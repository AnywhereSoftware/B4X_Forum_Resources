B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@
' #################################################################
' vertical and horizontal scrollable Panel
' #################################################################
' Name:			TD_SwipePanel
' Version:		1.1
' Filename:		TD_SwipePanel.bas (TD_SwipePanel.b4xlib)
' Dev State:	(x)WIP ()Rel
' Type:			()Activity ()B4XPage ()Class ()Mod (X)CustView XUI
' -----------------------------------------------------------------
' Libs:			XUI,ScrollView2D
' Classes:		-
' Modules:		-
' Layouts:		-
' Files:		
' -----------------------------------------------------------------
' Devloper/s:	G. Becker
' -----------------------------------------------------------------
'' #################################################################
' (C) TechDoc G. Becker | https://www.gbecker.de
' Licence: 
' Royalty Free for Private and Commercial Usage ONLY for
' B4X Anywhere licensed Members.
' #################################################################

#region Links
' tested: Name:G. Becker / 2023/10/31
' Ctrl + click to build b4xlib: ide://run?file=%JAVABIN%\jar.exe&WorkingDirectory=%PROJECT%\..&Args=-cMf&Args=%PROJECT_NAME%.b4xlib&&Args=..&Args=*.bas&Args=manifest.txt
#end region

' #################################################################

#region Designer Custom Properties
' tested: Name:G. Becker / 2023/11/13
#DesignerProperty: Key: layout, DisplayName: Layout Filename, FieldType: string, DefaultValue:
#DesignerProperty: Key: oversize, DisplayName: Oversize, FieldType: Int, max: 10, min: 0, DefaultValue: 1, Description: Value is in 1/10%
#end region

' #################################################################

#region Custom Events
' tested: Name:G. Becker / 2023/11/13
#Event: ScrollChanged(PosX As Int, PosY As Int)
#end region

' #################################################################

#region Globals
' tested: Name:G. Becker / 2023/11/13
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Public XScrollView As ScrollView2D
	Private mprops As Map
End Sub

' tested: Name:G. Becker / 2023/11/13
Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub
#end region

' #################################################################

#region basic
' tested: Name:G. Becker / 2023/11/13
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me
	
	mprops = Props
	
	' Initialize scrollview
	XScrollView.Initialize(mBase.width,mBase.height,"XScrollview")
	If Props.get("layout") <> "" Then setLayoutFile(Props.get("layout"))
	' Add scrollview to base
	mBase.AddView(XScrollView,0,0,mBase.width,mBase.height)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub
#end region

' #################################################################

#region custom properties
' tested: Name:G. Becker / 2023/11/13
public Sub setLayoutFile(Layout As String)
	Try
		' load layout
		Sleep(0)
		XScrollView.Panel.RemoveAllViews
		XScrollView.panel.LoadLayout(Layout)
		' compute needed area to show all child views	
		Dim w,h As Int
		For Each v As Object In XScrollView.panel.getallviewsrecursive	
			If v.As(View).Left + v.As(View).Width > w Then w = v.As(View).Left + v.As(View).Width
			If v.As(View).Top + v.As(View).Height > h Then h = v.As(View).Top + v.As(View).Height
		Next
		w = w + w *	mprops.get("oversize")/100
		h = h + h *	mprops.get("oversize")/100
		XScrollView.panel.Width = w 
		XScrollView.panel.height = h
	Catch
		Log(LastException)
	End Try
End Sub
#end region

#region Custom Events
' tested: Name:G. Becker / 2023/11/13
Private Sub XScrollView_ScrollChanged(PosX As Int, PosY As Int)
	If SubExists(mCallBack, mEventName & "_ScrollChanged") Then
		CallSub3(mCallBack, mEventName & "_ScrollChanged",PosX,PosY)
	End If
End Sub
#end region
' #################################################################
' Version 1/2023
' #################################################################

