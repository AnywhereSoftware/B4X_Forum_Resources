B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
'Version: 1.0
'Author: Alexander Stolte

#DesignerProperty: Key: View1BackColor, DisplayName: View1 Back Color, FieldType: Color, DefaultValue: 0xFF171C20, Description: Placeholder
#DesignerProperty: Key: View1BorderColor, DisplayName: View1 Border Color, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: Placeholder

#DesignerProperty: Key: View2BackColor, DisplayName: View2 Back Color, FieldType: Color, DefaultValue: 0xFF8D44AD, Description: Placeholder
#DesignerProperty: Key: View2BorderColor, DisplayName: View2 Border Color, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: Placeholder

#DesignerProperty: Key: View3BackColor, DisplayName: View3 Back Color, FieldType: Color, DefaultValue: 0xFF4962A4, Description: Placeholder
#DesignerProperty: Key: View3BorderColor, DisplayName: View3 Border Color, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: Placeholder

#DesignerProperty: Key: Interval, DisplayName: Animation Interval, FieldType: Int, DefaultValue: 500, Description: The Interval of the Animation default is 500

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private xview1,xview2,xview3 As B4XView
	
	
	Private doit As Boolean = False
	
	Private viewbackcolor1,viewbackcolor2,viewbackcolor3 As Int
	Private viewbordercolor1,viewbordercolor2,viewbordercolor3 As Int
	
	Private interval As Int
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
 
	ini_properties(Props)
 
 #If B4A
	Base_Resize(mBase.Width,mBase.Height)
 #End If
 
End Sub

Private Sub ini_properties(Props As Map)
	
	viewbackcolor1 = xui.PaintOrColorToColor(Props.Get("View1BackColor"))
	viewbackcolor2 = xui.PaintOrColorToColor(Props.Get("View2BackColor"))
	viewbackcolor3 = xui.PaintOrColorToColor(Props.Get("View3BackColor"))
	
	viewbordercolor1 = xui.PaintOrColorToColor(Props.Get("View1BorderColor"))
	viewbordercolor2 = xui.PaintOrColorToColor(Props.Get("View2BorderColor"))
	viewbordercolor3 = xui.PaintOrColorToColor(Props.Get("View3BorderColor"))
	
	interval = Props.Get("Interval")
	
End Sub

Private Sub ini_views
	
	xview1 = xui.CreatePanel("")
	xview2 = xui.CreatePanel("")
	xview3 = xui.CreatePanel("")
	
	mBase.AddView(xview1,0,0,0,0)
	mBase.AddView(xview2,0,0,0,0)
	mBase.AddView(xview3,0,0,0,0)
	
	xview1.SetLayoutAnimated(0,0,0,mBase.Width,mBase.Height/2.5)
	xview1.SetColorAndBorder(viewbackcolor1,5dip,viewbordercolor1,(mBase.Width/2.5)/2)
	
	xview2.SetLayoutAnimated(0,mBase.Width - mBase.Width/2.5,mBase.Height - mBase.Height/2.5,mBase.Width/2.5,mBase.Height/2.5)
	xview2.SetColorAndBorder(viewbackcolor2,5dip,viewbordercolor2,(mBase.Width/2.5)/2)
	
	xview3.SetLayoutAnimated(0,0,mBase.Height - mBase.Height/2.5,mBase.Width/2.5,mBase.Height/2.5)
	xview3.SetColorAndBorder(viewbackcolor3,5dip, viewbordercolor3,(mBase.Width/2.5)/2)
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
	If xview1.IsInitialized = False Then
		
		ini_views
		
	End If
  
  
  
End Sub

#Region Properties

Public Sub setView1BackColor(color As Int)
	
	viewbackcolor1 = color
	
End Sub

Public Sub getView1BackColor As Int
	
	Return viewbackcolor1
	
End Sub

Public Sub setView2BackColor(color As Int)
	
	viewbackcolor2 = color
	
End Sub

Public Sub getView2BackColor As Int
	
	Return viewbackcolor2
	
End Sub

Public Sub setView3BackColor(color As Int)
	
	viewbackcolor3 = color
	
End Sub

Public Sub getView3BackColor As Int
	
	Return viewbackcolor3
	
End Sub


Public Sub setView1BorderColor(color As Int)
	
	viewbordercolor1 = color
	
End Sub

Public Sub getView1BorderColor As Int
	
	Return viewbordercolor1
	
End Sub

Public Sub setView2BorderColor(color As Int)
	
	viewbordercolor2 = color
	
End Sub

Public Sub getView2BorderColor As Int
	
	Return viewbordercolor2
	
End Sub

Public Sub setView3BorderColor(color As Int)
	
	viewbordercolor3 = color
	
End Sub

Public Sub getView3BorderColor As Int
	
	Return viewbordercolor3
	
End Sub

Public Sub setInterval(xinterval As Int)
	
	interval = xinterval
	
End Sub

Public Sub getInterval As Int
	
	Return interval
	
End Sub

#End Region

Public Sub Start
	
	doit = True
	Animation
	
End Sub

Public Sub Stop
	
	doit = True
	
	
End Sub

Public Sub Show
	
	mBase.Visible = True
	
End Sub

Public Sub Hide
	
	mBase.Visible = False
	
End Sub

Public Sub getBaseView As B4XView
	
	Return mBase
	
End Sub

'https://www.uplabs.com/posts/loading-icon-9baf397f-cf16-4438-b03f-6aed4edaa833
Private Sub Animation
	
	Do While doit = True
	
	'idle
		xview1.SetLayoutAnimated(interval,0,0,mBase.Width,mBase.Height/2.5)
	xview1.SetColorAndBorder(viewbackcolor1,5dip,viewbordercolor1,(mBase.Width/2.5)/2)
	
		xview2.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,mBase.Height - mBase.Height/2.5,mBase.Width/2.5,mBase.Height/2.5)
	xview2.SetColorAndBorder(viewbackcolor2,5dip,viewbordercolor2,(mBase.Width/2.5)/2)
	
		xview3.SetLayoutAnimated(interval,0,mBase.Height - mBase.Height/2.5,mBase.Width/2.5,mBase.Height/2.5)
	xview3.SetColorAndBorder(viewbackcolor3,5dip, viewbordercolor3,(mBase.Width/2.5)/2)
	
	Sleep(interval)
	'1 step
	xview1.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,0,mBase.Width/2.5,mBase.Height/2.5)
	xview1.SetColorAndBorder(viewbackcolor1,5dip,viewbordercolor1,(mBase.Width/2.5)/2)
	
	xview2.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,mBase.Height - mBase.Height/2.5,mBase.Width/2.5,mBase.Height/2.5)
	xview2.SetColorAndBorder(viewbackcolor2,5dip,viewbordercolor2,(mBase.Width/2.5)/2)
	
	xview3.SetLayoutAnimated(interval,0,0,mBase.Width/2.5,mBase.Height)
	xview3.SetColorAndBorder(viewbackcolor3,5dip, viewbordercolor3,(mBase.Width/2.5)/2)

	Sleep(interval)
'	'2 step
	xview1.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,0,mBase.Width/2.5,mBase.Height/2.5)
	xview1.SetColorAndBorder(viewbackcolor1,5dip,viewbordercolor1,(mBase.Width/2.5)/2)
	
	xview2.SetLayoutAnimated(interval,0,mBase.Height - mBase.Height/2.5,mBase.Width,mBase.Height/2.5)
	xview2.SetColorAndBorder(viewbackcolor2,5dip,viewbordercolor2,(mBase.Width/2.5)/2)
	
	xview3.SetLayoutAnimated(interval,0,0,mBase.Width/2.5,mBase.Height/2.5)
	xview3.SetColorAndBorder(viewbackcolor3,5dip,viewbordercolor3,(mBase.Width/2.5)/2)
	
	Sleep(interval)
	'3 step
	xview1.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,0,mBase.Width/2.5,mBase.Height)
	xview1.SetColorAndBorder(viewbackcolor1,5dip,viewbordercolor1,(mBase.Width/2.5)/2)
	
	xview2.SetLayoutAnimated(interval,0,mBase.Height - mBase.Height/2.5,mBase.Width/2.5,mBase.Height/2.5)
	xview2.SetColorAndBorder(viewbackcolor2,5dip,viewbordercolor2,(mBase.Width/2.5)/2)
	
	xview3.SetLayoutAnimated(interval,0,0,mBase.Width/2.5,mBase.Height/2.5)
	xview3.SetColorAndBorder(viewbackcolor3,5dip,viewbordercolor3,(mBase.Width/2.5)/2)
	
	Sleep(interval)
	'4 step
	xview1.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,mBase.Height - mBase.Height/2.5,mBase.Width/2.5,mBase.Height/2.5)
	xview1.SetColorAndBorder(viewbackcolor1,5dip,viewbordercolor1,(mBase.Width/2.5)/2)
	
	xview2.SetLayoutAnimated(interval,0,mBase.Height - mBase.Height/2.5,mBase.Width/2.5,mBase.Height/2.5)
	xview2.SetColorAndBorder(viewbackcolor2,5dip,viewbordercolor2,(mBase.Width/2.5)/2)
	
	xview3.SetLayoutAnimated(interval,0,0,mBase.Width,mBase.Height/2.5)
	xview3.SetColorAndBorder(viewbackcolor3,5dip,viewbordercolor3,(mBase.Width/2.5)/2)
	
	Sleep(interval)
	'5 step
	xview1.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,mBase.Height - mBase.Height/2.5,mBase.Width/2.5,mBase.Height/2.5)
	xview1.SetColorAndBorder(viewbackcolor1,5dip,viewbordercolor1,(mBase.Width/2.5)/2)
	
	xview2.SetLayoutAnimated(interval,0,0,mBase.Width/2.5,mBase.Height)
	xview2.SetColorAndBorder(viewbackcolor2,5dip,viewbordercolor2,(mBase.Width/2.5)/2)
	
	xview3.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,0,mBase.Width/2.5,mBase.Height/2.5)
	xview3.SetColorAndBorder(viewbackcolor3,5dip,viewbordercolor3,(mBase.Width/2.5)/2)
	
	Sleep(interval)
	'6 step
	xview1.SetLayoutAnimated(interval,0,mBase.Height - mBase.Height/2.5,mBase.Width,mBase.Height/2.5)
	xview1.SetColorAndBorder(viewbackcolor1,5dip,viewbordercolor1,(mBase.Width/2.5)/2)
	
	xview2.SetLayoutAnimated(interval,0,0,mBase.Width/2.5,mBase.Height/2.5)
	xview2.SetColorAndBorder(viewbackcolor2,5dip,viewbordercolor2,(mBase.Width/2.5)/2)
	
	xview3.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,0,mBase.Width/2.5,mBase.Height/2.5)
	xview3.SetColorAndBorder(viewbackcolor3,5dip,viewbordercolor3,(mBase.Width/2.5)/2)
	
	Sleep(interval)
	'8 step
	xview1.SetLayoutAnimated(interval,0,mBase.Height - mBase.Height/2.5,mBase.Width/2.5,mBase.Height/2.5)
	xview1.SetColorAndBorder(viewbackcolor1,5dip,viewbordercolor1,(mBase.Width/2.5)/2)
	
	xview2.SetLayoutAnimated(interval,0,0,mBase.Width/2.5,mBase.Height/2.5)
	xview2.SetColorAndBorder(viewbackcolor2,5dip,viewbordercolor2,(mBase.Width/2.5)/2)
	
	xview3.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,0,mBase.Width/2.5,mBase.Height)
	xview3.SetColorAndBorder(viewbackcolor3,5dip,viewbordercolor3,(mBase.Width/2.5)/2)
	
	Sleep(interval)
	'9 step
	xview1.SetLayoutAnimated(interval,0,mBase.Height - mBase.Height/2.5,mBase.Width/2.5,mBase.Height/2.5)
	xview1.SetColorAndBorder(viewbackcolor1,5dip,viewbordercolor1,(mBase.Width/2.5)/2)
	
	xview2.SetLayoutAnimated(interval,0,0,mBase.Width,mBase.Height/2.5)
	xview2.SetColorAndBorder(viewbackcolor2,5dip,viewbordercolor2,(mBase.Width/2.5)/2)
	
	xview3.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,mBase.Height - mBase.Height/2.5,mBase.Width/2.5,mBase.Height/2.5)
	xview3.SetColorAndBorder(viewbackcolor3,5dip,viewbordercolor3,(mBase.Width/2.5)/2)
	
	Sleep(interval)
	'10. step
	xview1.SetLayoutAnimated(interval,0,0,mBase.Width/2.5,mBase.Height)
	xview1.SetColorAndBorder(viewbackcolor1,5dip,viewbordercolor1,(mBase.Width/2.5)/2)
	
	xview2.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,0,mBase.Width/2.5,mBase.Height/2.5)
	xview2.SetColorAndBorder(viewbackcolor2,5dip,viewbordercolor2,(mBase.Width/2.5)/2)
	
	xview3.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,mBase.Height - mBase.Height/2.5,mBase.Width/2.5,mBase.Height/2.5)
	xview3.SetColorAndBorder(viewbackcolor3,5dip,viewbordercolor3,(mBase.Width/2.5)/2)
	
	Sleep(interval)
	'11. step
	xview1.SetLayoutAnimated(interval,0,0,mBase.Width/2.5,mBase.Height/2.5)
	xview1.SetColorAndBorder(viewbackcolor1,5dip,viewbordercolor1,(mBase.Width/2.5)/2)
	
	xview2.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,0,mBase.Width/2.5,mBase.Height/2.5)
	xview2.SetColorAndBorder(viewbackcolor2,5dip,viewbordercolor2,(mBase.Width/2.5)/2)
	
	xview3.SetLayoutAnimated(interval,0,mBase.Height - mBase.Height/2.5,mBase.Width,mBase.Height/2.5)
	xview3.SetColorAndBorder(viewbackcolor3,5dip,viewbordercolor3,(mBase.Width/2.5)/2)
	
	Sleep(interval)
	'12. step
	xview1.SetLayoutAnimated(interval,0,0,mBase.Width/2.5,mBase.Height/2.5)
	xview1.SetColorAndBorder(viewbackcolor1,5dip,viewbordercolor1,(mBase.Width/2.5)/2)
	
	xview2.SetLayoutAnimated(interval,mBase.Width - mBase.Width/2.5,0,mBase.Width/2.5,mBase.Height)
	xview2.SetColorAndBorder(viewbackcolor2,5dip,viewbordercolor2,(mBase.Width/2.5)/2)
	
	xview3.SetLayoutAnimated(interval,0,mBase.Height - mBase.Height/2.5,mBase.Width/2.5,mBase.Height/2.5)
	xview3.SetColorAndBorder(viewbackcolor3,5dip,viewbordercolor3,(mBase.Width/2.5)/2)
	Sleep(interval)
	
	
	Loop
	
End Sub

