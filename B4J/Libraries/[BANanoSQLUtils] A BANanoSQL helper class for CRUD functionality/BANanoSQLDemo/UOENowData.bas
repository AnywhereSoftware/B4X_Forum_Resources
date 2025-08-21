B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.32
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public DT_Types As List
	Public PrimaryKey As Boolean
	Public Percentage As Boolean
	Public Name As Boolean
	Public Word As Boolean
	Public Percent As Boolean
	Public Password As Boolean
	Public FirstName As Boolean
	Public LastName As Boolean
	Public Country As Boolean
	Public CapitalCity As Boolean
	Public Email As Boolean
	Public Gmail As Boolean
	Public Yahoo As Boolean
	Public Gender As Boolean
	Public Phone As Boolean
	Public YesNo As Boolean
	Public Date As Boolean
	Public Time As Boolean
	Public DateAndTime As Boolean
	Public LoremIpsum As Boolean
	Public Age As Boolean
	Public PinCode As Boolean
	Public Number As Boolean
	Public CompanyName As Boolean
	Public JobTitle As Boolean
	Public Money As Boolean
	Public IPAddress As Boolean
	Public Street As Boolean
	Public Month As Boolean
	Public Sport As Boolean
	Public Minutes As Boolean
	Public HexColor As Boolean
	Public Prefix As Boolean
	Public Port As Boolean
	Public HashTag As Boolean
	Public Twitter As Boolean
	Public Year As Boolean
	Public FullName As Boolean
	Public Seconds As Boolean
	Public Hour As Boolean
	Public Number As Boolean
	
	Public const DT_PRIMARYKEY As String = "id"
	Public const DT_PERCENTAGE As String = "percentage"
	Public const DT_PERCENT As String = "percent"
	Public const DT_PASSWORD As String = "password"
	Public const DT_NAME As String = "name"
	Public const DT_FIRST_NAME As String = "first name"
	Public const DT_LAST_NAME As String = "last name"
	Public const DT_FULL_NAME As String = "full name"
	Public const DT_COUNTRY As String = "country"
	Public const DT_CAPITAL_CITY As String = "capital city"
	Public const DT_EMAIL As String= "email"
	Public const DT_GMAIL As String=  "gmail"
	Public const DT_YAHOO As String = "yahoo"
	Public const DT_GENDER As String = "gender"
	Public const DT_LOREM_IPSUM As String = "lorem ipsum"
	Public const DT_PHONE As String = "phone"
	Public const DT_YES_NO As String = "yes/no"
	Public const DT_SPORT As String = "sport"
	Public const DT_DATE As String = "date"
	Public const DT_TIME As String ="time"
	Public const DT_DATE_TIME As String = "date time"
	Public const DT_AGE As String = "age"
	Public const DT_PINCODE As String= "pin code"
	Public const DT_NUMBER As String = "number"
	Public const DT_COMPANY_NAME As String = "company name"
	Public const DT_JOB_TITLE As String = "job title"
	Public const DT_IP_ADDRESS As String = "ip address"
	Public const DT_MONEY As String = "money"
	Public const DT_STREET As String = "street"
	Public const DT_MONTH As String = "month"
	Public const DT_MINUTES As String = "minutes"
	Public const DT_SECONDS As String = "seconds"
	Public const DT_HOUR As String = "hour"
	Public const DT_HEXCOLOR As String = "hexcolor"
	Public const DT_PREFIX As String = "prefix"
	Public const DT_PORT As String = "port"
	Public const DT_HASHTAG As String = "hashtag"
	Public const DT_TWITTER As String = "twitter"
	Public const DT_YEAR As String ="year"
	Public const DT_WORD As String = "word"
	Private Conditions As Map
End Sub

Sub Initialize As UOENowData
	Conditions.Initialize 
	DT_Types.Initialize
	DT_Types.Add(DT_PRIMARYKEY)
	DT_Types.Add(DT_PERCENTAGE)
	DT_Types.Add(DT_PASSWORD)
	DT_Types.Add(DT_PERCENT)
	DT_Types.Add(DT_NAME)
	DT_Types.Add(DT_FIRST_NAME)
	DT_Types.Add(DT_LAST_NAME)
	DT_Types.Add(DT_FULL_NAME)
	DT_Types.Add(DT_COUNTRY)
	DT_Types.Add(DT_CAPITAL_CITY)
	DT_Types.Add(DT_EMAIL)
	DT_Types.Add(DT_GMAIL)
	DT_Types.Add(DT_YAHOO)
	DT_Types.Add(DT_GENDER)
	DT_Types.Add(DT_LOREM_IPSUM)
	DT_Types.Add(DT_PHONE)
	DT_Types.Add(DT_YES_NO)
	DT_Types.Add(DT_SPORT)
	DT_Types.Add(DT_DATE)
	DT_Types.Add(DT_TIME)
	DT_Types.Add(DT_DATE_TIME)
	DT_Types.Add(DT_AGE)
	DT_Types.Add(DT_PINCODE)
	DT_Types.Add(DT_NUMBER)
	DT_Types.Add(DT_COMPANY_NAME)
	DT_Types.Add(DT_JOB_TITLE)
	DT_Types.Add(DT_IP_ADDRESS)
	DT_Types.Add(DT_MONEY)
	DT_Types.Add(DT_STREET)
	DT_Types.Add(DT_MONTH)
	DT_Types.Add(DT_MINUTES)
	DT_Types.Add(DT_SECONDS)
	DT_Types.Add(DT_HOUR)
	DT_Types.Add(DT_HEXCOLOR)
	DT_Types.Add(DT_PREFIX)
	DT_Types.Add(DT_PORT)
	DT_Types.Add(DT_HASHTAG)
	DT_Types.Add(DT_TWITTER)
	DT_Types.Add(DT_YEAR)
	DT_Types.Add(DT_WORD)
	DT_Types.Add("")
	PrimaryKey = True
	Percentage=False
	Password =False
	Percent = False
	Name = False
	FirstName =False
	LastName = False
	Country =False
	CapitalCity =False
	Email =False
	Gmail =False
	Yahoo =False
	Gender =False
	Phone =False
	YesNo =False
	Date =False
	Time =False
	DateAndTime =False
	LoremIpsum =False
	Age =False
	PinCode =False
	Number =False
	CompanyName =False
	JobTitle =False
	Money =False
	IPAddress =False
	Street =False
	Month =False
	Sport =False
	Minutes =False
	HexColor =False
	Prefix =False
	Port =False
	HashTag =False
	Twitter =False
	Year =False
	FullName = False
	Seconds = False
	Hour = False
	Number = False
	Word = False
	Return Me
End Sub

'add types of data should be returned
Sub All As UOENowData
	PrimaryKey = True
	Percentage=True
	Password =True
	Percent = True
	Name = True
	FirstName =True
	LastName = True
	Country =True
	CapitalCity =True
	Email =True
	Gmail =True
	Yahoo =True
	Gender =True
	Phone =True
	YesNo =True
	Date =True
	Time =True
	DateAndTime =True
	LoremIpsum =True
	Age =True
	PinCode =True
	Number =True
	CompanyName =True
	JobTitle =True
	Money =True
	IPAddress =True
	Street =True
	Month =True
	Sport =True
	Minutes =True
	HexColor =True
	Prefix =True
	Port =True
	HashTag =True
	Twitter =True
	Year =True
	FullName = True
	Seconds = True
	Hour = True
	Number = True
	Word = True
	Return Me
End Sub

'get records from a defined structure using fieldname and dummy type
Sub GetRecordsWithStructure(structure As Map, numRecords As Int) As List
	Dim recs As List
	Dim tRecs As Int
	recs.Initialize 
	For tRecs = 1 To numRecords
		Dim rec As Map
		rec.Initialize 
		For Each strkey As String In structure.Keys
			Dim strVal As String = structure.Get(strkey)
			Dim svalue As String = ""
			Select Case strVal
				Case "word"
					svalue = Rand_Word(2)
				Case "id"
					svalue = tRecs
				Case "percentage"
					svalue = Rand_Percentage
				Case "percent"
					svalue = Rand_Percent
				Case "password"
					svalue = Rand_Password(8,True,True,True,True)
				Case "name"
					svalue = Rand_Human_Name
				Case "first name"
					svalue = Rand_Human_Name
				Case "last name"
					svalue = Rand_Human_Name
				Case "full name"
					svalue = Rand_Full_Name
				Case "country"
					svalue = Rand_Country_Name
				Case "capital city"
					svalue = Rand_Capital_City
				Case "email"
					svalue = Rand_Email("icloud.com",True)
				Case "gmail"
					svalue = Rand_Gmail(True)
				Case "yahoo"
					svalue = Rand_Yahoo_Mail(True)
				Case "gender"
					svalue = Rand_Gender
				Case "lorem ipsum"
					svalue = Rand_LoremIpsum(2)
				Case "phone"
					svalue = Rand_Phone_Number(27,10)
				Case "yes no", "yes/no"
					svalue = Rand_True_Or_False
				Case "sport"
					svalue = Rand_Sport_Name
				Case "date"
					svalue = Rand_Date
				Case "time"
					svalue = Rand_Time
				Case "date time","datetime"
					svalue = Rand_DateTime
				Case "age"
					svalue = Rand_Age(CreateMap("type":"all"))
				Case "pin code", "number"
					svalue = Rand_PinCode(4)
				Case "company name"
					svalue = Rand_Company_Name
				Case "job title"
					svalue = Rand_Occupation
				Case "ip address"
					svalue = Rand_Ip_Address
				Case "money"
					svalue = Rand_Money(4)
				Case "street"
					svalue = Rand_Home_Address
				Case "month"
					svalue = Random_Month
				Case "minutes"
					svalue = Random_Minute
				Case "seconds"
					svalue = Rand_Seconds
				Case "hour"
					svalue = Random_Hour
				Case "hexcolor"
					svalue = Random_HexColor
				Case "prefix"
					svalue = Rand_Prefix(CreateMap("gender":"all"))
				Case "port"
					svalue = Rand_Port
				Case "hashtag"
					svalue = Rand_HashTag
				Case "twitter"
					svalue = Rand_Twitter
				Case "year"
					svalue = Rand_Year
			End Select
			rec.Put(strkey,svalue)
		Next
		ProcessCondition(rec)
		recs.Add(rec)
	Next
	Return recs
End Sub

Sub AddCondition(fldName As String, fldValue As Object, UpdateFields As Map)
	Dim rec As Map
	rec.Initialize 
	rec.Put("name", fldName)
	rec.Put("value", fldValue)
	rec.Put("update", UpdateFields)
	Conditions.Put(fldName,rec)
End Sub

Sub ProcessCondition(rec As Map)
	For Each strfld As String In rec.Keys
		If Conditions.ContainsKey(strfld) Then
			'read value to check against
			Dim checkValue As Object = rec.Get(strfld)
			'get the condition
			Dim cond As Map = Conditions.Get(strfld)
			'get condition value
			Dim value As Object = cond.Get("value")
			'get values to update
			Dim update As Map = cond.Get("update")
			'condition match
			If checkValue = value Then
				For Each condfld As String In update.Keys
					Dim condvalue As Object = update.Get(condfld)
					rec.Put(condfld,condvalue)
				Next
			End If
		End If
	Next
End Sub

Sub GetRecords(numRecords As Int) As List
	Dim recs As List
	recs.Initialize
	Dim tRecs As Int
	For tRecs = 1 To numRecords
		Dim rec As Map
		rec.Initialize
		If PrimaryKey Then rec.Put("id", tRecs)
		If Percentage Then rec.Put("percentage", Rand_Percentage)
		If Percent Then rec.Put("percent", Rand_Percent)
		If Password Then rec.Put("password", Rand_Password(8,True,True,True,True))
		If Name Then rec.Put("name", Rand_Human_Name)
		If FirstName Then rec.Put("firstname", Rand_Human_Name)
		If LastName Then rec.Put("lastname", Rand_Human_Name)
		If FullName Then rec.Put("fullname", Rand_Full_Name)
		If Country Then rec.Put("country", Rand_Country_Name)
		If CapitalCity Then rec.Put("capitalcity", Rand_Capital_City)
		If Email Then rec.Put("email", Rand_Email("icloud.com",True))
		If Gmail Then rec.Put("gmail", Rand_Gmail(True))
		If Yahoo Then rec.Put("yahoo", Rand_Yahoo_Mail(True))
		If Gender Then rec.Put("gender", Rand_Gender)
		If LoremIpsum Then rec.Put("loremipsum", Rand_LoremIpsum(2))
		If Phone Then rec.Put("phone", Rand_Phone_Number(27,10))
		If YesNo Then rec.Put("yesno", Rand_True_Or_False)
		If Sport Then rec.Put("sport", Rand_Sport_Name)
		If Date Then rec.Put("date", Rand_Date)
		If Time Then rec.Put("time", Rand_Time)
		If DateAndTime Then rec.Put("datetime", Rand_DateTime)
		If Age Then rec.Put("age", Rand_Age(CreateMap("type":"all")))
		If PinCode Then rec.Put("pincode", Rand_PinCode(4))
		If CompanyName Then rec.Put("companyname", Rand_Company_Name)
		If JobTitle Then rec.Put("jobtitle", Rand_Occupation)
		If IPAddress Then rec.Put("ipaddress", Rand_Ip_Address)
		If Money Then rec.Put("money", Rand_Money(4))
		If Street Then rec.Put("street", Rand_Home_Address)
		If Month Then rec.Put("month", Random_Month)
		If Minutes Then rec.Put("minutes", Random_Minute)
		If Seconds Then rec.Put("seconds", Rand_Seconds)
		If Hour Then rec.Put("hour", Random_Hour)
		If HexColor Then rec.Put("hexcolor", Random_HexColor)
		If Prefix Then rec.Put("prefix", Rand_Prefix(CreateMap("gender":"all")))
		If Port Then rec.Put("port", Rand_Port)
		If HashTag Then rec.Put("hashtag", Rand_HashTag)
		If Twitter Then rec.Put("twitter", Rand_Twitter)
		If Year Then rec.Put("year", Rand_Year)
		If Word Then rec.Put("word", Rand_Word(2))
		recs.Add(rec)
	Next
	Return recs
End Sub


'This will generate random numeric codes
'Example:
'<code>log(CFStringUtility.generatePinCode(4)) 'This will generate 4 random numbers
' 'Outputs something like this: 3760
 ' </code>
Public Sub Rand_PinCode(PinLength As Int) As Int
	Dim result As String =""
	Dim RandomArray() As String = Array As String(1,2,3,4,5,6,7,8,9,0)
	For i = 0 To PinLength - 1
		result = result &  RandomArray( Rnd( 0, Rnd(2, RandomArray.Length -1)) )
	Next
	Return  result
End Sub

Sub Random_Month As String
	Return Rnd(1,12)
End Sub

Sub Random_Minute As String
	Return Rnd(1,59)
End Sub

Sub Rand_Seconds As String
	Return Rnd(1,59)
End Sub

Sub Random_Hour As String
	Return Rnd(1,12)
End Sub

Sub Random_HexColor As String
	Dim result As StringBuilder
	result.Initialize
	Dim RandomArray() As String = Array As String("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f")
	result.Append("#")
	result.Append(RandomArray(Rnd(0,15)))
	result.Append(RandomArray(Rnd(0,15)))
	result.Append(RandomArray(Rnd(0,15)))
	result.Append(RandomArray(Rnd(0,15)))
	result.Append(RandomArray(Rnd(0,15)))
	result.Append(RandomArray(Rnd(0,15)))
	Return result.ToString
End Sub

'Example
'Options: CreateMap("type":"child")
'Options are child,teen,adult,senior,all
Sub Rand_Age(Options As Map) As String
	Dim stype As String = Options.Get("type")
	Dim iAge As Int = 0
	Select Case stype
		Case "child"
			iAge = Rnd(0,12)
		Case "teen"
			iAge = Rnd(13,19)
		Case "adult"
			iAge = Rnd(18,65)
		Case "senior"
			iAge = Rnd(65,100)
		Case "all"
			iAge = Rnd(0,100)
		Case Else
			iAge = Rnd(0,65)
	End Select
	Dim sage As String = CStr(iAge)
	Return sage
End Sub

'options createmap("gender":"Male")
Sub Rand_Prefix(options As Map) As String
	Dim lst As List
	lst.Initialize
	lst.AddAll(Array("Dr."))
	Dim sgender As String = options.Get("gender")
	sgender = sgender.tolowercase
	Select Case sgender
		Case "male"
			lst.AddAll(Array("Mr."))
		Case "female"
			lst.AddAll(Array("Miss","Mrs."))
		Case Else
			lst.AddAll(Array("Miss","Mrs.","Mr."))
	End Select
	lst = ExplodeList(lst,10)
	Return RandListValue(lst)
End Sub

Sub Rand_Port As String
	Return Rnd(0,65535)
End Sub

'convert a string to a percentage
Sub Rand_Percentage() As String
	Dim sValue As Int = Rnd(1,100)
	sValue = Round2(sValue,2)
	sValue = CStr(sValue) & "%"
	Return sValue
End Sub

'return percentage value
Sub Rand_Percent() As Int
	Dim sValue As Int = Rnd(1,100)
	Return sValue
End Sub

private Sub ShuffleList(pl As List) As List
	For i = pl.Size - 1 To 0 Step -1
		Dim j As Int
		Dim k As Object
		j = Rnd(0, i + 1)
		k = pl.Get(j)
		pl.Set(j,pl.Get(i))
		pl.Set(i,k)
	Next
	Return pl
End Sub

Sub Rand_Password(numChars As Int, numbers As Boolean, lowercase As Boolean, uppercase As Boolean, symbols As Boolean) As String
	Dim uppercaseArray() As String = Array As String ("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z")
	Dim lowercaseArray() As String = Array As String ("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
	Dim numbersArray()   As String = Array As String ("0","1","2","3","4","5","6","7","8","9")
	Dim symbolsArray() As String = Array As String ("@","$","%","&","?","#","!","*","+","-",";","_")
	
	Dim charList As List
	charList.Initialize
  
	If numbers   Then charList.AddAll(numbersArray)
	If lowercase Then charList.AddAll(lowercaseArray)
	If uppercase Then charList.AddAll(uppercaseArray)
	If symbols   Then charList.AddAll(symbolsArray)

	Dim newPassword As StringBuilder
	newPassword.Initialize
  
	For i = 1 To numChars
		newPassword.Append(charList.Get(Rnd(0, charList.Size)))
	Next
	Return newPassword
End Sub

Sub Rand_Year As String
	Return Rnd(1920,3000)
End Sub

public Sub Rand_Date As String
	Dim iMM As Int = Rnd(1,12)
	Dim iDD As Int
	Select Case iMM
		Case 1,3,5,7,8,10,12
			iDD = Rnd(1,31)
		Case 4,6,9,11
			iDD = Rnd(1,30)
		Case 2
			iDD = Rnd(1,28)
	End Select
	Dim iYY As Int = Rnd(1920,3000)
	Dim sDD As String = PadRight(CStr(iDD),2,"0")
	Dim sMM As String = PadRight(CStr(iMM),2,"0")
	Dim strDate As String = $"${iYY}-${sMM}-${sDD}"$
	Return strDate
End Sub

public Sub Rand_Time As String
	Dim iHH As Int = Rnd(1,11)
	Dim iMM As Int = Rnd(1,59)
	Dim sHH As String = PadRight(CStr(iHH),2,"0")
	Dim sMM As String = PadRight(CStr(iMM),2,"0")
	Dim strTime As String = $"${sHH}:${sMM}"$
	Return strTime
End Sub

public Sub Rand_DateTime As String
	Dim sDate As String = Rand_Date
	Dim sTime As String = Rand_Time
	Dim sout As String = $"${sDate} ${sTime}"$
	Return sout
End Sub

'convert an object to a string
private Sub CStr(o As Object) As String
	Return "" & o
End Sub


'get the length of the string
private Sub Len(Text As String) As Int
	Return Text.Length
End Sub


private Sub PadRight(Value As String, MaxLen As Int, PadChar As String) As String
	Dim intOrdNoLen As Int = Len(Value)
	Dim i As Int
	For i = 1 To (MaxLen - intOrdNoLen) Step 1
		Value = PadChar & Value
	Next
	Return Value
End Sub

Sub Rand_Money(moneyLength As Int) As Double
	Dim res As String = Rand_PinCode(moneyLength) & "." & Rand_PinCode(2)
	res = MakeMoney(res)
	Return res
End Sub

 
 'Returns a random list value from a LIST 
private Sub RandListValue(ListX As List) As Object
	Return ListX.Get(Rnd(0, ListX.Size -1))
End Sub

Sub Rand_Country_Name As String
	Dim names As List
	names.initialize
	names.add("Afghanistan")
	names.add("Albania")
	names.add("Algeria")
	names.add("American Samoa")
	names.add("Andorra")
	names.add("Angola")
	names.add("Anguilla")
	names.add("Antigua & Barbuda")
	names.add("Argentina")
	names.add("Armenia")
	names.add("Aruba")
	names.add("Australia")
	names.add("Austria")
	names.add("Azerbaijan")
	names.add("Bahamas, The")
	names.add("Bahrain")
	names.add("Bangladesh")
	names.add("Barbados")
	names.add("Belarus")
	names.add("Belgium")
	names.add("Belize")
	names.add("Benin")
	names.add("Bermuda")
	names.add("Bhutan")
	names.add("Bolivia")
	names.add("Bosnia & Herzegovina")
	names.add("Botswana")
	names.add("Brazil")
	names.add("British Virgin Is.")
	names.add("Brunei")
	names.add("Bulgaria")
	names.add("Burkina Faso")
	names.add("Burma")
	names.add("Burundi")
	names.add("Cambodia")
	names.add("Cameroon")
	names.add("Canada")
	names.add("Cape Verde")
	names.add("Cayman Islands")
	names.add("Central African Rep.")
	names.add("Chad")
	names.add("Chile")
	names.add("China")
	names.add("Colombia")
	names.add("Comoros")
	names.add("Congo, Dem. Rep.")
	names.add("Congo, Repub. of the")
	names.add("Cook Islands")
	names.add("Costa Rica")
	names.add("Cote d'Ivoire")
	names.add("Croatia")
	names.add("Cuba")
	names.add("Cyprus")
	names.add("Czech Republic")
	names.add("Denmark")
	names.add("Djibouti")
	names.add("Dominica")
	names.add("Dominican Republic")
	names.add("East Timor")
	names.add("Ecuador")
	names.add("Egypt")
	names.add("El Salvador")
	names.add("Equatorial Guinea")
	names.add("Eritrea")
	names.add("Estonia")
	names.add("Ethiopia")
	names.add("Faroe Islands")
	names.add("Fiji")
	names.add("Finland")
	names.add("France")
	names.add("French Guiana")
	names.add("French Polynesia")
	names.add("Gabon")
	names.add("Gambia, The")
	names.add("Gaza Strip")
	names.add("Georgia")
	names.add("Germany")
	names.add("Ghana")
	names.add("Gibraltar")
	names.add("Greece")
	names.add("Greenland")
	names.add("Grenada")
	names.add("Guadeloupe")
	names.add("Guam")
	names.add("Guatemala")
	names.add("Guernsey")
	names.add("Guinea")
	names.add("Guinea-Bissau")
	names.add("Guyana")
	names.add("Haiti")
	names.add("Honduras")
	names.add("Hong Kong")
	names.add("Hungary")
	names.add("Iceland")
	names.add("India")
	names.add("Indonesia")
	names.add("Iran")
	names.add("Iraq")
	names.add("Ireland")
	names.add("Isle of Man")
	names.add("Israel")
	names.add("Italy")
	names.add("Jamaica")
	names.add("Japan")
	names.add("Jersey")
	names.add("Jordan")
	names.add("Kazakhstan")
	names.add("Kenya")
	names.add("Kiribati")
	names.add("Korea, North")
	names.add("Korea, South")
	names.add("Kuwait")
	names.add("Kyrgyzstan")
	names.add("Laos")
	names.add("Latvia")
	names.add("Lebanon")
	names.add("Lesotho")
	names.add("Liberia")
	names.add("Libya")
	names.add("Liechtenstein")
	names.add("Lithuania")
	names.add("Luxembourg")
	names.add("Macau")
	names.add("Macedonia")
	names.add("Madagascar")
	names.add("Malawi")
	names.add("Malaysia")
	names.add("Maldives")
	names.add("Mali")
	names.add("Malta")
	names.add("Marshall Islands")
	names.add("Martinique")
	names.add("Mauritania")
	names.add("Mauritius")
	names.add("Mayotte")
	names.add("Mexico")
	names.add("Micronesia, Fed. St.")
	names.add("Moldova")
	names.add("Monaco")
	names.add("Mongolia")
	names.add("Montserrat")
	names.add("Morocco")
	names.add("Mozambique")
	names.add("Namibia")
	names.add("Nauru")
	names.add("Nepal")
	names.add("Netherlands")
	names.add("Netherlands Antilles")
	names.add("New Caledonia")
	names.add("New Zealand")
	names.add("Nicaragua")
	names.add("Niger")
	names.add("Nigeria")
	names.add("N. Mariana Islands")
	names.add("Norway")
	names.add("Oman")
	names.add("Pakistan")
	names.add("Palau")
	names.add("Panama")
	names.add("Papua New Guinea")
	names.add("Paraguay")
	names.add("Peru")
	names.add("Philippines")
	names.add("Poland")
	names.add("Portugal")
	names.add("Puerto Rico")
	names.add("Qatar")
	names.add("Reunion")
	names.add("Romania")
	names.add("Russia")
	names.add("Rwanda")
	names.add("Saint Helena")
	names.add("Saint Kitts & Nevis")
	names.add("Saint Lucia")
	names.add("St Pierre & Miquelon")
	names.add("Saint Vincent and the Grenadines")
	names.add("Samoa")
	names.add("San Marino")
	names.add("Sao Tome & Principe")
	names.add("Saudi Arabia")
	names.add("Senegal")
	names.add("Serbia")
	names.add("Seychelles")
	names.add("Sierra Leone")
	names.add("Singapore")
	names.add("Slovakia")
	names.add("Slovenia")
	names.add("Solomon Islands")
	names.add("Somalia")
	names.add("South Africa")
	names.add("Spain")
	names.add("Sri Lanka")
	names.add("Sudan")
	names.add("Suriname")
	names.add("Swaziland")
	names.add("Sweden")
	names.add("Switzerland")
	names.add("Syria")
	names.add("Taiwan")
	names.add("Tajikistan")
	names.add("Tanzania")
	names.add("Thailand")
	names.add("Togo")
	names.add("Tonga")
	names.add("Trinidad & Tobago")
	names.add("Tunisia")
	names.add("Turkey")
	names.add("Turkmenistan")
	names.add("Turks & Caicos Is")
	names.add("Tuvalu")
	names.add("Uganda")
	names.add("Ukraine")
	names.add("United Arab Emirates")
	names.add("United Kingdom")
	names.add("United States")
	names.add("Uruguay")
	names.add("Uzbekistan")
	names.add("Vanuatu")
	names.add("Venezuela")
	names.add("Vietnam")
	names.add("Virgin Islands")
	names.add("Wallis and Futuna")
	names.add("West Bank")
	names.add("Western Sahara")
	names.add("Yemen")
	names.add("Zambia")
	names.add("Zimbabwe")
	Return RandListValue(names)
End Sub

public Sub Rand_Street_Type As String
	Dim names As List
	names.Initialize
	names.Add("Abbey")
	names.Add("Acres")
	names.Add("Alley")
	names.Add("Annex")
	names.Add("Arcade")
	names.Add("Autoroute")
	names.Add("Avenue")
	names.Add("Bay")
	names.Add("Bayou")
	names.Add("Beach")
	names.Add("Bend")
	names.Add("Bluff")
	names.Add("Box")
	names.Add("Bottom")
	names.Add("Boulevard")
	names.Add("Branch")
	names.Add("Bridge")
	names.Add("Brook")
	names.Add("Burg")
	names.Add("Burrow")
	names.Add("By-pass")
	names.Add("Byway")
	names.Add("Camp")
	names.Add("Campus")
	names.Add("Canyon")
	names.Add("Cape")
	names.Add("Carré")
	names.Add("Carrefour")
	names.Add("Castle")
	names.Add("Causeway")
	names.Add("Centre")
	names.Add("Cercle")
	names.Add("Chare")
	names.Add("Chase")
	names.Add("Chemin")
	names.Add("Circle")
	names.Add("Circuit")
	names.Add("Cliffs")
	names.Add("Cliff")
	names.Add("Close")
	names.Add("Club")
	names.Add("Common")
	names.Add("Concession")
	names.Add("Corners")
	names.Add("Corner")
	names.Add("Côte")
	names.Add("Cour")
	names.Add("Cours")
	names.Add("Course")
	names.Add("Court")
	names.Add("Cove")
	names.Add("Creek")
	names.Add("Crescent")
	names.Add("Crest")
	names.Add("Croissant")
	names.Add("Cross")
	names.Add("Crossing")
	names.Add("Crossroads")
	names.Add("Crossroad")
	names.Add("Cul-de-sac")
	names.Add("Curve")
	names.Add("Dale")
	names.Add("Dam")
	names.Add("Dell")
	names.Add("Diagonal")
	names.Add("Diversion")
	names.Add("Divide")
	names.Add("Downs")
	names.Add("Drive")
	names.Add("Échangeur")
	names.Add("End")
	names.Add("Esplanade")
	names.Add("Estates")
	names.Add("Estate")
	names.Add("Expressway")
	names.Add("Extension")
	names.Add("Extensions")
	names.Add("Fall")
	names.Add("Falls")
	names.Add("Farm")
	names.Add("Ferry")
	names.Add("Field")
	names.Add("Fields")
	names.Add("Flat")
	names.add("Flats")
	names.Add("Ford")
	names.Add("Fords")
	names.Add("Forest")
	names.Add("Forge")
	names.Add("Fork")
	names.Add("Fort")
	names.Add("Freeway")
	names.Add("Front")
	names.Add("Gardens")
	names.Add("Gate")
	names.Add("Gateway")
	names.Add("Glade")
	names.Add("Glen")
	names.Add("Glens")
	names.Add("Glenway")
	names.Add("Golfway")
	names.Add("Green")
	names.Add("Grounds")
	names.Add("Grove")
	names.Add("Hall")
	names.Add("Harbour")
	names.Add("Haven")
	names.Add("Heath")
	names.Add("Heights")
	names.Add("Highlands")
	names.Add("Highway")
	names.Add("Hill")
	names.Add("Hollow")
	names.Add("Île")
	names.Add("Impasse")
	names.Add("Inlet")
	names.Add("Island")
	names.Add("Isle")
	names.Add("Junction")
	names.Add("Keep")
	names.Add("Key")
	names.Add("Knoll")
	names.Add("Lake")
	names.Add("Land")
	names.Add("Landing")
	names.Add("Lane")
	names.Add("Light")
	names.Add("Limits")
	names.Add("Line")
	names.Add("Ligne")
	names.Add("Link")
	names.Add("Loaf")
	names.Add("Lock")
	names.Add("Lodge")
	names.Add("Lookout")
	names.Add("Loop")
	names.Add("Mall")
	names.Add("Manor")
	names.Add("Maze")
	names.Add("Meadow")
	names.Add("Mews")
	names.Add("Mill")
	names.Add("Mission")
	names.Add("Montée")
	names.Add("Moor")
	names.Add("Motorway")
	names.Add("Mount")
	names.Add("Mountain")
	names.Add("Neck")
	names.Add("Nene")
	names.Add("Oaks")
	names.Add("Orchard")
	names.Add("Oval")
	names.Add("Overpass")
	names.Add("Parade")
	names.Add("Park")
	names.Add("Parkway")
	names.Add("Pass")
	names.Add("Path")
	names.Add("Pathway")
	names.Add("Peak")
	names.Add("Pike")
	names.Add("Pine")
	names.Add("Place")
	names.Add("Placeway")
	names.Add("Plain")
	names.Add("Plateau")
	names.Add("Plaza")
	names.Add("Point")
	names.Add("Pond")
	names.Add("Port")
	names.Add("Prairie")
	names.Add("Private")
	names.Add("Promenade")
	names.Add("Quai")
	names.Add("Quary")
	names.Add("Quay")
	names.Add("Radial")
	names.Add("Ramp")
	names.Add("Ranch")
	names.Add("Rang")
	names.Add("Range")
	names.Add("Rangée")
	names.Add("Rapid")
	names.Add("Rapids")
	names.Add("Reach")
	names.Add("Rest")
	names.Add("Ridge")
	names.Add("Right of Way")
	names.Add("Rise")
	names.Add("River")
	names.Add("Road")
	names.Add("Rond-point")
	names.Add("Ronde")
	names.Add("Round")
	names.Add("Route")
	names.Add("Row")
	names.Add("Rue")
	names.Add("Ruelle")
	names.Add("Run")
	names.Add("Sentier")
	names.Add("Shoal")
	names.Add("Shores")
	names.Add("Shore")
	names.Add("Sideroad")
	names.Add("Skyway")
	names.Add("Springs")
	names.Add("Spur")
	names.Add("Square")
	names.Add("Station")
	names.Add("Standard")
	names.Add("Stravenue")
	names.Add("Stream")
	names.Add("Street")
	names.Add("Streets")
	names.Add("Stroll")
	names.Add("Subdivision")
	names.Add("Summit")
	names.Add("Terrace")
	names.Add("Thicket")
	names.Add("Throughway")
	names.Add("Tour")
	names.Add("Towers")
	names.Add("Townline")
	names.Add("Trace")
	names.Add("Track")
	names.Add("Trafficway")
	names.Add("Trail")
	names.Add("Tailer")
	names.Add("Tunnel")
	names.Add("Turnabout")
	names.Add("Turnpike")
	names.Add("Two")
	names.Add("Underpass")
	names.Add("Union")
	names.Add("Vale")
	names.Add("Valley")
	names.Add("Via")
	names.Add("View")
	names.Add("Village")
	names.Add("Villa")
	names.Add("Ville")
	names.Add("Vista")
	names.Add("Voie")
	names.Add("Walk")
	names.Add("Walkway")
	names.Add("Wall")
	names.Add("Way")
	names.Add("Well")
	names.Add("Wells")
	names.Add("Wharf")
	names.Add("Wold")
	names.Add("Wood")
	names.Add("Wynd")
	Return RandListValue(names)
End Sub

 
Sub Rand_FirstName As String
	Return Rand_Human_Name
End Sub

Sub Rand_LastName As String
	Return Rand_Human_Name
End Sub
 
 #Region rand_human_name : Generates a random real human name 
 
'Generates a random human name...
'List of Names is
'FROM: https://gist.github.com/subodhghulaxe/8148971
Public Sub Rand_Human_Name As String

	Dim names As List
	names.Initialize

	'Add list of names
 
	names.Add("Abbott")
	names.Add("Acevedo")
	names.Add("Acosta")
	names.Add("Adams")
	names.Add("Adkins")
	names.Add("Aguilar")
	names.Add("Aguirre")
	names.Add("Albert")
	names.Add("Alexander")
	names.Add("Alford")
	names.Add("Allen")
	names.Add("Allison")
	names.Add("Alston")
	names.Add("Alvarado")
	names.Add("Alvarez")
	names.Add("Anderson")
	names.Add("Andrews")
	names.Add("Anthony")
	names.Add("Armstrong")
	names.Add("Arnold")
	names.Add("Ashley")
	names.Add("Atkins")
	names.Add("Atkinson")
	names.Add("Austin")
	names.Add("Avery")
	names.Add("Avila")
	names.Add("Ayala")
	names.Add("Ayers")
	names.Add("Bailey")
	names.Add("Baird")
	names.Add("Baker")
	names.Add("Baldwin")
	names.Add("Ball")
	names.Add("Ballard")
	names.Add("Banks")
	names.Add("Barber")
	names.Add("Barker")
	names.Add("Barlow")
	names.Add("Barnes")
	names.Add("Barnett")
	names.Add("Barr")
	names.Add("Barrera")
	names.Add("Barrett")
	names.Add("Barron")
	names.Add("Barry")
	names.Add("Bartlett")
	names.Add("Barton")
	names.Add("Bass")
	names.Add("Bates")
	names.Add("Battle")
	names.Add("Bauer")
	names.Add("Baxter")
	names.Add("Beach")
	names.Add("Bean")
	names.Add("Beard")
	names.Add("Beasley")
	names.Add("Beck")
	names.Add("Becker")
	names.Add("Bell")
	names.Add("Bender")
	names.Add("Benjamin")
	names.Add("Bennett")
	names.Add("Benson")
	names.Add("Bentley")
	names.Add("Benton")
	names.Add("Berg")
	names.Add("Berger")
	names.Add("Bernard")
	names.Add("Berry")
	names.Add("Best")
	names.Add("Bird")
	names.Add("Bishop")
	names.Add("Black")
	names.Add("Blackburn")
	names.Add("Blackwell")
	names.Add("Blair")
	names.Add("Blake")
	names.Add("Blanchard")
	names.Add("Blankenship")
	names.Add("Blevins")
	names.Add("Bolton")
	names.Add("Bond")
	names.Add("Bonner")
	names.Add("Booker")
	names.Add("Boone")
	names.Add("Booth")
	names.Add("Bowen")
	names.Add("Bowers")
	names.Add("Bowman")
	names.Add("Boyd")
	names.Add("Boyer")
	names.Add("Boyle")
	names.Add("Bradford")
	names.Add("Bradley")
	names.Add("Bradshaw")
	names.Add("Brady")
	names.Add("Branch")
	names.Add("Bray")
	names.Add("Brennan")
	names.Add("Brewer")
	names.Add("Bridges")
	names.Add("Briggs")
	names.Add("Bright")
	names.Add("Britt")
	names.Add("Brock")
	names.Add("Brooks")
	names.Add("Brown")
	names.Add("Browning")
	names.Add("Bruce")
	names.Add("Bryan")
	names.Add("Bryant")
	names.Add("Buchanan")
	names.Add("Buck")
	names.Add("Buckley")
	names.Add("Buckner")
	names.Add("Bullock")
	names.Add("Burch")
	names.Add("Burgess")
	names.Add("Burke")
	names.Add("Burks")
	names.Add("Burnett")
	names.Add("Burns")
	names.Add("Burris")
	names.Add("Burt")
	names.Add("Burton")
	names.Add("Bush")
	names.Add("Butler")
	names.Add("Byers")
	names.Add("Byrd")
	names.Add("Cabrera")
	names.Add("Cain")
	names.Add("Calderon")
	names.Add("Caldwell")
	names.Add("Calhoun")
	names.Add("Callahan")
	names.Add("Camacho")
	names.Add("Cameron")
	names.Add("Campbell")
	names.Add("Campos")
	names.Add("Cannon")
	names.Add("Cantrell")
	names.Add("Cantu")
	names.Add("Cardenas")
	names.Add("Carey")
	names.Add("Carlson")
	names.Add("Carney")
	names.Add("Carpenter")
	names.Add("Carr")
	names.Add("Carrillo")
	names.Add("Carroll")
	names.Add("Carson")
	names.Add("Carter")
	names.Add("Carver")
	names.Add("Case")
	names.Add("Casey")
	names.Add("Cash")
	names.Add("Castaneda")
	names.Add("Castillo")
	names.Add("Castro")
	names.Add("Cervantes")
	names.Add("Chambers")
	names.Add("Chan")
	names.Add("Chandler")
	names.Add("Chaney")
	names.Add("Chang")
	names.Add("Chapman")
	names.Add("Charles")
	names.Add("Chase")
	names.Add("Chavez")
	names.Add("Chen")
	names.Add("Cherry")
	names.Add("Christensen")
	names.Add("Christian")
	names.Add("Church")
	names.Add("Clark")
	names.Add("Clarke")
	names.Add("Clay")
	names.Add("Clayton")
	names.Add("Clements")
	names.Add("Clemons")
	names.Add("Cleveland")
	names.Add("Cline")
	names.Add("Cobb")
	names.Add("Cochran")
	names.Add("Coffey")
	names.Add("Cohen")
	names.Add("Cole")
	names.Add("Coleman")
	names.Add("Collier")
	names.Add("Collins")
	names.Add("Colon")
	names.Add("Combs")
	names.Add("Compton")
	names.Add("Conley")
	names.Add("Conner")
	names.Add("Conrad")
	names.Add("Contreras")
	names.Add("Conway")
	names.Add("Cook")
	names.Add("Cooke")
	names.Add("Cooley")
	names.Add("Cooper")
	names.Add("Copeland")
	names.Add("Cortez")
	names.Add("Cote")
	names.Add("Cotton")
	names.Add("Cox")
	names.Add("Craft")
	names.Add("Craig")
	names.Add("Crane")
	names.Add("Crawford")
	names.Add("Crosby")
	names.Add("Cross")
	names.Add("Cruz")
	names.Add("Cummings")
	names.Add("Cunningham")
	names.Add("Curry")
	names.Add("Curtis")
	names.Add("Dale")
	names.Add("Dalton")
	names.Add("Daniel")
	names.Add("Daniels")
	names.Add("Daugherty")
	names.Add("Davenport")
	names.Add("David")
	names.Add("Davidson")
	names.Add("Davis")
	names.Add("Dawson")
	names.Add("Day")
	names.Add("Dean")
	names.Add("Decker")
	names.Add("Dejesus")
	names.Add("Delacruz")
	names.Add("Delaney")
	names.Add("Deleon")
	names.Add("Delgado")
	names.Add("Dennis")
	names.Add("Diaz")
	names.Add("Dickerson")
	names.Add("Dickson")
	names.Add("Dillard")
	names.Add("Dillon")
	names.Add("Dixon")
	names.Add("Dodson")
	names.Add("Dominguez")
	names.Add("Donaldson")
	names.Add("Donovan")
	names.Add("Dorsey")
	names.Add("Dotson")
	names.Add("Douglas")
	names.Add("Downs")
	names.Add("Doyle")
	names.Add("Drake")
	names.Add("Dudley")
	names.Add("Duffy")
	names.Add("Duke")
	names.Add("Duncan")
	names.Add("Dunlap")
	names.Add("Dunn")
	names.Add("Duran")
	names.Add("Durham")
	names.Add("Dyer")
	names.Add("Eaton")
	names.Add("Edwards")
	names.Add("Elliott")
	names.Add("Ellis")
	names.Add("Ellison")
	names.Add("Emerson")
	names.Add("England")
	names.Add("English")
	names.Add("Erickson")
	names.Add("Espinoza")
	names.Add("Estes")
	names.Add("Estrada")
	names.Add("Evans")
	names.Add("Everett")
	names.Add("Ewing")
	names.Add("Farley")
	names.Add("Farmer")
	names.Add("Farrell")
	names.Add("Faulkner")
	names.Add("Ferguson")
	names.Add("Fernandez")
	names.Add("Ferrell")
	names.Add("Fields")
	names.Add("Figueroa")
	names.Add("Finch")
	names.Add("Finley")
	names.Add("Fischer")
	names.Add("Fisher")
	names.Add("Fitzgerald")
	names.Add("Fitzpatrick")
	names.Add("Fleming")
	names.Add("Fletcher")
	names.Add("Flores")
	names.Add("Flowers")
	names.Add("Floyd")
	names.Add("Flynn")
	names.Add("Foley")
	names.Add("Forbes")
	names.Add("Ford")
	names.Add("Foreman")
	names.Add("Foster")
	names.Add("Fowler")
	names.Add("Fox")
	names.Add("Francis")
	names.Add("Franco")
	names.Add("Frank")
	names.Add("Franklin")
	names.Add("Franks")
	names.Add("Frazier")
	names.Add("Frederick")
	names.Add("Freeman")
	names.Add("French")
	names.Add("Frost")
	names.Add("Fry")
	names.Add("Frye")
	names.Add("Fuentes")
	names.Add("Fuller")
	names.Add("Fulton")
	names.Add("Gaines")
	names.Add("Gallagher")
	names.Add("Gallegos")
	names.Add("Galloway")
	names.Add("Gamble")
	names.Add("Garcia")
	names.Add("Gardner")
	names.Add("Garner")
	names.Add("Garrett")
	names.Add("Garrison")
	names.Add("Garza")
	names.Add("Gates")
	names.Add("Gay")
	names.Add("Gentry")
	names.Add("George")
	names.Add("Gibbs")
	names.Add("Gibson")
	names.Add("Gilbert")
	names.Add("Giles")
	names.Add("Gill")
	names.Add("Gillespie")
	names.Add("Gilliam")
	names.Add("Gilmore")
	names.Add("Glass")
	names.Add("Glenn")
	names.Add("Glover")
	names.Add("Goff")
	names.Add("Golden")
	names.Add("Gomez")
	names.Add("Gonzales")
	names.Add("Gonzalez")
	names.Add("Good")
	names.Add("Goodman")
	names.Add("Goodwin")
	names.Add("Gordon")
	names.Add("Gould")
	names.Add("Graham")
	names.Add("Grant")
	names.Add("Graves")
	names.Add("Gray")
	names.Add("Green")
	names.Add("Greene")
	names.Add("Greer")
	names.Add("Gregory")
	names.Add("Griffin")
	names.Add("Griffith")
	names.Add("Grimes")
	names.Add("Gross")
	names.Add("Guerra")
	names.Add("Guerrero")
	names.Add("Guthrie")
	names.Add("Gutierrez")
	names.Add("Guy")
	names.Add("Guzman")
	names.Add("Hahn")
	names.Add("Hale")
	names.Add("Haley")
	names.Add("Hall")
	names.Add("Hamilton")
	names.Add("Hammond")
	names.Add("Hampton")
	names.Add("Hancock")
	names.Add("Haney")
	names.Add("Hansen")
	names.Add("Hanson")
	names.Add("Hardin")
	names.Add("Harding")
	names.Add("Hardy")
	names.Add("Harmon")
	names.Add("Harper")
	names.Add("Harrell")
	names.Add("Harrington")
	names.Add("Harris")
	names.Add("Harrison")
	names.Add("Hart")
	names.Add("Hartman")
	names.Add("Harvey")
	names.Add("Hatfield")
	names.Add("Hawkins")
	names.Add("Hayden")
	names.Add("Hayes")
	names.Add("Haynes")
	names.Add("Hays")
	names.Add("Head")
	names.Add("Heath")
	names.Add("Hebert")
	names.Add("Henderson")
	names.Add("Hendricks")
	names.Add("Hendrix")
	names.Add("Henry")
	names.Add("Hensley")
	names.Add("Henson")
	names.Add("Herman")
	names.Add("Hernandez")
	names.Add("Herrera")
	names.Add("Herring")
	names.Add("Hess")
	names.Add("Hester")
	names.Add("Hewitt")
	names.Add("Hickman")
	names.Add("Hicks")
	names.Add("Higgins")
	names.Add("Hill")
	names.Add("Hines")
	names.Add("Hinton")
	names.Add("Hobbs")
	names.Add("Hodge")
	names.Add("Hodges")
	names.Add("Hoffman")
	names.Add("Hogan")
	names.Add("Holcomb")
	names.Add("Holden")
	names.Add("Holder")
	names.Add("Holland")
	names.Add("Holloway")
	names.Add("Holman")
	names.Add("Holmes")
	names.Add("Holt")
	names.Add("Hood")
	names.Add("Hooper")
	names.Add("Hoover")
	names.Add("Hopkins")
	names.Add("Hopper")
	names.Add("Horn")
	names.Add("Horne")
	names.Add("Horton")
	names.Add("House")
	names.Add("Houston")
	names.Add("Howard")
	names.Add("Howe")
	names.Add("Howell")
	names.Add("Hubbard")
	names.Add("Huber")
	names.Add("Hudson")
	names.Add("Huff")
	names.Add("Huffman")
	names.Add("Hughes")
	names.Add("Hull")
	names.Add("Humphrey")
	names.Add("Hunt")
	names.Add("Hunter")
	names.Add("Hurley")
	names.Add("Hurst")
	names.Add("Hutchinson")
	names.Add("Hyde")
	names.Add("Ingram")
	names.Add("Irwin")
	names.Add("Jackson")
	names.Add("Jacobs")
	names.Add("Jacobson")
	names.Add("James")
	names.Add("Jarvis")
	names.Add("Jefferson")
	names.Add("Jenkins")
	names.Add("Jennings")
	names.Add("Jensen")
	names.Add("Jimenez")
	names.Add("Johns")
	names.Add("Johnson")
	names.Add("Johnston")
	names.Add("Jones")
	names.Add("Jordan")
	names.Add("Joseph")
	names.Add("Joyce")
	names.Add("Joyner")
	names.Add("Juarez")
	names.Add("Justice")
	names.Add("Kane")
	names.Add("Kaufman")
	names.Add("Keith")
	names.Add("Keller")
	names.Add("Kelley")
	names.Add("Kelly")
	names.Add("Kemp")
	names.Add("Kennedy")
	names.Add("Kent")
	names.Add("Kerr")
	names.Add("Key")
	names.Add("Kidd")
	names.Add("Kim")
	names.Add("King")
	names.Add("Kinney")
	names.Add("Kirby")
	names.Add("Kirk")
	names.Add("Kirkland")
	names.Add("Klein")
	names.Add("Kline")
	names.Add("Knapp")
	names.Add("Knight")
	names.Add("Knowles")
	names.Add("Knox")
	names.Add("Koch")
	names.Add("Kramer")
	names.Add("Lamb")
	names.Add("Lambert")
	names.Add("Lancaster")
	names.Add("Landry")
	names.Add("Lane")
	names.Add("Lang")
	names.Add("Langley")
	names.Add("Lara")
	names.Add("Larsen")
	names.Add("Larson")
	names.Add("Lawrence")
	names.Add("Lawson")
	names.Add("Le")
	names.Add("Leach")
	names.Add("Leblanc")
	names.Add("Lee")
	names.Add("Leon")
	names.Add("Leonard")
	names.Add("Lester")
	names.Add("Levine")
	names.Add("Levy")
	names.Add("Lewis")
	names.Add("Lindsay")
	names.Add("Lindsey")
	names.Add("Little")
	names.Add("Livingston")
	names.Add("Lloyd")
	names.Add("Logan")
	names.Add("Long")
	names.Add("Lopez")
	names.Add("Lott")
	names.Add("Love")
	names.Add("Lowe")
	names.Add("Lowery")
	names.Add("Lucas")
	names.Add("Luna")
	names.Add("Lynch")
	names.Add("Lynn")
	names.Add("Lyons")
	names.Add("Macdonald")
	names.Add("Macias")
	names.Add("Mack")
	names.Add("Madden")
	names.Add("Maddox")
	names.Add("Maldonado")
	names.Add("Malone")
	names.Add("Mann")
	names.Add("Manning")
	names.Add("Marks")
	names.Add("Marquez")
	names.Add("Marsh")
	names.Add("Marshall")
	names.Add("Martin")
	names.Add("Martinez")
	names.Add("Mason")
	names.Add("Massey")
	names.Add("Mathews")
	names.Add("Mathis")
	names.Add("Matthews")
	names.Add("Maxwell")
	names.Add("May")
	names.Add("Mayer")
	names.Add("Maynard")
	names.Add("Mayo")
	names.Add("Mays")
	names.Add("Mcbride")
	names.Add("Mccall")
	names.Add("Mccarthy")
	names.Add("Mccarty")
	names.Add("Mcclain")
	names.Add("Mcclure")
	names.Add("Mcconnell")
	names.Add("Mccormick")
	names.Add("Mccoy")
	names.Add("Mccray")
	names.Add("Mccullough")
	names.Add("Mcdaniel")
	names.Add("Mcdonald")
	names.Add("Mcdowell")
	names.Add("Mcfadden")
	names.Add("Mcfarland")
	names.Add("Mcgee")
	names.Add("Mcgowan")
	names.Add("Mcguire")
	names.Add("Mcintosh")
	names.Add("Mcintyre")
	names.Add("Mckay")
	names.Add("Mckee")
	names.Add("Mckenzie")
	names.Add("Mckinney")
	names.Add("Mcknight")
	names.Add("Mclaughlin")
	names.Add("Mclean")
	names.Add("Mcleod")
	names.Add("Mcmahon")
	names.Add("Mcmillan")
	names.Add("Mcneil")
	names.Add("Mcpherson")
	names.Add("Meadows")
	names.Add("Medina")
	names.Add("Mejia")
	names.Add("Melendez")
	names.Add("Melton")
	names.Add("Mendez")
	names.Add("Mendoza")
	names.Add("Mercado")
	names.Add("Mercer")
	names.Add("Merrill")
	names.Add("Merritt")
	names.Add("Meyer")
	names.Add("Meyers")
	names.Add("Michael")
	names.Add("Middleton")
	names.Add("Miles")
	names.Add("Miller")
	names.Add("Mills")
	names.Add("Miranda")
	names.Add("Mitchell")
	names.Add("Molina")
	names.Add("Monroe")
	names.Add("Montgomery")
	names.Add("Montoya")
	names.Add("Moody")
	names.Add("Moon")
	names.Add("Mooney")
	names.Add("Moore")
	names.Add("Morales")
	names.Add("Moran")
	names.Add("Moreno")
	names.Add("Morgan")
	names.Add("Morin")
	names.Add("Morris")
	names.Add("Morrison")
	names.Add("Morrow")
	names.Add("Morse")
	names.Add("Morton")
	names.Add("Moses")
	names.Add("Mosley")
	names.Add("Moss")
	names.Add("Mueller")
	names.Add("Mullen")
	names.Add("Mullins")
	names.Add("Munoz")
	names.Add("Murphy")
	names.Add("Murray")
	names.Add("Myers")
	names.Add("Nash")
	names.Add("Navarro")
	names.Add("Neal")
	names.Add("Nelson")
	names.Add("Newman")
	names.Add("Newton")
	names.Add("Nguyen")
	names.Add("Nichols")
	names.Add("Nicholson")
	names.Add("Nielsen")
	names.Add("Nieves")
	names.Add("Nixon")
	names.Add("Noble")
	names.Add("Noel")
	names.Add("Nolan")
	names.Add("Norman")
	names.Add("Norris")
	names.Add("Norton")
	names.Add("Nunez")
	names.Add("Obrien")
	names.Add("Ochoa")
	names.Add("Oconnor")
	names.Add("Odom")
	names.Add("Odonnell")
	names.Add("Oliver")
	names.Add("Olsen")
	names.Add("Olson")
	names.Add("Oneal")
	names.Add("Oneil")
	names.Add("Oneill")
	names.Add("Orr")
	names.Add("Ortega")
	names.Add("Ortiz")
	names.Add("Osborn")
	names.Add("Osborne")
	names.Add("Owen")
	names.Add("Owens")
	names.Add("Pace")
	names.Add("Pacheco")
	names.Add("Padilla")
	names.Add("Page")
	names.Add("Palmer")
	names.Add("Park")
	names.Add("Parker")
	names.Add("Parks")
	names.Add("Parrish")
	names.Add("Parsons")
	names.Add("Pate")
	names.Add("Patel")
	names.Add("Patrick")
	names.Add("Patterson")
	names.Add("Patton")
	names.Add("Paul")
	names.Add("Payne")
	names.Add("Pearson")
	names.Add("Peck")
	names.Add("Pena")
	names.Add("Pennington")
	names.Add("Perez")
	names.Add("Perkins")
	names.Add("Perry")
	names.Add("Peters")
	names.Add("Petersen")
	names.Add("Peterson")
	names.Add("Petty")
	names.Add("Phelps")
	names.Add("Phillips")
	names.Add("Pickett")
	names.Add("Pierce")
	names.Add("Pittman")
	names.Add("Pitts")
	names.Add("Pollard")
	names.Add("Poole")
	names.Add("Pope")
	names.Add("Porter")
	names.Add("Potter")
	names.Add("Potts")
	names.Add("Powell")
	names.Add("Powers")
	names.Add("Pratt")
	names.Add("Preston")
	names.Add("Price")
	names.Add("Prince")
	names.Add("Pruitt")
	names.Add("Puckett")
	names.Add("Pugh")
	names.Add("Quinn")
	names.Add("Ramirez")
	names.Add("Ramos")
	names.Add("Ramsey")
	names.Add("Randall")
	names.Add("Randolph")
	names.Add("Rasmussen")
	names.Add("Ratliff")
	names.Add("Ray")
	names.Add("Raymond")
	names.Add("Reed")
	names.Add("Reese")
	names.Add("Reeves")
	names.Add("Reid")
	names.Add("Reilly")
	names.Add("Reyes")
	names.Add("Reynolds")
	names.Add("Rhodes")
	names.Add("Rice")
	names.Add("Rich")
	names.Add("Richard")
	names.Add("Richards")
	names.Add("Richardson")
	names.Add("Richmond")
	names.Add("Riddle")
	names.Add("Riggs")
	names.Add("Riley")
	names.Add("Rios")
	names.Add("Rivas")
	names.Add("Rivera")
	names.Add("Rivers")
	names.Add("Roach")
	names.Add("Robbins")
	names.Add("Roberson")
	names.Add("Roberts")
	names.Add("Robertson")
	names.Add("Robinson")
	names.Add("Robles")
	names.Add("Rocha")
	names.Add("Rodgers")
	names.Add("Rodriguez")
	names.Add("Rodriquez")
	names.Add("Rogers")
	names.Add("Rojas")
	names.Add("Rollins")
	names.Add("Roman")
	names.Add("Romero")
	names.Add("Rosa")
	names.Add("Rosales")
	names.Add("Rosario")
	names.Add("Rose")
	names.Add("Ross")
	names.Add("Roth")
	names.Add("Rowe")
	names.Add("Rowland")
	names.Add("Roy")
	names.Add("Ruiz")
	names.Add("Rush")
	names.Add("Russell")
	names.Add("Russo")
	names.Add("Rutledge")
	names.Add("Ryan")
	names.Add("Salas")
	names.Add("Salazar")
	names.Add("Salinas")
	names.Add("Sampson")
	names.Add("Sanchez")
	names.Add("Sanders")
	names.Add("Sandoval")
	names.Add("Sanford")
	names.Add("Santana")
	names.Add("Santiago")
	names.Add("Santos")
	names.Add("Sargent")
	names.Add("Saunders")
	names.Add("Savage")
	names.Add("Sawyer")
	names.Add("Schmidt")
	names.Add("Schneider")
	names.Add("Schroeder")
	names.Add("Schultz")
	names.Add("Schwartz")
	names.Add("Scott")
	names.Add("Sears")
	names.Add("Sellers")
	names.Add("Serrano")
	names.Add("Sexton")
	names.Add("Shaffer")
	names.Add("Shannon")
	names.Add("Sharp")
	names.Add("Sharpe")
	names.Add("Shaw")
	names.Add("Shelton")
	names.Add("Shepard")
	names.Add("Shepherd")
	names.Add("Sheppard")
	names.Add("Sherman")
	names.Add("Shields")
	names.Add("Short")
	names.Add("Silva")
	names.Add("Simmons")
	names.Add("Simon")
	names.Add("Simpson")
	names.Add("Sims")
	names.Add("Singleton")
	names.Add("Skinner")
	names.Add("Slater")
	names.Add("Sloan")
	names.Add("Small")
	names.Add("Smith")
	names.Add("Snider")
	names.Add("Snow")
	names.Add("Snyder")
	names.Add("Solis")
	names.Add("Solomon")
	names.Add("Sosa")
	names.Add("Soto")
	names.Add("Sparks")
	names.Add("Spears")
	names.Add("Spence")
	names.Add("Spencer")
	names.Add("Stafford")
	names.Add("Stanley")
	names.Add("Stanton")
	names.Add("Stark")
	names.Add("Steele")
	names.Add("Stein")
	names.Add("Stephens")
	names.Add("Stephenson")
	names.Add("Stevens")
	names.Add("Stevenson")
	names.Add("Stewart")
	names.Add("Stokes")
	names.Add("Stone")
	names.Add("Stout")
	names.Add("Strickland")
	names.Add("Strong")
	names.Add("Stuart")
	names.Add("Suarez")
	names.Add("Sullivan")
	names.Add("Summers")
	names.Add("Sutton")
	names.Add("Swanson")
	names.Add("Sweeney")
	names.Add("Sweet")
	names.Add("Sykes")
	names.Add("Talley")
	names.Add("Tanner")
	names.Add("Tate")
	names.Add("Taylor")
	names.Add("Terrell")
	names.Add("Terry")
	names.Add("Thomas")
	names.Add("Thompson")
	names.Add("Thornton")
	names.Add("Tillman")
	names.Add("Todd")
	names.Add("Torres")
	names.Add("Townsend")
	names.Add("Tran")
	names.Add("Travis")
	names.Add("Trevino")
	names.Add("Trujillo")
	names.Add("Tucker")
	names.Add("Turner")
	names.Add("Tyler")
	names.Add("Tyson")
	names.Add("Underwood")
	names.Add("Valdez")
	names.Add("Valencia")
	names.Add("Valentine")
	names.Add("Valenzuela")
	names.Add("Vance")
	names.Add("Vang")
	names.Add("Vargas")
	names.Add("Vasquez")
	names.Add("Vaughan")
	names.Add("Vaughn")
	names.Add("Vazquez")
	names.Add("Vega")
	names.Add("Velasquez")
	names.Add("Velazquez")
	names.Add("Velez")
	names.Add("Villarreal")
	names.Add("Vincent")
	names.Add("Vinson")
	names.Add("Wade")
	names.Add("Wagner")
	names.Add("Walker")
	names.Add("Wall")
	names.Add("Wallace")
	names.Add("Waller")
	names.Add("Walls")
	names.Add("Walsh")
	names.Add("Walter")
	names.Add("Walters")
	names.Add("Walton")
	names.Add("Ward")
	names.Add("Ware")
	names.Add("Warner")
	names.Add("Warren")
	names.Add("Washington")
	names.Add("Waters")
	names.Add("Watkins")
	names.Add("Watson")
	names.Add("Watts")
	names.Add("Weaver")
	names.Add("Webb")
	names.Add("Weber")
	names.Add("Webster")
	names.Add("Weeks")
	names.Add("Weiss")
	names.Add("Welch")
	names.Add("Wells")
	names.Add("West")
	names.Add("Wheeler")
	names.Add("Whitaker")
	names.Add("White")
	names.Add("Whitehead")
	names.Add("Whitfield")
	names.Add("Whitley")
	names.Add("Whitney")
	names.Add("Wiggins")
	names.Add("Wilcox")
	names.Add("Wilder")
	names.Add("Wiley")
	names.Add("Wilkerson")
	names.Add("Wilkins")
	names.Add("Wilkinson")
	names.Add("William")
	names.Add("Williams")
	names.Add("Williamson")
	names.Add("Willis")
	names.Add("Wilson")
	names.Add("Winters")
	names.Add("Wise")
	names.Add("Witt")
	names.Add("Wolf")
	names.Add("Wolfe")
	names.Add("Wong")
	names.Add("Wood")
	names.Add("Woodard")
	names.Add("Woods")
	names.Add("Woodward")
	names.Add("Wooten")
	names.Add("Workman")
	names.Add("Wright")
	names.Add("Wyatt")
	names.Add("Wynn")
	names.Add("Yang")
	names.Add("Yates")
	names.Add("York")
	names.Add("Young")
	names.Add("Zamora")
	names.Add("Zimmerman")
 
	Return RandListValue(names)
 
End Sub

'Generates a random human full name
Public Sub Rand_Full_Name As String
	
	Return Rand_Human_Name & " " & Rand_Human_Name
	
End Sub

 #End Region

#Region Human Gender

'Generates a random human Gender and Types
'between MALE or FEMALE only!
Public Sub Rand_Gender As String
	Dim Genders As List
	Genders.Initialize
	Genders.AddAll(Array As String("Male","Female"))
	Genders = ExplodeList(Genders,6)
	Return RandListValue(Genders)
End Sub

private Sub ExplodeList(lst As List, runs As Int) As List
	Dim nList As List
	nList.Initialize
	Dim oCnt As Int
	For oCnt = 1 To runs
		nList.AddAll(lst)
	Next
	nList = ShuffleList(nList)
	Return nList
End Sub

#Region GenderTypesList: A Full list of Gender Types

'Returns a List of the Most accepted Genders in the world
'This list does not contain MALE or FEMALE just Gender Types
'FROM: http://genderfluidsupport.tumblr.com/gender
Public Sub GenderTypesList As List
	
	Dim GenderTypes As List
	GenderTypes.Initialize
	
	GenderTypes.Add("Abimegender")
	GenderTypes.Add("Adamasgender")
	GenderTypes.Add("Aerogender")
	GenderTypes.Add("Aesthetigender")
	GenderTypes.Add("Affectugender")
	GenderTypes.Add("Agender")
	GenderTypes.Add("Agenderflux")

	GenderTypes.Add("Alexigender")
	GenderTypes.Add("Aliusgender")
	GenderTypes.Add("Amaregender")
	GenderTypes.Add("Ambigender")
	GenderTypes.Add("Ambonec")
	GenderTypes.Add("Amicagender")
	GenderTypes.Add("Androgyne")
	GenderTypes.Add("Anesigender")

	GenderTypes.Add("Angenital")
	GenderTypes.Add("Anogender")
	GenderTypes.Add("Anongender")
	GenderTypes.Add("Antegender")
	GenderTypes.Add("Anxiegender")
	GenderTypes.Add("Apagender")
	GenderTypes.Add("Apconsugender")
	GenderTypes.Add("Astergender")
	GenderTypes.Add("Astralgender")

	GenderTypes.Add("Autigender")
	GenderTypes.Add("Autogender")
	GenderTypes.Add("Axigender")
	GenderTypes.Add("Bigender")
	GenderTypes.Add("Biogender")
	GenderTypes.Add("Blurgender")
	GenderTypes.Add("Boyflux")
	GenderTypes.Add("Burstgender")
	GenderTypes.Add("Caelgender")

	GenderTypes.Add("Cassgender")
	GenderTypes.Add("Cassflux")
	GenderTypes.Add("Cavusgender")
	GenderTypes.Add("Cendgender")
	GenderTypes.Add("Ceterofluid")
	GenderTypes.Add("Ceterogender")
	GenderTypes.Add("Cisgender")
	GenderTypes.Add("Cloudgender")
	GenderTypes.Add("Collgender")

	GenderTypes.Add("Colorgender")
	GenderTypes.Add("Commogender")
	GenderTypes.Add("Condigender")
	GenderTypes.Add("Deliciagender")
	GenderTypes.Add("Demifluid")
	GenderTypes.Add("Demiflux")
	GenderTypes.Add("Demigender")
	GenderTypes.Add("Domgender")
	GenderTypes.Add("Demi-vapor")

	GenderTypes.Add("Demi-smoke")
	GenderTypes.Add("Duragender")
	GenderTypes.Add("Egogender")
	GenderTypes.Add("Epicene")
	GenderTypes.Add("Espigender")
	GenderTypes.Add("Exgender")
	GenderTypes.Add("Existigender")

	GenderTypes.Add("Female")
	GenderTypes.Add("Femfluid")
	GenderTypes.Add("Femgender")
	GenderTypes.Add("Fluidflux")
	GenderTypes.Add("Gemigender")
	GenderTypes.Add("Genderblank")
	GenderTypes.Add("Genderflow")
	GenderTypes.Add("Genderfluid")

	GenderTypes.Add("Genderflux")
	GenderTypes.Add("Genderfuzz")
	GenderTypes.Add("Gender Neutral")
	GenderTypes.Add("Genderpunk")
	GenderTypes.Add("Genderqueer")
	GenderTypes.Add("Genderwitched")
	GenderTypes.Add("Girlflux")
	GenderTypes.Add("Glassgender")

	GenderTypes.Add("Glimragender")
	GenderTypes.Add("Greygender")
	GenderTypes.Add("Gyragender")
	GenderTypes.Add("Healgender")
	GenderTypes.Add("Heliogender")
	GenderTypes.Add("Hemigender")
	GenderTypes.Add("Horogender")
	GenderTypes.Add("Hydrogender")

	GenderTypes.Add("Imperigender")
	GenderTypes.Add("Intergender")
	GenderTypes.Add("Juxera")
	GenderTypes.Add("Libragender")
	GenderTypes.Add("Male")
	GenderTypes.Add("Magigender")
	GenderTypes.Add("Mascfluid")
	GenderTypes.Add("Mascgender")

	GenderTypes.Add("Maverique")
	GenderTypes.Add("Mirrorgender")
	GenderTypes.Add("Molligender")
	GenderTypes.Add("Multigender")
	GenderTypes.Add("Nanogender")
	GenderTypes.Add("Neutrois")
	GenderTypes.Add("Nonbinary")

	GenderTypes.Add("Omnigender")
	GenderTypes.Add("Oneirogender")
	GenderTypes.Add("Pangender")
	GenderTypes.Add("Paragender")
	GenderTypes.Add("Perigender")
	GenderTypes.Add("Polygender")
	GenderTypes.Add("Proxvir")

	GenderTypes.Add("Quoigender")
	GenderTypes.Add("Subgender")
	GenderTypes.Add("Surgender")
	GenderTypes.Add("Systemgender")
	GenderTypes.Add("Tragender")
	GenderTypes.Add("Transgender")
	GenderTypes.Add("Transneutral")

	GenderTypes.Add("Trigender")
	GenderTypes.Add("Vapogender")
	GenderTypes.Add("Venngender")
	GenderTypes.Add("Verangender")
	GenderTypes.Add("Vibragender")
	GenderTypes.Add("Vocigender")
	
	Return GenderTypes
	 
End Sub

#End Region
 
'Generates a random Gender Type 
'Refer to fullGenderTypesList() 
Public Sub Rand_Gender_Type As String
	 
	Return RandListValue(GenderTypesList)
	
End Sub

 #End Region

Sub Rand_LoremIpsum(count As Int) As String
	Dim str As String = $"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."$
	Dim sb As StringBuilder
	sb.Initialize
	For i = 1 To count
		sb.Append(str).Append(CRLF)
	Next
	Return sb.tostring
End Sub

Sub Rand_Word(count As Int) As String
	Dim words As List
	words.Initialize
	words.AddAll(Array("Lorem", "ipsum", "dolor", "sit" ,"amet", "consectetur", "adipisicing", "elit"))
	words.AddAll(Array("sed", "do", "eiusmod" ,"tempor", "incididunt", "ut", "labore", "et", "dolore", "magna", "aliqua"))
	words.AddAll(Array("Ut", "enim", "ad" ,"minim", "veniam", "quis", "nostrud", "exercitation", "ullamco", "laboris"))
	words.AddAll(Array("nisi", "ut", "aliquip", "ex" ,"ea", "commodo", "consequat"))
	words.AddAll(Array("Duis", "aute", "irure", "dolor", "in", "reprehenderit", "in", "voluptate", "velit", "esse", "cillum"))
	words.AddAll(Array("dolore", "eu", "fugiat", "nulla", "pariatur"))
	words.AddAll(Array("Excepteur", "sint", "occaecat", "cupidatat", "non", "proident", "sunt", "in", "culpa"))
	words.AddAll(Array("qui", "officia", "deserunt", "mollit","anim","id","est","laborum"))
	words = ExplodeList(words,5)
	Dim st As StringBuilder
	st.Initialize
  	For i = 1 To count
 		st.Append(RandListValue(words) & " ")
 	Next
	Dim sout As String = st.ToString
	sout = sout.trim
  	Return sout
End Sub

#Region Random Dummy Text
'Generates a random lorem ispum text
'ParagraphCount =   Is the number of paragraphs to generate
Public Sub Rand_Lorem_Ipsum(ParagraphCount  As Int) As String

	Dim textList As List
	textList.Initialize
 
	textList.Add("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
	textList.Add("Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
	textList.Add("Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
	textList.Add("Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
	textList = ExplodeList(textList,3)
	     
	Dim st As StringBuilder
	st.Initialize
  
	For i = 1 To ParagraphCount
 
		st.Append(RandListValue(textList) & " ")
 
	Next
  
	Return st.ToString

End Sub

'Generates a random dummy text (lorem ispum)
'ParagraphCount =   Is the number of paragraphs to generate
'Alias of lorem_ispum()
Public Sub Rand_Dummy_Text(ParagraphCount  As Int) As String
 
	Return Rand_Lorem_Ipsum(ParagraphCount)
 
End Sub
 
 #End Region
 
 #Region Random Email Generators
 'Generates a random email
Public Sub Rand_Email(EmailProvider As String, withNumeric As Boolean) As String
	 
	Dim sname As String = Rand_Human_Name & "." & Rand_Human_Name
	sname = sname.ToLowerCase
	
	If withNumeric Then
	 	
		Return  sname & Rnd(10, 3000) & "@" & EmailProvider
		
	Else
			
		Return sname & "@" & EmailProvider
			
	End If
	
End Sub

Sub Rand_Twitter As String
	Return "@" & Rand_Human_Name
End Sub

Sub Rand_HashTag As String
	Return "#" & Rand_Human_Name
End Sub

'Generates a random Gmail address
'withNumeric = should gmail contain suffixed numbers
'EG demo_20@gmail.com
'Quick shortcut Alias of rand_email()
Public Sub Rand_Gmail(withNumeric As Boolean) As String
	 
	Return Rand_Email("gmail.com", withNumeric)
	
End Sub

'Generates a random Yahoo email address
'withNumeric = should gmail contain suffixed numbers
'EG demo_20@yahoo.com
'Quick shortcut Alias of rand_email()
Public Sub Rand_Yahoo_Mail(withNumeric As Boolean) As String
	 
	Return Rand_Email("yahoo.com", withNumeric)
	
End Sub

#End Region 

#Region Random phone number
'Generates a random phone number
'CountryCode = the Country Code to use without the + ; for example,
'Nigeria is 234, USA is 1 and Indian is 91
'ilength = This is how long should the remaining part of the number be
Public Sub Rand_Phone_Number(CountryCode As Int , ilength As Int) As String
	
	Return "+" & CountryCode & Rand_PinCode(ilength)
	 
End Sub
 
'Generates a random phone number
'CountryCode = the Country Code to use without the + ; for example,
'Nigeria is 234, USA is 1 and Indian is 91
'startsWith = what custom number should phone number start with?
'ilength = This is how long should the remaining part of the number be
'<code> 'Example: would output something like; +2348174795280
'log(CF_DataGeneratorUtility.rand_phoneNumber2(234, 817, 7))
'</code>
Public Sub Rand_Phone_Number2(CountryCode As Int , istartsWith As Int, ilength As Int) As String
	
	Return "+" & CountryCode & istartsWith & Rand_PinCode(ilength)
	 
End Sub

#End Region

#Region Random True or False Value 

'Generates a random True or False Value
Public Sub Rand_True_Or_False As Boolean
	 
	If Rnd( Rnd(1, 5), Rnd(6, 10))  < 6 Then
		
		Return True
		
	Else
			
		Return False
			
	End If
	 
End Sub

'Generates a random True or False Value
'Alias of Rand_True_Or_False()
Public Sub Rand_Boolean_Value As Boolean
	 
	Return Rand_True_Or_False
	 
End Sub

#End Region
 
'Generates a random IP address
Public Sub Rand_Ip_Address As String
	 
	Return  Rnd(190, 230) & "." & Rnd(13, 200) & "." & Rnd(50, 200) & "." & Rnd(75, 200)
	
End Sub

#Region Sports Data Generators

'List of Major Sports around the world
'NOTE: this list is not A-Z of all sports
private Sub MajorSportsList As List
	
	Dim sports As List
	sports.Initialize
	
	sports.add("Alpine Skiing")
	sports.add("Athletics")
	sports.add("Badminton")
	sports.add("Basketball")
	sports.add("Bocce")
	sports.add("Bowling")

	sports.add("Cricket")
	sports.add("Cross Country Skiing")
	sports.add("Cycling")
	sports.add("Equestrian")
	sports.add("Figure Skating")
	sports.add("Floorball")

	sports.add("Floor Hockey")
	sports.add("Football")
	sports.add("Golf")
	sports.add("Gymnastics Artistic")
	sports.add("Gymnastics Rhythmic")
	sports.add("Handball")

	sports.add("Judo")
	sports.add("Kayaking")
	sports.add("Motor Activity Training Program")
	sports.add("Netball")
	sports.add("Open Water Swimming")
	sports.add("Powerlifting")
	sports.add("Roller Skating")

	sports.add("Sailing")
	sports.add("Short Track Speed Skating")
	sports.add("Snowboarding")
	sports.add("Snowshoeing")
 
	sports.add("Softball")
	sports.add("Swimming")
	sports.add("Table Tennis")
	sports.add("Tennis")
	sports.add("Triathlon")
	sports.add("Volleyball")

	Return sports
	
End Sub

'Generates a random sport name
Public Sub Rand_Sport_Name() As String
	
	Return RandListValue(MajorSportsList)
	
End Sub

#End Region
 
'Generates a random home address
'using a street address format
Public Sub Rand_Home_Address As String
	Dim sStreet As String = Rand_Street_Type
	Return  $"${Rnd(1, 999)} ${Rand_Human_Name} ${sStreet}"$
End Sub

'Generates a random home address
'using an Estate house address format
Public Sub Rand_Home_Address2 As String
	 
	Return  $"Block ${Rnd(1, 130)} flat ${Rnd(1, 10)}, ${Rand_Human_Name} Estate"$
	
End Sub
  
'Generates a random company name
Public Sub Rand_Company_Name As String
	 
	Dim values As List
	values.Initialize
	
	values.AddAll(Array("Technologies", "& Sons","Clothings","Softwares","Enterprises"))
	values.AddAll(Array("Industries","System","Inc","Motors","& Co.", "Foods","Properties"))
	values.AddAll(Array("Brands","Digital","Logistics","Holdings","Labs"))
	
	Return  Rand_Human_Name & " " & RandListValue(values)
	
End Sub
 
'Generates a random job Occupation
Public Sub Rand_Occupation As String
	 
	Dim values As List
	values.Initialize
	
	values.AddAll(Array("Cleaner", "Make-up artist","Cashier","Banker","Manager"))
	values.AddAll(Array("Dentist","Doctor","Teacher","Web Developer","Lawyer", "Assistant","Sales man"))
	values.AddAll(Array("Graphics Designer","Digital Marketer","Musician","Blogger","Bartender"))
	
	Return RandListValue(values)
	
End Sub

Sub Rand_Capital_City As String
	Dim names As List
	names.initialize
	names.add("﻿Kabul")
	names.add("Tiranë (Tirana)")
	names.add("El Djazaïr  (Algiers)")
	names.add("Pago Pago")
	names.add("Andorra la Vella")
	names.add("Luanda")
	names.add("The Valley")
	names.add("St. John's")
	names.add("Buenos Aires")
	names.add("Yerevan")
	names.add("Oranjestad")
	names.add("Canberra")
	names.add("Wien (Vienna)")
	names.add("Baku")
	names.add("Nassau")
	names.add("Al-Manamah (Manama)")
	names.add("Dhaka")
	names.add("Bridgetown")
	names.add("Minsk")
	names.add("Bruxelles-Brussel")
	names.add("Belmopan")
	names.add("Cotonou")
	names.add("Porto-Novo")
	names.add("Hamilton")
	names.add("Thimphu")
	names.add("La Paz")
	names.add("Sucre")
	names.add("Sarajevo")
	names.add("Gaborone")
	names.add("Brasília")
	names.add("Road Town")
	names.add("Bandar Seri Begawan")
	names.add("Sofia")
	names.add("Ouagadougou")
	names.add("Bujumbura")
	names.add("Praia")
	names.add("Phnum Pénh (Phnom Penh)")
	names.add("Yaoundé")
	names.add("Ottawa-Gatineau")
	names.add("Kralendijk")
	names.add("George Town")
	names.add("Bangui")
	names.add("N'Djaména")
	names.add("St. Helier")
	names.add("St. Peter Port")
	names.add("Santiago")
	names.add("Beijing")
	names.add("Hong Kong")
	names.add("Macao")
	names.add("Bogotá")
	names.add("Moroni")
	names.add("Brazzaville")
	names.add("Rarotonga")
	names.add("San José")
	names.add("Abidjan")
	names.add("Yamoussoukro")
	names.add("Zagreb")
	names.add("La Habana (Havana)")
	names.add("Willemstad")
	names.add("Lefkosia (Nicosia)")
	names.add("Praha (Prague)")
	names.add("P'yongyang")
	names.add("Kinshasa")
	names.add("København (Copenhagen)")
	names.add("Djibouti")
	names.add("Roseau")
	names.add("Santo Domingo")
	names.add("Quito")
	names.add("Al-Qahirah (Cairo)")
	names.add("San Salvador")
	names.add("Malabo")
	names.add("Asmara")
	names.add("Tallinn")
	names.add("Addis Ababa")
	names.add("Stanley")
	names.add("Tórshavn")
	names.add("Suva")
	names.add("Helsinki")
	names.add("Paris")
	names.add("Cayenne")
	names.add("Papeete")
	names.add("Libreville")
	names.add("Banjul")
	names.add("Tbilisi")
	names.add("Berlin")
	names.add("Accra")
	names.add("Gibraltar")
	names.add("Athínai (Athens)")
	names.add("Nuuk (Godthåb)")
	names.add("St.George's")
	names.add("Basse-Terre")
	names.add("Hagåtña")
	names.add("Ciudad de Guatemala (Guatemala City)")
	names.add("Conakry")
	names.add("Bissau")
	names.add("Georgetown")
	names.add("Port-au-Prince")
	names.add("Vatican City")
	names.add("Tegucigalpa")
	names.add("Budapest")
	names.add("Reykjavík")
	names.add("Delhi")
	names.add("Jakarta")
	names.add("Tehran")
	names.add("Baghdad")
	names.add("Dublin")
	names.add("Douglas")
	names.add("Jerusalem")
	names.add("Roma (Rome)")
	names.add("Kingston")
	names.add("Tokyo")
	names.add("Amman")
	names.add("Astana")
	names.add("Nairobi")
	names.add("Tarawa")
	names.add("Al Kuwayt (Kuwait City)")
	names.add("Bishkek")
	names.add("Vientiane")
	names.add("Riga")
	names.add("Bayrut (Beirut)")
	names.add("Maseru")
	names.add("Monrovia")
	names.add("Tarabulus (Tripoli)")
	names.add("Vaduz")
	names.add("Vilnius")
	names.add("Luxembourg")
	names.add("Antananarivo")
	names.add("Lilongwe")
	names.add("Kuala Lumpur")
	names.add("Male")
	names.add("Bamako")
	names.add("Valletta")
	names.add("Majuro")
	names.add("Fort-de-France")
	names.add("Nouakchott")
	names.add("Port Louis")
	names.add("Mamoudzou")
	names.add("Ciudad de México (Mexico City)")
	names.add("Palikir")
	names.add("Monaco")
	names.add("Ulaanbaatar")
	names.add("Podgorica")
	names.add("Brades Estate")
	names.add("Rabat")
	names.add("Maputo")
	names.add("Nay Pyi Taw")
	names.add("Windhoek")
	names.add("Nauru")
	names.add("Kathmandu")
	names.add("Amsterdam")
	names.add("s-Gravenhage (The Hague)")
	names.add("Nouméa")
	names.add("Wellington")
	names.add("Managua")
	names.add("Niamey")
	names.add("Abuja")
	names.add("Alofi")
	names.add("Saipan")
	names.add("Oslo")
	names.add("Masqat (Muscat)")
	names.add("Islamabad")
	names.add("Koror")
	names.add("Ciudad de Panamá (Panama City)")
	names.add("Port Moresby")
	names.add("Asunción")
	names.add("Lima")
	names.add("Manila")
	names.add("Warszawa (Warsaw)")
	names.add("Lisboa (Lisbon)")
	names.add("San Juan")
	names.add("Ad-Dawhah (Doha)")
	names.add("Seoul")
	names.add("Chisinau")
	names.add("Saint-Denis")
	names.add("Bucuresti (Bucharest)")
	names.add("Moskva (Moscow)")
	names.add("Kigali")
	names.add("Jamestown")
	names.add("Basseterre")
	names.add("Castries")
	names.add("Saint-Pierre")
	names.add("Kingstown")
	names.add("Apia")
	names.add("San Marino")
	names.add("São Tomé")
	names.add("Ar-Riyadh (Riyadh)")
	names.add("Dakar")
	names.add("Beograd (Belgrade)")
	names.add("Victoria")
	names.add("Freetown")
	names.add("Singapore")
	names.add("Philipsburg")
	names.add("Bratislava")
	names.add("Ljubljana")
	names.add("Honiara")
	names.add("Muqdisho (Mogadishu)")
	names.add("Bloemfontein")
	names.add("Cape Town")
	names.add("Pretoria")
	names.add("Juba")
	names.add("Madrid")
	names.add("Colombo")
	names.add("Sri Jayewardenepura Kotte")
	names.add("Ramallah")
	names.add("Al-Khartum (Khartoum)")
	names.add("Paramaribo")
	names.add("Mbabane")
	names.add("Stockholm")
	names.add("Bern")
	names.add("Dimashq (Damascus)")
	names.add("Dushanbe")
	names.add("Skopje")
	names.add("Krung Thep (Bangkok)")
	names.add("Dili")
	names.add("Lomé")
	names.add("Tokelau")
	names.add("Nuku'alofa")
	names.add("Port of Spain")
	names.add("Tunis")
	names.add("Ankara")
	names.add("Ashgabat")
	names.add("Cockburn Town")
	names.add("Funafuti")
	names.add("Kampala")
	names.add("Kyiv (Kiev)")
	names.add("Abu Zaby (Abu Dhabi)")
	names.add("London")
	names.add("Dodoma")
	names.add("Washington, D.C.")
	names.add("Charlotte Amalie")
	names.add("Montevideo")
	names.add("Tashkent")
	names.add("Port Vila")
	names.add("Caracas")
	names.add("Hà Noi")
	names.add("Matu-Utu")
	names.add("El Aaiún")
	names.add("Sana'a'")
	names.add("Lusaka")
	names.add("Harare")
	Return RandListValue(names)
End Sub

'Generates a random job title
Public Sub Rand_Job_Title As String
	  
	Return Rand_Occupation

End Sub
 
'convert a string to monetary format
private Sub MakeMoney(sValue As String) As String
	If sValue.Length = 0 Then Return "0.00"
	If sValue = "null" Then sValue = "0.00"
	sValue = sValue.Replace(",","")
	sValue = Val(sValue)
	If sValue = "0" Then sValue = "000"
	sValue = Round2(sValue,2)
	Return NumberFormat2(sValue, 1, 2, 2, True)
End Sub

'extract all numeric values from a string
Public Sub Val(value As String) As String
	Try
		value = value.Trim
		If value = "" Then value = "0"
		Dim sout As String = ""
		Dim mout As String = ""
		Dim slen As Int = value.Length
		Dim i As Int = 0
		For i = 0 To slen - 1
			mout = value.CharAt(i)
			If InStr("0123456789.-", mout) <> -1 Then
				sout = sout & mout
			End If
		Next
		Return sout + 0
	Catch
		Return value
	End Try
End Sub

private Sub InStr(Text As String, sFind As String) As Int
	Return Text.tolowercase.IndexOf(sFind.tolowercase)
End Sub

  
	