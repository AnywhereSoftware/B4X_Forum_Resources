B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.35
@EndOfDesignText@
'Example Midi Monitor
'Custom View class 
#DesignerProperty: Key: showchnls, DisplayName: Show Channels, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: loopdelay, DisplayName: Loop Delay, FieldType: Int, DefaultValue: 33, Description: Delay of 33 is approx 30 fps. The indocators will respond better with lower values.
Sub Class_Globals
	Private const NOTE_ON As Int = 0x90
	Private const NOTE_OFF As Int = 0x80

	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As Panel
	Private Const DefaultColorConstant As Int = -984833 'ignore
	Private Cnv As B4XCanvas
	Private mSeqr As MidiSequencer
	Private MidiCount(16) As Int
	Private Interrupt As Boolean
	Private IndRadius As Int
	Private IndDiameter As Int
	Private IndTop As Int
	Private IndSpace As Int = 5
	Private Xui As XUI
	Private LoopDelay As Int = 33 ' ~30 FPS
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	mBase = Base
	Cnv.Initialize(mBase)
	If Props.Get("showchnls") Then
		IndTop = mBase.Height / 2
		IndDiameter = Min((mBase.Width - 18 * IndSpace) / 16, IndTop - IndSpace * 2)
		IndRadius = IndDiameter / 2
		DrawChannels
	Else
		IndDiameter = (mBase.Width - 18 * IndSpace) / 16
		IndRadius = IndDiameter / 2
		IndTop = (mBase.Height - IndDiameter) / 2
	End If
	
	LoopDelay = Props.Get("loopdelay")
End Sub

Public Sub GetBase As Panel
	Return mBase
End Sub

Public Sub SetSeqr(Seqr As MidiSequencer)
	mSeqr = Seqr
	'Create a MidiReceiver and register it with the Sequencer so we can monitor the midi messages,
	'pass it this Module.
	Dim MDI As MidiDeviceInfo = MidiDevice_Static.RegisterReceiver("Monitor","Midi Monitor","Midi Monitor",Me)
	mSeqr.SetReceiver(MDI)
	
End Sub

'This module is the receiver for midi messages from the MidiRealTimeSequencer, we just need to create a Send(msg() As Byte) sub to get them
'And register it with the sequencer (See SetSeqr above)
Public Sub Send(Msg() As Byte)
	If Msg.Length = 3 Then
		Dim B0 As Int = Bit.And(Msg(0),0xff)
		Dim Status As Int = Bit.And(B0, 0xF0)
		Dim Chnl As Int = Bit.And(B0, 0x0F)
		Dim Velocity As Int = Bit.And(Msg(2),0xff)
		If Status = NOTE_ON And Velocity > 0 Then
			MidiCount(Chnl) = MidiCount(Chnl) + 1
		Else If Status = NOTE_ON And Velocity = 0 Or Status = NOTE_OFF Then
			MidiCount(Chnl) = Max(0, MidiCount(Chnl) - 1)
		End If
	End If
End Sub

Public Sub Start
	Interrupt = False
	MonitorLoop
End Sub

Public Sub Stop
	Interrupt = True
End Sub

Sub MonitorLoop
	Do While True
		For i = 0 To 15
			UpdateIndicator(i, MidiCount(i) > 0)
		Next
		Cnv.Invalidate
		Sleep(LoopDelay)
		If Interrupt Then
			ClearIndicators
			Exit
		End If
	Loop
End Sub

Public Sub ClearIndicators
	For i = 0 To 15
		MidiCount(i) = 0
		UpdateIndicator(i, False)
	Next
	Cnv.Invalidate
End Sub

Private Sub UpdateIndicator(chnl As Int, Active As Boolean)
	DrawIndicator(IndDiameter + IndSpace + chnl * (IndSpace + IndDiameter), IndTop + IndRadius + IndSpace, Active)
End Sub

Private Sub DrawIndicator(x As Int, y As Int, Active As Boolean)
	Dim clr As Int = IIf(Active, Colors.Green, Colors.Gray)
	Cnv.DrawCircle(x, y, IndRadius, clr, True, 0)
End Sub

Private Sub DrawChannels
	Dim Font As B4XFont = Xui.CreateDefaultFont(12)
	For i = 1 To 16
		Cnv.DrawText(i,IndDiameter + IndSpace + (i -1) * (IndSpace + IndDiameter), IndSpace + IndRadius + IndSpace,Font,Colors.White,"CENTER")
	Next
	Cnv.Invalidate
End Sub
