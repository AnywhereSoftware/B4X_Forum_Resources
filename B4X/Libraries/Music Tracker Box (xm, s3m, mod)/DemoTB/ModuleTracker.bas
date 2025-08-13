B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private TB As TrackerBox
	Private SampleRate As Int = 48000
	Private Playing As Boolean = False

	Private MainProc As Object, EventName As String
	Private LSpectr As Spectrum, RSpectr As Spectrum
	
	Public Volume As Int = 1000
	Public Reverb As Int = 0
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(proc As Object, evname As String, LSpect As B4XView, Rspect As B4XView)
	MainProc = proc
	EventName = evname
	TB.Initialize
	LSpectr.Initialize(LSpect, xui.Color_RGB(239,253,222), xui.Color_RGB(0, 0, 0))
	RSpectr.Initialize(Rspect, xui.Color_RGB(252,252,84), xui.Color_RGB(0, 0, 0))
End Sub

Public Sub LoadModule(Dir As String, FileName As String)
	TB.LoadModule(SampleRate, Dir, FileName)
End Sub

Public Sub PlayModule()
	If TB.ReadyModule = True And Playing = False Then
		Playing = True
		Dim mixBuf(TB.MixBufferLength) As Int
		Dim outBuf(mixBuf.Length * 2) As Byte
		Dim detectR As Int, detectB As Int
		
		Dim reverbIdx As Int
		Dim ReverbBuf() As Int
		Dim ReverbOld As Int = 0
		
		TB.AudioOpen(SampleRate)
		
		Do While Playing = True
			Dim count As Int = TB.Audio(mixBuf)
			
			If Reverb > 0 Then
				If Reverb <> ReverbOld Then
					ReverbOld = Reverb
					Dim ReverbBuf( Bit.And(Bit.ShiftRight(SampleRate * Reverb, 9), -2) ) As Int
					reverbIdx = 0
				End If
				reverbIdx = Reverb_(mixBuf, ReverbBuf, reverbIdx, count)
			End If

			Clip_(mixBuf, outBuf, count * 2)

			TB.AudioWrite(outBuf, 0, count * 4 )
			Do While TB.AudioReady = False
				#if b4j 
				Sleep(5)
				#else
				Sleep(1)
				#end if
			Loop
			
			LSpectr.GetBuf(mixBuf, count, 0)
			RSpectr.GetBuf(mixBuf, count, 1)
			
			If (detectR = -1 And TB.Row = 0) Or (detectR = 0 And TB.Row = 0 And detectB > 0) Then
				detectR = 0 : detectB = 0
				CallSub2(MainProc, EventName & "_Row", TB.SequencePos)
			End If
			
			detectR = TB.NextRow
			detectB = TB.BreakSeqPos
		Loop
		LSpectr.GetBuf(Array As Int(), 0, 0)
		RSpectr.GetBuf(Array As Int(), 0, 1)
		TB.AudioClose
	End If
End Sub

Private Sub Clip_(inputBuf() As Int, outputBuf() As Byte, count As Int )
	For idx = 0 To count - 1
		Dim ampl As Int = inputBuf(idx)
		ampl = Volume * ampl / 1000
		If ampl > 32767 Then ampl = 32767
		If ampl < -32768 Then ampl = -32768
				
		outputBuf(idx * 2) = ampl
		outputBuf(idx * 2 + 1) = Bit.ShiftRight(ampl, 8)
	Next
End Sub

Private Sub Reverb_(buf() As Int, reverbBuf() As Int, reverbIdx As Int, count As Int ) As Int
	For idx = 0 To count - 1
		buf(idx * 2) = Bit.ShiftRight(buf(idx * 2) * 3 + reverbBuf(reverbIdx + 1), 2)
		buf(idx * 2 + 1)=  Bit.ShiftRight(buf(idx * 2 + 1) * 3 + reverbBuf(reverbIdx), 2)
		reverbBuf(reverbIdx)= buf(idx * 2)
		reverbBuf(reverbIdx + 1) = buf(idx * 2 + 1)
		reverbIdx = reverbIdx + 2
		If reverbIdx >= reverbBuf.length Then reverbIdx = 0
	Next
	Return reverbIdx
End Sub

Public Sub PauseModule()
	Playing = False
End Sub

Public Sub getSongName As String
	Return TB.SongName
End Sub

Public Sub getSequenceLength As Int
	Return TB.SequenceLength
End Sub

Public Sub getSequencePos As Int
	Return TB.SequencePos
End Sub

Public Sub setSequencePos(pos As Int)
	TB.SequencePos = pos
End Sub

Public Sub setInterpolation(metod As Int)
	TB.Interpolation = metod
End Sub

Public Sub getInterpolation() As Int
	Return TB.Interpolation
End Sub

Public Sub getReadyModule() As Boolean
	Return TB.ReadyModule
End Sub
