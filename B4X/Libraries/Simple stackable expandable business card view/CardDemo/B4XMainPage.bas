B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private clv1 As CustomListView
	Private CornerPanel As B4XView
	Private pnlTitle As B4XView
	Private lblTitle As B4XView
	Private pnlExpanded As B4XView
	
	Private expandable As CLVExpandableCards
	Private colorMap As Map
	Private textColors As List
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	colorMap.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	Sleep(100)
	
	expandable.Initialize(clv1)

	'List of colors that I want to allow the BestTextColor sub to use
	'In this demo, the generated color palette for the names will
	'likely mean that Black & White dominate the results 
	textColors.Initialize
	textColors.Add(xui.Color_White)
	textColors.Add(xui.Color_Black)
	textColors.Add(xui.Color_LightGray)
	textColors.Add(xui.Color_DarkGray)
	textColors.Add(xui.Color_Blue)
	textColors.Add(xui.Color_Yellow)
	
	'Demo names randomly generated. 
	Dim names As List
	names.Initialize
	names.AddAll(Array As String( _
    "Alice Thornton", "Ben McAllister", "Carla Donovan", "David Fletcher", "Ella Jennings", _
    "Frank Rhodes", "Grace Pritchard", "Henry Wallace", "Isla Bennett", "Jack Emerson", _
    "Kara Whitman", "Liam Granger", "Mona Ellis", "Noah Whitaker", "Olive Carmichael", _
    "Paul Redmond", "Quinn Mathers", "Rita Holloway", "Samuel Drake", "Tina Langford", _
    "Victor Henson", "Wendy Slater", "Xavier Brooks", "Yasmin Cole", "Zachary Ingram", _
    "Amber Saunders", "Brian Whittaker", "Chloe Doran", "Derek Malone", "Eva Sinclair", _
    "Freddie Lovell", "Georgia Harper", "Harvey McLean", "Imogen Talbot", "Jake Norris", _
    "Kelsey Bartlett", "Leo Burgess", "Maya Caldwell", "Nathan Rowe", "Orla Swift", _
    "Patrick Hodge", "Quincy Doyle", "Rebecca Fenton", "Simon Bell", "Tori Hamilton", _
    "Umar Fielding", "Vera Hart", "Willis Madden", "Xena Curran", "Yusuf Brant", _
    "Zoe Redpath", "Aidan Lister", "Bella Simmonds", "Callum Yorke", "Daisy Abbott", _
    "Elliot Napier", "Faith Rankin", "Gavin Sherwood", "Hannah Drury", "Isaac Hearn", _
    "Jade Vickers", "Kyle Oakley", "Lola Preece", "Miles Kavanagh", "Nina Hadley", _
    "Owen Sayers", "Phoebe Gower", "Rory Aldridge", "Sophie Murtagh", "Tyler Beecham", _
    "Una Franks", "Vanessa Ogden", "Warren Clancy", "Xander Hoyle", "Yara Beck", _
    "Zane Cartwright", "Aimee Kenyon", "Blake Sutherland", "Caitlin Groves", "Dylan Moffatt", _
    "Erin Headley", "Finn Dalrymple", "Gemma Rourke", "Harry Broughton", "India Neale", _
    "Jayden Furlong", "Keira Latham", "Louis Rix", "Matilda Sayers", "Nathaniel Coates", _
    "Ophelia Mears", "Parker Hanley", "Rowan Craddock", "Scarlett Ames", "Toby Lister", _
    "Ursula Tait", "Vince Colton", "Willow Fenwick", "Xanthe Prior", "Yvonne Clay", _
    "Zeke Millar" ))
	
	For i = 1 To 100
		'Mapping the colors so we don't have to wait for the CLV to catch up
		Dim prevColor As Int = colorMap.GetDefault (i-1, xui.Color_Transparent)
		Dim r As Int = StringToColor (names.Get (i-1))
		colorMap.Put (i, r)
		Dim p As B4XView = CreateItem(r, prevColor, names.Get(i-1), Rnd(100dip, 300dip) + 60dip)
		clv1.Add(p, expandable.CreateValue(p, i))
		expandable.CollapseItem (i-1, prevColor)
	Next
End Sub


Sub CreateItem(clr As Int, pclr As Int, Title As String, ExpandedHeight As Int) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, clv1.AsView.Width, ExpandedHeight)
	p.LoadLayout("Item")
	p.SetLayoutAnimated(0, 0, 0, p.Width, p.GetView(0).Height) 'resize it to the collapsed height
	lblTitle.Text = Title
	pnlTitle.Color = clr
	lblTitle.TextColor = BestTextColor (clr, textColors)
	pnlExpanded.Color = clr
	CornerPanel.Color = pclr
	Return p
End Sub

Sub clv1_ItemClick (Index As Int, Value As Object)
	expandable.ToggleItem(Index, colorMap.GetDefault (Index , xui.Color_Transparent))
End Sub

'Used in CLVExpandable demo - left here for posterity
Sub ShadeColor(clr As Int) As Int	'ignore
	Dim argb() As Int = GetARGB(clr)
	Dim factor As Float = 0.75
	Return xui.Color_RGB(argb(1) * factor, argb(2) * factor, argb(3) * factor)
End Sub


#Region Get best text colorMap

' Takes a given background color and figures out which one of a supplied list of
' colors gives the best contrast color for writing text on it

Sub BestTextColor(bgColor As Int, options As List) As Int
	Dim maxContrast As Float = -1
	Dim bestColor As Int = xui.Color_Black

	For Each tc As Int In options
		Dim c As Float = ContrastRatio(bgColor, tc)
		If c > maxContrast Then
			maxContrast = c
			bestColor = tc
		End If
	Next

	Return bestColor
End Sub

Sub ContrastRatio(c1 As Int, c2 As Int) As Float
	Dim l1 As Float = RelativeLuminance(c1)
	Dim l2 As Float = RelativeLuminance(c2)
	If l1 > l2 Then
		Return (l1 + 0.05) / (l2 + 0.05)
	Else
		Return (l2 + 0.05) / (l1 + 0.05)
	End If
End Sub

Sub RelativeLuminance(color As Int) As Float
	Dim r As Float = (Bit.And(Bit.ShiftRight(color, 16), 0xFF)) / 255
	Dim g As Float = (Bit.And(Bit.ShiftRight(color, 8), 0xFF)) / 255
	Dim b As Float = (Bit.And(color, 0xFF)) / 255

	r = IIf(r <= 0.03928, r / 12.92, Power((r + 0.055) / 1.055, 2.4))
	g = IIf(g <= 0.03928, g / 12.92, Power((g + 0.055) / 1.055, 2.4))
	b = IIf(b <= 0.03928, b / 12.92, Power((b + 0.055) / 1.055, 2.4))

	Return 0.2126 * r + 0.7152 * g + 0.0722 * b
End Sub

#End Region

#region Generate a repeatable color from a text string

'Something a bit different from simply choosing a random color -
'Each persons name is fed into an algorithm that produces a repeatable color
'associated with their name

Sub StringToColor(name As String) As Int
	Dim hash As Long = 0
	For i = 0 To name.Length - 1
		Dim ch As String = name.SubString2(i, i + 1)
		hash = Bit.Xor(hash, Asc(ch))
		hash = Bit.ShiftLeft(hash, 5) - hash + Asc(ch)  
	Next
	hash = Abs(hash)

	Dim hue As Float = hash Mod 360
	Dim sat As Float = 0.6 + (hash Mod 40) / 100   
	Dim val As Float = 0.75 + ((hash / 3) Mod 25) / 100   

	Return HSVToColor(hue, sat, val)
End Sub

Sub GetARGB(Color As Int) As Int()
	Private res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

Sub HSVToColor(H As Float, S As Float, V As Float) As Int
	Dim r, g, b As Float
	Dim i As Int = Floor(H / 60) Mod 6
	Dim f As Float = (H / 60) - Floor(H / 60)
	Dim p As Float = V * (1 - S)
	Dim q As Float = V * (1 - f * S)
	Dim t As Float = V * (1 - (1 - f) * S)

	Select i
		Case 0
			r = V : g = t : b = p
		Case 1
			r = q : g = V : b = p
		Case 2
			r = p : g = V : b = t
		Case 3
			r = p : g = q : b = V
		Case 4
			r = t : g = p : b = V
		Case 5
			r = V : g = p : b = q
	End Select
	
	Dim red As Int = r * 255
	Dim green As Int = g * 255
	Dim blue As Int = b * 255
	Dim alpha As Int = 255
	
	Dim color As Int = Bit.Or(Bit.ShiftLeft(alpha, 24), Bit.ShiftLeft(red, 16))
	color = Bit.Or(color, Bit.ShiftLeft(green, 8))
	color = Bit.Or(color, blue)
	
	Return color
End Sub

#End Region
