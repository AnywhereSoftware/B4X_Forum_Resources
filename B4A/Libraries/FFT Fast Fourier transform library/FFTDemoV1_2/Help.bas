Type=Activity
Version=3.82
B4A=true
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	Dim HelpIndex = 0 As Int
	Dim HelpIndexMax = 5 As Int
End Sub

Sub Globals
	Dim pnlHelp As Panel
	Dim lblHelp1, lblHelp2, lblHelp3 As Label
	Dim btnHelpPrev, btnHelpNext, btnHelpLast, btnHelpFirst As Button
	Dim scvHelp As ScrollView
	Dim stu As StringUtils
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("Help")
	InitHelp
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub InitHelp
' Initilisation of the help panel, ScrollView
	Dim vv As View
	Dim i As Int
	Dim TagNb As Int
	Dim TagI(10) As Int
	Dim Tags(10) As String
	Dim txt As String
	
	TagNb = 0
	For i = 0 To pnlHelp.NumberOfViews - 1
		vv = pnlHelp.GetView(i)
		txt = vv.Tag
		If txt = "Help1" OR txt = "Help2" OR txt = "Help3" Then
			TagNb = TagNb + 1
			Tags(TagNb) = txt
			TagI(TagNb) = i
		End If
	Next
	
	Dim Space = btnHelpFirst.Top As Int
	For i = TagNb To 1 Step -1
		pnlHelp.RemoveViewAt(TagI(i))
		If Tags(i) = "Help1" Then
			scvHelp.Panel.AddView(lblHelp1, Space, Space, 0.45 * scvHelp.Width, lblHelp1.Height)
		Else If Tags(i) = "Help2" Then
			scvHelp.Panel.AddView(lblHelp2, 0.55 * scvHelp.Width - Space ,Space ,0.45 * scvHelp.Width, lblHelp2.Height)
		Else If Tags(i) = "Help3" Then
			scvHelp.Panel.AddView(lblHelp3, Space, lblHelp1.Height + 2 * Space, 100%x - 2 * Space, 450dip)
		End If	
	Next

	DisplayHelp
End Sub

' help button maganement
Sub btnHelpMove_Click
	Dim Send As View, btn As String
	
	Send = Sender
	btn = Send.Tag
	
	If HelpIndex>0 AND btn = "Prev" Then
		HelpIndex = HelpIndex - 1
	Else If HelpIndex<HelpIndexMax AND btn = "Next" Then
		HelpIndex = HelpIndex + 1
	Else If btn = "First" Then
		HelpIndex = 0
	Else If btn = "Last" Then
		HelpIndex = HelpIndexMax
	End If

	If HelpIndex = 0 Then
		btnHelpPrev.Enabled = False
		btnHelpFirst.Enabled = False
	Else
		btnHelpPrev.Enabled = True
		btnHelpFirst.Enabled = True
	End If

	If HelpIndex = HelpIndexMax Then
		btnHelpNext.Enabled = False
		btnHelpLast.Enabled = False
	Else
		btnHelpNext.Enabled = True
		btnHelpLast.Enabled = True
	End If

	DisplayHelp
End Sub

' displaying the help texts
Sub DisplayHelp
	Dim txt1, txt2, txt3 As String
	
	scvHelp.ScrollPosition = 0
	txt2 = "FFTdemo Help  Version 1.1"
	If HelpIndex = 0 Then
		txt1 = txt2
		txt2 = ""
		txt3 = "The program shows some basic operations with  FFT, Fast Fourier Transform, calculations which is a mathematical transformation of signals in the time domain to signals in the frequency domain." & CRLF
		txt3 = txt3 & "The FFT is mainly used in frequency analysis, vibration analysis, audio systems, spectrum analysers etc." & CRLF & CRLF
		txt3 = txt3 & "This program can use either the Transform / Inverse or the Transform2 / Inverse2 method pair." & CRLF
		txt3 = txt3 & "You can set the <Transform> variable to <0> or to <2> in the setup Panel." & CRLF
		txt3 = txt3 & TAB & "<0> for Transform / Inverse  and <2> for Transform2 / Inverse2." & CRLF & CRLF
		txt3 = txt3 & "A pure sine wave in the time domain is represented by ONE spectral line in the frequency domain." & CRLF & CRLF
		txt3 = txt3 & "Examples:" & CRLF & CRLF
		txt3 = txt3 & "<1 sin>" & TAB & "calculates 1 pure sine wave with one period over the time window, which gives just one line at index 1 in the frequency domain." & CRLF & CRLF
		txt3 = txt3 & "<3 sin>" & TAB & "calculates 3 pure sine waves with 1,  25  and 100 periods over the time window, which gives 3 spectral lines at index 1,  25 and 100 in the frequency domain." & CRLF & CRLF
		txt3 = txt3 & "You can calculate different time signals composed of sines or cosines, predefined and user defined, calculate the FFT and Inverse FFT and display the values of the samples in a list and in graphics."
	Else If HelpIndex = 1 Then
		txt1 = "Calculating time signals"
		txt3 = "<1 sin>" & TAB & "1 sine wave with 1 period over the time window  amplitude = 1" & CRLF & CRLF
		txt3 = txt3 & "<3 sin>" & TAB & "3 sine waves with 1, 25, 100 periods over the time window" & CRLF
		txt3 = txt3 & TAB & TAB & TAB & "A1 = 1   A2 = 0.8   A3 = 0.5" & CRLF & CRLF
		txt3 = txt3 & "<3 cos>" & TAB & "3 cosine waves with 1, 25, 100 periods over the time window" & CRLF
		txt3 = txt3 & TAB & TAB & TAB & "A1 = 1   A2 = 0.8   A3 = 0.5" & CRLF & CRLF
		txt3 = txt3 & "<n sin>" & TAB & "n sine waves, user definable to a maximum of 10 sines" & CRLF & CRLF
		txt3 = txt3 & "<Setup>" & TAB & "Sine definitions and additional parameters below" & CRLF & CRLF
		txt3 = txt3 & "<Damping>" & TAB & "adds a damping to the signal" & CRLF
		txt3 = txt3 & TAB & TAB & "the damping coefficient can be defined in <Setup>" & CRLF & CRLF
		txt3 = txt3 & "<Offset>" & TAB & TAB & "adds a DC offset to the signal" & CRLF
		txt3 = txt3 & TAB & TAB & "the DC offset can be defined in <Setup>" & CRLF & CRLF
		txt3 = txt3 & "<Modulation>" & TAB & "adds an amplitude frequency modulation" & CRLF
		txt3 = txt3 & TAB & TAB & "it can be defined in <Setup>" & CRLF
	Else If HelpIndex = 2 Then
		txt1 = "Calculating   Inverse FFT"
		txt3 = "<FFT I>" & TAB & "calculates the inverse FFT, frequency domain to time domain." & CRLF & CRLF
		txt3 = txt3 & "<Del>" & TAB & TAB & "allows deleting the selected frequency sample." & CRLF & CRLF
		txt3 = txt3 & "Deleting frequency samples and calculating the Inverse FFT shows the time signal without the deleted frequencies." & CRLF
	Else If HelpIndex = 3 Then
		txt1 = "Displaying signals"
		txt3 = "Sample values in a List" & CRLF
		txt3 = txt3 & TAB & "<Real>" & TAB & TAB & TAB & "Real, time series or frequency" & CRLF
		txt3 = txt3 & TAB & "<Imag>" & TAB & TAB & "Imaginary, time series or frequency" & CRLF
		txt3 = txt3 & TAB & "<Ampl>" & TAB & TAB & "Amplitude" & TAB & "(FFT only)" & CRLF
		txt3 = txt3 & TAB & "<Phas>" & TAB & TAB & "Phase" & TAB & TAB & TAB & "(FFT only)" & CRLF & CRLF
		txt3 = txt3 & "Graphics" & CRLF
		txt3 = txt3 & TAB & "<Time>" & TAB & TAB & "Time series,  real and imaginary" & CRLF
		txt3 = txt3 & TAB & "<FFT>" & TAB & TAB & TAB & "Frequencies" & CRLF
		txt3 = txt3 & TAB & "<R / I>" & TAB & TAB & TAB & "Real (Cosine) / Imaginary (Sine)" & CRLF
		txt3 = txt3 & TAB & "<A / P>" & TAB & TAB & "Amplitude / Phase" & CRLF & CRLF
		txt3 = txt3 & "Cursor function" & CRLF
		txt3 = txt3 & "Pointing onto a diagram sets the cursor and displays the index and values of the selected sample." & CRLF
		txt3 = txt3 & "Clicking onto <  or  >  moves the cursor by 1, a long click moves it by 10" & CRLF
	Else If HelpIndex = 4 Then
		txt1 = "<Setup>"
		txt3 = "Sine definition" & CRLF
		txt3 = txt3 & TAB & "Number of sines  (max. 10)" & CRLF
		txt3 = txt3 & TAB & "Index of the selected sine" & CRLF
		txt3 = txt3 & TAB & "Number of periods over the time window" & CRLF
		txt3 = txt3 & TAB & "Amplitude of the selected sine" & CRLF
		txt3 = txt3 & TAB & "Phase of the selected sine  ( Ex:  -90° = sine,  0° = cosine)" & CRLF & CRLF
		txt3 = txt3 & "Modulation" & CRLF
		txt3 = txt3 & TAB & "Periods:" & TAB & TAB & "number of modulation periods over the time window" & CRLF
		txt3 = txt3 & TAB & "Percent %:" & TAB & "modulation  percentage      max: 100%" & CRLF & CRLF
		txt3 = txt3 & "Offset" & CRLF
		txt3 = txt3 & TAB & "DC offset value" & CRLF & CRLF
		txt3 = txt3 & "Damping" & CRLF
		txt3 = txt3 & TAB & "damping coefficient" & CRLF & CRLF
		txt3 = txt3 & "To change parameters, click onto the parameter, an input screen will be displayed." & CRLF & CRLF
		txt3 = txt3 & "FFT Transform mode" & CRLF
		txt3 = txt3 & "0" & TAB & "uses the Transform / Inverse routines from the FFT library" & CRLF
		txt3 = txt3 & TAB & TAB & "in this case there are 256 time samples and 256 frequency samples" & CRLF
		txt3 = txt3 & TAB & TAB & "each frequency sample is a complex conjugate pair of values." & CRLF
		txt3 = txt3 & "2" & TAB & "uses the Transform2 / Inverse2 routines from the FFT library" & CRLF
		txt3 = txt3 & TAB & TAB & "in this case there are 256 time samples but only 129 (256 / 2 + 1) frequency samples." & CRLF
	Else If HelpIndex = HelpIndexMax Then
		txt1 = "About"
		txt3 = "Program:" & TAB & TAB & TAB & Main.ProgName & TAB & TAB & Main.ProgVersion & CRLF
		txt3 = txt3 & "Date:" & TAB & TAB & TAB & TAB & TAB & TAB & Main.ProgDate & CRLF
		txt3 = txt3 & "Written by:" & TAB & Main.ProgAuthor & CRLF & CRLF
		txt3 = txt3 & "The FFT library Is based on a port of the FFT from the SciMark2a Java Benchmark To C#  by Chris Re (cmr28@cornell.edu) and Werner Vogels (vogels@cs.cornell.edu)." & CRLF
		txt3 = txt3 & "For details on the original authors see http: /  / math.nist.gov / scimark2" & CRLF & CRLF
		txt3 = txt3 & "Library adapted for B4Android by Andrew Graham" & CRLF & CRLF
		txt3 = txt3 & "Library version : " & Main.FFT1.Version
	End If
	lblHelp1.Text = txt1
	lblHelp2.Text = txt2
	lblHelp3.Text = txt3
	lblHelp3.Height = stu.MeasureMultilineTextHeight(lblHelp3, txt3)
	scvHelp.Panel.Height = lblHelp3.Height + lblHelp1.Height + 2 * lblHelp1.Top
End Sub
