B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.5
@EndOfDesignText@
#Event: Click
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: TExt Color
#DesignerProperty: Key: TextSize, DisplayName: Text Size for not Square, FieldType: int, DefaultValue: 16, Description: Size for TextLabel if not Square
#DesignerProperty: Key: Color, DisplayName: Backgrond Color, FieldType: Color, DefaultValue: 0xFF009688, Description: Backgrond Color
#DesignerProperty: Key: Title, DisplayName: Title windows, FieldType: String, DefaultValue: Select date, Description: Backgrond Color
#DesignerProperty: Key: Square, DisplayName: Square form, FieldType: boolean, DefaultValue: True, Description: Square form
#DesignerProperty: Key: Now, DisplayName: Date Now, FieldType: Boolean, DefaultValue: True, Description: Start with actual Date Time 
#DesignerProperty: Key: DayOfMounth, DisplayName: Day of Mounth, FieldType: int, DefaultValue: 1, Description: Day of Mounth
#DesignerProperty: Key: Mounth, DisplayName: Mounth, FieldType: int, DefaultValue: 5, Description: Mounth
#DesignerProperty: Key: Year, DisplayName: Year, FieldType: int, DefaultValue: 2017, Description: Year

Sub Class_Globals
	Public DatePicker As Long
	Public Color As Int = Colors.RGB(0,150,136)
	Public TextColor As Int = Colors.White
	Public TextSize As Int = 16
	Public Title As String = ""
	Public Square As Boolean = True
	
	Private EventName As String 'ignore
	Private CallBack As Object 'ignore
	Private mBase As Panel
	Private Pa As Panel
	Private Pan As Panel
	Private MyAct As Panel
	
	Private DateRet As Long = 0
	Private Ret As Int = 0
	
	Private Cale As Panel
	Private Testa As Panel
	Private ButtonOk As Button
	Private ButtoCancel As Button
	Private LabelNow As Label
	Private LDay As Label
	Private LYear As Label
	Private LMounth As Label
End Sub

Public Sub Initialize (vCallback As Object, vEventName As String)
	EventName = vEventName
	CallBack = vCallback
	Pa.Initialize("Pa")
End Sub

Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	Dim Bm As Bitmap
	Dim Can As Canvas
	Dim D,M,Y As Int
	
	mBase = Base
	mBase.Color=Colors.Transparent
	
	' Find Activity
	Dim Obj As View = mBase
	Do While Not(GetType(Obj) = "android.widget.FrameLayout")
		Obj=Obj.Parent
	Loop
	MyAct=Obj
	
	' Initialize Main Panel
	Pan.Initialize("Pan")
	mBase.AddView(Pan,0dip,0dip,mBase.Width,mBase.Height)
	
	' Read Parameter
	If Props.ContainsKey("TextColor") Then TextColor=Props.Get("TextColor")
	If Props.ContainsKey("TextSize") Then TextSize=Props.Get("TextSize")
	If Props.ContainsKey("Color") Then Color=Props.Get("Color")
	If Props.ContainsKey("DayOfMounth") Then d=Props.Get("DayOfMounth")
	If Props.ContainsKey("Mounth") Then m=Props.Get("Mounth")
	If Props.ContainsKey("Year") Then y=Props.Get("Year")
	If Props.ContainsKey("Title") Then Title=Props.Get("Title")
	If Props.ContainsKey("Square") Then Square=Props.Get("Square")
	
	If Props.ContainsKey("Now") Then
		If Props.Get("Now")=True Then
			DatePicker=DateTime.Now
			D=DateTime.GetDayOfMonth(DatePicker)
			M=DateTime.GetMonth(DatePicker)
			Y=DateTime.GetYear(DatePicker)
		Else
			DateTime.DateFormat="MM/dd/yyyyy"
			DatePicker=DateTime.DateParse(m & "/" & d & "/" & y)
		End If
	End If
		
	DateRet=DatePicker
	
	If Square Then
		Bm.InitializeMutable(400dip,400dip)
		Can.Initialize2(Bm)
		Can.DrawColor(Color)
		Can.DrawText(NomeMese(M),210dip,80dip,Typeface.DEFAULT_BOLD,60,TextColor,"CENTER")
		Can.DrawText(d,200dip,260dip,Typeface.DEFAULT_BOLD,180,TextColor,"CENTER")
		Can.DrawText(y,200dip,350dip,Typeface.DEFAULT_BOLD,60,TextColor,"CENTER")
		Pan.SetBackgroundImage(Can.Bitmap)
	Else
		Pan.Background=Corner(Color)
		Can.Initialize(Pan)
		Can.DrawText(d & "-" & NomeMese(M).SubString2(0,3) &  "-" & y,mBase.Width/2,mBase.Height/2+5dip,Typeface.DEFAULT_BOLD,TextSize,TextColor,"CENTER")
	End If

End Sub

Public Sub GetBase As Panel
	Return mBase
End Sub

Public Sub SetDate(Date As Long)
	Dim Bm As Bitmap
	Dim Can As Canvas
	Dim D,M,Y As Int
	
	D=DateTime.GetDayOfMonth(Date)
	M=DateTime.GetMonth(Date)
	Y=DateTime.GetYear(Date)
	Log(M)
	
	DateTime.DateFormat="MM/dd/yyyy"
	DatePicker=DateTime.DateParse(m & "/" & d & "/" & y)
		
	Bm.InitializeMutable(400dip,400dip)
	Can.Initialize2(Bm)

	If Square Then
		Bm.InitializeMutable(400dip,400dip)
		Can.Initialize2(Bm)
		Can.DrawColor(Color)
		Can.DrawText(NomeMese(M),210dip,80dip,Typeface.DEFAULT_BOLD,60,TextColor,"CENTER")
		Can.DrawText(d,200dip,260dip,Typeface.DEFAULT_BOLD,180,TextColor,"CENTER")
		Can.DrawText(y,200dip,350dip,Typeface.DEFAULT_BOLD,60,TextColor,"CENTER")
		Pan.SetBackgroundImage(Can.Bitmap)
	Else
		Pan.Background=Corner(Color)
		Can.Initialize(Pan)
		Can.DrawText(d & "-" & NomeMese(M).SubString2(0,3) &  "-" & y,mBase.Width/2,mBase.Height/2+5dip,Typeface.DEFAULT_BOLD,TextSize,TextColor,"CENTER")
	End If
End Sub

Private Sub Pan_Click

	Ret=0
	If Show=DialogResponse.POSITIVE Then SetDate(DatePicker)
End Sub

private Sub Corner(Colore As Int) As ColorDrawable
	Dim cdb As ColorDrawable
	cdb.Initialize(Colore, 20dip)
	Return cdb
End Sub

#region InputDialog

private Sub FillCalendar
	Dim GDay,D,M,A,Y,X As Int
	Dim DateStart As Long

	Cale.RemoveAllViews
	'CALENDARIO
	d=DateTime.GetDayOfMonth(DateRet)
	m=DateTime.GetMonth(DateRet)
	a=DateTime.GetYear(DateRet)
	GDay=DateTime.GetDayOfWeek(DateRet)
	
	DateTime.DateFormat="MM/dd/yyy"
	DateStart=DateTime.DateParse(M & "/01/" & A)
	
	DateTime.DateFormat="MM/dd/yyy"
	GDay=DateTime.GetDayOfWeek(DateTime.DateParse(M & "/01/" & A))
	
	For i=0 To 6
		Dim Lab As Label
		Lab.Initialize("")
		Lab.Text=NomeGiorno(i)
		Lab.Color=Colors.Transparent
		If i=0 Then Lab.Textcolor=Colors.Red Else Lab.Textcolor=Colors.Black
		Lab.Gravity=Gravity.CENTER
		Lab.Typeface=Typeface.DEFAULT_BOLD
		Lab.TextSize=14
		Cale.AddView(Lab,i*40dip,0dip,40dip,40dip)
	Next
	
	Y=40dip
	X=(GDay-1)*40dip
	For i=1 To 31
		If DateTime.GetMonth(DateStart)=m Then
			Dim Lab As Label
			
			Lab.Initialize("Giorno")
			If d=i Then
				Lab.Background=Corner(Color)
				Lab.Textcolor=Colors.White
				LabelNow=Lab
			Else
				Lab.Color=Colors.Transparent
				Lab.TextColor=Colors.Black
			End If
			Lab.Text=i
			Lab.Tag=DateStart
			Lab.Gravity=Gravity.CENTER
			Lab.TextSize=14
			Cale.AddView(Lab,X,Y,40dip,40dip)
						
			GDay=GDay+1
			If GDay>7 Then
				GDay=1
				Y=Y+35dip
				X=0dip
			Else
				X=X+40dip
			End If

		End If
		DateStart=DateStart + DateTime.TicksPerDay
	Next
	
	'Button
	ButtonOk.Initialize("ButtonOk")
	ButtonOk.Color=Colors.Transparent
	ButtonOk.TextColor=Color
	ButtonOk.Gravity=Gravity.CENTER
	ButtonOk.Typeface=Typeface.DEFAULT_BOLD
	ButtonOk.Text="OK"
	ButtonOk.Textsize=14
	Cale.AddView(ButtonOk,140dip,240dip,140dip,40dip)
		
	ButtoCancel.Initialize("ButtonCancel")
	ButtoCancel.Color=Colors.Transparent
	ButtoCancel.TextColor=Color
	ButtoCancel.Gravity=Gravity.CENTER
	ButtoCancel.Typeface=Typeface.DEFAULT_BOLD
	ButtoCancel.Text="CANCEL"
	ButtoCancel.Textsize=14
	Cale.AddView(ButtoCancel,0dip,240dip,140dip,40dip)
End Sub

private Sub FillTesta
	'TITOLO
	Dim Lab As Label
	Lab.Initialize("")
	Lab.Gravity=Gravity.CENTER
	Lab.Text=Title
	Lab.TextSize=14
	Lab.Textcolor=Colors.White
	Lab.Color=Colors.ARGB(150,0,0,0)
	Testa.AddView(Lab,0dip,0dip,280dip,30dip)
	
	'Mese
	LMounth.Initialize("")
	LMounth.Gravity=Gravity.CENTER
	LMounth.Text=NomeMese(DateTime.GetMonth(DateRet))
	LMounth.TextSize=25
	LMounth.Textcolor=Colors.White
	LMounth.Color=Colors.Transparent
	Testa.AddView(LMounth,0dip,30dip,280dip,60dip)
	'Prev Mese
	'Dim Lab As Label
	'Lab.Initialize("PrevM")
	'Lab.Gravity=Gravity.CENTER
	'Lab.Text="<"
	'Lab.TextSize=30
	'Lab.Textcolor=Colors.ARGB(200,255,255,255)
	'Lab.Color=Colors.Transparent
	'Testa.AddView(Lab,10dip,30dip,40dip,40dip)
	Dim P2 As Button
	P2.Initialize("PrevM")
	LoadDrawableByName(P2,"jog_tab_left_confirm_gray")
	Testa.AddView(P2,0dip,35dip,40dip,40dip)
	
	'Next Mese
'	Dim Lab As Label
'	Lab.Initialize("NextM")
'	Lab.Gravity=Gravity.CENTER
'	Lab.Text=">"
'	Lab.TextSize=30
'	Lab.Textcolor=Colors.ARGB(200,255,255,255)
'	Lab.Color=Colors.Transparent
'	Testa.AddView(Lab,230dip,30dip,40dip,40dip)
	Dim P2 As Button
	P2.Initialize("NextM")
	LoadDrawableByName(P2,"jog_tab_right_confirm_gray")
	Testa.AddView(P2,240dip,35dip,40dip,40dip)
	
	'giorno
	LDay.Initialize("")
	LDay.Gravity=Gravity.CENTER
	LDay.Text=DateTime.GetDayOfMonth(DateRet)
	LDay.TextSize=100
	LDay.Textcolor=Colors.White
	LDay.Typeface=Typeface.SANS_SERIF
	LDay.Color=Colors.Transparent
	Testa.AddView(LDay,0dip,70dip,280dip,120dip)
	
	'Anno
	LYear.Initialize("")
	LYear.Gravity=Gravity.CENTER
	LYear.Text=DateTime.GetYear(DateRet)
	LYear.TextSize=30
	LYear.Textcolor=Colors.ARGB(200,255,255,255)
	LYear.Color=Colors.Transparent
	Testa.AddView(LYear,0dip,190dip,280dip,40dip)
	'Prev Anno
'	Dim Lab As Label
'	Lab.Initialize("PrevY")
'	Lab.Gravity=Gravity.CENTER
'	Lab.Text="<"
'	Lab.TextSize=30
'	Lab.Textcolor=Colors.ARGB(200,255,255,255)
'	Lab.Color=Colors.Transparent
'	Testa.AddView(Lab,10dip,190dip,40dip,40dip)
	Dim P2 As Button
	P2.Initialize("PrevY")
	LoadDrawableByName(P2,"jog_tab_left_confirm_gray")
	Testa.AddView(P2,0dip,190dip,40dip,40dip)
	
	'Next year
'	Dim Lab As Label
'	Lab.Initialize("NextY")
'	Lab.Gravity=Gravity.CENTER
'	Lab.Text=">"
'	Lab.TextSize=30
'	Lab.Textcolor=Colors.ARGB(200,255,255,255)
'	Lab.Color=Colors.Transparent
'	Testa.AddView(Lab,230dip,190dip,40dip,40dip)
	Dim P2 As Button
	P2.Initialize("NextY")
	LoadDrawableByName(P2,"jog_tab_right_confirm_gray")
	Testa.AddView(P2,240dip,190dip,40dip,40dip)
	
End Sub

Private Sub Show As Int
	Dim Tit As Int = GetDeviceLayoutValues.Height - 100%y
	Pa.Color=Colors.ARGB(200,0,0,0)
	
	Cale.Initialize("Cale")
	Cale.Color=Colors.White
	
	Testa.Initialize("Testa")
	Testa.Color=Color
	
	FillCalendar
	FillTesta
		
	If 100%y>100%x Then
		'verticale -250 +280 = 530
		Pa.AddView(Testa,50%x-140dip,50%y-265dip,280dip,250dip)
		Pa.AddView(Cale,50%x-140dip,50%y-15dip,280dip,280dip)
		MyAct.AddView(Pa,0dip,0dip,100%x,100%y)
	Else
		'orizzontale
		Pa.AddView(Testa,50%x-280dip,50%y-140dip,280dip,280dip)
		Pa.AddView(Cale,50%x,50%y-140dip,280dip,280dip)
		MyAct.AddView(Pa,0dip,0dip,100%x,100%y)
	End If
	
	Do While Ret=0
		DoEvents 'ignore
		If Pa.Width<>GetDeviceLayoutValues.Width  Then
			MyAct.Width=GetDeviceLayoutValues.Width
			MyAct.Height=GetDeviceLayoutValues.Height-Tit
			Pa.Width=GetDeviceLayoutValues.Width
			Pa.Height=GetDeviceLayoutValues.Height-Tit

			If Pa.Height>Pa.Width Then
				'verticale -250 +280 = 530
				Testa.Left=Pa.Width/2-140dip
				Testa.Top=Pa.Height/2-265dip
				Testa.Height=250dip
				Cale.Left=Pa.Width/2-140dip
				Cale.Top=Pa.Height/2-15dip
			Else
				'orizzontale
				Testa.Left=Pa.Width/2-280dip
				Testa.Top=Pa.Height/2-140dip
				Testa.Height=280dip
				Cale.Left=Pa.Width/2
				Cale.Top=Pa.Height/2-140dip
			End If
		End If
	Loop
	
	Pa.RemoveView
	Return Ret
End Sub

private Sub Giorno_Click
	LabelNow.Color=Colors.Transparent
	LabelNow.TextColor=Colors.Black
	
	LabelNow=Sender
	LabelNow.Background=Corner(Color)
	LabelNow.Textcolor=Colors.White
	
	DateRet=LabelNow.Tag
	LDay.Text=LabelNow.Text
End Sub

Private Sub LoadDrawableByName(Control As View, ImageName As String) As Boolean
	Dim R As Reflector
	Try
		R.Target = R.GetContext
		R.Target = R.RunMethod("getResources")
		R.Target = R.RunMethod("getSystem")
		Dim ID_Drawable As Int
		ID_Drawable = R.RunMethod4("getIdentifier", Array As Object(ImageName, "drawable", "android"), _
		                                            Array As String("java.lang.String", "java.lang.String", "java.lang.String"))
		R.Target = R.GetContext
		R.Target = R.RunMethod("getResources")
		Control.Background = R.RunMethod2("getDrawable", ID_Drawable, "java.lang.int")
		Return True
		
	Catch
		LogColor("ERROR.LoadDrawableByName:" & LastException.Message, Colors.Red)
		Return False
		
	End Try
End Sub
#End Region

#Region Button
Private Sub PrevM_Click
	Dim D,M,A As Int
	
	d=DateTime.GetDayOfMonth(DateRet)
	m=DateTime.GetMonth(DateRet)
	a=DateTime.GetYear(DateRet)
	
	M=M-1
	If M=0 Then
		M=12
		a=a-1
	End If
	
	If (M=2)And(D>28) Then D=28
	If (M>30) And (D=4 Or D=6 Or D=9 Or D=11) Then D=30
	
	DateTime.DateFormat="MM/dd/yyyy"
	DateRet=DateTime.DateParse(m & "/" & d & "/" & a)
	FillCalendar
	LMounth.Text=NomeMese(M)
	LYear.Text=a
	LDay.Text=d
End Sub

Private Sub NextM_Click
	Dim D,M,A As Int
	
	d=DateTime.GetDayOfMonth(DateRet)
	m=DateTime.GetMonth(DateRet)
	a=DateTime.GetYear(DateRet)
	
	M=M+1
	If M=13 Then
		M=1
		a=a+1
	End If
	
	If (M=2)And(D>28) Then D=28
	If (M>30) And (D=4 Or D=6 Or D=9 Or D=11) Then D=30
	
	DateTime.DateFormat="MM/dd/yyyy"
	DateRet=DateTime.DateParse(m & "/" & d & "/" & a)
	FillCalendar
	LMounth.Text=NomeMese(M)
	LYear.Text=a
	LDay.Text=d
End Sub

Private Sub PrevY_Click
	Dim D,M,A As Int
	
	d=DateTime.GetDayOfMonth(DateRet)
	m=DateTime.GetMonth(DateRet)
	a=DateTime.GetYear(DateRet)
	
	a=a-1
		
	If (M=2)And(D>28) Then D=28
	If (M>30) And (D=4 Or D=6 Or D=9 Or D=11) Then D=30
	
	DateTime.DateFormat="MM/dd/yyyy"
	DateRet=DateTime.DateParse(m & "/" & d & "/" & a)
	FillCalendar
	LYear.Text=a
	LDay.Text=d
End Sub

Private Sub Nexty_Click
	Dim D,M,A As Int
	
	d=DateTime.GetDayOfMonth(DateRet)
	m=DateTime.GetMonth(DateRet)
	a=DateTime.GetYear(DateRet)
	
	a=a+1
		
	If (M=2)And(D>28) Then D=28
	If (M>30) And (D=4 Or D=6 Or D=9 Or D=11) Then D=30
	
	DateTime.DateFormat="MM/dd/yyyy"
	DateRet=DateTime.DateParse(m & "/" & d & "/" & a)
	FillCalendar
	LYear.Text=a
	LDay.Text=d
End Sub

private Sub ButtonOk_Click
	DatePicker=DateRet
	Ret=DialogResponse.POSITIVE
	If SubExists(CallBack,EventName & "_Click") Then CallSub(CallBack,EventName & "_Click")
End Sub

private Sub ButtonCancel_Click
	Ret=DialogResponse.NEGATIVE
End Sub

#End Region

#Region Traduci

private Sub NomeGiorno(D As Int) As String
	Dim L_it As List = Array As String ("D","L","M","M","G","V","S")
	Dim L_en As List = Array As String ("S","M","T","W","T","F","S")
	Dim L_es As List = Array As String ("D","L","M","M","J","V","S")
	Dim L_fr As List = Array As String ("D","L","M","M","J","V","S")
	Dim L_de As List = Array As String ("S","M","D","M","D","F","S")
	Dim L_pt As List = Array As String ("D","S","T","Q","Q","S","S")
	Dim L_ru As List = Array As String ("В","П","В","С","Ч","П","С")
	Dim L_ko As List = Array As String ("일","월","화","수","목","금","토")
	Dim S As String
	
	If Lingua.StartsWith("it") Then
		S=L_it.Get(d)
	Else If Lingua.StartsWith("fr") Then
		S=L_fr.Get(d)
	Else If Lingua.StartsWith("ru") Then
		S=L_ru.Get(d)
	Else If Lingua.StartsWith("es") Then
		S=L_es.Get(d-1)
	Else If Lingua.StartsWith("de") Then
		S=L_de.Get(d)
	Else If Lingua.StartsWith("pt") Then
		S=L_pt.Get(d)
	Else If Lingua.StartsWith("ko") Then
		S=L_ko.Get(d)
	Else
		S=L_en.Get(d)
	End If
	
	Return S
End Sub

private Sub NomeMese(M As Int) As String
	Dim L_it As List = Array As String ("Gennaio","Febbraio","Marzo","Aprile","Maggio","Giugno","Luglio","Agosto","Settembre","Ottobre","Novembre","Dicembre")
	Dim L_en As List = Array As String ("January","February","March","April","May","June","July","August","September","October","November","December")
	Dim L_fr As List = Array As String ("Janvier","Février","Mars","Avril","mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre")
	Dim L_ru As List = Array As String ("Январь" , "Февраль" , "Март","Апрель" , "Май" , "Июнь" , "Июль" , "Август" , "Сентябрь" , "Октябрь" , "Ноябрь" , "Декабрь")
	Dim L_es As List = Array As String ("Enero" , "Febrero" , "Marcha","abril" , "puede" , "Junio​​" , "Julio" , "agosto" , "Septiembre" , "Octubre" , "noviembre" , "diciembre")
	Dim L_de As List = Array As String ("Januar", "Februar", "März" , "April" , "Mai" , "June" , "Juli" , "August" , "September" , "October" , "November" , "December")
	Dim L_pt As List = Array As String ("Janeiro" , "fevereiro" , "March", "Abril" , "pode" , "June" , "Julho" , "August" , "September" , "Outubro" , "November", "dezembro")
	Dim L_ko As List = Array As String ("1월","2월","3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월")
	Dim S As String

	If Lingua.StartsWith("it") Then
		S=L_it.Get(M-1)
	Else If Lingua.StartsWith("fr") Then
		S=L_fr.Get(M-1)
	Else If Lingua.StartsWith("ru") Then
		S=L_ru.Get(M-1)
	Else If Lingua.StartsWith("es") Then
		S=L_es.Get(M-1)
	Else If Lingua.StartsWith("de") Then
		S=L_de.Get(M-1)
	Else If Lingua.StartsWith("pt") Then
		S=L_pt.Get(M-1)
	Else If Lingua.StartsWith("ko") Then
		S=L_ko.Get(M-1)
	Else
		S=L_en.Get(M-1)
	End If
	
	Return S
End Sub

private Sub Lingua As String
	Dim r As Reflector
	r.Target = r.RunStaticMethod("java.util.Locale", "getDefault", Null, Null)
	Return r.RunMethod("getLanguage")
End Sub
#End Region
