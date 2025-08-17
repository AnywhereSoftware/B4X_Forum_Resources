B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Class Module DialogsX for Library jRLDialogsX

Private Sub Class_Globals
	'Set the version. Ensure this entry aligns with Main Project Attributes #LibraryVersion: 1.88
	Public Version As String = "1.88"
	'
	Private joInlineJava As JavaObject
	Private mParentForm As Form
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	joInlineJava = Me
End Sub

#Region LOCALISATION
'Set / Get the Username Label
'Use <code>
'Dlg.UsernameLabel = "Username:"
'Dim usernamelabel As String = Dlg.UsernameLabel
'</code>
Public Sub setUsernameLabel(lbl As String)
	joInlineJava.RunMethod("SetUsernameLabel", Array(lbl))
End Sub

Public Sub getUsernameLabel As String
	Return joInlineJava.RunMethod("GetUsernameLabel", Null)
End Sub

'Set / Get the Username Prompt
'Use <code>
'Dlg.UsernamePrompt = "Enter Username"
'Dim usernameprompt As String = Dlg.UsernamePrompt
'</code>
Public Sub setUsernamePrompt(prompt As String)
	joInlineJava.RunMethod("SetUsernamePrompt", Array(prompt))
End Sub

Public Sub getUsernamePrompt As String
	Return joInlineJava.RunMethod("GetUsernamePrompt", Null)
End Sub

'Set / Get the Password Label
'Use <code>
'Dlg.PasswordLabel = "Password:"
'Dim passwordlabel As String = Dlg.PasswordLabel
'</code>
Public Sub setPasswordLabel(lbl As String)
	joInlineJava.RunMethod("SetPasswordLabel", Array(lbl))
End Sub

Public Sub getPasswordLabel As String
	Return joInlineJava.RunMethod("GetPasswordLabel", Null)
End Sub

'Set / Get the Password Prompt
'Use <code>
'Dlg.PasswordPrompt = "Enter Password"
'Dim passwordprompt As String = Dlg.PasswordPrompt
'</code>
Public Sub setPasswordPrompt(prompt As String)
	joInlineJava.RunMethod("SetPasswordPrompt", Array(prompt))
End Sub

Public Sub getPasswordPrompt As String
	Return joInlineJava.RunMethod("GetPasswordPrompt", Null)
End Sub

'Set / Get the OK Button Text
'Use <code>
'Dlg.OKButtonText = "OK"
'Dim okbuttontext As String = Dlg.OKButtonText
'</code>
Public Sub setOKButtonText(txt As String)
	joInlineJava.RunMethod("SetOKButtonText", Array(txt))
End Sub
Public Sub getOKButtonText As String
	Return joInlineJava.RunMethod("GetOKButtonText", Null)
End Sub

'Set the OK Button Style
'Use <code>
'Dlg.OKButtonStyle = "-fx-font-size: 24px;-fx-background-color: indianred;"
'</code>
Public Sub setOKButtonStyle(stl As String)
	joInlineJava.RunMethod("SetOKButtonStyle", Array(stl))
End Sub

'Set / Get the Cancel Button Text
'Use <code>
'Dlg.CancelButtonText = "Cancel"
'Dim cancelbuttontext As String = Dlg.CancelButtonText
'</code>
Public Sub setCancelButtonText(txt As String)
	joInlineJava.RunMethod("SetCancelButtonText", Array(txt))
End Sub
Public Sub getCancelButtonText As String
	Return joInlineJava.RunMethod("GetCancelButtonText", Null)
End Sub

'Set the Cancel Button Style
'Use <code>
'Dlg.CancelButtonStyle = "-fx-font-size: 24px;-fx-background-color: indianred;"
'</code>
Public Sub setCancelButtonStyle(stl As String)
	joInlineJava.RunMethod("SetCancelButtonStyle", Array(stl))
End Sub

'Set / Get the YES Button Text
'Use <code>
'Dlg.YesButtonText = "YES"
'Dim yesbuttontext As String = Dlg.YesButtonText
'</code>
Public Sub setYesButtonText(txt As String)
	joInlineJava.RunMethod("SetYesButtonText", Array(txt))
End Sub
Public Sub getYesButtonText As String
	Return joInlineJava.RunMethod("GetYesButtonText", Null)
End Sub

'Set the Yes Button Style
'Use <code>
'Dlg.YesButtonStyle = "-fx-font-size: 24px;-fx-background-color: indianred;"
'</code>
Public Sub setYesButtonStyle(stl As String)
	joInlineJava.RunMethod("SetYesButtonStyle", Array(stl))
End Sub

'Set / Get the NO Button Text
'Use <code>
'Dlg.NoButtonText = "NO"
'Dim nobuttontext As String = Dlg.NoButtonText
'</code>
Public Sub setNoButtonText(txt As String)
	joInlineJava.RunMethod("SetNoButtonText", Array(txt))
End Sub
Public Sub getNoButtonText As String
	Return joInlineJava.RunMethod("GetNoButtonText", Null)
End Sub

'Set the No Button Style
'Use <code>
'Dlg.NoButtonStyle = "-fx-font-size: 24px;-fx-background-color: indianred;"
'</code>
Public Sub setNoButtonStyle(stl As String)
	joInlineJava.RunMethod("SetNoButtonStyle", Array(stl))
End Sub

'Set / Get the Previous Button Text
'Use <code>
'Dlg.PreviousButtonText = "<"
'Dim prevbuttontext As String = Dlg.PreviousButtonText
'</code>
Public Sub setPreviousButtonText(txt As String)
	joInlineJava.RunMethod("SetPreviousButtonText", Array(txt))
End Sub
Public Sub getPreviousButtonText As String
	Return joInlineJava.RunMethod("GetPreviousButtonText", Null)
End Sub

'Set the Previous Button Style
'Use <code>
'Dlg.PreviousButtonStyle = "-fx-font-size: 24px;-fx-background-color: indianred;"
'</code>
Public Sub setPreviousButtonStyle(stl As String)
	joInlineJava.RunMethod("SetPreviousButtonStyle", Array(stl))
End Sub

'Set / Get the Next Button Text
'Use <code>
'Dlg.NextButtonText = ">"
'Dim nextbuttontext As String = Dlg.NextButtonText
'</code>
Public Sub setNextButtonText(txt As String)
	joInlineJava.RunMethod("SetNextButtonText", Array(txt))
End Sub
Public Sub getNextButtonText As String
	Return joInlineJava.RunMethod("GetNextButtonText", Null)
End Sub

'Set the Next Button Style
'Use <code>
'Dlg.NextButtonStyle = "-fx-font-size: 24px;-fx-background-color: indianred;"
'</code>
Public Sub setNextButtonStyle(stl As String)
	joInlineJava.RunMethod("SetNextButtonStyle", Array(stl))
End Sub

'Set / Get the Login Button Text
'Use <code>
'Dlg.LoginButtonText = "Login"
'Dim loginnbuttontext As String = Dlg.LoginButtonText
'</code>
Public Sub setLoginButtonText(txt As String)
	joInlineJava.RunMethod("SetLoginButtonText", Array(txt))
End Sub
Public Sub getLoginButtonText As String
	Return joInlineJava.RunMethod("GetLoginButtonText", Null)
End Sub

'Set the Login Button Style
'Use <code>
'Dlg.LoginButtonStyle = "-fx-font-size: 24px;-fx-background-color: indianred;"
'</code>
Public Sub setLoginButtonStyle(stl As String)
	joInlineJava.RunMethod("SetLoginButtonStyle", Array(stl))
End Sub

'Set / Get the Select Button Text
'Use <code>
'Dlg.SelectButtonText = "Select"
'Dim selectbuttontext As String = Dlg.SelectButtonText
'</code>
Public Sub setSelectButtonText(txt As String)
	joInlineJava.RunMethod("SetSelectButtonText", Array(txt))
End Sub
Public Sub getSelectButtonText As String
	Return joInlineJava.RunMethod("GetSelectButtonText", Null)
End Sub

'Set the Select Button Style
'Use <code>
'Dlg.SelectButtonStyle = "-fx-font-size: 24px;-fx-background-color: indianred;"
'</code>
Public Sub setSelectButtonStyle(stl As String)
	joInlineJava.RunMethod("SetSelectButtonStyle", Array(stl))
End Sub

'Set / Get the Extended Dialog Show More Details Hyperlink Button Text
'Use <code>
'Dlg.ExtendedDialogShowMoreDetailsText = "More..."
'Dim ExtendedDialogShowMoreDetailsText As String = Dlg.ExtendedDialogShowMoreDetailsText
'</code>
Public Sub setExtendedDialogShowMoreDetailsText(txt As String)
	joInlineJava.RunMethod("SetExtendedDialogShowMoreDetailsText", Array(txt))
End Sub
Public Sub getExtendedDialogShowMoreDetailsText As String
	Return joInlineJava.RunMethod("GetExtendedDialogShowMoreDetailsText", Null)
End Sub

'Set / Get the Extended Dialog Show Less Details Hyperlink Button Text
'Use <code>
'Dlg.ExtendedDialogShowLessDetailsText = "Less..."
'Dim ExtendedDialogShowLessDetailsText As String = Dlg.ExtendedDialogShowLessDetailsText
'</code>
Public Sub setExtendedDialogShowLessDetailsText(txt As String)
	joInlineJava.RunMethod("SetExtendedDialogShowLessDetailsText", Array(txt))
End Sub
Public Sub getExtendedDialogShowLessDetailsText As String
	Return joInlineJava.RunMethod("GetExtendedDialogShowLessDetailsText", Null)
End Sub

'Set / Get the MessageHTML Dialog Show More Details Hyperlink Button Text
'Use <code>
'Dlg.MessageHTMLDialogShowMoreDetailsText = "More..."
'Dim MessageHTMLDialogShowMoreDetailsText As String = Dlg.MessageHTMLDialogShowMoreDetailsText
'</code>
Public Sub setMessageHTMLDialogShowMoreDetailsText(txt As String)
	joInlineJava.RunMethod("SetMessageHTMLDialogShowMoreDetailsText", Array(txt))
End Sub
Public Sub getMessageHTMLDialogShowMoreDetailsText As String
	Return joInlineJava.RunMethod("GetMessageHTMLDialogShowMoreDetailsText", Null)
End Sub

'Set / Get the MessageHTML Dialog Show Less Details Hyperlink Button Text
'Use <code>
'Dlg.MessageHTMLDialogShowLessDetailsText = "Less..."
'Dim MessageHTMLDialogShowLessDetailsText As String = Dlg.MessageHTMLDialogShowLessDetailsText
'</code>
Public Sub setMessageHTMLDialogShowLessDetailsText(txt As String)
	joInlineJava.RunMethod("SetMessageHTMLDialogShowLessDetailsText", Array(txt))
End Sub
Public Sub getMessageHTMLDialogShowLessDetailsText As String
	Return joInlineJava.RunMethod("GetMessageHTMLDialogShowLessDetailsText", Null)
End Sub

'Set / Get the MessageDialog Show More Details Hyperlink Button Text
'Use <code>
'Dlg.MessageDialogShowMoreDetailsText = "More..."
'Dim MessageDialogShowMoreDetailsText As String = Dlg.MessageDialogShowMoreDetailsText
'</code>
Public Sub setMessageDialogShowMoreDetailsText(txt As String)
	joInlineJava.RunMethod("SetMessageDialogShowMoreDetailsText", Array(txt))
End Sub
Public Sub getMessageDialogShowMoreDetailsText As String
	Return joInlineJava.RunMethod("GetMessageDialogShowMoreDetailsText", Null)
End Sub

'Set / Get the MessageDialog Show Less Details Hyperlink Button Text
'Use <code>
'Dlg.MessageDialogShowLessDetailsText = "Less..."
'Dim MessageDialogShowLessDetailsText As String = Dlg.MessageDialogShowLessDetailsText
'</code>
Public Sub setMessageDialogShowLessDetailsText(txt As String)
	joInlineJava.RunMethod("SetMessageDialogShowLessDetailsText", Array(txt))
End Sub
Public Sub getMessageDialogShowLessDetailsText As String
	Return joInlineJava.RunMethod("GetMessageDialogShowLessDetailsText", Null)
End Sub

'LOCALIZATION END
#End Region

#Region SetParentWindow
'Set the parent window for the dialogs.
'ParentForm - Form to be used as parent window.
'Use <code>
'SetParentWindow(MainForm)
'</code>
'<b>Notes:</b>
'To reset the parentwindow, call SetParentWindow(Null).
'The parent window can not be set for the ToastMessage dialog.
Public Sub SetParentWindow(ParentForm As Form)
	If ParentForm = Null Then
		joInlineJava.RunMethod("SetParentWindow", Array(Null))
	Else
		Dim joForm As JavaObject = ParentForm.RootPane
		Dim joStage As JavaObject = joForm.RunMethodJO("getScene", Null).RunMethod("getWindow", Null)
		joInlineJava.RunMethod("SetParentWindow", Array(joStage))
	End If
	mParentForm = ParentForm
End Sub
#End Region

#Region InformationDialog
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Content - string to show in the content area (below the header).
'Returns: None.
Public Sub InformationDialog(Title As String , Header As String, Content As String)
	joInlineJava.RunMethod("InformationDialog", Array(Title, Header, Content))
End Sub
#End Region

#Region ExtendedDialog
'Get / Set the option to show the content of the ExtendedDialog expanded.
'Expanded - False = do not expand the textarea with extended information.
'Returns: None.
Public Sub setExtendedDialogExpanded(Expanded As Boolean)
	joInlineJava.RunMethod("SetExtendedDialogExpanded", Array(Expanded))
End Sub
Public Sub getExtendedDialogExpanded As Boolean
	Return joInlineJava.RunMethod("GetExtendedDialogExpanded", Null)
End Sub

'Get / Set the option to hide or show the details hyperlink button of the ExtendedDialog.
Public Sub setExtendedDialogHideDetails(Hide As Boolean)
	joInlineJava.RunMethod("SetExtendedDialogHideDetails", Array(Hide))
End Sub
Public Sub getExtendedDialogHideDetails As Boolean
	Return joInlineJava.RunMethod("GetExtendedDialogHideDetails", Null)
End Sub

'Show an Extended Dialog which has a expandable Textarea. The textarea is by default not expanded.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Content - string to show in the content area (below the header).
'Extended Content - string to show in a text area if the clicked on the show details options.
'Returns: None.
Public Sub ExtendedDialog(Title As String , Header As String, Content As String, ContentExtended As String)
	joInlineJava.RunMethod("ExtendedDialog", Array(Title, Header, Content, ContentExtended))
End Sub
'EXTENDEDDIALOG
#End Region

#Region WarningDialog
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Content - string to show in the content area (below the header).
'Returns: None.
Public Sub WarningDialog(Title As String , Header As String, Content As String)
	joInlineJava.RunMethod("WarningDialog", Array(Title, Header, Content))
End Sub
#End Region

#Region ErrorDialog
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Content - string to show in the content area (below the header).
'Returns: None.
Public Sub ErrorDialog(Title As String , Header As String, Content As String)
	joInlineJava.RunMethod("ErrorDialog", Array(Title, Header, Content))
End Sub
#End Region

#Region ConfirmationDialog
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Content - string to show in the content area (below the header).
'Returns: True for OK or False for Cancel.
Public Sub ConfirmationDialog(Title As String , Header As String, Content As String) As Boolean
	Return joInlineJava.RunMethod("ConfirmationDialog", Array(Title, Header, Content))
End Sub
#End Region

#Region YesNoCancelDialog
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Content - string to show in the content area (below the header).
'Returns: Integer with Yes = 1, No = 0, Cancel = -1.
Public Sub YesNoCancelDialog(Title As String , Header As String, Content As String) As Int
	Return joInlineJava.RunMethod("YesNoCancelDialog", Array(Title, Header, Content))
End Sub
#End Region

#Region AlertSelectionDialog
'Alert dialog with button selection option.
'The alert is from type Confirmation. It is mandatory to select an option.
'Note if there are many buttons, the dialog window is rather large.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Content - string to show in the content area (below the header).
'Buttons - string array with button text.
'Returns: Integer starting with 0 .. number of buttons - 1.
'Use <code>
'Dim buttons() As String = Array As String ("A", "B", "C", "D", "E")
'Dim selection As Int = AlertSelectionDialog("Title", "Select an option", $""$, buttons)
'Log($"Selected option: index=${selection}, buttontext=${buttons(selection)}"$)
'</code>
Public Sub AlertSelectionDialog(Title As String , Header As String, Content As String, Buttons() As String) As Int
	Return joInlineJava.RunMethod("AlertSelectionDialog", Array(Title, Header, Content, Buttons))
End Sub
#End Region

#Region CustomAlertDialog
'Custom Alert Dialog which is highly configurable.
'AlertType - String CONFIRMATION, ERROR, INFORMATION, NONE, WARNING. The default is INFORMATION.
'Title - String with the title bar text. If empty, the title bar is not shown.
'Header - String with the header text.
'Content - String with the content text.
'PrefWidth - Pref width of the dialog window. Set to -1 uses the system default. If not -1, ensure to set the right width.
'PrefHeight - Pref height of the dialog window. Set to -1 uses the system default. If not -1, ensure to set the right height.
'StageStyle - String DECORATED, TRANSPARENT, UNDECORATED, UNIFIED, UTILITY. The default is UTILITY.
'DialogStyle - String defining the CSS dialog style.
'HeaderStyle - String defining the CSS header style.
'ContentStyle - String defining the CSS content style.
'ButtonYesText - String setting the YES button text. If empty, the button is not displayed.
'ButtonNoText - String setting the NO button text. If empty, the button is not displayed.
'ButtonCancelText - String setting the CANCEL button text. If empty, the button is not displayed.
'ButtonYesStyle - String defining the CSS style of the YES button.
'ButtonNoStyle - String defining the CSS style of the NO button.
'ButtonCancelStyle - String defining the CSS style of the CANCEL button.
'Returns: Integer with Yes = 1, No = 0, Cancel = -1.
'Use <code>
'Simple dialog with OK button
'Dim DialogStyle As String	= "-fx-background-color: #e2e2e2; -fx-border-color: DarkSlateGray; -fx-border-width: 2; -fx-border-radius: 0;"
'Dim HeaderStyle As String	= "-fx-background-color: cadetblue; -fx-font-style: italic; -fx-font-size: 24px;-fx-text-fill: #FF0000; -fx-font-weight: bold;"
'Dim ContentStyle As String	= "-fx-background-color: #00FF00; -fx-font-size: 33px;-fx-text-fill: #0000FF; -fx-font-weight: bold;"
'Dlg.CustomAlertDialog("INFORMATION", "Information", "Header", $"Content${CRLF}..."$, -1, -1, "TRANSPARENT", DialogStyle, HeaderStyle, ContentStyle, "OK", "", "", "-fx-background-color: #FF0000; -fx-text-fill: #FFFFFF; -fx-font-weight: bold;", "", "")
'</code>
Public Sub CustomAlertDialog(AlertType As String, _ 
	Title As String , Header As String, Content As String, _ 
	PrefWidth As Double, PrefHeight As Double, _ 
	StageStyle As String, DialogStyle As String, HeaderStyle As String, ContentStyle As String, _ 
	ButtonYesText As String, ButtonNoText As String, ButtonCancelText As String, _ 
	ButtonYesStyle As String, ButtonNoStyle As String, ButtonCancelStyle As String) As Int

	'Show the dialog and return the result.
	Return joInlineJava.RunMethod("CustomAlertDialog", _
		Array(AlertType.ToUpperCase, _ 
			Title, Header, Content, _ 
			PrefWidth, PrefHeight, _ 
			StageStyle.ToUpperCase, _ 
			DialogStyle, HeaderStyle, ContentStyle, _ 
			ButtonYesText, ButtonNoText, ButtonCancelText, _ 
			ButtonYesStyle, ButtonNoStyle, ButtonCancelStyle))
End Sub
#End Region

#Region TextInputDialog
'TextInput Dialog with one field.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Label - string to show as label left from the input field.
'Text - string as default for the input field.
'Returns: Text entered as string or an empty string.
Public Sub TextInputDialog(Title As String , Header As String, Label As String, Text As String) As String
	Return joInlineJava.RunMethod("TextInputDialog", Array(Title, Header, Label, Text))
End Sub
#End Region

#Region TextInputDialog2
'TextInputDialog with two fields.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Label1 - Label for field 1
'Label2 - Label for field 2
'Field1 - Default values for field1.
'Field2 - Default values for field2.
'Returns: Map with 2 entries holding field1:textinputfield1, field2:textinputfield2 or if cancelled a non initialized Map.
'Example <code>
'Dim m As Map = Dlg.TextInputDialog2("Text Input Dialog 2", "Name & EMail", "Name", "EMail", "name", "email")
'Log($"${m.Get("field1")} ${m.Get("field2")}"$)
'</code>
Public Sub TextInputDialog2(Title As String , Header As String, Label1 As String, Label2 As String, Field1 As String, Field2 As String) As Map
	Return joInlineJava.RunMethod("TextInputDialog2", Array(Title, Header, Label1, Label2, Field1, Field2))
End Sub
#End Region

#Region TextInputDialog3
'TextInput Dialog with one field with user cancel handling.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Label - string to show as label left from the input field.
'Text - string as default for the input field.
'Returns: Text entered as string or an empty string.
'To test the result of the dialog use i.e. If result.EqualsIgnoreCase(Null) Then ...
Public Sub TextInputDialog3(Title As String , Header As String, Label As String, Text As String) As String
	Return joInlineJava.RunMethod("TextInputDialog3", Array(Title, Header, Label, Text))
End Sub
#End Region

#Region TextInputDialog4
'TextInput Dialog with one field with user cancel handling.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Text - string as default for the input field.
'Width - Width of the input field. Set to 0 to use the default width.
'Returns: Text entered as string or an empty string.
'To test the result of the dialog use i.e. If result.EqualsIgnoreCase(Null) Then ...
'Example <code>
'Dim url As String = Dlg.TextInputDialog4("Text Input Dialog 4", "Enter the URL", "http://www.rwblinn.de", 600)
'lblTextInputDialog.Text = url
'</code>
Public Sub TextInputDialog4(Title As String , Header As String, Text As String, Width As Int) As String
	Return joInlineJava.RunMethod("TextInputDialog4", Array(Title, Header, Text, Width))
End Sub
#End Region

#Region MaskInputDialog
'MaskInput Dialog with one mask formatted field with user cancel handling.
'Title - string to show in the title bar (optional).
'Header - string to show in the dialog header area (optional).
'Label - string to show as label left from the input field (optional).
'Text - string as default for the input field (optional).
'Mask - string containing the mask (mandatory) , i.e. ###_####. Following characters:
'# 	Any valid number, uses Character.isDigit.
'' 	Escape character, used to escape any of the special formatting characters.
'U	Any character (Character.isLetter). All lowercase letters are mapped To upper Case.
'L	Any character (Character.isLetter). All upper Case letters are mapped To lower Case.
'A	Any character Or number (Character.isLetter Or Character.isDigit)
'?	Any character (Character.isLetter).
'*	Anything.
'H	Any hex character (0-9, a-f Or A-F).
'Returns: Formatted text entered as string or an empty string or null in case error.
'To test the result of the dialog use i.e. If result.EqualsIgnoreCase(Null) Then ...
Public Sub MaskInputDialog(Title As String , Header As String, Label As String, Text As String, Mask As String) As String
	Return joInlineJava.RunMethod("MaskInputDialog", Array(Title, Header, Label, Text, Mask))
End Sub
#End Region

#Region MultiInputFieldDialog
'Multi Input Field build from a field map.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Fields- map which holds for each field the pair label:text.
'FieldCount - size of the field map.
'Returns: Map holding for each field the pair fieldN:fieldtext Or if cancelled, a non initialized map.
'N is the fieldnumber, starting with 0. The max number of fields is determined by the Field Map size.
'Example <code>
'SetParentWindow
'Dlg.OKButtonText = tfOKButtonText.Text
'Dim fieldmap As Map = CreateMap("FieldA": "Value FieldA", "FieldB": "Value FieldB", "FieldC": "Value FieldC", "FieldD": "Value FieldD")
'Dim resultmap As Map = Dlg.MultiInputFieldDialog("MultiInputField Title", "Header", fieldmap, fieldmap.size)
''The resultmap holds for each field the pair fieldN:text
'For i = 0 To resultmap.Size - 1
'	Log($"${resultmap.GetKeyAt(i)} = ${resultmap.GetValueAt(i)}"$)
'Next
'</code>
Public Sub MultiInputFieldDialog(Title As String , Header As String, Fields As Map, FieldCount As Int) As Map
	Return joInlineJava.RunMethod("MultiInputFieldDialog", Array(Title, Header, Fields, FieldCount))
End Sub
#End Region

#Region SimpleFormDialog
'Property get / set the SimpleFormDialog content per form row
'If value false, then row contains label : field else row contains label or field.
Public Sub setSimpleFormSplitFields(Value As Boolean)
	joInlineJava.RunMethod("SetSimpleFormSplitFields", Array(Value))
End Sub

Public Sub getSimpleFormSplitFields As Boolean
	Return joInlineJava.RunMethod("GetSimpleFormSplitFields", Null)
End Sub

'Property get / set the SimpleFormDialog width
Public Sub setSimpleFormWidth(width As Int)
	joInlineJava.RunMethod("SetSimpleFormWidth", Array(width))
End Sub

Public Sub getSimpleFormWidth As Int
	Return joInlineJava.RunMethod("GetSimpleFormWidth", Null)
End Sub

'Property get / set the SimpleFormDialog ComboBox editable
Public Sub setSimpleFormComboBoxEditable(editable As Boolean)
	joInlineJava.RunMethod("SetSimpleFormComboBoxEditable", Array(editable))
End Sub

Public Sub getSimpleFormComboBoxEditable As Boolean
	Return 	joInlineJava.RunMethod("GetSimpleFormComboBoxEditable", Null)
End Sub

'Property get / set the SimpleFormDialog ComboBox Value
Public Sub setSimpleFormComboBoxValue(value As String)
	joInlineJava.RunMethod("SetSimpleFormComboBoxValue", Array(value))
End Sub

Public Sub getSimpleFormComboBoxValue As String
	Return 	joInlineJava.RunMethod("GetSimpleFormComboBoxValue", Null)
End Sub

'Property get / set the SimpleFormDialog DatePicker Value
Public Sub setSimpleFormDatePickerValue(value As String)
	joInlineJava.RunMethod("SetSimpleFormDatePickerValue", Array(value))
End Sub

Public Sub getSimpleFormDatePickerValue As String
	Return 	joInlineJava.RunMethod("GetSimpleFormDatePickerValue", Null)
End Sub

'Simple Form Dialog enabling Text- / Password- / Numeric fields.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'FieldList - list of maps. Each map represents a field with id, label, value, fieldtype.
'The fieldtypes (must be uppercase) TextField "T", Password "P" , Numeric "N", TextArea "A", CheckBox "C", ComboBox "B", Datepicker "D"
'Returns: Map with for each field the key:value pair id:value.
'The returned fieldvalues are strings, means for numberfields conversion has to be done manually.
'Example <code>
'Dim fieldlist As List
'fieldlist.Initialize
'fieldlist.Add(CreateMap("id":"textfield", "label":"Textfield", "value":"textfield", "type":"T"))
'fieldlist.Add(CreateMap("id":"numeric", "label":"Numeric", "value":"1958", "type":"N"))
'fieldlist.Add(CreateMap("id":"password", "label":"Password", "value":"password", "type":"P"))
'fieldlist.Add(CreateMap("id":"checkbox", "label":"Checkbox", "value":"1", "type":"C"))
'fieldlist.Add(CreateMap("id":"combobox", "label":"Combobox", "value":"Item 1,Item 2,Item 3", "type":"B"))
'IMPORTANT TO SET THIS FORMAT prior adding datepicker
'DateTime.DateFormat = "yyyy-MM-dd"
'fieldlist.Add(CreateMap("id":"datepicker", "label":"DatePicker", "value":"2019-01-01", "type":"D"))
'Dim resultmap As Map = SimpleFormDialog("jRLDialogsX Simple Form Dialog", "Header", fieldlist)
'If resultmap.IsInitialized Then
'	Dim sb As StringBuilder
'	sb.Initialize
'	For i = 0 To resultmap.Size - 1
'		sb.Append($"${resultmap.GetKeyAt(i)} = ${resultmap.GetValueAt(i)}"$).Append(CRLF)
'	Next
'	Log(sb.tostring)
'End If
'</code> 
Public Sub SimpleFormDialog(Title As String , Header As String, FieldList As List) As Map
	Return joInlineJava.RunMethod("SimpleFormDialog", Array(Title, Header, FieldList))
End Sub

'SIMPLEFORMDIALOG
#End Region

#Region IntegerInputDialog
'Show a Integer Input Dialog
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Label - string to show as label left from the input field.
'Default - default value as integer in range -32768 to +32767.
'Returns: Value or if cancelled the default give.
'Example <code>
'Dim default As Int = 9
'Dim result As Int = IntegerInputDialog("jRLDialogsX Integer Input Dialog", "Header", "Label", default)
'If result <>  default Then
'	Log(result)
'End If
'</code>
Public Sub IntegerInputDialog(Title As String , Header As String, Label As String, Default As Int) As Int
	Return joInlineJava.RunMethod("IntegerInputDialog", Array(Title, Header, Label, Default))
End Sub
#End Region

#Region ChoiceDialog
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Label - string to show as label left from the input field.
'Choices - List
'Defaultitem - Selected item between 0 and choices.size - 1.
'Returns: Selection as string or an empty string.
Public Sub ChoiceDialog(Title As String , Header As String, Label As String, Choices As List, Defaultitem As Int) As String
	If (Defaultitem < 0) Or (Defaultitem > Choices.size - 1) Then Defaultitem = 0
	Return joInlineJava.RunMethod("ChoiceDialog", Array(Title, Header, Label, Choices, Defaultitem))
End Sub
#End Region

#Region LoginDialog
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Returns: Map username:username, password:password.
'If cancel selected, the returned map will not be initialized.
Public Sub LoginDialog(Title As String , Header As String) As Map
	Return joInlineJava.RunMethod("LoginDialog", Array(Title, Header))
End Sub
#End Region

#Region LoginDialog2
'Login Dialog with Icon and default UserName.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Username - string as the default username.
'Returns: Map username:username, password:password.
'If cancel selected, the returned map will not be initialized.
'Note: Ensure the icon file login.png is added to the B4J project.
Public Sub LoginDialog2(Title As String , Header As String, UserName As String) As Map
	Return joInlineJava.RunMethod("LoginDialog2", Array(Title, Header, UserName))
End Sub
#End Region

#Region DidYouKnowDialogs
'Did You Know Dialog with Icon.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Content - string to show in the content area (below the header).
'Returns: None.
Public Sub DidYouKnowDialog(Title As String , Header As String, Content As String) As Map
	Return joInlineJava.RunMethod("DidYouKnowDialog", Array(Title, Header, Content))
End Sub

'Did You Know Dialog 2 with list of did you know strings and icon.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Content - string to show in the content area (below the header).
'Items - string list with did you know's
'DefaultItem - integer between 0 and items.size - 1
'Width - width of the dialog. -1 uses the default 500
'Height - height of the dialog. -1 uses the default 400
'Returns: Last selected did you know string index
Public Sub DidYouKnowDialog2(Title As String , Header As String, Items As List, Defaultitem As Int, Width As Double, Height As Double) As Int
	Dim dyk As DidYouKnowDialog2
	dyk.Initialize(mParentForm, Title, Header, Items, Defaultitem, Width, Height)
	dyk.Button_CloseText = getOKButtonText
	dyk.Button_PreviousTipText = getPreviousButtonText
	dyk.Button_NextTipText = getNextButtonText
	Return dyk.ShowAndWait
End Sub
#End Region

#Region ExceptionDialog
'Exception Dialog in an expanded text area.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Content - string to show in the content area (below the header).
'ExceptionContent - string containing the exception shown in the text area.
'Returns: None.
'Note: For the content, an option is to use LastException.Message and for Ex the LastException.
Public Sub ExceptionDialog(Title As String , Header As String, Content As String, ExceptionContent As Exception)
	joInlineJava.RunMethod("ExceptionDialog", Array(Title, Header, Content, ExceptionContent))
End Sub
#End Region

#Region MessageDialog
'Get / Set the option to show the content of the MessageDialog expanded.
'Expanded - False = do not expand the textarea with extended information.
Public Sub setMessageDialogDialogExpanded(Expanded As Boolean)
	joInlineJava.RunMethod("SetMessageDialogExpanded", Array(Expanded))
End Sub

Public Sub getMessageDialogDialogExpanded As Boolean
	Return joInlineJava.RunMethod("GetMessageDialogExpanded", Null)
End Sub

'Get / Set the option to show the content of the MessageDialog wrapped.
'Wrap - False = do not wrap the textarea with extended information.
Public Sub setMessageDialogWrapText(Wrap As Boolean)
	joInlineJava.RunMethod("SetMessageDialogWrapText", Array(Wrap))
End Sub

Public Sub getMessageDialogWrapText As Boolean
	Return joInlineJava.RunMethod("GetMessageDialogWrapText", Null)
End Sub

'Title - string to show in the title bar.
'Content - string with plain text in an expanded text area.
'Returns: None.
Public Sub MessageDialog(Title As String, Content As String)
	joInlineJava.RunMethod("MessageDialog", Array(Title, Content))
End Sub
#End Region

#Region MessageHTMLDialog
'Get / Set the option to show the content of the MessageHTMLDialog expanded.
'Expanded - False = do not expand the textarea with extended information.
'Returns: None.
Public Sub setMessageHTMLDialogDialogExpanded(Expanded As Boolean)
	joInlineJava.RunMethod("SetMessageHTMLDialogExpanded", Array(Expanded))
End Sub
Public Sub getMessageHTMLDialogDialogExpanded As Boolean
	Return joInlineJava.RunMethod("GetMessageHTMLDialogExpanded", Null)
End Sub

'Get / Set the option to hide or show the details hyperlink button of the MessageHTMLDialog.
Public Sub setMessageHTMLDialogHideDetails(Hide As Boolean)
	joInlineJava.RunMethod("SetMessageHTMLDialogHideDetails", Array(Hide))
End Sub
Public Sub getMessageHTMLDialogHideDetails As Boolean
	Return joInlineJava.RunMethod("GetMessageHTMLDialogHideDetails", Null)
End Sub

'Title - string to show in the title bar.
'Content - string with HTML formatted content in an expanded webview.
'Note - Anchors are handled if defined like [a href="#myanchor"]Jump To myanchor[/a] ... [a name="myanchor"][/a] (replace brackets by left/right arrows).
'Returns: None.
Public Sub MessageHTMLDialog(Title As String, Content As String)
	joInlineJava.RunMethod("MessageHTMLDialog", Array(Title, Content))
End Sub
#End Region

#Region MessageHTMLDialog2
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Content - string with HTML formatted content in an expanded webview.
'Note - Anchors are handled if defined like [a href="#myanchor"]Jump To myanchor[/a] ... [a name="myanchor"][/a] (replace brackets by left/right arrows).
'Note - The content is always expanded and can not be hide.
'Returns: None.
Public Sub MessageHTMLDialog2(Title As String, Header As String, Content As String)
	joInlineJava.RunMethod("MessageHTMLDialog2", Array(Title, Header, Content))
End Sub
#End Region

#Region MessageHTMLDialog3
'Title - string to show in the title bar.
'Content - string with HTML formatted content in an expanded webview.
'Note - Anchors are handled if defined like [a href="#myanchor"]Jump To myanchor[/a] ... [a name="myanchor"][/a] (replace brackets by left/right arrows).
'Returns: True for OK, False for Cancel.
Public Sub MessageHTMLDialog3(Title As String, Content As String) As Boolean
	Return joInlineJava.RunMethod("MessageHTMLDialog3", Array(Title, Content))
End Sub
#End Region

#Region ListDialog
'List Dialog with single selection.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Items - List of items to select
'Defaultitem - set between 0 - items.size - 1. If -1, then no item selected.
'Returns: Selected item as String or an empty String.
Public Sub ListDialog(Title As String, Header As String, Items As List, Defaultitem As Int) As String
	' If (Defaultitem < 0) Or (Defaultitem > Items.size - 1) Then Defaultitem = 0
	Return joInlineJava.RunMethod("ListDialog", Array(Title, Header, Items, Defaultitem))
End Sub
#End Region

#Region ListDialog2
'List Dialog with multiple selection.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Items - List of items to select
'Defaultitem - set between 0 - items.size - 1. If -1, then no item selected.
'Returns: One or more selected items as a Map (nr:item) or a non initialized Map.
Public Sub ListDialog2(Title As String, Header As String, Items As List, Defaultitem As Int) As Map
	' If (Defaultitem < 0) Or (Defaultitem > Items.size - 1) Then Defaultitem = 0
	Return joInlineJava.RunMethod("ListDialog2", Array(Title, Header, Items, Defaultitem))
End Sub
#End Region

#Region ListFindDialog
'List Find Dialog with single selection.
'Title - string to show in the title bar.
'Items - List of items to select
'Defaultitem - set between 0 - items.size - 1.
'Returns: Selected item as String or an empty String.
Public Sub ListFindDialog(Title As String, Items As List, Defaultitem As Int, Width As Double, Height As Double) As String
	Dim lfd As ListFindDialog
	lfd.Initialize(mParentForm, Title, Items, Defaultitem, Width, Height)
	lfd.Button_SelectText = getOKButtonText
	lfd.Button_CancelText = getCancelButtonText
	Return lfd.ShowAndWait
End Sub
#End Region

#Region SelectDialog
'Title - string to show in the title bar.
'Items - List of items to select
'Height - Dialog height
'Width - Dialog width.
'Returns: Selected item as Int or -1 if nothing selected.
Public Sub SelectDialog(Title As String, Items As List, Defaultitem As Int, Height As Double, Width As Double) As Int
	If (Defaultitem < 0) Or (Defaultitem > Items.size - 1) Then Defaultitem = 0
	Return joInlineJava.RunMethod("SelectDialog", Array(Title, Items, Defaultitem, Height, Width))
End Sub
#End Region

#Region SpinnerIntegerDialog
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Label - Label shown left from the spinner.
'MinValue - Spinner minimum value.
'MaxValue - Spinner maximum value (must be greater minimum value).
'InitialValue - Integer as the defalt value.
'AmountToStepBy - Value to increase or decrease when stepping up or down.
'Returns: Integer with selected value or -1 if cancelled.
Public Sub SpinnerIntegerDialog(Title As String, Header As String, Label As String, MinValue As Int, MaxValue As Int, InitialValue As Int, AmountToStepBy As Int) As Int
	Return joInlineJava.RunMethod("SpinnerIntegerDialog", Array(Title, Header, Label, MinValue, MaxValue, InitialValue, AmountToStepBy))
End Sub
#End Region

#Region SpinnerDoubleDialog
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Label - Label shown left from the spinner.
'MinValue - Spinner minimum value.
'MaxValue - Spinner maximum value (must be greater minimum value).
'InitialValue - Integer as the defalt value.
'AmountToStepBy - Value to increase or decrease when stepping up or down.
'Returns: Double with selected value or -1 if cancelled.
Public Sub SpinnerDoubleDialog(Title As String, Header As String, Label As String, MinValue As Double, MaxValue As Double, InitialValue As Double, AmountToStepBy As Double) As Double
	Return joInlineJava.RunMethod("SpinnerDoubleDialog", Array(Title, Header, Label , MinValue, MaxValue, InitialValue, AmountToStepBy))
End Sub
#End Region

#Region SpinnerListDialog
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Label - Label shown left from the spinner.
'Items - List of items to select from.
'Returns: String with selected value or empty string if cancelled.
Public Sub SpinnerListDialog(Title As String, Header As String, Label As String, Items As List) As String
	Return joInlineJava.RunMethod("SpinnerListDialog", Array(Title, Header, Label, Items))
End Sub
#End Region

#Region TextAreaDialog
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Label - Label shown left from the text area.
'Text - Content of the text area.
'Returns: Text entered as string or a null string if dialog cancelled.
'To test the result of the dialog use e.g. If result.EqualsIgnoreCase(Null) Then ...
Public Sub TextAreaDialog(Title As String , Header As String, Label As String, Text As String) As String
	Return joInlineJava.RunMethod("TextAreaDialog", Array(Title, Header, Label, Text))
End Sub
#End Region

#Region ToastMessage
'Property get / set message font size
'Parameters: Fontsize as Int.
Public Sub setToastMessageFontSize(size As Int)
	joInlineJava.RunMethod("setToastMessageFontSize", Array(size))
End Sub

Public Sub getToastMessageFontSize As Int
	Return joInlineJava.RunMethod("getToastMessageFontSize", Null)
End Sub

'Property get / set message border width
'Parameters: Width as Int
Public Sub setToastMessageBorderWidth(width As Int)
	joInlineJava.RunMethod("setToastMessageBorderWidth", Array(width))
End Sub

Public Sub getToastMessageBorderWidth As Int
	Return joInlineJava.RunMethod("setToastMessageBorderWidth", Null)
End Sub

'Property get / set back ground color
'Parameters: Color as Paint
Public Sub setToastMessageBackgroundColor(color As Paint)
	joInlineJava.RunMethod("setToastMessageBackgroundColor", Array(color))
End Sub

Public Sub getToastMessageBackgroundColor() As Paint
	Return joInlineJava.RunMethod("setToastMessageBackgroundColor", Null)
End Sub

'Property get / set border line color
'Color - Paint
Public Sub setToastMessageBorderColor(color As Paint)
	joInlineJava.RunMethod("setToastMessageBorderColor", Array(color))
End Sub

Public Sub getToastMessageBorderColor() As Paint
	Return joInlineJava.RunMethod("getToastMessageBorderColor", Null)
End Sub

'Message - String which can include html tags (ensure to include the start html and end /html tags.
'Duration - miliseconds keeping the message visible. Must be greater 0.
'Returns: None
Public Sub ToastMessage(Message As String , Duration As Int)
	joInlineJava.RunMethod("ToastMessage", Array(Message, Duration))
End Sub
#End Region

#Region ToastMessageAlert
'Property get / set the style properties of the Alert Dialog
'BorderColor - String, i.e. BLUE
'BorderWidth - int, default Is 1
'BorderRadius - int, default Is 0
'Fontsize - int, defaullt Is 16
Public Sub ToastMessageAlertStyle(BorderColor As String, BorderWidth As Int, BorderRadius As Int, Fontsize As Int) 
	joInlineJava.RunMethod("SetToastMessageAlertStyle", Array(BorderColor, BorderWidth, BorderRadius, Fontsize))
End Sub

'NOT USED because the Sub ToastMessageAlertStyle has multiple parameter
'Public Sub getToastMessageAlertStyle() As String
'	Return joInlineJava.RunMethod("GetToastMessageAlertStyle", Null)
'End Sub

'Display a ToastMessage using JavaFX Alert Dialog
'AlertType - String, types are Information, Warning, Error
'Header - String, Header displayed above the content
'Content - String, Content
'Miliseconds - int, duration of the dialog being displayed
Public Sub ToastMessageAlert(AlertType As String, Header As String, Content As String, Duration As Int)
	joInlineJava.RunMethod("ToastMessageAlert", Array(AlertType, Header, Content, Duration))
End Sub
#End Region

#Region DatePickerDialog
'DatePicker Dialog with default date, weeknumbers.
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Label - Label shown left from the date picker.
'Returns: String with selected date or an empty string if cancelled.
'Note: Important to set the pattern (i.e. DateTime.DateFormat = "yyyy-MM-dd") prior calling this method; If the default date left empty (""), the actual date is set.
Public Sub DatePickerDialog(Title As String, Header As String, Label As String, DefaultDate As String) As String
	Return joInlineJava.RunMethod("DatePickerDialog", Array(Title, Header, Label, DefaultDate))
End Sub
#End Region

#Region TimePicker24Dialog
'24hr Time Picker Dialog with default values hours, minutes
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Hours - 0-23
'Minutes - 0-59
'SetNow - True = Set the actual time (parameter Hours, Minutes are omitted).
'Returns: Time String HH:mm or empty string if cancelled.
'Example <code>
'Dlg.OKButtonText = "Pick"
''Pick a time with current time as default. The given hours and minutes are not used.
'Dim timepicked As String = Dlg.TimePicker24Dialog("TimePicker", "Pick your time", 0,0, True)
''Pick a time with a default time set 17:08.
'Dim timepicked As String = Dlg.TimePicker24Dialog("TimePicker", "Pick your time", 17,8, False)
'Log(timepicked)
'</code>
Public Sub TimePicker24Dialog(Title As String, Header As String, Hours As Int, Minutes As Int, SetNow As Boolean) As String
	Return joInlineJava.RunMethod("TimePicker24Dialog", Array(Title, Header, Hours, Minutes, SetNow ))
End Sub
#End Region

#Region TimePicker12Dialog
'12hr Time Picker Dialog with default values hours, minutes, AMPM
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Hours - 0-11
'Minutes - 0-59
'AMPM - "AM" or "PM"
'SetNow - True = Set the actual time (parameter Hours, Minutes are omitted).
'Returns: Time String HH:mm:ss or empty string if cancelled.
'Example <code>
'Dlg.OKButtonText = "Pick"
''Pick a time with current time as default. The given hours and minutes are not used.
'Dim timepicked As String = Dlg.TimePicker12Dialog("TimePicker", "Pick your time", 0,0,"", True)
''Pick a time with a default time set 0:08 AM
'Dim timepicked As String = Dlg.TimePicker12Dialog("TimePicker", "Pick your time", 10,8,"AM", False)
'Log(timepicked)
'</code>
Public Sub TimePicker12Dialog(Title As String, Header As String, Hours As Int, Minutes As Int, AMPM As String, SetNow As Boolean) As String
	Return joInlineJava.RunMethod("TimePicker12Dialog", Array(Title, Header, Hours, Minutes, AMPM, SetNow ))
End Sub
#End Region

#Region ColorNameDialog
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Default - Color index to show as default selected.
'Returns: Selected color as paint or null if cancelled
'Example <code>
'Dim default As Int = 9
'Dim color As Paint = ColorNameDialog("jRLDialogsX Color Dialog", "Header", default)
'If color.IsInitialized Then
'	Dim ColorInt As Int  = fx.Colors.To32Bit(color)
'	Dim HexARGB As String = Bit.ToHexString(ColorInt)
'	Dim HexRGB As String = HexARGB.SubString2(2,8)
'	Log($"Color Int:${ColorInt}${CRLF}HEXARGB:${HexARGB}${CRLF}HexRGB:${HexRGB}"$)
'End If
'</code>
Public Sub ColorNameDialog(Title As String , Header As String, Default As Int) As Paint
	Return joInlineJava.RunMethod("ColorNameDialog", Array(Title, Header, Default))
End Sub
#End Region

#Region ColorPickerDialog
'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Default - Color as Paint to show as default selected.
'Returns: Selected color as paint or null if cancelled
'Example <code>
'Dim default As Int = 9
'Dim color As Paint = ColorPickerDialog("jRLDialogsX Color Picker Dialog", "Header", fx.Colors.blue)
'If color.IsInitialized Then
'	Dim ColorInt As Int  = fx.Colors.To32Bit(color)
'	Dim HexARGB As String = Bit.ToHexString(ColorInt)
'	Dim HexRGB As String = HexARGB.SubString2(2,8)
'	Log($"Color Int:${ColorInt}${CRLF}HEXARGB:${HexARGB}${CRLF}HexRGB:${HexRGB}"$)
'End If
'</code>
Public Sub ColorPickerDialog(Message As String , Header As String, Default As Paint) As Paint
	Return joInlineJava.RunMethod("ColorPickerDialog", Array(Message, Header, Default))
End Sub
#End Region

#Region SliderDialog
'Property get / set block increment
'Increment - amount by which to adjust the slider if the track of the slider is clicked.
Public Sub setSliderBlockIncrement(increment As Double)
	joInlineJava.RunMethod("SetSliderBlockIncrement", Array(increment))
End Sub

Public Sub getSliderBlockIncrement As Double
	Return joInlineJava.RunMethod("GetSliderBlockIncrement", Null)
End Sub

'SliderDialog - Property get / set major tick unit
'Unit - unit distance between major tick marks..
Public Sub setSliderMajorTickUnit(unit As Double)
	joInlineJava.RunMethod("SetSliderMajorTickUnit", Array(unit))
End Sub

Public Sub getSliderMajorTickUnit As Double
	Return joInlineJava.RunMethod("GetSliderMajorTickUnit", Null)
End Sub

'SliderDialog - Property get / set minor tick count
'Count - number of minor ticks to place between any two major ticks.
Public Sub setSliderMinorTickCount(count As Int)
	joInlineJava.RunMethod("SetSliderMinorTickCount", Array(count))
End Sub

Public Sub getSliderMinorTickCount As Int
	Return joInlineJava.RunMethod("GetSliderMinorTickCount", Null)
End Sub

'SliderDialog - Property get / set show the tick labels
'Show - Indicates that the labels for tick marks should be shown.
Public Sub setSliderShowTickLabels(show As Boolean)
	joInlineJava.RunMethod("SetSliderShowTickLabels", Array(show))
End Sub

Public Sub getSliderShowTickLabels As Boolean
	Return joInlineJava.RunMethod("GetSliderShowTickLabels", Null)
End Sub

'SliderDialog - Property get / set show the tick marks.
'Show - Specifies whether the Skin implementation should show tick marks.
Public Sub setSliderShowTickMarks(show As Boolean)
	joInlineJava.RunMethod("SetSliderShowTickMarks", Array(show))
End Sub

Public Sub getSliderShowTickMarks As Boolean
	Return joInlineJava.RunMethod("GetSliderShowTickMarks", Null)
End Sub

'SliderDialog - Property get / set snap to ticks.
'Snap - Indicates whether the value of the Slider should always be aligned with the tick marks.
Public Sub setSliderSnapToTicks(snap As Boolean)
	joInlineJava.RunMethod("SetSliderSnapToTicks", Array(snap))
End Sub

Public Sub getSliderSnapToTicks As Boolean
	Return joInlineJava.RunMethod("GetSliderSnapToTicks", Null)
End Sub

'SliderDialog - Property get / set to show the value in a seperate label.
'Show - Value in a label.
Public Sub setSliderShowValue(show As Boolean)
	joInlineJava.RunMethod("SetSliderShowValue", Array(show))
End Sub

Public Sub getSliderShowValue As Boolean
	Return joInlineJava.RunMethod("GetSliderShowValue", Null)
End Sub

'SliderDialog - Property get / set the width of the slider.
'Width - Slider width. If 0, then the default setting is used.
Public Sub setSliderPrefWidth(width As Double)
	joInlineJava.RunMethod("SetSliderPrefWidth", Array(width))
End Sub

Public Sub getSliderPrefWidth As Double
	Return joInlineJava.RunMethod("GetSliderPrefWidth", Null)
End Sub

'SliderDialog - Property get / set the CSS style of the value label.
'Style - CSS style, i.e. "-fx-text-fill: red; -fx-font-size: 24pt;".
Public Sub setSliderValueStyle(style As String) {
	joInlineJava.RunMethod("SetSliderValueStyle", Array(style))
End Sub

Public Sub getSliderValueStyle As String
	Return joInlineJava.RunMethod("GetSliderValueStyle", Null)
End Sub

'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Label - Label shown left from the spinner.
'MinValue - Minimum value of the slider (start value).
'MaxValue - Maximum value of the slider (end value).
'DefaultValue - Default value set in range Min / Max value.
'Returns: Slider value As Double or if cancelled the default value given
'Note: The slider style can be customized by using an external CSS file called Slider.css (case sensitive) which must be placed in the B4J Project Files (DirAssets) folder.
'Example <code>
'Dim defaultValue As Double = 58
'Dlg.SliderShowTickLabels = True
'Dlg.SliderShowTickMarks = True
'Dlg.SliderShowValue = True
'Dlg.SliderBlockIncrement = 10
'Dlg.SliderMajorTickUnit = 10
'Dlg.SliderValueStyle = "-fx-text-fill: red; -fx-font-size: 24pt;"
'Dim value As Double = Dlg.SliderDialog("SliderDialog Title", "Header", 0, 100, defaultValue)
'If value <> defaultValue Then
'	Log($"Slider Value:${CRLF}${value}"$)
'Else
'	Log($"User Abort.${CRLF}Selected Value ${value} = Default Value ${defaultValue}"$)
'End If
'</code>
Public Sub SliderDialog(Title As String, Header As String, MinValue As Double, MaxValue As Double, DefaultValue As Double) As Double
	Return joInlineJava.RunMethod("SliderDialog", Array(Title, Header, MinValue, MaxValue, DefaultValue))
End Sub
'SLIDERDIALOG
#End Region

#Region DoNotAskAgainDialog
'Property get / set the option for not asking again, to true or false.
Public Sub setDoNotAskAgainOption(askagain As Boolean)
	joInlineJava.RunMethod("SetDoNotAskAgainOption", Array(askagain))
End Sub
'Get the Do Not Ask Again Message option true or false
Public Sub getDoNotAskAgainOption As Boolean
	Return 	joInlineJava.RunMethod("GetDoNotAskAgainOption", Null)
End Sub

'Title - string to show in the title bar.
'Header - string to show in the dialog header area.
'Content - string to show in the content area (below the header).
'DoNotAskAgainMessage - string to show the option of not asking this dialog again.
'DefaultOption - boolean to indicate the choice of not asking this dialog again.
'Returns:
'1. From the Buttons: True = Yes, False = No
'2. From the DoNotAskAgain Checkbox: True if checked which means, do not ask again to show the dialog.
'Example <code>
'Dim result As Boolean = Dlg.DoNotAskAgainDialog("DoNotAskMeAgain Title", "Header", "Content", "Do Not ask Me again", True)
'Dim resultOption As Boolean = Dlg.DoNotAskAgainOption
'Log($"Do Not Ask Me Again${CRLF}Result:${result}${CRLF}Option:${resultOption}"$)
'</code>
Public Sub DoNotAskAgainDialog(Title As String, Header As String, Content As String, DoNotAskAgainMessage As String, DefaultOption As Boolean) As Boolean
	Return joInlineJava.RunMethod("DoNotAskAgainDialog", Array(Title, Header, Content, DoNotAskAgainMessage, DefaultOption))
End Sub

#End Region
'DONOTASKAGAINDIALOG
'
'
'
#if JAVA

//Import Start
import anywheresoftware.b4a.objects.collections.Map;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Toolkit;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Field;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.Optional;
import javafx.application.Application;
import javafx.application.Platform;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Worker.State;
import javafx.concurrent.Worker;
import javafx.embed.swing.SwingNode;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.geometry.HPos;
import javafx.geometry.Pos;
import javafx.scene.Node;
import javafx.scene.control.*;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ButtonBar.ButtonData;
import javafx.scene.control.ButtonType;
import javafx.scene.control.CheckBox;
import javafx.scene.control.Control;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Dialog;
import javafx.scene.control.Hyperlink;
import javafx.scene.control.Label;
import javafx.scene.control.ListCell;
import javafx.scene.control.ListView;
import javafx.scene.control.SelectionMode;
import javafx.scene.control.Spinner;
import javafx.scene.Group;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.ColumnConstraints;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Priority;
import javafx.scene.layout.Region;
import javafx.scene.layout.VBox;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Text;
import javafx.scene.web.WebEngine;
import javafx.scene.web.WebView;
import javafx.stage.*;
import javafx.stage.Stage;
import javafx.stage.Window;
import javafx.util.Callback;
import javafx.util.Pair;
import javax.swing.BoxLayout;
import javax.swing.JDialog;
import javax.swing.JFormattedTextField;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.border.LineBorder;
import javax.swing.event.*;
import javax.swing.event.HyperlinkEvent.*;
import javax.swing.text.MaskFormatter;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.w3c.dom.events.Event;
import org.w3c.dom.events.EventListener;
import org.w3c.dom.events.EventTarget;
//Import End

//LOCALIZATION
// Username Label
private static String mUsernameLabel = "Username:";
public static void SetUsernameLabel(String lbl) {
	mUsernameLabel	= lbl;
}
public static String GetUsernameLabel() {
	return mUsernameLabel;
}

// Username Prompt
private static String mUsernamePrompt = "Username:";
public static void SetUsernamePrompt(String prompt) {
	mUsernamePrompt	= prompt;
}
public static String GetUsernamePrompt() {
	return mUsernamePrompt;
}

// Password Label
private static String mPasswordLabel = "Password:";
public static void SetPasswordLabel(String lbl) {
	mPasswordLabel	= lbl;
}
public static String GetPasswordLabel() {
	return mPasswordLabel;
}

// Password Prompt
private static String mPasswordPrompt = "Password";
public static void SetPasswordPrompt(String prompt) {
	mPasswordPrompt	= prompt;
}
public static String GetPasswordPrompt() {
	return mPasswordPrompt;
}

// OK Button Text
private static String mOKButtonText = "OK";
public static void SetOKButtonText(String txt) {
	mOKButtonText = txt;
}
public static String GetOKButtonText() {
	return mOKButtonText;
}
// OK Button Style
private static String mOKButtonStyle = "";
public static void SetOKButtonStyle(String stl) {
	mOKButtonStyle = stl;
}

// Cancel Button Text
private static String mCancelButtonText = "Cancel";
public static void SetCancelButtonText(String txt) {
	mCancelButtonText = txt;
}
public static String GetCancelButtonText() {
	return mCancelButtonText;
}
// Cancel Button Style
private static String mCancelButtonStyle = "";
public static void SetCancelButtonStyle(String stl) {
	mCancelButtonStyle = stl;
}

// YES Button Text
private static String mYesButtonText = "Yes";
public static void SetYesButtonText(String txt) {
	mYesButtonText = txt;
}
public static String GetYesButtonText() {
	return mYesButtonText;
}
// Yes Button Style
private static String mYesButtonStyle = "";
public static void SetYesButtonStyle(String stl) {
	mYesButtonStyle = stl;
}

// NO Button Text
private static String mNoButtonText = "No";
public static void SetNoButtonText(String txt) {
	mNoButtonText = txt;
}
public static String GetNoButtonText() {
	return mNoButtonText;
}
// No Button Style
private static String mNoButtonStyle = "";
public static void SetNoButtonStyle(String stl) {
	mNoButtonStyle = stl;
}

// Login Button Text
private static String mLoginButtonText = "Login";
public static void SetLoginButtonText(String txt) {
	mLoginButtonText = txt;
}
public static String GetLoginButtonText() {
	return mLoginButtonText;
}
// Login Button Style
private static String mLoginButtonStyle = "";
public static void SetLoginButtonStyle(String stl) {
	mLoginButtonStyle = stl;
}

// Select Button Text
private static String mSelectButtonText = "Select";
public static void SetSelectButtonText(String txt) {
	mSelectButtonText = txt;
}
public static String GetSelectButtonText() {
	return mSelectButtonText;
}
// Select Button Style
private static String mSelectButtonStyle = "";
public static void SetSelectButtonStyle(String stl) {
	mSelectButtonStyle = stl;
}

// Previous Button Text
private static String mPreviousButtonText = "<";
public static void SetPreviousButtonText(String txt) {
	mPreviousButtonText = txt;
}
public static String GetPreviousButtonText() {
	return mPreviousButtonText;
}
// Previous Button Style
private static String mPreviousButtonStyle = "";
public static void SetPreviousButtonStyle(String stl) {
	mPreviousButtonStyle = stl;
}

// Next Button Text
private static String mNextButtonText = ">";
public static void SetNextButtonText(String txt) {
	mNextButtonText = txt;
}
public static String GetNextButtonText() {
	return mNextButtonText;
}
// Next Button Style
private static String mNextButtonStyle = "";
public static void SetNextButtonStyle(String stl) {
	mNextButtonStyle = stl;
}
// LOCALIZATION END

// HELPER
public static Node getNodeByRowColumnIndex (final int row, final int column, GridPane gridPane) {
    Node result = null;
    ObservableList<Node> childrens = gridPane.getChildren();

    for (Node node : childrens) {
        if(gridPane.getRowIndex(node) == row && gridPane.getColumnIndex(node) == column) {
            result = node;
            break;
        }
    }

    return result;
}

// Set Parent Window
public static Window parentWindow = null;

public static void SetParentWindow(Window mparentwindow) {
	parentWindow = mparentwindow;
}

public static final String EVENT_TYPE_CLICK = "click";
public static final String EVENT_TYPE_MOUSEOVER = "mouseover";
public static final String EVENT_TYPE_MOUSEOUT = "mouseclick";
	
//InformationDialog
public static void InformationDialog(String mtitle, String mheader, String mcontent) {
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	Alert alert = new Alert(AlertType.INFORMATION, mcontent, buttonTypeOK);
	alert.setTitle(mtitle);
	alert.setHeaderText(mheader);
	alert.setContentText(mcontent);
	alert.initStyle(StageStyle.UTILITY);
	alert.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		alert.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	alert.showAndWait();
};

//WarningDialog
public static void WarningDialog(String mtitle, String mheader, String mcontent) {
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	Alert alert = new Alert(AlertType.WARNING, mcontent, buttonTypeOK);
	alert.setTitle(mtitle);
	alert.setHeaderText(mheader);
	alert.setContentText(mcontent);
	alert.initStyle(StageStyle.UTILITY);
	alert.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		alert.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	alert.showAndWait();
};

//ErrorDialog
public static void ErrorDialog(String mtitle, String mheader, String mcontent) {
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	Alert alert = new Alert(AlertType.ERROR,mcontent, buttonTypeOK);
	alert.setTitle(mtitle);
	alert.setHeaderText(mheader);
	alert.setContentText(mcontent);
	alert.initStyle(StageStyle.UTILITY);
	alert.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		alert.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	alert.showAndWait();
};

//ConfirmationDialog
public static boolean ConfirmationDialog(String mtitle, String mheader, String mcontent) {
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	Alert alert = new Alert(AlertType.CONFIRMATION,mcontent,buttonTypeOK,buttonTypeCancel);
	alert.setTitle(mtitle);
	alert.setHeaderText(mheader);
	alert.setContentText(mcontent);
	alert.initStyle(StageStyle.UTILITY);
	alert.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		alert.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		alert.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	Optional<ButtonType> result = alert.showAndWait();
	if (result.get() == buttonTypeOK){
		return true; 
	} else {
		return false; 
	}
};

//YesNoCancelDialog
public static int YesNoCancelDialog(String mtitle, String mheader, String mcontent) {
	Alert alert = new Alert(AlertType.CONFIRMATION);

	alert.setTitle(mtitle);
	alert.setHeaderText(mheader);
	alert.setContentText(mcontent);
	alert.initStyle(StageStyle.UTILITY);

	ButtonType buttonTypeYes = new ButtonType(mYesButtonText, ButtonBar.ButtonData.YES);
	ButtonType buttonTypeNo = new ButtonType(mNoButtonText, ButtonBar.ButtonData.NO);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	if(!mCancelButtonText.isEmpty()) {
		alert.getButtonTypes().setAll(buttonTypeYes, buttonTypeNo, buttonTypeCancel);
	} else {
		alert.getDialogPane().lookupButton(buttonTypeCancel).setVisible(false);
		alert.getButtonTypes().setAll(buttonTypeYes, buttonTypeNo);
	}

	if (mYesButtonStyle.isEmpty() == false) {
		alert.getDialogPane().lookupButton(buttonTypeYes).setStyle(mYesButtonStyle);
	}
	if (mNoButtonStyle.isEmpty() == false) {
		alert.getDialogPane().lookupButton(buttonTypeNo).setStyle(mNoButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		alert.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	
	alert.initOwner(parentWindow);
	
	Optional<ButtonType> result = alert.showAndWait();
	if (result.get() == buttonTypeYes){
		return 1; 
	} else if (result.get() == buttonTypeNo) {
		return 0; 
	} else {
		return -1; 
	}
};

//AlertSelectionDialog
public static int AlertSelectionDialog(String mtitle, String mheader, String mcontent, String[] mbuttons) {
    Alert alert = new Alert(AlertType.CONFIRMATION);

    alert.setTitle(mtitle);
    alert.setHeaderText(mheader);
	alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
	alert.getDialogPane().setMinWidth(Region.USE_PREF_SIZE);
    alert.initStyle(StageStyle.UTILITY);

	// Clear buttons first
	alert.getButtonTypes().clear();

	// Add the buttons from the mbuttons argument array
	for (String btn : mbuttons) {
		ButtonType newbutton = new ButtonType(btn, ButtonBar.ButtonData.YES);
		alert.getButtonTypes().add(newbutton);
	}

    alert.initOwner(parentWindow);
    
	// Show the dialog and wait for a button to be selected.
	Optional<ButtonType> result = alert.showAndWait();
	
	// Get and return the selected button
	ButtonType buttonselected = result.get();
	// BA.Log(Integer.toString(alert.getButtonTypes().indexOf(buttonselected)));
	return alert.getButtonTypes().indexOf(buttonselected);
};

//CustomAlertDialog
public static int CustomAlertDialog(
	String malerttype,
	String mtitle, String mheader, String mcontent, 
	double mprefwidth, double mprefheight, 
	String mstagestyle, String mdialogstyle, String mheaderstyle, String mcontentstyle, 
	String mbuttonyestext, String mbuttonnotext, String mbuttoncanceltext,
	String mbuttonyesstyle, String mbuttonnostyle, String mbuttoncancelstyle) {

	// Define the dialog result.
	// The dialog will always return a value. Default is -1.
	int dlgresult = -1;
		
	// Create the alert object from alert type given by the argument malerttype.
	// If no alert type given or error (=wrong alert type), set as default alert type INFORMATION.
	if(malerttype.isEmpty()) { malerttype = "INFORMATION"; }
	AlertType alerttype;
	try {
		alerttype = AlertType.valueOf(malerttype);
  	} catch (IllegalArgumentException e) {
		malerttype = "INFORMATION";
  	}
	Alert alert = new Alert(AlertType.valueOf(malerttype));

	// Always create the 3 default buttons
	ButtonType buttonTypeYes = new ButtonType(mbuttonyestext, ButtonBar.ButtonData.YES);
	ButtonType buttonTypeNo = new ButtonType(mbuttonnotext, ButtonBar.ButtonData.NO);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);

	// Set the alert object properties
    alert.setTitle(mtitle);
    alert.setHeaderText(mheader);
	
	// Set the stage style, i.e. DECORATED, TRANSPARENT.
	// If no stage style given or error (=wrong stage style), set as default stage style UTILITY.
	if(mstagestyle.isEmpty()) { mstagestyle = "UTILITY"; }
	StageStyle statestyle;
	try {
		statestyle = StageStyle.valueOf(mstagestyle);
  	} catch (IllegalArgumentException e) {
		mstagestyle = "UTILITY";
  	}
	alert.initStyle(StageStyle.valueOf(mstagestyle));
	
	// Set the css style of the dialog pane
    alert.getDialogPane().setStyle(mdialogstyle);

	// Handle dialog pane sizing
	alert.setResizable(true);
	alert.getDialogPane().setMinWidth(Region.USE_PREF_SIZE);
	alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
	alert.getDialogPane().setPrefSize(mprefwidth, mprefheight);

	// Set the style of the header label    
	GridPane grid = (GridPane)alert.getDialogPane().lookup(".header-panel"); 
	grid.setStyle(mheaderstyle);

	// Set the style of the content label    
    Label lbl = new Label(mcontent);
    lbl.setAlignment(Pos.CENTER_LEFT);
    lbl.setStyle(mcontentstyle);
    lbl.setWrapText(true);
    alert.getDialogPane().setContent(lbl);

	// Clear the default buttons
	alert.getButtonTypes().clear();

	// Add up-to 3 buttons if the text is given and set the button style accordingly (if given)
    if(!mbuttonyestext.isEmpty()) {
        alert.getButtonTypes().add(buttonTypeYes);
		if(!mbuttonyesstyle.isEmpty()) {
			alert.getDialogPane().lookupButton(buttonTypeYes).setStyle(mbuttonyesstyle);
		}
	}
    if(!mbuttonnotext.isEmpty()) {
        alert.getButtonTypes().add(buttonTypeNo);
		if(!mbuttonnostyle.isEmpty()) {
			alert.getDialogPane().lookupButton(buttonTypeNo).setStyle(mbuttonnostyle);
		}
	}
    if(!mbuttoncanceltext.isEmpty()) {
        alert.getButtonTypes().add(buttonTypeCancel);
		if(!mbuttoncancelstyle.isEmpty()) {
			alert.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mbuttoncancelstyle);
		}
    } 
	
	// Init the owner with the parentwindow
    alert.initOwner(parentWindow);

	// Show the dialog	
    Optional<ButtonType> result = alert.showAndWait();

	// Handle dialog result. The default value is -1.
	// The isPresent method checks if a button is pressed and not the system button (top right X in the dialog window).
	if(result.isPresent()) {
		if(result.get().equals(buttonTypeYes)) {
			dlgresult = 1;
		}
		else if(result.get() == buttonTypeNo) {
			dlgresult = 0;
		}
	}
	return dlgresult;
}

//TextInputDialog
//Parameter: Title and Header, Prompt Label1 for Field1, Default Values for Field1
//Result: String OR if cancelled an empty string
public static String TextInputDialog(String mtitle, String mheader, String mlabel, String mtext) {
	TextInputDialog dialog = new TextInputDialog(mtext);
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);
	dialog.setContentText(mlabel);

	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);

    dialog.getDialogPane().getButtonTypes().setAll(buttonTypeOK, buttonTypeCancel);
	dialog.initStyle(StageStyle.UTILITY);
	dialog.initOwner(parentWindow);

	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}

	Optional<String> result = dialog.showAndWait();
	if (result.isPresent()){
		return result.get();
	}
	else {
		return "";
	}	
};

//TextInputDialog2
//Parameter: Title and Header, Prompts (Label1 and Label2) for Field1 and 2, Default values for Field1 and 2
//Result: Map with 2 entries holding field1:textinputfield1, field2:textinputfield2 OR if cancelled a non initialized map
public static Map.MyMap TextInputDialog2(String mtitle, String mheader, String mlabel1, String mlabel2, String mfield1, String mfield2) {
	//Create a new field map
	Map.MyMap fieldmap = new Map.MyMap();
	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	//Create the labels and fields.
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);
	// grid.setPadding(new Insets(20, 150, 10, 10));

	final TextField field1 = new TextField();
	field1.setPromptText(mlabel1);
	field1.setText(mfield1);
	Platform.runLater(new Runnable() {
         @Override
         public void run() {
            field1.requestFocus();
        }
	});	
	TextField field2 = new TextField();
	field2.setPromptText(mlabel2);
	field2.setText(mfield2);

	grid.add(new Label(mlabel1), 0, 0);
	grid.add(field1, 1, 0);
	grid.add(new Label(mlabel2), 0, 1);
	grid.add(field2, 1, 1);

	//Enable/Disable OK button depending on whether field1 was entered = triggerd by textfield listener
	final Node buttonOK = dialog.getDialogPane().lookupButton(buttonTypeOK);
	buttonOK.setDisable(field1.getText().trim().isEmpty());

	//Listen for field1 TextField text changes
	field1.textProperty().addListener(new ChangeListener<String>() {
    	public void changed(ObservableValue<? extends String> observable, String oldValue, String newValue) {
			buttonOK.setDisable(newValue.trim().isEmpty());
   		}
	});

	dialog.getDialogPane().setContent(grid);
	//Handle the dialog result based on the button clicked OK or Cancel
	dialog.initOwner(parentWindow);

	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}

	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK){
		//Create a new map with 2 entries holding field1:textinputfield1, field2:textinputfield2
		Map m = new Map();
		m.Initialize();
		m.Put("field1", field1.getText());
		m.Put("field2", field2.getText());
		//Put the map to the B4J mymap
		fieldmap.putAll(m.getObject());
		return fieldmap;
	} else {
		//Returns a non initialized B4J mymap
		return null; 
	}
}

//TextInputDialog3
//Parameter: Title and Header, Prompt Label1 for Field1, Default Values for Field1
//Result: String OR if cancelled a null string
public static String TextInputDialog3(String mtitle, String mheader, String mlabel1, String mfield1) {
	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	//Create the labels and fields.
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);
	// grid.setPadding(new Insets(20, 150, 10, 10));

	final TextField field1 = new TextField();
	field1.setPromptText(mlabel1);
	field1.setText(mfield1);
	Platform.runLater(new Runnable() {
         @Override
         public void run() {
            field1.requestFocus();
        }
	});	
	grid.add(new Label(mlabel1), 0, 0);
	grid.add(field1, 1, 0);
	dialog.getDialogPane().setContent(grid);
	//Handle the dialog result based on the button clicked OK or Cancel
	dialog.initOwner(parentWindow);

	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}

	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK){
		return field1.getText();
	} else {
		//Returns a null string
		return null; 
	}
}

//TextInputDialog4
//Parameter: Title, Header (can be used as prompt), Default value for textfield, Width of the textfield
//Result: String OR if cancelled a null string
public static String TextInputDialog4(String mtitle, String mheader, String mfield1, int mwidth) {
	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	//Check the width
	if (mwidth < 0) { mwidth = 0; }

	//Create the labels and fields.
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);

	final TextField field1 = new TextField();
	field1.setText(mfield1);
	Platform.runLater(new Runnable() {
         @Override
         public void run() {
            field1.requestFocus();
        }
	});	
	grid.add(field1, 0, 0);
    grid.getColumnConstraints().add(new ColumnConstraints(mwidth)); // Set the columns width

	dialog.getDialogPane().setContent(grid);
	//Handle the dialog result based on the button clicked OK or Cancel
	dialog.initOwner(parentWindow);

	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}

	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK){
		return field1.getText();
	} else {
		//Returns a null string
		return null; 
	}
}

//MaskInputDialog
//Parameter: Title and Header, Prompt Label1 for Field1, Default Values for Field1, Mask
//Result: String OR if cancelled a null string
public static String MaskInputDialog(String mtitle, String mheader, String mlabel1, String mfield1, String mmask) {
	//IMPORTANT: https://docs.oracle.com/javafx/8/embed_swing/jfxpub-embed_swing.htm
	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	//Create the labels and fields.
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);
	// grid.setPadding(new Insets(20, 150, 10, 10));

	// Swing part
	final SwingNode swingNode;
   	final MaskFormatter formatter;
   	final JFormattedTextField field1;
	try {
		swingNode = new SwingNode();
		// Create formatter instance
   		formatter = new MaskFormatter(mmask);
		formatter.setPlaceholderCharacter('_');
		// Create the formatted field
   		field1 = new JFormattedTextField(formatter);
    	field1.setValue(mfield1);
		// Add the field to the swing node
		swingNode.setContent(field1);
		// Populate the grid with the javafx label and the swing node containing the formatted field
		grid.add(new Label(mlabel1), 0, 0);
		grid.add(swingNode, 1, 0);
		// Set the content of the dialog pane
		dialog.getDialogPane().setContent(grid);
		// Request the focus on the swingnode - do not use the swingfield
		Platform.runLater(new Runnable() {
        	 @Override
         	public void run() {
            	swingNode.requestFocus();
        	}
		});	
		//Handle the dialog result based on the button clicked OK or Cancel
		dialog.initOwner(parentWindow);

		if (mOKButtonStyle.isEmpty() == false) {
			dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
		}
		if (mCancelButtonStyle.isEmpty() == false) {
			dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
		}

		Optional<ButtonType> result = dialog.showAndWait();
		if (result.get() == buttonTypeOK){
			return field1.getText();
		} else {
			//Returns a null string
			return null; 
		}
	} catch (ParseException e) {
		System.err.println("MaskInputField: Unable to add formatted textfield.");
		return null;
    }
}

//MultiInputFieldDialog
//Parameter: Title and Header, Fieldmap
//The fieldmap holds for each field the pair label:fieldtext
//Result: Map holding for each field the pair fieldN:fieldtext OR if cancelled a non initialized map.
//N is the fieldnumber, starting with 0. The max number of fields is determined by the Fieldmap size.
public static Map.MyMap MultiInputFieldDialog(String mtitle, String mheader, Map.MyMap mfieldmap, int mfieldcnt ) {
	//Set the field count (=the fieldmap size as parameter)
	final int MAXFIELDS = mfieldcnt;

	//Create the text field array 
	final TextField fields[] = new TextField[MAXFIELDS];

	//Create a new field map
	Map.MyMap fieldmap = new Map.MyMap();

	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	//Create the labels and fields.
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);

	//The fields are defined in the parameter mfieldmap
	//Check the field count, if beyond or below range return null
	if (mfieldcnt > MAXFIELDS || mfieldcnt < 1) {
		return null;
	}

	//Build the grid with for each row label:textfield
	int i = 0;
	String value;
	String key;
	for (Map.MyMap.Entry<Object, Object> entry : mfieldmap.entrySet()) {
		key = (String) entry.getKey();
		value = (String) entry.getValue();
		fields[i] = new TextField(value);
		fields[i].setId(key);
		// col, row
		grid.add(new Label(key), 0, i);
		grid.add(fields[i], 1, i);
		i += 1;
	}

	//Set focus on first field
	Platform.runLater(new Runnable() {
         @Override
         public void run() {
            fields[0].requestFocus();
        }
	});	

	//Set the grid content in the dialog pane
	dialog.getDialogPane().setContent(grid);
	
	//Handle the dialog result based on the button clicked OK or Cancel
	dialog.initOwner(parentWindow);

	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}

	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK){
		//Create a new map with 2 entries holding field1:textinputfield1, field2:textinputfield2
		Map m = new Map();
		m.Initialize();
		for (int j = 0; j < mfieldcnt; j++) {
			m.Put("field"+j, fields[j].getText());
			//m.Put(fields[j].getId(), fields[j].getText()); --- this would be an option to use the label as fieldkey
		}
		//Put the map to the B4J mymap
		fieldmap.putAll(m.getObject());
		return fieldmap;
	} else {
		//Returns a non initialized B4J mymap
		return null; 
	}
}

//SIMPLEFORMDIALOG START
/**
 * Row Content type:
 * If value is true, then row contains label : field else row contains label or field.
 */
private static boolean mSimpleFormSplitFields = true;

/**
 * Set content type per row.
 * If value is false, then row contains label : field else row contains label or field.
 */
public static void SetSimpleFormSplitFields(final boolean value) {
	mSimpleFormSplitFields = value;
}

/**
 * Get the flag on what is displayed in a form row.
 * If false, then row contains label : field else row contains label or field.
 *
 * @return boolean
 */
public static boolean GetSimpleFormSplitFields() {
	return mSimpleFormSplitFields;
}

/**
 * Set / Get the width of the SimpleFormDialog
 * If value < 0, then default width is used.
 */
private static int mSimpleFormWidth = -1;
public static void SetSimpleFormWidth(int width) {
	mSimpleFormWidth = width;
}
public static int GetSimpleFormWidth() {
	return mSimpleFormWidth;
}

/**
 * Set / Get the SimpleFormDialog ComboBox editable
 */
private static Boolean mSimpleFormComboBoxEditable = false;
public static void SetSimpleFormComboBoxEditable(final Boolean editable) {
	mSimpleFormComboBoxEditable = editable;
}
public static Boolean GetSimpleFormComboBoxEditable() {
	return mSimpleFormComboBoxEditable;
}

/**
 * Set / Get the SimpleFormDialog ComboBox Value
 */
private static String mSimpleFormComboBoxValue = "";
public static void SetSimpleFormComboBoxValue(final String value) {
	mSimpleFormComboBoxValue = value;
}
public static String GetSimpleFormComboBoxValue() {
	return mSimpleFormComboBoxValue;
}

/**
 * Set / Get the SimpleFormDialog DatePicker Value
 */
private static String mSimpleFormDatePickerValue = "";
public static void SetSimpleFormDatePickerValue(final String value) {
	mSimpleFormDatePickerValue = value;
}
public static String GetSimpleFormDatePickerValue() {
	return mSimpleFormDatePickerValue;
}

/**
 * SimpleFormDialog
 * Show a SimpleFormDialog with Text-, Password-, Numeric fields.
 * The fields are defined in a list of maps. Each map represents a field with id, label, value, field type.
 * Field types:
 * "T" for TextField,
 * "P" for Password Field,
 * "N" for Numeric Field (0..9, minus and decimal dot).
 * "A" for TextArea
 * "C" for CheckBox
 * "B" for ComboBox (comma separated string)
 * "D" for DatePicker
 * @param mtitle
 * @param mheader
 * @param mfields
 * @return map with for each field the key:value pair fieldid:fieldvalue.
 *         The returned fieldvalues are strings, means for numberfields conversion has to be done manually.
 */
public static Map.MyMap SimpleFormDialog(final String mtitle, final String mheader, final List<Map.MyMap> mfields) {
	// Create the text field array
	final ArrayList<Control> fields = new ArrayList<>();
	// Create a new field map
	final Map.MyMap fieldmap = new Map.MyMap();

	// Create a new dialog and set title and header
	@SuppressWarnings("rawtypes")
	final Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	// Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	final ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	final ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	// Create the labels and fields.
	final GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);

	// Build the grid with for each row label:textfield
	int i = 0;
	String id;
	String label;
	String value;
	String type;
	int colIndex = 0, rowIndex = 0, rowIndexLabel = 0;

	//Set the column width
	if (GetSimpleFormWidth() > 0) { 
		if (GetSimpleFormSplitFields() == true) {
		// Split row into label : field means label is colindex 0, field is colindex 1
		ColumnConstraints col0 = new ColumnConstraints();
		ColumnConstraints col1 = new ColumnConstraints(GetSimpleFormWidth());
		grid.getColumnConstraints().addAll(col0,col1);
		} else {
			// Each row has one entry i.e. label or field means label is colindex 0, field is colindex 0
			ColumnConstraints col0 = new ColumnConstraints(GetSimpleFormWidth());
			grid.getColumnConstraints().addAll(col0);
		}
	}

	//
	for (final Map.MyMap m : mfields) {
		id = (String) m.get("id");
		label = (String) m.get("label");
		value = (String) m.get("value");
		type = (String) m.get("type");
		// col, row
		rowIndexLabel = i;
		if (GetSimpleFormSplitFields() == true) {
			// Split row into label : field means label is colindex 0, field is colindex 1
			colIndex = 1;
			rowIndex = i;
		} else {
			// Each row has one entry i.e. label or field means label is colindex 0, field is colindex 0
			colIndex = 0;
			i += 1;
			rowIndex = i;
		}
		if (type.equals("T")) {
			final TextField textField = new TextField(value);
			textField.setId(id);
			fields.add(textField);
			grid.add(new Label(label), 0, rowIndexLabel);
			grid.add(textField, colIndex, rowIndex);
		}
		if (type.equals("P")) {
			// No parameter
			final PasswordField passwordField = new PasswordField();
			passwordField.setId(id);
			passwordField.setText(value);
			fields.add(passwordField);
			grid.add(new Label(label), 0, rowIndexLabel);
			grid.add(passwordField, colIndex, rowIndex);
		}
		if (type.equals("N")) {
			final NumericField numField = new NumericField();
			numField.setId(id);
			numField.setText(value);
			fields.add(numField);
			grid.add(new Label(label), 0, rowIndexLabel);
			grid.add(numField, colIndex, rowIndex);
		}
		if (type.equals("A")) {
			final TextArea textArea = new TextArea(value);
			textArea.setId(id);
			fields.add(textArea);
			grid.add(new Label(label), 0, rowIndexLabel);
			grid.add(textArea, colIndex, rowIndex);
		}
		if (type.equals("C")) {
			final CheckBox checkBox = new CheckBox(label);
			checkBox.setId(id);
			if (Integer.parseInt(value) == 1) {
				checkBox.setSelected(true);
			}
			fields.add(checkBox);
			grid.add(checkBox, colIndex, rowIndex);
		}
		if (type.equals("B")) {
			final ComboBox<String> comboBox = new ComboBox<String>();
			comboBox.setId(id);
			comboBox.getItems().addAll(Arrays.asList(value.split(",")));
			comboBox.setEditable(GetSimpleFormComboBoxEditable());
			String cbvalue = GetSimpleFormComboBoxValue();
			if(cbvalue != null && !cbvalue.isEmpty()) {
				comboBox.setValue(cbvalue);
			} else {
				comboBox.setValue(comboBox.getItems().get(0));
			}
			fields.add(comboBox);
			grid.add(new Label(label), 0, rowIndexLabel);
			grid.add(comboBox, colIndex, rowIndex);
		}
		if (type.equals("D")) {
			final DatePicker datePicker = new DatePicker();
			datePicker.setId(id);
			datePicker.setShowWeekNumbers(true);
			if(value != null && !value.isEmpty()) {
				datePicker.setValue(LocalDate.parse(value));
			} else {
				datePicker.setValue(LocalDate.now());
			}
			fields.add(datePicker);
			grid.add(new Label(label), 0, rowIndexLabel);
			grid.add(datePicker, colIndex, rowIndex);
		}
		
		// Increase counter for the row index label
		i += 1;
	}

	// Set focus on first field
	Platform.runLater(new Runnable() {
		@Override
		public void run() {
			Node firstfield;
			// Get the first field to be able to set requestfocus
			if (GetSimpleFormSplitFields() == true) {
				// Split row into label : field means label is colindex 0, field is colindex 1
				firstfield = getNodeByRowColumnIndex (0, 1, grid); 
			} else {
				// Each row has one entry i.e. label or field means label is colindex 0, field is colindex 0
				firstfield = getNodeByRowColumnIndex (1, 0, grid); 
			}
			firstfield.requestFocus();
			// fields[0].requestFocus();
		}
	});

	dialog.getDialogPane().setContent(grid);

	// Set Button CSS Style
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}

	// Handle the dialog result based on the button clicked OK or Cancel
	dialog.initOwner(parentWindow);
	@SuppressWarnings("unchecked")	
	final Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK) {
		// Create a new map with N entries holding fieldid:text
		final Map m = new Map();
		m.Initialize();
		// Get the children of the gridpane column 2 (=index 1)
		final ObservableList<Node> nodes = grid.getChildren();
		// Iterate over the nodes, determine its instance, get the field value and put into the return map
		for (final Node node : nodes) {
				if (node instanceof TextField) {
					m.Put(((TextField) node).getId(), ((TextField) node).getText());
				}
				if (node instanceof PasswordField) {
					m.Put(((PasswordField) node).getId(), ((PasswordField) node).getText());
				}
				if (node instanceof NumericField) {
					m.Put(((NumericField) node).getId(), ((NumericField) node).getText());
				}
				if (node instanceof TextArea) {
					m.Put(((TextArea) node).getId(), ((TextArea) node).getText());
				}
				if (node instanceof CheckBox) {
					if (((CheckBox) node).isSelected()) {
						m.Put(((CheckBox) node).getId(), "1");
					} else {
						m.Put(((CheckBox) node).getId(), "0");
					}
				}
				if (node instanceof ComboBox) {
					m.Put(((ComboBox) node).getId(), ((ComboBox) node).getValue().toString());
				}
				if (node instanceof DatePicker) {
					LocalDate date = ((DatePicker) node).getValue();
					if(date != null){
						m.Put(((DatePicker) node).getId(), date.toString());
					} else {
						m.Put(((DatePicker) node).getId(), "");
					}
				}
		}
		// Put the map to the B4J mymap
		fieldmap.putAll(m.getObject());
		return fieldmap;
	} else {
		// Returns a non initialized B4J mymap
		return null;
	}
}

//NumericField Class
//Used for the SimpleFormDialog. Characters allowed are numbers 0-9, minus (-), dot (.)
public static class NumericField extends TextField {
    final String allowedPattern = "-?[0-9]*(\\.[0-9]*)?";	//"-?(\\d*)?";
	
    @Override
	public void replaceText(int start, int end, String text) {
    	if (text.matches(allowedPattern) || text == "") {
               super.replaceText(start, end, text);
        }
    }
     
	@Override
	public void replaceSelection(String text) {
    	if (text.matches(allowedPattern) || text == "") {
               super.replaceSelection(text);
        }
    }
}
//SIMPLEFORMDIALOG END

//IntegerInputDialog
//Parameter: Title, Header, Label, Value
//Result: The integer entered OR if cancelled/input error the default integer set
public static int IntegerInputDialog(String mtitle, String mheader, String mlabel, int mdefault ) {
	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	//Create the labels and fields.
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);

	final TextField numfield = new TextField();
	numfield.setPromptText(mlabel);
	numfield.setText(String.valueOf(mdefault));

	Platform.runLater(new Runnable() {
         @Override
         public void run() {
            numfield.requestFocus();
        }
	});	
	grid.add(new Label(mlabel), 0, 0);
	grid.add(numfield, 1, 0);

	//Enable OK button
	final Node buttonOK = dialog.getDialogPane().lookupButton(buttonTypeOK);
	buttonOK.setDisable(false);

	//Listen for numfield TextField text changes
	numfield.textProperty().addListener(new ChangeListener<String>() {
    	public void changed(ObservableValue<? extends String> observable, String oldValue, String newValue) {
    				final String allowedPattern = "-?([1-9][0-9]*)?";
    				if (!newValue.matches(allowedPattern)) {
        				numfield.setText(oldValue);
    				}
   		}
	});

	dialog.getDialogPane().setContent(grid);
	//Handle the dialog result based on the button clicked OK or Cancel
	dialog.initOwner(parentWindow);

	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}

	Optional<ButtonType> result = dialog.showAndWait();
	String value = numfield.getText();
	if (result.get() == buttonTypeOK){
		try {
    		return Integer.parseInt(value);
  		} catch (NumberFormatException e) {
    		return mdefault;
  		}
	} else {
		return mdefault; 
	}
}

public static String ChoiceDialog(String mtitle, String mheader, String mlabel, List<String> choices, int msel) {
	ChoiceDialog<String> dialog = new ChoiceDialog(null, choices);
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);
	dialog.setContentText(mlabel);
	dialog.setSelectedItem(choices.get(msel));
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
    dialog.getDialogPane().getButtonTypes().setAll(buttonTypeOK, buttonTypeCancel);
	dialog.initStyle(StageStyle.UTILITY);
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	Optional<String> result = dialog.showAndWait();
	if (result.isPresent()){
		return result.get();
	}
	else {
		return "";
	}	
}

//ExtendedDialog Get / Set Option to show the content expanded
private static boolean mExtendedDialogExpanded = false;
public static void SetExtendedDialogExpanded(final boolean expanded) {
	mExtendedDialogExpanded = expanded;
}
public static boolean GetExtendedDialogExpanded() {
	return mExtendedDialogExpanded;
}

private static String mExtendedDialogShowMoreDetailsText = "Show more details";
public static void SetExtendedDialogShowMoreDetailsText(final String text) {
	mExtendedDialogShowMoreDetailsText = text;
}
public static String GetExtendedDialogShowMoreDetailsText() {
	return mExtendedDialogShowMoreDetailsText;
}

//ExtendedDialog Get / Set Option to change the text of the hyperlink button showing more or less details
private static String mExtendedDialogShowLessDetailsText = "Show less details";
public static void SetExtendedDialogShowLessDetailsText(final String text) {
	mExtendedDialogShowLessDetailsText = text;
}
public static String GetExtendedDialogShowLessDetailsText() {
	return mExtendedDialogShowLessDetailsText;
}

//ExtendedDialog
private static Boolean mExtendedDialogHideDetails = false;
public static void SetExtendedDialogHideDetails(final Boolean hide) {
	mExtendedDialogHideDetails = hide;
}
public static Boolean GetExtendedDialogHideDetails() {
	return mExtendedDialogHideDetails;
}

public static void ExtendedDialog(String mtitle, String mheader, String mcontent, String mcontentextended) {
	final Alert alert = new Alert(AlertType.INFORMATION);
	alert.setTitle(mtitle);
	alert.setHeaderText(mheader);
	alert.setContentText(mcontent);

	TextArea textArea = new TextArea(mcontentextended);
	textArea.setEditable(false);
	textArea.setWrapText(true);

	textArea.setMaxWidth(Double.MAX_VALUE);
	textArea.setMaxHeight(Double.MAX_VALUE);
	GridPane.setVgrow(textArea, Priority.ALWAYS);
	GridPane.setHgrow(textArea, Priority.ALWAYS);

	GridPane expContent = new GridPane();
	expContent.setMaxWidth(Double.MAX_VALUE);
	expContent.add(textArea, 0, 0);

	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
    alert.getDialogPane().getButtonTypes().setAll(buttonTypeOK);
	alert.getDialogPane().setExpandableContent(expContent);
	alert.getDialogPane().setExpanded(GetExtendedDialogExpanded());

	Platform.runLater(new Runnable() {
		@Override
		public void run() {
			final Hyperlink detailsButton = (Hyperlink) alert.getDialogPane().lookup(".details-button");
			detailsButton.setText(GetExtendedDialogExpanded() ? GetExtendedDialogShowLessDetailsText() : GetExtendedDialogShowMoreDetailsText());
			detailsButton.setVisible(!GetExtendedDialogHideDetails());
			alert.getDialogPane().expandedProperty().addListener(new ChangeListener<Boolean>() {
				@Override
				public void changed(final ObservableValue<? extends Boolean> observable, final Boolean oldValue, final Boolean newValue) {
					detailsButton.setText(newValue ? GetExtendedDialogShowLessDetailsText() : GetExtendedDialogShowMoreDetailsText());
				}
			});
		} // Run
	});
	
	alert.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		alert.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	alert.showAndWait();
}

//Login Dialog
//Parameter: Title and Header information
//Result: Map with 2 entries holding username:username, password:password OR if cancelled a non initialized map
public static Map.MyMap LoginDialog(String mtitle, String mheader) {
	//Create a new username and password map
	Map.MyMap usernamepasswordmap = new Map.MyMap();
	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Set the button types Login and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeLogin = new ButtonType(mLoginButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeLogin, buttonTypeCancel);

	//Create the username and password labels and fields.
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);

	final TextField username = new TextField();
	username.setPromptText(mUsernamePrompt);

	Platform.runLater(new Runnable() {
         @Override
         public void run() {
            username.requestFocus();
        }
	});	
	//username.setText(musername); NOT USED
	PasswordField password = new PasswordField();
	password.setPromptText(mPasswordPrompt);

	grid.add(new Label(mUsernameLabel), 0, 0);
	grid.add(username, 1, 0);
	grid.add(new Label(mPasswordLabel), 0, 1);
	grid.add(password, 1, 1);

  	grid.setHgrow(username, Priority.ALWAYS);
  	grid.setHgrow(password, Priority.ALWAYS);

	//Enable/Disable login button depending on whether a username was entered = triggerd by textfield listener
	final Node loginButton = dialog.getDialogPane().lookupButton(buttonTypeLogin);
	loginButton.setDisable(true);

	// Listen for TextField text changes
	username.textProperty().addListener(new ChangeListener<String>() {
    	public void changed(ObservableValue<? extends String> observable, String oldValue, String newValue) {
			loginButton.setDisable(newValue.trim().isEmpty());
   		}
	});

	dialog.getDialogPane().setContent(grid);
	//Handle the dialog result based on the button clicked
	dialog.initOwner(parentWindow);
	if (mLoginButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeLogin).setStyle(mLoginButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeLogin){
		//Create a new map with 2 entries holding username:username, password:password
		Map m = new Map();
		m.Initialize();
		m.Put("username", username.getText());
		m.Put("password", password.getText());
		//Put the map to the B4J mymap
		usernamepasswordmap.putAll(m.getObject());
		return usernamepasswordmap;
	} else {
		//Returns a non initialized B4J mymap
		return null; 
	}
}

//Login Dialog2
//Parameter: Title and Header information, Default Username (can be empty)
//Result: Map with 2 entries holding username:username, password:password OR if cancelled a non initialized map
//In addition to the LoginDialog:
//* UserName as a Parameter
//* Shows in addition to the LoginDialog an icon. IMPORTANT = This icon "login.png" must be placed in the project files folder and added to the B4J IDE Files list.
public static Map.MyMap LoginDialog2(String mtitle, String mheader, String musername) {
	//Create the fx variable as required for displaying the icon
	anywheresoftware.b4j.objects.JFX fx = new anywheresoftware.b4j.objects.JFX();
	//Create a new username and password map
	Map.MyMap usernamepasswordmap = new Map.MyMap();
	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Set the icon (must be included in the B4J project files list (=add to tab files)).
	try {
		dialog.setGraphic(new ImageView((javafx.scene.image.Image)(fx.LoadImage(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"login.png").getObject())));
    } catch (Exception e) {
		throw new RuntimeException(e);
	};

	//Set the button types Login and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeLogin = new ButtonType(mLoginButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeLogin, buttonTypeCancel);

	//Create the username and password labels and fields.
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);
	// grid.setPadding(new Insets(20, 150, 10, 10));

	final TextField username = new TextField();
	username.setPromptText(mUsernamePrompt);
	username.setText(musername);
	Platform.runLater(new Runnable() {
         @Override
         public void run() {
            username.requestFocus();
        }
	});	
	PasswordField password = new PasswordField();
	password.setPromptText(mPasswordPrompt);

	grid.add(new Label(mUsernameLabel), 0, 0);
	grid.add(username, 1, 0);
	grid.add(new Label(mPasswordLabel), 0, 1);
	grid.add(password, 1, 1);

  	grid.setHgrow(username, Priority.ALWAYS);
  	grid.setHgrow(password, Priority.ALWAYS);

	//Enable/Disable login button depending on whether a username was entered = triggerd by textfield listener
	final Node loginButton = dialog.getDialogPane().lookupButton(buttonTypeLogin);
	loginButton.setDisable(username.getText().trim().isEmpty());

	//Listen for UserName TextField text changes
	username.textProperty().addListener(new ChangeListener<String>() {
    	public void changed(ObservableValue<? extends String> observable, String oldValue, String newValue) {
			loginButton.setDisable(newValue.trim().isEmpty());
   		}
	});

	dialog.getDialogPane().setContent(grid);
	//Handle the dialog result based on the button clicked Login or Cancel
	dialog.initOwner(parentWindow);
	if (mLoginButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeLogin).setStyle(mLoginButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeLogin){
		//Create a new map with 2 entries holding username:username, password:password
		Map m = new Map();
		m.Initialize();
		m.Put("username", username.getText());
		m.Put("password", password.getText());
		//Put the map to the B4J mymap
		usernamepasswordmap.putAll(m.getObject());
		return usernamepasswordmap;
	} else {
		//Returns a non initialized B4J mymap
		return null; 
	}
}

//Did You Know Dialog
//Parameter: Title and Header information, Content which can be shown in an extended way
//Result None
//IMPORTANT = This icon "dyk.png" must be placed in the project files folder and added to the B4J IDE Files list.
//Class Reference: http://docs.oracle.com/javase/8/javafx/api/javafx/scene/control/DialogPane.html
public static void DidYouKnowDialog(String mtitle, String mheader, String mcontent) {
	//Create the fx variable as required for displaying the icon
	anywheresoftware.b4j.objects.JFX fx = new anywheresoftware.b4j.objects.JFX();
	//Create the dialog
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);
	//Set the icon (must be included in the B4J project files list (=add to tab files)).
	try {
		dialog.setGraphic(new ImageView((javafx.scene.image.Image)(fx.LoadImage(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"dyk.png").getObject())));
    } catch (Exception e) {
		throw new RuntimeException(e);
	};

	//Add an OK button to close the dialog. Standard action is closing by setting OK_DONE.
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK);

	//Create the textarea showing the extended content.
	TextArea textArea = new TextArea(mcontent);
	textArea.setEditable(false);
	textArea.setWrapText(true);
	textArea.setMaxWidth(Double.MAX_VALUE);
	textArea.setMaxHeight(Double.MAX_VALUE);
	GridPane.setVgrow(textArea, Priority.ALWAYS);
	GridPane.setHgrow(textArea, Priority.ALWAYS);

	GridPane expContent = new GridPane();
	expContent.setMaxWidth(Double.MAX_VALUE);
	expContent.add(textArea, 0, 0);

	//Set the expandable content and show
	dialog.getDialogPane().setExpandableContent(expContent);
	dialog.getDialogPane().setExpanded(true);

	//Show the dialog till closed via OK button
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	Optional<ButtonType> result = dialog.showAndWait();
}

//Exception Dialog = Show the content of the exception stacktrace
//Parameter: Title and Header information, Content, Exception
//Result None
public static void ExceptionDialog(String mtitle, String mheader, String mcontent, Exception e) {
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	Alert alert = new Alert(AlertType.INFORMATION, mcontent, buttonTypeOK);
	alert.setTitle(mtitle);
	alert.setHeaderText(mheader);
	alert.setContentText(mcontent);

	//Build the exception string
    //Create new StringWriter object
    StringWriter sw = new StringWriter();
    //Create PrintWriter for StringWriter
    PrintWriter pw = new PrintWriter(sw);
    //Print the stacktrace to PrintWriter created
    e.printStackTrace(pw);
    //Use toString method to get stacktrace to String from StringWriter object
	TextArea textArea = new TextArea(sw.toString());
	//The textarea can not be added and has no wrap (makes it better readable)
	textArea.setEditable(false);
	textArea.setWrapText(false);
	textArea.setMaxWidth(Double.MAX_VALUE);
	textArea.setMaxHeight(Double.MAX_VALUE);
	GridPane.setVgrow(textArea, Priority.ALWAYS);
	GridPane.setHgrow(textArea, Priority.ALWAYS);

	GridPane expContent = new GridPane();
	expContent.setMaxWidth(Double.MAX_VALUE);
	expContent.add(textArea, 0, 0);

	//Set the expandable content and show
	alert.getDialogPane().setExpandableContent(expContent);
	alert.getDialogPane().setExpanded(true);

	//Set the button CSS style
	if (mOKButtonStyle.isEmpty() == false) {
		alert.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}

	alert.initOwner(parentWindow);
	alert.showAndWait();
}

// MessageDialog Properties
private static boolean mMessageDialogExpanded = true;
public static void SetMessageDialogExpanded(final boolean expanded) {
	mMessageDialogExpanded = expanded;
}
public static boolean GetMessageDialogExpanded() {
	return mMessageDialogExpanded;
}

private static String mMessageDialogShowMoreDetailsText = "Show more details";
public static void SetMessageDialogShowMoreDetailsText(final String text) {
	mMessageDialogShowMoreDetailsText = text;
}
public static String GetMessageDialogShowMoreDetailsText() {
	return mMessageDialogShowMoreDetailsText;
}

private static String mMessageDialogShowLessDetailsText = "Show less details";
public static void SetMessageDialogShowLessDetailsText(final String text) {
	mMessageDialogShowLessDetailsText = text;
}
public static String GetMessageDialogShowLessDetailsText() {
	return mMessageDialogShowLessDetailsText;
}

private static Boolean mMessageDialogWrapText = true;
public static void SetMessageDialogWrapText(final Boolean wrap) {
	mMessageDialogWrapText = wrap;
}
public static Boolean GetMessageDialogWrapText() {
	return mMessageDialogWrapText;
}

//Message Dialog with plain text content
//Parameter: Title and Message Content which is displayed in an extended way.
//Result None
public static void MessageDialog(String mtitle, String mcontent) {
	//Create the dialog
	final Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);

	//Add an OK button to close the dialog. Standard action is closing by setting OK_DONE.
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK);

	//Create the textarea showing the extended content.
	TextArea textArea = new TextArea(mcontent);
	textArea.setEditable(false);
	textArea.setWrapText(GetMessageDialogWrapText());
	textArea.setMaxWidth(Double.MAX_VALUE);
	textArea.setMaxHeight(Double.MAX_VALUE);
	GridPane.setVgrow(textArea, Priority.ALWAYS);
	GridPane.setHgrow(textArea, Priority.ALWAYS);

	GridPane expContent = new GridPane();
	expContent.setMaxWidth(Double.MAX_VALUE);
	expContent.add(textArea, 0, 0);

	//Set the expandable content and show
	dialog.getDialogPane().setExpandableContent(expContent);
	dialog.getDialogPane().setExpanded(GetMessageDialogExpanded());

	Platform.runLater(new Runnable() {
		@Override
		public void run() {
			final Hyperlink detailsButton = (Hyperlink) dialog.getDialogPane().lookup(".details-button");
			detailsButton.setText(
					GetMessageDialogExpanded() ? GetMessageDialogShowLessDetailsText() : GetMessageDialogShowMoreDetailsText());

			dialog.getDialogPane().expandedProperty().addListener(new ChangeListener<Boolean>() {
				@Override
				public void changed(final ObservableValue<? extends Boolean> observable, final Boolean oldValue, final Boolean newValue) {
					detailsButton.setText(newValue ? GetMessageDialogShowLessDetailsText() : GetMessageDialogShowMoreDetailsText());
				}
			});
		} // Run
	});

	//Show the dialog till closed via OK button
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	dialog.showAndWait();
}

// MessageHTMLDialog Get / Set Option to show the content exapnded
private static boolean mMessageHTMLDialogExpanded = true;
public static void SetMessageHTMLDialogExpanded(final boolean expanded) {
	mMessageHTMLDialogExpanded = expanded;
}
public static boolean GetMessageHTMLDialogExpanded() {
	return mMessageHTMLDialogExpanded;
}

private static String mMessageHTMLDialogShowMoreDetailsText = "Show more details";
public static void SetMessageHTMLDialogShowMoreDetailsText(final String text) {
	mMessageHTMLDialogShowMoreDetailsText = text;
}
public static String GetMessageHTMLDialogShowMoreDetailsText() {
	return mMessageHTMLDialogShowMoreDetailsText;
}

private static String mMessageHTMLDialogShowLessDetailsText = "Show less details";
public static void SetMessageHTMLDialogShowLessDetailsText(final String text) {
	mMessageHTMLDialogShowLessDetailsText = text;
}
public static String GetMessageHTMLDialogShowLessDetailsText() {
	return mMessageHTMLDialogShowLessDetailsText;
}

private static Boolean mMessageHTMLDialogHideDetails = false;
public static void SetMessageHTMLDialogHideDetails(final Boolean hide) {
	mMessageHTMLDialogHideDetails = hide;
}
public static Boolean GetMessageHTMLDialogHideDetails() {
	return mMessageHTMLDialogHideDetails;
}

//Message Dialog with HTML formatted content.
//Anchors are handled if defined like <a href="#myanchor">Jump to myanchor</a> ... <a name="myanchor"></a>
//Parameter: Title and Header information, HTML formatted content which is displayed in an extended way.
//Result None
public static void MessageHTMLDialog(String mtitle, String mcontent) {
	//Create the dialog
  	final Dialog dialog = new Dialog();
  	dialog.setTitle(mtitle);
  	//dialog.setHeaderText(mheader);

  	//Add an OK button to close the dialog. Standard action is closing by setting OK_DONE.
	dialog.getDialogPane().getButtonTypes().clear();
  	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
  	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK);

  	//Create the webview showing the content.
	final WebView webView = new WebView();
 	final WebEngine webEngine = webView.getEngine();
	webEngine.setJavaScriptEnabled(true);
	webEngine.loadContent(mcontent);

	//Handle events on hyperlinks (href)
	webView.getEngine().getLoadWorker().stateProperty().addListener(new ChangeListener<State>() {
            @Override
            public void changed(ObservableValue ov, State oldState, State newState) {
                if (newState == Worker.State.SUCCEEDED) {
                    EventListener listener = new EventListener() {
                        @Override
                        public void handleEvent(Event ev) {
                            String domEventType = ev.getType();
                            if (domEventType.equals("click")) {
                                String href = ((Element)ev.getTarget()).getAttribute("href");
		                        try {
									//Define in HTML like <a href="#myanchor">Jump to myanchor</a> ... <a name="myanchor"></a>
									String script = "var str='"+href+"'; str=str.replace(/[^a-zA-Z0-9]/g,''); document.getElementsByName(str)[0].scrollIntoView(true);";
									webEngine.executeScript(script);
									
									//Note:Alternative to consider using an ID to jump to
									//This works with <a href="#myanchor">Jump to myanchor</a> ....... <div id="#myanchor"></div>
									//String script = "document.getElementById('"+href+"').scrollIntoView(true);";
            		            } 
								catch (Exception e) {
									}
                            	}
                        }
                    };
					// Add the eventlistener to all elements with tagname a.
                    Document doc = webView.getEngine().getDocument();
                    NodeList nodeList = doc.getElementsByTagName("a");
                    for (int i = 0; i < nodeList.getLength(); i++) {
                        ((EventTarget) nodeList.item(i)).addEventListener("click", listener, false);
                    }
                }
            }
        });
 
  	GridPane.setVgrow(webView, Priority.ALWAYS);
  	GridPane.setHgrow(webView, Priority.ALWAYS);

  	GridPane expContent = new GridPane();
  	expContent.setMaxWidth(Double.MAX_VALUE);
  	expContent.add(webView, 0, 0);

  	//Set the expandable content and show
  	dialog.getDialogPane().setExpandableContent(expContent);
  	dialog.getDialogPane().setExpanded(GetMessageHTMLDialogExpanded());

	Platform.runLater(new Runnable() {
		@Override
		public void run() {
			final Hyperlink detailsButton = (Hyperlink) dialog.getDialogPane().lookup(".details-button");
			detailsButton.setText(
					GetMessageHTMLDialogExpanded() ? GetMessageHTMLDialogShowLessDetailsText() : GetMessageHTMLDialogShowMoreDetailsText());

			detailsButton.setVisible(!GetMessageHTMLDialogHideDetails());

			dialog.getDialogPane().expandedProperty().addListener(new ChangeListener<Boolean>() {
				@Override
				public void changed(final ObservableValue<? extends Boolean> observable, final Boolean oldValue, final Boolean newValue) {
					detailsButton.setText(newValue ? GetMessageHTMLDialogShowLessDetailsText() : GetMessageHTMLDialogShowMoreDetailsText());
				}
			});
		} // Run
	});

  	//Show the dialog till closed via OK button
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
  	dialog.showAndWait();
}

//Message Dialog 2 with HTML formatted content which is always displayed
//Anchors are handled if defined like <a href="#myanchor">Jump to myanchor</a> ... <a name="myanchor"></a>
//Parameter: Title, Header, HTML formatted content which is displayed in an extended way.
//Result None
public static void MessageHTMLDialog2(String mtitle, String mheader, String mcontent) {
	//Create the dialog
  	final Dialog dialog = new Dialog();
  	dialog.setTitle(mtitle);
  	dialog.setHeaderText(mheader);

  	//Add an OK button to close the dialog. Standard action is closing by setting OK_DONE.
	dialog.getDialogPane().getButtonTypes().clear();
  	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
  	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK);

  	//Create the webview showing the content.
	final WebView webView = new WebView();
 	final WebEngine webEngine = webView.getEngine();
	webEngine.setJavaScriptEnabled(true);
	webEngine.loadContent(mcontent);

	//Handle events on hyperlinks (href)
	webView.getEngine().getLoadWorker().stateProperty().addListener(new ChangeListener<State>() {
            @Override
            public void changed(ObservableValue ov, State oldState, State newState) {
                if (newState == Worker.State.SUCCEEDED) {
                    EventListener listener = new EventListener() {
                        @Override
                        public void handleEvent(Event ev) {
                            String domEventType = ev.getType();
                            if (domEventType.equals("click")) {
                                String href = ((Element)ev.getTarget()).getAttribute("href");
		                        try {
									//Define in HTML like <a href="#myanchor">Jump to myanchor</a> ... <a name="myanchor"></a>
									String script = "var str='"+href+"'; str=str.replace(/[^a-zA-Z0-9]/g,''); document.getElementsByName(str)[0].scrollIntoView(true);";
									webEngine.executeScript(script);
									
									//Note:Alternative to consider using an ID to jump to
									//This works with <a href="#myanchor">Jump to myanchor</a> ....... <div id="#myanchor"></div>
									//String script = "document.getElementById('"+href+"').scrollIntoView(true);";
            		            } 
								catch (Exception e) {
									}
                            	}
                        }
                    };
					// Add the eventlistener to all elements with tagname a.
                    Document doc = webView.getEngine().getDocument();
                    NodeList nodeList = doc.getElementsByTagName("a");
                    for (int i = 0; i < nodeList.getLength(); i++) {
                        ((EventTarget) nodeList.item(i)).addEventListener("click", listener, false);
                    }
                }
            }
        });
 
  	GridPane.setVgrow(webView, Priority.ALWAYS);
  	GridPane.setHgrow(webView, Priority.ALWAYS);

  	GridPane expContent = new GridPane();
  	expContent.setMaxWidth(Double.MAX_VALUE);
  	expContent.add(webView, 0, 0);

  	//Set the expandable content and show
  	dialog.getDialogPane().setExpandableContent(expContent);
  	dialog.getDialogPane().setExpanded(true);

	Platform.runLater(new Runnable() {
		@Override
		public void run() {
			final Hyperlink detailsButton = (Hyperlink) dialog.getDialogPane().lookup(".details-button");
			detailsButton.setVisible(false);
		} // Run
	});

  	//Show the dialog till closed via OK button
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
  	dialog.showAndWait();
}

//Message Dialog with HTML formatted content returning true (OK) or false (Cancel)
//Anchors are handled if defined like <a href="#myanchor">Jump to myanchor</a> ... <a name="myanchor"></a>
//Parameter: Title and Header information, HTML formatted content which is displayed in an extended way.
//Result None
public static boolean MessageHTMLDialog3(String mtitle, String mcontent) {
	//Create the dialog
  	final Dialog dialog = new Dialog();
  	dialog.setTitle(mtitle);
  	//dialog.setHeaderText(mheader);

  	//Add an OK button to close the dialog. Standard action is closing by setting OK_DONE.
	dialog.getDialogPane().getButtonTypes().clear();
  	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
  	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
  	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK,buttonTypeCancel);

  	//Create the webview showing the content.
	final WebView webView = new WebView();
 	final WebEngine webEngine = webView.getEngine();
	webEngine.setJavaScriptEnabled(true);
	webEngine.loadContent(mcontent);

	//Handle events on hyperlinks (href)
	webView.getEngine().getLoadWorker().stateProperty().addListener(new ChangeListener<State>() {
            @Override
            public void changed(ObservableValue ov, State oldState, State newState) {
                if (newState == Worker.State.SUCCEEDED) {
                    EventListener listener = new EventListener() {
                        @Override
                        public void handleEvent(Event ev) {
                            String domEventType = ev.getType();
                            if (domEventType.equals("click")) {
                                String href = ((Element)ev.getTarget()).getAttribute("href");
		                        try {
									//Define in HTML like <a href="#myanchor">Jump to myanchor</a> ... <a name="myanchor"></a>
									String script = "var str='"+href+"'; str=str.replace(/[^a-zA-Z0-9]/g,''); document.getElementsByName(str)[0].scrollIntoView(true);";
									webEngine.executeScript(script);
									
									//Note:Alternative to consider using an ID to jump to
									//This works with <a href="#myanchor">Jump to myanchor</a> ....... <div id="#myanchor"></div>
									//String script = "document.getElementById('"+href+"').scrollIntoView(true);";
            		            } 
								catch (Exception e) {
									}
                            	}
                        }
                    };
					// Add the eventlistener to all elements with tagname a.
                    Document doc = webView.getEngine().getDocument();
                    NodeList nodeList = doc.getElementsByTagName("a");
                    for (int i = 0; i < nodeList.getLength(); i++) {
                        ((EventTarget) nodeList.item(i)).addEventListener("click", listener, false);
                    }
                }
            }
        });
 
  	GridPane.setVgrow(webView, Priority.ALWAYS);
  	GridPane.setHgrow(webView, Priority.ALWAYS);

  	GridPane expContent = new GridPane();
  	expContent.setMaxWidth(Double.MAX_VALUE);
  	expContent.add(webView, 0, 0);

  	//Set the expandable content and show
  	dialog.getDialogPane().setExpandableContent(expContent);
  	dialog.getDialogPane().setExpanded(GetMessageHTMLDialogExpanded());

	Platform.runLater(new Runnable() {
		@Override
		public void run() {
			final Hyperlink detailsButton = (Hyperlink) dialog.getDialogPane().lookup(".details-button");

			detailsButton.setVisible(!GetMessageHTMLDialogHideDetails());

			detailsButton.setText(
					GetMessageHTMLDialogExpanded() ? GetMessageHTMLDialogShowLessDetailsText() : GetMessageHTMLDialogShowMoreDetailsText());

			dialog.getDialogPane().expandedProperty().addListener(new ChangeListener<Boolean>() {
				@Override
				public void changed(final ObservableValue<? extends Boolean> observable, final Boolean oldValue, final Boolean newValue) {
					detailsButton.setText(newValue ? GetMessageHTMLDialogShowLessDetailsText() : GetMessageHTMLDialogShowMoreDetailsText());
				}
			});

		} // Run
	});

  	//Show the dialog till closed via OK button
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK){
		return true; 
	} else {
		return false; 
	}
}

//List Dialog from which a single item can be selected.
//Parameter: Title and Header information, List of items to select from.
//Result Selected item as string or an empty string
public static String ListDialog(String mtitle, String mheader, List<String> items, int msel) {
	//Create the dialog
  	Dialog dialog = new Dialog();
  	dialog.setTitle(mtitle);
  	dialog.setHeaderText(mheader);

	//Add an OK and CANCEL button to select & close the dialog or cancel the dialog.
	dialog.getDialogPane().getButtonTypes().clear();
  	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
  	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
  	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

  	//Create the listview.
	final ListView listView = new ListView();
	listView.getSelectionModel().setSelectionMode(SelectionMode.SINGLE);
    listView.setEditable(false);

	ObservableList<String> litems = FXCollections.observableArrayList();
	litems.addAll(items);
	listView.setItems(litems);
	if (msel > -1){
		listView.getSelectionModel().select(msel);
		listView.getFocusModel().focus(msel);
		listView.scrollTo(msel);
	}

	GridPane.setVgrow(listView, Priority.ALWAYS);
  	GridPane.setHgrow(listView, Priority.ALWAYS);

  	GridPane expContent = new GridPane();
  	expContent.setMaxWidth(Double.MAX_VALUE);
  	expContent.add(listView, 0, 0);

  	//Set the content
  	dialog.getDialogPane().setContent(expContent);

  	//Show the dialog till closed via OK or CANCEL button
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
  	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK){
		//OK returns the selected item as string or if an empty string if not selected
		int idx = listView.getSelectionModel().getSelectedIndex();
		if (idx < 0) {
			return "";
		} else {
			return listView.getSelectionModel().getSelectedItem().toString();
		}
	} else {
		//Cancel returns an empty string
		return ""; 
	}
}

//List Dialog2 from which multiple items can be selected.
//Parameter: Title and Header information, List of items to select from.
//Result one or more selected items as a Map (nr:item) or a non initialized Map
public static Map.MyMap ListDialog2(String mtitle, String mheader, List<String> items, int msel) {
	//Create a selecteditems map
	Map.MyMap selecteditemsmap = new Map.MyMap();
	//Create the dialog
  	Dialog dialog = new Dialog();
  	dialog.setTitle(mtitle);
  	dialog.setHeaderText(mheader);

	//Add an OK and CANCEL button to select & close the dialog or cancel the dialog.
	dialog.getDialogPane().getButtonTypes().clear();
  	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
  	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
  	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

  	//Create the listview.
	ListView listView = new ListView();
	listView.getSelectionModel().setSelectionMode(SelectionMode.MULTIPLE);
	listView.setEditable(false);
	ObservableList<String> litems = FXCollections.observableArrayList();
	litems.addAll(items);
	listView.setItems(litems);
	if (msel > -1){
		listView.getSelectionModel().select(msel);
		listView.getFocusModel().focus(msel);
		listView.scrollTo(msel);
	}
	GridPane.setVgrow(listView, Priority.ALWAYS);
  	GridPane.setHgrow(listView, Priority.ALWAYS);

  	GridPane expContent = new GridPane();
  	expContent.setMaxWidth(Double.MAX_VALUE);
  	expContent.add(listView, 0, 0);

  	//Set the content
  	dialog.getDialogPane().setContent(expContent);

  	//Show the dialog till closed via OK or CANCEL button
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
  	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK){
		//OK returns the selected item as string or if an empty string if not selected
		Map m = new Map();
		m.Initialize();
		ObservableList<String> selectedItems =  listView.getSelectionModel().getSelectedItems();
		ObservableList<Integer> selectedIndices =  listView.getSelectionModel().getSelectedIndices();
		int i = -1;
        for(String s : selectedItems){
			i = i +1;
			m.Put(selectedIndices.get(i), s);
        }
		selecteditemsmap.putAll(m.getObject());
		return selecteditemsmap;
	} else {
		//Cancel returns an empty string
		return null; 
	}
}

//Select Dialog from which a single item can be selected.
//Parameter: Title, List of items to select from, Default Item, Height and With
//Result Selected item as Int or -1 if nothing selected
public static Integer SelectDialog(String mtitle, List<String> items, int msel, Double height, Double width) {
	//Create the dialog
  	Dialog dialog = new Dialog();
  	dialog.setTitle(mtitle);
	dialog.initStyle(StageStyle.UTILITY);
	dialog.setHeight(height);
	dialog.setWidth(width);

	//Add a Select button to select & close the dialog
	dialog.getDialogPane().getButtonTypes().clear();
  	ButtonType buttonTypeOK = new ButtonType(mSelectButtonText, ButtonBar.ButtonData.OK_DONE);
  	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK);

  	//Create the listview.
	ListView listView = new ListView();
	listView.setPrefHeight(height - 50);
	listView.getSelectionModel().setSelectionMode(SelectionMode.SINGLE);
    listView.setEditable(false);
	ObservableList<String> litems = FXCollections.observableArrayList();
	litems.addAll(items);
	listView.setItems(litems);
	listView.getSelectionModel().select(msel);
	listView.scrollTo(msel);
	listView.getFocusModel().focus(msel);

  	//Set the content
  	dialog.getDialogPane().setContent(listView);

  	//Show the dialog till closed via OK or CANCEL button
	dialog.setX(10);
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	Optional<ButtonType> result = dialog.showAndWait();
	Integer rt = -1;
	try {
		//OK returns the selected item as int, if nothing selected then -1 is returned
		if (result.get() == buttonTypeOK){
			rt = listView.getSelectionModel().getSelectedIndex();
		}
    }
   	catch (NoSuchElementException exception) {
		//Dialog Close [X] button selected
    }
	return rt; 
}

//SpinnerIntegerDialog with default value and amount to step by.
//Parameter: Title and Header, Label, Integer Values Min, Max, Initial, StepBy
//Result: Integer with selected value or -1 if cancelled
public static Integer SpinnerIntegerDialog(String mtitle, String mheader, String mlabel, Integer min, Integer max, Integer initialValue, Integer amountToStepBy) {
//public static String SpinnerDialog(String mtitle, String mheader, String mlabel, double min, double max, double initialValue, double amountToStepBy) {
	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	//Create the labels and fields.
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);

	Spinner spinner = new Spinner(min, max, initialValue, amountToStepBy);
	grid.add(new Label(mlabel), 0, 0);
	grid.add(spinner, 1, 0);

	dialog.getDialogPane().setContent(grid);
	//Handle the dialog result based on the button clicked OK or Cancel
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK){
		return (Integer) spinner.getValueFactory().getValue();
	} else {
		return -1; 
	}
}

//SpinnerDoubleDialog with default value and amount to step by.
//Parameter: Title and Header, Label, Double Values Min, Max, Initial, StepBy
//Result: Double with selected value or -1 if cancelled
public static Double SpinnerDoubleDialog(String mtitle, String mheader, String mlabel, double min, double max, double initialValue, double amountToStepBy) {
	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	//Create the labels and fields.
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);

	Spinner spinner = new Spinner(min, max, initialValue, amountToStepBy);
	grid.add(new Label(mlabel), 0, 0);
	grid.add(spinner, 1, 0);

	dialog.getDialogPane().setContent(grid);
	//Handle the dialog result based on the button clicked OK or Cancel
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK){
		return (Double) spinner.getValueFactory().getValue();
	} else {
		return -1.0; 
	}
}

//SpinnerListDialog
//Parameter: Title and Header, Items as List
//Result: String
public static String SpinnerListDialog(String mtitle, String mheader, String mlabel, List<String> items) {
	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	//Create the labels and fields.
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);

	ObservableList<String> litems = FXCollections.observableArrayList();
	litems.addAll(items);
	Spinner spinner = new Spinner(litems);
	grid.add(new Label(mlabel), 0, 0);
	grid.add(spinner, 1, 0);

	dialog.getDialogPane().setContent(grid);
	//Handle the dialog result based on the button clicked OK or Cancel
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK){
		return (String) spinner.getValueFactory().getValue();
	} else {
		return ""; 
	}
}

//TextAreaDialog
//Parameter: Title and Header, Prompt Label1 for Field1, Default Values for Field1
//Result: String OR if cancelled a null string
public static String TextAreaDialog(String mtitle, String mheader, String mlabel1, String mfield1) {
	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	//Create the labels and fields.
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);
	// grid.setPadding(new Insets(20, 150, 10, 10));

	final TextArea field1 = new TextArea();
	field1.setPromptText(mlabel1);
	field1.setText(mfield1);
	Platform.runLater(new Runnable() {
         @Override
         public void run() {
            field1.requestFocus();
        }
	});	

	grid.add(new Label(mlabel1), 0, 0);
	grid.add(field1, 1, 0);
	dialog.getDialogPane().setContent(grid);
	//Handle the dialog result based on the button clicked OK or Cancel
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK){
		return field1.getText();
	} else {
		//Returns a null string
		return null; 
	}
}

//
//TOASTMESSAGE
//Android like ToastMessage. 
//The solution does not make use of JavaFX Dialogs but Swing Components
//Parameter:
//Message to show.
//Can include html (use <html>Message Line 1<BR>Message Line 2</html>
//miliseconds to keep the message visible

/*
 * ToastMessage Getter / Setter
 */
private static int mFontsizeToastMessage = 16;
private static int mBorderwidthToastMessage = 1;
private static java.awt.Color mBackgroundColorToastMessage = java.awt.Color.LIGHT_GRAY;
private static java.awt.Color mBorderColorToastMessage = java.awt.Color.DARK_GRAY;

public static void setToastMessageFontSize(final int fontsize) {
	mFontsizeToastMessage = fontsize;
}

public static int getToastMessageFontSize() {
	return mFontsizeToastMessage;
}

public static void setToastMessageBorderWidth(final int width) {
	mBorderwidthToastMessage = width;
}

public static int getToastMessageBorderWidth() {
	return mBorderwidthToastMessage;
}

public static void setToastMessageBackgroundColor(final javafx.scene.paint.Color fxc) {
	final java.awt.Color awtColor = new java.awt.Color((float) fxc.getRed(), (float) fxc.getGreen(), (float) fxc.getBlue(),
			(float) fxc.getOpacity());
	mBackgroundColorToastMessage = awtColor;
}

public static java.awt.Color getToastMessageBackgroundColor() {
	return mBackgroundColorToastMessage;
}

public static void setToastMessageBorderColor(final javafx.scene.paint.Color fxc) {
	final java.awt.Color awtColor = new java.awt.Color((float) fxc.getRed(), (float) fxc.getGreen(), (float) fxc.getBlue(),
			(float) fxc.getOpacity());
	mBorderColorToastMessage = awtColor;
}

public static java.awt.Color getToastMessageBorderColor() {
	return mBorderColorToastMessage;
}

public static void ToastMessage(final String message, final int miliseconds) {
	final JFrame frame = new JFrame("");
	final JPanel panel = new JPanel();
	final JLabel label = new JLabel(message);

	panel.setBackground(getToastMessageBackgroundColor());
	panel.setBorder(new LineBorder(getToastMessageBorderColor(), getToastMessageBorderWidth()));
	frame.getContentPane().add(panel, BorderLayout.CENTER);
	label.setFont(new Font("Dialog", Font.BOLD, getToastMessageFontSize()));
	panel.add(label);
	frame.add(panel);
	frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	frame.setUndecorated(true);
	frame.pack();
	frame.setLocationRelativeTo(null);
	new Thread() {
		@Override
		public void run() {
			try {
				frame.setVisible(true);
				Thread.sleep(miliseconds);
				frame.dispose();
			} catch (final InterruptedException e) {
				e.printStackTrace();
			}
		}
	}.start();
}
//TOASTMESSAGE END

//TOASTMESSAGEALERT START
// ToastMessageAlert Get / Set Style
private static String mToastMessageAlertStyle = "";

/**
 * Set the style for certain properties of the Alert Dialog
 * mbordercolor - String, i.e. BLUE
 * mborderwidth - int, default is 1
 * mborderradius - int, default is 0
 * mfontsize - int, defaullt is 16
 */
public static void SetToastMessageAlertStyle(String mbordercolor, int mborderwidth, int mborderradius, int mfontsize) {
	if (mbordercolor.length() == 0) {
		mbordercolor = "lightgrey";
	}
	if (mborderwidth < 0) {
		mborderwidth = 1;
	}
	if (mborderradius < 0) {
		mborderradius = 0;
	}
	if (mfontsize < 0) {
		mfontsize = 16;
	}

	mToastMessageAlertStyle = "-fx-border-color:" + mbordercolor + ";-fx-border-width:" + String.valueOf(mborderwidth) + "px;-fx-border-radius:" + String.valueOf(mborderradius) + "; -fx-font-size:" + String.valueOf(mfontsize) + "px;";
}

/**
 * Get the style of the ToastMessageAlert
 * Returns - String with CSS selectors.
 */
public static String GetToastMessageAlertStyle() {
	return mToastMessageAlertStyle;
}

/**
 * Display a ToastMessage using JavaFX Alert Dialog
 *
 * @param malerttype - String, types are Information, Warning, Error
 * @param mheader - String, Header displayed above the content
 * @param mcontent - String, Content
 * @param miliseconds - int, duration of the dialog being displayed
 */
public static void ToastMessageAlert(final String malerttype, final String mheader, final String mcontent, int milliseconds) {
	if (milliseconds < 0) {
		milliseconds = 0;
	}
	final int ms = milliseconds;
		// Set the alert type - default is information
	AlertType alerttype = AlertType.INFORMATION;
	if (malerttype.toLowerCase().equals("warning")) {
		alerttype = AlertType.WARNING;
	}
	if (malerttype.toLowerCase().equals("error")) {
		alerttype = AlertType.ERROR;
	}
	final Alert alert = new Alert(alerttype, mcontent);
	// Hide the button
	alert.getDialogPane().lookupButton(ButtonType.OK).setVisible(false);
	// Set the header
	alert.setHeaderText(mheader);
	// Set style to undecorated
	alert.initStyle(StageStyle.UNDECORATED);
	// alert.getDialogPane().setStyle(GetToastMessageAlertBorderStyle());
	alert.getDialogPane().setStyle(GetToastMessageAlertStyle());
	alert.show();

	final Thread newThread = new Thread(new Runnable() {
		@Override
		public void run() {
			try {
				Thread.sleep(ms);
			} catch (final InterruptedException ex) {
				Thread.currentThread().interrupt();
			}
				Platform.runLater(new Runnable() {
				@Override
				public void run() {
					alert.close();
				}
			});
		}
	});
	newThread.start();
}

//TOASTMESSAGEALERT END

//DATE AND TIME
//Show a DatePickerDialog with default date and weeknumbers
//Parameter: Title and Header, Prompt, Default Date
//Result: String with selected date or empty if cancelled
//Note: Important to set the pattern (i.e. DateTime.DateFormat = "yyyy-MM-dd") prior calling this method; if default date is empty ("") then actual date is set
public static String DatePickerDialog(String mtitle, String mheader, String mlabel, String mdate) {
	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	//Create the labels and fields.
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);

	DatePicker datePicker = new DatePicker();
	datePicker.setShowWeekNumbers(true);
	if(mdate.isEmpty() == false) {
		datePicker.setValue(LocalDate.parse(mdate));
	} else {
		datePicker.setValue(LocalDate.now());
	}
	grid.add(new Label(mlabel), 0, 0);
	grid.add(datePicker, 1, 0);

	dialog.getDialogPane().setContent(grid);
	//Handle the dialog result based on the button clicked OK or Cancel
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK){
		LocalDate date = datePicker.getValue();
		if(date != null){
			return date.toString();
		} else {
			return "";
		}
	} else {
		return ""; 
	}
}

//TimePicker24
//Show a Time Picker 24hr Dialog with default values for hours, minutes
//Parameter: Title and Header, Integer Values Hours (0-23), Minutes (0-59), SetNow
//If SetNow is true, the parameter Hours, Minutes,Seconds are omitted as current time is set.
//Result: Time String HH:mm:ss or empty string if cancelled
public static String TimePicker24Dialog(String mtitle, String mheader, Integer mhours, Integer mminutes, boolean msetnow) {
	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Check SetNow Flag. if set, then adjust the hour,minute, second
	if (msetnow){
		LocalDateTime now = LocalDateTime.now();
		mhours = now.getHour();
		mminutes = now.getMinute();
	}

	//Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	//Create the gridpane
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);

	//Add 2 spinners hours, minutes each having width 70 
	Spinner spinnerhours = new Spinner(0, 23, mhours, 1);
	grid.add(spinnerhours, 0, 0);
	grid.getColumnConstraints().add(new ColumnConstraints(70)); // column 1

	Spinner spinnerminutes = new Spinner(0, 59, mminutes, 1);
	grid.add(spinnerminutes, 1, 0);
    grid.getColumnConstraints().add(new ColumnConstraints(70)); // column 2

	dialog.getDialogPane().setContent(grid);

	//Handle the dialog result based on the button clicked OK or Cancel
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK){
		int h = (int) spinnerhours.getValueFactory().getValue();
		int m = (int) spinnerminutes.getValueFactory().getValue();
		//Result in format HH:mm, e.g. 19:01
		return String.format("%1$02d:%2$02d", h, m);
	} else {
		return ""; 
	}
}

//TimePicker12
//Show a Time Picker 12hr Dialog with default values for hours, minutes, AMPM
//Parameter: Title and Header, Integer Values Hours (1-12), Minutes (0-59), AP ("AM" or "PM"), SetNow
//If SetNow is true, the parameter Hours, Minutes are omitted as current time is set.
//Result: Time String HH:mm AM/PM or empty string if cancelled
public static String TimePicker12Dialog(String mtitle, String mheader, Integer mhours, Integer mminutes, String mampm, boolean msetnow) {
	//Create a new dialog and set title and header
	Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	//Check if mampm is empty
	if(mampm.isEmpty()) { mampm = "AM"; }

	//Check SetNow Flag. if set, then adjust the hour,minute, second
	if (msetnow){
		LocalDateTime now = LocalDateTime.now();
		mhours = now.getHour();
		mminutes = now.getMinute();
	}

	//Correct the hours to 12 hr format
   	if (mhours   > 11) { mampm = "PM"; }
   	if (mhours   > 12) { mhours = mhours - 12; }
   	if (mhours   == 0) { mhours = 12; }

	//Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonBar.ButtonData.OK_DONE);
	ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonBar.ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	//Create the gridpane
	GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);

	//Add 3 spinners hours, minutes, AMPM
	Spinner spinnerhours = new Spinner(1, 12, mhours, 1);
	grid.add(spinnerhours, 0, 0);
	grid.getColumnConstraints().add(new ColumnConstraints(70)); // column 1

	Spinner spinnerminutes = new Spinner(0, 59, mminutes, 1);
	grid.add(spinnerminutes, 1, 0);
    grid.getColumnConstraints().add(new ColumnConstraints(70)); // column 2

	ObservableList<String> lampm = FXCollections.observableArrayList();
	lampm.add("AM");
	lampm.add("PM");
	Spinner spinnerampm = new Spinner(lampm);
	spinnerampm.getValueFactory().setValue(mampm);
	grid.add(spinnerampm, 2, 0);
    grid.getColumnConstraints().add(new ColumnConstraints(74)); // column 3

	dialog.getDialogPane().setContent(grid);

	//Handle the dialog result based on the button clicked OK or Cancel
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK){
		int h = (int) spinnerhours.getValueFactory().getValue();
		int m = (int) spinnerminutes.getValueFactory().getValue();
		String ampm = (String) spinnerampm.getValueFactory().getValue();
		//Result in format HH:mm a, e.g. 11:01 AM
		return String.format("%1$02d:%2$02d %3$s", h, m, ampm);
	} else {
		return ""; 
	}
}

//COLORNAMEDIALOG START
public static javafx.scene.paint.Color ColorNameDialog(final String mtitle, final String mheader, final int mdefault) {
	// Create a color label to show the color name and hex value
	final Label colorLabel = new Label();
	colorLabel.setAlignment(Pos.CENTER);
	colorLabel.setStyle("-fx-font-size: 18px; -fx-text-fill: #000000"); // -fx-background-color: white;");
	colorLabel.setMaxWidth(250);
	colorLabel.setMaxHeight(40);
	colorLabel.setWrapText(true);

	// Create the dialog
	final Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	// Add an OK and CANCEL button to select & close the dialog or cancel the dialog.
	dialog.getDialogPane().getButtonTypes().clear();
	final ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonData.OK_DONE);
	final ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	// Create the list view
	final ListView listView = new ListView();
	listView.getSelectionModel().setSelectionMode(SelectionMode.SINGLE);
	listView.setEditable(false);

	// Build the list holding the color names
	final ObservableList<String> data = FXCollections.observableArrayList();
	Class<?> clcolor;
	try {
		clcolor = Class.forName("javafx.scene.paint.Color");
		if (clcolor != null) {
			final Field[] field = clcolor.getFields();
			for (final Field f : field) {
				final Object objn = f.get(null);
				if (objn instanceof javafx.scene.paint.Color) {
					data.add(f.getName()); // The color name i.e. BLACK, RED
					// To get the string representation of the color use:
					// final javafx.scene.paint.Color c = (Color) objn;
					// data.add(c.toString());
				}
			}
		}
	} catch (final ClassNotFoundException e) {
		e.printStackTrace();
		return null;
	} catch (final IllegalArgumentException e) {
		e.printStackTrace();
		return null;
	} catch (final IllegalAccessException e) {
		e.printStackTrace();
		return null;
	}

	// ListView add the data (color names), select the default
	listView.setItems(data);
	listView.getSelectionModel().select(mdefault);
	listView.getFocusModel().focus(mdefault);
	listView.scrollTo(mdefault);

	// Define a custom listview cellfactory to show the color as rect and a label with the color name
	listView.setCellFactory(new Callback<ListView<String>, ListCell<String>>() {
		@Override
		public ListCell<String> call(final ListView<String> list) {
			return new ColorRectCell();
		}
	});

	// Define the listview changelistener to update the label showing the colorname and hex value
	listView.getSelectionModel().selectedItemProperty().addListener(new ChangeListener<String>() {
		@Override
		public void changed(final ObservableValue<? extends String> ov, final String old_val, final String new_val) {
			colorLabel.setText(new_val);
		}
	});

	Platform.runLater(new Runnable() {
		@Override
		public void run() {
			listView.requestFocus();
		}
	});

	// Build the grid pane with the ListView and the Label
	GridPane.setVgrow(listView, Priority.ALWAYS);
	GridPane.setHgrow(listView, Priority.ALWAYS);

	final GridPane expContent = new GridPane();
	expContent.setMaxWidth(Double.MAX_VALUE);
	expContent.add(listView, 0, 0);
	expContent.add(colorLabel, 0, 1);

	// Set the content in the dialog pane
	dialog.getDialogPane().setContent(expContent);

	// Show the dialog till closed via OK or CANCEL button
	dialog.initOwner(parentWindow);
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	final Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK) {
		// OK returns the selected color or null if not selected
		final int idx = listView.getSelectionModel().getSelectedIndex();
		if (idx < 0) {
			return null;
		} else {
			return javafx.scene.paint.Color.valueOf(listView.getSelectionModel().getSelectedItem().toString());
		}
	} else {
		// Cancel returns a null value
		return null;
	}
}

/**
 * Create a rect and label showing the color value and name
 */
static class ColorRectCell extends ListCell<String> {
	@Override
	public void updateItem(final String item, final boolean empty) {
		super.updateItem(item, empty);
		if (item != null) {
			final Label lbl = new Label("              ");
			lbl.setStyle("-fx-background-color: " + item);
			final VBox vBox = new VBox(new Label(item));
			final HBox hBox = new HBox(lbl, vBox);
			hBox.setSpacing(10);
			setGraphic(hBox);
		}
	}
}
//COLORNAMEDIALOG END

//COLORPICKERDIALOG START
public static javafx.scene.paint.Color ColorPickerDialog(final String mtitle, final String mheader, final javafx.scene.paint.Color mdefault) {
	// Create the dialog
	final Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	// Add an OK and CANCEL button to select & close the dialog or cancel the dialog.
	dialog.getDialogPane().getButtonTypes().clear();
	final ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonData.OK_DONE);
	final ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	// Create the color picker with a split button
	final javafx.scene.control.ColorPicker colorPicker = new javafx.scene.control.ColorPicker(mdefault);
	if (mdefault == null) {
		colorPicker.setValue(javafx.scene.paint.Color.WHITE);
	}
	// colorPicker.getStyleClass().add("button");
	colorPicker.getStyleClass().add("split-button");

	Platform.runLater(new Runnable() {
		@Override
		public void run() {
			colorPicker.requestFocus();
		}
	});

	// Enable OK button
	final Node buttonOK = dialog.getDialogPane().lookupButton(buttonTypeOK);
	buttonOK.setDisable(false);

	// Create the labels and fields.
	final GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);
	grid.add(colorPicker, 0, 0);

	dialog.getDialogPane().setContent(grid);
	dialog.initOwner(parentWindow);

	// Set Button CSS Style
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}

	// Handle the dialog result based on the button clicked OK or Cancel
	dialog.initOwner(parentWindow);
	@SuppressWarnings("unchecked")
	final Optional<ButtonType> result = dialog.showAndWait();
	final javafx.scene.paint.Color c = colorPicker.getValue();
	if (result.get() == buttonTypeOK) {
		return c;
	} else {
		return null;
	}
}
//COLORPICKERDIALOG END

//SLIDERDIALOG
private static double mSliderBlockIncrement = 0.25f;
public static void SetSliderBlockIncrement(final double increment) {
	mSliderBlockIncrement = increment;
}
public static double GetSliderBlockIncrement() {
	return mSliderBlockIncrement;
}

private static double mSliderMajorTickUnit = 0.25f;
public static void SetSliderMajorTickUnit(final double units) {
	mSliderMajorTickUnit = units;
}
public static double GetSliderMajorTickUnit() {
	return mSliderMajorTickUnit;
}

private static int mSliderMinorTickCount = 5;
public static void SetSliderMinorTickCount(final int value) {
	mSliderMinorTickCount = value;
}
public static int GetSliderMinorTickCount() {
	return mSliderMinorTickCount;
}

private static boolean mSliderShowTickLabels = false;
public static void SetSliderShowTickLabels(final Boolean show) {
	mSliderShowTickLabels = show;
}
public static boolean GetSliderShowTickLabels() {
	return mSliderShowTickLabels;
}

private static boolean mSliderShowTickMarks = false;
public static void SetSliderShowTickMarks(final Boolean show) {
	mSliderShowTickMarks = show;
}
public static boolean GetSliderShowTickMarks() {
	return mSliderShowTickMarks;
}

private static boolean mSliderSetSnapToTicks = false;
public static void SetSliderSnapToTicks(final boolean snap) {
	mSliderSetSnapToTicks = snap;
}
public static boolean GetSliderSnapToTicks() {
	return mSliderSetSnapToTicks;
}

private static boolean mSliderShowValue = false;
public static void SetSliderShowValue(final boolean show) {
	mSliderShowValue = show;
}
public static boolean GetSliderShowValue() {
	return mSliderShowValue;
}

private static double mSliderPrefWidth = 400;
public static void SetSliderPrefWidth(final double width) {
	mSliderPrefWidth = width;
}
public static double GetSliderPrefWidth() {
	return mSliderPrefWidth;
}

private static String mSliderValueStyle = "";
public void SetSliderValueStyle(final String style) {
	this.mSliderValueStyle = style;
}
public static String GetSliderValueStyle() {
	return mSliderValueStyle;
}

// SliderDialog
// Parameter: Title, Header, Label, MinValue, MaxValue, Value
// Result: The slider value as double or if cancelled the default given
public static double SliderDialog(final String mtitle, final String mheader, final double mminvalue, final double mmaxvalue, final double mdefault)  throws Exception {
	// Create a new dialog and set title and header
	@SuppressWarnings("rawtypes")
	final Dialog dialog = new Dialog();
	dialog.setTitle(mtitle);
	dialog.setHeaderText(mheader);

	// Set the button types OK and Cancel
	dialog.getDialogPane().getButtonTypes().clear();
	final ButtonType buttonTypeOK = new ButtonType(mOKButtonText, ButtonData.OK_DONE);
	final ButtonType buttonTypeCancel = new ButtonType(mCancelButtonText, ButtonData.CANCEL_CLOSE);
	dialog.getDialogPane().getButtonTypes().addAll(buttonTypeOK, buttonTypeCancel);

	// Create the labels and fields.
	final GridPane grid = new GridPane();
	grid.setHgap(10);
	grid.setVgap(10);

	final Slider slider = new Slider(mminvalue, mmaxvalue, mdefault);
	slider.setBlockIncrement(GetSliderBlockIncrement());
	slider.setMajorTickUnit(GetSliderMajorTickUnit());
	slider.setMinorTickCount(GetSliderMinorTickCount());
	slider.setShowTickLabels(GetSliderShowTickLabels());
	slider.setShowTickMarks(GetSliderShowTickMarks());
	slider.setSnapToTicks(GetSliderSnapToTicks());
	slider.setPrefWidth(GetSliderPrefWidth());

	// Load the slider specific css file (if exists). The file must be located in the files folder (dirassets)
	try{
		final InputStream input = ClassLoader.getSystemResourceAsStream("Files/Slider.css");			
		if (input != null) {
			slider.getStylesheets().add("Files/Slider.css");
		}
	}
	catch(Exception e){
			// No action
	}

	final Label sliderValue = new Label(Double.toString(slider.getValue()));
	sliderValue.setStyle(GetSliderValueStyle());
	slider.valueProperty().addListener(new ChangeListener<Number>() {
		@Override
		public void changed(final ObservableValue<? extends Number> ov, final Number old_val, final Number new_val) {
			sliderValue.setText(String.format("%.0f", new_val));
		}
	});

	Platform.runLater(new Runnable() {
		@Override
		public void run() {
			slider.requestFocus();
		}
	});

	GridPane.setHalignment(sliderValue, HPos.CENTER);
	GridPane.setHgrow(slider, Priority.ALWAYS);
	grid.add(slider, 0, 0, 1, 1);
	if (GetSliderShowValue()) {
		grid.add(sliderValue, 0, 1);
		sliderValue.setText(String.format("%.0f", mdefault));
	}

	// Enable OK button
	final Node buttonOK = dialog.getDialogPane().lookupButton(buttonTypeOK);
	buttonOK.setDisable(false);

	// Set grid content and owner
	dialog.getDialogPane().setContent(grid);
	dialog.initOwner(parentWindow);

	// Set Button CSS Style
	if (mOKButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeOK).setStyle(mOKButtonStyle);
	}
	if (mCancelButtonStyle.isEmpty() == false) {
		dialog.getDialogPane().lookupButton(buttonTypeCancel).setStyle(mCancelButtonStyle);
	}
	// Handle the dialog result based on the button clicked OK or Cancel
	@SuppressWarnings("unchecked")
	final Optional<ButtonType> result = dialog.showAndWait();
	if (result.get() == buttonTypeOK) {
		try {
			final double value = slider.getValue();
			return value;
		} catch (final NumberFormatException e) {
			return mdefault;
		}
	} else {
		return mdefault;
	}
}
//SLIDERDIALOG END

//DONOTASKAGAINDIALOG
private static Boolean mDoNotAskAgainOption = false;
public static void SetDoNotAskAgainOption(final Boolean option) {
	mDoNotAskAgainOption = option;
}
public static Boolean GetDoNotAskAgainOption() {
	return mDoNotAskAgainOption;
}

// DoNotAskAgain
// Parameter: Title, Header, Label, DoNotAskAgainMessage,Default
// Result: The slider value as double or if cancelled the default given
public static Boolean DoNotAskAgainDialog(final String mtitle, final String mheader, final String mcontent, final String mdonotaskagainmsg, final boolean mdefaultoption) {
	// Dummy checkbox used as callback for the node createDetailsButton
	final CheckBox option = new CheckBox();
	// Result of this dialog 
	Boolean resultdialog = false;
	// Create a new dialog and set title and header
	final Alert alert = new Alert(AlertType.CONFIRMATION);
	// Apply the CSS style and get the dialog graphic
	alert.getDialogPane().applyCss();
	final Node graphic = alert.getDialogPane().getGraphic();
	// Create a new dialog pane which a checkbox instead of the hide/show details button
	alert.setDialogPane(new DialogPane() {
		@Override
		protected Node createDetailsButton() {
			final CheckBox checkBox = new CheckBox();
			checkBox.setSelected(mdefaultoption);
			option.setSelected(checkBox.isSelected());
			checkBox.setText(mdonotaskagainmsg);
			checkBox.setOnAction(new EventHandler<ActionEvent>() {
				@Override
				public void handle(final ActionEvent e) {
					option.setSelected(checkBox.isSelected());
				}
			});
			return checkBox;
		}
	});

	final ButtonType buttonTypeYes = new ButtonType(mYesButtonText, ButtonData.YES);
	final ButtonType buttonTypeNo = new ButtonType(mNoButtonText, ButtonData.NO);

	alert.getDialogPane().getButtonTypes().setAll(buttonTypeYes, buttonTypeNo);
	alert.getDialogPane().setContentText(mcontent);
	alert.getDialogPane().setExpandableContent(new Group());
	alert.getDialogPane().setExpanded(true);
	alert.getDialogPane().setGraphic(graphic);
	alert.setTitle(mtitle);
	alert.setHeaderText(mheader);
	alert.initStyle(StageStyle.UTILITY);
	alert.initOwner(parentWindow);

	if (mYesButtonStyle.isEmpty() == false) {
		alert.getDialogPane().lookupButton(buttonTypeYes).setStyle(mYesButtonStyle);
	}
	if (mNoButtonStyle.isEmpty() == false) {
		alert.getDialogPane().lookupButton(buttonTypeNo).setStyle(mNoButtonStyle);
	}
	final Optional<ButtonType> result = alert.showAndWait();
	if (result.get() == buttonTypeYes) {
		resultdialog = true;
	} else {
		resultdialog = false;
	}
	SetDoNotAskAgainOption(option.isSelected());
	return resultdialog;
}
//DONOTASKAGAINDIALOG END

#end if
