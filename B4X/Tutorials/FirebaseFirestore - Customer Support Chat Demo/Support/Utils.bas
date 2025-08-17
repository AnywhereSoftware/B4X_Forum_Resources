B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
'Static code module
Sub Process_Globals
	#if b4j
	Private fx As JFX
	#End If
	Private xui As XUI
End Sub

Public Sub Categories As List
	Dim c As List
	c.Initialize
	c.Add("Apartments")
	c.Add("Shop")
	c.Add("Repairs & Construction")
	c.Add("Vehicles")
	c.Add("Office Space")
	c.Add("Hostels")
	c.Add("Electronic Appliance")
	c.Add("Events & Outdoor")
	Return c
End Sub

Public Sub Regions As List
	Dim R As List
	R.Initialize
	R.Add("Ashanti")
	R.Add("Brong-Ahafo")
	R.Add("Central")
	R.Add("Eastern")
	R.Add("Greater Accra")
	R.Add("Northern")
	R.Add("Upper East")
	R.Add("Upper West")
	R.Add("Volta")
	R.Add("Western")
	R.Add("Western North")
	R.Add("Oti")
	R.Add("Savannah")
	R.Add("North East")
	R.Add("Bono")
	R.Add("Ahafo")	
	Return R
End Sub

Public Sub Amenities As List
	Dim A As List 
	A.Initialize
	A.Initialize
	A.Add("Air Condition")
	A.Add("Wi-Fi")
	A.Add("TV")
	A.Add("Kitchen")
	A.Add("Restaurant")
	A.Add("Hotel")
	A.Add("Hospital")
	A.Add("School")
	A.Add("Supermarket")
	A.Add("Bank")
	A.Add("Park")
	A.Add("Gym")
	A.Add("Pharmacy")
	A.Add("Library")
	A.Add("Coffee Shop")
	A.Add("Gas Station")
	A.Add("Post Office")
	A.Add("Police Station")
	A.Add("Barbershop")
	A.Add("Laundry")
	Return A
End Sub

Public Sub ServiceTypes As List
	Dim ST As List
	ST.Initialize
	ST.Add("Plumbing")
	ST.Add("Electrical")
	ST.Add("Carpentry")
	ST.Add("Painting")
	ST.Add("Roofing")
	ST.Add("Masonry")
	ST.Add("HVAC")
	ST.Add("Flooring")
	ST.Add("Tiling")
	ST.Add("Welding")
	ST.Add("Fencing")
	ST.Add("Concrete Work")
	ST.Add("Drywall")
	ST.Add("Demolition")
	ST.Add("Renovation")
	Return ST
End Sub
Public Sub EventServiceTypes As List
	Dim ST As List
	ST.Initialize
	ST.Add("Catering")
	ST.Add("Event Planning")
	ST.Add("Venue Rental")
	ST.Add("Audio/Visual Services")
	ST.Add("Decoration")
	ST.Add("Photography")
	ST.Add("Videography")
	ST.Add("Entertainment")
	ST.Add("Security Services")
	ST.Add("Transportation")
	ST.Add("Ticketing Services")
	ST.Add("Staffing")
	Return ST
End Sub
Public Sub EngineTypes As List
	Dim ET As List
	ET.Initialize
	ET.Add("Inline 4-cylinder")
	ET.Add("V6")
	ET.Add("V8")
	ET.Add("Inline 6-cylinder")
	ET.Add("Electric")
	ET.Add("Hybrid")
	Return ET
End Sub
Public Sub CarBodyTypes As List
	Dim CB As List
	CB.Initialize
	CB.Add("Sedan")
	CB.Add("SUV")
	CB.Add("Hatchback")
	CB.Add("Coupe")
	CB.Add("Convertible")
	CB.Add("Wagon")
	CB.Add("Van")
	CB.Add("Truck")
	CB.Add("Minivan")
	CB.Add("Pickup")
	CB.Add("Crossover")
	CB.Add("Roadster")
	CB.Add("Limousine")
	CB.Add("Compact")
	CB.Add("Sports Car")
	CB.Add("Off-road Vehicle")
	CB.Add("MPV (Multi-Purpose Vehicle)")
	CB.Add("Station Wagon")
	CB.Add("Buggy")
	CB.Add("Microcar")
	CB.Add("Targa Top")
	Return CB
End Sub
Public Sub FuelTypes As List
	Dim FT As List
	FT.Initialize
	FT.Add("Gasoline")
	FT.Add("Diesel")
	FT.Add("Electric")
	FT.Add("Hybrid")
	Return FT
End Sub
public Sub EventTypes As List
	Dim ET As List
	ET.Initialize
	ET.Add("Birthday")
	ET.Add("Naming Ceremony")
	ET.Add("Conference")
	ET.Add("Funeral")
	ET.Add("Seminar")
	ET.Add("Workshop")
	ET.Add("Webinar")
	ET.Add("Trade Show")
	ET.Add("Exhibition")
	ET.Add("Symposium")
	ET.Add("Summit")
	ET.Add("Panel Discussion")
	ET.Add("Networking Event")
	ET.Add("Meeting")
	ET.Add("Convention")
	ET.Add("Training")
	ET.Add("Gala")
	ET.Add("Festival")
	ET.Add("Concert")
	ET.Add("Sporting Event")
	ET.Add("Charity Event")    
	Return ET
End Sub
public Sub DurationTypes As List
	Dim DT As List
	DT.Initialize
	DT.Add("Hourly")
	DT.Add("Daily")
	DT.Add("Weekly")
	DT.Add("Bi-weekly")
	DT.Add("Monthly")
	DT.Add("Quarterly")
	DT.Add("Semi-annually")
	DT.Add("Annually")
	Return DT
End Sub

Public Sub DurationName(Duration As String) As String
	Select Duration
		Case "Annually"
			Return "per year"
		Case "Year"
			Return "per year"
		Case "Month"
			Return "per month"
		Case "Monthly"
			Return "per month"
		Case "Hourly"
			Return "per hour"
		Case "Daily"
			Return "per day"
		Case "Weekly"
			Return "per week"
		Case Else
			Return "For Sale"
	End Select
End Sub

Public Sub ParseContact(Contact As String, CountryCode As String)	As String
	Contact = Contact.Replace(" ","").Replace("-","").Replace(".","").Replace("E8","").Replace("E11","").Trim
	If Contact.StartsWith("0") == True Then
		Contact = CountryCode&Contact.SubString2(1,Contact.Length)
	Else if Contact.StartsWith(CountryCode) == False And Contact.StartsWith("0") == False And Contact.StartsWith("+") == False Then
		Contact = CountryCode&Contact
	End If
			
	If Contact.StartsWith("+") == False Then
		Contact = "+"&Contact
	End If
	Return Contact
End Sub

Public Sub MediaManager	As SimpleMediaManager
	Dim Media As SimpleMediaManager
	Media.Initialize
	Media.AddLocalMedia(Media.KEY_DEFAULT_ERROR, xui.LoadBitmap(File.DirAssets, "error.jpg"), "image/*")
	Media.DefaultErrorRequest.Extra.Put(Media.REQUEST_BACKGROUND, xui.Color_White)
	Media.AddLocalMedia(Media.KEY_DEFAULT_LOADING, File.ReadBytes(File.DirAssets, "loading.gif"), "image/gif")
	Return Media
End Sub

Public Sub MediaManager2 As SimpleMediaManager
	Dim Media As SimpleMediaManager
	Media.Initialize
	Return Media
End Sub

Public Sub SetMediaFromFile(iv As B4XView, Dir As String, FileName As String,MIME As String)
	MediaManager.SetMediaFromFile(iv,Dir,FileName,MIME,CreateMap(MediaManager.REQUEST_RESIZE_MODE:"FILL"))
	MediaManager.TrimMediaCache
End Sub

Public Sub SetMedia(iv As B4XView, Dir As String, Filename As String,MIME As String)
	MediaManager.SetMediaFromFile(iv,Dir,Filename,MIME,CreateMap(MediaManager.REQUEST_RESIZE_MODE:"FILL"))
	MediaManager.TrimMediaCache
	SetCircleClip(iv)
End Sub

Public Sub DownloadMedia(Link As String, iv As B4XView)
	Dim mainpage As B4XMainPage = B4XPages.GetManager.MainPage
	mainpage.DownloadMedia(Link,iv)
End Sub

Public Sub DownloadMedia2(Link As String, iv As B4XView)
	Dim mainpage As B4XMainPage = B4XPages.GetManager.MainPage
	mainpage.DownloadMedia(Link,iv)
	SetCircleClip(iv)
End Sub

Public Sub DownloadMedia3(Link As String, iv As B4XView)
	Dim Path As String
	Path = Link.Replace("https://firebasestorage.googleapis.com/v0/b/"&Main.projectID&".appspot.com/o/","")
	Path = Path.Replace("?alt=media","")
	Path = Path.Replace("/","%2F")
	Dim mainpage As B4XMainPage = B4XPages.GetManager.MainPage
	mainpage.DownloadMedia($"https://firebasestorage.googleapis.com/v0/b/${Main.projectID}.appspot.com/o/${Path}?alt=media"$,iv)
	SetCircleClip(iv)
	iv.SetColorAndBorder(xui.Color_White,0,xui.Color_White,100dip)
End Sub


Public Sub UrlEncodeMap(input As Map) As String
	Dim sb As StringBuilder
	Dim su As StringUtils
	sb.Initialize
	Dim first As Boolean = True
	For Each key In input.Keys
		If Not(first) Then
			sb.Append("&")
		Else
			first = False
		End If
		sb.Append($"${su.EncodeUrl(key, "UTF8")}=${su.EncodeUrl(input.Get(key), "UTF8")}"$)
	Next
	Return sb.ToString
End Sub

Public Sub SetCircleClip (View As B4XView)
#if B4J
    Dim circle As JavaObject
	Dim radius As Double = Max(View.Width / 2, View.Height / 2)
	Dim cx As Double = View.Width / 2
    Dim cy As Double = View.Height / 2
    circle.InitializeNewInstance("javafx.scene.shape.Circle", Array(cx, cy, radius))
	Dim jo As JavaObject = View
    jo.RunMethod("setClip", Array(circle))
#else if B4A
	Dim jo As JavaObject = View
	jo.RunMethod("setClipToOutline", Array(True))
#end if
End Sub


Public Sub LikeAnimationColored(xlbl As B4XView,duration As Int,liked_color As Int,unliked_color As Int)
	Dim txt_size As Float = xlbl.TextSize
	If xlbl.Text = Chr(0xE87E) Then
		xlbl.SetTextSizeAnimated(duration/2,1)
		Sleep(duration/2)
		xlbl.Text = Chr(0xE87D)
		xlbl.TextColor = liked_color
		xlbl.SetTextSizeAnimated(duration/2,txt_size)
	Else
		xlbl.SetTextSizeAnimated(duration/2,1)
		Sleep(duration/2)
		xlbl.Text = Chr(0xE87E)
		xlbl.TextColor = unliked_color
		xlbl.SetTextSizeAnimated(duration/2,txt_size)
	End If
End Sub

Public Sub LikeAnimation(xlbl As B4XView,duration As Int)
	Dim txt_size As Float = xlbl.TextSize
	If xlbl.Text = Chr(0xE87E) Then
		xlbl.SetTextSizeAnimated(duration/2,1)
		Sleep(duration/2)
		xlbl.Text = Chr(0xE87D)
		xlbl.SetTextSizeAnimated(duration/2,txt_size)
	Else
		xlbl.SetTextSizeAnimated(duration/2,1)
		Sleep(duration/2)
		xlbl.Text = Chr(0xE87E)
		xlbl.SetTextSizeAnimated(duration/2,txt_size)
	End If
End Sub

Public Sub CreatePanel(Left As Int, Top As Int, Width As Int, Height As Int, Layout As String) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0,Left,Top,Width,Height)
	p.LoadLayout(Layout)
	Return p
End Sub

Public Sub CreatePanel2(EventName As String ,Left As Int, Top As Int, Width As Int, Height As Int, Layout As String) As B4XView
	Dim p As B4XView = xui.CreatePanel(EventName)
	p.SetLayoutAnimated(0,Left,Top,Width,Height)
	p.LoadLayout(Layout)
	Return p
End Sub

public Sub SearchItems(searchString As String, dataList As List) As List
	Dim searchWords() As String = Regex.Split("\s+", searchString.Trim)
	Dim results As List
	results.Initialize
	If dataList Is List And dataList.IsInitialized And dataList.Size > 0 Then
		For Each item As Map In dataList
			Dim found As Boolean = False
			For Each word As String In searchWords
				Log(word)
				Dim title As String = item.Get("title")
				Dim description As String = item.Get("description")
				Dim category As String = item.Get("category")
				Dim city As String = item.Get("city")
				Dim region As String = item.Get("region")
				If title.ToLowerCase.Contains(word.ToLowerCase) Or _
				description.ToLowerCase.Contains(word.ToLowerCase) Or _
				city.ToLowerCase.Contains(word.ToLowerCase) Or _
				region.ToLowerCase.Contains(word.ToLowerCase) Or _
				category.ToLowerCase.Contains(word.ToLowerCase) Then
					found = True
					Exit
				End If
			Next
			If found Then
				results.Add(item)
			End If
		Next
	End If
	Return results
End Sub

Public Sub CheckFields(Map As Map) As Boolean
	Dim Result As Boolean = True
	For Each k As String In Map.Keys
		If Map.Get(k) == Null Or Map.Get(k) == "" Then
			xui.MsgboxAsync($"${CapitalizeWords(k.Replace("_"," "))} cannot be empty"$,"Required")
			Result = False
			Return Result
			Exit
		End If
	Next
	Return Result
End Sub

public Sub CapitalizeWords(inputString As String) As String
	Dim words() As String = Regex.Split("\s+", inputString.Trim)
	Dim capitalizedString As StringBuilder
	capitalizedString.Initialize
    
	For Each word As String In words
		If word.Length > 0 Then
			Dim firstLetter As String = word.SubString2(0, 1).ToUpperCase
			Dim restOfWord As String = word.SubString(1).ToLowerCase
			Dim capitalizedWord As String = firstLetter & restOfWord
			capitalizedString.Append(capitalizedWord & " ")
		End If
	Next
    
	' Remove trailing space and return the capitalized string
	Return capitalizedString.ToString.Trim
End Sub