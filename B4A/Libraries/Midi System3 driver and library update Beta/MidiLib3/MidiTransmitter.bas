B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module
#IgnoreWarnings:12
Sub Class_Globals
'	Private mCableNo As Int = 0

	Private mMidiDeviceInfo As MidiDeviceInfo
	Private mIsReady As Boolean
	Private mIsRunning As Boolean
	Private mReceivers As List
	Private Interrupt As Boolean
	Private TH As Thread									'Ignore
	Private mInEndPoint As UsbEndpoint			'Ignore
	Private mMidiThru As Boolean = True
	Private mUSBChannel As Int = 0
End Sub

'Initializes the MidiTransmitter object. The MidiDeviceInfo Trnasmitter is updated with the Transmitter it will use
Public Sub Initialize(MDI As MidiDeviceInfo)
	
	mReceivers.Initialize
	
	If MDI.DevType <> MidiDevice_Static.DEVICE_TRANSMITTER Then
		MidiLibUtils.ThrowException("Transmitter: Cannot add a non transmitter type: " & MDI.DevType)
	End If
	If MDI.Transmitter.IsInitialized Then
		MidiDevice_Static.AddDriverTransmitter(MDI)
		Return
	End If
	'LogColor("mIsAvailable " & mIsAvailable,Colors.Green)
	mMidiDeviceInfo = MDI
	'LogColor("MDI " & (MDI = "usb"),Colors.Green)
	If MDI.Driver = MidiDevice_Static.DRIVER_USB Then
		mIsReady = True
		'Log("Starting USB")
		mInEndPoint =  MDI.USBEndP
		TH.Initialise("USBInThread")
	Else
		mIsReady = True
	End If
	MidiDevice_Static.AddDriverTransmitter(MDI)
	mMidiDeviceInfo.Transmitter = Me
End Sub
'Register a receiver on this transmitter
Sub RegisterReceiverDevice(MDI As MidiDeviceInfo)
	
	If MDI.Receiver.IsInitialized Then 
		'Only add it once
		If mReceivers.IndexOf(MDI) = -1 Then
			mReceivers.Add(MDI)
			MidiDevice_Static.AddDriverReceiver(MDI)
		End If
	Else
		MidiLibUtils.ThrowException("Transmitter: Attempt to Register a non initialized or Illegal Receiver: ")
	End If
End Sub
Sub RemoveReceiverDevice(MDI As MidiDeviceInfo)
	Dim Pos As Int = mReceivers.IndexOf(MDI)
	If Pos > -1 Then
		mReceivers.RemoveAt(Pos)
		MidiDevice_Static.RemoveDriverReceiver(MDI,False)
	End If
End Sub
'Get the ready state of the transmitter
Sub getIsReady As Boolean
	Return mIsReady
End Sub
'Get / Set a friendly name for this transmitter
Sub setFriendlyName(Name As String)
	mMidiDeviceInfo.FriendlyName = Name
End Sub
Sub getFriendlyName As String
	Return mMidiDeviceInfo.FriendlyName
End Sub
'Starts a thread on which to listen for incoming USB data, or calls start for used defined module
Sub Start
	Select mMidiDeviceInfo.Driver
		Case MidiDevice_Static.DRIVER_USB
			Interrupt = False
			If Not(mIsRunning) Then TH.Start(Me,"USBInThread",Null)
			
		Case MidiDevice_Static.DRIVER_INTERNAL
			If SubExists(mMidiDeviceInfo.Module,"Start") Then
				CallSub(mMidiDeviceInfo.Module,"Start")
			End If
			
	End Select
End Sub
'Stop the listening USB thread, or user defined module
Sub Stop
	Select mMidiDeviceInfo.Driver
	
		Case MidiDevice_Static.DRIVER_USB
			Interrupt = True
			
		Case MidiDevice_Static.DRIVER_INTERNAL
			If SubExists(mMidiDeviceInfo.Module,"Stop") Then
				CallSub(mMidiDeviceInfo.Module,"Stop")
			End If
			
	End Select
End Sub
'Send a midi message to a non USB device
Sub Send(MidiMsg() As Byte)
	If mMidiDeviceInfo.Driver = MidiDevice_Static.DRIVER_USB Then MidiLibUtils.ThrowException("Cannot send MidiData directly to a USB Device")
	If mMidiThru Then
		'Send to registered receivers so we can hear what's played
		For Each MDI As MidiDeviceInfo In mReceivers
			MDI.Receiver.Send(MidiMsg)
		Next
	End If
	'Send to the recording receiver
	Dim M As MidiMessage
	M.Initialize
	M.FASTShortMessage(MidiMsg)
	MidiSequencerReceiver_Static.Send(M,-1)
End Sub
Private Sub USBInThread
	Log("USB in Thread Started")
	mIsRunning = True
	Dim inBytes(mInEndPoint.MaxPacketSize) As Byte
	Dim MsgType As Int
	Dim i As Int
	Dim byteCount As Int
'	Log("USBInThread Running")
	'Parse the incoming data
	Do While True
		'Set timeout to 100ms to give a chance to test if thread should stop
		byteCount = mMidiDeviceInfo.USBDeviceType.Connection.BulkTransfer(mInEndPoint,inBytes,inBytes.Length,100)
		If byteCount > 0 Then
			i = 0
			Do While i < byteCount
				MsgType = Bit.AND(inBytes(i),0xF)
				Dim MidiMsg() As Byte
				Select MsgType
					Case 8,9,0xA,0xB,0xE
						Dim MidiMsg(3) As Byte
						MidiMsg(0) = Bit.AND(inBytes(i+1),0xF0) + mUSBChannel
						MidiMsg(1) = inBytes(i+2)
						MidiMsg(2) = inBytes(i+3)
						'MidiMsg(3) = inBytes(i+3)
						i=i+4
					Case 0xC,0xD
						Dim MidiMsg(2) As Byte
						MidiMsg(0) = Bit.AND(inBytes(i+1),0xF0) + mUSBChannel
						MidiMsg(1) = inBytes(i+2)
						'MidiMsg(2) = inBytes(i+2)
						i=i+3
					Case Else
						i=i+3
						
				End Select

				If MidiMsg.Length > 0 Then
					'Send to the recording receiver
					Dim M As MidiMessage
					M.Initialize
					M.FASTShortMessage(MidiMsg)
					MidiSequencerReceiver_Static.Send(M,-1)
					
					If mMidiThru Then
						'Send to registered receivers so we can hear what's played
						For Each MDI As MidiDeviceInfo In mReceivers
							MDI.Receiver.Send(MidiMsg)
						Next
					End If
					'TH.RunOnGuiThread("ShowMessage",Array As Object(MidiMsg))

				End If
				If Interrupt Then Exit
			Loop
			If Interrupt Then Exit
		End If
		If Interrupt Then Exit
	
	Loop
End Sub
Private Sub USBInThread_Ended(endedOK As Boolean, error As String)
	Log("USBInThread Ended OK " & endedOK & " " & error)
	'Thread Finished
	mIsRunning = False
	Interrupt = False
	'If SubExists(mModule,"MidiIN_Finished") Then CallSub(mModule,"MidiIN_Finished")
End Sub
Private Sub ShowMessage(Msg() As Byte)

	Dim Data(Msg.Length) As Object
	For i = 0 To Msg.Length - 1
		Data(i) = Msg(i)
	Next
	'Create the Formatter Object
    Dim Format As JavaObject
    Format.InitializeStatic("java.lang.String")
	
	Dim FormatString As String = "In   %#4x  %#4x %#4x"
	If Data.Length = 4 Then FormatString = FormatString  & " %#4x" 
	
	LogColor(Format.RunMethod("format",Array As Object(FormatString,Data)),Colors.Gray)
End Sub
'Get the current running state of this transmitter (USB Only)
Sub getIsRunning As Boolean
	Return mIsRunning
End Sub
'Set / get MidiThru Status, Need to enable if local device(s) are not playing the midi
'Enabled by default
Sub setMidiThru(Thru As Boolean)
	mMidiThru = Thru
End Sub
Sub getMidiThru As Boolean
	Return mMidiThru
End Sub
Sub setUSBChannel(Channel As Int)
	mUSBChannel = Channel
End Sub
Sub getUSBChannel As Int
	Return mUSBChannel
End Sub
Sub getReceivers As List
	Return mReceivers
End Sub