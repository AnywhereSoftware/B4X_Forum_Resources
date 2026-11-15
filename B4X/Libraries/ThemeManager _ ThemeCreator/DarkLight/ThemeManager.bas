B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=14.2
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Public CurrentTheme As String
	Public ColorsMap As Map
	Public Pages As List
	#if B4A
	Private TopBar, BottomBar As B4XView
	Private ime As IME
	#end if
End Sub

Public Sub Initialize (Theme As String)
	#if B4A
	ime.Initialize("")
	#end if
	Pages.Initialize
	SetTheme(Theme)
End Sub

Public Sub RegisterPage(page As Object)
	Pages.Add(page)
	CallSub(page, "ResetLayout")
End Sub

Public Sub SetTheme(Theme As String)
	CurrentTheme = Theme
	ColorsMap = File.ReadString(File.DirAssets, "colors.json").As(JSON).ToMap.Get(CurrentTheme)
	#if B4A
	Dim p As Phone
	If p.SdkVersion >= 30 Then
		Dim jo As JavaObject
		jo.InitializeContext
		Dim window As JavaObject = jo.RunMethod("getWindow", Null)
		Dim controller As JavaObject = window.RunMethod("getInsetsController", Null)
		controller.RunMethod("setSystemBarsAppearance", Array(IIf(CurrentTheme = "light", 0, 24), 24))
	End If
	#end if
	For Each page As Object In Pages
		CallSub(page, "ResetLayout")
	Next
End Sub

Public Sub LayoutName(Layout As String) As String
	Return "_" & Layout & "_" & CurrentTheme
End Sub

'Sets the colors of the top and bottom bars. Should only be called from B4XMainPage.
Public Sub SetBars(BackgroundColorName As String, ArrowIndicatorColor As String)
	Dim clr As Int = ColorFromMap(BackgroundColorName)
	#if B4A
	If NotInitialized(TopBar) Then
		TopBar = xui.CreatePanel("")
		Dim act As Activity = B4XPages.GetNativeParent(B4XPages.MainPage) 'Activity with non-B4XPages
		Dim r As Rect = ime.GetContentRect
		act.AddView(TopBar, 0, 0, act.Width, r.Top)
		BottomBar = xui.CreatePanel("")
		act.AddView(BottomBar, 0, r.Bottom, act.Width, act.Height - r.Bottom)
	End If
	TopBar.Color = clr
	BottomBar.Color = clr
	SetActionBarArrowColor(ColorFromMap(ArrowIndicatorColor))
	#Else if B4i
	If Main.App.KeyController Is NavigationController Then
		Dim no As NativeObject = Main.App.KeyController
		no.GetField("navigationBar").RunMethod("setBarTintColor:", Array(no.ColorToUIColor(clr)))
		no.GetField("view").As(View).Color = clr
		no.GetField("navigationBar").RunMethod("setTintColor:", Array(no.ColorToUIColor(clr)))
	End If
'	Dim no As NativeObject = App
'	no.RunMethod("setStatusBarStyle:", Array(1))
'	SetTitleColor(Nav, Colors.White)
'	Dim no As NativeObject = NavControl
	#end if
End Sub

Public Sub SetTitle(Page As Object, TitleColorName As String, Title As String)
	Dim pi As B4XPageInfo = B4XPages.GetManager.FindPIFromB4XPage(Page)
	#if B4A
	Dim cs As CSBuilder
	cs.Initialize.Color(ColorFromMap(TitleColorName)).Append(Title).PopAll
	#else if B4i
	Dim cs As String = Title
	Dim attributes As NativeObject
	attributes = attributes.Initialize("B4IAttributedString").RunMethod("createAttributes::", _
     Array(Font.CreateNew(18), attributes.ColorToUIColor(ColorFromMap(TitleColorName))))
	Dim no As NativeObject = Main.App.KeyController
	no.GetField("navigationBar").RunMethod("setTitleTextAttributes:", Array(attributes))
	#Else if B4J 
	Dim CS As String = Title
	#End If
	pi.Title = CS
	Dim TopPage As B4XPageInfo = B4XPages.GetManager.GetTopPage
	If Initialized(TopPage) And TopPage.B4XPage = Page Then
		B4XPages.SetTitle(Page, CS)
	End If
End Sub

'Returns the color value from the current theme map.
Public Sub ColorFromMap(Name As String) As Int
	Dim s As String = ColorsMap.Get(Name)
	If s.StartsWith("#") Then s = s.SubString(1)
	If s.Length = 6 Then s = "FF" & s
	Return Bit.ParseLong(s, 16)
End Sub

#if B4A
Public Sub SetBackgroundTintList(View As View, Active As String, Enabled As String)
	Dim States(2,1) As Int
	States(0,0) = 16842908     'Active
	States(1,0) = 16842910    'Enabled
	Dim Color(2) As Int = Array As Int(ColorFromMap(Active), ColorFromMap(Enabled))
	Dim CSL As JavaObject
	CSL.InitializeNewInstance("android.content.res.ColorStateList",Array As Object(States,Color))
	Dim jo As JavaObject
	jo.InitializeStatic("android.support.v4.view.ViewCompat")
	jo.RunMethod("setBackgroundTintList", Array(View, CSL))
End Sub

Private Sub SetActionBarArrowColor(Color As Int)
	If B4XPages.GetManager.ActionBar.IsInitialized = False Then Return
	Dim attrs As JavaObject
	attrs.InitializeStatic("android.R$attr")
	Dim attrId As Int = attrs.GetField("homeAsUpIndicator")

	Dim context As JavaObject = B4XPages.GetManager.ActionBar.RunMethod("getThemedContext", Null)
	Dim ta As JavaObject = context.RunMethod("obtainStyledAttributes", _
        Array(Array As Int(attrId)))
	Dim drawable As JavaObject = ta.RunMethod("getDrawable", Array(0))
	ta.RunMethod("recycle", Null)
	If drawable.IsInitialized = False Then Return

	drawable = drawable.RunMethod("mutate", Null)
	drawable.RunMethod("setTint", Array(Color))
	B4XPages.GetManager.ActionBar.RunMethod("setHomeAsUpIndicator", Array(drawable))
End Sub
#end if

#if B4J 
'Returns a hex color that cn be used with CSSUtils.
Public Sub CSSColorFromMap(Name As String) As String
	Dim fx As JFX
	Return CSSUtils.ColorToHex(fx.Colors.From32Bit(ColorFromMap(Name)))
End Sub
#End If