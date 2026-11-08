B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'Example Form Template Based on FormsBuilder .json Output

'1. CallSub2(CallBack, "ExampleForm_Closed", NumTries, prefdialog.PrefItems) will be called on closing
'2. If there are 'required' items, the Required note can be shown at the top of the form
'3. If the user tries up to the MaxTries, the form will close
'	 -1 will put no limits, but will not let the user close the form if there is an error
'4. #Regions 'Form Specification' and 'Form Validation' need to be modified for each form, the rest is common to all forms
'5. I would recommend not adding more fields than fit on the form. Scrolling would risk the user missing things.
'	It would be better to split a big form into individual smaller forms. That would be quick and easy to do with this approach.

Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private CallBack, pdia As Object
	Private JString, RequiredNote As String
	Private requiredColor, NumRetries, errorIndex As Int

	Public prefdialog As PreferencesDialog		'Public so that PreferencesDialog methods can be used elsewhere
	Public Data As Map							'Public so that the calling module can access the results
	Public MaxRetries As Int						'Public so that the calling module can add logic
End Sub

Public Sub Initialize(CallBack_ As Object) As Object
	CallBack = CallBack_
	
#Region Form Specification	
	RequiredNote = "* marked info is required"
	MaxRetries = 3
	NumRetries = -1
	
	'JString = File.ReadString(File.DirAssets, "example.json")
	'Or...
	
	toWilFormat					'See #Region Optional
	'Paste Log, remove excess lines, and uncomment
	Dim spacer As String = $"{"title": "", "type": "Separator", "key": "", "required": False}"$
	JString = $"
		{"Theme": "Light Theme",
		    "Items": [
				{"title": "May I?", "type": "Boolean", "key": "proceed", "required": false},${spacer},
				{"title": "Your Name", "type": "Text", "key": "name", "required": true},${spacer},${spacer},${spacer},
				{"title": "When will you complete this?", "type": "Date", "key": "today", "required": false},${spacer},
				{"title": "Basic color?", "type": "Options", "key": "colors", "required": false,
					"options": [White, Black, Red, Green, Blue]
				}
		    ]
		}
	"$
	Data = CreateMap("colors": "Black")		'Other values can be preset after this module is initialized
#End Region

	Return Me
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	
#Region Form Vertical Layout and Colors (Common to all forms)
'The following set the colors of all the parts depending on dark/light theme - defined by Root.Color
	Root.Color = 0xFFFFFFFF
	B4XPages.SetTitle(Me, "Sample Form")
	requiredColor = xui.Color_Red
	Dim pnl As B4XView = xui.CreatePanel("")
	Root.AddView(pnl, Root.Width / 2 - 200dip, Root.Height / 2 - 200dip, 400dip, 400dip)
	prefdialog.Initialize(pnl, "", 400dip, 400dip)
	'This is not needed in B4A - the scrollbar won't show if there is no overflow
#If B4J
	prefdialog.CustomListView1.sv.As(ScrollPane).SetVScrollVisibility("NEVER")
#End If
	prefdialog.LoadFromJson(JString)
	If prefdialog.Theme = prefdialog.THEME_DARK Then
		Root.Color = 0xFF555555
		requiredColor = xui.Color_RGB(255, 255, 0)
	End If
	prefdialog.Dialog.BorderWidth = 0
	prefdialog.SeparatorBackgroundColor = xui.Color_Transparent
	prefdialog.ItemsBackgroundColor = Root.Color
	prefdialog.SeparatorBackgroundColor = Root.Color
	prefdialog.SeparatorTextColor = Root.Color
	prefdialog.Dialog.BackgroundColor = Root.Color
	
	If RequiredNote.Trim.Length > 0 Then			'Set to RequiredNote = "" if not needed
		Dim required As B4XView = XUIViewsUtils.CreateLabel
		required.TextColor = requiredColor
		required.SetTextAlignment("CENTER", "CENTER")
		required.Text = RequiredNote
		Root.AddView(required, Root.Width / 2 - 100dip, 5dip, 200dip, 20dip)
	End If
	
	Dim btn As Button	'This btn won't be visible, but will accept auto focus
	btn.Initialize("")	' - without it the first text field will get focus after error msgBox closes in B4J.
	Root.AddView(btn, -100dip, -100dip, 1dip, 1dip)
#End Region

End Sub

Private Sub B4XPage_Appear
	If MaxRetries > -1 Then NumRetries = NumRetries + 1
	If NumRetries = MaxRetries Then
		CallSub3(CallBack, "Example_Closed", NumRetries, prefdialog.PrefItems)
		B4XPages.ClosePage(Me)
		Return
	End If
	pdia = prefdialog.ShowDialog(Data, "", "")				'Note that the normal Wait For is deferred to the B4XPage_CloseRequest sub
	
#Region CLV Colors (Common to all forms)
	prefdialog.CustomListView1.GetBase.Color = Root.color	'Some of the colors need to be set after the underlying CLV is ready
	prefdialog.CustomListView1.sv.Color = Root.color
	prefdialog.CustomListView1.sv.ScrollViewInnerPanel.Color = Root.color
	For i = 0 To prefdialog.CustomListView1.Size - 1
		prefdialog.CustomListView1.GetPanel(i).Color = Root.Color
	Next
#End Region

End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	prefdialog.Dialog.Close(xui.DialogResponse_Positive)	'The prefdialog won't finish by itself
	Wait For (pdia) Complete (Result As Int)				'Without this, the data won't be ready

#Region Form Validation
	For i = 0 To prefdialog.PrefItems.Size - 1
		Dim pi As B4XPrefItem = prefdialog.PrefItems.Get(i)
		If pi.ItemType = prefdialog.TYPE_SEPARATOR Then Continue
		Dim answer As Object = Data.Get(pi.Key)
		Select pi.Key
			Case "proceed"
				If answer = False Then 
					xui.MsgboxAsync("You have to give permission to proceed", "Notice")   'When OK is clicked the MsgBox_Result event handler is called.
					errorIndex = i
					B4XPage_Appear
					Return False
				End If
			Case "today"
				Dim dif As Period = DateUtils.PeriodBetweenInDays(DateTime.Now, answer)
				If dif.days < 0 Then
					xui.MsgboxAsync("Completion date can't come before today's date", "Error")
					errorIndex = i
					B4XPage_Appear
					Return False
				End If
			Case "name"
				Data.Put("name", CamelCase(Data.Get("name")))		'An example to capialize a name
			Case Else
				'Handle other items if needed
		End Select
	Next
#End Region

	CallSub3(CallBack, "Example_Closed", NumRetries, prefdialog.PrefItems)
	Return True
End Sub

#Region Optional JSON formater (Common to all forms)
'You don't need to use this, but I like to see the form schema on top of this module.  Just paste what is on the clipboard and uncomment.
Public Sub toWilFormat
	Dim JSON As JSONParser
	Dim Map1 As Map
	JSON.Initialize(File.ReadString(File.DirAssets, "example.json"))
	Map1 = JSON.NextObject
	Dim theme As String = Map1.Get("Theme")
	Dim items As List = Map1.Get("Items")
	Dim sb As StringBuilder
	sb.Initialize
	Dim spacerLiteral As String = "${spacer}"
	For Each item As Map In items
		Dim thistype As String = item.Get("type")
		If thistype = "Separator" Then
			If sb.Length > 0 Then sb.Remove(sb.Length - 1, sb.Length)
			sb.Append($"${spacerLiteral},"$).Append(CRLF)
		Else
			Dim thistitle As String = item.Get("title")
			Dim thiskey As String = item.Get("key")
			Dim thisrequired As String = item.Get("required")
			If item.containsKey("options") Then
				sb.Append("'				").Append($"{"title": "${thistitle}", "type": "${thistype}", "key": "${thiskey}", "required": ${thisrequired},"$).Append(CRLF)
				sb.Append($"'					"options": ["$)
				Dim optionList As List = item.Get("options")
				For Each s As String In optionList
					sb.Append(s).Append(", ")
				Next
				If sb.Length > 0 Then sb.Remove(sb.Length - 2, sb.Length)
				sb.Append("]").Append(CRLF)
				sb.Append("'				}").Append(CRLF)
			Else
				sb.Append("'				").Append($"{"title": "${thistitle}", "type": "${thistype}", "key": "${thiskey}", "required": ${thisrequired}},"$).Append(CRLF)
			End If
		End If
	Next
	
	Log("'	Dim spacer As String = $" & QUOTE & "{" & $""title": "", "type": "Separator", "key": "", "required": False}""$ & "$")
	Dim itemsString As String = sb.toString
	Dim lit1 As String = "'	JString = $" & QUOTE
	Dim lit2 As String = "'	" & QUOTE & "$"
	
	Dim WilJString As String = $"
${lit1}
'		{"Theme": "${theme}",
'		    "Items": [
${itemsString}
'		    ]
'		}
${lit2}
	"$
	Log(WilJString)
End Sub
#End Region

#Region Utilities (Common to all forms)
Private Sub MsgBox_Result (Result As Int)	'called when msgbox closes
	'Copied from B4XPreferenceDialogs - it makes the error item wiggle after the user clicks ok to the message. Very good!
	prefdialog.CustomListView1.JumpToItem(errorIndex)
	Dim p As B4XView = prefdialog.CustomListView1.GetPanel(errorIndex)
	For i = 0 To 3
		Dim duration As Int = 100 - i * 20
		p.SetLayoutAnimated(duration, -10dip, 0, p.Width, p.Height)
		Sleep(duration)
		p.SetLayoutAnimated(duration, 10dip, 0, p.Width, p.Height)
		Sleep(duration)
	Next
	p.SetLayoutAnimated(50, 0, 0, p.Width, p.Height)
End Sub

Private Sub CamelCase(s As String) As String
	s = s.Replace("-", " ").Replace("_", " ")
	Dim v() As String = Regex.Split(" ", s)
	Dim sb As StringBuilder
	sb.Initialize
	For Each t As String In v
		If t.Length > 0 Then
			sb.Append(t.substring2(0, 1).toupperCase).Append(t.substring(1).toLowerCase)
		End If
	Next
	Return sb.ToString
End Sub
#End Region
