B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFF0000, Description: Text color

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private Vl As Int = 0
	Private Spessore As Int = 4dip
	Private clr As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mBase.Color=xui.Color_Transparent
	clr = xui.PaintOrColorToColor(Props.Get("TextColor")) 'Example of getting a color value from Props
	Invalidate
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	Invalidate
End Sub

' Set 0..100
Public Sub setValue(V As Int)
	Vl=Min(V,100)
	Invalidate
End Sub

Public Sub  getValue As Int
	Return Vl
End Sub

Public Sub Invalidate
	Dim Can As B4XCanvas
	
	mBase.Color=xui.Color_Transparent
	mBase.RemoveAllViews
	Can.Initialize(mBase)
	Dim Width As Int = Can.TargetView.Width-(2*Spessore)
	Dim Height As Int = Can.TargetRect.Height-(2*Spessore)
	
	Dim Rec As B4XRect
	Rec.Initialize(Spessore,Spessore,Width,Height)
	Dim Path As B4XPath
	Path.InitializeRoundedRect(Rec,Height/2)
	Can.DrawPath(Path,clr,False,Spessore/2)
	Can.ClipPath(Path)
	Rec.Initialize(Spessore,Spessore,Width*(Vl/100),Height)
	Can.DrawRect(Rec,clr,True,Spessore)
	
	If Starter.Colore = "Yellow" Then
		clr = xui.PaintOrColorToColor(xui.Color_Yellow) 'Example of getting a color value from Props
	Else If Starter.Colore = "Green" Then
		clr = xui.PaintOrColorToColor(xui.Color_Green) 'Example of getting a color value from Props
	Else If Starter.Colore = "Red" Then
		clr = xui.PaintOrColorToColor(xui.Color_Red) 'Example of getting a color value from Props
	End If
	
	Can.Invalidate
	Can.Release
End Sub