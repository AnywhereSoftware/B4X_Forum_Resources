B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.8
@EndOfDesignText@
Sub Class_Globals
		
	''Made by TDCBYTE 2020
	''
	
	''Constants for access
	Private const  fctReadCoil As Byte  = 1
	Private const  fctReadDiscreteInputs As Byte= 2
	Private const  fctReadHoldingRegister As Byte = 3
	Private const  fctReadInputRegister As Byte = 4
	Private const  fctWriteSingleCoil As Byte = 5
	Private const  fctWriteSingleRegister As Byte = 6
	Private const  fctWriteMultipleCoils As Byte = 15
	Private const  fctWriteMultipleRegister As Byte = 16
	Private const  fctReadWriteMultipleRegister As Byte = 23 'not supported in this class
	
	
	'''''--------------------------------------------------------------.
	'''The constant exceptions here below are exceptions used in the master, or send by the slave via the echo of the function code
	'Constant for exception illegal function.
	Public const excIllegalFunction As Short = 1
	'Constant for exception illegal data address.
	Public const excIllegalDataAdr As Short = 2
	'Constant for exception illegal data value.
	Public const excIllegalDataVal As Short = 3
	'Constant for exception slave device failure.
	Public const excSlaveDeviceFailure As Short = 4
	'Constant for exception acknowledge. This is triggered if a write request is executed while the watchdog has expired.
	Public const excAck As Short = 5
	'Constant for exception slave is busy/booting up.
	Public const excSlaveIsBusy As Short = 6
	'Constant for exception Negative acknowledge
	Public const excNegAck As Short = 7
	'Constant for exception Memory parity error
	Public const excMemoryParityErr As Short = 8
	'Constant for exception gate path unavailable.
	Public const excGatePathUnavailable As Short = 10
	'Constant for exception target fails to respond
	Public const excGateRepsonseFailure As Short = 11
	'Constant for exception Extended excpetion response, the PDU contains extended exception information
	Public const excExtendExceptResponse As Short = 255
	
	'''''-------------------------------------------------------------------
	'''The constants here below are excepions inside this master itself
	'Constant for exception not connected.
	Public const excExceptionNotConnected As Short = 253
	'Constant for exception connection lost.
	Public const excExceptionConnectionLost As Short = 254
	'>Constant for exception response timeout.
	Public const excExceptionTimeout As Short = 252
	'Constant for exception wrong offset.
	Public const excExceptionOffset As Short = 128
	'Constant for exception send failt.
	Public const excSendFailt As Short = 100
	
	Public const excSocketError As Short = 200 'Created for exceptions from async connection
	

	
	
	''//Private declaration//
	Private PrivTimeout As Int = 800 '800ms timeout
	Private IsConnected As Boolean = False
	Private Socket1 As Socket
	Private Astream As AsyncStreams
	
	Public PrivIPaddress As String
	Public PrivTCPport As Int
	
	
	Private WatchdogTimer As Timer 'watchdogtimer for TCP connection
	Private ResponseTimeoutTimer As Timer 'Timer to generate pulses for monitoring all the messages to track if there is a replay on each transaction id.
	Private MapTransactionID_timeout_as_ms As B4XOrderedMap  'Map, where the transaction ID is unique, and the timeout as milisecond value
	
	'Callback for asynchrnous response
	Private mCallback As Object
	Private mEventName As String
	Private mEventName_Exception As String
	
	
	
	'Special Types
	'Type for exception -> see main
	Type MB_exceptionType (TransactionID As Short,unit As Short, function As Short , exception As Short)
	Type MB_MBAP_HeaderData (TransactionID As Short, MessageLength As Short,unit As Short)
	Type MB_ResponseDataValues (Registers() As Short, CoilsOrDitialInputs() As Byte)
	

End Sub


'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize (Callback As Object, EventName_MBresponse As String, EventName_MBexception As String)
	
	'Initilize the objects that are passed at initialization for sending the result to the Main
	mCallback = Callback
	mEventName = EventName_MBresponse
	mEventName_Exception = EventName_MBexception
	
	'Watchdogtimer, will trigger re-connection when tcp connection is lost.
	'Is is different then the response-timeout.(there the TCP connection is alive, but the server doesn't reply)
	'This timer is used to re-initiate a new connection to the server socket.
	WatchdogTimer.Initialize("WatchdogTimer",10000) '10 seconds delay

	'Initialize the map with that tracks the timeouts
	MapTransactionID_timeout_as_ms.Initialize
	
	'Response timeout timer.
	ResponseTimeoutTimer.Initialize("ResponseTimeoutTimer",100) 'every 100ms
	ResponseTimeoutTimer.Enabled = True

	
	
End Sub


#region get and set internal properties
'Get and set internal properties
Public Sub SetResponseTimeout_ms (t As Int)
	If t <= 0 Then
		Log("invalid timeout")
		Return
	End If
	PrivTimeout  = t
	
End Sub

Public Sub GetResponseTimeouts_ms As Int
	Return PrivTimeout
End Sub

Public Sub GetConnectionStatus As Boolean
	Return IsConnected
	
End Sub

#End Region


Private Sub WatchdogTimer_Tick
	
	If IsConnected = False Then
		Log("TCP connection dead, trying to reconnect")
		PrivConnectToServer
			
	End If
	
End Sub


#Region ResponseTimeoutTrackingForEachTransactionID
'Here we will keep track of when the transaction ID has been send.
'At each command , under region "modbusrequests", we call trackTimeout, where we add the transaction ID to a map.
'The default timeout is also saved in the map. 
'Every 100ms, we will lower this value, and when the value is too low, an exception is thrown.
'When we receive an answer from the slave, even if an exception of the slave itself has been send, we will remove the transactionID from the
'list, so no timeout will be triggered.

Private Sub ResponseTimeoutTimer_Tick
	'every 100ms this routine will be activated
	
	'Temp value for iteration
	Dim TimeOfTransactionID As Int
	
	'List to keep track of items to be removed
	Dim KeysToBeRemoved As List
	KeysToBeRemoved.Initialize
	KeysToBeRemoved.Clear
	
	'First part, we will go thru the current list and lower the values (timer countdown)
	'Also, if there is an entry that has timed out, we put that one in a separate list
	For Each Key As Short In MapTransactionID_timeout_as_ms.keys
		
		TimeOfTransactionID = 	MapTransactionID_timeout_as_ms.Get(Key)
		
		MapTransactionID_timeout_as_ms.Put(Key,TimeOfTransactionID - 100) '100ms less
	
		If TimeOfTransactionID <= 0 Then
			'Time elapsed! Exception must be thrown!
			'Here we will make a list of values to be deleted and an exception must be thrown.
			'We cannot delete those records here, as we arecurrently going thru the map
			KeysToBeRemoved.Add(Key)
					
		End If
			
	Next
		
	'Here is part two, if there are keys in the list "KeyToBeRemoved", then those keys will be removed and an exception timeout will be thrown.
	'For Id's that are removed, because the server answered (no exception), look in the sub "ResponseHandling".
	For Each Key As Short In KeysToBeRemoved
		CallException(Key,0xFF,0xFF,excExceptionTimeout)
		If MapTransactionID_timeout_as_ms.ContainsKey(Key) Then
			MapTransactionID_timeout_as_ms.Remove(Key)
		End If
		
	Next

	
End Sub

Private Sub TrackTimeout (transactionID As Short)
	
	'Add a new key, with default timeout value
	MapTransactionID_timeout_as_ms.Put(transactionID,PrivTimeout)
		
End Sub
#End Region

#region ModbusRequests
''------------------------------------------------------------------------------------
''Read holding registers
''Transaction id = Unique id that marks the transaction
''Unit = unit identifier (aka slave address)
''StartAddress = Adderss from where the data read begins
''NumInputs = Length of the data
''
public Sub ReadHoldingRegisters (transactionID As Short,unit As Short, startAddress As Short, numInputs As Short) As Boolean
	
	''error when request is send
	If numInputs > 125 Then
		CallException(transactionID,unit,fctReadHoldingRegister,excIllegalDataVal)
		Return False
	End If
	
	''request is oke
	
	Try
		
		If IsConnected = True Then
			'Send message to the network
			Astream.Write(CreateReadHeader(transactionID,unit,startAddress,numInputs,fctReadHoldingRegister))
			
			'To track the send messages en their timeout
			TrackTimeout(transactionID)
			Return True
		Else
			CallException(transactionID,unit,fctReadHoldingRegister,excExceptionNotConnected)
			Return False
		End If
	
	Catch
		Log(LastException)
	End Try
	
End Sub



Public Sub ReadInputRegisters (transactionID As Short,unit As Short, startAddress As Short, numInputs As Short) As Boolean
	''error when request is send
	If numInputs > 125 Then
		CallException(transactionID,unit,fctReadInputRegister,excIllegalDataVal)
		Return False
	End If
	
	Try
		
		If IsConnected = True Then
			'Send message to the network
			Astream.Write(CreateReadHeader(transactionID,unit,startAddress,numInputs,fctReadInputRegister))
			
			'To track the send messages en their timeout
			TrackTimeout(transactionID)
			Return True
		Else
			CallException(transactionID,unit,fctReadInputRegister,excExceptionNotConnected)
			Return False
		End If
	
	Catch
		Log(LastException)
	End Try
	
	
	
End Sub

Public Sub ReadCoils (transactionID As Short,unit As Short, startAddress As Short, numInputs As Short) As Boolean
	''error when request is send
	If numInputs > 2000 Then
		CallException(transactionID,unit,fctReadCoil,excIllegalDataVal)
		Return False
	End If
	
	Try
		If IsConnected = True Then
			'Send message to the network
			Astream.Write(CreateReadHeader(transactionID,unit,startAddress,numInputs,fctReadCoil))
				
			'To track the send messages en their timeout
			TrackTimeout(transactionID)
			Return True
		Else
			CallException(transactionID,unit,fctReadCoil,excExceptionNotConnected)
			Return False
		End If
		
	Catch
		Log(LastException)
	End Try
	
End Sub

Public Sub ReadDiscreteInputs (transactionID As Short,unit As Short, startAddress As Short, numInputs As Short) As Boolean
	''error when request is send
	If numInputs > 2000 Then
		CallException(transactionID,unit,fctReadDiscreteInputs,excIllegalDataVal)
		Return False
	End If
	
	Try
		If IsConnected = True Then
			'Send message to the network
			Astream.Write(CreateReadHeader(transactionID,unit,startAddress,numInputs,fctReadDiscreteInputs))
				
			'To track the send messages en their timeout
			TrackTimeout(transactionID)
			Return True
		Else
			CallException(transactionID,unit,fctReadDiscreteInputs,excExceptionNotConnected)
			Return False
		End If
		
	Catch
		Log(LastException)
	End Try
	
End Sub



''------------------------------------------------------------------------------------
''Write holding registers
''Transaction id = Unique id that marks the transaction
''Unit = unit identifier (aka slave address)
''StartAddress = Address from where the data read begins
''Values = Array of shorts that contains the data
''
public Sub WriteMultipleRegsiters (transactionID As Short,unit As Short, startAddress As Short, Values() As Short) As Boolean
	
	Dim HeaderData() As Byte
	Dim ValuesAsBytes() As Byte
	Dim NumberOfDataBytes As Short
	
	Dim bb As B4XBytesBuilder
	Dim bc As ByteConverter
	bc.LittleEndian = False 'Special configuration! here we need to swap the values, normally we use LittleEndian.
	
	bb.Initialize
	bb.Clear
	
	NumberOfDataBytes = (Values.Length)*2
	
	'Max 125 holding registers -> 250 bytes /2=125 shorts
	If NumberOfDataBytes > 250 Then
		
		CallException(transactionID,unit,fctWriteMultipleRegister,excIllegalDataVal)
		Return False
	End If
	''request is good
	Try
		
		If IsConnected = True Then
				
			'Create Headerdata, prepair it as a byte array
			'numData is linked to the number of data elements, for holding registers # bytes /2
			'For Coils is this 1byte = 8 coils
			'Offset of DataBytes = 3 -> Register count (2bytes) and byte count (1byte), other standard bytes are added in the CreateWriteHeader sub
			HeaderData = CreateWriteHeader(transactionID,unit,startAddress,(NumberOfDataBytes/2),NumberOfDataBytes+3,fctWriteMultipleRegister)
			
			'Convert the given short values to a byte array
			ValuesAsBytes = bc.ShortsToBytes(Values)
			
			'Merge the two byte array's together
			bb.Append(HeaderData)
			bb.Append(ValuesAsBytes)
			
			'Send the merged byte-array
			Astream.Write(bb.ToArray)
			
			'To track the send messages en their timeout
			TrackTimeout(transactionID)
	
			Return True
		Else
			CallException(transactionID,unit,fctWriteMultipleRegister,excExceptionNotConnected)
		End If

		
	Catch
		Log(LastException)
	End Try

End Sub

''------------------------------------------------------------------------------------
''Write single holding register
''Transaction id = Unique id that marks the transaction
''Unit = unit identifier (aka slave address)
''StartAddress = Address from where the data read begins
''Values = Array of shorts that contains the data
''
public Sub WriteSingleRegister (transactionID As Short,unit As Short, startAddress As Short, Value As Short) As Boolean
	
	Dim HeaderData() As Byte
	Dim ValuesAsBytes() As Byte
	Dim NumberOfBytes As Short
	Dim ValueAsArray(1) As Short
	
	Dim bb As B4XBytesBuilder
	Dim bc As ByteConverter
	bc.LittleEndian = False 'Special configuration! here we need to swap the values, normally we use LittleEndian.
	
	bb.Initialize
	bb.Clear
	
	NumberOfBytes = 2 'fixed in this case
	
	ValueAsArray(0) = Value
	
	Try
		If IsConnected = True Then
					
			'Create Headerdata, prepair it as a byte array
			'numData is linked to the number of data elements, for holding registers # bytes /2
			'For Coils is this 1byte = 8 coils
			HeaderData = CreateWriteHeader(transactionID,unit,startAddress,(NumberOfBytes/2),NumberOfBytes,fctWriteSingleRegister)
			
			'Convert the given short values to a byte array
			ValuesAsBytes = bc.ShortsToBytes(ValueAsArray)
			
			'Merge the two byte array's together
			bb.Append(HeaderData)
			bb.Append(ValuesAsBytes)
			
			'Send the merged byte-array
			Astream.Write(bb.ToArray)
			
			'To track the send messages en their timeout
			TrackTimeout(transactionID)
	
			Return True
		Else
			CallException(transactionID,unit,fctWriteSingleRegister,excExceptionNotConnected)
		End If

		
	Catch
		Log(LastException)
	End Try

End Sub

''------------------------------------------------------------------------------------
''Write single Coil
''Transaction id = Unique id that marks the transaction
''Unit = unit identifier (aka slave address)
''StartAddress = Address from where the data read begins
''Values = Array of shorts that contains the data
''
public Sub WriteSingleCoil (transactionID As Short,unit As Short, startAddress As Short, Value As Boolean) As Boolean
	
	Dim HeaderData() As Byte
	Dim ValuesAsBytes() As Byte
	Dim NumberOfBytes As Short
	Dim ValueAsArray(1) As Short
	
	Dim bb As B4XBytesBuilder
	Dim bc As ByteConverter
	bc.LittleEndian = False 'Special configuration! here we need to swap the values, normally we use LittleEndian.
	
	bb.Initialize
	bb.Clear
	
	NumberOfBytes = 2 'fixed in this case
	
	If Value = True Then
		
		ValueAsArray(0) = 0xFF00 'Coil is high
	Else
		ValueAsArray(0) = 0x0000 'Coil is low
		
	End If
	
	
	Try
		If IsConnected = True Then
					
			'Create Headerdata, prepair it as a byte array
			'numData is linked to the number of data elements, for holding registers # bytes /2
			'For Coils is this 1byte = 8 coils
			HeaderData = CreateWriteHeader(transactionID,unit,startAddress,(NumberOfBytes/2),NumberOfBytes,fctWriteSingleCoil)
			
			'Convert the given short values to a byte array
			ValuesAsBytes = bc.ShortsToBytes(ValueAsArray)
			
			'Merge the two byte array's together
			bb.Append(HeaderData)
			bb.Append(ValuesAsBytes)
			
			'Send the merged byte-array
			Astream.Write(bb.ToArray)
			
			'To track the send messages en their timeout
			TrackTimeout(transactionID)
	
			Return True
		Else
			CallException(transactionID,unit,fctWriteSingleCoil,excExceptionNotConnected)
		End If

		
	Catch
		Log(LastException)
	End Try

End Sub


''------------------------------------------------------------------------------------
''Write multiple coils
''Transaction id = Unique id that marks the transaction
''Unit = unit identifier (aka slave address)
''StartAddress = Address from where the data read begins
''Values = Array of shorts that contains the data
''
public Sub WriteMultipleCoils (transactionID As Short,unit As Short, startAddress As Short, Values() As Byte) As Boolean
	
	Dim HeaderData() As Byte
	Dim ValuesAsBytes() As Byte
	Dim NumberOfDataBytes As Short
	
	Dim bb As B4XBytesBuilder
	Dim bc As ByteConverter
	bc.LittleEndian = False 'Special configuration! here we need to swap the values, normally we use LittleEndian.
	
	bb.Initialize
	bb.Clear
	
	NumberOfDataBytes = Values.Length
	
	'Max 1968 coils -> 246 bytes
	If NumberOfDataBytes > 246 Then
		
		CallException(transactionID,unit,fctWriteMultipleCoils,excIllegalDataVal)
		Return False
	End If
	''request is good
	Try
		
		If IsConnected = True Then
				
			'Create Headerdata, prepair it as a byte array
			'numData is linked to the number of data elements, for holding registers # bytes /2
			'For Coils is this 1 byte = 8 coils
			'Offset of DataBytes = 3 -> Register count (2bytes) and byte count (1byte), other standard bytes are added in the CreateWriteHeader sub
			'NumData is the amount of values been written, with coils the amount of bits. Here we will write in blocks of 8 bits
			HeaderData = CreateWriteHeader(transactionID,unit,startAddress,(NumberOfDataBytes*8),NumberOfDataBytes+3,fctWriteMultipleCoils)
			
			'Convert the given byte values to a byte array
			ValuesAsBytes = Values
			
			'Merge the two byte array's together
			bb.Append(HeaderData)
			bb.Append(ValuesAsBytes)
			
			'Send the merged byte-array
			Astream.Write(bb.ToArray)
			
			'To track the send messages en their timeout
			TrackTimeout(transactionID)
	
			Return True
		Else
			CallException(transactionID,unit,fctWriteMultipleCoils,excExceptionNotConnected)
		End If
	


		
	Catch
		Log(LastException)
	End Try

End Sub

#End Region



private Sub CallException (transactionID As Short,unit As Short, function As Short , exception As Short)
	
	Dim mException As MB_exceptionType
	'fill the exception object
	mException.transactionID = transactionID
	mException.unit = unit
	mException.function = function
	mException.exception = exception
	
	CallSub2(mCallback,mEventName_Exception,mException)
	
End Sub

#region HeaderPreparations

Private Sub CreateReadHeader (transactionID As Short, unit As Short,  startAddress As Short, numInputs As Short, function As Short) As Byte ()
	
	Dim TxData (12) As Byte
	
	'Transaction identifier
	TxData(0) = ShortToByte(transactionID)(1)
	TxData(1) = ShortToByte(transactionID)(0)
	'Protocol identifier, always 0 when using modbus TCp
	TxData(2) = 0
	TxData(3) = 0
	'Message size, when sending a request, always 6 byte after this
	TxData(4) = 0
	TxData(5) = 6
	'UID or slave address
	TxData(6) = unit
	'Fuction code
	TxData(7) = function
	'Start address MSB
	TxData(8) = ShortToByte(startAddress)(1)
	'Start address LSB
	TxData(9) = ShortToByte(startAddress)(0)
	'Number of datapoints to be read MSB
	TxData(10) = ShortToByte(numInputs)(1)
	'Number of datapoints to be read LSB
	TxData(11) = ShortToByte(numInputs)(0)
	
	Return TxData
	
End Sub

Private Sub CreateWriteHeader (transactionID As Short,unit As Short,startAddress As Short,numData As Short,numBytes As Short, function As Short) As Byte()
	
	'numData only used for Coils
	Dim MessageSize As Short
	Dim bb As B4XBytesBuilder
	bb.Initialize
	bb.Clear
	
	Dim TxData (10) As Byte
	Dim NoElements(3) As Byte
	
	MessageSize = numBytes + 4 'Offset 4 = 1 byte, slave id, 1 byte function code, 2 byte first register address
	
	'Transaction identifier
	TxData(0) = ShortToByte(transactionID)(1)
	TxData(1) = ShortToByte(transactionID)(0)
	'Protocol identifier, always 0 when using modbus TCp
	TxData(2) = 0
	TxData(3) = 0
	'Message size, when sending a request, always 6 byte after this
	TxData(4) = ShortToByte(MessageSize)(1)
	TxData(5) =  ShortToByte(MessageSize)(0)
	'UID or slave address
	TxData(6) = unit
	'Fuction code - from here the PDU starts
	TxData(7) = ShortToByte(function)(0)
	'Start address
	TxData(8) =ShortToByte(startAddress)(1)
	TxData(9) =ShortToByte(startAddress)(0)
	
	bb.Append(TxData)
	
	If function >= fctWriteMultipleCoils Then
		'Register count
		NoElements(0) = ShortToByte(numData)(1)
		NoElements(1) = ShortToByte(numData)(0)
		
		'byte count
		NoElements(2) =ShortToByte(numBytes-3)(0)
				
		bb.Append(NoElements)
		
	End If
		
	Return bb.ToArray
	
End Sub


#End Region

#region ResponseHandling
Private Sub ResponseHandling (RxBuffer () As Byte)
	
	'Do first MBAP reading, this is for each modbus frame the same
	
	Dim MBAP As MB_MBAP_HeaderData
	Dim transactionID(2) As Byte
	Dim MessageLength(2) As Byte
	Dim MessageLength(2) As Byte
	Dim Unit As Short
	Dim FunctionCode As Short
	Dim FunctionCodeException As Short
	
	Dim ResponseHeaderLength As Short
	Dim ByteOrShortArray As Byte ' 0 = byte, 1 = short
	
	Dim ByteCount As Int
	Dim FirstCoilOrRegisterAddress(2) As Byte
	Dim RegisterCount(2) As Byte
	Dim CoilOrRegisterValue(2) As Byte
	
	Dim Response As MB_ResponseDataValues
	
	'https://www.b4x.com/android/forum/threads/b4x-bytesbuilder-simplifies-working-with-arrays-of-bytes.89008/#content
	Dim bb As B4XBytesBuilder
	Dim TempSubArray() As Byte
	bb.Initialize
	bb.Clear
	
	transactionID(1) = RxBuffer(0)
	transactionID(0) = RxBuffer(1)
	'RxBuffer 2 and 3 is the protocol identifier, that is always zero
	MessageLength(1) =  RxBuffer(4)
	MessageLength(0) =  RxBuffer(5)
	Unit = SingleByteToShort(RxBuffer(6))
	FunctionCode = SingleByteToShort(RxBuffer(7))
	

	MBAP.transactionID   = ByteArrayToShort(transactionID)
	MBAP.MessageLength  = ByteArrayToShort(MessageLength)
	MBAP.unit = Unit
	
	
	'If we received the correct transaction ID, remove then that ID from the timeoutlist, so no timeout will occur
	If MapTransactionID_timeout_as_ms.ContainsKey(MBAP.transactionID) Then
		MapTransactionID_timeout_as_ms.Remove(MBAP.transactionID)
	End If
	
	
	'When the msb of the function code is high, the an exceptionflag is saying there is an error
	If FunctionCode >= 128 Then
		'Bit.And(FunctionCode, 127)
		FunctionCodeException =  SingleByteToShort(RxBuffer(8)) 'the error code is given in the first data block of the array
			
		CallException(MBAP.transactionID,MBAP.unit,Bit.And(FunctionCode, 127),FunctionCodeException)
		'exit response reading function
		Return
		
	End If
	
	'Here we will filter the answer accroding to the type of functioncode that has been returned
	'The error state of the function code is already filtered by the code here above
	Select	FunctionCode
		Case fctReadCoil,fctReadDiscreteInputs
			ByteCount = SingleByteToShort(RxBuffer(8))
			ResponseHeaderLength = 9
			
			ByteOrShortArray = 0 'byteStorage
			
		Case fctReadHoldingRegister,fctReadInputRegister
			'In case of reading holding registers,
			ByteCount = SingleByteToShort(RxBuffer(8)) 'ByteCount = number of bytes that are requested, different then the MessageLength!!
			'For Reading holding registers, the first 10 bytes are non-data bytes, so set the offset zerobased to 9
			ResponseHeaderLength = 9
			
			ByteOrShortArray = 1 'short Storage
			
		Case fctWriteSingleCoil
			FirstCoilOrRegisterAddress(1) = RxBuffer(8)
			FirstCoilOrRegisterAddress(0) =RxBuffer(9)
			CoilOrRegisterValue(1) = RxBuffer(10)
			CoilOrRegisterValue(0) = RxBuffer(11)
			ResponseHeaderLength = 12
			
			ByteOrShortArray = 0 'byte Storage
			
		Case fctWriteSingleRegister
			FirstCoilOrRegisterAddress(1) = RxBuffer(8)
			FirstCoilOrRegisterAddress(0) =RxBuffer(9)
			CoilOrRegisterValue(1) = RxBuffer(10)
			CoilOrRegisterValue(0) = RxBuffer(11)
			ResponseHeaderLength = 12
			
			ByteOrShortArray = 1 'short Storage
			
		Case fctWriteMultipleCoils
			FirstCoilOrRegisterAddress(1) = RxBuffer(8)
			FirstCoilOrRegisterAddress(0) = RxBuffer(9)
			RegisterCount(1) = RxBuffer(10)
			RegisterCount(0) = RxBuffer(11)
			ResponseHeaderLength = 12
			
			ByteOrShortArray = 0 'byte Storage
			
		Case fctWriteMultipleRegister
			
			FirstCoilOrRegisterAddress(1) = RxBuffer(8)
			FirstCoilOrRegisterAddress(0) = RxBuffer(9)
			RegisterCount(1) = RxBuffer(10)
			RegisterCount(0) = RxBuffer(11)
			ResponseHeaderLength = 12
			
			ByteOrShortArray = 1 'short Storage
			
		Case Else
			
			ResponseHeaderLength = 9
	End Select
	
	
	'Load the whole Rxbuffer to the bytesbuilder
	bb.Append(RxBuffer)
	
	'Remove first bytes, we need only requested data, not the header data
	TempSubArray = bb.SubArray(ResponseHeaderLength)
	
	If ByteOrShortArray = 0 Then
		'Pass byte array direcly
		Response.CoilsOrDitialInputs = TempSubArray
		
	Else
		'convert byte array to array of shorts
		Dim bc As ByteConverter
		bc.LittleEndian = False 'Special configuration! here we need to swap the values, normally we use LittleEndian.
		Response.Registers = bc.ShortsFromBytes(TempSubArray)
	
	End If
	
	'Send data to main program
	CallSub3(mCallback,mEventName,MBAP,Response)
	

End Sub

#End region


#region NetworkHandling

'----------------------Here networking stuff -----------------------------------


Private Sub SetState (Connected As Boolean)
	IsConnected = Connected
	'tmr.Enabled = Connected
	
	If IsConnected Then
		Log("Connected")
		
	Else
		Log("Disconnected")
	End If
End Sub


private Sub PrivConnectToServer
	
	If Astream.IsInitialized Then
		Astream.Close
	End If
	If Socket1.IsInitialized Then
		Socket1.Close
	End If
	
	Try
				
		Socket1.Initialize("Socket")
		Socket1.Connect(PrivIPaddress,PrivTCPport,100)
		Wait For Socket_connected (Succesful As Boolean)
		If Succesful Then
		
			Astream.Initialize(Socket1.InputStream,Socket1.OutputStream,"astream")
			SetState(True)
		
		End If
	
	Catch
		Log(LastException)
	End Try
	
End Sub

private Sub PrivDisconnectServer
	Astream.Close
	Socket1.Close
	
End Sub

public Sub ConnectServer (IPaddress As String, TCPport As Int)
	
	If IsValidIPv4Address(IPaddress) Then
		PrivIPaddress = IPaddress
		
	Else
		Log("Error, bad ip address at initialization")
		Return
	End If

	If TCPport > 0 Then
		PrivTCPport = TCPport
	Else
		Log("Error, bad port number used")
		Return
	End If
	
	
	WatchdogTimer.Enabled = True
	PrivConnectToServer
	
End Sub

public Sub DisconnectServer
	WatchdogTimer.Enabled = False
	
	'Disconnect from server
	PrivDisconnectServer
	
End Sub


Private Sub Astream_NewData (buffer() As Byte)
	'New data has arrived.
	ResponseHandling(buffer)
		
End Sub

Private Sub Astream_Terminated
	
	SetState(False)
	
End Sub

Private Sub Astream_Error
	
	CallException(0xFF,0xFF,0xFF,excSocketError)
	Astream_Terminated
End Sub

Public Sub IsValidIPv4Address(IPAddress As String) As Boolean
	Return Regex.IsMatch("^(([01]?\d\d?|2[0-4]\d|25[0-5])\.){3}([01]?\d\d?|2[0-4]\d|25[0-5])$", IPAddress)
End Sub

#End Region

#region conversions
private Sub ByteArrayToShort(ByteArray() As Byte) As Short
	
	Dim bc As ByteConverter
	bc.LittleEndian = True
	Dim i As Short = bc.shortsFromBytes(ByteArray)(0)
		
	Return  i
	
End Sub

'In B4X , bytes are always signed, if unsigned needed -> use integer or short
private Sub SingleByteToShort(b As Byte) As Short
	Return Bit.And(0xFF, b)
End Sub

private Sub ShortToByte(ShortValue As Short) As Byte()
	
	Dim bc As ByteConverter
	bc.LittleEndian = True
	Dim b() As Byte = bc.ShortsToBytes(Array As Short(ShortValue))
		
	Return b
	
End Sub


Public Sub ToBinaryString(number As Byte) As String
	Dim sb As StringBuilder
	sb.Initialize
	Dim x As Int = Bit.ShiftLeft(1, 7)
	For i = 0 To 7
		Dim ii As Int = Bit.And(number, x)
		If ii <> 0 Then
			sb.Append("1")
		Else
			sb.Append("0")
		End If
		x = Bit.UnsignedShiftRight(x, 1)
	Next
	Return sb.ToString
	
	
End Sub

#End Region

