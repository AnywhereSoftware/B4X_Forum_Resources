B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'B4XMainPage Custom View class
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

Sub Class_Globals
	Dim sql As SQL
	Private CircularProgressBar1 As CircularProgressBar
	Type PagePosition (Left As Int, Top As Int, Width As Int, Height As Int, IsIconified As Boolean)
	
	' Globals objects:
    #Region ©.Globals objects 
	Dim btnBuild As Button
	Dim btnClose As Button
	Dim btnBwse1 As Button
	Dim btnBwse2 As Button
	Dim coBoxse1 As Button
	Dim btnSegRefresh As Button
	Dim SegmentedSeparator As BreadCrumbBar
	Dim Label1, Label2, Label3, Label4, Label5 As Label
	Dim fc As FileChooser
	Dim txtDB As TextField
	Dim txtFILE As TextField
	Dim txtSepr As TextField
	Dim CheckBoxMore As CheckBox
	Dim ComboBox1, ComboBox2 As ComboBox
	Dim cutils As ControlsUtils
	Dim sRow As String
	#End Region
	
	Private xui As XUI

	Private DialogFX As DialogsFX
	Private RootM As B4XView
	
	Dim B4XPage As Object
	Dim MainPages As Form
	Dim cutils As ControlsUtils
	Dim SegmentedLocale As BreadCrumbBar

	Private TitleBarCV1 As TitleBarCV
End Sub

'You can add more parameters here.
Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	DialogFX.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	RootM = Root1	'load the layout to Root
	RootM.LoadLayout("Main")

	SharedCode.CheckInternet.Initialize(RootM,Main.loc.Localize("Połączenie internetowe"),SharedCode.AppName,Main.loc.Localize("Proszę, włącz połączenie internetowe.")&CRLF&CRLF,Main.loc.Localize("Gotowy"),Main.loc.Localize("Anuluj"))

    #Region ©.TitleBar CustomView 1 
	TitleBarCV1.SetIcon(Main.ImageIcon)
	TitleBarCV1.SetTitle(Main.AppName)
	TitleBarCV1.SetResizeWindow.MaxWindowWidth  = 600
	TitleBarCV1.SetResizeWindow.MaxWindowHeight = 600
	TitleBarCV1.SetResize(True) 'Form with fixed size if <True>
	#End Region

	B4XPage = Me
	LoadPagePosition(Me)

End Sub

Private Sub B4XPage_Background
	B4XPages.MainPage.SavePagePosition(Me)
End Sub

Sub B4XPage_Appear
	Dim lang As String = Main.kvs.Get("lang")
	Select lang
		Case "pl"
			SegmentedLocale.SetItems(Array("Polski √","Angielski"))
		Case "en"
			SegmentedLocale.SetItems(Array("Polish","English √"))
		Case Else
			SegmentedLocale.SetItems(Array("Polish","English √"))
	End Select
	
	CircularProgressBar1.Value = 0
	
	ComboBox1.Items.AddAll(Array As String ("af","am","ar","ar-Latn","az","be","bg","bg-Latn","bn","bs","ca","ceb","co","cs","cy", _
	"da","de","el","el-Latn","en","eo","es","et","eu","fa","fi","fil","fr","fy","ga","gd","gl","gu","ha","haw","he","hi","hi-Latn","hmn","hr","ht","hu","hy","id", _
	"ig","is","it","ja","ja-Latn","jv","ka","kk","km","kn","ko","ku","ky","la","lb","lo","lt","lv","mg","mi","mk","ml","mn","mr","ms","mt","my","ne","nl","no","ny","pa","pl", _
	"ps","pt","ro","ru","ru-Latn","sd","si","sk","sl","sm","sn","so","sq","sr","st","su","sv","sw","ta","te","tg","th","tr","uk","ur","uz","vi","xh","yi","yo","zh","zh-Latn","zu"))
	ComboBox2.Items.AddAll(Array As String ("af","am","ar","ar-Latn","az","be","bg","bg-Latn","bn","bs","ca","ceb","co","cs","cy", _
	"da","de","el","el-Latn","en","eo","es","et","eu","fa","fi","fil","fr","fy","ga","gd","gl","gu","ha","haw","he","hi","hi-Latn","hmn","hr","ht","hu","hy","id", _
	"ig","is","it","ja","ja-Latn","jv","ka","kk","km","kn","ko","ku","ky","la","lb","lo","lt","lv","mg","mi","mk","ml","mn","mr","ms","mt","my","ne","nl","no","ny","pa","pl", _
	"ps","pt","ro","ru","ru-Latn","sd","si","sk","sl","sm","sn","so","sq","sr","st","su","sv","sw","ta","te","tg","th","tr","uk","ur","uz","vi","xh","yi","yo","zh","zh-Latn","zu"))
	
	ComboBox1.Value = "pl"
	ComboBox2.Value = "en"
	
	TitleBarAndMoreRefresh
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Public Sub SavePagePosition (Page As Object)
	Dim f As Form = B4XPages.GetNativeParent(Page)
	If  f = Null Or f.IsInitialized = False Then Return
	Main.kvs.Put(B4XPages.GetPageId(Page), FormToPP(f))
	Main.kvs.Put("lang", Main.loc.Device)
End Sub

Public Sub LoadPagePosition (Page As Object)
	MainPages = B4XPages.GetNativeParent(Page)
	Dim pp As PagePosition = Main.kvs.Get(B4XPages.GetPageId(Page))
	If  pp = Null Then Return
	SetFormFromMap(pp, MainPages)
End Sub

Private Sub FormToPP (f As Form) As PagePosition
	Return CreatePagePosition(f.WindowLeft, f.WindowTop, f.WindowWidth, f.WindowHeight, f.As(JavaObject).GetFieldJO("stage").RunMethod("isIconified", Null))
End Sub

Public Sub SetFormFromMap(pp As PagePosition, f As Form)
	f.WindowLeft = pp.Left
	f.WindowTop = pp.Top
	f.WindowWidth = pp.Width
	f.WindowHeight = pp.Height
	Dim iconified As Boolean = pp.IsIconified
	If iconified Then
		Dim jo As JavaObject = f
		jo.GetFieldJO("stage").RunMethod("setIconified", Array(iconified))
	End If
	'check that left and top are in screen boundaries
	Dim goodLeft, goodTop As Boolean
	Dim fx As JFX
	For Each screen As Screen In fx.Screens
		If f.WindowLeft >= screen.MinX And f.WindowLeft <= screen.MaxX Then
			goodLeft = True
		End If
		If f.WindowTop >= screen.MinY And f.WindowTop <= screen.MaxY Then
			goodTop = True
		End If
	Next
	If Not(goodLeft) Then f.WindowLeft = 0
	If Not(goodTop) Then f.WindowTop = 0
End Sub

Private Sub CreatePagePosition (Left As Int, Top As Int, Width As Int, Height As Int, IsIconified As Boolean) As PagePosition
	Dim t1 As PagePosition
	t1.Initialize
	t1.Left = Left
	t1.Top = Top
	t1.Width = Width
	t1.Height = Height
	t1.IsIconified = IsIconified
	Return t1
End Sub

'Update CornersRadius.
Public Sub UpdateClip (pnl As B4XView, CornersRadius As Int)
	Dim jo As JavaObject = pnl
	Dim shape As JavaObject
	Dim cx As Double = pnl.Width
	Dim cy As Double = pnl.Height
	shape.InitializeNewInstance("javafx.scene.shape.Rectangle", Array(cx, cy))
	If CornersRadius > 0 Then
		Dim d As Double = CornersRadius * 2
		shape.RunMethod("setArcHeight", Array(d))
		shape.RunMethod("setArcWidth", Array(d))
	End If
	jo.RunMethod("setClip", Array(shape))
End Sub

Sub SegmentedSeparator_CrumbAction (Selected As String)
	Select Selected
		Case "średnik","semicolon"
			Main.SeparatorChar = ";"
		Case "spacja","space"
			Main.SeparatorChar = " "
		Case "tabulator","tab"
			Main.SeparatorChar = TAB
		Case "przecinek","comma"
			Main.SeparatorChar = ","
		Case "'"
			Main.SeparatorChar = "'"
		Case Chr(34)
			Main.SeparatorChar = Chr(34)
		Case Else
			Main.SeparatorChar = ""
	End Select
	CheckBoxMore.Checked = True
	txtSepr.Text = Main.SeparatorChar
	txtSepr.SelectAll
	txtSepr.RequestFocus
End Sub

Private Sub CheckBoxMore_CheckedChange(Checked As Boolean)
	txtSepr.Enabled = Checked
	If Checked Then
		txtSepr.RequestFocus
		txtSepr.SelectAll
	Else
		txtSepr.Text = ""
		SegmentedSeparator.SetItems(Array(Main.loc.Localize("średnik"),Main.loc.Localize("spacja"),Main.loc.Localize("tabulator"),Main.loc.Localize("przecinek"),"'",Chr(34),". . ."))
		btnSegRefresh.RequestFocus
	End If
End Sub

Sub SegmentedLocale_CrumbAction (Selected As String)
	btnClose.RequestFocus
	Select Selected
		Case "Polish √","Polski √", "Polish","Polski"
			Main.loc.Device = "pl"
			SegmentedLocale.SetItems(Array("Polski √","Angielski"))
		Case "English √","Angielski √","English","Angielski"
			Main.loc.Device = "en"
			SegmentedLocale.SetItems(Array("Polish","English √"))
		Case ""
			Main.loc.Device = Main.loc.FindLocale
			If Main.loc.Device.EqualsIgnoreCase("pl") Then
				SegmentedLocale.SetItems(Array("Polski √","Angielski"))
			Else
				SegmentedLocale.SetItems(Array("Polish","English √"))
			End If
	End Select
	Main.kvs.Put("lang", Main.loc.Device)
	Main.loc.Locale = Main.loc.Device
	Main.loc.UsrLng = Main.loc.Locale
	Main.loc.ForceLocale(Main.loc.Device)
	TitleBarAndMoreRefresh
End Sub

Private Sub ComboBox1_ValueChanged (Value As Object)
End Sub

Private Sub ComboBox2_ValueChanged (Value As Object)
End Sub

Private Sub coBoxse1_Click
	Dim co1 As String = ComboBox1.Value
	ComboBox1.Value = ComboBox2.Value
	ComboBox2.Value = co1
End Sub

Private Sub ComboBox1_SelectedIndexChanged(Index As Int, Value As Object)
	Select Index
		Case 0
			Label4.Text = "Afrikaans" & " = af"
		Case 1
			Label4.Text = "Amharic" & " = am"
		Case 2
			Label4.Text = "Arabic" & " = ar"
		Case 3
			Label4.Text = "Arabic_Latin" & " = ar-Latn"
		Case 4
			Label4.Text = "Azerbaijani" & " = az"
		Case 5
			Label4.Text = "Belarusian" & " = be"
		Case 6
			Label4.Text = "Bulgarian" & " = bg"
		Case 7
			Label4.Text = "Bulgarian_Latin" & " = bg-Latn"
		Case 8
			Label4.Text = "Bengali" & " = bn"
		Case 9
			Label4.Text = "Bosnian" & " = bs"
		Case 10
			Label4.Text = "Catalan" & " = ca"
		Case 11
			Label4.Text = "Cebuano" & " = ceb"
		Case 12
			Label4.Text = "Corsican" & " = co"
		Case 13
			Label4.Text = "Czech" & " = cs"
		Case 14
			Label4.Text = "Welsh" & " = cy"
		Case 15
			Label4.Text = "Danish" & " = da"
		Case 16
			Label4.Text = "German" & " = de"
		Case 17
			Label4.Text = "Greek" & " = el"
		Case 18
			Label4.Text = "Greek_Latin" & " = el-Latn"
		Case 19
			Label4.Text = "English" & " = en"
		Case 20
			Label4.Text = "Esperanto" & " = eo"
		Case 21
			Label4.Text = "Spanish" & " = es"
		Case 22
			Label4.Text = "Estonian" & " = et"
		Case 23
			Label4.Text = "Basque" & " = eu"
		Case 24
			Label4.Text = "Persian" & " = fa"
		Case 25
			Label4.Text = "Finnish" & " = fi"
		Case 26
			Label4.Text = "Filipino" & " = fil"
		Case 27
			Label4.Text = "French" & " = fr"
		Case 28
			Label4.Text = "Western_Frisian" & " = fy"
		Case 29
			Label4.Text = "Irish" & " = ga"
		Case 30
			Label4.Text = "Scots_Gaelic" & " = gd"
		Case 31
			Label4.Text = "Galician" & " = gl"
		Case 32
			Label4.Text = "Gujarati" & " = gu"
		Case 33
			Label4.Text = "Hausa" & " = ha"
		Case 34
			Label4.Text = "Hawaiian" & " = haw"
		Case 35
			Label4.Text = "Hebrew" & " = he"
		Case 36
			Label4.Text = "Hindi" & " = hi"
		Case 37
			Label4.Text = "Hindi_Latin" & " = hi-Latn"
		Case 38
			Label4.Text = "Hmong" & " = hmn"
		Case 39
			Label4.Text = "Croatian" & " = hr"
		Case 40
			Label4.Text = "Haitian" & " = ht"
		Case 41
			Label4.Text = "Hungarian" & " = hu"
		Case 42
			Label4.Text = "Armenian" & " = hy"
		Case 43
			Label4.Text = "Indonesian" & " = id"
		Case 44
			Label4.Text = "Igbo" & " = ig"
		Case 45
			Label4.Text = "Icelandic" & " = is"
		Case 46
			Label4.Text = "Italian" & " = it"
		Case 47
			Label4.Text = "Japanese" & " = ja"
		Case 48
			Label4.Text = "Japanese_Latin" & " = ja-Latn"
		Case 49
			Label4.Text = "Javanese" & " = jv"
		Case 50
			Label4.Text = "Georgian" & " = ka"
		Case 51
			Label4.Text = "Kazakh" & " = kk"
		Case 52
			Label4.Text = "Khmer" & " = km"
		Case 53
			Label4.Text = "Kannada" & " = kn"
		Case 54
			Label4.Text = "Korean" & " = ko"
		Case 55
			Label4.Text = "Kurdish" & " = ku"
		Case 56
			Label4.Text = "Kyrgyz" & " = ky"
		Case 57
			Label4.Text = "Latin" & " = la"
		Case 58
			Label4.Text = "Luxembourgish" & " = lb"
		Case 59
			Label4.Text = "Lao" & " = lo"
		Case 60
			Label4.Text = "Lithuanian" & " = lt"
		Case 61
			Label4.Text = "Latvian" & " = lv"
		Case 62
			Label4.Text = "Malagasy" & " = mg"
		Case 63
			Label4.Text = "Maori" & " = mi"
		Case 64
			Label4.Text = "Macedonian" & " = mk"
		Case 65
			Label4.Text = "Malayalam" & " = ml"
		Case 66
			Label4.Text = "Mongolian" & " = mn"
		Case 67
			Label4.Text = "Marathi" & " = mr"
		Case 68
			Label4.Text = "Malay" & " = ms"
		Case 69
			Label4.Text = "Maltese" & " = mt"
		Case 70
			Label4.Text = "Burmese" & " = my"
		Case 71
			Label4.Text = "Nepali" & " = ne"
		Case 72
			Label4.Text = "Dutch" & " = nl"
		Case 73
			Label4.Text = "Norwegian" & " = no"
		Case 74
			Label4.Text = "Nyanja" & " = ny"
		Case 75
			Label4.Text = "Punjabi" & " = pa"
		Case 76
			Label4.Text = "Polish" & " = pl"
		Case 77
			Label4.Text = "Pashto" & " = ps"
		Case 78
			Label4.Text = "Portuguese" & " = pt"
		Case 79
			Label4.Text = "Romanian" & " = ro"
		Case 80
			Label4.Text = "Russian" & " = ru"
		Case 81
			Label4.Text = "Russian_Latin" & " = ru-Latn"
		Case 82
			Label4.Text = "Sindhi" & " = sd"
		Case 83
			Label4.Text = "Sinhala" & " = si"
		Case 84
			Label4.Text = "Slovak" & " = sk"
		Case 85
			Label4.Text = "Slovenian" & " = sl"
		Case 86
			Label4.Text = "Samoan" & " = sm"
		Case 87
			Label4.Text = "Shona" & " = sn"
		Case 88
			Label4.Text = "Somali" & " = so"
		Case 89
			Label4.Text = "Albanian" & " = sq"
		Case 90
			Label4.Text = "Serbian" & " = sr"
		Case 91
			Label4.Text = "Sesotho" & " = st"
		Case 92
			Label4.Text = "Sundanese" & " = su"
		Case 93
			Label4.Text = "Swedish" & " = sv"
		Case 94
			Label4.Text = "Swahili" & " = sw"
		Case 95
			Label4.Text = "Tamil" & " = ta"
		Case 96
			Label4.Text = "Telugu" & " = te"
		Case 97
			Label4.Text = "Tajik" & " = tg"
		Case 98
			Label4.Text = "Thai" & " = th"
		Case 99
			Label4.Text = "Turkish" & " = tr"
		Case 100
			Label4.Text = "Ukrainian" & " = uk"
		Case 101
			Label4.Text = "Urdu" & " = ur"
		Case 102
			Label4.Text = "Uzbek" & " = uz"
		Case 103
			Label4.Text = "Vietnamese" & " = vi"
		Case 104
			Label4.Text = "Xhosa" & " = xh"
		Case 105
			Label4.Text = "Yiddish" & " = yi"
		Case 106
			Label4.Text = "Yoruba" & " = yo"
		Case 107
			Label4.Text = "Chinese" & " = zh"
		Case 108
			Label4.Text = "Chinese_Latin" & " = zh-Latn"
		Case 109
			Label4.Text = "Zulu" & " = zu"
	End Select
End Sub

Private Sub ComboBox2_SelectedIndexChanged(Index As Int, Value As Object)
	Select Index
		Case 0
			Label5.Text = "Afrikaans" & " = af"
		Case 1
			Label5.Text = "Amharic" & " = am"
		Case 2
			Label5.Text = "Arabic" & " = ar"
		Case 3
			Label5.Text = "Arabic_Latin" & " = ar-Latn"
		Case 4
			Label5.Text = "Azerbaijani" & " = az"
		Case 5
			Label5.Text = "Belarusian" & " = be"
		Case 6
			Label5.Text = "Bulgarian" & " = bg"
		Case 7
			Label5.Text = "Bulgarian_Latin" & " = bg-Latn"
		Case 8
			Label5.Text = "Bengali" & " = bn"
		Case 9
			Label5.Text = "Bosnian" & " = bs"
		Case 10
			Label5.Text = "Catalan" & " = ca"
		Case 11
			Label5.Text = "Cebuano" & " = ceb"
		Case 12
			Label5.Text = "Corsican" & " = co"
		Case 13
			Label5.Text = "Czech" & " = cs"
		Case 14
			Label5.Text = "Welsh" & " = cy"
		Case 15
			Label5.Text = "Danish" & " = da"
		Case 16
			Label5.Text = "German" & " = de"
		Case 17
			Label5.Text = "Greek" & " = el"
		Case 18
			Label5.Text = "Greek_Latin" & " = el-Latn"
		Case 19
			Label5.Text = "English" & " = en"
		Case 20
			Label5.Text = "Esperanto" & " = eo"
		Case 21
			Label5.Text = "Spanish" & " = es"
		Case 22
			Label5.Text = "Estonian" & " = et"
		Case 23
			Label5.Text = "Basque" & " = eu"
		Case 24
			Label5.Text = "Persian" & " = fa"
		Case 25
			Label5.Text = "Finnish" & " = fi"
		Case 26
			Label5.Text = "Filipino" & " = fil"
		Case 27
			Label5.Text = "French" & " = fr"
		Case 28
			Label5.Text = "Western_Frisian" & " = fy"
		Case 29
			Label5.Text = "Irish" & " = ga"
		Case 30
			Label5.Text = "Scots_Gaelic" & " = gd"
		Case 31
			Label5.Text = "Galician" & " = gl"
		Case 32
			Label5.Text = "Gujarati" & " = gu"
		Case 33
			Label5.Text = "Hausa" & " = ha"
		Case 34
			Label5.Text = "Hawaiian" & " = haw"
		Case 35
			Label5.Text = "Hebrew" & " = he"
		Case 36
			Label5.Text = "Hindi" & " = hi"
		Case 37
			Label5.Text = "Hindi_Latin" & " = hi-Latn"
		Case 38
			Label5.Text = "Hmong" & " = hmn"
		Case 39
			Label5.Text = "Croatian" & " = hr"
		Case 40
			Label5.Text = "Haitian" & " = ht"
		Case 41
			Label5.Text = "Hungarian" & " = hu"
		Case 42
			Label5.Text = "Armenian" & " = hy"
		Case 43
			Label5.Text = "Indonesian" & " = id"
		Case 44
			Label5.Text = "Igbo" & " = ig"
		Case 45
			Label5.Text = "Icelandic" & " = is"
		Case 46
			Label5.Text = "Italian" & " = it"
		Case 47
			Label5.Text = "Japanese" & " = ja"
		Case 48
			Label5.Text = "Japanese_Latin" & " = ja-Latn"
		Case 49
			Label5.Text = "Javanese" & " = jv"
		Case 50
			Label5.Text = "Georgian" & " = ka"
		Case 51
			Label5.Text = "Kazakh" & " = kk"
		Case 52
			Label5.Text = "Khmer" & " = km"
		Case 53
			Label5.Text = "Kannada" & " = kn"
		Case 54
			Label5.Text = "Korean" & " = ko"
		Case 55
			Label5.Text = "Kurdish" & " = ku"
		Case 56
			Label5.Text = "Kyrgyz" & " = ky"
		Case 57
			Label5.Text = "Latin" & " = la"
		Case 58
			Label5.Text = "Luxembourgish" & " = lb"
		Case 59
			Label5.Text = "Lao" & " = lo"
		Case 60
			Label5.Text = "Lithuanian" & " = lt"
		Case 61
			Label5.Text = "Latvian" & " = lv"
		Case 62
			Label5.Text = "Malagasy" & " = mg"
		Case 63
			Label5.Text = "Maori" & " = mi"
		Case 64
			Label5.Text = "Macedonian" & " = mk"
		Case 65
			Label5.Text = "Malayalam" & " = ml"
		Case 66
			Label5.Text = "Mongolian" & " = mn"
		Case 67
			Label5.Text = "Marathi" & " = mr"
		Case 68
			Label5.Text = "Malay" & " = ms"
		Case 69
			Label5.Text = "Maltese" & " = mt"
		Case 70
			Label5.Text = "Burmese" & " = my"
		Case 71
			Label5.Text = "Nepali" & " = ne"
		Case 72
			Label5.Text = "Dutch" & " = nl"
		Case 73
			Label5.Text = "Norwegian" & " = no"
		Case 74
			Label5.Text = "Nyanja" & " = ny"
		Case 75
			Label5.Text = "Punjabi" & " = pa"
		Case 76
			Label5.Text = "Polish" & " = pl"
		Case 77
			Label5.Text = "Pashto" & " = ps"
		Case 78
			Label5.Text = "Portuguese" & " = pt"
		Case 79
			Label5.Text = "Romanian" & " = ro"
		Case 80
			Label5.Text = "Russian" & " = ru"
		Case 81
			Label5.Text = "Russian_Latin" & " = ru-Latn"
		Case 82
			Label5.Text = "Sindhi" & " = sd"
		Case 83
			Label5.Text = "Sinhala" & " = si"
		Case 84
			Label5.Text = "Slovak" & " = sk"
		Case 85
			Label5.Text = "Slovenian" & " = sl"
		Case 86
			Label5.Text = "Samoan" & " = sm"
		Case 87
			Label5.Text = "Shona" & " = sn"
		Case 88
			Label5.Text = "Somali" & " = so"
		Case 89
			Label5.Text = "Albanian" & " = sq"
		Case 90
			Label5.Text = "Serbian" & " = sr"
		Case 91
			Label5.Text = "Sesotho" & " = st"
		Case 92
			Label5.Text = "Sundanese" & " = su"
		Case 93
			Label5.Text = "Swedish" & " = sv"
		Case 94
			Label5.Text = "Swahili" & " = sw"
		Case 95
			Label5.Text = "Tamil" & " = ta"
		Case 96
			Label5.Text = "Telugu" & " = te"
		Case 97
			Label5.Text = "Tajik" & " = tg"
		Case 98
			Label5.Text = "Thai" & " = th"
		Case 99
			Label5.Text = "Turkish" & " = tr"
		Case 100
			Label5.Text = "Ukrainian" & " = uk"
		Case 101
			Label5.Text = "Urdu" & " = ur"
		Case 102
			Label5.Text = "Uzbek" & " = uz"
		Case 103
			Label5.Text = "Vietnamese" & " = vi"
		Case 104
			Label5.Text = "Xhosa" & " = xh"
		Case 105
			Label5.Text = "Yiddish" & " = yi"
		Case 106
			Label5.Text = "Yoruba" & " = yo"
		Case 107
			Label5.Text = "Chinese" & " = zh"
		Case 108
			Label5.Text = "Chinese_Latin" & " = zh-Latn"
		Case 109
			Label5.Text = "Zulu" & " = zu"
	End Select
End Sub

Private Sub txtSepr_TextChanged (Old As String, New As String)
	If txtSepr.Text.Length > 1 Then
		Dim lth As Int
		lth = Old.Length - 1
		txtSepr.Text = New.SubString2(lth,1)
	End If
	txtSepr.SelectAll
End Sub

Sub TitleBarAndMoreRefresh
	TitleBarCV1.setMinimizeIcon(Main.loc.Localize("Minimalizuj"))
	TitleBarCV1.setMaximizeIcon(Main.loc.Localize("Maksymalizuj"))
	TitleBarCV1.setCloseIcon(Main.loc.Localize("Zamknij"))
	
	'more refresh
	btnBuild.Text = Main.loc.Localize("Buduj!")
	btnClose.Text = Main.loc.Localize("Wyjście")
	Label1.Text = Main.loc.Localize("Plik:")
	Label2.Text = Main.loc.Localize("Plik wyjściowy:")
	Label3.Text = Main.loc.Localize("Kody dla wszystkich języków obsługiwanych przez Google's ML Kit")
	txtFILE.PromptText = Main.loc.Localize("( plik do tłumaczenia )")
	btnBwse1.Text =  Main.loc.Localize("Przeglądaj")
	btnBwse2.Text =  Main.loc.Localize("Przeglądaj")
	SegmentedSeparator.SetItems(Array(Main.loc.Localize("średnik"),Main.loc.Localize("spacja"),Main.loc.Localize("tabulator"),Main.loc.Localize("przecinek"),"'",Chr(34),". . ."))
	SegmentedSeparator.TooltipText =  Main.loc.Localize("Lista dostępnych separatorów")
	CheckBoxMore.Text = Main.loc.Localize("Inny separator")
	ComboBox1.TooltipText = Main.loc.Localize("Źródło")
	ComboBox2.TooltipText = Main.loc.Localize("Cel")
	SharedCode.CheckInternet.Initialize(RootM,Main.loc.Localize("Połączenie internetowe"),SharedCode.AppName,Main.loc.Localize("Proszę, włącz połączenie internetowe.")&CRLF&CRLF,Main.loc.Localize("Gotowy"),Main.loc.Localize("Anuluj"))
End Sub

'Returns Integer with Yes = 1, No = 0, Cancel = -1
Private Sub MainPageBuildRequest As ResumableSub
	DialogFX.YesButtonText = Main.loc.Localize("Buduj!")
	DialogFX.NoButtonText  = Main.loc.Localize("Anuluj")
	DialogFX.CancelButtonText = ""
	B4XPages.MainPage.UpdateClip(B4XPages.MainPage.MainPages.RootPane, 12)
	Return DialogFX.Dialog(Main.loc.Localize("Dialog"), Main.AppName, Main.loc.Localize("Chcesz rozpocząć tłumaczenie ?") & CRLF & CRLF & "{ " &Label4.Text&" }  →  { "&Label5.Text&" }" & CRLF & CRLF)
End Sub

'Returns Integer with Yes = 1, No = 0, Cancel = -1
Public Sub MainPageCloseRequest As ResumableSub
	DialogFX.YesButtonText = Main.loc.Localize("Zamknij")
	DialogFX.NoButtonText  = Main.loc.Localize("Anuluj")
	DialogFX.CancelButtonText = ""
	B4XPages.MainPage.UpdateClip(B4XPages.MainPage.MainPages.RootPane, 12)
	Return DialogFX.Dialog(Main.loc.Localize("Dialog"), Main.AppName, Main.loc.Localize("Chcesz zamknąć teraz aplikację ?")&CRLF&CRLF)
End Sub

'Returns Integer with Yes = 1, No = 0, Cancel = -1
Private Sub MainPageResumeRequest(InterruptPosition As String) As ResumableSub
	DialogFX.YesButtonText = Main.loc.Localize("Tak")
	DialogFX.NoButtonText  = Main.loc.Localize("Nie")
	DialogFX.CancelButtonText = "Anuluj"
	B4XPages.MainPage.UpdateClip(B4XPages.MainPage.MainPages.RootPane, 12)
	Return DialogFX.Dialog(Main.loc.Localize("Pozycja")&": "&InterruptPosition, Main.AppName, Main.loc.Localize("Czy chcesz wznowić tłumaczenie od ostatnio przerwanej pozycji ?") & CRLF & CRLF)
End Sub

'Returns Integer with Yes = 1, No = 0, Cancel = -1
Private Sub MainPageErrorRequest(LastExceptionMessage As String, InterruptPosition As String) As ResumableSub
	DialogFX.YesButtonText = "OK"
	DialogFX.NoButtonText  = ""
	DialogFX.CancelButtonText = ""
	B4XPages.MainPage.UpdateClip(B4XPages.MainPage.MainPages.RootPane, 12)
	Return DialogFX.Dialog(Main.loc.Localize("Pozycja")&": "&InterruptPosition, Main.AppName, Main.loc.Localize("Proces tłumaczenia został przerwany!") & CRLF & CRLF & LastExceptionMessage)
End Sub

Sub btnSignOut_Click
	Wait For (MainPageCloseRequest) Complete (Result As Int) 'Returns Integer with Yes = 1, No = 0, Cancel = -1
	If Result = 1 Then
		SharedCode.ClearSystemClipboard
		B4XPages.ClosePage(Me)
		ExitApplication2(0)
	End If
End Sub

Sub btnBwse1_Click
	txtFILE.RequestFocus
	Browse(1,txtFILE, "Text files (*.txt | *.csv | *.xlsx)", False)
End Sub

Sub btnBwse2_Click
	txtDB.RequestFocus
	Browse(2,txtDB, "Sqlite Database files (*.db | *.db3 | *.sqlite)", True)
End Sub

Sub btnSegRefresh_Click
	txtSepr.Text = ""
	Main.SeparatorChar = ""
	CheckBoxMore.Checked = False
	SegmentedSeparator.SetItems(Array(Main.loc.Localize("średnik"),Main.loc.Localize("spacja"),Main.loc.Localize("tabulator"),Main.loc.Localize("przecinek"),"'",Chr(34),". . ."))
End Sub

Private Sub Browse(filter As Int, tf As TextField, extension As String, save As Boolean)
	If File.Exists(File.GetFileParent(tf.Text), "") Then fc.InitialDirectory = File.GetFileParent(tf.Text)
	If filter = 1 Then
		fc.SetExtensionFilter(extension, Array As String("*.txt","*.csv","*.xlsx"))
	Else
		fc.SetExtensionFilter(extension, Array As String("*.db","*.db3","*.sqlite"))
	End If
	Dim path As String
	If save Then
		path = fc.ShowSave(MainPages)
	Else
		path = fc.ShowOpen(MainPages)
	End If
	If path <> "" Then tf.Text = path
End Sub

#Region Google Translation (BuildDatabase) 
Sub btnBuild_Click
	If txtDB.Text = "" Or txtFILE.Text = "" Then
		LogMessage(Main.loc.Localize("Wypełnij wymagane pola."), cutils.ICON_WARNING)
		Return
	End If
	Wait For (SharedCode.CheckInternet.Check(True)) Complete(Result As Boolean)
	If Result Then
		BuildDatabaseFromCSV(txtFILE.Text, txtDB.Text)
	Else
		cutils.ShowNotification2("", Main.loc.Localize("Wymagane jest połączenie z internetem."), cutils.ICON_WARNING, MainPages)
	End If
End Sub

Private Sub BuildDatabaseFromCSV (Input As String, Output As String)
	Dim TableSize As Int = 0
	CircularProgressBar1.Value = 0
	If CheckBoxMore.Checked = True Then Main.SeparatorChar = txtSepr.Text
	If Main.SeparatorChar.As(String).Length > 1 Then
		LogMessage(Main.loc.Localize("Wybierz odpowiedni separator."), cutils.ICON_WARNING)
		Return
	End If

	Wait For (MainPageBuildRequest) Complete (Result As Int) 'Returns Integer with Yes = 1, No = 0, Cancel = -1
	If Result = 0 Then
		Return
	End If

	If Main.SeparatorChar <> "" Then
		Dim parser As CSVParser
		parser.Initialize
		Dim table As List = parser.Parse(File.ReadString(Input, ""), Main.SeparatorChar, False)
	Else
		Dim table As List = File.ReadList(Input, "")
	End If
	
	If table.IsInitialized = False Or table.Size = 0 Then
		cutils.ShowNotification2(Input, Main.loc.Localize("Nie znaleziono wiersza językowego!"), cutils.ICON_ERROR, MainPages)
		Return
	Else
		TableSize = table.Size
	End If

	If sql.IsInitialized Then sql.Close
	sql.InitializeSQLite(Output, "", True)
	
	Dim translationsfile, initializesqlite As String
	Dim resultset As Int = 0
	
	If Main.kvs.ContainsKey("translationsfile") And Main.kvs.ContainsKey("initializesqlite") And Main.kvs.ContainsKey("resultset") Then
		translationsfile = Main.kvs.Get("translationsfile")
		initializesqlite = Main.kvs.Get("initializesqlite")
		       resultset = Main.kvs.Get("resultset")
		
		If Input.EqualsIgnoreCase(translationsfile) = True And Output.EqualsIgnoreCase(initializesqlite) = True Then
			'Continue translation from file
			Wait For (MainPageResumeRequest(resultset)) Complete (Result As Int) 'Returns Integer with Yes = 1, No = 0, Cancel = -1
			Select Result
				Case 1
					If TableSize < resultset Then
						cutils.ShowNotification2(Input, Main.loc.Localize("Nie znaleziono wiersza językowego!"), cutils.ICON_WARNING, MainPages)
						If sql.IsInitialized Then sql.Close
						Return
					End If
				Case 0
					resultset = 0
					Main.kvs.Put("resultset",0)
				Case Else
					If sql.IsInitialized Then sql.Close
					Return
			End Select
		End If
	Else
		Main.kvs.Put("translationsfile", Input)
		Main.kvs.Put("initializesqlite", Output)
		Main.kvs.Put("resultset",0)
	End If
	
	Try

		If SharedCode.DBTableExists(sql,"data") = False Then
			sql.ExecNonQuery("CREATE TABLE data (key TEXT, lang TEXT, value TEXT, PRIMARY KEY (lang, key))")
			sql.ExecNonQuery("REINDEX TABLE data")
		End If

		#Region ©.Google Translation -------------------------------------------------------------------------------------------------------------

		For stps = resultset To TableSize - 1
			sRow = table.Get(stps)
			CircularProgressBar1.Value = ((100 * stps) / TableSize) - 1
			sql.BeginTransaction
			Wait For (SharedCode.goGoogleTranslation(sql,sRow,ComboBox1.Value,ComboBox2.Value)) Complete (Results As Boolean)
			If Results = True Then
				sql.TransactionSuccessful 'commits the statements and ends the transaction
			Else
				sql.Rollback 'no changes
				sql.Close
				Main.kvs.Put("resultset",stps)
				Wait For (MainPageErrorRequest(LastException.Message, stps)) Complete (Result As Int) 'Returns Integer with Yes = 1, No = 0, Cancel = -1
				CircularProgressBar1.Value = 0
				Return
			End If
		Next

		#End Region ------------------------------------------------------------------------------------------------------------------------------

		sql.Close
		Main.kvs.Put("resultset",0)
		CircularProgressBar1.Value = 0
		LogMessage(Main.loc.Localize("Baza danych utworzona pomyślnie!"), cutils.ICON_INFORMATION)
	Catch
		sql.Rollback 'no changes
		sql.Close
		LogMessage("Error!" & CRLF & LastException.Message, cutils.ICON_ERROR)
		ExitApplication2(0)
	End Try
End Sub

Public Sub LogMessage(msg As String, Icon As Int)
	cutils.ShowNotification2("", msg, Icon, MainPages)
End Sub
#End Region