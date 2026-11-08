B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
#Event: Click(id  as string )


Sub Class_Globals
	Private cs As CSBuilder
	Public BulletsMap As Map 
	Public TypefacesMap As Map 
	Public ColorsMap As Map
	Public BulletTypeFace As Typeface
	Private EventName As String
	Private CallBack As Object
	Private xui As XUI
End Sub


	
Private Sub Superscript  (csp As Object)
	Dim span As JavaObject
	span.InitializeNewInstance("android.text.style.SuperscriptSpan", Array())
	Dim jo As JavaObject = csp
	jo.RunMethod("open", Array(span))
End Sub

Private Sub Subscript (csp As Object)
	Dim span As JavaObject
	span.InitializeNewInstance("android.text.style.SubscriptSpan", Array())
	Dim jo As JavaObject = csp
	jo.RunMethod("open", Array(span))
End Sub

Private Sub AddTabStop(csp As Object, Offset As Int)
	Dim span As JavaObject
	span.InitializeNewInstance("android.text.style.TabStopSpan.Standard", Array(Offset))
	Dim jo As JavaObject = csp
	jo.RunMethod("open", Array(span))
End Sub

Private Sub AddQuoteSpan(csp As Object, intColorGap As Int)
	Dim span As JavaObject
	span.InitializeNewInstance("android.text.style.QuoteSpan", Array(intColorGap))
	Dim jo As JavaObject = csp
	jo.RunMethod("open", Array(span))
End Sub

Private Sub AddLeadingMarginSpan(csp As Object, FirstAndRest() As Int)
	Dim span As JavaObject
	span.InitializeNewInstance("android.text.style.LeadingMarginSpan.Standard", Array(FirstAndRest(0), FirstAndRest(1)))
	Dim jo As JavaObject = csp
	jo.RunMethod("open", Array(span))
End Sub

Private Sub IconMarginSpan(csp As Object, Param() As Object  )
	Dim span As JavaObject
	span.InitializeNewInstance("android.text.style.IconMarginSpan", Array(Param(0),Param(1)))
	Dim jo As JavaObject = csp
	jo.RunMethod("open", Array(span))
End Sub


Public Sub Initialize As TagCSBuilder
	EventName = ""
	CallBack = Null
	BulletTypeFace = Typeface.FONTAWESOME
	BulletsMap = CreateMap ( _
				"caret-right" :  	Chr(0xF0DA), _
				"check" :			Chr(0xF00C), _
				"circle" :			Chr(0xF111), _
				"circle-o" : 		Chr(0xF10C), _ 
				"close" : 			Chr(0xF00D), _
				"square-o" :		Chr(0xF096), _
				"check-square-o" :	Chr(0xF046), _
				"info" : 			Chr(0xF129))
	TypefacesMap  = CreateMap ( _
				"default" : Typeface.DEFAULT, _
				"awesone" : Typeface.FONTAWESOME,  _
				"material" : Typeface.MATERIALICONS)
	ColorsMap= CreateMap( _
				"black" : Colors.Black, _
				"blue": Colors.Blue, _
				"cyan" : Colors.Cyan, _
				"darkgray" : Colors.DarkGray, _
				"gray" : Colors.Gray, _
				"green" : Colors.Green, _
				"lightgray" : Colors.LightGray, _
				"magenta" : Colors.Magenta, _
				"red" : Colors.Red, _
				"transparent" :  Colors.Transparent, _
				"white" : Colors.White, _
				"yellow" : Colors.Yellow) 
	cs.Initialize
	Return Me
End Sub


Public Sub InitLink (vCallBack As Object, vEventName As String, lab As Label ) As TagCSBuilder
	EventName = vEventName
	CallBack = vCallBack
	cs.EnableClickEvents(lab)
	Return Me
End Sub


Public Sub ImageMargin(bmp As Bitmap, offset As Int) As TagCSBuilder
	CallSub3(Me, "IconMarginSpan", cs,  Array As Object(bmp ,  offset ))
	Return Me	
End Sub

'Bitmap - the image
'Width/Height : Image dimesnions
'Baseline : If True Then the Image will be aligned on the baselne. Otherwise t will be aligned on the lowest descender in he text
Public Sub Image(bmp As Bitmap, width As Int, height As Int, baseline As Boolean ) As TagCSBuilder
	cs.image(bmp,width,height,baseline)
	Return Me
End Sub 

Private Sub tagcs_Click (Tag As Object)
	If xui.SubExists(CallBack, EventName & "_Click", 0) Then
		CallSubDelayed2(CallBack, EventName & "_Click",Tag)
	End If
End Sub

' Return the charsequence 
Public Sub getCS As CSBuilder
	cs.PopAll
	Return cs
End Sub

' Clear the Tag csbuilder
Public Sub Clear As TagCSBuilder
	cs.Initialize
	Return Me
End Sub

' Append Non taguued string
Public Sub ANS (txt As String) As TagCSBuilder
	cs.Append(txt)
	Return Me
End Sub

' append taggued string 
Public Sub ATS ( txt As String) As TagCSBuilder

	Dim s As String
	Dim i As Int = 0 ' current Index
	Dim  iStart As Int = 0 ' Start  Index
	Dim iSep As Int = 0  ' separator index
	Dim code As Char
	Dim argn As Int = 0
	Dim  arg1, arg2 As String
	
	Do While i < txt.Length
		If txt.CharAt(i) = "<" Then
			' Text non token
			If i <> 0 Then ' sauf si début de chaine pas de précédente
				cs.Append( txt.SubString2(iStart,i))
			End If
			i = i+1
			iStart = i
			iSep = 0
		Else if txt.CharAt(i) = ">" Then ' fin du token
			' token code uppercase
			code = txt.CharAt(iStart)
			If (Asc(code) >= 97) And ( Asc(code) <= 122)  Then code = Chr(Asc(code)-32) ' upercase
			' calculate nuber of parameter,  and extract parameters
			If iStart+1 = i Then
				argn=0
			Else
				If iSep <> 0 Then 	' 2 arguments séparés par une virgule
					argn= 2
					arg1 = txt.SubString2(iStart+1,iSep).trim
					arg2 = txt.SubString2(iSep+1,i).trim
				Else
					argn=1
					arg1 = txt.SubString2(iStart+1,i).trim
				End If
			End If
			i = i+1
			If (i < txt.Length) And (txt.CharAt(i)="<") Then
				i = i +1
			End If
			iStart = i
			iSep = 0
			' code : tag code
			' argn : number of arguments 0, 1 or 2
			' arg 1 : first argument
			' arg2 : second argument
			ExecuteTAge (code,argn, arg1, arg2)
		Else
			If txt.CharAt(i) = "," Then iSep = i
		End If
		i = i+1
	Loop
	If i > txt.length  Then i = i-1
	'f final string
	s = txt.SubString2(iStart,i)
	If s.Length> 0 Then cs.append(s)
	Return Me
	
End Sub




Private Sub  ExecuteTAge (code As Char, argn As Int, arg1 As String, arg2 As String)
	Dim index As Int
	Try 
		Select Case code
			Case "A"
				Select arg1
					Case "N" : cs.Alignment("ALIGN_NORMAL")
					Case "O" : cs.Alignment("ALIGN_OPPOSITE")
					Case "C" : cs.Alignment("ALIGN_CENTER")
				End Select
			Case "B" : 	cs.Bold
			Case "C" : 	If (argn = 1 ) Then cs.Color(DecodeColor(arg1))
			Case "F"
				If IsNumber(arg1) Then
					index = arg1
					If (index>=0) And (index < TypefacesMap.Size) Then cs.Typeface(TypefacesMap.GetValueAt(index))
				Else
					cs.Typeface(TypefacesMap.GetDefault(arg1.ToLowerCase,Typeface.DEFAULT))
				End If
			Case "G" :	If (argn = 1 ) Then cs.BackgroundColor (DecodeColor(arg1))
			Case "H" 
				If (argn=2) Then
					cs.Clickable("tagcs",arg1).Underline.Append(arg2).pop.pop
				Else if (argn=1) Then
					cs.Clickable("tagcs",arg1) 					
				End If
			Case "K" :  cs.Strikethrough
			Case "L" :
				If Not((argn=1) And IsNumber(arg1)) Then arg1=1
				For k=1 To arg1
					cs.Append(CRLF)
				Next
			Case "M"
				If (argn=1) Then
					If IsNumber(arg1) Then CallSub3(Me, "AddLeadingMarginSpan", cs,   Array As Int(arg1*1dip, arg1*1dip))
				else if (argn=2) Then
					If IsNumber(arg1) And IsNumber(arg2) Then CallSub3(Me, "AddLeadingMarginSpan", cs,   Array As Int(arg1*1dip, arg2*1dip))
				End If
			Case "O"
				If (argn=2) Then cs.Size(arg2)
				If IsNumber(arg1) Then
					index = arg1
					If (index>=0) And (index < BulletsMap.Size) Then cs.Typeface(BulletTypeFace).append(BulletsMap.GetValueAt(index)).Pop
				Else
					If arg1.IndexOf("0x")= 0 Then
						cs.Typeface(BulletTypeFace).Append(Chr(Bit.ParseInt(arg1.SubString(2),16))).pop 
					Else
						cs.Typeface(BulletTypeFace).append(BulletsMap.GetDefault(arg1.ToLowerCase,Chr(0xF128))).Pop
					End If 
				End If
				If argn = 2 Then cs.pop
				
			Case "P"    ' POP  <P>:pop <Pn> pop n timew , <PA> : popall
				If (argn=0) Then
					cs.Pop
				Else
					If (argn=1) Then
						If arg1.ToUpperCase = "A" Then
							cs.PopAll
						Else
							If IsNumber(arg1) Then
								For k=1 To arg1
									cs.Pop
								Next
							End If
						End If
					End If
				End If
			Case "Q" : If (argn=1) Then CallSub3(Me, "AddQuoteSpan", cs,   DecodeColor(arg1))
			Case "S" : If (argn = 1) And IsNumber(arg1) Then cs.Size(arg1)
			Case "T"
				Select argn
					Case 0
						cs.append(Chr(9))
					Case 1
						Dim di As Int = arg1*1dip
						CallSub3(Me, "AddTabStop", cs,  di)
				End Select
			Case "U" : cs.Underline
			Case "V" : If (argn = 1) And IsNumber(arg1) Then cs.VerticalAlign(arg1)
			Case "X"
				Select arg1
					Case "-" :  CallSub2(Me, "Subscript", cs)
					Case "+" :  CallSub2(Me, "Superscript", cs)
				End Select
			Case "0" : If (argn=1) And (arg1.CharAt(0)="x") Then cs.Append(Chr(Bit.ParseInt(arg1.SubString(1),16)))
			Case ">" : cs.append(">")
			Case "<" : cs.Append("<")
				
		End Select
	Catch
		cs.Append("***TAG ERROR")
	End Try
	
End Sub

Private Sub DecodeColor( col As String) As Int
	Dim colorStr  As String
	colorStr = col.ToLowerCase
	
	If IsNumber(colorStr) Then
		Dim co As Int = colorStr
		If (co>=0) And (co < ColorsMap.Size) Then
			Return ColorsMap.GetValueAt(co)
		Else
			Return co
		End If
	Else
		If colorStr.CharAt(0) = "#"  Then ' hex value
			If colorStr.Length = 7 Then
				Dim redc As Int = Bit.ParseInt(colorStr.SubString2(1,3),16)
				Dim greenc As Int = Bit.ParseInt(colorStr.SubString2(3,5),16)
				Dim bluec As Int = Bit.ParseInt(colorStr.SubString2(5,7),16)
				Return Colors.RGB(redc,greenc,bluec)
			End If
		Else
			Return ColorsMap.GetDefault(colorStr,Colors.Red)
		End If
	End If
	Return Colors.Red ' ifnot found set to colors.Red
End Sub




