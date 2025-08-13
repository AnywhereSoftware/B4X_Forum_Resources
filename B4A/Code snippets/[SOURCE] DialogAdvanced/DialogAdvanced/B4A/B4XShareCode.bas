B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=11.8
@EndOfDesignText@
'Author: T201016
'Code module Version 1.01
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	
End Sub

Public Sub SetScrollbarColor(sv As ScrollView, clr As Int)
	Dim r As Reflector
	r.Target = sv
	r.Target = r.GetField("mScrollCache")
	r.Target = r.GetField("scrollBar")
	Dim cd As ColorDrawable
	cd.Initialize(clr, 5dip)
	r.RunMethod4("setVerticalThumbDrawable", Array(cd), Array As String("android.graphics.drawable.Drawable"))
End Sub

Public Sub YourMailValid(New As String) As Boolean
	Dim VMail As Boolean = Regex.IsMatch("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", New)
	Dim Valid As Boolean = New.Length > 0 And VMail
	Return Valid ' Valid Email Address.
End Sub

Public Sub MeasureTextWidth(t As String, f As B4XFont) As Float
	Dim cvs As B4XCanvas
	Dim p As B4XView = B4XPages.MainPage.xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 2dip, 2dip)
	cvs.Initialize(p)
	Dim Width As Float = cvs.MeasureText(t, f).Width
	Return Width
End Sub