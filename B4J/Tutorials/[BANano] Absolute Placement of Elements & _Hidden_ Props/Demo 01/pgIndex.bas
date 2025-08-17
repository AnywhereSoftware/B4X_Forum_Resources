B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.5
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private banano As BANano		'ignore
	Private SHIonBaseElement1 As SHIonBaseElement
	Private SHIonBaseElement2 As SHIonBaseElement
	Private SHIonBaseElement3 As SHIonBaseElement
	Private SHIonBaseElement4 As SHIonBaseElement
	Private lblHeight As SHIonBaseElement
	Private lblLeft As SHIonBaseElement
	Private lblTop As SHIonBaseElement
	Private lblWidth As SHIonBaseElement
	Private lblHAnchor As SHIonBaseElement
	Private lblVAnchor As SHIonBaseElement
	Private lblCode As SHIonBaseElement
End Sub

Sub Initialize
	banano.LoadLayout("#body", "baselayout")
	lblTop.Text = "Top: " & SHIonBaseElement1.B4XTop
	lblLeft.Text = "Left: " & SHIonBaseElement1.B4XLeft
	lblHeight.Text = "Height: " & SHIonBaseElement1.B4xHeight
	lblWidth.Text = "Width: " & SHIonBaseElement1.B4XWidth
	lblHAnchor.Text = "HAnchor: " & SHIonBaseElement1.B4XHAnchor
	lblVAnchor.Text = "VAnchor: " & SHIonBaseElement1.B4XVAnchor
	'
	'Log(SHIonBaseElement1.B4XVisible)
	'Log(SHIonBaseElement1.B4XEnabled)
	
	'get the state of the component
	Dim sCopy As String = SHIonBaseElement1.ToJSON
	'define a new component
	Dim elCopy As SHIonBaseElement
	elCopy.Initialize(Me, "elCopy", "elCopy")
	'use add to parent to inject the copied state.
	elCopy.AddToParentJSON(lblCode.Here, sCopy)
	
'	banano.LoadLayout(SHIonBaseElement1.Here, "childlayout")
'	banano.LoadLayout(SHIonBaseElement2.Here, "childlayout")
'	banano.LoadLayout(SHIonBaseElement3.Here, "childlayout")
'	banano.LoadLayout(SHIonBaseElement4.Here, "childlayout")
End Sub