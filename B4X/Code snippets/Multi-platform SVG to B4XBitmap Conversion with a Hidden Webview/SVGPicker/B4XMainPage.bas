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

'Source of  material
'https://openmoji.org/

'All emojis are free to use under the CC BY-SA 4.0 license
'https://creativecommons.org/licenses/by-sa/4.0/

Sub Class_Globals 
	Type range(first As Int, last As Int)
	Type KeyValues(key As String, values() As String)
	Private Root As B4XView
	Private xui As XUI
	Private fx As JFX
	Private myDir As String
	Private files As List
	
	Private wv As WebView
	Private cv As B4XCanvas
	Private tPanels(192) As B4XView
	Private cvRect As B4XRect
	
	Private categories As Map
	Private subCats As Map
	Private subcatList As List
	
	Private SLCats As SuperList
End Sub

Public Sub Initialize
	wv.Initialize("wv")
	categories.Initialize
	categories.Put("Functional", Array( _
		newRange(0, 90), _
		newRange(709, 721), _
		newRange(1453, 1467), _
		newRange(1471, 1478), _
		newRange(1483, 1489), _
		newRange(1490, 1512), _
		newRange(1520, 1520), _
		newRange(1532, 1532), _
		newRange(1535, 1556), _
		newRange(1558, 1559), _
		newRange(1569, 1571), _
		newRange(1581, 1581), _
		newRange(1602, 1602), _
		newRange(1611, 1612), _
		newRange(1620, 1623), _
		newRange(1628, 1640), _
		newRange(1679, 1719), _
		newRange(1754, 1759), _
		newRange(1790, 1794), _
		newRange(1795, 1804), _
		newRange(1741, 1743), _
		newRange(1839, 1839), _
		newRange(1841, 1857), _
		newRange(1860, 1860), _
		newRange(1862, 1862), _
		newRange(1881, 1921), _
		newRange(1655, 1666), _
		newRange(1809, 1809), _
		newRange(1811, 1812), _
		newRange(735, 744), _
		newRange(1641, 1648), _
		newRange(1573, 1573), _
		newRange(621, 621), _
		newRange(1025, 1025), _
		newRange(1572, 1572), _
		newRange(1649, 1654), _
		newRange(1026, 1026), _
		newRange(2000, 2004) _
		))
	
	categories.Put("Plants", Array(newRange(136, 154), newRange(343, 343), newRange(1394, 1401)))
	categories.Put("Food", Array(newRange(155, 203), newRange(1107, 1134), newRange(1222, 1233), _
		newRange(1334, 1336), newRange(205, 212), newRange(214, 214), newRange(1094, 1096), _
		newRange(1778, 1789), newRange(1940, 1940), newRange(1957, 1957), newRange(1816, 1822), _
		newRange(133, 135), newRange(204, 215), newRange(1135, 1138), newRange(1414, 1425), newRange(1522, 1522)))
	categories.Put("Party_Games_Sports", Array(newRange(216, 307), newRange(344, 347), newRange(1075, 1093), _
		newRange(1097, 1106), newRange(343, 347), newRange(1313, 1320), newRange(1594, 1599), _
		newRange(279, 279), _
		newRange(282, 282), _
		newRange(290, 290), _
		newRange(293, 293), _
		newRange(296, 296), _
		newRange(1076, 1076), _
		newRange(1079, 1079), _
		newRange(1083, 1083), _
		newRange(1086, 1086), _
		newRange(1089, 1089), _
		newRange(1827, 1827), _
		newRange(1832, 1832), _
		newRange(1280, 1282), _
		newRange(1576, 1577)))
	categories.Put("Buildings_Scenery_Flags", Array(newRange(308, 333), newRange(814, 818), newRange(91, 91), _
		newRange(1586, 1588), newRange(1590, 1590), newRange(93, 97), newRange(99, 99), _
		newRange(1866, 1868), newRange(1870, 1870), newRange(1872, 1879), newRange(1927, 1929), newRange(1932, 1933), _
		newRange(747, 749), newRange(1861, 1861), newRange(1863, 1863), newRange(1737, 1739), newRange(334, 342)))
	categories.Put("Animals", Array(newRange(348, 416), newRange(1155, 1201), newRange(1388, 1342), _
		newRange(783, 784), newRange(1390, 1393), newRange(1404, 1404), newRange(1412, 1412), _
		newRange(1667, 1668), newRange(1670, 1678), newRange(1402, 1402), newRange(1563, 1563)))
	categories.Put("BodyParts_Clothing_StickFigures", Array( _
		newRange(417, 455), newRange(524, 525), newRange(1206, 1209), newRange(1307, 1307), _
		newRange(792, 794), newRange(1028, 1029), newRange(977, 980), _
		newRange(1038, 1044), newRange(1405, 1406), newRange(1435, 1444), newRange(1605, 1608), newRange(1524, 1524), _
		newRange(1150, 1154), newRange(1308, 1312), newRange(778, 778), _
		newRange(1338, 1341), newRange(1364, 1364), newRange(1445, 1452), _		
		newRange(786, 786), _
		newRange(563, 563), newRange(1235, 1238), newRange(1260, 1261), newRange(1283, 1285), newRange(1295, 1296), _
		newRange(1407, 1409), newRange(1721, 1721), newRange(1935, 1936), newRange(1824, 1825), newRange(1949, 1950)))
	categories.Put("People", Array(newRange(456, 523), newRange(526, 551), newRange(557, 562), newRange(1210, 1215), _
		newRange(1234, 1234), newRange(1239, 1241), newRange(1243, 1259), newRange(1262, 1279), _
		newRange(1283, 1282), newRange(1286, 1294), newRange(1297, 1306), _
		newRange(1410, 1410), newRange(1744, 1744), newRange(1720, 1720), newRange(1991, 1992), _
		newRange(1810, 1810), newRange(1826, 1826), newRange(1828, 1831), newRange(1934, 1934), newRange(1953, 1956)))
	categories.Put("Love_Light_Action", Array(newRange(575, 604), newRange(1342, 1344), newRange(1624, 1627)))
	categories.Put("Money_Office_Tools_Clocks", Array(newRange(605, 620), newRange(622, 704), newRange(723, 730), _
		newRange(1360, 1361), newRange(1368, 1370), newRange(787, 791), newRange(1321, 1324), _
		newRange(1327, 1333), newRange(795, 809), newRange(751, 774), _
		newRange(1027, 1027), newRange(705, 706), newRange(708, 708), newRange(1468, 1469), _
		newRange(1005, 1005), newRange(1479, 1482), newRange(1574, 1575), newRange(1582, 1582), _
		newRange(1601, 1601), newRange(1609, 1610), newRange(1993, 1999)))
	categories.Put("Travel_Transportation", Array(newRange(1325, 1326), newRange(981, 1001), _
		newRange(1003, 1004), newRange(1008, 1024), newRange(914, 976), newRange(99, 100), _
		newRange(1835, 1835), newRange(1864, 1864), newRange(1869, 1869), _
		newRange(103, 106), newRange(779, 781), newRange(1592, 1593), newRange(1603, 1603)))
	categories.Put("Emotions", Array(newRange(1139, 1149), newRange(820, 913), newRange(553, 556), _
		 newRange(1030, 1074), newRange(1426, 1434), newRange(1533, 1534), newRange(1923, 1926), newRange(1242, 1242), newRange(552, 552)))
	categories.Put("SunMoon_Weather_Medical_Spa_Religion", Array(newRange(92, 92), newRange(98, 98), newRange(107, 132), _
		newRange(1489, 1489), newRange(1513, 1518), newRange(1521, 1521), newRange(1529, 1529), _
		newRange(1578, 1580), newRange(1589, 1589), newRange(1871, 1871), _
		newRange(1345, 1348), newRange(564, 574), newRange(722, 722), _
		newRange(1525, 1525), newRange(1722, 1736), newRange(1760, 1760), newRange(1764, 1776), newRange(1990, 1990), _
		newRange(1805, 1805), newRange(1563, 1563), newRange(1859, 1860), newRange(1961, 1986), newRange(1987, 1988), newRange(1958, 1960), _
		newRange(731, 734), newRange(745, 746), newRange(750, 750),newRange(775, 776), newRange(1613, 1614)))
	categories.Put("Miscellaneous", Array( _
	newRange(101, 102), _
	newRange(707, 707), _
	newRange(777, 777), _
	newRange(782, 782), _
	newRange(785, 785), _
	newRange(810, 813), _
	newRange(1002, 1002), _
	newRange(1006, 1007), _
	newRange(1202, 1205), _
	newRange(1216, 1221), _
	newRange(1337, 1337), _
	newRange(1349, 1359), _
	newRange(1362, 1367), _
	newRange(1371, 1389), _
	newRange(1403, 1403), _
	newRange(1411, 1411), _
	newRange(1413, 1413), _
	newRange(1470, 1470), _
	newRange(1526, 1531), _
	newRange(1519, 1519), _
	newRange(1523, 1523), _
	newRange(1557, 1557), _
	newRange(1560, 1568), _
	newRange(1583, 1583), _
	newRange(1584, 1584), _
	newRange(1585, 1585), _
	newRange(1591, 1591), _
	newRange(1600, 1600), _
	newRange(1604, 1604), _
	newRange(1615, 1619), _
	newRange(1669, 1669), _
	newRange(1740, 1740), _
	newRange(1745, 1753), _
	newRange(1761, 1763), _
	newRange(1777, 1777), _
	newRange(1806, 1808), _
	newRange(1813, 1815), _
	newRange(1823, 1823), _
	newRange(1833, 1834), _
	newRange(1836, 1838), _
	newRange(1840, 1840), _
	newRange(1858, 1858), _
	newRange(1865, 1865), _
	newRange(1880, 1880), _
	newRange(1922, 1922), _
	newRange(1930, 1931), _
	newRange(1937, 1939), _
	newRange(1941, 1948), _
	newRange(1951, 1951), _
	newRange(1952, 1952), _
	newRange(819, 819), _
	newRange(1989, 1989) _
	))
	subcatList.Initialize
	subCats.initialize
	For Each kw As String In categories.Keys
		Dim v() As String = Regex.Split("\_", kw)
		For j = 0 To v.Length - 1
			subCats.Put(v(j), kw)
			subcatList.Add(v(j))
		Next
	Next
	subcatList.Sort(True)
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.AddView(wv, -Root.Width, 0, Root.Width, Root.Height)
	cv.Initialize(Root)
	cvRect.Initialize(0, 0, Root.Width, Root.Height)
	
	myDir = File.DirApp
	myDir = myDir.SubString2(0, myDir.LastIndexOf("\"))
	myDir = myDir.SubString2(0, myDir.LastIndexOf("\"))
	myDir = myDir.SubString2(0, myDir.LastIndexOf("\"))
	files = File.ListFiles(myDir & "\UemojiFiles")
	Sleep(0)
	SLCats = CreateSuperList(Me, "SLCats")
	SLCats.Title = "Choose Category"
	SLCats.Searchable = True
	For Each fn As String In subcatList
		SLCats.dataList.Add(fn)
	Next
	B4XPages.ShowPage("SLCats")
	Wait For SLCats_Response
	ShowCategory(subCats.get(SLCats.Response))
End Sub

Private Sub ShowCategory(categoryName As String)
	Dim ar() As Object = categories.Get(categoryName)

	cv.ClearRect(cvRect)
	Dim x As Float = 0
	Dim y As Float = 0
	Dim cnt As Int = -1
	For k = 0 To ar.Length - 1
		Dim rng As range = ar(k)
		For i = rng.first To rng.last
			cnt = cnt + 1
			If cnt > 191 Then Exit
			Dim content As String = File.ReadString(myDir & "\UemojiFiles", files.Get(i))
			content = content.Replace($"viewBox="0 0 72 72""$, $"viewBox="0 0 100 100""$)
			wv.LoadHtml(content)
			Sleep(15)
			Dim bm As B4XBitmap = wv.Snapshot
			bm = bm.Crop(0, 0, 600, 600)
			bm = bm.Resize(95, 95, True)
			Dim r As B4XRect
			r.Initialize(x, y, x + bm.Width, y + bm.Height)
			cv.DrawBitmap(bm, r)
			cv.DrawRect(r, xui.Color_Black, False, 1)
			cv.DrawText(i, r.CenterX, r.bottom -2, xui.CreateDefaultFont(12), xui.Color_Black, "CENTER")
			x = x + 100
			If x >= Root.Width Then
				x = 0
				y = y + 100
			End If
			tPanels(cnt) = xui.CreatePanel("tPanel")
			Root.AddView(tPanels(cnt), r.Left, r.Top, r.Width, r.Height)
			tPanels(cnt).Tag = i
		Next
	Next
End Sub

Public Sub newRange (first As Int, last As Int) As range
	Dim t1 As range
	t1.Initialize
	t1.first = first
	t1.last = last
	Return t1
End Sub

'Creates and initializes a list with an array of values. For an empty list, use CreateList(Array()) 
Public Sub CreateList(ar() As Object) As List
	Dim a As List
	a.Initialize
	For Each obj As Object In ar
		a.Add(obj)
	Next
	Return a
End Sub

'Creates a empty SuperList
Public Sub CreateSuperList(callBack_ As Object, eventName As String) As SuperList
	Dim SLX As SuperList
	SLX.Initialize(callBack_, eventName)
	B4XPages.AddPage(eventName, SLX)
	Return SLX
End Sub

Public Sub SLCats_Complete(result As List)
	SLCats.Response = result.Get(0).As(KeyValues).key
	CallSubDelayed(Me, "SLCats_Response")
End Sub

Private Sub tPanel_MouseClicked(Ev As MouseEvent)
	Dim pnl As B4XView = Sender
	Dim content As String = File.ReadString(myDir & "\UemojiFiles", files.Get(pnl.tag))
	content = content.Replace($"viewBox="0 0 72 72""$, $"viewBox="0 0 100 100""$)
	Log(content)
	cv.ClearRect(cvRect)
	wv.LoadHtml(content)
	Sleep(15)
	Dim bm As B4XBitmap = wv.Snapshot
	bm = bm.Crop(0, 0, 600, 600)
	bm = bm.Resize(300, 300, True)
	Dim r As B4XRect
	r.Initialize(0, 0, bm.Width, bm.Height)
	cv.DrawBitmap(bm, r)
	
	fx.Clipboard.SetString(content)
	Dim sf As Object = xui.Msgbox2Async("The Image SVG contents have has been placed on the Clipboard", "Info", "OK", "", "", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
End Sub