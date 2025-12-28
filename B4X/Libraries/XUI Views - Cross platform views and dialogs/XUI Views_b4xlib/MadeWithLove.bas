B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 
	Private xui As XUI 'ignore
	Public Tag As Object
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	Dim xlbl As B4XView = Lbl
	#if B4J
  	Dim tf As B4JTextFlow
	tf.Initialize
	tf.Append("Made with ")
	tf.SetFont(xlbl.Font)
	tf.SetColor(xlbl.TextColor)
	tf.Append(Chr(0xF004))
	tf.SetFont(xui.CreateFontAwesome(xlbl.TextSize))
	tf.SetColor(xui.Color_Red)
	tf.Append(" in B4X")
	tf.SetFont(xlbl.Font)
	tf.SetColor(xlbl.TextColor)
	mBase.AddView(tf.CreateTextFlow, 0, 0, mBase.Width, mBase.Height)
	#else if B4A
	Dim cs As CSBuilder
	cs.Initialize.Append("Made with ").Typeface(Typeface.FONTAWESOME).Color(xui.Color_Red).Append(Chr(0xF004)).Pop.Pop.Append(" in B4X").PopAll
	xlbl.Text = cs
	xlbl.SetTextAlignment("CENTER", "CENTER")
	mBase.AddView(xlbl, 0, 0, mBase.Width, mBase.Height)
	#else if B4i
	Dim cs As CSBuilder
	cs.Initialize.Append("Made with ").Font(Font.CreateFontAwesome(xlbl.TextSize)).Color(xui.Color_Red).Append(Chr(0xF004)).Pop.Pop.Append(" in B4X").PopAll
	Lbl.AttributedText = cs
	xlbl.SetTextAlignment("CENTER", "CENTER")
	mBase.AddView(xlbl, 0, 0, mBase.Width, mBase.Height)
	#end if
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  	mBase.GetView(0).SetLayoutAnimated(0, 0, 0, Width, Height)
End Sub