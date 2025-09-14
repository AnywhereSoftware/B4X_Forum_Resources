B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
#If documentation
Versions:
V1.00
	-Release
	mBase public yapıldı. Fiestam da erişebilmek için.
V2.00
    - Kütüphane optimize edildi.
	- Hint Up Enable özelliği eklendi. Bu özellik ile beraber;
	- Hint Text artık yukarıya çıkarken rengini özelleştirebilirsiniz.
	- Hint Text artık yukarıya çıkarkenki ismini değiştirebilirsiniz.
	Bu özellikleri aktif etmek için " Hint Up Enable " özelliği etkinleştirin. 
V2.5 
    - Hint Name arka planının rengini istediğiniz gibi değiştirebilirsiniz.
V3.00
   -Bug Düzeltmeleri
   -Resim küçültme.
V3.3
   -Android için Numaralı Klavyede şifre özelliğine geçmiyordu.   
   
#End If
#DesignerProperty: Key: ArkaPlanRadius, DisplayName:Background Corner Radius , FieldType: int, DefaultValue: 10, Description:Background Corner Radius.
#DesignerProperty: Key: ArkaPlanRengi, DisplayName:Background Color , FieldType: Color, DefaultValue: 0x00FF0000,  Description:Background Color.
#DesignerProperty: Key: HintArkaPlanRengi, DisplayName:Hint Background Color , FieldType: Color, DefaultValue: 0xFFFFFFFF,  Description:Background Color.
#DesignerProperty: Key: BorderWidth, DisplayName:Border Width , FieldType: int, DefaultValue: 1, Description:Border Width.
#DesignerProperty: Key: BorderColor, DisplayName:Border Color , FieldType: Color, DefaultValue: 0xFFB0AEAE,  Description:Border Color.
#DesignerProperty: Key: HintLabelColor, DisplayName:Hint Label Color , FieldType: Color, DefaultValue: 0xFF067DC1,  Description:Hint Label Color.
#DesignerProperty: Key: LineColor, DisplayName:Line Color , FieldType: Color, DefaultValue: 0xFF067DC1,  Description:Line Color.
#DesignerProperty: Key: DoneButtonColor, DisplayName:Done Button Color , FieldType: Color, DefaultValue: 0xFF067DC1,  Description:Done Button Color.
#DesignerProperty: Key: TextColor, DisplayName:Text Color , FieldType: Color, DefaultValue: 0xFF067DC1,  Description:Text Color.
#DesignerProperty: Key: HintName, DisplayName:Hint Name , FieldType: String, DefaultValue: Hint Name,  Description:Hint Name.
#DesignerProperty: Key: PasswordMode, DisplayName:Password Mode , FieldType: Boolean, DefaultValue: False,  Description:Password Mode.
#if b4a
#DesignerProperty: Key: SingleLine, DisplayName:Single Line Textbox , FieldType: Boolean, DefaultValue: True,  Description:Single Line Textbox.
#DesignerProperty: Key: TextboxInput, DisplayName: Textbox Input Type, FieldType: String, DefaultValue: TEXT, List: NONE|NUMBERS|DECIMAL_NUMBERS|TEXT|PHONE
#Else
#DesignerProperty: Key: TextboxInput, DisplayName: Textbox Input Type, FieldType: String, DefaultValue: DEFAULT, List: |DEFAULT|ASCII_CAPABLE|NUMBERS_AND_PUNCTUATIONS|URL|NUMBER_PAD|PHONE_PAD|NAME_PHONE_PAD|EMAIL_ADDRESS|DECIMAL_PAD|WEB_SEARCH|
#end if
#DesignerProperty: Key: DoneButton, DisplayName:Done Button Visible , FieldType: Boolean, DefaultValue: True,  Description:Done Button Visible.
#DesignerProperty: Key: DoneButtonKeyboardHide, DisplayName:Done Button Keyboard Visible , FieldType: Boolean, DefaultValue: True,  Description:Done Button Visible.
#DesignerProperty: Key: ResimBitmapString, DisplayName:Default Image File , FieldType: String, DefaultValue:,  Description:Usage (just write.): errorimage.png Please make sure that the image File Is attached To your project..
#DesignerProperty: Key: Errorimage, DisplayName:Error Image File , FieldType: String, DefaultValue: errorimage.png,  Description:Usage (just write.): errorimage.png Please make sure that the image File Is attached To your project..
#DesignerProperty: Key: Warningimage, DisplayName:Warning Image File , FieldType: String, DefaultValue: warningimage.png,  Description:Usage (just write.): warningimage.png Please make sure that the image File Is attached To your project..
#DesignerProperty: Key: HintUpEnable, DisplayName:Hint Up Enable , FieldType:Boolean, DefaultValue:False,  Description:Hint Up Enable
#DesignerProperty: Key: HintNameUpColor, DisplayName:Hint Name Up Color , FieldType: color, DefaultValue: 0xFF067DC1,  Description:Hint Name Up Color
#DesignerProperty: Key: HintNameUpText, DisplayName:Hint Name Up Text , FieldType: String, DefaultValue: Hint Name,  Description:Hint Name Up Text

#Event: TextChanged (OldText As String, Newtext As String)
#Event: FocusChanged (HasFocus As Boolean)
#Event: EnterPressed
#Event: DoneClick
Private Sub Class_Globals
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private mProps As Map
	Private MyTextBox As B4XView
	
	Private Myimageview As ImageView ' Resim Oluştuğu İmageview
	Private MyDikeyCizgiLabel As Label
	Private MyHintPanel As Panel
	Private MyHintLabel As B4XView
	Private MyHLabel As Label 'MyHintLabel Buna Eşitledik.Object i label a çevirdik gibi.
	Private MyPanel As Panel
	Private TextboxOkeyButton As Label
	
	Private ArkaPlanRadius As Int
	Private ArkaPlanRengi As Int
	
	Private HintArkaPlanRengi As Int
	
	Private BorderWidth As Int
	Private BorderColor As Int
	Private HintLabelColor As Int
	Private LineColor As Int
	Private DoneButtonColor As Int
	Private TextColor As Int
	Private HintName As String
	Private PasswordMode As Boolean
    #if b4a
	Private SingleLine As Boolean 'ignore
	Private IME As IME
	Dim MyTextBoxB4X As EditText
	#else
	Private MyTextBoxB4X As TextField
	Private hud As HUD
	#end if
	
	Private TextboxInput As String
	Private DoneButton As Boolean 'ignore
	Private DoneButtonKeyboardHide As Boolean 'ignore
	Private Defaultimage As String 'ignore
	Private Errorimage As String 'ignore
	Private Warningimage As String
	Private HintUpEnable As Boolean
	Private HintNameUpColor As Int
	Private HintNameUpText As String
	Private NormalLeft As Int
	Private NormalHintArkaPlanUzunlugu As Double
	Private YukardaHintArkaPlanUzunlugu As Double
	
	
	Private ilkAcilis As Boolean=True
	Private Normalimage As Bitmap
	

	
End Sub

Public Sub Initialize (vCallback As Object, vEventName As String)
	mEventName = vEventName
	mCallBack = vCallback
		
		#IF B4A
	MyTextBoxB4X.Initialize("MyTextBox")
	MyTextBoxB4X.InputType = Bit.Or(MyTextBoxB4X.InputType, 524288)
	IME.Initialize("")
	#ELSE 
	MyTextBoxB4X.Initialize("MyTextBox")
	MyTextBoxB4X.BorderStyle=0
	MyTextBoxB4X.ReturnKey=0
	#End If
	MyHLabel.Initialize("LabelHint")
	MyHintLabel=MyHLabel
	
	MyTextBox=MyTextBoxB4X
	
End Sub

Private Sub My_initialize
	MyPanel.Initialize("")
	Myimageview.Initialize("")
	MyDikeyCizgiLabel.Initialize("")
	MyHintPanel.Initialize("")
	
	TextboxOkeyButton.Initialize("Labelex")
	mProps.Initialize
	
End Sub

Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	My_initialize
	mBase=Base
	Tag = mBase.Tag
	mBase.Tag = Me
	mProps = Props
	
	ArkaPlanRadius=Props.Get("ArkaPlanRadius")
	ArkaPlanRengi=Props.Get("ArkaPlanRengi")
	
	HintArkaPlanRengi=Props.Get("HintArkaPlanRengi")
	
	BorderWidth=Props.Get("BorderWidth")
	BorderColor=Props.Get("BorderColor")
	HintLabelColor=Props.Get("HintLabelColor")
	LineColor=Props.Get("LineColor")
	DoneButtonColor=Props.Get("DoneButtonColor")
	TextColor=Props.Get("TextColor")
	HintName=Props.Get("HintName")
	PasswordMode=Props.Get("PasswordMode")
	
	#if B4a 
	SingleLine=Props.Get("SingleLine")
	#end if
	
	TextboxInput=Props.Get("TextboxInput")
	DoneButton=Props.Get("DoneButton")
	DoneButtonKeyboardHide=Props.Get("DoneButtonKeyboardHide")
	Defaultimage=Props.Get("ResimBitmapString")
	Errorimage=Props.Get("Errorimage")
	Warningimage=Props.Get("Warningimage")
	
	If Props.Get("HintUpEnable")="null" Then
		HintUpEnable=False
	Else
		HintUpEnable=Props.Get("HintUpEnable")
	End If
	
	HintNameUpColor=Props.Get("HintNameUpColor")
	HintNameUpText=Props.Get("HintNameUpText")

	MyTextBox.Color=Colors.Transparent
	
	If DoneButton=True Then
		TextboxOkeyButton.TextColor=DoneButtonColor
		TextboxOkeyButton.Visible=False
		#if b4a
		TextboxOkeyButton.Typeface=Typeface.MATERIALICONS
		TextboxOkeyButton.TextSize=16
		#else
		TextboxOkeyButton.Font=Font.CreateMaterialIcons(20)
		#end if
	Else
		TextboxOkeyButton.Visible=False
		TextboxOkeyButton.TextColor=Colors.Transparent
	End If
	
	mBase.Color=Colors.Transparent
	
	#IF B4A

	Dim PanelArkaPlanOzellikleri As ColorDrawable
	PanelArkaPlanOzellikleri.Initialize2(ArkaPlanRengi,ArkaPlanRadius,BorderWidth,BorderColor)
	MyPanel.Background=PanelArkaPlanOzellikleri
	
	Dim MyDikeyCizgiLabelDrawable As ColorDrawable
	MyDikeyCizgiLabelDrawable.Initialize2(LineColor,50,0,Colors.Black)
	MyDikeyCizgiLabel.Background=MyDikeyCizgiLabelDrawable
	
	Dim MyHintLabelDrawable As ColorDrawable
	MyHintLabelDrawable.Initialize2(HintArkaPlanRengi,10,0,0)
	MyHLabel.background=MyHintLabelDrawable
			
			
	If Defaultimage="null" Or Defaultimage = "" Then
		Normalimage=Null
		Normalimage.InitializeMutable(30dip,30dip)
	Else
		Normalimage=LoadBitmap(File.DirAssets,Defaultimage)
		Myimageview.Bitmap=Normalimage
	End If
	
	Myimageview.Gravity=Gravity.FILL
	MyTextBox.TextColor=TextColor
	MyTextBoxB4X.SingleLine=SingleLine

	
	
	If TextboxInput = "TEXT" Then
		MyTextBoxB4X.InputType=MyTextBoxB4X.INPUT_TYPE_TEXT
	else if TextboxInput="NUMBERS" Then
		MyTextBoxB4X.InputType= MyTextBoxB4X.INPUT_TYPE_NUMBERS
	else if TextboxInput="PHONE" Then
		MyTextBoxB4X.InputType = MyTextBoxB4X.INPUT_TYPE_PHONE
	else if TextboxInput="NONE" Then
		MyTextBoxB4X.InputType=MyTextBoxB4X.INPUT_TYPE_NONE
	else if TextboxInput="DECIMAL_NUMBERS" Then
		MyTextBoxB4X.InputType=MyTextBoxB4X.INPUT_TYPE_DECIMAL_NUMBERS
	End If
	
	If PasswordMode=True Then MyTextBoxB4X.InputType = Bit.Or(MyTextBoxB4X.InputType, 0x00000080)
		
	If PasswordMode=True And TextboxInput="NUMBERS" Or TextboxInput="DECIMAL_NUMBERS" Then MyTextBoxB4X.InputType=0x00000012
	
	mBase.AddView(MyPanel, 0,8dip, mBase.Width, mBase.Height-8dip)
	MyPanel.AddView(MyTextBox, MyPanel.left+58dip,0, mBase.Width-75dip, MyPanel.Height-1dip)
	MyPanel.AddView(MyDikeyCizgiLabel, Myimageview.left+45dip,MyTextBox.top+13dip, 2dip, MyPanel.Height-25dip)
	MyPanel.AddView(Myimageview, MyPanel.left+12dip,MyDikeyCizgiLabel.Height/1.9, 25dip, 25dip)
	MyPanel.AddView(TextboxOkeyButton, MyTextBox.Width+51dip,MyDikeyCizgiLabel.Height/2.2, 30dip, 30dip)
	
	
	TextboxOkeyButton.Gravity=Gravity.CENTER_VERTICAL
	If DoneButton=True Then
		TextboxOkeyButton.Typeface=Typeface.MATERIALICONS
		TextboxOkeyButton.TextColor=DoneButtonColor
		TextboxOkeyButton.TextSize=16
	Else
		TextboxOkeyButton.TextColor=Colors.Transparent
	End If
	
	
	NormalLeft=MyPanel.Left
	MyHintLabel.TextSize=14
	MyHintLabel.TextColor=HintLabelColor
	MyHLabel.Gravity=Gravity.LEFT
	Dim HintYukseklik As Int=DipToCurrent(MyHintLabel.TextSize/0.77)
	
	#if b4a
	If HintName.Length<=3 Then
		Dim Sizex As Int=Abs(HintName.Length-4)
	
		For i=0 To Sizex  -1
			HintName=HintName &" "
		Next
	End If
	
	If HintNameUpText.Length<=3 Then
		Dim Sizex As Int=Abs(HintNameUpText.Length-4)
		For i=0 To Sizex  -1
			HintNameUpText=HintNameUpText &" "
		Next
	End If
	#end if
	
	MyHintLabel.Text=HintName
	NormalHintArkaPlanUzunlugu=UzunlukHesapla(HintName)
	YukardaHintArkaPlanUzunlugu=UzunlukHesapla(HintNameUpText)
	mBase.AddView(MyHintLabel, MyTextBox.Left,MyTextBox.Height/2,NormalHintArkaPlanUzunlugu,HintYukseklik)

	#else
	

	MyDikeyCizgiLabel.SetBorder(10,LineColor,5)
	MyPanel.SetBorder(BorderWidth,BorderColor,ArkaPlanRadius)
	
	Base.SetBorder(0,0,0)
	MyHintLabel.SetColorAndBorder(HintArkaPlanRengi,0,0,9)
	
	
	If Defaultimage="" Then
		Dim no As NativeObject
		Normalimage = no.Initialize ("UIImage").RunMethod ("new", Null)
	Else
		Normalimage=LoadBitmap(File.DirAssets,Defaultimage)
		Myimageview.Bitmap=Normalimage
	End If
	
	MyTextBoxB4X.TextColor=TextColor
	
	mBase.AddView(MyPanel, 0,9dip, mBase.Width, Base.Height-12dip)
	MyPanel.AddView(MyTextBox, MyPanel.left+60dip,0, mBase.Width-80dip, MyPanel.Height)
	MyPanel.AddView(MyDikeyCizgiLabel, Myimageview.left+45dip,MyTextBox.top+13dip, 2dip, MyPanel.Height-25dip)
	MyPanel.AddView(Myimageview, MyPanel.left+9dip,MyDikeyCizgiLabel.Height/2.5, 30dip, 30dip)
	MyPanel.AddView(TextboxOkeyButton, MyTextBox.Width+43dip,MyDikeyCizgiLabel.Height/2.5, 30dip, 30dip)
	
	If TextboxInput = "DEFAULT" Then
		MyTextBoxB4X.KeyboardType=0
	else if TextboxInput="ASCII_CAPABLE" Then
		MyTextBoxB4X.KeyboardType=1
	else if TextboxInput="NUMBERS_AND_PUNCTUATIONS" Then
		MyTextBoxB4X.KeyboardType=2
	else if TextboxInput="URL" Then
		MyTextBoxB4X.KeyboardType=3
	else if TextboxInput="NUMBER_PAD" Then
		MyTextBoxB4X.KeyboardType=4
	else if TextboxInput="PHONE_PAD" Then
		MyTextBoxB4X.KeyboardType=5
	else if TextboxInput="NAME_PHONE_PAD" Then
		MyTextBoxB4X.KeyboardType=6
	else if TextboxInput="EMAIL_ADDRESS" Then
		MyTextBoxB4X.KeyboardType=7
	else if TextboxInput="DECIMAL_PAD" Then
		MyTextBoxB4X.KeyboardType=8
	else if TextboxInput="WEB_SEARCH" Then
		MyTextBoxB4X.KeyboardType=9
	End If
	TextboxOkeyButton.TextColor=DoneButtonColor

	MyTextBoxB4X.PasswordMode=PasswordMode
	NormalLeft=MyPanel.Left
	Dim HintTextFontSize As Int=13

	MyHLabel.Font.CreateNew(HintTextFontSize)
	MyHintLabel.TextColor=HintLabelColor
	
	Dim HintYukseklik As Int=DipToCurrent(MyHintLabel.TextSize/0.75)
	MyHintLabel.Text=HintName
	NormalHintArkaPlanUzunlugu=UzunlukHesapla(HintName)
	YukardaHintArkaPlanUzunlugu=UzunlukHesapla(HintNameUpText)
	
	MyHintLabel.Text=HintName
	mBase.AddView(MyHintLabel, MyTextBox.Left,MyTextBox.Height/2.2,NormalHintArkaPlanUzunlugu,HintYukseklik)

	
	#end if
	
End Sub

Public Sub ClearError
	Myimageview.Bitmap=Normalimage

	#IF B4A
	
	Dim PanelArkaPlanOzellikleri As ColorDrawable
	PanelArkaPlanOzellikleri.Initialize2(Colors.White,ArkaPlanRadius,BorderWidth,BorderColor)
	MyPanel.Background=PanelArkaPlanOzellikleri
	
	#ELSE
	MyPanel.SetBorder(BorderWidth,BorderColor,ArkaPlanRadius)
    #END IF
	
End Sub

Private Sub UzunlukHesapla (NameText As String) As Double
	Dim UzunPanel As B4XView = xui.CreatePanel("")
	UzunPanel.SetLayoutAnimated(0,0,0,MyPanel.Width,MyPanel.Height)
	Dim Canvas1 As B4XCanvas
	Canvas1.Initialize(UzunPanel)
	Dim Rect As B4XRect = Canvas1.MeasureText(NameText, MyHintLabel.Font)
	Dim Sonuc As Double=(Rect.Width*1.08)
	#if b4i
	Sonuc=Sonuc+3dip
	#End If
	Return Sonuc
End Sub

Public Sub ShowError(ErrorText As String)
	Myimageview.Bitmap=LoadBitmap(File.DirAssets,Errorimage)
	
	#IF B4A
	If ErrorText.Length>0 Then
		ToastMessageShow(ErrorText,False)
	End If
	Dim PanelArkaPlanOzellikleri As ColorDrawable
	PanelArkaPlanOzellikleri.Initialize2(ArkaPlanRengi,ArkaPlanRadius,BorderWidth,BorderColor)
	MyPanel.Background=PanelArkaPlanOzellikleri
	#ELSE
	MyPanel.SetBorder(BorderWidth,Colors.red,ArkaPlanRadius)
	If ErrorText.Length>0 Then
		hud.ToastMessageShow(ErrorText,False)
	End If
    #END IF
End Sub

Public Sub ShowWarning(WarningText As String)
	Myimageview.Bitmap=LoadBitmap(File.DirAssets,Warningimage)
	#IF B4A
	If WarningText.Length>0 Then
		ToastMessageShow(WarningText,False)
	End If
	Dim PanelArkaPlanOzellikleri As ColorDrawable
	PanelArkaPlanOzellikleri.Initialize2(ArkaPlanRengi,ArkaPlanRadius,BorderWidth,Colors.RGB(193,200,24))
	MyPanel.Background=PanelArkaPlanOzellikleri
	#ELSE
	MyPanel.SetBorder(BorderWidth,Colors.RGB(193,200,24),ArkaPlanRadius)
	If WarningText.Length>0 Then
		hud.ToastMessageShow(WarningText,False)
	End If
    #END IF
End Sub

Public Sub ShowErrorAnimation(ErrorText As String)

	Myimageview.Bitmap=LoadBitmap(File.DirAssets,Errorimage)
  #IF B4A
	If ErrorText.Length>0 Then
		ToastMessageShow(ErrorText,False)
	End If
	Dim PanelArkaPlanOzellikleri As ColorDrawable
	PanelArkaPlanOzellikleri.Initialize2(ArkaPlanRengi,ArkaPlanRadius,BorderWidth,Colors.Red)
	MyPanel.Background=PanelArkaPlanOzellikleri
	MyHintLabel.Visible=False
	#ELSE
	MyPanel.SetBorder(BorderWidth,Colors.Red,ArkaPlanRadius)
	If ErrorText.Length>0 Then
		hud.ToastMessageShow(ErrorText,False)
	End If
	MyHintLabel.Visible=False
	#END IF

	For i=0 To 2
		MyPanel.Left=NormalLeft+100dip
	
		Sleep(50)
	
		MyPanel.Left=NormalLeft-100dip
		Sleep(50)
	Next
	MyHintLabel.Visible=True
	MyPanel.Left=NormalLeft
End Sub

#if B4A
Public Sub getNativeObject As EditText
	Return MyTextBox
End Sub
#ELSE 
Public Sub getNativeObject As TextField
	Return MyTextBox
End Sub
#END IF

Public Sub setText(Text As String)
	If ilkAcilis=True Then
'		ilkAcilis=False
		If HintUpEnable = True Then
			MyHintLabel.Width=YukardaHintArkaPlanUzunlugu
			MyHintLabel.Text=HintNameUpText
			MyHintLabel.TextColor=HintNameUpColor
		End If
		If Text.Length=0 Then
		#If b4a
			MyHintLabel.SetLayoutAnimated(200,MyHintLabel.left,MyTextBox.Height/2,MyHintLabel.Width,MyHintLabel.Height)
		#Else
			MyHintLabel.SetLayoutAnimated(200,MyHintLabel.left,MyTextBox.Height/2.2,MyHintLabel.Width,MyHintLabel.Height)
		#End if
		Else
			MyHintLabel.SetLayoutAnimated(200,MyHintLabel.left,MyTextBox.Top,MyHintLabel.Width,MyHintLabel.Height)
		End If
	End If
	MyTextBox.Text=Text
	
'	MyHintLabel.SetLayoutAnimated(200,MyHintLabel.left,MyTextBox.Top,MyHintLabel.Width,MyHintLabel.Height)

End Sub

Sub Clear
	
	
	If ilkAcilis=True Then
'		ilkAcilis=False
		MyTextBox.Text=""
		
		If HintUpEnable = True Then
			MyHintLabel.Width=YukardaHintArkaPlanUzunlugu
			MyHintLabel.Text=HintNameUpText
			MyHintLabel.TextColor=HintNameUpColor
		End If
		If MyTextBox.Text.Length=0 Then
		#If b4a
			MyHintLabel.SetLayoutAnimated(200,MyHintLabel.left,MyTextBox.Height/2,MyHintLabel.Width,MyHintLabel.Height)
		#Else
			MyHintLabel.SetLayoutAnimated(200,MyHintLabel.left,MyTextBox.Height/2.2,MyHintLabel.Width,MyHintLabel.Height)
		#End if
		Else
			MyHintLabel.SetLayoutAnimated(200,MyHintLabel.left,MyTextBox.Top,MyHintLabel.Width,MyHintLabel.Height)
		End If
	End If
	
End Sub

Public Sub getText As String
	Return MyTextBox.Text
End Sub

Public Sub setTextFont(Fnt As B4XFont)
	MyTextBox.Font=Fnt
End Sub

Public Sub getTextFont As B4XFont
	Return MyTextBox.Font
End Sub

Private Sub Labelex_Click
	If DoneButton=True And DoneButtonKeyboardHide=True  Then
#if b4a
		IME.HideKeyboard
	#else
		MyTextBoxB4X.ResignFocus
#end if
	End If
	
	If xui.SubExists(mCallBack,mEventName & "_DoneClick",0) Then CallSub(mCallBack,mEventName & "_DoneClick")
End Sub

Private Sub MyTextBox_BeginEdit
	CallSub2(Me,"MyTextBox_FocusChanged",True)
End Sub
Private Sub MyTextBox_EndEdit
	CallSub2(Me,"MyTextBox_FocusChanged",False)
End Sub

Private Sub MyTextBox_FocusChanged (HasFocus As Boolean)
	If HasFocus = False Then
		If MyTextBox.Text.Length=0 Then
			
			If HintUpEnable = True Then
				MyHintLabel.Width=NormalHintArkaPlanUzunlugu
				MyHintLabel.Text=HintName
				MyHintLabel.TextColor=HintLabelColor
			End If
			TextboxOkeyButton.Visible=False
			#if b4a
			MyHintLabel.SetLayoutAnimated(200,MyHintLabel.left,MyTextBox.Height/2,MyHintLabel.Width,MyHintLabel.Height)
			#else
			MyHintLabel.SetLayoutAnimated(200,MyHintLabel.left,MyTextBox.Height/2.2,MyHintLabel.Width,MyHintLabel.Height)
			#End If
		Else if MyTextBoxB4X.Text.Length>0 Then
			
			If HintUpEnable = True Then
				MyHintLabel.Width=YukardaHintArkaPlanUzunlugu
				MyHintLabel.Text=HintNameUpText
				MyHintLabel.TextColor=HintNameUpColor
			End If
			MyHintLabel.SetLayoutAnimated(200,MyHintLabel.left,MyTextBox.Top,MyHintLabel.Width,MyHintLabel.Height)
			TextboxOkeyButton.Visible=False
		End If
	Else
		If MyTextBox.Text.Length=0 Then
						
			If HintUpEnable = True Then
				MyHintLabel.Width=YukardaHintArkaPlanUzunlugu
				MyHintLabel.Text=HintNameUpText
				MyHintLabel.TextColor=HintNameUpColor
			End If
			MyHintLabel.SetLayoutAnimated(200,MyHintLabel.left,MyTextBox.Top,MyHintLabel.Width,MyHintLabel.Height)
			
			
			TextboxOkeyButton.Text=""
			TextboxOkeyButton.Visible=True
		Else
			TextboxOkeyButton.Text=""
			TextboxOkeyButton.Visible=True
			
			
		End If
	End If
	If xui.SubExists(mCallBack,mEventName & "_FocusChanged",1) Then CallSub2(mCallBack,mEventName & "_FocusChanged",HasFocus)
End Sub

#Region Event

Private Sub MyTextBox_TextChanged (Old As String, New As String)
	
	If New.Length>Old.Length Then
		
		MyHintLabel.SetLayoutAnimated(200,MyHintLabel.left,MyTextBox.Top,MyHintLabel.Width,MyHintLabel.Height)

'	Else if New.Length=0 Then
'	
'		MyHintLabel.SetLayoutAnimated(200,MyHintLabel.left,MyTextBox.Height/2,MyHintLabel.Width,MyHintLabel.Height)

		
	End If
	
	If xui.SubExists(mCallBack,mEventName & "_TextChanged",2) Then CallSub3(mCallBack,mEventName & "_TextChanged",Old,New)
End Sub

private Sub MyTextBox_EnterPressed
	#if b4i
	MyTextBoxB4X.ResignFocus
    #end if
	If xui.SubExists(mCallBack,mEventName & "_EnterPressed",0) Then CallSub(mCallBack,mEventName & "_EnterPressed")
End Sub

Private Sub MyTextBox_Action
	If xui.SubExists(mCallBack,mEventName & "_EnterPressed",0) Then CallSub(mCallBack,mEventName & "_EnterPressed")
End Sub

#END Region