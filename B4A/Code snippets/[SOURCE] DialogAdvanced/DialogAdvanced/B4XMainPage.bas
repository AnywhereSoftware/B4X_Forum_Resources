B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Dim kbd As IME
	Dim xui As XUI
	Dim Root As B4XView
	
    #Region Custom Dialog **
	Dim Dialog As B4XDialog
	Dim Label1 As Label
	Dim l1Undo As Label
	Dim l2Undo As Label
	Dim l1Echo As Label
	Dim l2Echo As Label
	Dim mapDaten As Map
	Dim ScrollUp As Label
	Dim btUndo As Button
	Dim Image2 As ImageView
	Dim txtDialogEmail  As B4XFloatTextField
	Dim txtDialogPayPal As B4XFloatTextField
	Dim logDialogChange As Boolean = False
	Dim KeyboardIsClose As Boolean = True
	Dim svMainCDialogScrollView As ScrollView
	#End Region

End Sub

Public Sub Initialize
	mapDaten.Initialize
	btUndo.Initialize("btUndo")
	B4XPages.GetManager.LogEvents = True
	B4XPages.GetManager.TransitionAnimationDuration = 0
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.Visible = False
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "B4A - Dialog Advanced")
	
    #Region Keyboard
	kbd.Initialize("kbd")
	kbd.AddHeightChangedEvent
	kbd.HideKeyboard
	#End Region
	
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	'home button
	If Main.ActionBarHomeClicked Then
		Sleep(100)
		B4XPages.ClosePage(Me)
		Return False
	End If

	'back key (_KeyPress)
	Sleep(100)
	B4XPages.ClosePage(Me)
	Return True
End Sub

Sub B4XPage_Appear
	Root.SetVisibleAnimated(600,True)
	B4XPages.GetManager.ActionBar.RunMethod("setDisplayHomeAsUpEnabled", Array(True)) 'Display enabled = True
End Sub

Private Sub B4XPage_Disappear
	If mapDaten.IsInitialized Then mapDaten.Clear
	B4XPages.GetManager.ActionBar.RunMethod("setDisplayHomeAsUpEnabled", Array(False)) 'Display enabled = True
End Sub

'Keyboard is close if (OldHeight < NewHeight)
Private Sub kbd_HeightChanged (NewHeight As Int, OldHeight As Int)
	If OldHeight < NewHeight Then KeyboardIsClose = True Else KeyboardIsClose = False
End Sub

Private Sub kbd_HandleAction As Boolean
	Return False
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

#Region TESTING the contents of the field (Address EmailDetails) 
Sub ScrollUp_Click
	If svMainCDialogScrollView.ScrollPosition > 0 Then svMainCDialogScrollView.ScrollPosition = 0
End Sub

Sub btUndo_Click
	Dim undo As Label
	undo = Sender

	Select undo.Tag
		Case "txtDialogEmail"
			txtDialogEmail.TextField.Text  = mapDaten.Get(undo.Tag)
		Case "txtDialogPayPal"
			txtDialogPayPal.TextField.Text = mapDaten.Get(undo.Tag)
	End Select
	undo.Visible = False
End Sub

Sub txtDialogEmail_TextChanged (Old As String, New As String)
	IsDialogValid(New)
	If logDialogChange = False And Old.Length > 0 Then logDialogChange = Old.EqualsIgnoreCase(New) = False
	If New.Length = 0 Then
		If mapDaten.GetDefault("txtDialogEmail","").As(String).Length = 0 Then mapDaten.Put("txtDialogEmail", Old): l1Undo.Visible = True
	Else
		l1Undo.Visible = False
	End If
End Sub
Sub txtDialogEmail_FocusChanged (HasFocus As Boolean)
	txtDialogEmail.NextField = txtDialogPayPal
End Sub
Sub txtDialogEmail_Enterpressed
	txtDialogPayPal.TextField.RequestFocus
	txtDialogPayPal.TextField.SelectionStart = txtDialogPayPal.TextField.Text.Length
	If KeyboardIsClose Then kbd.ShowKeyboard(txtDialogPayPal.TextField)
End Sub
Sub txtDialogPayPal_TextChanged (Old As String, New As String)
	If logDialogChange = False And Old.Length > 0 Then logDialogChange = Old.EqualsIgnoreCase(New) = False
	If New.Length = 0 Then
		If mapDaten.GetDefault("txtDialogPayPal","").As(String).Length = 0 Then mapDaten.Put("txtDialogPayPal", Old): l2Undo.Visible = True
	Else
		l2Undo.Visible = False
	End If
End Sub
Sub txtDialogPayPal_FocusChanged (HasFocus As Boolean)
	txtDialogPayPal.NextField = txtDialogEmail
End Sub
Sub txtDialogPayPal_Enterpressed
	If logDialogChange = True Then
		kbd.HideKeyboard
		Dim p As B4XView = xui.CreatePanel("")
		p.SetLayoutAnimated(0, 50%x-160dip, 10dip, 320dip, 120dip)
		p.LoadLayout("svMainPaymentMessage") 'has both Label B4Xviews

		Dialog.PutAtTop = True
		Dialog.Title = Starter.loc.Localize("Payment Method")&" / "&Starter.loc.Localize("Mailbox")
		Dim dr As ResumableSub = Dialog.ShowCustom(p, Starter.loc.Localize("Save"), "", Starter.loc.Localize("Cancel"))

		Label1.Typeface = Typeface.LoadFromAssets("LucidaSansDemiBold.ttf")
		Label1.Text = Starter.loc.Localize("Do you want to save changes?")

		Wait For (dr) Complete (ResultChoose As Int)
		Dialog.PutAtTop = False
		
		Sleep(0)
		kbd.HideKeyboard
		If mapDaten.IsInitialized Then mapDaten.Clear

		If ResultChoose = DialogResponse.POSITIVE Then
			Main.pmr.SetString("email1",txtDialogEmail.Text)
			Main.pmr.SetString("paypal",txtDialogPayPal.Text)
			If  B4XPages.MainPage.Dialog.IsInitialized Then
				If B4XPages.MainPage.Dialog.PutAtTop = True Then
					B4XPages.MainPage.Dialog.Close(B4XPages.MainPage.xui.DialogResponse_Cancel)
				End If
			End If
		End If
	Else
		If svMainCDialogScrollView.ScrollPosition > 0 Then svMainCDialogScrollView.ScrollPosition = 0
		txtDialogEmail.TextField.RequestFocus
		txtDialogEmail.TextField.SelectionStart = txtDialogEmail.TextField.Text.Length
		If KeyboardIsClose Then kbd.ShowKeyboard(txtDialogEmail.TextField)
	End If
End Sub

Private Sub IsDialogValid (field As String) As Boolean
	Private Positive As B4XView = Dialog.GetButton(xui.DialogResponse_Positive)
	Private Cancel As B4XView = Dialog.GetButton(xui.DialogResponse_Cancel)
	
	If  field.Length > 0 And B4XShareCode.YourMailValid(field) = True Then
		field = ""
		Positive.Left = 100%x - (5dip+(Cancel.Width))
		Cancel.Left   = 100%x - (10dip+(2*Positive.Width))
		Positive.Visible = True
		Label1.TextColor = Colors.RGB(255,133,0)
		txtDialogEmail.TextField.TextColor = Colors.Black
		Return True
	Else
		field = ""
		Positive.Visible = False
		Positive.Left = 100%x - (10dip+(2*Positive.Width))
		Cancel.Left = 100%x - (5dip+(Cancel.Width))
		Label1.TextColor = Colors.RGB(177,177,177)
		txtDialogEmail.TextField.TextColor = Colors.RGB(177,177,177)
		Return False
	End If
End Sub
#End Region

Private Sub Button1_Click
	Dialog.Initialize(Root)
	Dialog.VisibleAnimationDuration = 800
	Dialog.Title = Starter.loc.Localize("Payment Method")&" / "&Starter.loc.Localize("Mailbox")
	Dialog.TitleBarFont = xui.CreateFont(Typeface.LoadFromAssets("LucidaSansDemiBold.ttf"), 14)
	Dialog.TitleBarTextColor = Colors.Black
	Dialog.TitleBarColor = Colors.RGB(255,133,0)
	Dialog.BackgroundColor = Colors.RGB(44,44,44)
	Dialog.ButtonsTextColor = Colors.RGB(255,133,0)
	Dialog.ButtonsColor = Colors.ARGB(25,255,123,0)
	Dialog.BorderColor = Colors.ARGB(25,255,123,0)
	Dialog.BorderCornersRadius = 10
	Dialog.BorderWidth = 1

	Dim p As B4XView = xui.CreatePanel("") '---------------------------------s c r o l l i n g ----------
	p.SetLayoutAnimated(0, 0, 10dip, 100%x-6dip, 50%y-50dip)

	svMainCDialogScrollView.Initialize(Root.Height)
	svMainCDialogScrollView.Color = Colors.ARGB(25,44,44,44)
	B4XShareCode.SetScrollbarColor(svMainCDialogScrollView,Colors.ARGB(50,83,83,83))
	p.AddView(svMainCDialogScrollView,0, 0dip, 100%x-6dip, 50%y-50dip)
	svMainCDialogScrollView.Panel.LoadLayout("svMainPaymentDialog")  'has both B4XFloatTextField B4Xviews
	svMainCDialogScrollView.Panel.Width  = 100%x - 3dip
	svMainCDialogScrollView.Panel.Height = 60%y
	svMainCDialogScrollView.ScrollPosition = 0
	svMainCDialogScrollView.FullScroll(True) '-----------------------------------------------------------
		
	For i = 0 To 1
		If i = 0 Then
			Dim ft As B4XFloatTextField = txtDialogEmail
		Else
			Dim ft As B4XFloatTextField = txtDialogPayPal
			Image2.SetBackgroundImage(LoadBitmap(File.DirAssets, "paypal.png"))
		End If

		Dim dp As Int = ft.lblClear.Top - 34dip
		Dim hg As Int = 80dip 'Changes the height of an existing item (custom view)

		ft.TextField.Font = xui.CreateFont(Typeface.LoadFromAssets("LucidaSansDemiBold.ttf"), 20)
		ft.HintColor = Colors.RGB(171,171,171)
		ft.NonFocusedHintColor = Colors.RGB(171,171,171)
		ft.TextField.SetTextAlignment("BOTTOM","LEFT")
		ft.SmallLabelTextSize  = 12 'Hint Small
		ft.LargeLabelTextSize  = 14 'Hint Large
		ft.TextField.TextSize  = 17 'Text
		ft.TextField.TextColor = Colors.Black

		If i = 0 Then ft.HintText = Starter.loc.Localize("Mailbox")
		If i = 1 Then ft.HintText = Starter.loc.Localize("Account PayPal")
			
		Private SmallTextFont  As B4XFont = xui.CreateFont2(ft.HintFont, ft.SmallLabelTextSize)
		Private LargeTextFont  As B4XFont = xui.CreateFont2(ft.HintFont, ft.LargeLabelTextSize)
		Private SmallTextWidth As Int = B4XShareCode.MeasureTextWidth(ft.HintText, SmallTextFont)
		Private LargeTextWidth As Int = B4XShareCode.MeasureTextWidth(ft.HintText, LargeTextFont)
		Private BorderRadius   As Int = 0

		ft.HintLabelSmallOffsetY = 3 'Inside
		ft.HintLabelSmallOffsetX = (ft.TextField.Width - SmallTextWidth) - (BorderRadius + 45)	   'Right

		If ft.LargeLabelTextSize = ft.SmallLabelTextSize Then
			ft.HintLabelLargeOffsetX = (ft.TextField.Width - LargeTextWidth) - (BorderRadius + 25) 'Right
		Else
			ft.HintLabelLargeOffsetX = (ft.TextField.Width - LargeTextWidth) - (BorderRadius + 25) 'Right
		End If

		Private edt As EditText = ft.TextField
		edt.Padding = Array As Int (4dip, 10dip, 4dip, 4dip) 'Resize Padding

		ft.mBase.Width  = ft.mBase.Width
		ft.mBase.Height = hg

		CallSub3(ft, "Base_Resize", ft.mBase.Width, ft.mBase.Height)

		ft.TextField.SetColorAndBorder(xui.Color_White, DipToCurrent(2), xui.Color_Transparent, BorderRadius)
		ft.lblClear.Left = (ft.TextField.Width - BorderRadius - 22dip)
		ft.lblClear.Top = dp
		ft.lblClear.TextColor = Colors.RGB(255,133,0)
		ft.lblClear.Visible = True
		ft.mBase.Top = 15dip
		ft.Update
	Next

	Dialog.PutAtTop = True
	Dim rs As ResumableSub = Dialog.ShowCustom(p, "OK", "", Starter.loc.Localize("Cancel"))
		
	Dialog.Base.Top = 3dip
	Dialog.Base.Left  = 1dip
	Dialog.Base.Width = 100%x - 2dip
		
	Dim Positive As B4XView = Dialog.GetButton(xui.DialogResponse_Positive)
	Dim Cancel   As B4XView = Dialog.GetButton(xui.DialogResponse_Cancel)

	Positive.Top  = Dialog.Base.Height - (2dip+(Cancel.Height))
	Positive.Left = 100%x - (5dip+(Cancel.Width))
	Cancel.Top    = Dialog.Base.Height - (2dip+(Cancel.Height))
	Cancel.Left   = 100%x - (10dip+(2*Positive.Width))
		
	logDialogChange = False
	txtDialogEmail.TextField.Text  = Main.pmr.GetString("email1")
	txtDialogPayPal.TextField.Text = Main.pmr.GetString("paypal")

	txtDialogEmail.TextField.RequestFocus
	txtDialogEmail.TextField.SelectionStart = txtDialogEmail.TextField.Text.Length
	kbd.ShowKeyboard(txtDialogEmail.TextField)
	IsDialogValid(txtDialogEmail.Text)
	
	Wait For (rs) Complete (Result As Int)
	Dialog.PutAtTop = False
		
	Sleep(0)
	kbd.HideKeyboard
	If mapDaten.IsInitialized Then mapDaten.Clear

	If Result = xui.DialogResponse_Positive And logDialogChange = True Then
		Dim p As B4XView = xui.CreatePanel("")
		p.SetLayoutAnimated(0, 50%x-160dip, 10dip, 320dip, 120dip)
		p.LoadLayout("svMainPaymentMessage") 'has both Label B4Xviews

		Dialog.PutAtTop = True
		Dialog.Title = Starter.loc.Localize("Payment Method")&" / "&Starter.loc.Localize("Mailbox")
		Dim dr As ResumableSub = Dialog.ShowCustom(p, Starter.loc.Localize("Save"), "", Starter.loc.Localize("Cancel"))

		Label1.Typeface = Typeface.LoadFromAssets("LucidaSansDemiBold.ttf")
		Label1.Text = Starter.loc.Localize("Do you want to save changes?")

		Wait For (dr) Complete (ResultChoose As Int)
		Dialog.PutAtTop = False
		If ResultChoose = DialogResponse.POSITIVE Then
			Main.pmr.SetString("email1",txtDialogEmail.Text)
			Main.pmr.SetString("paypal",txtDialogPayPal.Text)
		End If
	End If
End Sub