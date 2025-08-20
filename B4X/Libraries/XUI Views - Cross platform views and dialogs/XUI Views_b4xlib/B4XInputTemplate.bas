B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.98
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Public mBase As B4XView
	Public Text As String
	Private xDialog As B4XDialog
	Public RegexPattern As String
	Public TextField1 As B4XView
	Public lblTitle As B4XView
	#if B4A
	Private IME As IME
	#End If
	Private mAllowDecimals As Boolean
	Private BorderColor = xui.Color_White, BorderColorInvalid = xui.Color_Red As Int
End Sub

Public Sub Initialize
	mBase = xui.CreatePanel("mBase")
	mBase.SetLayoutAnimated(0, 0, 0, 300dip, 80dip)
	mBase.LoadLayout("B4XInputTemplate")
	TextField1.TextColor = xui.Color_White
	#if B4A
	IME.Initialize("")
	Dim jo As JavaObject = TextField1
	jo.RunMethod("setImeOptions", Array(Bit.Or(33554432, 6))) 'IME_FLAG_NO_FULLSCREEN | IME_ACTION_DONE
	#if DEBUG
	Dim jo As JavaObject = Me
	jo.RunMethod("RemoveWarning", Null)
	#End If
	#End If
	SetBorder(BorderColor)
End Sub

'Sets the border color for the valid and invalid states.
Public Sub SetBorderColor(Valid As Int, Invalid As Int)
	BorderColor = Valid
	BorderColorInvalid = Invalid
	SetBorder(BorderColor)
End Sub

Public Sub ConfigureForNumbers (AllowDecimals As Boolean, AllowNegative As Boolean)
	#if B4A
	Dim et As EditText = TextField1
	If AllowDecimals Or AllowNegative Then 
		et.InputType = et.INPUT_TYPE_DECIMAL_NUMBERS 
	Else 
		et.InputType = et.INPUT_TYPE_NUMBERS
	End If
	#else if B4I
	Dim tf As TextField = TextField1
	If AllowNegative Then
		tf.KeyboardType = tf.TYPE_NUMBERS_AND_PUNCTUATIONS
	Else If AllowDecimals  Then
		tf.KeyboardType = tf.TYPE_DECIMAL_PAD
	Else
		tf.KeyboardType = tf.TYPE_NUMBER_PAD
	End If
	#end if
	'https://stackoverflow.com/a/39399503/971547
	If AllowDecimals And AllowNegative Then
		RegexPattern = "^-?(0|[1-9]\d*)?(\.\d+)?(?<=\d)$"
	Else If AllowDecimals And AllowNegative = False Then
		RegexPattern = "^(0|[1-9]\d*)?(\.\d+)?(?<=\d)$"
	Else If AllowDecimals = False And AllowNegative = True Then
		RegexPattern = "^-?(0|[1-9]\d*)$"
	Else If AllowDecimals = False And AllowNegative = False Then
		RegexPattern = "^(0|[1-9]\d*)$"
	End If
	mAllowDecimals = AllowDecimals
End Sub

Private Sub TextField1_TextChanged (Old As String, New As String)
	#if B4i
	If mAllowDecimals Then
		If New.Contains(",") Then
			New = New.Replace(",", ".")
			Dim tf As TextField = TextField1
			Dim i As Int = tf.SelectionStart
			TextField1.Text = New
			tf.SetSelection(i + 1, 0)
		End If
	End If
	#end if
	Validate (New)
End Sub

Private Sub Validate (New As String)
	Dim bc As Int = BorderColor
	Dim enabled As Boolean = True
	If IsValid(New) = False Then
		If New.Length > 0 Then
			bc = BorderColorInvalid
		End If
		enabled = False
	End If
	xDialog.SetButtonState(xui.DialogResponse_Positive, enabled)
	SetBorder(bc)
End Sub

Private Sub SetBorder(bc As Int)
	TextField1.SetColorAndBorder(xui.Color_Transparent, 1dip, bc, 2dip)
End Sub

Private Sub IsValid(New As String) As Boolean
	Return RegexPattern = "" Or Regex.IsMatch(RegexPattern, New)
End Sub

Private Sub TextField1_Action
	TextField1_EnterPressed
End Sub

Private Sub TextField1_EnterPressed
	If IsValid(TextField1.Text) Then xDialog.Close(xui.DialogResponse_Positive)
End Sub


Public Sub GetPanel (Dialog As B4XDialog) As B4XView
	Return mBase
End Sub

Private Sub Show (Dialog As B4XDialog)
	xDialog = Dialog
	xDialog.PutAtTop = xui.IsB4A Or xui.IsB4i
	Sleep(20)
	TextField1.Text = Text
	Validate(Text)
	TextField1.RequestFocus
	#if B4A
	Dim tf As EditText = TextField1
	tf.SelectAll
	IME.ShowKeyboard(TextField1)
	#Else If B4i
	Dim tf As TextField = TextField1
	tf.SelectAll
	#End If
End Sub

Private Sub DialogClosed(Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Text = TextField1.Text
	End If
End Sub

#if DEBUG
#if JAVA
public void RemoveWarning() throws Exception{
	anywheresoftware.b4a.shell.Shell s = anywheresoftware.b4a.shell.Shell.INSTANCE;
	java.lang.reflect.Field f = s.getClass().getDeclaredField("errorMessagesForSyncEvents");
	f.setAccessible(true);
	java.util.HashSet<String> h = (java.util.HashSet<String>)f.get(s);
	if (h == null) {
		h = new java.util.HashSet<String>();
		f.set(s, h);
	}
	h.add("textfield1_textchanged");
}
#End If
#End If

