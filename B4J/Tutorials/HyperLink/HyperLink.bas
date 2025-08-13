B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Custom View class
#Event: Clicked (link As String)
#DesignerProperty: Key: Text, DisplayName: Text, FieldType: String, DefaultValue: Text
#DesignerProperty: Key: Link, DisplayName: Link, FieldType: String, DefaultValue: Link
#DesignerProperty: Key: Color, DisplayName: Color, FieldType: Color, DefaultValue: 0xFF0000FF, Description: You can use the built-in color picker to find the color values.
Sub Class_Globals
	Private fx As JFX
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As Pane
	Private mHyperLink As JavaObject
	Private mLink As String
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	mHyperLink.InitializeNewInstance("javafx.scene.control.Hyperlink",Null)
End Sub

Public Sub DesignerCreateView (Base As Pane, Lbl As Label, Props As Map)
	mBase = Base
	mBase.AddNode(mHyperLink,0,0,-1,-1)
	mHyperLink.RunMethod("setText",Array(Props.GetDefault("Text","")))
	Dim event As Object = mHyperLink.CreateEvent("javafx.event.EventHandler","HyperlinkClicked","")
	mHyperLink.RunMethod("setOnAction",Array(event))
	mLink = Props.GetDefault("Link","")
	mHyperLink.RunMethod("setUnderline",Array(True))
	CSSUtils.SetStyleProperty(mHyperLink,"-fx-border-width",0)
	Dim color As String = Props.Get("Color")
	CSSUtils.SetStyleProperty(mHyperLink,"-fx-text-fill",color.Replace("0x","#"))
End Sub

Public Sub HyperLinkClicked_Event (MethodName As String, Args() As Object) As Object			'ignore
	mHyperLink.RunMethod("setVisited",Array(False))
	If SubExists(mCallBack,mEventName & "_Clicked") Then
		CallSub2(mCallBack,mEventName & "_Clicked",mLink)
	End If
	fx.ShowExternalDocument(mLink)
End Sub

Public Sub setColor(color As Paint)
	Dim rgba() As Int = GetRGBA(fx.Colors.To32Bit(color))
	Dim r As Int = rgba(0)
	Dim g As Int = rgba(1)
	Dim b As Int = rgba(2)
	Dim a As Double = rgba(3)/255
	Dim value As String = $"rgba(${r},${g},${b},${a})"$
	CSSUtils.SetStyleProperty(mHyperLink,"-fx-text-fill",value)
End Sub

private Sub GetRGBA(Color As Int) As Int()
	Dim res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(2) = Bit.And(Color, 0xff)
	res(3) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	Return res
End Sub

Public Sub setText(text As String)
	mHyperLink.RunMethod("setText",Array(text))
End Sub

Public Sub getText
	mHyperLink.RunMethod("getText",Null)
End Sub

Public Sub getLink As String
	Return mLink
End Sub

Public Sub setLink(Link As String)
	mLink = Link
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)

End Sub

Public Sub GetBase As Pane
	Return mBase
End Sub
