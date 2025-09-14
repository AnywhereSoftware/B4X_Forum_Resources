B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
#DesignerProperty: Key: NumberFormat, DisplayName: NumberFormat, FieldType: String, DefaultValue: 0;0;0;True, Description: NumberFormat in the form: Min Integers;Max Fractions;Min Fractions;Group
#Event: TextChanged(Old As String, New as string)
#Event: Action
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private TextField1 As TextField
	Private Label1 As B4XView
	Private TextString As String
	Private TFHasFocus As Boolean
	
	Private DecimalSeparator As String = "."
	
	Private MinInts,MaxFracs,MinFracs As Int
	Private bGroup As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	mBase.LoadLayout("nfinput")
	
	Dim tf As TextFormatter
	tf.Initialize(Me,"Numeric",TextField1)
	
	Dim OptArr() As String = Regex.Split(";",Props.GetDefault("NumberFormat","0;0;0;True"))
	
	If OptArr.Length <> 4 Then
		LogError("NFInput " & mEventName & " Not enough parameters")
		Return
	End If
	
	If Lbl.As(B4XView).Color = xui.Color_Transparent Then
		Label1.SetColorAndBorder(xui.Color_White,1,xui.Color_DarkGray,5)
	Else
		Label1.SetColorAndBorder(Lbl.As(B4XView).Color,1,xui.Color_DarkGray,5)
	End If
	
	Try
		MinInts = OptArr(0)
		MaxFracs = OptArr(1)
		MinFracs = OptArr(2)
		bGroup = OptArr(3).ToLowerCase = "true"
	Catch
		LogError("NFInput " & mEventName & "Invalid parameters for Numberformat2")
		Return
	End Try
	
	'  	Dim clr As Int = xui.PaintOrColorToColor(Props.Get("TextColor")) 'Example of getting a color value from Props
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Private Sub TextField1_FocusChanged (HasFocus As Boolean)
	If HasFocus Then
		TFHasFocus = True
		Label1.Text = ""
		Label1.Visible = False
		TextField1.Text = TextString
		Sleep(0)
		TextField1.SetSelection(TextString.Length,TextString.Length)
	Else
		TFHasFocus = False
		TextField1.Text = ""
		Label1.Visible = True
		If IsNumber(TextString) Then Label1.Text = NumberFormat2(TextString,MinInts,MaxFracs,MinFracs,bGroup)
	End If
End Sub

Private Sub Label1_MouseClicked (EventData As MouseEvent)
	TextField1.RequestFocus
End Sub


Sub Numeric_TextValidator(Change As TFChange) As TFChange

	'Get the character that has been changed
	Dim ThisChar As String = Change.Text
	
	'Get the full text as it would be applied to the field
	Dim Text As String = Change.ControlNewText
	
	'Duplicate the full text so we can manipulate it
	Dim FullText As String = Text
	
	'Check we are using the correct decimal separator
	If DecimalSeparator <> "." And ThisChar = "." Then Return Null
	
	'Test there is only one decimal Separator
	If FullText.Replace(DecimalSeparator,"").Length < FullText.Length - 1 Then Return Null
	
	'Allow '-' and '.' at the beginning
	If FullText.StartsWith("-") Or FullText.StartsWith(DecimalSeparator) Then FullText = FullText.SubString(1)
	
	'Allow '.' at the end
	If FullText.EndsWith(DecimalSeparator) Then FullText = FullText.SubString2(0,FullText.Length-1)
	
	'IsNumber allows f and d at the end so override this
	If Regex.IsMatch("[df]",ThisChar) Then Return Null
	
	'Isnumber requires decimal separator to be ".", so change it for the next test.
	FullText = FullText.Replace(DecimalSeparator,".")

	'What is left should be an empty string(we have removed other characters we want to allow) or a valid number
	If FullText = "" Or IsNumber(FullText) Then Return Change
	
	'Invalidates this change, it will not be applied to the input field.
	Return Null
End Sub
Private Sub TextField1_TextChanged (Old As String, New As String)
	If TFHasFocus Then TextString = New
	If SubExists(mCallBack,mEventName & "_TextChanged") Then CallSubDelayed3(mCallBack,mEventName & "_TextChanged",Old,New)
End Sub

Private Sub Textfield1_Action
	Log("TF Action")
	If SubExists(mCallBack,mEventName & "_Action") Then CallSubDelayed(mCallBack,mEventName & "_Action")
End Sub

Public Sub setText(Text As String)
	If IsNumber(Text) = False Then Return
	TextString = Text
	If Label1.Visible Then
		Label1.Text = NumberFormat2(TextString,MinInts,MaxFracs,MinFracs,bGroup)
	Else
		TextField1.Text = Text
	End If
End Sub
Public Sub getText As String
	Return TextString
End Sub

