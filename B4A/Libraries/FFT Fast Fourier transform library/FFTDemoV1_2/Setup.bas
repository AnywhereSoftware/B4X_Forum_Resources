Type=Activity
Version=3.82
B4A=true
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals

End Sub

Sub Globals
	Dim spnSineIndex, spnSinesNb As Spinner
	Dim ckbOffset, ckbDamping, ckbSineModulation As CheckBox
	Dim lblSineNbPeriods, lblSineAmpl, lblSinePhase As Label
	Dim lblSineOffset, lblSineDamping, lblModulationPercent, lblModulationPeriod As Label
	Dim SendView As Label
	Dim rbtTransform0, rbtTransform2 As RadioButton
	
	Dim pnlBackground, pnlInput As Panel
	Dim btnInputMinus As Button
	Dim lblInputTitle, lblInputDisplay, lblInputDispCurs As Label
	Dim CurPos = 0 As Int
	
	Dim RadDeg = 180 / cPI As Double
	Dim flgDot = False As Boolean
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("Setup")
	Activity.LoadLayout("Input")
	
	SetPaddings
	
	InitSinesNb
	
	UpdateSineSetup
	UpdateSineParameters
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)
	UpdateOneSineParameters
	UpdateSineParameters
	Main.flgSetupChanged = True
End Sub

Sub InitSinesNb
	Dim i As Int
	
	spnSinesNb.Clear
	spnSinesNb.Prompt = "Select the number of sines"
	spnSinesNb.Add(" 1 sine")
	For i = 2 To 9
		spnSinesNb.Add(" " & i & " sines")
	Next
	spnSinesNb.Add("10 sines")
End Sub

Sub lblInput_Click
	Dim Title As String
	
	SendView = Sender

	If SendView.Tag = "SineNbPeriods" Then
		Title = "Sinus  " & (Main.SineI + 1) & "  nb. of periods"
	Else If SendView.Tag = "SineAmpl" Then
		Title = "Sinus  " & (Main.SineI + 1) & "  amplitude"
	Else If SendView.Tag = "SinePhase" Then
		Title = "Sinus  " & (Main.SineI + 1) & "  phase [deg]"
	Else If SendView.Tag = "ModulationPeriod" Then
		Title = "Modulation   nb. of periods"
	Else If SendView.Tag = "ModulationPercent" Then
		Title = "Modulation   percentage"
	Else If SendView.Tag = "SineOffset" Then
		Title = "DC offset"
	Else If SendView.Tag = "SineDamping" Then
		Title = "Damping coefficient"
	End If
	
	Input1(SendView, Title)
End Sub

Sub Input1(ctrl As View,Title As String)
' input panel management
	If SendView.Tag = "SineAmpl" OR SendView.Tag = "SineNbPeriods" OR SendView.Tag = "SineDamping" OR SendView.Tag = "ModulationPeriod" OR SendView.Tag = "ModulationPercent" Then
		btnInputMinus.Visible = False
	Else
		btnInputMinus.Visible = True
	End If
	lblInputTitle.Text = Title
	lblInputDisplay.Text = SendView.Text
	lblInputDispCurs.Text = ""
	For i = 0 To SendView.Text.Length - 1
		lblInputDispCurs.Text = lblInputDispCurs.Text & " "
	Next
	lblInputDispCurs.Text = lblInputDispCurs.Text & "_"
	CurPos = i
	
	pnlBackground.Visible = True
End Sub

Sub UpdateSineParameters
	Dim i As Int
	
	Main.SineModPeriod = lblModulationPeriod.Text
	Main.SineModPercent = lblModulationPercent.Text / 100
	Main.SineDampingCoef = lblSineDamping.Text
	Main.SineDamping = Main.SineDampingCoef * cPI / Main.NN
	Main.SineOffset = lblSineOffset.Text
	
	UpdateOneSineParameters
	
	For i = 0 To Main.SineNb - 1
		Main.SineW0(i) = cPI / Main.ND2 * Main.SineNbPeriods(i)
	Next
	Main.SineModW0 = cPI / Main.ND2 * Main.SineModPeriod
End Sub

Sub UpdateSineSetup
	Dim i As Int
	
	spnSinesNb.SelectedIndex = Main.SineNb - 1
	spnSineIndex.Clear
	For i = 0 To Main.SineNb - 1
		spnSineIndex.Add("Sine " & (i + 1))
	Next
	spnSineIndex.SelectedIndex = Main.SineI
	lblModulationPercent.Text = (Main.SineModPercent * 100)
	lblModulationPeriod.Text = Main.SineModPeriod
	lblSineDamping.Text = Main.SineDampingCoef
	lblSineOffset.Text = Main.SineOffset
	ckbDamping.Checked = Main.flgDamping
	ckbOffset.Checked = Main.flgOffset
	ckbSineModulation.Checked = Main.flgSineModulation
	UpdateOneSineSetup
	
	If Main.Transform = 0 Then
		rbtTransform0.Checked = True
	Else
		rbtTransform2.Checked = True
	End If
End Sub

Sub UpdateOneSineSetup
	lblSineNbPeriods.Text = Main.SineNbPeriods(Main.SineI)
	lblSineAmpl.Text = Main.SineAmpl(Main.SineI)
	lblSinePhase.Text = (Main.SinePhase(Main.SineI) * RadDeg)
End Sub

Sub UpdateOneSineParameters
	Main.SineAmpl(Main.SineI) = lblSineAmpl.Text
	Main.SinePhase(Main.SineI) = (lblSinePhase.Text) / RadDeg
	Main.SineNbPeriods(Main.SineI) = lblSineNbPeriods.Text
End Sub

Sub ckbOffset_CheckedChange(Checked As Boolean)
	Main.flgOffset = Checked
End Sub

Sub ckbDamping_CheckedChange(Checked As Boolean)
	Main.flgDamping = Checked
End Sub

Sub ckbSineModulation_CheckedChange(Checked As Boolean)
	Main.flgSineModulation = Checked
End Sub

Sub spnSineIndex_ItemClick (Position As Int, Value As Object)
	UpdateSineParameters
	Main.SineI = Position
	UpdateOneSineSetup
End Sub

Sub spnSinesNb_ItemClick (Position As Int, Value As Object)
	Dim i As Int
	
	If Position <> Main.SineNb - 1 Then
		Main.SineNb = Position + 1
		spnSineIndex.Clear
		For i = 0 To Main.SineNb - 1
			spnSineIndex.Add("Sine " & (i + 1))
		Next
		spnSineIndex.SelectedIndex = 0
	End If
End Sub

' FFT1.Transform and FFT1.Inverse
Sub rbtTransform0_Click
	Main.Transform = 0
End Sub

' FFT1.Transform2 and FFT1.Inverse2
Sub rbtTransform2_Click
	Main.Transform = 2
End Sub

Sub SetPaddings
	setPadding(lblModulationPercent)
	setPadding(lblModulationPeriod)
	setPadding(lblSineAmpl)
	setPadding(lblSineDamping)
	setPadding(lblSineNbPeriods)
	setPadding(lblSineOffset)
	setPadding(lblSinePhase)
	setPadding(lblInputDisplay)
	setPadding(lblInputDispCurs)
End Sub

Sub setPadding(lbl As Label)
	Dim lp As Int
	lp = DipToCurrent(lbl.TextSize * .5)
	Dim jo = lbl As JavaObject
	jo.RunMethod("setPadding", Array As Object(lp, 1dip, lp, 1dip))
End Sub

Sub btnInputOK_Click
	If lblInputDisplay.Text <> "" Then
		SendView.Text = lblInputDisplay.Text
		btnInputMinus.Visible = True
		pnlBackground.Visible = False
	End If
End Sub

Sub btnInputCancel_Click
	pnlBackground.Visible = False
	lblInputDispCurs.Visible = True
End Sub

Sub btnInputNb_Click
	Dim Send As View, ch As String
	Dim txt1, txt2 As String
	Dim i As Int
	
	Send = Sender
	ch = Send.Tag
	
	If ch = "0" OR ch = "1" OR ch = "2" OR ch = "3" OR ch = "4" OR ch = "5" OR ch = "6" OR ch = "7" OR ch = "8" OR ch = "9" Then
		If CurPos = lblInputDisplay.Text.Length Then
			lblInputDisplay.Text = lblInputDisplay.Text & ch
		Else 
			txt1 = lblInputDisplay.Text.SubString2(0, CurPos)
			txt2 = lblInputDisplay.Text.SubString2(CurPos, lblInputDisplay.Text.Length)
			lblInputDisplay.Text = txt1 & ch & txt2
		End If
		
		If lblInputDispCurs.Text.Length = 0 Then
			lblInputDispCurs.Text = "_"
		Else
			lblInputDispCurs.Text = " " & lblInputDispCurs.Text
		End If
		CurPos = CurPos + 1
	Else If ch = "." AND flgDot = False Then	
		flgDot = True
		lblInputDisplay.Text = lblInputDisplay.Text & ch
		lblInputDispCurs.Text = " " & lblInputDispCurs.Text
		CurPos = CurPos + 1
	Else If ch = "-" Then
		If lblInputDisplay.Text.Length > 0 Then
			If lblInputDisplay.Text.CharAt(0) = "-" Then
				lblInputDisplay.Text = lblInputDisplay.Text.SubString2(1, lblInputDisplay.Text.Length)
				lblInputDispCurs.Text = lblInputDispCurs.Text.SubString2(1, lblInputDispCurs.Text.Length)
				CurPos = CurPos - 1
			Else
				lblInputDisplay.Text = ch & lblInputDisplay.Text
				lblInputDispCurs.Text = " " & lblInputDispCurs.Text
				CurPos = CurPos + 1
			End If
		Else
			lblInputDisplay.Text = ch & lblInputDisplay.Text
			lblInputDispCurs.Text = " " & lblInputDispCurs.Text
			CurPos = CurPos + 1
		End If
	Else If ch = "BS" Then
		If lblInputDisplay.Text.Length>0 Then
			If lblInputDisplay.Text.CharAt(lblInputDisplay.Text.Length - 1) = "." Then
				flgDot = False
			End If
			lblInputDisplay.Text = lblInputDisplay.Text.SubString2(0, lblInputDisplay.Text.Length - 1)
			lblInputDispCurs.Text = lblInputDispCurs.Text.SubString2(1, lblInputDispCurs.Text.Length)
			CurPos = CurPos - 1
		Else
			flgDot = False
		End If
	Else If ch = "R" Then
		If CurPos<lblInputDisplay.Text.Length Then
			CurPos = CurPos + 1
			lblInputDispCurs.Text = " " & lblInputDispCurs.Text
		End If
	Else If ch = "L" Then
		If CurPos>0 Then
			CurPos = CurPos - 1
			lblInputDispCurs.Text = lblInputDispCurs.Text.SubString2(1, lblInputDispCurs.Text.Length)
		End If
	Else If ch = "S" Then
		lblInputDispCurs.Text = "_"
		CurPos = 0
	Else If ch = "E" Then
		For i = CurPos To lblInputDisplay.Text.Length - 1
			lblInputDispCurs.Text = " " & lblInputDispCurs.Text
		Next
		CurPos = i
	Else If ch = "Clr" Then
		lblInputDisplay.Text = ""
		lblInputDispCurs.Text = "_"
		CurPos = 0
	Else If ch = "Del" Then
		If CurPos<lblInputDisplay.Text.Length Then
			txt1 = lblInputDisplay.Text.SubString2(0, CurPos)
			txt2 = lblInputDisplay.Text.SubString2(CurPos + 1, lblInputDisplay.Text.Length)
			lblInputDisplay.Text = txt1 & txt2
		End If
	End If
End Sub

Sub btnHelp_Click
	Help.HelpIndex = 4
	StartActivity(Help)
End Sub

'used to consume events of views behind pnlBackground
Sub pnlBackground_Click

End Sub