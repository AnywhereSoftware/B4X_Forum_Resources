B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module
#IgnoreWarnings: 12
Sub Class_Globals
	Private mCableNo As Int = 0
	Private mDriver As MidiDriver
	Private mMidiDeviceInfo As MidiDeviceInfo
	Private mIsReady As Boolean
	Private mTranspose As Int = 0
	Private WriteLock As Lock
	Private Running As Boolean
	Private mDelay As Long
	Private Interrupt As Boolean										'ignore
	Private TH As Thread												'ignore
	Private Queue As List
	Type MidiUSBWriteType(Time As Long,Message() As Byte)
	
End Sub

'Initialize a receiver, MDI is updated with the receiver that will be used for this device
Public Sub Initialize(MDI As MidiDeviceInfo)
	If MDI.DevType <> MidiDevice_Static.DEVICE_RECEIVER Then
		MidiLibUtils.ThrowException("Receiver: Cannot add a non receiver type: " & MDI.DevType)
	End If
		
	If MDI.Receiver.IsInitialized Then
		Return
	End If
	
	'Check if a Receiver is already assigned to this driver
	Dim R As MidiReceiver = MidiDevice_Static.GetDriverReceiver(MDI)
	If R.IsInitialized Then
		MDI.Receiver = R
		'Record that this Device is using the receiver
		MidiDevice_Static.AddDriverReceiver(MDI)
		Return
	End If

	'Finish initializing this receiver
	mMidiDeviceInfo = MDI
	WriteLock.Initialize(False)

	Select MDI.Driver
		Case MidiDevice_Static.DRIVER_USB
			mIsReady = True
			TH.Initialise("TH")
			TH.Start(Me,"USBThread",Null)
	
		Case MidiDevice_Static.DRIVER_SYSINTERNAL
			mDriver.Initialize(Me)
			mDriver.Start
			Midi_Ready
			
		Case MidiDevice_Static.DRIVER_INTERNAL
		Start
			
	End Select
	
	MDI.Receiver = Me
	'Record that this Device is using the receiver
	MidiDevice_Static.AddDriverReceiver(MDI)
	Queue.Initialize
End Sub

Private Sub Start_Default
	mDriver.Start
End Sub

Private Sub Midi_Ready
	mIsReady = True
	Running = True
End Sub

Public Sub IsDefaultDriver As Boolean
	Return mMidiDeviceInfo.DRIVER = MidiDevice_Static.DRIVER_SYSINTERNAL
End Sub

Public Sub GetDefaultDriver As MidiDriver
	Return mDriver
End Sub

'@SLHide
Sub Start
	If mMidiDeviceInfo.DRIVER = MidiDevice_Static.DRIVER_SYSINTERNAL Then
		mDriver.Start
	End If
	If mMidiDeviceInfo.DRIVER = MidiDevice_Static.DRIVER_INTERNAL And SubExists(mMidiDeviceInfo.Module,"Start") Then
		CallSub(mMidiDeviceInfo.Module,"Start")
		Running = True
	End If
End Sub
'@SLHide
Sub Stop
	If Running Then
		If mMidiDeviceInfo.DRIVER = MidiDevice_Static.DRIVER_SYSINTERNAL Then
			mDriver.Stop
		End If
		If mMidiDeviceInfo.DRIVER = MidiDevice_Static.DRIVER_INTERNAL And SubExists(mMidiDeviceInfo.Module,"Stop") Then
			CallSub(mMidiDeviceInfo.Module,"Stop")
		End If
		Running = False
	End If
End Sub
'Send a midi message to this Receiver
Sub Send(Message() As Byte)

	Dim Status As Int = Bit.And(Message(0),0xFF)
	Dim s As Int = Bit.And(Status,0xF0)
	
	If mTranspose <> 0 And Bit.And(Status,0xF) <> 9 And (s = 0x80 Or s = 0x90 Or s = 0xA0) Then
		Message(1) = Message(1) + mTranspose
	End If
	
	Select mMidiDeviceInfo.DRIVER
		
		Case MidiDevice_Static.DRIVER_USB
			Dim MU As MidiUSBWriteType
			MU.Initialize
			MU.Time = DateTime.Now
			MU.Message = Message
			
			WriteLock.Wait
				Queue.Add(MU)
			WriteLock.Unlock
			
		Case MidiDevice_Static.DRIVER_SYSINTERNAL
			SysInternalSendMessage(Message)
				
		Case MidiDevice_Static.DRIVER_INTERNAL
			ModuleInternalSendMessage(Message)
			
	End Select
End Sub
Private Sub USBThread
	Do While True
	
		Dim Message() As Byte
		Dim Time As Long

	
		Do While Queue.Size > 0
			
			Dim MU As MidiUSBWriteType = Queue.Get(0)
			Time = MU.Time
			Message = MU.Message
			
			'Do Delay
			Do While DateTime.now < Time + mDelay
			Loop
			
			WriteLock.Wait
				Queue.RemoveAt(0)
			WriteLock.Unlock
			
			Dim Status As Int = Bit.And(Message(0),0xFF)
			Dim s As Int = Bit.And(Status,0xF0)
		
				'Check message type
				If s = 0x80 Or s = 0x90 Or s = 0xA0 Or s = 0xB0 Or s = 0xC0 Or s = 0xD0 Or s = 0xE0 Then
					'ShortMessage
					USBSendMessage(Message)
				Else
					If Status = 0XF0 Or Status = 0xF7 Then
						'Controller Message
						USBSendControllerMessage(Message)
					Else
						If Status = 0XFF Then
							'Sysex
							USBSendSysex(Message)
						End If
					End If
				End If
			If Interrupt Then Exit
		Loop
		If Interrupt Then Exit
	Loop
End Sub
'@SLHide
Sub SendShortMessage(Message() As Byte)
	Select mMidiDeviceInfo.DRIVER
		
		Case MidiDevice_Static.DRIVER_USB
			USBSendMessage(Message)
		
		Case MidiDevice_Static.DRIVER_SYSINTERNAL
			SysInternalSendMessage(Message)
			
		Case MidiDevice_Static.DRIVER_INTERNAL
			ModuleInternalSendMessage(Message)
		
	End Select
End Sub
'@SLHide
Sub SendSysex(Message() As Byte)
	Select mMidiDeviceInfo.DRIVER
		
		Case MidiDevice_Static.DRIVER_USB
		USBSendSysex(Message)
		
		Case MidiDevice_Static.DRIVER_SYSINTERNAL
			SysInternalSendMessage(Message)
			
		Case MidiDevice_Static.DRIVER_INTERNAL
			ModuleInternalSendMessage(Message)
		
	End Select
End Sub
'Send a real time message to this receiver
Sub SendRealTimeMessage(Message() As Byte)
	Select mMidiDeviceInfo.DRIVER
		
		Case MidiDevice_Static.DRIVER_USB
			USBSendControllerMessage(Message)
			
		Case MidiDevice_Static.DRIVER_SYSINTERNAL
			SysInternalSendMessage(Message)
			
		Case MidiDevice_Static.DRIVER_INTERNAL
			ModuleInternalSendMessage(Message)
		
	End Select
End Sub
Private Sub SysInternalSendMessage(Message() As Byte)
	WriteLock.Wait
	Try
		mDriver.SendMidi(Message)
	Catch
		'LogColor("Receiver: Error caught in MidiSend Message: " & BC.StringFromBytes(Message,MidiSequence_Static.GetCharSet),Colors.Red)
		LogColor("Receiver: Error caught in SysInternalSendMessage: " & MidiLibUtils.StringFromBytes(Message,"UTF-8"),Colors.Red)
	End Try
	WriteLock.Unlock
End Sub
Private Sub ModuleInternalSendMessage(Message() As Byte)
	WriteLock.Wait
	Try
		CallSub2(mMidiDeviceInfo.Module,"Send",Message)
	Catch
		LogColor("Receiver: Error caught in SysInternalSendMessage: " & LastException ,Colors.Red)
	End Try
	WriteLock.Unlock
End Sub
'Make sure longer messages are sent in 4 byte packets with correct packed headers
Private Sub USBSendSysex(SysexMsg() As Byte)
	WriteLock.Wait
	Dim i As Int
'	Dim SLB As SLByteArrayBuffer
'	SLB.Initialize(10)
	Do While i < SysexMsg.Length - 2
		Dim MidiMsg(4) As Byte = Array As Byte(0x04,0,0,0)	
		MidiMsg(1) = SysexMsg(i)
		MidiMsg(2) = SysexMsg(i+1)
		MidiMsg(3) = SysexMsg(i+2)
		i=i+3
		If i = SysexMsg.Length Then MidiMsg(0) = 0x07
		mMidiDeviceInfo.USBDeviceType.Connection.BulkTransfer(mMidiDeviceInfo.USBEndP,MidiMsg,MidiMsg.Length,50)
'		SLB.AppendByte(MidiMsg,0,MidiMsg.Length)
	Loop
	
	If i < SysexMsg.Length Then
		'Deal with what's left
		Select SysexMsg.Length - i
			Case 2
				Dim MidiMsg(4) As Byte = Array As Byte(0x06,0,0,0)	
				MidiMsg(1) = SysexMsg(i)
				MidiMsg(2) = SysexMsg(i+1)
			Case 1
				Dim MidiMsg(4) As Byte = Array As Byte(0x05,0,0,0)	
				MidiMsg(1) = SysexMsg(i)
		End Select
'		SLB.AppendByte(MidiMsg,0,MidiMsg.Length)
		mMidiDeviceInfo.USBDeviceType.Connection.BulkTransfer(mMidiDeviceInfo.USBEndP,MidiMsg,MidiMsg.Length,50)
	End If
	WriteLock.Unlock
'	MidiLibUtils.LogByteArray(SLB.ToByteArray)
End Sub
'Format the message for USB comms, all events in the message must be the same length and 3 bytes or less
Private Sub USBSendControllerMessage(Message() As Byte)
	WriteLock.Wait
	'Message length has been added as the last element in the array
	Dim MsgLen As Int = Message(Message.Length-1)
	For i = 0 To Message.Length - 2 Step MsgLen
		'USB communication requres 4 byte packets
		Dim MidiMsg(4) As Byte = Array As Byte(0,0,0,0)
		MidiMsg(0) = mCableNo * 128 + Bit.And(Bit.ShiftRight(Message(i),4),0XF)
		MidiMsg(1) = Message(i)
		Select MsgLen
			Case 2
				MidiMsg(2) = Message(i+1)
			Case 3
				MidiMsg(2) = Message(i+1)
				MidiMsg(3) = Message(i+2)
		End Select
		
		mMidiDeviceInfo.USBDeviceType.Connection.BulkTransfer(mMidiDeviceInfo.USBEndP,MidiMsg,MidiMsg.Length,50)
		
	Next
	WriteLock.Unlock
End Sub
'Send a standard midi message must be 3 bytes or less
Private Sub USBSendMessage(Message() As Byte)
	WriteLock.Wait
	'USB communication requres 4 byte packets
	Dim MidiMsg(4) As Byte = Array As Byte(0,0,0,0)
	MidiMsg(0) = mCableNo * 128 + Bit.And(Bit.ShiftRight(Message(0),4),0XF)
	For i = 0 To Message.Length - 1
		MidiMsg(i+1) = Message(i)
	Next
	'Try
		mMidiDeviceInfo.USBDeviceType.Connection.BulkTransfer(mMidiDeviceInfo.USBEndP,MidiMsg,MidiMsg.Length,50)
	'Catch
		'ToastMessageShow("Error Sending Midi to USB",False)
	'End Try
	WriteLock.Unlock
End Sub
'Get the device info for this Receiver
Sub getDeviceInfo As MidiDeviceInfo
	Return mMidiDeviceInfo
End Sub
'Get the current ready stat for this receiver
Sub getIsReady As Boolean
	Return mIsReady
End Sub
Sub getIsRunning As Boolean
	Return Running
End Sub
'Get / Set a friendly name for this receiver
Sub setFriendlyName(Name As String)
	mMidiDeviceInfo.FriendlyName = Name
End Sub
Sub getFriendlyName As String
	Return mMidiDeviceInfo.FriendlyName
End Sub
'Set the transposition in semitones for this receiver
Sub setTranspose(Transpose As Int)
	mTranspose = Transpose
End Sub
Sub setDelay(Delay As Long)
	mDelay = Delay
End Sub
Sub getDelay As Long
	Return mDelay
End Sub
Sub QueueClear
	WriteLock.Lock
	Queue.Clear
	WriteLock.Unlock
End Sub
Sub Close
	MidiDevice_Static.RemoveDriverReceiver(mMidiDeviceInfo,True)
End Sub