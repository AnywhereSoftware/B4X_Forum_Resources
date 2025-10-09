B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'############################################################
'#  MenuBar Extended
'############################################################
'# Name:		GBEMenuBar
'# Type:		Custom View (XUI) Class or b4xlib
'# Version:		1.2
'# Language:	B4J
'# Moduls:		-
'# Classes:		-
'# Libs:		JAudioClip-b4xlib, JavaObject, jFX, jReflection,jXUI
'# Files:		infobleep-87963.mp3 (pixabay.com)
'#				MyMenu.txt, MyMenu.css
'# ###########################################################
'# (C):				Günter Becker, Anwhere licensed B4X Developer
'# Royalty Free:	audio files pixabay.com
'#############################################################
#region Changes
'Version 1.0 2025/10 Final
'Version 1.1 2025/10 Beep added, Title-Click added
'Version 1.2
'Shortcut ctrl+key or alt+key / setGUI / TooltipTtext / actbeep
'setBadge / removeMenu / removeMenuItem
'Designer Property: css File
#end region
'#############################################################
#region Custom Designer Properties
#DesignerProperty: Key:css , DisplayName:css File, FieldType: string, List:MyMenuSolid|MyMenuShaded, DefaultValue: MyMenuSolid, Description: no extension!
#end region
'#############################################################

#region Custom Events
#Event: ItemClicked(ID as string)
#Event: MenuClicked(ID as string)
#end region
'#############################################################
#region CustomView
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private fx As JFX
	
	Private badger1 As Badger 
	Public Menubar As MenuBar
	Public actBeep As Boolean = False
	Private mprops As Map
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	Menubar.Initialize("MBar")
	badger1.initialize
	mprops.initialize
End Sub
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	mprops = Props
  	Menubar.PrefWidth=mBase.width
  	Menubar.PrefHeight = mBase.height	
	mBase.AddView(Menubar,0,0,mBase.Width,mBase.Height)
	Menubar.TooltipText = Lbl.TooltipText
	
	'# MainForm must be declared as Public!
	If Props.Get("css") <> "" Then
		Main.MainForm.Stylesheets.Add(File.GetUri(File.Dirassets,Props.Get("css") & ".css"))
	End If
	
End Sub
Private Sub Base_Resize (Width As Double, Height As Double)
	Menubar.PrefWidth=mBase.width
	Menubar.PrefHeight = mBase.height
End Sub
#end region
'#############################################################
#region Custom properties
'##	Function:	Load Menu structure Text File
'##				Build Menu
'## Parameter:	Filename in DirAssets
'## Tested:		2025/10
public Sub LoadMenu(Filename As String)
	Try
		Dim l As List: l.initialize
		l=File.ReadList(File.DirAssets,Filename)
		Menubar.Menus.Clear		
		For x = 0 To l.Size-1
			If l.Get(x).As(String).StartsWith("#") = False Then '# jump over comment
				' 0 ID, 1 ParentID, 2 ShortCut, 3 Text, 4 IconFile, 5 IconWidtzh, 6 IconHeight
				Dim s() As String = Regex.Split(",",l.Get(x))
				If s.Length = 7 Then ' description has always 7 parts
					If s(1) = "" And s(2).ToLowerCase <> "separator" Then
						AddMenu(s(0),s(3),s(4),s(5),s(6))
					Else if s(0) <> "" Then
						AddMenuItem(s(0),s(1),s(3),s(2),s(4),s(5),s(6))
					End If
				End If
			End If
		Next
	Catch
		Log(LastException)
	End Try
End Sub
'##	Function:	Ad main Menu item
'## Parameter:
'## 			ID ID of the Menu
'##				Text Menutext
'##				Icon Menu Icon Filename
'## Tested:		2025/10
public Sub AddMenu(ID As String, Text As String, Icon As String,IconWidth As Int,IconHeight As Int)
	Dim mnu As Menu
	mnu.Initialize(Text,"")
	mnu.Tag = ID
	Menubar.Menus.Add(mnu)
	If Icon <> "" Then PlaceIcon(mnu,Icon,IconWidth,IconHeight)
End Sub
'##	Function:	remove Menu
'## Parameter:	IDt
'## Tested:	2025/10
public Sub removeMenu(ID As String)
	Dim mn As Menu = getItem(ID)
	For x = 0 To Menubar.Menus.Size-1
		Dim mn As Menu = Menubar.Menus.Get(x)
		If mn.Tag=ID Then
			Menubar.Menus.RemoveAt(x)
			Exit
		End If
	Next
End Sub
'##	Function:	Ad sub Menu item
'## Parameter:
'## 0 ID, 1 ParentID, 2 ShortCut, 3 Text, 4 IconFile, 5 IconWidtzh, 6 IconHeight
'## Tested:	2025/10
public Sub AddMenuItem(ID As String, ParentID As String, ShortCut As String, _
	Text As String,Icon As String,IconWidth As Int,IconHeight As Int)
	For x = 0 To Menubar.Menus.Size-1
		Dim mn As Menu = Menubar.Menus.Get(x)
		If mn.Tag = ParentID Then
				If ID.ToLowerCase = "separator" Then
					Dim mi As MenuItem = PlaceSeperator
					mn.MenuItems.Add(mi)
				Else
					Dim mi As MenuItem
					mi.Initialize(Text,"Menu")
					If Icon <> "" Then
						mi.Image = fx.LoadImageSample(File.dirassets,Icon,IconWidth,IconHeight)
					End If
					mi.Tag = ID
					mi.Text=Text			
					If ShortCut <> "" Then PlaceShortCut(mi,ShortCut.ToUpperCase)
					mn.MenuItems.Add(mi)
				End If
			Exit
		End If
	Next
End Sub
'##	Function:	remove Menu
'## Parameter:	IDt
'## Tested:	2025/10
public Sub removeMenuItem(ID As String)
	Dim mn As Menu = getItem(ID)
	For x = 0 To Menubar.Menus.Size-1
		Dim mn As Menu = Menubar.Menus.Get(x)
		For y = 0 To mn.MenuItems.Size-1
			Dim mi As MenuItem = mn.menuitems.get(x)
			If mi.Tag= ID Then
				mn.menuitems.RemoveAt(y)
				Exit
			End If
		Next
	Next
End Sub
'##	Function:	enabled/disable sub Menu item
'## Tested:		2025/10
public Sub enableMenuItem(ID As String,Enabled As Boolean)
	If getItem(ID) Is MenuItem Then
		Dim mi As MenuItem = getItem(ID)
		mi.ENABLED = Enabled
	End If
End Sub
'##	Function:	show/hide sub Menu item
'## Parameter:	ID MenuItem, Hidden True/False
'## Tested:		2025/10
public Sub hideMenuItem(ID As String, Hidden As Boolean)
	If getItem(ID) Is MenuItem Then
		Dim mi As MenuItem = getItem(ID)
		mi.visible =Not(Hidden)
	End If
End Sub

'##	Function:	set or update Badge on Menubar
'## Tested:		2025/10
public Sub setBadge(Value As Int,CX As Int, CY As Int,col As Int)
	badger1.SetBadge(Menubar.As(Node),Value,CX,CY,col)
End Sub
'##	Function:	localize Menu
'## Tested:		2025/10
public Sub locMenu(ID As String, Text As String)
	Dim o As Object = getItem(ID)
	If o <> Null Then
		If o Is Menu Then
			o.As(Menu).Text = Text
		else if o Is MenuItem Then
			o.As(MenuItem).Text = Text
		End If
	End If
End Sub
'##	Function:	gete menubar item by id
'## Tested:		2025/10
private Sub getItem(ID As String) As Object
	For Each mn As Menu In Menubar.menus
		If mn.Tag = ID Then Return mn
		For Each mi As MenuItem In mn.MenuItems
			If mi.Tag=ID Then Return mi
		Next
	Next
	Return Null
End Sub
'##	Function:	Custom Event MenuItem clicked
'## Parameter:	Returned Menu ID
'## Tested:		2025/10
private Sub Menu_Action
	If actBeep Then doBeep
	If SubExists(mCallBack, mEventName & "_ItemClicked") Then
		Dim mi As MenuItem = Sender
		CallSub2(mCallBack, mEventName & "_ItemClicked",mi.tag)
	End If
End Sub
'##	Function:	Ad icon to Menu
'## Parameter:	mi Menu, Icon Filename
private Sub PlaceIcon(Mn As Menu, Icon As String,iconWidth As Int, IconHeight As Int)	
	Dim jo As JavaObject = Mn
	Dim imv As ImageView
	imv.Initialize("MnuTitle")
	imv.SetImage(fx.LoadImageSample(File.DirAssets,Icon,iconWidth,IconHeight))
	jo.RunMethod("setGraphic",Array(imv))
	
	'# Add Menu clickevent
	Dim theMenu As JavaObject = Mn ' this bit was mi	ssing
	Dim e As Object = theMenu.CreateEvent("javafx.event.EventHandler","menuTitleClick",False)
	theMenu.RunMethod("setOnShowing",Array(e))
End Sub
'##	Function:	Event TitleClick to menu item
'## Parameter:	mi Menu, Icon Filename
private Sub menuTitleClick_Event(MethodName As String, Args() As Object)
	If actBeep Then doBeep
	If SubExists(mCallBack, mEventName & "_MenuClicked") Then
		Dim Mn As Menu = Sender
		CallSub2(mCallBack, mEventName & "_MenuClicked",Mn.tag)
	End If
End Sub
#end region
'#############################################################
#region helpers
'##	Function:	Ad Seperator to Menu
'## Parameter:	mn Menu
private Sub PlaceSeperator As MenuItem
	Dim TJO As JavaObject
	TJO.InitializeNewInstance("javafx.scene.control.SeparatorMenuItem",Null)
	Return TJO
End Sub
'##	Function:	Add shortcut to Menu item
'## Parameter: 	mi MenuItem, SC schrotcut key
private Sub PlaceShortCut(Mi As JavaObject, SC As String)
		SC=SC.ToLowerCase
	If SC.ToLowerCase.Contains("ctrl+") Or SC.ToLowerCase.Contains("alt+") Then
		Dim KC As JavaObject
		Dim combination(2) As String
		If SC.ToUpperCase.Contains("alt") Then
			combination(0) = "Alt"
			SC = SC.Replace("alt+","")
		Else
			combination(0) = "Ctrl"
			SC = SC.Replace("ctrl+","")
		End If
		combination(1) = SC.ToLowerCase
		KC.InitializeStatic("javafx.scene.input.KeyCombination")
		Dim KCS As String
		For i = 0 To combination.Length - 1
			If i > 0 Then KCS = KCS & "+"
			KCS = KCS & combination(i)
		Next
		Mi.RunMethod("setAccelerator",Array(KC.RunMethod("keyCombination",Array(KCS))))
	End If
End Sub

'## Function:	Play Beep Sound
'## Parameter:	1 beep, 2 smooth beep, 3 alarm
'##(C)			Royalty free from pixabay.com
'## Tested:		2025/07
private Sub doBeep
	Dim whistle As AudioClip
	whistle.initialize
	whistle.Create2(File.DirAssets,"infobleep-87963.mp3")
	whistle.Play2(.35)
End Sub
#end region
'#############################################################
