B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=13
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
    #IncludeTitle: FALSE
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
Dim xui As XUI

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
    Private btfloating1 As UIBtnFloating
    Private btmenu As UIBtnFloatingExtramenu

    Private btn As UIButton

End Sub

Sub Activity_Create(FirstTime As Boolean)

	' Example: all UI views are added by code in the Activity below
	Activity.Color = Colors.Cyan

    btfloating1.Initialize(Me,"btfloating1")
	btfloating1.AddToParent(Activity,85%x,57%y,6%y,6%y,xui.Color_RGB(99, 160, 180))
	btmenu.Initialize(Me,"btmenu",False,False,True,btfloating1.mBase,Activity)
    btmenu.additemIcon("Create new list",xui.Color_White,14,Chr(0xf14e),xui.CreateDefaultBoldFont(16),xui.Color_White,xui.Color_RGB(143, 145, 206))
    btmenu.additemIcon("New item",xui.Color_White,14,Chr(0xf64f),xui.CreateDefaultBoldFont(16),xui.Color_White,xui.Color_RGB(255, 209, 121))
    btmenu.additemIcon("Clear list",xui.Color_White,14,Chr(0xf6cb),xui.CreateDefaultBoldFont(16),xui.Color_White,xui.Color_RGB(231, 140, 151))
    btmenu.additemIcon("Reload list",xui.Color_White,14,Chr(0xf6af),xui.CreateDefaultBoldFont(16),xui.Color_White,xui.Color_RGB(140, 206, 239))

    btfloating1.Color = xui.Color_RGB(99, 160, 180)
    btfloating1.lcon(xui.CreateFontAwesome(22),Chr(0xF067))
    btfloating1.mBase.BringToFront

    Dim TabMenuAnimated As UITabMenuAnimated
    TabMenuAnimated.Initialize(Me,Activity,5,"menu4",85%y)
    TabMenuAnimated.Add_Menu("menu1",Chr(0xF015),xui.CreateFontAwesome(20),0xFFC95AFC,"Main",TabMenuAnimated.AnimationBlink)
    TabMenuAnimated.Add_Menu("menu2",Chr(0xF17B),xui.CreateFontAwesome(20),0xFF519649,"Android",TabMenuAnimated.AnimationFadeIn)
    TabMenuAnimated.Add_Menu("menu3",Chr(0xF179),xui.CreateFontAwesome(20),0xFF6C6969,"Ios",TabMenuAnimated.AnimationShake)
    TabMenuAnimated.Add_Menu("menu4",Chr(0xF0F3),xui.CreateFontAwesome(20),0xFFF4CF4B,"alerts",TabMenuAnimated.AnimationSlide)
    TabMenuAnimated.Add_Menu("menu5",Chr(0xF129),xui.CreateFontAwesome(20),0xFF8EA7F2,"Info",TabMenuAnimated.AnimationNone)


End Sub

Sub menu1_OptionMenuClick
    Log(1)
End Sub

Sub menu2_OptionMenuClick
    Log(2)
End Sub

Sub menu3_OptionMenuClick
    Log(3)
End Sub

Sub menu4_OptionMenuClick
    Log(4)
End Sub

Sub menu5_OptionMenuClick
    Log(5)
End Sub

Sub Activity_Resume


End Sub




Sub Activity_Pause (UserClosed As Boolean)
    ' This sub is called when the activity is paused.
    ' UserClosed: True if the user closed the activity, False otherwise.
End Sub

Private Sub btfloating1_Clicked(open As Boolean)

    btmenu.show


End Sub


Private Sub btmenu_Clicked (item As String, index As Int)
    Try


        Log("selected itemindex: " & index)
        Log(item)
        'UPDATE AN ITEM !!!
'        btmenu.ItemLabel(index).Text = "New Item Text"

        If item = "Create new list" Then


        else if item = "New item" Then




        else if item = "Clear list" Then


        else if item = "Reload list" Then


        End If
    Catch
        Log(LastException)
    End Try
End Sub