B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
'Author: Alexander Stolte
'Version: 1.2

'Updates
'V1.1
'-Add Custom Key Click (Fingerprint Key)
'-Add Clear Input to reset the user input
'-Add Explanations on the Subs

'V1.2
'-Removes unused variable
'-Fix Bug the setDescription property was not showing
'-Add CodeColor Property
'-Add KeyboardBackgroundColor Porperty
'-Add KeyboardTextColor Poperty
'-Add KeyboardExtraButtonBackgroundColor
'-Remove Seperator Bug with the new seperators
'-Add New Designer-Property ShowKeyboardSeperator set to true to show seperators on the numberfields
'-Add New Designer-Property KeyboardSeperatorColor set the seperator color for the numberfields
'-Add EncryptMethods as return values

#DesignerProperty: Key: HeaderColor, DisplayName: Header Background Color, FieldType: Color, DefaultValue: 0xFF2E4057, Description: The Background Color of the Header
#DesignerProperty: Key: CodeColor, DisplayName: Code Background Color, FieldType: Color, DefaultValue: 0x9B2E4057, Description: Background Color of the Code Area (Description etc.)
#DesignerProperty: Key: KeyboardNumberColor, DisplayName: Keyboard Numberfield Color, FieldType: Color, DefaultValue: 0xFF2E4057, Description: Background Color of the Numbers

#DesignerProperty: Key: KeyboardExtraColor, DisplayName: Keyboard Numberfield Extra Color, FieldType: Color, DefaultValue: 0x9B2E4057, Description: Background Color for the Fingerprint and Back Button
#DesignerProperty: Key: KeyboardTextColor, DisplayName: Keyboard Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text Color of the Numbers
#DesignerProperty: Key: ShowKeyboardSeperator, DisplayName: Show Keyboard Seperator, FieldType: Boolean, DefaultValue: True, Description: Shows Button Seperators
#DesignerProperty: Key: KeyboardSeperatorColor, DisplayName: Keyboard Seperator Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Color of the Seperators

#DesignerProperty: Key: EncryptMethod, DisplayName: Encrypt Method, FieldType: String, DefaultValue: SHA-256, List: MD5|SHA-1|SHA-224|SHA-256|SHA-384|SHA-512|NONE
#DesignerProperty: Key: Salt, DisplayName: Salt Value, FieldType: String, DefaultValue:
#DesignerProperty: Key: CodeLength, DisplayName: Code Length, FieldType: String, DefaultValue: 4, List: 4|8

#DesignerProperty: Key: KeyboardClickColor, DisplayName: Keyboard Click Color, FieldType: Color, DefaultValue: 0x9BFFFFFF, Description: Click Color if you click a button
#DesignerProperty: Key: description2, DisplayName: Description Text, FieldType: String, DefaultValue: Enter access code

#DesignerProperty: Key: SuccessColor, DisplayName: SuccessColor, FieldType: Color, DefaultValue: 0xFF2D8879, Description: The Color of the Code Area if the Input was correct
#DesignerProperty: Key: DenyColor, DisplayName: Deny Color, FieldType: Color, DefaultValue: 0xFFC0392B, Description: The Color of the Code Area if the Input was not correct
#DesignerProperty: Key: CodeTextColor, DisplayName: Code Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: The Color of the Code Area in the Normal Mode

#Event: BaseResize
#Event: PinReady (Value As String)
#Event: CustomKeyClick

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private xlbl_description As B4XView
	Private xpnl_code As B4XView
	Private xpnl_keyboard As B4XView
	
	'Pins
	Private xlbl_pin_1 As B4XView
	Private xlbl_pin_2 As B4XView
	Private xlbl_pin_3 As B4XView
	Private xlbl_pin_4 As B4XView
	Private xlbl_pin_5 As B4XView
	Private xlbl_pin_6 As B4XView
	Private xlbl_pin_7 As B4XView
	Private xlbl_pin_8 As B4XView
	
	'Properties
	Private header_color As Int
	Private code_color As Int
	Private keyboard_number_color As Int
	Private keyboard_extra_color As Int
	Private keyboard_text_color As Int
	Private keyboard_click_color As Int
	Private success_color As Int
	Private deny_color As Int
	Private code_text_color As Int
	
	Private keyboard_seperator_color As Int
	Private show_keyboard_seperator As Boolean
	
	Private encrypt_method As String
	Private salt_value As String
	Private code_length As Int
	Private str_description As String
	
	Private xpnl_header As B4XView
	
	
	Private hashed_value_1 As String = ""
	Private hashed_value_2 As String = ""
	Private hashed_value_3 As String = ""
	Private hashed_value_4 As String = ""
	Private hashed_value_5 As String = ""
	Private hashed_value_6 As String = ""
	Private hashed_value_7 As String = ""
	Private hashed_value_8 As String = ""
	
	Private current_pos As Int = 0
	
	'Keys
	Public xpnl_key_1 As B4XView
	Public xpnl_key_2 As B4XView
	Public xpnl_key_3 As B4XView
	Public xpnl_key_4 As B4XView
	Public xpnl_key_5 As B4XView
	Public xpnl_key_6 As B4XView
	Public xpnl_key_7 As B4XView
	Public xpnl_key_8 As B4XView
	Public xpnl_key_9 As B4XView
	Public xpnl_key_0 As B4XView
	Public xpnl_key_delete As B4XView
	Public xpnl_key_fingerprint As B4XView
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
 
	fill_properties(Props)

  xpnl_header  = xui.CreatePanel("")
  xpnl_code = xui.CreatePanel("")
  xpnl_keyboard = xui.CreatePanel("")
 
	mBase.AddView(xpnl_header,0,0,mBase.Width,(45 * mBase.Height)/100) '45%y
	mBase.AddView(xpnl_code,0,(45 * mBase.Height)/100,mBase.Width,(15 * mBase.Height)/100)'15%y
	mBase.AddView(xpnl_keyboard,0,(60 * mBase.Height)/100,mBase.Width,(40 * mBase.Height)/100) '40%y
 
	xpnl_header.Color = header_color
	xpnl_code.Color = code_color
	
	build_code(xpnl_code)
	build_keyboard(xpnl_keyboard)
	
	#If B4a
	
	Base_Resize(mBase.Width,mBase.Height)
	
	#End If
	
End Sub

Private Sub fill_properties(Props As Map)
	
	header_color = xui.PaintOrColorToColor(Props.Get("HeaderColor"))
	code_color = xui.PaintOrColorToColor(Props.Get("CodeColor"))
	keyboard_number_color = xui.PaintOrColorToColor(Props.Get("KeyboardNumberColor"))
	keyboard_extra_color = xui.PaintOrColorToColor(Props.Get("KeyboardExtraColor"))
	keyboard_text_color = xui.PaintOrColorToColor(Props.Get("KeyboardTextColor"))
	keyboard_click_color = xui.PaintOrColorToColor(Props.Get("KeyboardClickColor"))
	success_color = xui.PaintOrColorToColor(Props.Get("SuccessColor"))
	deny_color = xui.PaintOrColorToColor(Props.Get("DenyColor"))
	code_text_color = xui.PaintOrColorToColor(Props.Get("CodeTextColor"))
	encrypt_method = Props.Get("EncryptMethod")
	salt_value = Props.Get("Salt")
	code_length = Props.Get("CodeLength")
	str_description = Props.Get("description2")
	keyboard_seperator_color = xui.PaintOrColorToColor(Props.Get("KeyboardSeperatorColor"))
	show_keyboard_seperator = Props.Get("ShowKeyboardSeperator")
	
End Sub

#Region Properties

'Get the Header Panel, to load your own Layout
Public Sub getHeaderPanel As B4XView
	
	Return xpnl_header
	
End Sub

'Set the Color of Labels in the Code Area to the Success Color, to show the user that the input was right
Public Sub Success
	
	xlbl_description.TextColor = success_color
	xlbl_pin_1.TextColor = success_color
	xlbl_pin_2.TextColor = success_color
	xlbl_pin_3.TextColor = success_color
	xlbl_pin_4.TextColor = success_color
	
	xlbl_pin_5.TextColor = success_color
	xlbl_pin_6.TextColor = success_color
	xlbl_pin_7.TextColor = success_color
	xlbl_pin_8.TextColor = success_color
	
End Sub

'Set the Color of Labels in the Code Area to the Deny Color, to show the user that the input was wrong
Public Sub Deny
	
	xlbl_description.TextColor = deny_color
	xlbl_pin_1.TextColor = deny_color
	xlbl_pin_2.TextColor = deny_color
	xlbl_pin_3.TextColor = deny_color
	xlbl_pin_4.TextColor = deny_color
	
	xlbl_pin_5.TextColor = deny_color
	xlbl_pin_6.TextColor = deny_color
	xlbl_pin_7.TextColor = deny_color
	xlbl_pin_8.TextColor = deny_color
	
End Sub

'Reset the input
Public Sub ClearInput
	
	current_pos = 0
	
	For Each v As B4XView In xpnl_code.GetAllViewsRecursive
		
		v.TextColor = code_text_color
		
		
	Next
	
	xlbl_pin_1.Text = Chr(0xF10C)
	xlbl_pin_2.Text = Chr(0xF10C)
	xlbl_pin_3.Text = Chr(0xF10C)
	xlbl_pin_4.Text = Chr(0xF10C)
	xlbl_pin_5.Text = Chr(0xF10C)
	xlbl_pin_6.Text = Chr(0xF10C)
	xlbl_pin_7.Text = Chr(0xF10C)
	xlbl_pin_8.Text = Chr(0xF10C)
	
End Sub

Public Sub setShowKeyboardSeperator(show As Boolean)
	
	show_keyboard_seperator = show
	
	Dim seperator As Int = 0
	
	If show = True Then
		
		seperator = 1dip
		
	End If
	
	xpnl_key_1.GetView(0).SetColorAndBorder(keyboard_number_color,seperator,keyboard_seperator_color,0)
	xpnl_key_2.GetView(0).SetColorAndBorder(keyboard_number_color,seperator,keyboard_seperator_color,0)
	xpnl_key_3.GetView(0).SetColorAndBorder(keyboard_number_color,seperator,keyboard_seperator_color,0)
	xpnl_key_4.GetView(0).SetColorAndBorder(keyboard_number_color,seperator,keyboard_seperator_color,0)
	xpnl_key_5.GetView(0).SetColorAndBorder(keyboard_number_color,seperator,keyboard_seperator_color,0)
	xpnl_key_6.GetView(0).SetColorAndBorder(keyboard_number_color,seperator,keyboard_seperator_color,0)
	xpnl_key_7.GetView(0).SetColorAndBorder(keyboard_number_color,seperator,keyboard_seperator_color,0)
	xpnl_key_8.GetView(0).SetColorAndBorder(keyboard_number_color,seperator,keyboard_seperator_color,0)
	xpnl_key_9.GetView(0).SetColorAndBorder(keyboard_number_color,seperator,keyboard_seperator_color,0)
	xpnl_key_0.GetView(0).SetColorAndBorder(keyboard_number_color,seperator,keyboard_seperator_color,0)
	
	xpnl_key_fingerprint.GetView(0).SetColorAndBorder(keyboard_number_color,seperator,keyboard_seperator_color,0)
	xpnl_key_delete.GetView(0).SetColorAndBorder(keyboard_number_color,seperator,keyboard_seperator_color,0)
	
End Sub

Public Sub getShowKeyboardSeperator As Boolean
	
	Return show_keyboard_seperator
	
End Sub

Public Sub setKeyboardTextColor(color As Int)
	
	keyboard_text_color = color
	
	xpnl_key_1.GetView(0).TextColor = color
	xpnl_key_2.GetView(0).TextColor = color
	xpnl_key_3.GetView(0).TextColor = color
	xpnl_key_4.GetView(0).TextColor = color
	xpnl_key_5.GetView(0).TextColor = color
	xpnl_key_6.GetView(0).TextColor = color
	xpnl_key_7.GetView(0).TextColor = color
	xpnl_key_8.GetView(0).TextColor = color
	xpnl_key_9.GetView(0).TextColor = color
	xpnl_key_0.GetView(0).TextColor = color
	
	xpnl_key_fingerprint.GetView(0).TextColor = color
	xpnl_key_delete.GetView(0).TextColor = color
	
End Sub

Public Sub getKeyboardSeperatorColor As Int
	
	Return keyboard_seperator_color
	
End Sub

Public Sub setKeyboardSeperatorColor(color As Int)
	
	 keyboard_seperator_color = color
	 
	xpnl_key_1.GetView(0).SetColorAndBorder(keyboard_number_color,1dip,color,0)
	xpnl_key_2.GetView(0).SetColorAndBorder(keyboard_number_color,1dip,color,0)
	xpnl_key_3.GetView(0).SetColorAndBorder(keyboard_number_color,1dip,color,0)
	xpnl_key_4.GetView(0).SetColorAndBorder(keyboard_number_color,1dip,color,0)
	xpnl_key_5.GetView(0).SetColorAndBorder(keyboard_number_color,1dip,color,0)
	xpnl_key_6.GetView(0).SetColorAndBorder(keyboard_number_color,1dip,color,0)
	xpnl_key_7.GetView(0).SetColorAndBorder(keyboard_number_color,1dip,color,0)
	xpnl_key_8.GetView(0).SetColorAndBorder(keyboard_number_color,1dip,color,0)
	xpnl_key_9.GetView(0).SetColorAndBorder(keyboard_number_color,1dip,color,0)
	xpnl_key_0.GetView(0).SetColorAndBorder(keyboard_number_color,1dip,color,0)
	
	xpnl_key_fingerprint.GetView(0).SetColorAndBorder(keyboard_number_color,1dip,color,0)
	xpnl_key_delete.GetView(0).SetColorAndBorder(keyboard_number_color,1dip,color,0)
	
	mBase.Color = keyboard_number_color
	
End Sub

Public Sub getKeyboardTextColor As Int
	
	Return keyboard_text_color
	
End Sub

Public Sub setKeyboardExtraButtonBackgroundColor(color As Int)
	
	keyboard_extra_color = color
	
	xpnl_key_fingerprint.GetView(0).Color = color
	xpnl_key_delete.GetView(0).Color = color
	
End Sub

Public Sub getKeyboardExtraButtonBackgroundColor As Int
	
	Return keyboard_extra_color 
	
End Sub

Public Sub setKeyboardBackgroundColor(color As Int)
	
	keyboard_number_color = color
	
	xpnl_key_1.GetView(0).Color = color
	xpnl_key_2.GetView(0).Color = color
	xpnl_key_3.GetView(0).Color = color
	xpnl_key_4.GetView(0).Color = color
	xpnl_key_5.GetView(0).Color = color
	xpnl_key_6.GetView(0).Color = color
	xpnl_key_7.GetView(0).Color = color
	xpnl_key_8.GetView(0).Color = color
	xpnl_key_9.GetView(0).Color = color
	xpnl_key_0.GetView(0).Color = color
	
End Sub

Public Sub getKeyboardBackgroundColor As Int
	
	Return keyboard_number_color 
	
End Sub

Public Sub setCodeBackgroundColor(color As Int)
	
	code_color = color
	xpnl_code.Color = color
	
End Sub

Public Sub getCodeBackgroundColor As Int
	
	Return code_color
	
End Sub

'Get or Sets the Description Text (Enter access code)
Public Sub getDescription As String
		
	Return str_description
		
End Sub

'Get or Sets the Description Text (Enter access code)
Public Sub setDescription(text As String)
		
	str_description = text
	xlbl_description.Text = str_description
		
End Sub

'Get or Sets the Description Color (Enter access code)
Public Sub getDescriptionColor As Int
		
	Return code_text_color
		
End Sub

'Get or Sets the Description Color (Enter access code)
Public Sub setDescriptionColor(Color As Int)
		
	code_text_color = Color
	xlbl_description.TextColor = code_text_color
		
End Sub

'Get or Set the Code Length (4 or 8)
Public Sub getCodeLength As Int
	
	Return code_length
	
End Sub

'Get or Set the Code Length (4 or 8)
Public Sub setCodeLength(Length As Int)
	
	If Length = 4 Or Length = 8 Then
	
	code_length = Length
	Base_Resize(mBase.Width,mBase.Height)
	
	End If
	
End Sub

'Get or Sets the Header Background Color
Public Sub getHeaderColor As Int
	
	Return header_color
	
End Sub

'Get or Sets the Header Background Color
Public Sub setHeaderColor(Color As Int)
	
	header_color = Color
	xpnl_header.Color = header_color
	
End Sub

'Get or Set the Encryption Method Valid: MD5 SHA-1 SHA-224 SHA-256 SHA-384 SHA-512 NONE
Public Sub getEncryptMethod As String
	
	Return encrypt_method
	
End Sub

'Get or Set the Encryption Method Valid: MD5 SHA-1 SHA-224 SHA-256 SHA-384 SHA-512 NONE
Public Sub setEncryptMethod(Method As String)
	
If Method = "MD5" Or Method = "SHA-1"  Or Method = "SHA-224"  Or Method = "SHA-256"  Or Method = "SHA-384"  Or Method = "SHA-512"  Or Method = "NONE" Then
	
		encrypt_method = Method
	
	Else
		
		Log("wrong encryption method")
	
	End If
	
	
End Sub

'Get or Set the Salt Value to Secure your User Input more
Public Sub getSalt As String
	
	Return salt_value
	
End Sub

'Get or Set the Salt Value to Secure your User Input more
Public Sub setSalt(Salt As String)
	
	salt_value = Salt
	
End Sub

'Get or Set the Keyboard Click Color
Public Sub getKeyboardClickColor As Int
	
	Return keyboard_click_color
	
End Sub

'Get or Set the Keyboard Click Color
Public Sub setKeyboardClickColor(Color As Int)
	
	keyboard_click_color = Color
	
End Sub

'Get or Set the Success Color (Description Text Color and Code Circels Color)
Public Sub getSuccessColor As Int
	
	Return success_color
	
End Sub

'Get or Set the Success Color (Description Text Color and Code Circels Color)
Public Sub setSuccessColor(Color As Int)
	
	success_color = Color
	
End Sub

'Get or Set the Deny Color (Description Text Color and Code Circels Color)
Public Sub getDenyColor As Int
	
	Return deny_color
	
End Sub

'Get or Set the Deny Color (Description Text Color and Code Circels Color)
Public Sub setDenyColor(Color As Int)
	
	deny_color = Color
	
End Sub

'Get or Set the Code Color (Description Text Color and Code Circels Color)
Public Sub getCodeTextColor As Int
	
	Return code_text_color
	
End Sub

'Get or Set the Code Color (Description Text Color and Code Circels Color)
Public Sub setCodeTextColor(Color As Int)
	
	code_text_color = Color
	
	For Each v As B4XView In xpnl_code.GetAllViewsRecursive
		
		v.TextColor = code_text_color
		
	Next
	
End Sub

Public Sub getemMD5 As String
	
	Return "MD5"
	
End Sub

Public Sub getemSHA1 As String
	
	Return "SHA-1"
	
End Sub

Public Sub getemSHA224 As String
	
	Return "SHA-224"
	
End Sub

Public Sub getemSHA256 As String
	
	Return "SHA-256"
	
End Sub

Public Sub getemSHA384 As String
	
	Return "SHA-384"
	
End Sub

Public Sub getemSHA512 As String
	
	Return "SHA-512"
	
End Sub

Public Sub getemNONE As String
	
	Return "NONE"
	
End Sub

#End Region

Private Sub resizes_keys
	
	xpnl_key_1.SetLayoutAnimated(0,0,0,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4)
	xpnl_key_1.GetView(0).SetLayoutAnimated(0,0,0,xpnl_key_1.Width,xpnl_key_1.Height)
	
	xpnl_key_2.SetLayoutAnimated(0,xpnl_keyboard.Width/3,0,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4)
	xpnl_key_2.GetView(0).SetLayoutAnimated(0,0,0,xpnl_key_2.Width,xpnl_key_2.Height)
	
	xpnl_key_3.SetLayoutAnimated(0,xpnl_keyboard.Width/3 * 2,0,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4)
	xpnl_key_3.GetView(0).SetLayoutAnimated(0,0,0,xpnl_key_3.Width,xpnl_key_3.Height)
	
	xpnl_key_4.SetLayoutAnimated(0,0,xpnl_keyboard.Height/4,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4)
	xpnl_key_4.GetView(0).SetLayoutAnimated(0,0,0,xpnl_key_4.Width,xpnl_key_4.Height)
	
	xpnl_key_5.SetLayoutAnimated(0,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4)
	xpnl_key_5.GetView(0).SetLayoutAnimated(0,0,0,xpnl_key_5.Width,xpnl_key_5.Height)
	
	xpnl_key_6.SetLayoutAnimated(0,xpnl_keyboard.Width/3 * 2,xpnl_keyboard.Height/4,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4)
	xpnl_key_6.GetView(0).SetLayoutAnimated(0,0,0,xpnl_key_6.Width,xpnl_key_6.Height)
	
	xpnl_key_7.SetLayoutAnimated(0,0,xpnl_keyboard.Height/4 * 2,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4)
	xpnl_key_7.GetView(0).SetLayoutAnimated(0,0,0,xpnl_key_7.Width,xpnl_key_7.Height)
	
	xpnl_key_8.SetLayoutAnimated(0,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4 * 2,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4)
	xpnl_key_8.GetView(0).SetLayoutAnimated(0,0,0,xpnl_key_8.Width,xpnl_key_8.Height)
	
	xpnl_key_9.SetLayoutAnimated(0,xpnl_keyboard.Width/3 * 2,xpnl_keyboard.Height/4 * 2,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4)
	xpnl_key_9.GetView(0).SetLayoutAnimated(0,0,0,xpnl_key_9.Width,xpnl_key_9.Height)
	
	xpnl_key_0.SetLayoutAnimated(0,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4 * 3,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4)
	xpnl_key_0.GetView(0).SetLayoutAnimated(0,0,0,xpnl_key_0.Width,xpnl_key_0.Height)
	
	xpnl_key_delete.SetLayoutAnimated(0,xpnl_keyboard.Width/3 * 2,xpnl_keyboard.Height/4 * 3,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4)
	xpnl_key_delete.GetView(0).SetLayoutAnimated(0,0,0,xpnl_key_delete.Width,xpnl_key_delete.Height)
	
	xpnl_key_fingerprint.SetLayoutAnimated(0,0,xpnl_keyboard.Height/4 * 3,xpnl_keyboard.Width/3,xpnl_keyboard.Height/4)
	xpnl_key_fingerprint.GetView(0).SetLayoutAnimated(0,0,0,xpnl_key_fingerprint.Width,xpnl_key_fingerprint.Height)

End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
	mBase.Height = Height +1dip
  
	xpnl_header.SetLayoutAnimated(0,0,0,mBase.Width,(45 * mBase.Height)/100) '45%y
	xpnl_code.SetLayoutAnimated(0,0,(45 * mBase.Height)/100,mBase.Width,(15 * mBase.Height)/100)'15%y
	xpnl_keyboard.SetLayoutAnimated(0,0,(60 * mBase.Height)/100,mBase.Width,(40 * mBase.Height)/100 +0dip) '40%y
  
	resizes_keys
  
	xlbl_description.SetLayoutAnimated(0,0,0,xpnl_code.Width,xpnl_code.Height/2)
  
    Dim tmp_pin_parent As B4XView = xlbl_pin_1.Parent
  
	If code_length = 4 Then
  
		xlbl_pin_1.SetLayoutAnimated(0,tmp_pin_parent.Width/2 - 50dip ,tmp_pin_parent.Height/2 + 5dip,20dip,20dip)
		
		xlbl_pin_2.SetLayoutAnimated(0,tmp_pin_parent.Width/2 - 25dip  ,tmp_pin_parent.Height/2 + 5dip,20dip,20dip)
		
		xlbl_pin_3.SetLayoutAnimated(0,tmp_pin_parent.Width/2 + 5dip ,tmp_pin_parent.Height/2 + 5dip,20dip,20dip)
		
		xlbl_pin_4.SetLayoutAnimated(0,tmp_pin_parent.Width/2 + 30dip,tmp_pin_parent.Height/2 + 5dip,20dip,20dip)
  
	Else If code_length = 8 Then
  
		xlbl_pin_1.SetLayoutAnimated(0,tmp_pin_parent.Width/2 - 100dip ,tmp_pin_parent.Height/2 + 5dip,20dip,20dip)
	
		xlbl_pin_2.SetLayoutAnimated(0,tmp_pin_parent.Width/2 - 75dip  ,tmp_pin_parent.Height/2 + 5dip,20dip,20dip)
	
		xlbl_pin_3.SetLayoutAnimated(0,tmp_pin_parent.Width/2 - 50dip ,tmp_pin_parent.Height/2 + 5dip,20dip,20dip)
	
		xlbl_pin_4.SetLayoutAnimated(0,tmp_pin_parent.Width/2 - 25dip,tmp_pin_parent.Height/2 + 5dip,20dip,20dip)
		
		xlbl_pin_5.SetLayoutAnimated(0,tmp_pin_parent.Width/2 + 5dip ,tmp_pin_parent.Height/2 + 5dip,20dip,20dip)
	
		xlbl_pin_6.SetLayoutAnimated(0,tmp_pin_parent.Width/2 + 30dip  ,tmp_pin_parent.Height/2 + 5dip,20dip,20dip)
	
		xlbl_pin_7.SetLayoutAnimated(0,tmp_pin_parent.Width/2 + 55dip ,tmp_pin_parent.Height/2 + 5dip,20dip,20dip)
	
		xlbl_pin_8.SetLayoutAnimated(0,tmp_pin_parent.Width/2 + 80dip,tmp_pin_parent.Height/2 + 5dip,20dip,20dip)
  
  End If
  
		BaseResize_handler
  
End Sub

#Region Events

Private Sub BaseResize_handler
	
	If xui.SubExists(mCallBack, mEventName & "_BaseResize",0) Then
		Sleep(0)
		CallSub(mCallBack, mEventName & "_BaseResize")
	End If
	
End Sub

Private Sub PinnReady_handler(input As String)
	
	If xui.SubExists(mCallBack, mEventName & "_PinReady",0) Then
		Sleep(0)
		CallSub2(mCallBack, mEventName & "_PinReady",input)
	End If
	
End Sub

#End Region

#Region Build Code

Private Sub build_code(LayoutPanel As B4XView)
	
	Dim lbl_description As Label 
	lbl_description.Initialize("")
	xlbl_description = lbl_description
	
	xlbl_description.TextColor = code_text_color
	xlbl_description.Text = str_description
	xlbl_description.Font = xui.CreateDefaultFont(17)
	xlbl_description.SetTextAlignment("CENTER","CENTER")
	
	LayoutPanel.AddView(xlbl_description,0,0,LayoutPanel.Width,LayoutPanel.Height/2)
	
	xlbl_pin_1 = build_code_pin(xlbl_pin_1)
	xlbl_pin_2 = build_code_pin(xlbl_pin_2)
	xlbl_pin_3 = build_code_pin(xlbl_pin_3)
	xlbl_pin_4 = build_code_pin(xlbl_pin_4)
	
	xlbl_pin_5 = build_code_pin(xlbl_pin_5)
	xlbl_pin_6 = build_code_pin(xlbl_pin_6)
	xlbl_pin_7 = build_code_pin(xlbl_pin_7)
	xlbl_pin_8 = build_code_pin(xlbl_pin_8)
	
	LayoutPanel.AddView(xlbl_pin_1,0,0,0,0)
	LayoutPanel.AddView(xlbl_pin_2,0,0,0,0)
	LayoutPanel.AddView(xlbl_pin_3,0,0,0,0)
	LayoutPanel.AddView(xlbl_pin_4,0,0,0,0)
	
	LayoutPanel.AddView(xlbl_pin_5,0,0,0,0)
	LayoutPanel.AddView(xlbl_pin_6,0,0,0,0)
	LayoutPanel.AddView(xlbl_pin_7,0,0,0,0)
	LayoutPanel.AddView(xlbl_pin_8,0,0,0,0)
	
End Sub

Private Sub build_code_pin(xlbl_pin As B4XView) As B4XView
	
	Dim lbl_pin As Label 
	lbl_pin.Initialize("")
	xlbl_pin = lbl_pin
	xlbl_pin.Tag = "pin"
	xlbl_pin.TextColor = code_text_color
	xlbl_pin.SetTextAlignment("CENTER","CENTER")
	xlbl_pin.Font = xui.CreateFontAwesome(20)
	xlbl_pin.Text = Chr(0xF10C)
	
	Return xlbl_pin
	
End Sub

#End Region

#Region Build Keyboard

Private Sub build_keyboard(LayoutPanel As B4XView)
	
	xpnl_key_1 = build_key("key_1",xui.CreateDefaultFont(18),"1",LayoutPanel,0,0,LayoutPanel.Width/3,LayoutPanel.Height/4,1)
	
	xpnl_key_2 = build_key("key_2",xui.CreateDefaultFont(18),"2",LayoutPanel,LayoutPanel.Width/3,0,LayoutPanel.Width/3,LayoutPanel.Height/4,1)
	
	xpnl_key_3 = build_key("key_3",xui.CreateDefaultFont(18),"3",LayoutPanel,LayoutPanel.Width/3 * 2,0,LayoutPanel.Width/3,LayoutPanel.Height/4,1)
	
	xpnl_key_4 = build_key("key_4",xui.CreateDefaultFont(18),"4",LayoutPanel,0,LayoutPanel.Height/4,LayoutPanel.Width/3,LayoutPanel.Height/4,1)
	
	xpnl_key_5 = build_key("key_5",xui.CreateDefaultFont(18),"5",LayoutPanel,LayoutPanel.Width/3,LayoutPanel.Height/4,LayoutPanel.Width/3,LayoutPanel.Height/4,1)
	
	xpnl_key_6 = build_key("key_6",xui.CreateDefaultFont(18),"6",LayoutPanel,LayoutPanel.Width/3 * 2,LayoutPanel.Height/4,LayoutPanel.Width/3,LayoutPanel.Height/4,1)
	
	xpnl_key_7 = build_key("key_7",xui.CreateDefaultFont(18),"7",LayoutPanel,0,LayoutPanel.Height/4 * 2,LayoutPanel.Width/3,LayoutPanel.Height/4,1)
	
	xpnl_key_8 = build_key("key_8",xui.CreateDefaultFont(18),"8",LayoutPanel,LayoutPanel.Width/3,LayoutPanel.Height/4 * 2,LayoutPanel.Width/3,LayoutPanel.Height/4,1)
	
	xpnl_key_9 = build_key("key_9",xui.CreateDefaultFont(18),"9",LayoutPanel,LayoutPanel.Width/3 * 2,LayoutPanel.Height/4 * 2,LayoutPanel.Width/3,LayoutPanel.Height/4,1)
	
	xpnl_key_0 = build_key("key_0",xui.CreateDefaultFont(18),"0",LayoutPanel,LayoutPanel.Width/3,LayoutPanel.Height/4 * 3,LayoutPanel.Width/3,LayoutPanel.Height/4,1)
	
	xpnl_key_delete = build_key("key_deleteone",xui.CreateMaterialIcons(18),Chr(0xE14A),LayoutPanel,LayoutPanel.Width/3 * 2,LayoutPanel.Height/4 * 3,LayoutPanel.Width/3,LayoutPanel.Height/4,0)
	
	xpnl_key_fingerprint = build_key("key_fingerprint",xui.CreateMaterialIcons(18),Chr(0xE90D),LayoutPanel,0,LayoutPanel.Height/4 * 3,LayoutPanel.Width/3,LayoutPanel.Height/4,0)
	
	mBase.Color = keyboard_number_color
	
End Sub

'10 number keys + back key + fingerprint key = 12 Keys
Private Sub build_key(EventName As String,Fonti As B4XFont,Text As String,LayoutPanel As B4XView,Left As Int,Top As Int,width As Int,height As Int,mode As Int) As B4XView
	
	Dim xpnl_back As B4XView = xui.CreatePanel("")
	LayoutPanel.AddView(xpnl_back,Left,Top,width,height)
	
	Dim lbl_key As Label
	lbl_key.Initialize(EventName)
	Dim xlbl_key As B4XView = lbl_key
	
	xpnl_back.AddView(xlbl_key,0,0,xpnl_back.Width,xpnl_back.Height)
	
	Dim seperator As Int = 0
	
	If show_keyboard_seperator = True Then
		
		seperator = 1dip
		
	End If
	
		If mode = 0 Then
		'xlbl_key.Color = keyboard_extra_color
		xlbl_key.SetColorAndBorder(keyboard_extra_color,seperator,keyboard_seperator_color,0)
	else 	If mode = 1 Then
		'xlbl_key.Color = keyboard_number_color
		xlbl_key.SetColorAndBorder(keyboard_number_color,seperator,keyboard_seperator_color,0)
				End If
	xlbl_key.TextColor = keyboard_text_color

	xlbl_key.SetTextAlignment("CENTER","CENTER")
	xlbl_key.Font = Fonti
	xlbl_key.Text = Text

	
	Return xpnl_back
	
End Sub

#End Region

#Region KeyClicks

Private Sub wich_key_is_pressed(number As Int)
	
	If current_pos = 1 Then
		hashed_value_1 = Number2Hash(number & salt_value)
		xlbl_pin_1.Text = Chr(0xF192)
		
	else If current_pos = 2 Then
		hashed_value_2 = Number2Hash(number & salt_value)
		xlbl_pin_2.Text = Chr(0xF192)
		
	else If current_pos = 3 Then
		hashed_value_3 = Number2Hash(number & salt_value)
		xlbl_pin_3.Text = Chr(0xF192)
		
	else If current_pos = 4 Then
		hashed_value_4 = Number2Hash(number & salt_value)
		xlbl_pin_4.Text = Chr(0xF192)
		
	else If current_pos = 5 Then
		hashed_value_5 = Number2Hash(number & salt_value)
		xlbl_pin_5.Text = Chr(0xF192)
	else If current_pos = 6 Then
		hashed_value_6 = Number2Hash(number & salt_value)
		xlbl_pin_6.Text = Chr(0xF192)
	else If current_pos = 7 Then
		hashed_value_7 = Number2Hash(number & salt_value)
		xlbl_pin_7.Text = Chr(0xF192)
	else If current_pos = 8 Then
		hashed_value_8 = Number2Hash(number & salt_value)
		xlbl_pin_8.Text = Chr(0xF192)
	else If current_pos = 0 Then
		
		Else
			
			If current_pos > 8 And code_length = 8 Then
				
			current_pos = 8
				
		Else If current_pos > 4 And code_length = 4 Then
				
			current_pos = 4
			
		Else If current_pos < 0  Then
				
			current_pos = 0
				
			End If
		
	End If
	
	If code_length = 4 And current_pos = 4 Then
		
		PinnReady_handler(Number2Hash(hashed_value_1 & hashed_value_2 & hashed_value_3 & hashed_value_4 & salt_value))
		
	else If code_length = 8 And current_pos = 8 Then
		
		PinnReady_handler(Number2Hash(hashed_value_1 & hashed_value_2 & hashed_value_3 & hashed_value_4 & hashed_value_5 & hashed_value_6 & hashed_value_7 & hashed_value_8 & salt_value))
		
	End If
	
End Sub

Private Sub key_1_Click
	
	Dim tmp_xlbl As B4XView = Sender
	CreateHaloEffect(tmp_xlbl.Parent,tmp_xlbl.Width/2,tmp_xlbl.Height/2,keyboard_click_color)
	
	current_pos = current_pos +1
	wich_key_is_pressed(1)
	
End Sub

Private Sub key_2_Click
	
	Dim tmp_xlbl As B4XView = Sender
	CreateHaloEffect(tmp_xlbl.Parent,tmp_xlbl.Width/2,tmp_xlbl.Height/2,keyboard_click_color)
	
	current_pos = current_pos +1
	wich_key_is_pressed(2)
	
End Sub

Private Sub key_3_Click
	
	Dim tmp_xlbl As B4XView = Sender
	CreateHaloEffect(tmp_xlbl.Parent,tmp_xlbl.Width/2,tmp_xlbl.Height/2,keyboard_click_color)
	
	current_pos = current_pos +1
	wich_key_is_pressed(3)
	
End Sub


Private Sub key_4_Click
	
	Dim tmp_xlbl As B4XView = Sender
	CreateHaloEffect(tmp_xlbl.Parent,tmp_xlbl.Width/2,tmp_xlbl.Height/2,keyboard_click_color)
	
	current_pos = current_pos +1
	wich_key_is_pressed(4)
	
End Sub

Private Sub key_5_Click
	
	Dim tmp_xlbl As B4XView = Sender
	CreateHaloEffect(tmp_xlbl.Parent,tmp_xlbl.Width/2,tmp_xlbl.Height/2,keyboard_click_color)
	
	current_pos = current_pos +1
	wich_key_is_pressed(5)
	
End Sub

Private Sub key_6_Click
	
	Dim tmp_xlbl As B4XView = Sender
	CreateHaloEffect(tmp_xlbl.Parent,tmp_xlbl.Width/2,tmp_xlbl.Height/2,keyboard_click_color)
	
	current_pos = current_pos +1
	wich_key_is_pressed(6)
	
End Sub

Private Sub key_7_Click
	
	Dim tmp_xlbl As B4XView = Sender
	CreateHaloEffect(tmp_xlbl.Parent,tmp_xlbl.Width/2,tmp_xlbl.Height/2,keyboard_click_color)
	
	current_pos = current_pos +1
	wich_key_is_pressed(7)
	
End Sub

Private Sub key_8_Click
	
	Dim tmp_xlbl As B4XView = Sender
	CreateHaloEffect(tmp_xlbl.Parent,tmp_xlbl.Width/2,tmp_xlbl.Height/2,keyboard_click_color)
	
	current_pos = current_pos +1
	wich_key_is_pressed(8)
	
End Sub

Private Sub key_9_Click
	
	Dim tmp_xlbl As B4XView = Sender
	CreateHaloEffect(tmp_xlbl.Parent,tmp_xlbl.Width/2,tmp_xlbl.Height/2,keyboard_click_color)
	
	current_pos = current_pos +1
	wich_key_is_pressed(9)
	
End Sub

Private Sub key_0_Click
	
	Dim tmp_xlbl As B4XView = Sender
	CreateHaloEffect(tmp_xlbl.Parent,tmp_xlbl.Width/2,tmp_xlbl.Height/2,keyboard_click_color)
	
	current_pos = current_pos +1
	wich_key_is_pressed(0)
	
End Sub

Private Sub key_deleteone_Click
	
	Dim tmp_xlbl As B4XView = Sender
	CreateHaloEffect(tmp_xlbl.Parent,tmp_xlbl.Width/2,tmp_xlbl.Height/2,keyboard_click_color)
	
	If current_pos = 4 Then
		hashed_value_4 = ""
		xlbl_pin_4.Text = Chr(0xF10C)
		
		If code_length = 4 Then
			
			setCodeTextColor(code_text_color)
			
		End If
		
	else If current_pos = 3 Then
		hashed_value_3 = ""
		xlbl_pin_3.Text = Chr(0xF10C)
		
	else If current_pos = 2 Then
		hashed_value_2 = ""
		xlbl_pin_2.Text = Chr(0xF10C)
		
	else If current_pos = 1 Then
		hashed_value_1 = ""
		xlbl_pin_1.Text = Chr(0xF10C)
		
	else If current_pos = 5 Then
		hashed_value_5 = ""
		xlbl_pin_5.Text = Chr(0xF10C)
		
	else If current_pos = 6 Then
		hashed_value_6 = ""
		xlbl_pin_6.Text = Chr(0xF10C)
		
	else If current_pos = 7 Then
		hashed_value_7 = ""
		xlbl_pin_7.Text = Chr(0xF10C)
		
	else If current_pos = 8 Then
		hashed_value_8 = ""
		xlbl_pin_8.Text = Chr(0xF10C)
		If code_length = 8 Then
			
			setCodeTextColor(code_text_color)
			
		End If
	End If
	
	current_pos = current_pos -1
	
End Sub

Private Sub key_fingerprint_Click
	
	Dim tmp_xlbl As B4XView = Sender
	CreateHaloEffect(tmp_xlbl.Parent,tmp_xlbl.Width/2,tmp_xlbl.Height/2,keyboard_click_color)
	
	key_fingerprint_handler
	
End Sub

Private Sub key_fingerprint_handler
	
	If xui.SubExists(mCallBack, mEventName & "_CustomKeyClick",0) Then
		Sleep(0)
		CallSub(mCallBack, mEventName & "_CustomKeyClick")
	End If
	
End Sub

#End Region

#Region UsedFunctions
'https://www.b4x.com/android/forum/threads/b4x-xui-simple-halo-animation.80267/#content
Private Sub CreateHaloEffect (Parent As B4XView, x As Int, y As Int, clr As Int)
	Dim cvs As B4XCanvas
	Dim p As B4XView = xui.CreatePanel("")
	Dim radius As Int = 150dip
	p.SetLayoutAnimated(0, 0, 0, radius * 2, radius * 2)
	cvs.Initialize(p)
	cvs.DrawCircle(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, cvs.TargetRect.Width / 2, clr, True, 0)
	Dim bmp As B4XBitmap = cvs.CreateBitmap
	For i = 1 To 1
		CreateHaloEffectHelper(Parent,bmp, x, y, radius)
		Sleep(350)
	Next
End Sub

Private Sub CreateHaloEffectHelper (Parent As B4XView,bmp As B4XBitmap, x As Int, y As Int, radius As Int)
	Dim iv As ImageView
	iv.Initialize("")
	Dim p As B4XView = iv
	p.SetBitmap(bmp)
	Parent.AddView(p, x, y, 0, 0)
	Dim duration As Int = 500
	p.SetLayoutAnimated(duration, x - radius, y - radius, 2 * radius, 2 * radius)
	p.SetVisibleAnimated(duration, False)
	Sleep(duration)
	p.RemoveViewFromParent
End Sub

Private Sub Number2Hash (input As String) As String
	
	If encrypt_method = "NONE" Then
		
		Return input
		
		Else
	
	Dim md As MessageDigest
	Dim ByteCon As ByteConverter
	Dim passwordhash() As Byte
  
	passwordhash = md.GetMessageDigest(input.GetBytes("UTF8"),encrypt_method)
	Dim HashString As String
	HashString = ByteCon.HexFromBytes(passwordhash)
	HashString = HashString.ToLowerCase
	Return HashString
	
	End If
End Sub

#End Region