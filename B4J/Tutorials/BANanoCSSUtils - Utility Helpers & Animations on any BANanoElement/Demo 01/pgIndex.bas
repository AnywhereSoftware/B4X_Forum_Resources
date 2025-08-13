B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.5
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private banano As BANano							'ignore
	Private SHIonBaseElement1 As SHIonBaseElement		'ignore
	Private SHIonBaseElement2 As SHIonBaseElement		'ignore
	Private SHIonBaseElement3 As SHIonBaseElement		'ignore
	Private SHIonBaseElement4 As SHIonBaseElement		'ignore
	Private lblHeight As SHIonBaseElement				'ignore
	Private lblLeft As SHIonBaseElement					'ignore
	Private lblTop As SHIonBaseElement					'ignore
	Private lblWidth As SHIonBaseElement				'ignore
	Private lblHAnchor As SHIonBaseElement				'ignore
	Private lblVAnchor As SHIonBaseElement				'ignore
	Private lblCode As SHIonBaseElement					'ignore
	Private lblAssign As SHIonBaseElement				'ignore
	Private btnSetVisibleAnimated As SHIonBaseElement	'ignore
	Private btnSetLayoutAnimated As SHIonBaseElement	'ignore
	Private elState As String
	Private btnReset As SHIonBaseElement				'ignore
	Private btnSetLayoutAnimatedRadius As SHIonBaseElement		'ignore
	Private btnSetLeftAnimated As SHIonBaseElement				'ignore
	Private btnSetTopAnimated As SHIonBaseElement				'ignore
	Private btnSetHeightAnimated As SHIonBaseElement			'ignore
	Private btnSetWidthAnimated As SHIonBaseElement				'ignore
	Private btnSetColorAnimated As SHIonBaseElement				'ignore
	Private btnSetAlphaAnimated As SHIonBaseElement				'ignore
	Private btnSetRotateAnimated As SHIonBaseElement			'ignore
	Private btnSetRadiusAnimated As SHIonBaseElement			'ignore
	Private btnTextSizeAnimated As SHIonBaseElement				'ignore
	Private imgDiv As SHIonBaseElement							'ignore
	Private btnSetScaleAnimated As SHIonBaseElement				'ignore
End Sub

Sub Initialize
	banano.LoadLayout("#body", "baselayout")
	lblTop.Text = "Top: " & SHIonBaseElement1.B4XTop
	lblLeft.Text = "Left: " & SHIonBaseElement1.B4XLeft
	lblHeight.Text = "Height: " & SHIonBaseElement1.B4xHeight
	lblWidth.Text = "Width: " & SHIonBaseElement1.B4XWidth
	lblHAnchor.Text = "HAnchor: " & SHIonBaseElement1.B4XHAnchor
	lblVAnchor.Text = "VAnchor: " & SHIonBaseElement1.B4XVAnchor
	
	'** IMPORTANT
	BANanoCSSUtils.SetModule(Me)
	BANanoCSSUtils.SetBackgroundImage(imgDiv.Element, "./assets/firefox-logo.svg")
	BANanoCSSUtils.SetScale(imgDiv.Element, 1)
	'Log(SHIonBaseElement1.B4XVisible)
	'Log(SHIonBaseElement1.B4XEnabled)
	
	'get the state of the component
	elState = SHIonBaseElement1.ToJSON
	'define a new component
	Dim elCopy As SHIonBaseElement
	elCopy.Initialize(Me, "elCopy", "elCopy")
	'use add to parent to inject the copied state.
	elCopy.AddToParentJSON(lblCode.Here, elState)
	
	lblAssign.Text = "Assign"
	
'	banano.LoadLayout(SHIonBaseElement1.Here, "childlayout")
'	banano.LoadLayout(SHIonBaseElement2.Here, "childlayout")
'	banano.LoadLayout(SHIonBaseElement3.Here, "childlayout")
'	banano.LoadLayout(SHIonBaseElement4.Here, "childlayout")
End Sub

Private Sub lblAssign_Click (e As BANanoEvent)
	Dim elem As SHIonBaseElement = Sender
	Log(elem.ID) ' <------ the auto generated ID 
End Sub

Private Sub SHIonBaseElement1_Animation_Complete (anim As BANanoObject)
	'banano.Alert("Animation complete!")
End Sub

Private Sub btnSetLayoutAnimated_Click (e As BANanoEvent)
	BANanoCSSUtils.SetLayoutAnimated(SHIonBaseElement1.Element, 2000, "20px", "20px", "400px", "200px")
End Sub

Private Sub btnReset_Click (e As BANanoEvent)
	'get the state of the component
	Dim statem As Map = banano.FromJson(elState)
	Dim sB4XHeight As String = statem.Get("B4XHeight")
	Dim sB4XLeft As String = statem.Get("B4XLeft")
	Dim sB4XTop As String = statem.Get("B4XTop")
	Dim sB4XWidth As String = statem.Get("B4XWidth")
	Dim sBorderRadius As String = statem.Get("BorderRadius")
	Dim sBackgroundColor As String = statem.Get("BackgroundColor")
	BANanoCSSUtils.SetLayoutAnimatedRadius(SHIonBaseElement1.Element, 2000, sB4XLeft, sB4XTop, sB4XWidth, sB4XHeight, sBorderRadius)
	BANanoCSSUtils.SetColorAnimated(SHIonBaseElement1.Element, 2000, "#fe4a49".ToUpperCase, sBackgroundColor)
	BANanoCSSUtils.SetAlphaAnimated(SHIonBaseElement1.Element, 0, 1)
	BANanoCSSUtils.SetRotationAnimated(SHIonBaseElement1.Element, 2000, 0)
	BANanoCSSUtils.SetRadiusAnimated(SHIonBaseElement1.Element, 2000, "0px")
	BANanoCSSUtils.SetTextSizeAnimated(SHIonBaseElement1.Element, 2000, "16px")
	BANanoCSSUtils.SetVisibleAnimated(SHIonBaseElement1.Element, 2000, True)
	BANanoCSSUtils.SetScaleAnimated(imgDiv.Element, 2000, 2, 1)
End Sub

Private Sub SHIonBaseElement1_Animation_Update (anim As BANanoObject)
	Log("SHIonBaseElement1_Animation_Update...")
End Sub

Private Sub SHIonBaseElement1_Animation_Begin (anim As BANanoObject)
	Log("SHIonBaseElement1_Animation_Begin...")
End Sub

Private Sub SHIonBaseElement1_Animation_Change
	Log("SHIonBaseElement1_Animation_Change...")
End Sub

Private Sub SHIonBaseElement1_Animation_ChangeBegin (anim As BANanoObject)
	Log("SHIonBaseElement1_Animation_ChangeBegin...")
End Sub

Private Sub SHIonBaseElement1_Animation_ChangeComplete (anim As BANanoObject)
	Log("SHIonBaseElement1_Animation_ChangeComplete...")
End Sub

Private Sub btnSetLayoutAnimatedRadius_Click (e As BANanoEvent)
	BANanoCSSUtils.SetLayoutAnimatedRadius(SHIonBaseElement1.Element, 2000, "20px", "20px", "400px", "200px", "20px")
End Sub

Private Sub btnSetTopAnimated_Click (e As BANanoEvent)
	BANanoCSSUtils.SetTopAnimated(SHIonBaseElement1.Element, 2000, "100px")
End Sub

Private Sub btnSetLeftAnimated_Click (e As BANanoEvent)
	BANanoCSSUtils.SetLeftAnimated(SHIonBaseElement1.Element, 2000, "100px")
End Sub

Private Sub btnSetWidthAnimated_Click (e As BANanoEvent)
	BANanoCSSUtils.SetWidthAnimated(SHIonBaseElement1.Element, 2000, "300px")
End Sub

Private Sub btnSetHeightAnimated_Click (e As BANanoEvent)
	BANanoCSSUtils.SetHeightAnimated(SHIonBaseElement1.Element, 2000, "100px")
End Sub

Private Sub btnSetColorAnimated_Click (e As BANanoEvent)
	BANanoCSSUtils.SetColorAnimated(SHIonBaseElement1.Element, 2000, "#b0e0e6".ToUpperCase, "#fe4a49".ToUpperCase)
End Sub

Private Sub btnSetAlphaAnimated_Click (e As BANanoEvent)
	BANanoCSSUtils.SetAlphaAnimated(SHIonBaseElement1.Element, 2000, 0.5)
End Sub

Private Sub btnSetRotateAnimated_Click (e As BANanoEvent)
	BANanoCSSUtils.SetRotationAnimated(SHIonBaseElement1.Element, 2000, 45)
End Sub

Private Sub btnSetRadiusAnimated_Click (e As BANanoEvent)
	BANanoCSSUtils.SetRadiusAnimated(SHIonBaseElement1.Element, 2000, "50%")
End Sub

Private Sub btnTextSizeAnimated_Click (e As BANanoEvent)
'	Log(BANanoCSSUtils.GetStyleProperty(SHIonBaseElement1.Element, "font-size"))
	BANanoCSSUtils.SetTextSizeAnimated(SHIonBaseElement1.Element, 2000, "60px")
End Sub

Private Sub btnSetVisibleAnimated_Click (e As BANanoEvent)
	BANanoCSSUtils.SetVisibleAnimated(SHIonBaseElement1.Element, 2000, False)
End Sub

Private Sub btnSetScaleAnimated_Click (e As BANanoEvent)
	BANanoCSSUtils.SetScaleAnimated(imgDiv.Element, 2000, 1, 2)
End Sub