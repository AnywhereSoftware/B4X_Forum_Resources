B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
#DesignerProperty: Key: ZamanDilimiOnikiYirmiDort, DisplayName:  24 Hour Time, FieldType: Boolean, DefaultValue: True, Description: If you check it will be set for the 24-hour time frame.
#DesignerProperty: Key: SaniyeVisible, DisplayName: Second Visible, FieldType: Boolean, DefaultValue: False, Description: Second Visible 'true , false'
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: #FFFFFFFF, Description: Background Color
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: #FF000000, Description: Text Color
#DesignerProperty: Key: ClockColor, DisplayName: Clock Color, FieldType: Color, DefaultValue: #FFFFFFFF, Description: Clock Color

Private Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	Private xui As XUI 'ignore
	Private Tag As Object 'ignore
	
	
	Private AnaPanel As Panel
	
	Private Saatb4x As B4XView  'ignore
	Private SaatLblb4x As B4XView'ignore
	Private Dakikab4x As B4XView'ignore
	Private Dakikalblbb4x As B4XView'ignore
	Private Saniyeb4x As B4XView'ignore
	
	Private ZamanDilimiOnikiYirmiDort As Boolean
	Private SaniyeVisibleCheck As Boolean 'ignore
	Private BackgroundColor As String
	Private TextColor As String
	Private ClockColor As String 'ignore
	
	#If B4A
	Public Hour_Text As EditText
	Private Minute_Text As EditText
	Private Second_Text As EditText
	Private SaatLabel As Label
	Private DakikaLabel As Label
	
	Private IME As IME
	#Else
	Public Hour_Text As TextField
	Public Minute_Text As TextField
	Public Second_Text As TextField
	Private SaatLabel As Label
	Private DakikaLabel As Label
	#End If
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	

	AnaPanel.Initialize("AnaPanel")
	
	#IF B4A
	IME.Initialize("")
	
	#Else
	
	
	
	#End If

	Hour_Text.Initialize("Hour_Text")
	Minute_Text.Initialize("Minute_Text")
	Second_Text.Initialize("Second_Text")
	
	SaatLabel.Initialize("SaatLabel")
	DakikaLabel.Initialize("DakikaLabel")


	Saatb4x=Hour_Text
	Dakikab4x=Minute_Text
	Saniyeb4x=Second_Text
	
	SaatLblb4x=SaatLabel
	Dakikalblbb4x=DakikaLabel
	
	#IF B4A
	IME.Initialize("")
	
	Hour_Text.InputType=Hour_Text.INPUT_TYPE_NUMBERS
	Minute_Text.InputType=Hour_Text.INPUT_TYPE_NUMBERS
	Second_Text.InputType=Hour_Text.INPUT_TYPE_NUMBERS
	
	Hour_Text.Gravity=Gravity.CENTER
	Minute_Text.Gravity=Gravity.CENTER
	Second_Text.Gravity=Gravity.CENTER
	
	SaatLabel.Gravity=Gravity.CENTER
	DakikaLabel.Gravity=Gravity.CENTER
	
	Hour_Text.Color = Colors.Transparent
	Minute_Text.Color=Colors.Transparent
	Second_Text.Color=Colors.Transparent
		
	Hour_Text.Hint="00"
	SaatLabel.Text=":"
	Minute_Text.Hint="00"
	DakikaLabel.Text=":"
	Second_Text.Hint="00"
	
	#Else
	
	Hour_Text.KeyboardType=4
	Minute_Text.KeyboardType=4
	Second_Text.KeyboardType=4
	
	Hour_Text.TextAlignment=1
	Minute_Text.TextAlignment=1
	Second_Text.TextAlignment=1
	
	SaatLabel.TextAlignment=1
	DakikaLabel.TextAlignment=1
	
	
	#End If
	
'	Hour_Text.InputType=Hour_Text.INPUT_TYPE_NUMBERS
'	Minute_Text.InputType=Hour_Text.INPUT_TYPE_NUMBERS
'	Second_Text.InputType=Hour_Text.INPUT_TYPE_NUMBERS
	
'	Hour_Text
'	Minute_Text.Gravity=Gravity.CENTER
'	Second_Text.Gravity=Gravity.CENTER
'	
'	SaatLabel.Gravity=Gravity.CENTER
'	DakikaLabel.Gravity=Gravity.CENTER
	
	Hour_Text.Color = Colors.Transparent
	Minute_Text.Color=Colors.Transparent
	Second_Text.Color=Colors.Transparent
		
		
	SaatLabel.Text=":"
	DakikaLabel.Text=":"
	
	
	#if b4a
	Hour_Text.Hint="00"
	
	Minute_Text.Hint="00"
	
	Second_Text.Hint="00"
	 #else
	Hour_Text.HintText="00"
	
	Minute_Text.HintText="00"
	
	Second_Text.HintText="00"
	#End If
	
	
	
	
	
End Sub


Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	ZamanDilimiOnikiYirmiDort=Props.Get("ZamanDilimiOnikiYirmiDort")
	BackgroundColor=Props.Get("BackgroundColor")
	SaniyeVisibleCheck=Props.Get("SaniyeVisible")
	TextColor=Props.Get("TextColor")
	ClockColor=Props.Get("ClockColor")
	
	mBase.AddView(AnaPanel,0,0,mBase.Width, mBase.Height)
	
	
	#if b4a
	
	Dim PanelArkaPlanOzellikleri As ColorDrawable
	PanelArkaPlanOzellikleri.Initialize2(BackgroundColor,0,0,BackgroundColor)
	AnaPanel.Background=PanelArkaPlanOzellikleri
	
	#else b4i
'	
'	AnaPanel.SetBorder(0,BorderColor,ArkaPlanRadius)

	AnaPanel.SetBorder(0,BackgroundColor,0)
	
	AnaPanel.SetColorAnimated(0,BackgroundColor)
	
	Hour_Text.BorderStyle=0
	Minute_Text.BorderStyle=0
	Second_Text.BorderStyle=0
	
	
	
	#End If
	
	
	
	
	
	If SaniyeVisibleCheck=True Then
		AnaPanel.AddView(Hour_Text,0%x,0,mBase.Width/3,mBase.Height)
		AnaPanel.AddView(SaatLabel,Hour_Text.Width - 3dip ,0,5dip,mBase.Height-3dip)
		AnaPanel.AddView(Minute_Text,mBase.Width/3,0,mBase.Width/3,mBase.Height)
		AnaPanel.AddView(DakikaLabel,Minute_Text.Left + Minute_Text.Width - 3dip,0,5dip,mBase.Height-3dip)
		AnaPanel.AddView(Second_Text,Minute_Text.Left+Minute_Text.Width,0,mBase.Width/3,mBase.Height)
	Else ' saniye yoksa
		AnaPanel.AddView(Hour_Text,0%x,0,mBase.Width/2,mBase.Height)
		AnaPanel.AddView(SaatLabel,Hour_Text.Width - 2dip ,0,5dip,mBase.Height-3dip)
		AnaPanel.AddView(Minute_Text,mBase.Width/2,0,mBase.Width/2,mBase.Height)
	End If
	
	#if b4a
	
	Hour_Text.HintColor = TextColor
	Minute_Text.HintColor = TextColor
	Second_Text.HintColor = TextColor
	
	IME.SetLengthFilter(Hour_Text, 2)
	IME.SetLengthFilter(Minute_Text, 2)
	IME.SetLengthFilter(Second_Text, 2)
	
	#else b4i
	
'
'	Hour_Text.TintColor = TextColor
'	Minute_Text.TintColor = TextColor
'	Second_Text.TintColor = TextColor
	
	
	#End If
	
	
	
	Hour_Text.TextColor = TextColor
	Minute_Text.TextColor = TextColor
	Second_Text.TextColor = TextColor
	SaatLabel.TextColor= ClockColor
	DakikaLabel.TextColor= ClockColor
	
	
	
End Sub

Private Sub Hour_Text_TextChanged (Old As String, New As String)
	Try
		#if b4i
			Sleep(10)
		#End If
		
		If New.Length>=2 Then
			Dim Saatex As Int = Hour_Text.Text
		
			If ZamanDilimiOnikiYirmiDort = False Then
			
				If Saatex > 12 Then
				
				#if b4a 
					Hour_Text.Hint = "00"
				#else
				Hour_Text.HintText = "00"
				#End If
				
					Hour_Text.Text = ""
				
				Else if Saatex <= 12 Then
					If New.Length = 2 Then
					Minute_Text.RequestFocus
					End If
				End If

			Else if ZamanDilimiOnikiYirmiDort = True Then
	
				If Saatex >= 24 Then
				
				#if b4a 
					Hour_Text.Hint = "00"
				#else
				Hour_Text.HintText = "00"
				#End If
				
					Hour_Text.Text = ""
				
				Else if Saatex <= 24 Then
					If New.Length = 2 Then
						Minute_Text.RequestFocus
					End If
				End If
			
			End If
		End If
		
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Minute_Text_TextChanged (Old As String, New As String)
	Try
		
		#if b4i
		Sleep(10)
		If Minute_Text.Text.Length>2 Then
			CallSubDelayed3(Me, "CutText",Minute_Text,2)
		End If
		#End If
		
		
		
		If New.Length>=2 Then
			Dim Dakikaex As Int = Minute_Text.Text
			
			
		
			If Dakikaex > 59 Then
			#if b4a 
				Minute_Text.Hint = "00"
			#else
			Minute_Text.HintText = "00"
			#End If
				Minute_Text.Text = ""
			else if Dakikaex <= 59 Then
				If New.Length = 2 And SaniyeVisibleCheck=True Then
					Second_Text.RequestFocus
				Else If New.Length=2 Then
					#if b4i
					Minute_Text.ResignFocus
					#else if b4a
					IME.HideKeyboard
					#end if
			
				End If
			End If
		End If
		
		If New.Length=0 Then
			Hour_Text.RequestFocus
		End If
		
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Second_Text_TextChanged (Old As String, New As String)
	Try
		
		#if b4i
		Sleep(10)
		If Second_Text.Text.Length>2 Then
			CallSubDelayed3(Me, "CutText",Second_Text,2)
		End If
		#End If
		
		
		
		If New.Length>=2 Then
			Dim Saniyeex As Int = Second_Text.Text
		
			If Saniyeex > 59 Then
			#if b4a 
				Second_Text.Hint = "00"
			#else
				Second_Text.HintText = "00"
			#End If
				Second_Text.Text = ""
			Else If Second_Text.Text <= 59 Then
				
				If New.Length=2 Then
					#if b4i
					Second_Text.ResignFocus
					#else if b4a
					IME.HideKeyboard
					#end if
				End If
				
			End If
			
			
		End If
		
		If New.Length=0 Then
			Minute_Text.RequestFocus
		End If
		
	Catch
		Log(LastException)
	End Try
End Sub

 #if b4i
Sub CutText(Tf As TextField,MaxLength As Int)
	If Tf.Text.Length > MaxLength Then
		Tf.Text = Tf.Text.SubString2(0,MaxLength)
	End If
End Sub
#End If

Public Sub Time
	If SaniyeVisibleCheck=False And Hour_Text.Text.Length<>0 And Minute_Text.Text.Length<>0 Then
	
		Dim SaatveDakika As String = Hour_Text.Text & ":" & Minute_Text.Text
	
		Return SaatveDakika
		
	Else if SaniyeVisibleCheck=True And Hour_Text.Text.Length<>0 And Minute_Text.Text.Length<>0 And Second_Text.Text.Length<>0 Then
			
		Dim SaatveDakikaveSaniye As String = Hour_Text.Text & ":" & Minute_Text.Text & ":" & Second_Text.Text
		
		Return SaatveDakikaveSaniye
	
	End If
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub