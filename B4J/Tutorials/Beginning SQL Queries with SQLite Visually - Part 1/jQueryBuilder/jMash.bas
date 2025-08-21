B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.9
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Private fx As JFX
	Type BtnImage(defaultF As String, overF As String)
	Public Buttons As Map
	Public jSQL As SQL
	Public ffiles As List
	Public ffolders As List
	Public root As String
	Public PhpPath As String
	Private pool As ConnectionPool
	Private SQLite As SQL
	Private DatabaseType As Int
	Public VM As String = Chr(253)
	Private UsePool As Boolean
	Type sequencePair(value As Int, numTimes As Int)
	Private cutils As ControlsUtils
	Private fontawesome As Font
	Private sql1 As SQL
	Private tempFolder = File.DirTemp, tempFile = "key_value_temp.dat" As String
	Private LastMouseCursor As String = "DEFAULT"
	Private tid As Tidy
	Public EmailAddress As String
	'Private Bconv As ByteConverter
	Public EmailAddress As String
	Public LicensePath As String
End Sub

Public Sub ProgressRAG(dVariance As Double) As String
    If dVariance < 0 Then
            Return "../images/red.png"
    else if dVariance > 0 Then
            Return "../images/green.png"
    else if dVariance = 0 Then
            Return "../images/orange.png"
    Else
            Return "../images/gray.png"
    End If
End Sub

Public Sub ExpenditureRAG(dVariance As Double) As String
    If dVariance > 0 Then
        Return "../images/green.png"
    else if dVariance < 0 Then
        Return "../images/red.png"
    else if dVariance = 0 Then
        Return "../images/orange.png"
	Else 
        Return "../images/gray.png"
    End If
End Sub

Public Sub ExpectedRAG(dValue As Double) As String
    If dValue = 0 Then
            Return "../images/orange.png"
    else if dValue > 0 Then
            Return "../images/red.png"
    else if dValue < 0 Then
            Return "../images/green.png"
    Else 
            Return "../images/red.png"
    End If
End Sub

'calculate expected percentage
Sub ExpectedPercentage(pmap As Map) As Map
	DateTime.DateFormat = "yyyy-MM-dd"
	Dim splannedstart As String = pmap.getdefault("plannedstart","")
	Dim splannedfinish As String = pmap.getdefault("plannedfinish","")
	Dim sexpenditure As String = pmap.getdefault("expenditure","")
	Dim sbudget As String = pmap.getdefault("budget","")
	Dim sreportingdate As String = pmap.getdefault("reportingdate","")
	Dim splannedfinish As String = pmap.getdefault("plannedfinish","")
	Dim sactualprogress As Int = pmap.getdefault("actualprogress","")
	
	Dim splannedduration As Int = 0
	Dim spercentageexpenditure As Double = 0 
	Dim spercentageperday As Double = 0
	Dim sreportduration As Int = 0
	Dim sdaysavailable As Int = 0
	Dim sprojectedprogress As Double = 0
	Dim sexpenditurevariance As Double = 0
	Dim sactualprogressperday As Double = 0
	Dim sexpectedprogressperday As Double = 0
	Dim sexpecteddays As Int = 0
	Dim sworkeddays As Int = 0
	Dim saheadbehind As Int = 0
	Dim sexpectedvariance As Int = 0
	Dim spercentageimage As String = "../images/gray.png"
	Dim sbudgetimage As String = "../images/gray.png"
	Dim sexpectedimage As String = "../images/gray.png"
	
	Dim perDuration As Period
	Dim rptDurationStart As Period
	Dim rptDurationFinish As Period
	Dim lps As Long = 0
	Dim lpf As Long = 0
	Dim lrd As Long = 0
	'start calculations
	
	If splannedstart <> "" And splannedfinish <> "" And sreportingdate <> "" Then
		'clear ISO date
		splannedstart = splannedstart.Replace("T"," ")
		splannedfinish = splannedfinish.Replace("T"," ")
		sreportingdate = sreportingdate.Replace("T"," ")
		
		lps = DateTime.DateParse(splannedstart)
		lpf = DateTime.DateParse(splannedfinish)
		lrd = DateTime.DateParse(sreportingdate)
		'period between start and finish date
		perDuration = DateUtils.PeriodBetweenInDays(lps,lpf)
		splannedduration = perDuration.days
		'percentage per day planned
		If splannedduration = 0 Then
			spercentageperday = 0
		Else
			spercentageperday = 100 / splannedduration
		End If
		'period between planned start and reporting date
		rptDurationStart = DateUtils.PeriodBetweenInDays(lps,lrd)
		sreportduration = rptDurationStart.days
		'period between reporting date and planned finish
		rptDurationFinish = DateUtils.PeriodBetweenInDays(lrd,lpf)
		sdaysavailable = rptDurationFinish.Days
		'calculate expected progress
		sprojectedprogress = Val(spercentageperday) * Val(sreportduration)
	    If sdaysavailable > splannedduration Then sdaysavailable = splannedduration
		
		' if reportduration > 0 then
        If sreportduration > 0 Then
        	sprojectedprogress = sreportduration * spercentageperday
			sprojectedprogress = Round(sprojectedprogress)
        End If
        ' if planned if after report date, percentage expected = 100
        If sdaysavailable < 0 Then sprojectedprogress = 100
        ' days available cannot be less than zero, i.e. make them zero
        If sdaysavailable < 0 Then sdaysavailable = 0
        ' calculate the percentage variance i.e. minus indicated behind schedule and + ahead of schedule
        sexpectedvariance = sactualprogress - sprojectedprogress
        ' determine the number of days behind / ahead of schedule
        sexpecteddays = splannedduration * (sprojectedprogress / 100)
        sexpecteddays = Round(sexpecteddays)
        sworkeddays = splannedduration * (sactualprogress / 100)
        saheadbehind = sexpecteddays - sworkeddays
        If sprojectedprogress = 0 Then saheadbehind = 0
		sexpectedimage = ExpectedRAG(Val(saheadbehind))
		spercentageimage = sexpectedimage
	End If

	If sexpenditure <> "" And sbudget <> "" Then
		spercentageexpenditure = Val(sexpenditure) / Val(sbudget)
		spercentageexpenditure = spercentageexpenditure * 100
		sexpenditurevariance = Val(sbudget) - Val(sexpenditure)
    	sbudgetimage = ExpenditureRAG(Val(sexpenditurevariance))
		'difference between expenditure & actual progress
		Dim expvsprogress As Double = spercentageexpenditure - sactualprogress
		If Abs(expvsprogress) >= 10 Then
			sbudgetimage = "../images/red.png"
		End If
	End If

	'update map
	pmap.put("plannedduration",splannedduration)
	pmap.put("percentageexpenditure",spercentageexpenditure)
	pmap.put("percentageperday",spercentageperday)
	pmap.put("reportduration",sreportduration)
	pmap.put("daysavailable",sdaysavailable)
	pmap.put("projectedprogress",sprojectedprogress)
	pmap.put("expenditurevariance",sexpenditurevariance)
	pmap.put("actualprogressperday",sactualprogressperday)
	pmap.put("workeddays",sworkeddays)
	pmap.put("expectedprogressperday",sexpectedprogressperday)
	pmap.put("expecteddays",sexpecteddays)
	pmap.put("aheadbehind",saheadbehind)
	pmap.put("expectedvariance",sexpectedvariance)
	pmap.put("percentageimage",spercentageimage)
	pmap.put("budgetimage",sbudgetimage)
	pmap.put("expectedimage",sexpectedimage)
		
	Return pmap
End Sub

Sub CleanString(strDirty As String) As String
    Dim strLen As Int = Len(strDirty)
    Dim strCounter As Int = 0
    Dim strClean As StringBuilder
	strClean.Initialize 
    For strCounter = 1 To strLen
        Dim strValue As String = Mid2(strDirty,strCounter,1)
		Dim intAsc As Int = Asc(strValue)
		Select intAsc
        Case 65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90
            strClean.Append(strValue)
        Case 97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122
            strClean.Append(strValue)
        Case 32,48,49,50,51,52,53,54,55,56,57
            strClean.Append(strValue)
        Case Else
            'All other characters are stripped out 
	    End Select
    Next
    Return strClean.tostring
End Sub

Sub CaseIn(startVal As Int, endVal As Int) As String
	Dim sb As StringBuilder
	sb.Initialize
	Dim intC As Int = 0
	For intC = startVal To endVal
		sb.Append(intC).Append(",")
	Next
	Return RemDelimSB(",",sb).tostring
End Sub

'create a new list
Sub NewList(lstName As List) As List
	lstName.Initialize
	Return lstName
End Sub

Sub ApplyMetro(frm As Form)
	Dim jo As JavaObject
	jo.InitializeNewInstance("jfxtras.styles.jmetro8.JMetro", Array("LIGHT")) 'or DARK
	Dim jform As JavaObject = frm
	jo.RunMethod("applyTheme", Array(jform.GetField("scene")))
End Sub

'Sub FontAwesomeToBitmap (Text As String, FontSize As Float) As B4XBitmap
'	Dim xui As XUI
'	Dim p As Panel = xui.CreatePanel("")
'	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
'	Dim cvs1 As B4XCanvas
'	cvs1.Initialize(p)
'	Dim fnt As B4XFont = xui.CreateFont(Typeface.FONTAWESOME, FontSize)
'	Dim r As B4XRect = cvs1.MeasureText(Text, fnt)
'	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
'	cvs1.DrawText(Text, cvs1.TargetRect.CenterX, BaseLine, fnt, xui.Color_White, "CENTER")
'	Dim b As B4XBitmap = cvs1.CreateBitmap
'	cvs1.Release
'	Return b
'End Sub
'
'Public Sub FontToBitmap (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
'	Dim xui As XUI
'	Dim p As Panel = xui.CreatePanel("")
'	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
'	Dim cvs1 As B4XCanvas
'	cvs1.Initialize(p)
'	Dim t As Typeface
'	If IsMaterialIcons Then t = Typeface.MATERIALICONS Else t = Typeface.FONTAWESOME
'	Dim fnt As B4XFont = xui.CreateFont(t, FontSize)
'	Dim r As B4XRect = cvs1.MeasureText(text, fnt)
'	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
'	cvs1.DrawText(text, cvs1.TargetRect.CenterX, BaseLine, fnt, color, "CENTER")
'	Dim b As B4XBitmap = cvs1.CreateBitmap
'	cvs1.Release
'	Return b
'End Sub


'returns true of a map has all the keys
Sub MapHasKeys(m As Map,keys As List) As Boolean
	Dim iFound As Int = 0
	For Each strKey As String In keys
		strKey = strKey.tolowercase
		If m.ContainsKey(strKey) Then 
			iFound = iFound + 1
		End If
	Next
	If iFound = keys.Size Then
		Return True
	Else
		Return False
	End If
End Sub

Sub JSONField2Map(m As Map, fldName As String) As Map
	Dim propsJSON As String = m.GetDefault(fldName,"")
	Dim propsMap As Map = Json2Map(propsJSON)
	Return propsMap
End Sub

Sub MaxHeapSize As Long
	Dim jo As JavaObject
	Return jo.InitializeStatic("java.lang.Runtime").RunMethodJO("getRuntime", Null).RunMethod("maxMemory", Null)
End Sub

'extract map properties to a list
Sub MapProperty2List(om As List,prop As String) As List
	Dim lst As List: lst.initialize
	Dim mtot As Int = om.Size - 1
	Dim mcnt As Int = 0
	For mcnt = 0 To mtot
		Dim omm As Map = om.Get(mcnt) 
		Dim strvalue As String = GetDefault(omm,prop,"")
		lst.Add(strvalue)
	Next
	Return lst
End Sub


Sub BreakStringInEqualLength(Text As String, RowLen As Int) As String
	Dim sb As StringBuilder
	sb.Initialize
	Dim CurrentRow As Int
	For Each s As String In Regex.Split("\s+", Text)
		If CurrentRow > 0 And CurrentRow + s.Length > RowLen Then
			sb.Append(CRLF)
			CurrentRow = 0
		Else if CurrentRow > 0 Then
			sb.Append(" ")
			CurrentRow = CurrentRow + 1
		End If
		sb.Append(s)
		CurrentRow = CurrentRow + s.Length
	Next
	Return sb.ToString
End Sub


Sub SplitPaneRemoveLayout(splitp As SplitPane, idx As Int)
	Dim jo As JavaObject = splitp
	jo.RunMethodJO("getItems", Null).RunMethod("remove", Array(idx))
End Sub


private Sub MapKeySearch(nm As Map, s As String) As Int
	Dim mpos As Int = -1
	For Each strKey As String In nm.Keys
		mpos = mpos + 1
		If strKey.EqualsIgnoreCase(s) Then
			Return mpos
		End If
	Next
	Return mpos
End Sub


Sub FindAndReplace(sContents As String, findReplaceMap As Map) As String
	Dim mTot As Int  = findReplaceMap.Size - 1
	' for each findReplaceMap, execute
	For mCnt = 0 To mTot
		Dim sFind As String = findReplaceMap.GetKeyAt(mCnt)
		Dim sReplace As String = findReplaceMap.GetValueAt(mCnt)
		sContents = sContents.Replace(sFind,sReplace)
	Next
	Return sContents
End Sub


Sub CDbl(o As Object) As Double
	Try
		Dim ox As String = o
		ox = GetNumbers(ox)
		If ox = "" Then ox = "0"
		Return ox
	Catch
		Return 0
	End Try
End Sub

Sub GenerateRandomPassword(numChars As Int, numbers As Boolean, lowercase As Boolean, uppercase As Boolean, symbols As Boolean) As String          
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

Sub PrintObject(obj As Node)
	Dim pj,pr As JavaObject
	pj = pr.InitializeStatic("javafx.print.PrinterJob").RunMethodJO("createPrinterJob",Null)
	pj.RunMethodJO("showPrintDialog",Array As Object(Null))
	pj.RunMethodJO("showPageSetupDialog",Array As Object(Null))
	pj.RunMethodJO("printPage",Array As Object(obj))
	pj.RunMethodJO("endJob",Null)
End Sub
Sub TableViewSetColumnGraphic(tv As TableView, Index As Int, Node As Node)
	Dim jo As JavaObject = tv
	Dim column As JavaObject = jo.RunMethodJO("getColumns", Null).RunMethod("get", Array(Index))
	column.RunMethod("setGraphic", Array(Node))
	column.RunMethod("setText", Array(""))
End Sub

Sub IndexOfNth(occur As Int, query As String, data As String) As Int
    Dim index = data.IndexOf(query) As Int
    Do While index > -1 And occur > 1
        index = data.IndexOf2(query, index + 1)
        occur = occur - 1
    Loop
    Return index
End Sub

Sub SendEmail(esmtp As SMTP, sserver As String, sport As String, susername As String, spassword As String, sStartTLSMode As String, sUseSSL As String, toEmail As String, subject As String, msg As String) As ResumableSub
	'start sending the email
	esmtp.Initialize(sserver, sport, susername, spassword, "smtp")
	esmtp.To.Add(toEmail)
	esmtp.Body = msg
	esmtp.Subject = subject
	If sStartTLSMode = "1" Then
		esmtp.StartTLSMode = True
	Else
		esmtp.StartTLSMode = False
	End If
	If sUseSSL = "1" Then
		esmtp.UseSSL = True
	Else
		esmtp.UseSSL = False
	End If
	Wait For (esmtp.Send) smtp_MessageSent(Success As Boolean)
	Return Success
End Sub

Sub smtp_MessageSent(Success As Boolean)
End Sub

Sub GetFileBasename(sValue As String) As String
	Dim sout As String = File.GetName(sValue)
	sout = MvField(sout,1,".")
	Return sout
End Sub

Sub GetFilePath(sValue As String) As String
	Dim sout As String = File.GetFileParent(sValue)
	Return sout
End Sub


Sub GetFileName(sValue As String) As String
	Dim sout As String = File.GetName(sValue)
	Return sout
End Sub

'add an item to a delimited string
Sub MvAdd(oldValue As String, delim As String, item As String) As String
	Dim lst As List = Mv2List(delim,oldValue)
	lst.Add(item)
	oldValue = MvFromList(lst,delim)
	Return oldValue
End Sub

'get the rest of the mv data from a particular position
Sub MvRest(delim As String, svalue As String, startPos As String) As String
	Dim spItems() As String = StrParse(delim,svalue)
	Dim lst As List
	lst.initialize
	Dim rCnt As Int = startPos-1
	Dim rTot As Int = spItems.Length - 1
	For rCnt = (startPos-1) To rTot
		lst.Add(spItems(rCnt))
	Next
	Return Join(delim,lst)
End Sub


Sub HTML_TidyCode(sCode As String) As String
	'delete existing file
	If File.Exists(File.DirTemp,"temp.html") Then File.Delete(File.DirApp,"temp.html")
	If File.Exists(File.DirApp,"temp.xml") Then File.Delete(File.DirApp,"temp.xml")
	'save the contents first
	File.WriteString(File.DirTemp,"temp.html",sCode)
	'parse with jtidy to convert to xml
	tid.Initialize
	'ensure it shows the output
	Dim jo As JavaObject = tid
	jo.GetFieldJO("tidy").RunMethod("setForceOutput", Array(True))
	File.Copy(File.DirAssets,"jtidytags.txt",File.DirTemp,"jtidytags.txt")
	Dim fn As String = File.combine(File.DirTemp,"jtidytags.txt")
	jo.GetFieldJO("tidy").RunMethod("setConfigurationFromFile",Array(fn))
	'parse the Html page and create a new xml document.
	tid.Parse(File.OpenInput(File.DirTemp, "temp.html"), File.DirApp, "temp.xml")
	Dim sout As String = File.ReadString(File.DirApp,"temp.xml")
	Return sout
End Sub


Sub ConvertStringToInputStream(s As String) As InputStream
	Dim in As InputStream
	Dim b() As Byte
	b = s.GetBytes("UTF8")
	in.InitializeFromBytesArray(b, 0, b.Length)
	Return in
End Sub

Public Sub IsArray(Var As Object) As Boolean
	Dim VarType As String = GetType(Var)
	Return VarType.StartsWith("[")
End Sub

Public Sub ArrayType(Var As Object) As String
	Dim Res As String
	Dim VarType As String = GetType(Var)
	If VarType.StartsWith("[") Then
		Dim SecondChar As String = VarType.SubString2(1,2)
		Select Case SecondChar
			Case "B"
				Res = "Byte"
			Case "S"
				Res = "Short"
			Case "I"
				Res = "Int"
			Case "J"
				Res = "Long"
			Case "F"
				Res = "Float"
			Case "D"
				Res = "Double"
			Case "C"
				Res = "Char"
			Case "L"
				Res = "String"
			Case Else
				Res = ""
		End Select
	End If
	Return Res
End Sub

Sub HTMLEditor_SetFocus(Editor As HTMLEditor)
   	Dim jo2 As JavaObject = Editor
	Dim r2 As Reflector
	r2.Target = jo2.RunMethodJO("getSkin", Null)
	jo2 = r2.GetField("webView")
	jo2.RunMethod("requestFocus", Null)
	jo2 = jo2.RunMethod("getEngine", Null)
	jo2.RunMethod("executeScript", Array("document.body.focus()"))
	jo2.RunMethod("executeScript", Array($"
   var el = document.body;
if (typeof window.getSelection != "undefined"
  && typeof document.createRange != "undefined") {
   var range = document.createRange();
   range.selectNodeContents(el);
   range.collapse(false);
   var sel = window.getSelection();
   sel.removeAllRanges();
   sel.addRange(range);
} else if (typeof document.body.createTextRange != "undefined") {
   var textRange = document.body.createTextRange();
  textRange.moveToElementText(el);
   textRange.collapse(false);
   textRange.select();
}
   "$))  
End Sub

Sub HTML_RemoveTags(Text As String) As String
	Dim Pattern, Replacement As String
	Dim m As Matcher
	Pattern = "<[^>]*>"
	Replacement = " "
	m = Regex.Matcher2(Pattern, Regex.CASE_INSENSITIVE, Text)
	Dim r As Reflector
	r.Target = m
	Return r.RunMethod2("replaceAll", Replacement, "java.lang.String")
End Sub

Sub HTMLEditor_SetToolbar (Editor As HTMLEditor, Index As Int, State As Boolean)
	Dim jo As JavaObject = Editor
	Dim nodes() As Object = jo.RunMethodJO("lookupAll", Array(".tool-bar")).RunMethod("toArray", Null)
	Dim toolbar As JavaObject = nodes(Index)
	toolbar.RunMethod("setVisible", Array(State))
	toolbar.RunMethod("setManaged", Array(State))
End Sub

Sub ToBoolean(sValue As String) As Boolean
	Return iif(sValue="0",False,True)
End Sub

'get the clicked treeview item
Sub TreeViewClickedItem (tv As TreeView, EventData As MouseEvent) As TreeItem
	Dim ti As TreeItem
	Try
		Dim jo As JavaObject = EventData
		Dim target As JavaObject = jo.RunMethodJO("getTarget", Null)
		Do Until target Is TreeView
			If GetType(target) = "com.sun.javafx.scene.control.skin.TreeViewSkin$1" Then
				Dim ti As TreeItem = target.RunMethod("getTreeItem", Null)
				'If EventData.ClickCount = 2 Then
				'	Log("double click!")
				'End If
				Return ti
			End If
			Dim n As Node = target
			target = n.Parent
		Loop
	Catch
		Return ti
	End Try
End Sub

'Sub TextToBitmap (s As String, FontSize As Float) As Bitmap
'	Dim lblfontAwesome As Label
'	lblfontAwesome.Initialize("")
'	lblfontAwesome.typeface = fontawesome
'	lblfontAwesome.Font = awesome
'	Dim bmp As Bitmap
'	bmp.InitializeMutable(32dip, 32dip)
'	Dim cvs As Canvas
'	cvs.Initialize2(bmp)
'	Dim h As Double = cvs.MeasureStringHeight(s, lblfontAwesome.Typeface, FontSize)
'	cvs.DrawText(s, bmp.Width / 2, bmp.Height / 2 + h / 2, lblfontAwesome.Typeface, FontSize, Colors.White, "CENTER")
'	Return bmp
'End Sub

Sub LongDateToday() As String
	DateTime.DateFormat = "yyyy-MM-dd"
	Dim dt As Long = DateTime.now
	DateTime.DateFormat = "EEEE, dd MMMM yyyy"
	Return DateTime.Date(dt)
End Sub

Sub LongDateTimeToday() As String
	DateTime.DateFormat = "yyyy-MM-dd"
	Dim dt As Long = DateTime.now
	DateTime.DateFormat = "EEEE, dd MMMM yyyy, HH:mm"
	Return DateTime.Date(dt)
End Sub


public Sub CopyFolder(Source As String, targetFolder As String)
	If File.Exists(targetFolder, "") = False Then File.MakeDir(targetFolder, "")
	For Each f As String In File.ListFiles(Source)
		If File.IsDirectory(Source, f) Then
			CopyFolder(File.Combine(Source, f), File.Combine(targetFolder, f))
			Continue
		End If
		File.Copy(Source, f, targetFolder, f)
	Next
End Sub

'Depends on JavaObject
Sub WebViewAssetFile (dir As String, fil As String) As String
   #if B4J
	Return File.GetUri(dir, fil)
   #Else If B4A
     Dim jo As JavaObject
     jo.InitializeStatic("anywheresoftware.b4a.objects.streams.File")
     If jo.GetField("virtualAssetsFolder") = Null Then
       Return "file:///android_asset/" & FileName.ToLowerCase
     Else
       Return "file://" & File.Combine(jo.GetField("virtualAssetsFolder"), _
       jo.RunMethod("getUnpackedVirtualAssetFile", Array As Object(FileName)))
     End If
   #Else If B4i
     Return $"file://${File.Combine(File.DirAssets, FileName)}"$
   #End If
End Sub



public Sub WebViewLoadFile(dir As String, fil As String, webv As WebView)
	If File.Exists(dir,fil) = True Then
		Dim strData As String = File.ReadString(dir,fil)
		webv.LoadHtml(strData)
		webv.Tag = File.Combine(dir,fil)
	Else
		webv.LoadHtml("")
	End If
End Sub

'remove a delimiter from a string
public Sub RemDelimSB(delimiter As String, value As StringBuilder) As StringBuilder
	If value.tostring.EndsWith(delimiter) = True Then
		Dim delimLen As Int = delimiter.length
		value.Remove(value.Length-delimLen,value.Length)
	End If
	Return value
End Sub

public Sub RemPrefix(xvalue As String, delim As String) As String
	If xvalue.StartsWith(delim) Then
		xvalue = Mid(xvalue,delim.Length)
		Return xvalue
	End If
	Return xvalue
End Sub

Sub MvStringToType(Delim As String, TypeName As String, EnumName As String, MvStr As String) As String
	MvStr = MvStr.Replace("'","")
	MvStr = MvStr.Replace(QUOTE,"")
	Dim sb As StringBuilder
	sb.initialize
	sb.Append("Type ").Append(TypeName).Append("(")
	Dim items() As String = StrParse(Delim,MvStr)
	For Each strItem As String In items
		strItem = strItem.Trim
		sb.Append(strItem).Append(" As String,")
	Next
	sb = RemDelimSB(",",sb)
	sb.Append(")").Append(CRLF)
	sb.Append("Public ").Append(EnumName).Append(" As ").Append(TypeName).Append(CRLF)
	sb.Append(EnumName).Append(".Initialize").Append(CRLF)
	For Each strItem As String In items
		strItem = strItem.Trim
		sb.Append(EnumName).Append(".").Append(strItem).Append(" = ")
		sb.Append(InQuotes(strItem)).append(CRLF)
	Next
	sb.Append(items.Length).Append(CRLF)
	Return sb.tostring
End Sub

Sub MatchMap2Database(xjSQL As SQL, tblName As String, map2Save As Map) As Map
	'lets remove fields that dont exist on the table
	Dim fldsx As List = DBUtils.GetFieldNames(xjSQL,tblName)
	Dim nRecord As Map
	nRecord.Initialize
	For Each strKey As String In map2Save.Keys
		Dim strValue As String = map2Save.Get(strKey)
		strKey = strKey.tolowercase
		If fldsx.IndexOf(strKey) = -1 Then
		Else
			nRecord.Put(strKey,strValue)
		End If
	Next
	Return nRecord
End Sub

Sub ParseInt(strValue As String) As Int
	Try
	Return Bit.ParseInt(strValue, 16)
	Catch
		Return 0
	End Try
End Sub

Sub MenuItemVisible(MBar As MenuBar, MainMenu As String, MenuItem As String, bVisible As Boolean)
	Dim lMenus As List = MBar.menus
	For Each strMenu As Menu In lMenus
		Dim mText As String = strMenu.text
		If mText.EqualsIgnoreCase(MainMenu) Then
			For Each mi As MenuItem In strMenu.MenuItems
				Dim miText As String = mi.Text
				If miText.EqualsIgnoreCase(MenuItem) Then
					mi.Visible = bVisible
					Return
				End If
			Next
		End If
	Next
End Sub

Sub MenuItemRename(MBar As MenuBar, MainMenu As String, MenuItem As String, NewMenuItem As String)
	Dim lMenus As List = MBar.menus
	For Each strMenu As Menu In lMenus
		Dim mText As String = strMenu.text
		If mText.EqualsIgnoreCase(MainMenu) Then
			For Each mi As MenuItem In strMenu.MenuItems
				Dim miText As String = mi.Text
				If miText.EqualsIgnoreCase(MenuItem) Then
					mi.Text = NewMenuItem
					Return
				End If
			Next
		End If
	Next
End Sub

Sub MenuItemSetImage(MBar As MenuBar, MainMenu As String, MenuItem As String, Dir As String, ImageName As String)
	Dim lMenus As List = MBar.menus
	For Each strMenu As Menu In lMenus
		Dim mText As String = strMenu.text
		If mText.EqualsIgnoreCase(MainMenu) Then
			For Each mi As MenuItem In strMenu.MenuItems
				Dim miText As String = mi.Text
				If miText.EqualsIgnoreCase(MenuItem) Then
					mi.Image = fx.LoadImage(Dir,ImageName)
					Return
				End If
			Next
		End If
	Next
End Sub

Sub MenuItemEnable(MBar As MenuBar, MainMenu As String, MenuItem As String, bEnabled As Boolean)
	Dim lMenus As List = MBar.menus
	For Each strMenu As Menu In lMenus
		Dim mText As String = strMenu.text
		If mText.EqualsIgnoreCase(MainMenu) Then
			For Each mi As MenuItem In strMenu.MenuItems
				Dim miText As String = mi.Text
				If miText.EqualsIgnoreCase(MenuItem) Then
					mi.enabled = bEnabled
					Return
				End If
			Next
			
		End If
	Next
End Sub

Sub ConsolidateLists(lst1 As List, lst2 As List) As List
	Dim nMap As Map
	nMap.Initialize
	For Each strKey As String In lst1
		nMap.Put(strKey,strKey)
	Next
	For Each strKey As String In lst2
		nMap.Put(strKey,strKey)
	Next
	Dim nList As List
	nList.Initialize
	For Each strKey As String In nMap.Keys
		nList.Add(strKey)
	Next
	nList.Sort(True)
	Return nList
End Sub

Sub DidYouKnow(dlg As DialogsX, sTitle As String, sHeader As String, sContent As String)
	dlg.DidYouKnowDialog(sTitle, sHeader, sContent)
End Sub

Sub CSSUtilsRotate(n As Node, degrees As Int)
	CSSUtils.SetStyleProperty(n, "-fx-rotate", degrees)
End Sub

Sub CSSUtilsSetFontSize(n As Node,  size As String)
	CSSUtils.SetStyleProperty(n,"-fx-font-size", $"${size}px"$)
End Sub

Sub CSSUtilsLinearGradient(n As Node, colorHex1 As String, colorHex2 As String)
	CSSUtils.SetStyleProperty(n,"-fx-background-color",$"linear-gradient(${colorHex1}, ${colorHex2})"$)
End Sub

Sub CSSUtilsAlignRight(n As Node)
	CSSUtils.SetStyleProperty(n,"-fx-alignment", "center-right")
End Sub

Sub CSSUtilsStrikeThrough(n As Node, status As Boolean)
	CSSUtils.SetStyleProperty(n,"-fx-strikethrough", status)
End Sub

Sub CSSUtilsUnderline(n As Node, status As Boolean)
	CSSUtils.SetStyleProperty(n,"-fx-underline", status)
End Sub

Sub CSSutilsItalic(n As Node)
	CSSUtils.SetStyleProperty(n,"-fx-font-style","italic")
End Sub

Sub CSSutilsNormal(n As Node)
	CSSUtils.SetStyleProperty(n,"-fx-font-style","normal")
End Sub

Sub CSSutilsTextColor(n As Node,color As String)
	CSSUtils.SetStyleProperty(n,"-fx-text-fill",color)
End Sub

Sub CSSUtilsFontBold(n As Node)
	CSSUtils.SetStyleProperty(n, "-fx-font-weight", "bold")
End Sub

Sub MaxOfList(lst As List) As Int
	Dim maxcnt As Int = 0
	Dim curCnt As Int = 0
	For Each strID As String In lst
		curCnt = CInt(strID)
		If curCnt > maxcnt Then maxcnt = curCnt
	Next
	Return maxcnt
End Sub

Sub MaxOfMapKeys(lst As Map) As Int
	Dim maxcnt As Int = 0
	Dim curCnt As Int = 0
	For Each strID As String In lst.keys
		curCnt = CInt(strID)
		If curCnt > maxcnt Then maxcnt = curCnt
	Next
	Return maxcnt
End Sub


Sub MinOfList(lst As List) As Int
	'lets get the first value
	Dim fValue As String = lst.Get(0)
	Dim maxcnt As Int = CInt(fValue)
	Dim curCnt As Int = 0
	For Each strID As String In lst
		curCnt = CInt(strID)
		If curCnt < maxcnt Then maxcnt = curCnt
	Next
	Return maxcnt
End Sub

Sub GetRecordFromJSONList(jsonValue As String, sPrimaryKey As String, sPrimaryValue As String) As Map
	Dim outList As Map
	outList.Initialize
	If sPrimaryKey.Length = 0 Then Return outList
	Dim lItems As List = Json2List(jsonValue)
	For Each recMap As Map In lItems
		Dim strKey As String = recMap.GetDefault(sPrimaryKey.tolowercase,"")
		If strKey.EqualsIgnoreCase(sPrimaryValue) Then
			Return recMap
		End If
	Next
End Sub

Sub LongFileName(Path As String) As String
	Dim fileO As JavaObject
	fileO.InitializeNewInstance("java.io.File", Array As Object(Path))
	Return fileO.RunMethod("getCanonicalPath", Null)
End Sub

Sub File_Copy(SourceDir As String, SourceFile As String, TargetDir As String, bReplace As Boolean)
	If LongFileName(File.combine(SourceDir,SourceFile)) = LongFileName(File.Combine(TargetDir,SourceFile)) Then Return
	If bReplace = True Then
		File.Copy(SourceDir,SourceFile,TargetDir,SourceFile)
	Else
		If File.Exists(TargetDir,SourceFile) = False Then
			File.Copy(SourceDir,SourceFile,TargetDir,SourceFile)
		End If
	End If
End Sub

'extract a particular key value from a list of maps in JSON format
Sub ExtraListFromJSONMaps(strJSON As String, Property As String) As List
	Property = Property.tolowercase 
	Dim lstNew As List
	lstNew.initialize	
	Dim lst As List = Json2List(strJSON)
	For Each m As Map In lst
		Dim sprop As String = m.GetDefault(Property,"")
		If sprop.Length > 0 Then lstNew.add(sprop)
	Next
	Return lstNew
End Sub

'extract a particular key value from a list of maps
Sub ExtraPropertyFromListOfMaps(lst As List, Property As String) As List
	Property = Property.tolowercase 
	Dim lstNew As List
	lstNew.initialize	
	For Each m As Map In lst
		Dim sprop As String = m.GetDefault(Property,"")
		If sprop.Length > 0 Then lstNew.add(sprop)
	Next
	Return lstNew
End Sub

'extract a particular key value from a list of maps
Sub ExtraPropertyFromListOfMaps1(lst As List, Property As String) As Map
	Property = Property.tolowercase 
	Dim lstNew As Map
	lstNew.initialize	
	For Each m As Map In lst
		Dim sprop As String = m.GetDefault(Property,"")
		If sprop.Length > 0 Then lstNew.put(sprop,m)
	Next
	Return lstNew
End Sub

'public Sub MeasureTextWidth (Text As String, Font As B4XFont) As Float
'	Dim lbl As Label
'	lbl.Initialize("")
'	lbl.Text = Text
'	lbl.Font = Font
'	mBase.AddView(lbl, 0, 0, -1, -1) 'mBase is a B4XView panel.
'	lbl.Snapshot
'	lbl.RemoveNodeFromParent
'	Return lbl.Width
'End Sub

Sub AddMap2Json(strJSON As String, m As Map) As String
	Dim lst As List = Json2List(strJSON)
	lst.Add(m)
	Dim sjson As String = List2JSON(lst)
	Return sjson
End Sub


Sub GetDefault(m As Map, prop As String, def As String) As String
	prop = prop.tolowercase
	Return m.getdefault(prop,def)
End Sub

Sub SetDefault(m As Map, prop As String, def As Object) As Map
	prop = prop.tolowercase
	m.put(prop,def)
	Return m
End Sub

Sub MapKeys2List(m As Map) As List
	Dim lst As List
	lst.Initialize
	lst.add("")
	For Each strKey As String In m.keys
		lst.add(strKey)
	Next
	lst.sort(True)
	Return lst
End Sub

Sub ListOfMapsExtractKey(lst As List, skey As String) As List
	Dim nm As List
	nm.Initialize
	For Each oldm As Map In lst
		Dim svalue As Object = oldm.Get(skey.tolowercase)
		nm.Add(svalue)
	Next
	Return nm
End Sub

Sub GetElements (m As Map, key As String) As List
	Dim res As List
	If m.ContainsKey(key) = False Then
		res.Initialize
		Return res
	Else
		Dim value As Object = m.Get(key)
		If value Is List Then Return value
		res.Initialize
		res.Add(value)
		Return res
	End If
End Sub

Sub AddComment(sbx As StringBuilder, scomment As String)
	Dim svalue As String = $"'${scomment}"$
	sbx.Append(svalue).Append(CRLF)
End Sub


#Region KVS
Public Sub InitializeKVS(Dir As String, FileName As String)
	If sql1.IsInitialized Then sql1.Close
	sql1.InitializeSQLite(Dir, FileName, True)
	CreateTable
End Sub

Public Sub PutSimple(Key As String, Value As Object) As Boolean
	Key = Key.tolowercase
	Try
		start(Key)
		insertQuery(Key, Value)
		Return complete(True)
	Catch
		Return complete(False)
	End Try
End Sub
'Puts an object in the store. This method uses RandomAccessFile.WriteObject to save the object in the store.
'It is capable of writing the following types of objects: Lists, Arrays, Maps, Strings, primitive types and user defined types.
'Combinations of these types are also supported. For example, a Map with several lists of arrays can be written.
'The element type inside a collection must be a String OR primitive Type.
Public Sub PutObject(Key As String, Value As Object) As Boolean
	Key = Key.tolowercase
	Return putObjectInternal(Key, Value, False, "")
End Sub

'Similar to PutObject. Encrypts the object before writing it. Note that you can use it to store "simple" types as well.
Public Sub PutEncyptedObject(Key As String, Value As Object, Password As String) As Boolean
	Key = Key.tolowercase
	Return putObjectInternal(Key, Value, True, Password)
End Sub

'Puts a bitmap in the store.
Public Sub PutBitmap(Key As String, Value As Image) As Boolean
	Key = Key.tolowercase
	Try
		start(Key)
		Dim out As OutputStream
		out.InitializeToBytesArray(100)
		Dim b As Image = Value
		b.WriteToStream(out)
		insertQuery(Key, out.ToBytesArray)
		out.Close
		Return complete(True)
	Catch
		Return complete(False)
	End Try
End Sub

'Reads the data from the input stream and saves it in the store.
Public Sub PutInputStream(Key As String, Value As InputStream) As Boolean
	Key = Key.tolowercase
	Try
		start(Key)
		Dim out As OutputStream
		out.InitializeToBytesArray(100)
		File.Copy2(Value, out)
		Value.Close
		insertQuery(Key, out.ToBytesArray)
		out.Close
		Return complete(True)
	Catch
		Return complete(False)
	End Try
End Sub

'Removes the key and value mapped to this key.
Public Sub Remove(Key As String)
	Key = Key.tolowercase
	sql1.ExecNonQuery2("DELETE FROM main WHERE key = ?", Array As Object(Key))
End Sub

'Returns a list with all the keys.
Public Sub ListKeys As List
	Dim c As ResultSet = sql1.ExecQuery("SELECT key FROM main")
	Dim res As List
	res.Initialize
	Do While c.NextRow
		Dim fValue As String = c.GetString2(0)
		fValue = FixNull(fValue)
		res.Add(fValue)
	Loop
	c.Close
	Return res
End Sub

'Description: return all keys containing text like
'tag: key value store, keys
Public Sub ListKeysLike(sLike As String) As List
	Dim c As ResultSet = sql1.ExecQuery("SELECT key FROM main where key LIKE '%" & sLike & "%' order by key")
	Dim res As List
	res.Initialize
	Do While c.NextRow
		Dim fValue As String = c.GetString2(0)
		fValue = FixNull(fValue)
		res.Add(fValue)
	Loop
	c.Close
	Return res
End Sub

'Description: return all keys starting with text like
'tag: key value store, keys
Public Sub ListKeysStartsWith(sLike As String) As List
	Dim c As ResultSet = sql1.ExecQuery("SELECT key FROM main where key LIKE '" & sLike & "%' order by key")
	Dim res As List
	res.Initialize
	Do While c.NextRow
		Dim fValue As String = c.GetString2(0)
		fValue = FixNull(fValue)
		res.Add(fValue)
	Loop
	c.Close
	Return res
End Sub

public Sub ListObjects(bSorted As Boolean) As List
	Dim lKeys As List = ListKeys
	If bSorted = True Then lKeys.Sort(True)
	Dim lMaps As List
	Dim eMap As Map
	lMaps.Initialize
	For Each strKey As String In lKeys
		eMap = GetObject(strKey)
		lMaps.Add(eMap)
	Next
	Return lMaps
End Sub

'Tests whether a key is available in the store.
Public Sub ContainsKey(Key As String) As Boolean
	Key = Key.tolowercase
	Return sql1.ExecQuerySingleResult2("SELECT count(key) FROM main WHERE key = ?", _
		Array As String(Key)) > 0
End Sub

'Deletes all data from the store.
Public Sub DeleteAll
	sql1.ExecNonQuery("DROP TABLE main")
	CreateTable
End Sub

'Returns a "simple" value. See PutSimple.
Public Sub GetSimple(Key As String) As String
	Key = Key.tolowercase
	Dim c As ResultSet = getCursor(Key)
	If c.NextRow = False Then
		c.Close
		Return ""
	End If
	Dim fValue As String = c.GetString2(0)
	fValue = FixNull(fValue)
	Dim res As String = fValue
	res = res.Replace("null","").Replace("NULL","").replace("Null","")
	c.Close
	Return res
End Sub

Sub OnList(searchList As List, searchValue As String) As Boolean
	'If searchList.IsInitialized = False Then Return False
	For Each strTable As String In searchList
		If strTable.EqualsIgnoreCase(searchValue) = True Then
			Return True
		End If
	Next
	Return False
End Sub

'Returns an InputStream from the store. See PutInputStream.
Public Sub GetInputStream(Key As String) As InputStream
	Key = Key.tolowercase
	Dim c As ResultSet = getCursor(Key)
	If c.NextRow = False Then
		c.Close
		Return Null
	End If
	Dim buffer() As Byte = c.GetBlob2(0)
	Dim In As InputStream
	In.InitializeFromBytesArray(buffer, 0, buffer.Length)
	c.Close
	Return In
End Sub

'Returns a bitmap from the store. See PutBitmap.
Public Sub GetBitmap(Key As String) As Image
	Key = Key.tolowercase
	Dim c As ResultSet = getCursor(Key)
	Dim b As Image
	If c.NextRow = False Then
		c.Close
		Return b
	End If
	Dim buffer() As Byte = c.GetBlob2(0)
	Dim In As InputStream
	In.InitializeFromBytesArray(buffer, 0, buffer.Length)
	b.Initialize2(In)
	In.Close
	c.Close
	Return b
End Sub

'Returns an object from the store. See PutObject.
Public Sub GetObject(Key As String) As Object
	Key = Key.tolowercase
	Return getObjectInternal(Key, False, "")
End Sub

'Returns an encrypted object from the store. See PutEncryptedObject.
Public Sub GetEncryptedObject(Key As String, Password As String) As Object
	Key = Key.tolowercase
	Return getObjectInternal(Key, True, Password)
End Sub

'Closes the store.
Public Sub Close
	sql1.Close
End Sub

Private Sub getObjectInternal(Key As String, decrypt As Boolean, password As String) As Object
	Key = Key.tolowercase
	Dim c As ResultSet = getCursor(Key)
	If c.NextRow = False Then
		c.Close
		Return Null
	End If
	Dim buffer() As Byte = c.GetBlob2(0)
	Dim raf As RandomAccessFile
	raf.Initialize3(buffer, False)
	Dim res As Object
	If decrypt Then
		res = raf.ReadEncryptedObject(password, raf.CurrentPosition)
	Else
		res = raf.ReadObject(raf.CurrentPosition)
	End If
	raf.Close
	c.Close
	Return res
End Sub

Private Sub getCursor(Key As String) As ResultSet
	Key = Key.tolowercase
	Return sql1.ExecQuery2("SELECT value FROM main WHERE key = ?", Array As String(Key))
End Sub

Private Sub insertQuery(Key As String, Value As Object)
	Key = Key.tolowercase
	sql1.ExecNonQuery2("INSERT INTO main VALUES(?, ?)", Array As Object(Key, Value))
End Sub

'creates the main table (if it does not exist)
Private Sub CreateTable
	sql1.ExecNonQuery("CREATE TABLE IF NOT EXISTS main(key TEXT PRIMARY KEY, value NONE)")
End Sub

Private Sub start (Key As String)
	Key = Key.tolowercase
	sql1.BeginTransaction
	sql1.ExecNonQuery2("DELETE FROM main WHERE key = ?", Array As Object(Key))
End Sub

Private Sub complete(success As Boolean) As Boolean
	Try
		If success Then
			sql1.TransactionSuccessful
		Else
			Log("Error saving object: " & LastException)
			sql1.Rollback
		End If
		Return success
	Catch
		Return success
	End Try
End Sub

Private Sub putObjectInternal(Key As String, Value As Object, encrypt As Boolean, password As String) As Boolean
	Key = Key.tolowercase
	Try
		start(Key)
		Dim raf As RandomAccessFile
		File.Delete(tempFolder, tempFile)
		raf.Initialize(tempFolder, tempFile, False)
		If encrypt Then
			raf.WriteEncryptedObject(Value, password, raf.CurrentPosition)
		Else
			raf.WriteObject(Value, True, raf.CurrentPosition)
		End If
		raf.Flush
		Dim buffer(raf.CurrentPosition) As Byte
		raf.ReadBytes(buffer, 0, buffer.Length, 0)
		raf.Close
		insertQuery(Key, buffer)
		Return complete(True)
	Catch
		Return complete(False)
	End Try
End Sub

#End Region

'set a graphic object to a segmented button
Sub SegmentedButton_SetGraphic(SegmentedButton As SegmentedButton, Index As Int, Node As Node)
	Dim ToggleButton As JavaObject = SegmentedButton
	ToggleButton = ToggleButton.RunMethodJO("getButtons", Null).RunMethod("get", Array(Index))
	ToggleButton.RunMethod("setGraphic", Array(Node))
End Sub

Sub TableView2CSV(frm As Form, tv As TableView, Dir2 As String, File2 As String)
	Dim su As StringUtils
	Dim l As List
	l.Initialize
	For y = 0 To tv.Items.Size - 1
		tv.SelectedRow = y
		Dim Row() As Object = tv.SelectedRowValues
		Dim NRow(Row.Length) As String
		For x = 0 To Row.Length - 1
			NRow(x) = Row(x)
		Next
		l.Add(NRow)
	Next
	Dim ch As List
	ch.Initialize
	For i = 0 To tv.ColumnsCount - 1
		ch.Add(tv.GetColumnHeader(i))
	Next
	Try
		su.SaveCSV2(Dir2, File2, ",", l, ch)
		MsgBoxInform(frm,"TableView Export","Exported successfully.")
	Catch
		MsgBoxInform(frm,"TableView Export Error",LastException.message)
	End Try
End Sub

Sub Initialize
	'Load the font
	fontawesome = fx.CreateFontAwesome(20)
End Sub

'Sub SetFont(v As Node, FontNumber As Int)
'	'Assign the fontawesome font to a button
'	v.Font = fontawesome
'	v.Style.
'	v.
'  	'Option 2 using unicode - requires sub UnescapeUnicode
'	v.Text = UnescapeUnicode("\uf" & FontNumber)
'End Sub

Sub Form_Save(frm As Form, imgFile As String)
	SaveSnapShot(frm.RootPane.Snapshot,imgFile)
End Sub


Sub Beep
	Dim jo As JavaObject
	jo.InitializeStatic("java.awt.Toolkit")
	Dim toolkit As JavaObject = jo.RunMethod("getDefaultToolkit", Null)
	toolkit.RunMethod("beep", Null)	
End Sub

Sub UUID As String
	Dim joUUID As JavaObject
	Return joUUID.InitializeStatic("java.util.UUID").RunMethod("randomUUID", Null)
End Sub

Sub SliderProperties(sld As Slider, majorTickUnit As Double, showTickLabels As Boolean, showTickMarks As Boolean)
	'Assign a JavaObject as Slider
	Dim joSlider As JavaObject = sld
	'Set additional properties which are not provided by the B4J Visual Designer
	joSlider.RunMethod("setBlockIncrement", Array(majorTickUnit))    ' Must be double
	joSlider.RunMethod("setMajorTickUnit", Array(majorTickUnit))     ' Must be double
	'joSlider.RunMethod("setMinorTickCount", Array(20))      ' Must be Int
	joSlider.RunMethod("setShowTickLabels", Array(showTickLabels))
	joSlider.RunMethod("setShowTickMarks", Array(showTickMarks))
	'joSlider.RunMethod("setValueChanging", Array(True))
	'joSlider.RunMethod("setSnapToTicks", Array(True))
End Sub


Sub SumMapValues(m As Map) As Double
	Dim itv As Double = 0
	For Each strKey As String In m.keys
		Dim intValue As Double = m.Get(strKey)
		itv = itv + intValue
	Next
	Return itv
End Sub

Sub ShowForm(frm As Form, frmWidth As Double, frmHeight As Double, layout As String)
	If frm.IsInitialized = False Then
		frm.Initialize("frm", frmWidth, frmHeight)
		frm.RootPane.LoadLayout(layout)
	End If
	frm.Show
End Sub

Sub PrefixQuote(sValue As String) As String
	Return sValue
End Sub


public Sub File2Byte (Dir As String, FileName As String) As Byte()
	Return Bit.InputStreamToBytes(File.OpenInput(Dir, FileName))
End Sub

'lowercase a string
Sub LCase(Text As String) As String
	Return Text.ToLowerCase
End Sub

Sub RemoveLines(Lines As List,StrSearch As String, ExactMatch As Boolean) As List
	Dim nLines As List
	nLines.Initialize
	Dim totLines As Long
	Dim cntLines As Long
	Dim curLine As String
	totLines = Lines.size - 1
	For cntLines = 0 To totLines
		curLine = Lines.Get(cntLines)
		If ExactMatch = True Then
			If StrSearch.tolowercase = curLine.trim.tolowercase Then
			Else
				nLines.Add(curLine)
			End If
		Else
			If InStr(LCase(curLine), LCase(StrSearch)) > 0 Then
			Else
				nLines.Add(curLine)
			End If
		End If
	Next
	Return nLines
End Sub


Sub CreateList(Delimiter As String, Values As String) As List
	Dim newLst As List
	newLst.Initialize
	If Values.length > 0 Then
		Dim spV() As String = StrParse(Delimiter,Values)
		newLst.AddAll(spV)
	End If
	Return newLst
End Sub

Sub ListHas(data As String, listObj As List) As Boolean
	Return listObj.IndexOf(data) > -1
End Sub

Sub ListDoesNotHave(data As String, listObj As List) As Boolean
	Return listObj.IndexOf(data) == -1
End Sub

Sub OpenFileNonUI(sFile As String)
	Dim robot As AWTRobot
	robot.SystemOpenExternalFile(sFile)
End Sub

private Sub ExtractGoogleIcons(dir As String, filename As String)
	Dim icons As List = File.ReadList(dir,filename)
	Dim icn As List
	icn.Initialize
	For Each strIcon As String In icons
		strIcon = strIcon.Trim
		If strIcon.length > 0 Then
			Dim strIT As String = MvField(strIcon,1,",")
			strIT = strIT.Replace(QUOTE,"")
			strIT = "-" & strIT
			icn.Add(strIT)
		End If
	Next
	File.WriteList(File.DirApp,"google.txt",icn)
End Sub

Sub RotateNode(n As Node, Degree As Double)
	Dim jo As JavaObject = n
	jo.RunMethod("setRotate", Array(Degree))
End Sub

Sub GetFileIcon(Dir As String, FileName As String) As Image
	Dim jo As JavaObject
	Dim JavaFile As JavaObject
	JavaFile.InitializeNewInstance("java.io.File", Array(File.Combine(Dir, FileName)))
	Dim icon As JavaObject = jo.InitializeStatic("sun.awt.shell.ShellFolder").RunMethodJO( _
     "getShellFolder", Array(JavaFile)).RunMethod("getIcon", Array(True))
	Return AwtImageToImage(icon)
End Sub

Private Sub AwtImageToImage(img As JavaObject) As Image
	Dim jo As JavaObject
	Return jo.InitializeStatic("javafx.embed.swing.SwingFXUtils").RunMethod("toFXImage", Array(img, Null))
End Sub

Sub LoadImageSamplePreserveRatio(Dir As String, FileName As String, _
     Width As Double, Height As Double) As Image
	Dim jo As JavaObject
	Dim in As InputStream = File.OpenInput(Dir, FileName)
	jo.InitializeNewInstance("javafx.scene.image.Image", Array( _
     in ,Width, Height, True, True))
	in.Close
	Return jo
End Sub

Sub MvFieldsUntil(delim As String, strValue As String, endPos As Int) As String
	Dim spValues() As String = StrParse(delim,strValue)
	Dim nList As List
	Dim nCnt As Int = 0
	nList.Initialize
	For Each strKey As String In spValues
		nList.Add(strKey)
		nCnt = nCnt + 1
		If nCnt > endPos Then 
			Exit 
		End If
	Next
	Dim sout As String = MvFromList(nList,delim)
	Return sout
End Sub

Sub ExtrasExtractProperty(sExtras As String, propName As String) As List
	Dim outL As List
	outL.Initialize
	If sExtras.length = 0 Then
		Return outL
	Else
		Dim propList As List = Json2List(sExtras)
		For Each propMap As Map In propList
			Dim propValue As String = propMap.GetDefault(propName.tolowercase,"")
			If propValue.Length > 0 Then outL.add(propValue)
		Next
		Return outL
	End If
End Sub

Sub ExtrasExtractProperty1(sExtras As String, propName As String, propName1 As String, propName1Of As String) As List
	Dim outL As List
	outL.Initialize
	If sExtras.length = 0 Then
		Return outL
	Else
		Dim propList As List = Json2List(sExtras)
		For Each propMap As Map In propList
			Dim propValue As String = propMap.GetDefault(propName.tolowercase,"")
			Dim propValue1 As String = propMap.GetDefault(propName1.ToLowerCase,"")
			If propValue1.EqualsIgnoreCase(propName1Of) = True Then
				If propValue.Length > 0 Then outL.add(propValue)
			End If
		Next
		Return outL
	End If
End Sub




Sub File_Append(dir As String, fil As String, line As String)
	Dim content As List
	content.Initialize
	If File.Exists(dir,fil) = True Then 
		content = File.ReadList(dir,fil)
	End If
	content.Add(line)
	File.WriteList(dir,fil,content)
End Sub

Sub MvLast(delim As String, value As String) As String
	Dim tot As Int = MvCount(value,delim)
	Return MvField(value,tot,delim)
End Sub

Sub TabPaneSetMinWidthHeight(tp As TabPane, width As Double, height As Double)
	Dim jo As JavaObject = tp
	jo.RunMethod("setTabMinWidth", Array(width))
	jo.RunMethod("setTabMinHeight", Array(height))
End Sub

Sub TabPaneDisableAllTabsExceptOf(TabPane As TabPane, page As TabPage)
	For Each tp As TabPage In TabPane.Tabs
		Dim jo As JavaObject = tp
		jo.RunMethod("setDisable", Array(tp <> page))
	Next
End Sub

'Description: set the page of a TabPage in a TabPane
'tag: tabpane, tagpage
Sub TabPageSetText(tbPane As TabPane, idx As Int, Text As String)
	Dim tbPageList As List = tbPane.Tabs
	Dim tbPage As TabPage = tbPageList.Get(idx)
	tbPage.Text = Text
End Sub

Sub TabPageFindPos(tbPane As TabPane, Text As String) As Int
	Dim cntPos As Int
	Dim cntTot As Int = tbPane.Tabs.Size - 1
	For cntPos = 0 To cntTot
		Dim tbPage As TabPage = tbPane.Tabs.Get(cntPos)
		If tbPage.Text.EqualsIgnoreCase(Text) Then
			Return cntPos
		End If
	Next
	Return -1
End Sub

Sub TabPageSetView(tbPage As TabPage, imgView As ImageView)
	Dim jo As JavaObject = tbPage
	jo.RunMethod("setGraphic", Array(imgView))
End Sub

'this will be used for the background color of the alphabets of the senders
public Sub AlphaColorCode(sPrefix As String) As String
	Select Case sPrefix.ToLowerCase
		Case "a"
			Return "red darken-3"
		Case "b"
			Return "pink darken-3"
		Case "c"
			Return "purple darken-3"
		Case "d"
			Return "deep-purple darken-3"
		Case "e"
			Return "blue darken-3"
		Case "f"
			Return "indigo darken-3"
		Case "g"
			Return "light-blue darken-3"
		Case "h"
			Return "cyan darken-3"
		Case "i"
			Return "teal darken-3"
		Case "j"
			Return "green darken-3"
		Case "k"
			Return "lime darken-3"
		Case "l"
			Return "light-green darken-3"
		Case "m"
			Return "yellow darken-3"
		Case "o"
			Return "orange darken-3"
		Case "p"
			Return "deep-orange darken-3"
		Case "q"
			Return "brown darken-3"
		Case "r"
			Return "grey darken-3"
		Case "s"
			Return "red darken-1"
		Case "t"
			Return "indigo darken-1"
		Case "u"
			Return "blue darken-1"
		Case "v"
			Return "teal darken-1"
		Case "w"
			Return "green darken-1"
		Case "x"
			Return "pink darken-1"
		Case "y"
			Return "orange darken-1"
		Case "z"
			Return "cyan darken-1"
		Case Else
			Return "light-blue darken-1"
	End Select
End Sub

Public Sub SplitWords(s As String) As String()
    Return Regex.Split(s, "\W+")
End Sub
	
Sub TreeViewItemSetColorImage(ti As TreeItem, Color As Paint, dir As String, img As String)
	Dim FontSize As Int = 12
	Dim jo As JavaObject = ti
	Dim ft As Font = fx.DefaultFont(FontSize)
	Dim text As String = ti.Text
	If text.Length = 0 Then
		Dim p As Pane = jo.RunMethod("getGraphic", Null)
		text = p.Tag
	End If
	Dim tf As TextFlow
	tf.Initialize
	tf.AddImage(dir,img).AddText(" ").AddText(text).SetColor(Color).SetFont(ft)
	Dim p As Pane = tf.CreateTextFlow
	p.Tag = text
	ti.Text = ""
	jo.RunMethod("setGraphic", Array(p))
End Sub

Sub TreeViewItemGetText(ti As TreeItem) As String
	If ti.IsInitialized Then
		Dim jo As JavaObject = ti
		Dim text As String = ti.Text
		If text.Length = 0 Then
			Dim p As Pane = jo.RunMethod("getGraphic", Null)
			text = p.Tag
		End If
		Return text
	Else
		Return ""
	End If
End Sub

Sub TreeViewItemSetColor(ti As TreeItem, Color As Paint)
	If ti.IsInitialized Then
		Dim FontSize As Int = 12
		Dim jo As JavaObject = ti
		Dim ft As Font = fx.DefaultFont(FontSize)
		Dim text As String = ti.Text
		Dim img As Image = ti.Image
		'if the text is blank, search the tag property
		If text.Length = 0 Then
			Dim pi As ImageView = jo.RunMethod("getGraphic", Null)
			text = pi.Tag
			'Log("set: " & text)
		End If
		Dim tf As TextFlow
		tf.Initialize
		tf.AddImage2(img,text).Addtext(" ").AddText(text).SetColor(Color).SetFont(ft) 
		Dim p As Pane = tf.CreateTextFlow
		p.Tag = text
		ti.Text = ""
		jo.RunMethod("setGraphic", Array(p))
	End If
End Sub

Sub iif(Expression2Evaluate As String, ReturnIfTrue As Object, ReturnIfFalse As Object) As Object
	If Expression2Evaluate = True Then Return ReturnIfTrue Else Return ReturnIfFalse
End Sub

Sub ProperCase(myStr As String) As String
	Try
		Dim x As String
		Dim j, k As Int
		myStr = myStr.tolowercase
		x = myStr.ToUpperCase.CharAt(0)
		myStr = x & myStr.SubString2(1, myStr.Length)
		For j = 1 To myStr.Length
			k = myStr.IndexOf2(" ", j + 1)
			If k = -1 Then Exit
			x = myStr.ToUpperCase.CharAt(k + 1)
			myStr = myStr.SubString2(0, k + 1) & x & myStr.SubString2(k + 2, myStr.Length)
		Next
		Return myStr
	Catch
		Return myStr
	End Try
End Sub

public Sub ListViewGetItemText(lstView As ListView, idxPos As Int) As String
	Dim ap As AnchorPane
	Dim title As Label
	ap = lstView.items.Get(idxPos)
	title = ap.GetNode(0)
	Return title.text
End Sub

Sub ChooseDirectory(frm As Form, Title As String) As String
	Dim dc As DirectoryChooser
	dc.Initialize
	dc.Title = Title
	Dim chosen As String = dc.Show(frm)
	Return chosen
End Sub

Sub JavaGetFilePath(path As String) As String
	' Define the JavaObject
	Dim fileO As JavaObject
	' Get the fileio class
	fileO.InitializeNewInstance("java.io.File", Array As Object(path))
	' Getthe filename and path
	Dim n As String = fileO.RunMethod("getName", Null)
	Dim p As String = fileO.RunMethod("getPath", Null)
	p = p.Replace(n, "")
	Return p
End Sub

Sub OpenSaveFileDialog(frm As Form,OpenFlag As Boolean,Title As String,InitialDirectory As String,Extensions As List) As String
	Try
		If Extensions = Null Then
			Dim lst As List
			lst.Initialize 
			lst.Add("*.*")
			Extensions = lst
		End If
	Dim f As FileChooser
	f.Initialize
	f.Title = Title
	f.SetExtensionFilter("All Files",Extensions)
	If File.IsDirectory("",InitialDirectory) = True Then
		f.InitialDirectory = InitialDirectory
	End If
	' open a project file
	If OpenFlag Then
		Dim fileName = f.ShowOpen(frm) As String
	Else
		Dim fileName = f.ShowSave(frm) As String
	End If
	Return fileName
	Catch
		Return ""
	End Try
End Sub

Sub FormatSourceCode(dir As String, fil As String)
	Dim clsCM As clsCodeModule
	clsCM.Initialize(dir, fil)
	clsCM.Code_Beautify
	clsCM.save
End Sub

Sub CodeFormatter(strCode As String) As String
	Try
		File.WriteString(File.DirApp,"code.txt",strCode)
		Dim clsCM As clsCodeModule
		clsCM.Initialize(File.DirApp,"code.txt")
		clsCM.Code_Beautify
		clsCM.save
		Return File.ReadString(File.DirApp,"code.txt")
	Catch
		Return strCode
	End Try
End Sub

Sub JsonFile2Map(dir As String, fil As String) As Map
	Dim m As Map
	m.initialize
	Dim contents As String = File.ReadString(dir,fil)
	m = Json2Map(contents)
	Return m
End Sub

Sub OpenFile(sPath As String)
	If File.Exists("",sPath) = True Then
		fx.ShowExternalDocument(File.GetUri("",sPath))
	End If
End Sub


Sub OpenFile1(dir As String, sPath As String)
	If File.Exists(dir,sPath) = True Then
		fx.ShowExternalDocument(File.GetUri(dir,sPath))
	End If
End Sub

'set the child nodes to have a particular image
Public Sub TreeViewSetChildImages(thisNode As TreeItem, img As Image)
	If thisNode <> Null Then
		If thisNode.IsInitialized = True Then
			If thisNode.Children.Size > 0 Then
				For i = 0 To thisNode.Children.Size - 1
					Dim thisItem As TreeItem
					thisItem = thisNode.children.get(i)
					thisItem.Image = img
				Next
			End If
		End If
	End If
End Sub

Sub SetTreeViewItemColor(tv As TreeItem, color As Paint)
	Dim joRect As JavaObject = tv
	joRect.RunMethod("setFill", Array(color))
End Sub

Public Sub CSSUtils_SetTextColor(Node As Node, Color As Paint)
	CSSUtils.SetStyleProperty(Node, "-fx-text-color", CSSUtils.ColorToHex(Color))
End Sub


Sub InformUser(frm As Form,sTitle As String, sText As String)
	'cutils.ShowNotification(sTitle, sText, cutils.ICON_INFORMATION)
	cutils.ShowNotification3(sTitle, sText, cutils.ICON_INFORMATION, frm, "TOP_RIGHT",3000)
End Sub


Sub InformUserError(frm As Form, sTitle As String, sText As String)
	cutils.ShowNotification3(sTitle, sText, cutils.ICON_ERROR, frm, "TOP_RIGHT",3000)
End Sub

Sub InformUser1(sTitle As String, sText As String, Frm As Form, location As String)
	If location = "" Then location = "BOTTOM_CENTER"
	cutils.ShowNotification3(sTitle, sText, cutils.ICON_INFORMATION, Frm, location,5000)
End Sub


'get sequences of the sizes to add
Sub ListGetSequences(lst As List) As List
	Dim l As List
	l.Initialize
	l.AddAll(lst)
	Dim l2 As List = FindSequences(l)
	Return l2
End Sub


'detect sequences within the list of sizes to add: thanks to JordiCP for this
Sub FindSequences(srcList As List) As List
	Dim dstList As List
	dstList.initialize
	Dim currentSequencePair As sequencePair
	currentSequencePair.initialize
	currentSequencePair.value=srcList.Get(0)
	currentSequencePair.numTimes=1
	For k=1 To srcList.size-1  '<-- edited!! (originally was 0)
		Dim newVal As Int=srcList.Get(k)
		If newVal=currentSequencePair.value Then
			currentSequencePair.numTimes=currentSequencePair.numTimes+1
		Else
			dstList.Add(currentSequencePair)
			Dim currentSequencePair As sequencePair
			currentSequencePair.initialize
			currentSequencePair.value = newVal
			currentSequencePair.numTimes=1
		End If
	Next
	If currentSequencePair.numTimes>0 Then dstList.add(currentSequencePair)
	Return dstList
End Sub

private Sub ToolTipToImageView(iv As ImageView, msg As String, add As Boolean)
	Dim joToolTip As JavaObject
	Dim joToolTip2 As JavaObject = joToolTip.InitializeNewInstance("javafx.scene.control.Tooltip", Array(msg))
	If add = True Then
		joToolTip.RunMethod("install", Array(iv, joToolTip2))
	Else
		joToolTip.RunMethod("uninstall", Array(iv, joToolTip2))
	End If
End Sub

Sub UnescapeUnicode(s As String) As String
   Dim sb As StringBuilder
   sb.Initialize
   Dim i As Int
   Do While i < s.Length
      Dim c As Char = s.CharAt(i)
      If c = "\" And i < s.Length - 1 And s.CharAt(i + 1) = "u" Then
         Dim unicode As StringBuilder
         unicode.Initialize
         i = i + 2
         Do While i < s.Length
            Dim cc As String = s.CharAt(i)
            Dim n As Int = Asc(cc.ToLowerCase)
            If (n >= Asc("0") And n <= Asc("9")) Or (n >= Asc("a") And n <= Asc("z")) Then
               unicode.Append(s.CharAt(i))
            Else
               i = i - 1
               Exit
            End If
            i = i + 1
         Loop
         sb.Append(Chr(Bit.ParseInt(unicode.ToString, 16)))
      Else
         sb.Append(c)
      End If
      i = i + 1
   Loop
   Return sb.ToString
End Sub

Sub Map2Map(readFrom As Map, putIn As Map, keys As List, bLower As Boolean)
	Dim value As Object
	For Each strKey As String In keys
		If bLower = True Then strKey = strKey.ToLowerCase
		If readFrom.ContainsKey(strKey) Then
			value = readFrom.Get(strKey)
			putIn.Put(strKey,value) 
		End If
	Next
End Sub

Sub JoinMaps(oldMap As Map, map2Append As Map) As Map
	For Each strKey As Object In map2Append.Keys
		Dim strValue As Object = map2Append.Get(strKey)
		oldMap.Put(strKey,strValue)
	Next
	Return oldMap
End Sub

Sub CopyMap(oldMap As Map) As Map
	Dim oldValue As Object
	Dim nMap As Map
	nMap.Initialize 
	For Each strKey As String In oldMap.keys
		oldValue = oldMap.Get(strKey)
		nMap.Put(strKey,oldValue)
	Next
	Return nMap
End Sub


'break a string at uppercase to have a space
public Sub BreakAtUpperCase(st As String) As String
	If st.Length = 0 Then Return ""
	Dim k As Int
    Dim s As String
    Dim newst As String = st.CharAt(0)
    For i = 1 To st.Length - 1
        s = st.CharAt(i)
        k = Asc(s)
        If k>64 And k < 91 And st.CharAt(i-1) <> " " Then
            newst = newst & " " & s
        Else
            newst = newst & s
        End If
    Next
	Return newst
End Sub

'Public Sub Str2ProperCase(sValue As String) As String
'    Dim iPos As Int
'    Dim iSpace As String = ""
'    Dim sTemp As String = ""
'	iPos = 1
'    sValue = LCase(sValue)
'    Do While InStr(iPos, sValue, " ", 1) <> 0
'	    iSpace = InStr(iPos, sValue, " ", 1)
'        sTemp = sTemp & UCase(Mid(sValue, iPos, 1))
'        sTemp = sTemp & LCase(Mid(sValue, iPos + 1, iSpace - iPos))
'        iPos = iSpace + 1
'    Loop
'
'    sTemp = sTemp & UCase(Mid(sValue, iPos, 1))
'    sTemp = sTemp & LCase(Mid(sValue, iPos + 1))
'    Return sTemp
'End Sub

Sub Pad(Value As String, MaxLen As Int, PadChar As String, bRight As Boolean) As String
    Dim  intOrdNoLen As Int = Value.Length
    Dim i As Int
    For i = 1 To (MaxLen - intOrdNoLen) Step 1
        If bRight Then
            Value =  Value & PadChar
        Else
            Value = PadChar & Value
        End If
    Next
    Return Value
End Sub

Sub PadRight(Value As String, MaxLen As Int, PadChar As String) As String
	Dim intOrdNoLen As Int = Len(Value)
	Dim i As Int
	For i = 1 To (MaxLen - intOrdNoLen) Step 1
   		Value = PadChar & Value
	Next
	Return Value
End Sub

'return double clicked item from treeview
Sub TreeViewDoubleClick(EventData As MouseEvent) As TreeItem
	Dim jo As JavaObject = EventData
   	Dim target As JavaObject = jo.RunMethodJO("getTarget", Null)
   	Do Until target Is TreeView
     If GetType(target) = "com.sun.javafx.scene.control.skin.TreeViewSkin$1" Then
       Dim ti As TreeItem = target.RunMethod("getTreeItem", Null)
       Log($"Clicked tree item: ${ti}"$)
       If EventData.ClickCount = 2 Then
	   	Return ti
       End If
       Exit
     End If
     Dim n As Node = target
     target = n.Parent
   Loop
   Return Null
End Sub

Sub CreateStatusBar(status As StatusBar)
	'add the status bar at the bottom
	status.Text = "Conceptualized, Designed and Developed by Anele 'Mashy' Mbanga - anele@mbangas.com"
	'status.RightItems.AddAll(Array(btnFullScreen,btnSnap))
End Sub

Sub RenameFolder(oldPath As String, newPath As String)	
	Dim jo1, jo2 As JavaObject
	jo1.InitializeNewInstance("java.io.File", Array(oldPath))
	jo2.InitializeNewInstance("java.io.File", Array(newPath))
	Log(jo1.RunMethod("renameTo", Array(jo2)))
End Sub


'Returns a new date from the date passed plus or minus HowManyDays. Pass mDate as String, 
'HowManyDays As Int. HowManyDays can be positive or negitive numbers.
'
'DateDue = DateNew("02/04/2012", 90)
Sub DateAdd(mDate As String, HowManyDays As Int) As String
	Dim ConvertDate, NewDateDay As Long
	ConvertDate = DateTime.DateParse(mDate)
	NewDateDay = DateTime.Add(ConvertDate, 0, 0, HowManyDays)
	Return DateTime.Date(NewDateDay)
End Sub

'Returns the number of days that have passed between two dates.
'Pass the dates as a String
Sub DateNOD(CurrentDate As String, OtherDate As String) As Int
	Dim CurrDate, OthDate As Long
	CurrDate = DateTime.DateParse(CurrentDate)
	OthDate = DateTime.DateParse(OtherDate)
	Return (CurrDate-OthDate)/(DateTime.TicksPerDay)
End Sub
'Returns the systems date as a String
Sub Date() As String
	Return DateTime.Date(DateTime.Now)
End Sub

public Sub LoadTable2View(db As SQL, TableName As String, qryBox As TextArea, tblView As TableView)
	Try
	Dim t As List
	t = DBUtils.ExecuteMemoryTable(db, "PRAGMA table_info ('" & TableName & "')", Null, 0)
	Dim query As StringBuilder
	query.Initialize
	query.Append("SELECT ")
	For i = 0 To t.Size - 1
		Dim values() As String
		values = t.Get(i) 't is a list of arrays
		query.Append("[").Append(values(1)).Append("]").Append(",")
	Next
	query.Remove(query.Length - 1, query.Length) 'remove last comma
	query.Append(" FROM ").Append(TableName)
	qryBox.Text = query.tostring
	DBUtils.ExecuteTableView(db,query.ToString,Null,500,tblView)
	Catch
		Log("LoadTable2View: " & LastException)
	End Try
End Sub


'Just retrieves the list as I do that in a couple of places. Inherent laziness.
Sub ReadRecentItemsList() As List
    Dim recentList As List
    recentList.Initialize
    If File.IsDirectory(File.DirApp, "recentitems.lib") = False Then
        If File.Exists(File.DirApp, "recentitems.lib") = True Then
            recentList = File.ReadList(File.DirApp, "recentitems.lib")
        End If
    End If
    Return recentList
End Sub

'When the app loads, I clean up the list by removing anyting the user has deleted. I'll be adding a "Delete Profile" later today.
Sub cleanupRecentItems
    Dim listWrite As List
    listWrite.Initialize
    listWrite.Clear
    Dim recentFilesList As List
    recentFilesList.Initialize
    recentFilesList = ReadRecentItemsList
    Dim strLine As String
    Dim strLinePath As String
    Dim strLineName As String
    For i = 0 To recentFilesList.Size - 1
       If recentFilesList.Get(i) <> "" Then
            strLine = recentFilesList.Get(i)
            If strLine.IndexOf("|") > 0 Then
                strLinePath = strLine.SubString2(0, strLine.IndexOf("|"))
                strLineName = strLine.SubString(strLine.IndexOf("|") + 1)
                If strLinePath <> "" And strLineName <> "" Then
                    If File.Exists(strLinePath, strLineName) = True Then
                        listWrite.Add(strLine)
                    End If
                End If
            End If
       End If
    Next
	If listWrite.Size = 0 Then
	    File.Delete(File.DirApp, "recentitems.lib")
    Else 
	   File.WriteList(File.DirApp, "recentitems.lib", listWrite)
    End If
End Sub

'This is what saves the last file opened or created to the recent items list.
Sub SaveLastFile(strPath As String, strFile As String)
    Dim listWrite As List
    listWrite.Initialize
    listWrite.Add(strPath & "|" & strFile)
    File.WriteList(File.DirApp, "lastfile.lib", listWrite)
End Sub

Sub Assign2TextField(txt As TextField, m As Map, fld As String)
	txt.text = m.get(fld)
End Sub

Sub AssignTextField2Map(txt As TextField, m As Map, fld As String)
	m.put(fld, txt.Text)
End Sub

'run script to convert
Sub RunWSH(sPath As String, sParameters As String, ProjectPath As String, bOperation As String)
	Dim shl As Shell
	Dim lstParams As List: lstParams.Initialize
	Try
		' define the script to execute pass it the BAL and BIL files
		sPath = InQuotes(sPath)
		lstParams.Add(sParameters)
		shl.Initialize("shl", sPath, lstParams)
		Select Case bOperation
		Case "buildapp"
			shl.WorkingDirectory = ProjectPath
		Case "exeapp"	
			shl.WorkingDirectory = ProjectPath & "\Objects"
		End Select
  		shl.Run(-1)
	Catch
	Log("RunWSH: " & LastException.Message)
	End Try
End Sub






'***********************************************

'from rwblinn
'Adds a separator menu item
'Example call: AddMenuSeparator(MenuBar1, 0) where 0 is the first menu item
Sub RecentItemsAddSeparator(mBar As MenuBar, menuidx As Int)
    Dim joSepMi As JavaObject
    joSepMi.InitializeNewInstance("javafx.scene.control.SeparatorMenuItem", Null)
    Dim mnu As Menu = mBar.Menus.Get(menuidx)
    mnu.MenuItems.Add(joSepMi)
End Sub

'This subroutine takes the file either opened or saved and writes it to
'the recent items file. I add the file path and name to a Map to make sure
'I don't have duplicates without specifically testing each one. I use a pipe
'delimeter as that's what I'm used to. I want the flexibility of changing how
'I express the file name as well. Either that, or I could also extract the
'filepath and filename, I did what I was comfortable with for now, to get it working.
Sub SaveRecentItems(strPath As String, strFile As String)
    Dim recentItemsMap As Map
    recentItemsMap.Initialize
    recentItemsMap.Put(strPath & "|" & strFile, "1")
    If File.IsDirectory(File.dirapp, "recentitems.lib") = False Then
        If File.Exists(File.dirapp, "recentitems.lib") = True Then
            Dim recentItemsList As List
            recentItemsList.Initialize
            recentItemsList = ReadRecentItemsList
            If recentItemsList.Size > 0 Or recentItemsList.Get(0) <> "" Then
                For i = 0 To recentItemsList.Size - 1
                    recentItemsMap.Put(recentItemsList.Get(i), "1")
                Next
               
            End If
        End If
    End If
    Dim listWrite As List
    listWrite.Initialize
    For Each mapkey As String In recentItemsMap.Keys
        listWrite.Add(mapkey)
    Next
    File.WriteList(File.DirApp, "recentitems.lib", listWrite)
End Sub


Public Sub ConsolidateMaps(oldMap As Map, addMap As Map) As Map
	Dim nMap As Map = oldMap
	Dim strValue As String
	For Each strKey As String In addMap.Keys
		strValue = addMap.Get(strKey)
		nMap.Put(strKey.tolowercase,strValue)
	Next
	Return nMap
End Sub

Sub InStrRev(value As String, search As String) As Long
	Return value.tolowercase.LastIndexOf(search.tolowercase) + 1
End Sub

public Sub Code_Arguements(strDeclaration As String) As String
	Dim fBracket As Long
	Dim sBracket As Long
	Dim line As String
	'first first bracket
	fBracket = InStr(strDeclaration, "(")
	'find last bracket
	sBracket = InStrRev(strDeclaration, ")")
	If fBracket = -1 Or sBracket = 0 Then Return ""
	Select Case sBracket
	Case fBracket + 1
		Return ""
	Case Else
		line = Mid2(strDeclaration, fBracket + 1, (sBracket - fBracket - 1))
		Return line
	End Select
End Sub


Sub MvFromDelimitedString(Delim As String, Value As String, ValueDelim As String) As String
	Dim sp() As String
	Dim sb As StringBuilder
	Dim pCnt As Int
	Dim pTot As Int
	Dim strValue As String
	sb.Initialize 
	sp = StrParse(ValueDelim,Value)
	pTot = sp.Length - 1 
	For pCnt = 0 To pTot - 1
		strValue = sp(pCnt)
		sb.Append(strValue).Append(" & ").Append(InQuotes(Delim))
		If pCnt <> (pTot - 1) Then sb.Append(" & ")
	Next
	strValue = sp(pTot)
	sb.Append(" & ").Append(strValue)
	Return sb.tostring
End Sub

Sub ToHTML(svalue As String, sFont As String) As String
	Dim sb As StringBuilder
	sb.Initialize 
	sb.Append("<html>").Append(CRLF)
	sb.append("<head>").Append(CRLF)
	sb.Append("<style>.f{font-family:").Append(QUOTE).Append(sFont).Append(QUOTE).Append(";}</style>").Append(CRLF)
	sb.Append("</head>").Append(CRLF)
	sb.Append("<body>").Append(CRLF)
	sb.Append("<p class=f>").Append(svalue).Append("</p>").Append(CRLF)
	sb.Append("</body></html>")
	Return sb.ToString
End Sub


Sub AssetFileToEditText(txt As TextField, fn As String)
	Dim fc As String
	fc = File.ReadString(File.DirAssets,fn)
	txt.Text = fc
End Sub

Sub AssetFileToWebView(webV As WebView, fn As String)
	Dim fc As String
	fc = File.ReadString(File.DirAssets,fn)
	fc = fc.Replace(Chr(13), "<br /><br />")
	webV.LoadHtml(ToHTML(fc,"Arial"))
End Sub

Sub FileToWebView(webV As WebView, dir As String, fn As String)
	Dim fc As String
	fc = File.ReadString(dir,fn)
	fc = fc.Replace(Chr(13), "<br /><br />")
	webV.LoadHtml(ToHTML(fc,"Arial"))
End Sub

Sub GetCanonicalFilePath(fullpath As String) As String
    Dim joFileSource As JavaObject
    joFileSource.InitializeNewInstance("java.io.File", Array As Object(fullpath))
    Return joFileSource.RunMethod("getCanonicalFile", Null)
End Sub

private Sub Trim(strValue As String) As String
	Return strValue.trim
End Sub

public Sub List2Array (a_lstArgs As List) As String()
    Dim arrArgs(a_lstArgs.Size) As String
    For i = 0 To arrArgs.Length - 1
        arrArgs(i) = a_lstArgs.Get(i)
    Next
    Return arrArgs
End Sub

'show an hourglass
Sub ShowHourGlass(frm As Form)
	Dim mouseType As String = "HAND"
	frm.RootPane.MouseCursor = fx.Cursors.DEFAULT
	If mouseType = LastMouseCursor Then Return
	Dim cursor As JavaObject
	cursor.InitializeStatic("javafx.scene.Cursor")
	Dim joObj As JavaObject = frm.RootPane
	joObj.RunMethod("setCursor", Array(cursor.GetField(mouseType)))
	LastMouseCursor = mouseType
End Sub

' hide the hour glass
Sub HideHourGlass(frm As Form)
	Dim mouseType As String = "DEFAULT"
	frm.RootPane.MouseCursor = fx.Cursors.DEFAULT
	If mouseType = LastMouseCursor Then Return
	Dim cursor As JavaObject
	cursor.InitializeStatic("javafx.scene.Cursor")   
	Dim joObj As JavaObject = frm.RootPane
	joObj.RunMethod("setCursor", Array(cursor.GetField(mouseType)))
	LastMouseCursor = mouseType
End Sub

'generate a class like structure for the material design icons
Sub IconsClassCreator(dir As String, filename As String, prefix As String)
	If File.Exists(dir,filename) = False Then Return
	Dim mdi As List = File.ReadList(dir,filename)
	Dim dims As List
	Dim declares As List
	Dim masterList As List
	dims.Initialize
	declares.Initialize
	masterList.Initialize
	masterList.Add("Dim " & prefix & " As List")
	masterList.Add(prefix & ".Initialize") 
	For Each strLine As String In mdi
		strLine = Mid(strLine,2)
		strLine = prefix & "-" & strLine.trim
		Dim strDim As String = strLine.Replace("-","_")
		Dim strDim1 As String = $"Dim ${strDim} As String = """$
		dims.Add(strDim1)
		Dim strDeclare As String = $"${strDim} = "${strLine}""$
		Dim strList As String = $"${prefix}.Add("${strLine}")"$
		masterList.Add(strList)
		declares.Add(strDeclare)
	Next
	Dim sout As String = Join(CRLF,dims)
	sout = sout & CRLF & "*****" & CRLF & Join(CRLF,declares)
	sout = sout & CRLF & "*****" & Join(CRLF,masterList)
	File.WriteString(dir,"Icons.txt",sout)
End Sub

Sub GetAlpha(value As String) As String
	Dim strCnt As Int
	Dim str As String
	Dim sb As StringBuilder
	sb.Initialize 
	Dim master As String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	For strCnt = 0 To value.Length - 1
		str = value.CharAt(strCnt)
		If master.IndexOf(str) >= 0 Then
			sb.Append(str) 	 
		End If
	Next
	Return sb.tostring
End Sub

Sub GetAlpha1(value As String) As String
	Dim strCnt As Int
	Dim str As String
	Dim sb As StringBuilder
	sb.Initialize 
	Dim master As String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ~?!',;:-"
	For strCnt = 0 To value.Length - 1
		str = value.CharAt(strCnt)
		If master.IndexOf(str) >= 0 Then
			sb.Append(str) 	 
		End If
	Next
	Return sb.tostring
End Sub

Sub GetAlphaNumeric(value As String) As String
	Dim strCnt As Int
	Dim str As String
	Dim sb As StringBuilder
	sb.Initialize 
	Dim master As String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_-"
	For strCnt = 0 To value.Length - 1
		str = value.CharAt(strCnt)
		If master.IndexOf(str) >= 0 Then
			sb.Append(str) 	 
		End If
	Next
	Return sb.tostring
End Sub

Sub Alpha(value As String) As String
	Dim strCnt As Int
	Dim str As String
	Dim sb As StringBuilder
	sb.Initialize 
	Dim master As String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
	For strCnt = 0 To value.Length - 1
		str = value.CharAt(strCnt)
		If master.IndexOf(str) >= 0 Then
			sb.Append(str) 	 
		End If
	Next
	Return sb.tostring
End Sub

'return project days
Sub ProjectDays(sDays As String) As String
	Try
		sDays = sDays.trim
		If sDays = "" Then sDays = "0"
		sDays = sDays.Replace(",","")
		sDays = NumberFormat2(sDays,0,0,0,True)
		Return sDays & " Dys"
	Catch
		Return "0 Dys"
	End Try
End Sub

''Verify a donor
'Sub VerifyDonator(Salt As String) As Boolean
'	Try
'		If EmailAddress.trim = "" Or LicensePath.Trim = "" Then Return False
'		Dim b() As Byte = FileToBytes(LicensePath,EmailAddress)
'		Dim Cipher As B4XCipher
'		'use the donator key string saved
'		'Dim b() As Byte = Bconv.HexToBytes(DonatorKey)
'		Dim bb() As Byte = Cipher.Decrypt(b, Salt)
'		Dim ss As String = Bconv.StringFromBytes(bb, "UTF8")
'		If ss = EmailAddress Then
'			Return True
'		Else
'			Log("This is a donators component, please get your DonatorKey to use this!")
'			Return False
'		End If
'	Catch
'		Log("This is a donators component, please get your DonatorKey to use this!")
'		Return False
'	End Try
'End Sub
'
''Create a license file
'private Sub CreateLicense(UserEmail As String,Salt As String)
'	Dim Cipher As B4XCipher
'	Dim s As String = UserEmail
'	Dim b() As Byte = Cipher.Encrypt(s.GetBytes("UTF8"), Salt)
'	BytesToFile(File.DirApp,UserEmail,b)
'	'write as string to file
'	'Dim encryt As String = Bconv.HexFromBytes(b)
'	'File.WriteString(File.DirApp,UserEmail,encryt)
'End Sub
'
''Convert bytes to a file
'private Sub BytesToFile (Dir As String, FileName As String, Data() As Byte)
'	Dim out As OutputStream = File.OpenOutput(Dir, FileName, False)
'	out.WriteBytes(Data, 0, Data.Length)
'	out.Close
'End Sub
'
''Convert a file to bytes
'private Sub FileToBytes (Dir As String, FileName As String) As Byte()
'	Return Bit.InputStreamToBytes(File.OpenInput(Dir, FileName))
'End Sub

'Format file sizes
Sub FormatFileSize(Bytes As Float) As String
	Try
		Private Unit() As String = Array As String(" Byte", " KB", " MB", " GB", " TB", " PB", " EB", " ZB", " YB")
		If Bytes = 0 Then
			Return "0 Bytes"
		Else
			Private Po, Si As Double
			Private I As Int
			Bytes = Abs(Bytes)
			I = Floor(Logarithm(Bytes, 1024))
			Po = Power(1024, I)
			Si = Bytes / Po
			Return NumberFormat(Si, 1, 3) & Unit(I)
		End If
	Catch
		Return "0 Bytes"
	End Try
End Sub

Sub GetNumbers(value As String) As String
	Dim strCnt As Int
	Dim str As String
	Dim sb As StringBuilder
	sb.Initialize 
	Dim master As String = "0123456789-."
	For strCnt = 0 To value.Length - 1
		str = value.CharAt(strCnt)
		If master.IndexOf(str) >= 0 Then
			sb.Append(str) 	 
		End If
	Next
	Return sb.tostring
End Sub

Sub MsgBoxYesNoCancel(pForm As Form, title As String, msg As String) As String
	Dim res As Int
	res = fx.Msgbox2(pForm, msg, title, "Yes", "Cancel", "No", fx.MSGBOX_CONFIRMATION)
	Return DialogResponse(res)	
End Sub

Sub MsgBoxError(pForm As Form, title As String, Msg As String)
	fx.Msgbox2(pForm, Msg, title, "Ok", "","", fx.MSGBOX_WARNING)
End Sub

Sub MsgBoxInform(pform As Form, title As String, Msg As String)
	fx.Msgbox2(pform,Msg,title,"Ok","","",fx.MSGBOX_INFORMATION)
End Sub

Sub MsgBoxConfirm(pForm As Form, title As String, Msg As String) As String
	Dim res As Int
	res = fx.Msgbox2(pForm, Msg, title, "Yes", "","No", fx.MSGBOX_CONFIRMATION)
	Return DialogResponse(res)	
End Sub

Sub MsgBoxWarn(pForm As Form, title As String, Msg As String)
	fx.Msgbox2(pForm, Msg, title, "Ok", "","", fx.MSGBOX_WARNING)
End Sub

private Sub DialogResponse(res As Int) As String
	Select Case res
	Case fx.DialogResponse.POSITIVE
		Return "yes"
	Case fx.DialogResponse.CANCEL
		Return "cancel"
	Case Else
		Return "no"  
	End Select
End Sub

Sub MapLowerKeys(m As Map) As Map
	Dim nm As Map
	nm.initialize
	For Each strKey As String In m.Keys
		Dim objValue As Object = m.Get(strKey)
		If objValue = Null Then objValue = ""
		nm.Put(strKey.ToLowerCase,objValue)
	Next
	Return nm
End Sub

Sub Enclose(value As String, enclosure As String) As String
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append(enclosure).Append(value).Append(enclosure)
	Return sb.tostring 
End Sub

'remove all default values
Sub RemoveDefaults(om As Map, dm As Map) As Map
	'lets save this to a temporal map
	Dim tmpMap As Map
	tmpMap.Initialize
	tmpMap = om
	For Each strKey As String In dm.Keys
		' read the original map
		Dim strValue As String = dm.Get(strKey)
		' compare the key value to the temp value, if same, remove
		Dim tmpValue As String = om.Get(strKey)
		If strValue = tmpValue Then
			tmpMap.Remove(strKey)
		End If
	Next
	Return tmpMap	
End Sub

Sub MapRemoveNulls(dm As Map) As Map
	Dim tmpMap As Map
	Dim strValue As String
	tmpMap.Initialize
	For Each strKey As String In dm.Keys
		If dm.GetDefault(strKey,Null) = Null Then
			strValue = ""
		Else
			strValue = dm.Get(strKey)
		End If
		tmpMap.Put(strKey,strValue)
	Next
	Return tmpMap	
End Sub

Sub At(Text As String,sInStr As String) As String
	Return Text.IndexOf(sInStr)
End Sub

Sub Ltrim(Text As String) As String
	Do While Left(Text, 1) =" "
		Text = Right(Text, Len(Text)-1)
	Loop
	Return Text
End Sub

Sub Rtrim(Text As String) As String
	Do While Right(Text, 1) =" "
		Text = Left(Text, Len(Text)-1)
	Loop
	Return Text
End Sub

Sub RndChrGen(Howmany As Int, CT As Int) As String
	Dim a As String =""
	Dim l As Int
	Dim u As Int
	Dim ha As Int
	If CT = 0 Then
		L=65 : U=122
	Else If CT=1 Then
		L=65 : U=90
	Else
		L=97 : U=122
	End If
	For x=1 To Howmany
		Do While Len(a) < Howmany
			ha = Rnd(L, U)
			If ha>=91 And ha<=96 Then
			Else
				a = a & Chr(ha)
			End If
		Loop
	Next
	Return a
End Sub

Sub Mid2(Text As String, istart As Int, Length As Int) As String
   Return Text.SubString2(istart-1,istart+Length-1)
End Sub

Sub Mid(Text As String, iStart As Int) As String
   Return Text.SubString(iStart-1)
End Sub

Sub FullScreen(frm As Form)
	Dim jmf As JavaObject = frm
  	Dim stage As JavaObject = jmf.GetField("stage")
  	stage.RunMethod("setFullScreen", Array As Object(True))
End Sub

'set your screen to maximize mode
Sub MaximizeStage(frm As Form)
	Dim jmf As JavaObject = frm
  	Dim stage As JavaObject = jmf.GetField("stage")
  	stage.RunMethod("setMaximized", Array As Object(True))
End Sub

Sub Maximize(frm As Form)
	frm.WindowWidth = fx.PrimaryScreen.MaxX  - fx.PrimaryScreen.MinX
   	frm.WindowLeft = fx.PrimaryScreen.MinX
   	frm.WindowHeight = fx.PrimaryScreen.MaxY - fx.PrimaryScreen.MinY
   	frm.WindowTop = fx.PrimaryScreen.MinY
End Sub

'Description: Add cssfile to a form
'Tag: css, file, add form
Sub AddCSSFile(frm As Form, cssFile As String)
	frm.Stylesheets.Add(File.GetUri(File.DirAssets, cssFile))
End Sub

' add a css file to your app, store css in dirassets
Sub AddCSSFile1(frm As Form, cssFile As String)
	'Add the CSS file to the RootPane's Scene
    Dim JO As JavaObject = frm.RootPane
    JO.RunMethodJO("getScene",Null).RunMethodJO("getStylesheets",Null).RunMethod("add",Array(File.GetUri(File.DirAssets,cssFile)))
End Sub

Sub SetRotate(n As Node, Degrees As Double)
 Dim jo As JavaObject = n
 jo.RunMethod("setRotate", Array(Degrees))
End Sub

'RunMethod(l,"setRotate",Array(45.0))
Sub RunMethod(n As JavaObject,method As String,args() As Object)
    n.RunMethod(method,args)
End Sub

Sub ListRemoveItem(lst As List, item As String)
	Dim lPos As Int = lst.IndexOf(item)
	If lPos <> -1 Then lst.RemoveAt(lPos) 
End Sub

Sub RemoveClass(mNode As Node, cssClass As String)
	Dim cssPos As Int
	cssPos = mNode.StyleClasses.IndexOf(cssClass)
	If cssPos <> -1 Then mNode.StyleClasses.RemoveAt(cssPos) 
End Sub

Sub AddClass(mNode As Node, cssClass As String, cssProp As String, bRemove As Boolean)
	If bRemove = True Then RemoveClass(mNode, cssClass)
	mNode.StyleClasses.Add(cssClass & " " & cssProp)  
End Sub

'Description: Save panel as image to a file
'Tag: panel, save, image
Sub SavePaneToImage(pnl As Pane, imgFile As String)
	Dim Out As OutputStream
    Dim TempImage As Image
	If File.Exists(File.DirApp, imgFile) Then File.Delete(File.dirapp, imgFile)
    Out = File.OpenOutput(File.dirapp, imgFile, False)
    TempImage = pnl.Snapshot
    TempImage.WriteToStream(Out)
    Out.Close
End Sub

Sub SaveSnapShot(img As Image, imgFile As String)
	If File.Exists(File.DirApp, imgFile) Then File.Delete(File.dirapp, imgFile)
	Dim Out As OutputStream = File.OpenOutput(File.dirapp, imgFile, False) 
    img.WriteToStream(Out)
    Out.Close
End Sub

'Sub MD5(str As String) As String
'    Dim data(0) As Byte   
'    Dim md As MessageDigest
'    Dim Bconv As ByteConverter
'
'    data = Bconv.StringToBytes(str, "UTF8")
'    data = md.GetMessageDigest(data, "MD5") ' can replace "MD5" with "SHA-1"
'    Return Bconv.HexFromBytes(data).ToLowerCase
'End Sub

'Description: Returns the number of delimited strings
'Tags: multi-value field, delimiter, count, split
Sub MvCount(strMV As String, Delimiter As String) As Int
	If strMV.Length = 0 Then Return 0
	Dim xPos As Int: xPos = strMV.IndexOf(Delimiter)
	If xPos = -1 Then Return 1
	Dim spValues() As String
	Delimiter = FixDelimiter(Delimiter)
	spValues = Regex.Split(Delimiter, strMV)
	Return spValues.Length 
End Sub


'CollectTreeItems(TreeList, TreeView1.Root.Children)
Private Sub CollectTreeItems(TreeItems As List, Items As List)
    For Each ti As TreeItem In Items
        Dim CheckboxItem As CheckboxTreeItem = ti
        TreeItems.Add(ti.Text & " = " & CheckboxItem.Checked)
        If ti.Children.Size > 0 Then
            CollectTreeItems(TreeItems, ti.Children)
        End If
    Next
End Sub

Sub ExecutePHP(frm As Object, pQuery As Map, JobName As String, phpFile As String, phpTag As String)
	Dim job As HttpJob
	Dim scommand As String
	Dim json As String
	job.Initialize(JobName, frm)
	job.Tag = phpTag
	json = Map2QueryString(pQuery)
	If Len(json) = 0 Then
		scommand = PhpPath & phpFile
	Else
		scommand = PhpPath & phpFile & "?" & json
	End If
	'Log(scommand)
	job.Download(scommand)
End Sub

Sub MvRemoveDuplicates(sValue As String, Delim As String) As String
	Dim nMap As Map
	nMap.Initialize
	Dim spValues() As String = StrParse(Delim,sValue)
	For Each strvalue As String In spValues
		If strvalue <> "" Then nMap.Put(strvalue,"")
	Next
	Dim sb As StringBuilder
	sb.Initialize
	For Each strKey As String In nMap.Keys
		sb.Append(strKey).Append(Delim)		
	Next
	Dim strOutput As String = sb.ToString
	strOutput = RemDelim(strOutput,Delim)
	Return strOutput
End Sub

Sub MvRemoveBlanks(sValue As String, Delim As String) As String
	Dim nMap As Map
	nMap.Initialize
	Dim spValues() As String = StrParse(Delim,sValue)
	For Each strvalue As String In spValues
		If strvalue.Trim.Length > 0 Then nMap.Put(strvalue,"")
	Next
	Dim sb As StringBuilder
	sb.Initialize
	For Each strKey As String In nMap.Keys
		sb.Append(strKey).Append(Delim)		
	Next
	Dim strOutput As String = sb.ToString
	strOutput = RemDelim(strOutput,Delim)
	Return strOutput
End Sub

Sub Map2QueryString(sm As Map) As String
    ' convert a map to a querystring string
	Dim SU As StringUtils
    Dim iCnt As Int
    Dim iTot As Int
    Dim sb As StringBuilder
	Dim mValue As String
    sb.Initialize
	
	' get size of map
    iTot = sm.Size - 1
    iCnt = 0
    For Each mKey As String In sm.Keys
        mValue = sm.Get(mKey)
		mValue = SU.EncodeUrl(mValue, "UTF8")
		mKey = mKey.Trim 
		If mKey.EndsWith("=") = False Then mKey = mKey & "="  
		sb.Append(mKey).Append(mValue)
		If iCnt < iTot Then sb.Append("&")
        iCnt = iCnt + 1
    Next
    Return sb.ToString
End Sub

Sub GetImageFromServer(frm As Object, iLink As String, JobName As String, phpTag As String)
	Dim job As HttpJob
	job.Initialize(JobName, frm)
	job.Tag = phpTag
	'Log(iLink)
	job.Download(iLink)
End Sub

Sub FixFldPrefix(sFieldName As String, sPrefix As String) As String
	sFieldName = sFieldName.Replace(sPrefix,"")
	Return sFieldName
End Sub

Sub FixJson(sFieldName As String, xIsJson As String) As String
	If xIsJson = "1" Then
		Return sFieldName
	Else
		Return LCase(sFieldName)
	End If
End Sub


Sub MapCleanNulls(m As Map)
	For Each mKey As String In m.Keys
		If m.Get(mKey) = "null" Then m.Put(mKey,"") 
  	Next
End Sub

Sub IsBlankTextArea(dlg As DialogsX, txtControl As TextArea, title As String) As Boolean
	Dim valueToCheck As String = txtControl.text
	valueToCheck = valueToCheck.trim
	If valueToCheck = "null" Then valueToCheck = "" 
	If valueToCheck.Length = 0 Then
    	Dim msg As String
		msg = "The " & title & " cannot be blank, please enter the " & title.ToLowerCase  & " to be able to continue."
		dlg.ErrorDialog(title, "Input Error", msg)
		txtControl.RequestFocus 
		Return True
	Else
        Return False
	End If
End Sub

Sub MsgBoxIsBlankTextArea(dlg As Form, txtControl As TextArea, title As String) As Boolean
	Dim valueToCheck As String = txtControl.text
	valueToCheck = valueToCheck.trim
	If valueToCheck = "null" Then valueToCheck = "" 
	If valueToCheck.Length = 0 Then
    	Dim msg As String
		msg = "The " & title & " cannot be blank, please enter the " & title.ToLowerCase  & " to be able to continue."
		MsgBoxError(dlg, title, msg)
		txtControl.RequestFocus 
		Return True
	Else
        Return False
    End If
End Sub

Sub IsBlankTextField(dlg As DialogsX, txtControl As TextField, title As String) As Boolean
	Dim valueToCheck As String = txtControl.text
	valueToCheck = valueToCheck.trim
	If valueToCheck = "null" Then valueToCheck = "" 
	If valueToCheck.Length = 0 Then
    	Dim msg As String
		msg = "The " & title & " cannot be blank, please enter the " & title.ToLowerCase  & " to be able to continue."
		dlg.ErrorDialog(title, "Input Error", msg)
		txtControl.RequestFocus 
		Return True
	Else
        Return False
    End If
End Sub

Sub IsBlankComboBox(dlg As DialogsX, cboControl As ComboBox, title As String) As Boolean
	Dim valueToCheck As String = cboControl.value
	valueToCheck = valueToCheck.trim
	If valueToCheck = "null" Then valueToCheck = "" 
	If valueToCheck.Length = 0 Then
    	Dim msg As String
		msg = "The " & title & " cannot be blank, please select the " & title.ToLowerCase  & " to be able to continue."
		dlg.ErrorDialog(title, "Input Error", msg)
		cboControl.RequestFocus 
		Return True
	Else
        Return False
    End If
End Sub

Sub PadStringRight(source As String, paddingChar As String, size As Int) As String
	Dim padLength As Int
	Dim sourceLen As Int
	Dim i As Int
	Dim padStr As StringBuilder
	sourceLen = Len(source)
	padLength = size - sourceLen
	If sourceLen < size Then
		padStr.Initialize 
		For i = 1 To padLength
			padStr.Append(paddingChar)
		Next
   		source = padStr.tostring & source
	End If
	Return source
End Sub

'Description: Remove an item from the treeview using its text property
'Tag: treeview, remove, item
Sub TreeViewRemoveItem(tvItem As TreeItem, itmName As String)
	If itmName.Length > 0 Then
		Dim ti As TreeItem = TreeViewSearch(tvItem,itmName)
		If ti.IsInitialized Then TreeItemDelete(ti) 
	End If
End Sub

Sub TreeViewAddChild(parentItem As TreeItem, itmName As String, img As Image) As TreeItem
	Dim ctv As TreeItem
	ctv.Initialize("treeProject", itmName)
	ctv.Image = img
	parentItem.Children.Add(ctv)
	Return ctv
End Sub


Sub TreeViewItemExist(tvItem As TreeItem, itmName As String) As Boolean
	If itmName.Length > 0 Then
		Dim res As TreeItem
		res = TreeViewSearch(tvItem, itmName)
		Return res.IsInitialized
	Else
		Return False
	End If
End Sub

' Description: Remove an item from treeview using treeitem
' Tag: treeview, remove, delete
Sub TreeItemDelete(res As TreeItem)
	If res.IsInitialized Then
    	Dim i As Int = res.Parent.Children.IndexOf(res)
     	res.Parent.Children.RemoveAt(i)
   	End If
End Sub

'Description: Select an item in treeview using its name
'Tag: treeview, select item
Sub TreeViewSetItem(tv As TreeView, s As String)
	If s.Length > 0 Then
		Dim ti As TreeItem
		ti = TreeViewSearch(tv.root, s)
		If ti.IsInitialized = True Then
			Dim jo As JavaObject = tv
			jo.RunMethodJO("getSelectionModel", Null).RunMethod("select", Array(ti))
			' scroll to item
			TreeViewScrollToItem(tv, ti)
		End If	
	End If
End Sub

Sub TreeViewSetItem1(tv As TreeView, ti As TreeItem)
	If ti.IsInitialized = True Then
		Dim jo As JavaObject = tv
		jo.RunMethodJO("getSelectionModel", Null).RunMethod("select", Array(ti))
		' scroll to item
		TreeViewScrollToItem(tv, ti)
	End If	
End Sub

private Sub TreeViewScrollToItem (Tree As TreeView, ti As TreeItem)
   Tree.Enabled = False
   Dim p As TreeItem = ti.Parent
   Do While p.Root = False
     p.Expanded = True
     p = p.Parent
   Loop
   Dim index As Int = TreeViewCountVisibleChildren(Tree.Root, ti, Array As Boolean(False))
   Dim jo As JavaObject = Tree
   jo.RunMethod("scrollTo", Array(index))
   Tree.Enabled = True
End Sub

private Sub TreeViewCountVisibleChildren(ti As TreeItem, Target As TreeItem, Found() As Boolean) As Int
   Dim c As Int = 1
   If ti = Target Then
     Found(0) = True
     Return -1
   End If
   If ti.Expanded Then
     For Each child As TreeItem In ti.Children
       c = c + TreeViewCountVisibleChildren(child, Target, Found)
       If Found(0) = True Then Return c
     Next
   End If
   Return c
End Sub

'Description: return a treeview item using its text property
'Tag: treeview, search, text
Sub TreeViewSearch(Parent As TreeItem, s As String) As TreeItem
	Dim res As TreeItem
	If Parent.IsInitialized = False Then Return res
	For Each ti As TreeItem In Parent.Children
		Dim stext As String = TreeViewItemGetText(ti)
		If stext.EqualsIgnoreCase(s) Then
			Return ti
		End If
		If ti.Children.Size > 0 Then
			Dim res As TreeItem = TreeViewSearch(ti, s)
			If res.IsInitialized Then Return res
		End If
	Next
	Return res
End Sub

Sub CleanNull(sValue As String) As String
	If sValue = "null" Then
		Return ""
	Else
		Return sValue
	End If
End Sub

Sub ComboBoxFromList(cboBox As ComboBox, lst As List, bClear As Boolean)
	If bClear = True Then cboBox.Items.clear
	cboBox.Items.AddAll(lst) 
End Sub

Sub ComboBoxSetIndexFromItem(cboBox As ComboBox, itm As String)
	Dim tItems As Int
	Dim cItems As Int
	Dim strItem As String
	tItems = cboBox.Items.Size - 1
	For cItems = 0 To tItems
		strItem = cboBox.Items.Get(cItems)
		If strItem.ToLowerCase = itm.ToLowerCase Then
			cboBox.SelectedIndex = cItems
			Return
		End If
	Next
	Log("not found")
End Sub

Sub UnReadOnlyMap(sourceMap As Map) As Map
	'jRandomAccessFile
	Dim ser As B4XSerializator
    Return ser.ConvertBytesToObject(ser.ConvertObjectToBytes(sourceMap))
End Sub

Sub TableViewClear(tblV As TableView)
	Dim lst As List
	lst.Initialize 
	lst.clear
	Dim jb As JavaObject = tblV
	jb.RunMethod("setItems", Array As Object(lst))
End Sub

'Description: return 0 / 1 based on checkbox checked value
'Tag: checkbox, return numeric
Sub ChkBox2YN(chkBox As CheckBox) As String
	If chkBox.Checked = True Then
		Return "1"
	Else
		Return "0"
	End If
End Sub

Sub YesNo2ZeroOne(value As String) As String
	If value = "N" Or value = "" Then
		Return "0"
	Else
		Return "1"	
	End If
End Sub

Sub ZeroOne2YN(value As String) As String
	If value = "0" Or value = "" Then
		Return "N"
	Else 
		Return "Y"
	End If
End Sub


'Description: Set checkbox value based on numeric 0/1
'Tag: checkbox, numeric
Sub YN2ChkBox(YN As String, chkBox As CheckBox)
	Select Case YN
	Case "1"
		chkBox.Checked = True
	Case Else
		chkBox.Checked = False
	End Select
End Sub

'Description: Bring panel to front
'Tag: panel, node, Bring2Front
Sub ToFront(n As Node)
    Dim joNode As JavaObject = n
    joNode.RunMethod("toFront", Null)
End Sub

Sub RemDelim(sValue As String, Delim As String) As String
	If sValue.EndsWith(Delim) Then
		Dim lDelim As Int = Delim.Length
		Dim nValue As String = sValue
		nValue = nValue.SubString2(0, nValue.Length-lDelim) 
		Return nValue
	End If
	Return sValue
End Sub


Sub BringToFront(n As Node)
   Dim parent As Pane = n.Parent
   n.RemoveNodeFromParent
   parent.AddNode(n, n.Left, n.Top, n.PrefWidth, n.PrefHeight)
End Sub


Sub PrepareRecursiveSearch
	ffiles.Initialize 
	ffolders.Initialize 
	root = ""
End Sub

Sub OpenDatabase(dbName As String, bReplace As Boolean)
	CopyDatabase(dbName, bReplace)
	jSQL.InitializeSQLite("", File.DirApp & "\" & dbName, True)
End Sub

Sub Left(Text As String, Length As Long)As String
   If Length>Text.Length Then Length=Text.Length
   Return Text.SubString2(0, Length)
End Sub

Sub DeleteFolder(sFolderName As String)
	PrepareRecursiveSearch
	ReadDir(sFolderName, True)
	DeleteFiles(ffiles)
End Sub

Sub DeleteFiles(lst As List)
	For Each fName As String In lst
		File.Delete("",fName) 
	Next
End Sub

Sub ReadDir(folder As String, recursive As Boolean)
  Dim lst As List = File.ListFiles(folder)
  For i = 0 To lst.Size - 1
      If File.IsDirectory(folder,lst.Get(i)) Then
            Dim v As String
            v = folder & "\" & lst.Get(i)
            ffolders.Add(v.SubString(root.Length+1))
            If recursive Then
                ReadDir(v,recursive)
            End If
        Else
            ffiles.Add(folder & "\" & lst.Get(i))
        End If
  Next
End Sub

Sub WildCardFilesList2(FilesPath As String, WildCards As String, Sorted As Boolean, Ascending As Boolean, IncludeFolder As Boolean) As List
    Dim FilteredFiles As List : FilteredFiles.Initialize
	If File.IsDirectory("", FilesPath) Then
        Dim FilesFound As List = File.ListFiles(FilesPath)
		Dim GetCards() As String = Regex.Split(",", WildCards)        
        For i = 0 To FilesFound.Size -1
            For l = 0 To GetCards.Length -1
                Dim TestItem As String = FilesFound.Get(i)
				Dim mask As String = GetCards(l).Trim
                Dim pattern As String = "^"&mask.Replace(".","\.").Replace("*",".+").Replace("?",".")&"$"
                If Regex.IsMatch(pattern,TestItem) = True Then
					If IncludeFolder = True Then
						FilteredFiles.Add(FilesPath & "\" &TestItem.Trim)
					Else
						FilteredFiles.Add(TestItem.Trim)
					End If
				Else
					If IncludeFolder = True Then
						FilteredFiles.Add(FilesPath & "\" & TestItem.Trim)
					End If
                End If
            Next
        Next
        If Sorted Then
            FilteredFiles.SortCaseInsensitive(Ascending)
        End If
        Return FilteredFiles
    Else
		Return FilteredFiles
    End If
End Sub

Sub SortStringArray(sa() As String) As String()
	Dim lst As List
	Dim aTot As Int
	Dim aCnt As Int
	Dim aStr As String
	
	lst.Initialize
	lst.AddAll(sa)
	lst.SortCaseInsensitive(True) 
	aTot = lst.Size - 1
	For aCnt = 0 To aTot
		aStr = lst.Get(aCnt)
		sa(aCnt) = aStr
	Next
	Return sa
End Sub

public Sub CollectMenuItems(Menus As Map, Items As List)
   For Each mi As MenuItem In Items
     If mi.Tag <> Null And mi.Tag <> "" Then Menus.Put(mi.Tag, mi)
     If mi Is Menu Then
       Dim mn As Menu = mi
       CollectMenuItems(Menus, mn.MenuItems)
     End If
   Next
End Sub

Sub GetFileExt(FullPath As String) As String
   Return FullPath.SubString(FullPath.LastIndexOf(".")+1)
End Sub

Sub Int2Hex(iValue As String, iLen As Int) As String
	Return Bit.ToHexString(iValue)
	'Dim bc As ByteConverter
	'Return bc.HexFromBytes(Array As Byte(Bit.ParseInt(iValue, iLen)))
End Sub

Sub MvField(sValue As String, iPosition As Int, Delimiter As String) As String
	If sValue.Length = 0 Then Return ""
	Dim xPos As Int: xPos = sValue.IndexOf(Delimiter)
	If xPos = -1 Then Return sValue
	Dim mValues() As String
	Dim tValues As Int
	Delimiter = FixDelimiter(Delimiter)
	If sValue.EndsWith(Delimiter) Then sValue = sValue & " "
	mValues = Regex.split(Delimiter, sValue)
	tValues = mValues.Length -1
	Select Case iPosition
		Case -1
			Return mValues(tValues)
		Case -2
			Return mValues(tValues - 1)
		Case -3
			Dim sb As StringBuilder
			sb.Initialize
			Dim startcnt As Int
			For startcnt = 1 To tValues
				sb.Append(mValues(startcnt)).append(Delimiter)
			Next
			sb.Remove(sb.Length-Delimiter.Length,sb.Length)
			Return sb.tostring
		Case Else
			iPosition = iPosition - 1
			If iPosition <= -1 Then Return mValues(tValues)
			If iPosition > tValues Then Return ""
			Return mValues(iPosition)
	End Select
End Sub

Sub GetExtension(fil As String) As String
	Return MvField(fil,-1,".")
End Sub

Sub EndsWith(svalue As String, sfind As String) As Boolean
	Return svalue.EndsWith(sfind) 
End Sub

Sub Form_CenterOnScreen(Frm As Form)
   Dim ps As Screen = fx.PrimaryScreen
   Frm.WindowTop = (ps.MaxY - ps.MinY) / 2 - Frm.Height / 2
   Frm.WindowLeft = (ps.MaxX - ps.MinX) / 2 - Frm.Width / 2
End Sub     

Sub Form_SetBackgroundImage(m As Form, bgImage As String)
	m.RootPane.Style = "-fx-background-image:url('" & File.GetUri(File.DirAssets, bgImage) & "');-fx-background-repeat: stretch;-fx-background-size: 100% 100%;"
End Sub

Sub Form_SetIcon(m As Form, iconImage As String)
	m.Icon = fx.LoadImage(File.DirAssets, iconImage)
End Sub

Sub InStr(Text As String, sFind As String) As Int
	Return Text.tolowercase.IndexOf(sFind.tolowercase)
End Sub

Sub StartsWith(svalue As String, sfind As String) As Boolean
	Return svalue.StartsWith(sfind) 
End Sub


Sub Replace(Text As String, sFind As String, sReplaceWith As String) As String
	Return Text.Replace(sFind, sReplaceWith)
End Sub



Sub MvFromArray(varArry() As String, delim As String) As String
	Dim lTot As Int
	Dim lCnt As Int
	Dim str As StringBuilder
	str.Initialize 
	lTot = varArry.Length -1
	For lCnt = 0 To lTot
		str.Append(varArry(lCnt)).append(delim)
	Next
	Return str.tostring
End Sub

' this is used for CoronaShow
Sub InitButtons
	Buttons.Initialize 
	Dim btn1 As BtnImage
	Dim btn2 As BtnImage
	Dim btn3 As BtnImage
	Dim btn4 As BtnImage
	Dim btn5 As BtnImage
	Dim btn6 As BtnImage
	Dim btn7 As BtnImage
	Dim btn8 As BtnImage
	Dim btn9 As BtnImage
	Dim btn0 As BtnImage
	
	btn0.Initialize
	btn1.Initialize
	btn2.Initialize
	btn3.Initialize
	btn4.Initialize
	btn5.Initialize
	btn6.Initialize
	btn7.Initialize
	btn8.Initialize
	btn9.Initialize
	'blue
	btn0.defaultf = "buttonBlue.png"
	btn0.overf = "buttonBlueOver.png"
	' gray
	btn1.defaultf = "buttonGray.png"
	btn1.overf = "buttonGrayOver.png"
	' green
	btn2.defaultf = "buttonGreen.png"
	btn2.overf = "buttonGreenOver.png"
	
	' orange
	btn3.defaultf = "buttonOrange.png"
	btn3.overf = "buttonOrangeOver.png"
	
	' purple
	btn4.defaultf = "buttonPurple.png"
	btn4.overf = "buttonPurpleOver.png"
	
	' red
	btn5.defaultf = "buttonRed.png"
	btn5.overf = "buttonRedOver.png"
	
	' white
	btn6.defaultf = "buttonWhite.png"
	btn6.overf = "buttonWhiteOver.png"
	
	' yellow
	btn7.defaultf = "buttonYellow.png"
	btn7.overf = "buttonYellowOver.png"
	
	' left
	btn8.defaultf = "leftArrow.png"
	btn8.overf = "leftArrowOver.png"
	
	' left
	btn9.defaultf = "rightArrow.png"
	btn9.overf = "rightArrowOver.png"
	
	Buttons.Put("blue", btn0)
	Buttons.Put("gray", btn1)
	Buttons.Put("green", btn2)
	Buttons.Put("orange", btn3)
	Buttons.Put("purple", btn4)
	Buttons.Put("red", btn5)
	Buttons.Put("white", btn6)
	Buttons.Put("yellow", btn7)
	Buttons.Put("left", btn8)
	Buttons.Put("right", btn9)   
End Sub

' return visibility of a form
Sub IsVisible(f As Form) As Boolean
   Dim jo As JavaObject = f
   Return jo.GetFieldJO("stage").RunMethod("isShowing", Null)
End Sub

' show an error to a user
Sub Error(rld As DialogsX, Title As String, Msg As String)
	rld.ErrorDialog(Title,Msg,"") 
End Sub

' warm a user
Sub Warm(rld As DialogsX, Title As String, Msg As String)
	rld.WarningDialog(Title,Msg,"") 
End Sub

' show an information prompt
Sub Info(rld As DialogsX, Title As String, Msg As String)
	rld.InformationDialog(Title,Msg,"") 
End Sub

' returns yesnocancel msgbox
Sub YesNoCancel(rld As DialogsX, Title As String, Msg As String) As String
	Dim dlgYNCresult As Int
	dlgYNCresult = rld.YesNoCancelDialog(Title,Msg,"")
	Select Case dlgYNCresult
	Case 1
		Return "Yes"
	Case 0
		Return "No"
	Case Else
		Return "Cancel"
	End Select
End Sub

Sub StrParse(Delimiter As String, MV As String) As String()
	Delimiter = FixDelimiter(Delimiter)
	Return Regex.Split(Delimiter, MV)
End Sub

Sub StrParse2List(Delimiter As String, MV As String) As List
	Delimiter = FixDelimiter(Delimiter)
	Dim spData() As String = Regex.Split(Delimiter, MV)
	Dim lst As List
	lst.Initialize 
	lst.AddAll(spData)
	Return lst
End Sub

Public Sub ComboBox_PromptText(CB As ComboBox, Text As String)
	Dim joCB As JavaObject = CB
	joCB.RunMethod("setPromptText", Array(Text))
End Sub

Sub ListViewGetSelectedText(lstView As ListView) As String
	Dim m As Map = ListViewGetSelected(lstView)
	Dim o As String = m.GetDefault("text","")
	Return o
End Sub

'Description: return a tag and text of selected listview item as a map
'Tag: listview, map, tag, text
Sub ListViewGetSelected(lstView As ListView) As Map
	Dim m As Map
	m.Initialize 
	Dim fsel As Int = lstView.SelectedIndex
	If fsel = -1 Then
		m.Put("tag", "")
		m.Put("text", "")
		m.Put("index", fsel)
	Else
		' get the selected item
		Dim ap As AnchorPane = lstView.SelectedItem
		Dim title As Label = ap.GetNode(0)
		m.Put("tag", title.tag)
		m.Put("text", title.Text)
		m.Put("index", fsel)
	End If
	Return m
End Sub

'Description: return all items in the listview as a list of maps
'Tag: listview, b4j, map, anchorpane
Sub ListViewGetItems(lstView As ListView) As List
	Dim ap As AnchorPane
	Dim title As Label
	Dim m As Map
	Dim l As List
	Dim t As Int
	Dim i As Int
	l.Initialize 
	' get all the items from the list
	t = lstView.items.Size - 1
	' loop through each item
	For I = 0 To t
    	ap = lstView.items.Get(I)
		title = ap.GetNode(0)
		m.Initialize
		m.Put("tag", title.tag)
		m.Put("text", title.Text)
		m.Put("index", I)
		l.Add(m)
	Next
	Return l
End Sub

Sub ListViewGetTags(lstView As ListView) As List
	Dim ap As AnchorPane
	Dim title As Label
	Dim l As List
	Dim t As Int
	Dim i As Int
	l.Initialize 
	' get all the items from the list
	t = lstView.items.Size - 1
	' loop through each item
	For I = 0 To t
    	ap = lstView.items.Get(I)
		title = ap.GetNode(0)
		l.Add(title.Tag)
	Next
	Return l
End Sub


Sub ListViewGetItem(lstView As ListView, idxPos As Int) As Map
	Dim ap As AnchorPane
	Dim title As Label
	Dim m As Map
	ap = lstView.items.Get(idxPos)
	title = ap.GetNode(0)
	m.Initialize
	m.Put("tag", title.tag)
	m.Put("text", title.Text)
	m.Put("index", idxPos)
	Return m
End Sub

Sub ListViewGetItemTag(lstView As ListView, idxPos As Int) As Map
	Dim ap As AnchorPane
	Dim title As Label
	ap = lstView.items.Get(idxPos)
	title = ap.GetNode(0)
	Return title.tag
End Sub

Sub SortedKeys(m As Map) As List
	Dim lst As List
	lst.Initialize
	For Each strkey As String In m.Keys
		lst.Add(strkey)
	Next
	'sort the list keys
	lst.Sort(True)
	Return lst
End Sub

'sort the subroutines
Sub SortMap(m As Map) As Map
	Try
		Dim nm As Map
		nm.Initialize 
		Dim lst As List
		lst.Initialize 
		For Each strkey As String In m.Keys
			lst.Add(strkey)
		Next
		'sort the list keys
		lst.Sort(True)
		For Each strkey As String In lst
			Dim strvalue As Object = m.Get(strkey)
			nm.Put(strkey,strvalue)
		Next
		Return nm
	Catch
		Return m
	End Try
End Sub

Sub FixDelimiter(sValue As String) As String
	If sValue = "|" Then sValue = "\|"
	If sValue = "." Then sValue = "\."
	If sValue = "\" Then sValue = "\\"
	If sValue = "^" Then sValue = "\^"
	If sValue = "$" Then sValue = "\$"
	If sValue = "?" Then sValue = "\?"
	If sValue = "*" Then sValue = "\*"
	If sValue = "+" Then sValue = "\+"
	If sValue = "(" Then sValue = "\("
	If sValue = ")" Then sValue = "\)"
	If sValue = "[" Then sValue = "\["
	If sValue = "{" Then sValue = "\{"
	If sValue = ";" Then sValue = "\;"
	If sValue = "$" Then sValue = "\$"
	Return sValue
End Sub

'Description: Split a multi delimited string to an array
'Tag: split, delimited string
Sub Split(Text As String, Delimiter As String) As String()
	Return StrParse(Delimiter,Text)
End Sub

'Description: Add listview items from a delimited string
'Tag: listview, b4j, add items
Sub ListViewFromMV(lstView As ListView, MvString As String, Delimiter As String, bClear As Boolean)
	' do we clear the list first
	If bClear = True Then lstView.Items.clear
	Dim lst() As String: lst = Split(MvString,Delimiter)
	Dim lstTot As Int: lstTot = lst.length - 1
	Dim lstCnt As Int
	Dim lstStr As String
	For lstCnt = 0 To lstTot
		lstStr = lst(lstCnt)
		ListViewAddOneLine(lstView, lstStr,lstStr)
	Next
End Sub

'Description: return all text in the listview as a delimited string
'Tag: listview, b4j, map, anchorpane
Sub ListViewGetTexts(lstView As ListView, Delimiter As String) As String
	Dim sb As StringBuilder
	Dim ap As AnchorPane
	Dim title As Label
	Dim lTot As Int
	Dim lCnt As Int
	sb.Initialize 
	' loop through each item
	lTot = lstView.items.Size - 1
	For lCnt = 0 To lTot
    	ap = lstView.items.Get(lCnt)
		title = ap.GetNode(0)
		sb.Append(title.text)
		If lCnt <> lTot Then sb.Append(Delimiter)
	Next
	Return sb.tostring
End Sub

Sub ListViewRemoveByText(lstView As ListView, searchText As String)
	Dim ap As AnchorPane
	Dim title As Label
	Dim t As Int
	Dim i As Int
	Dim tg As String
	searchText = searchText.ToLowerCase 
	t = lstView.items.Size - 1
	For i = 0 To t
		ap = lstView.Items.Get(i)
     	title = ap.GetNode(0)
		tg = title.text
		tg = tg.ToLowerCase 
		If tg = searchText Then
			lstView.Items.RemoveAt(i) 
			Exit 
		End If
	Next
End Sub


Sub ListViewTextPos(lstView As ListView, searchText As String) As Int
	Dim ap As AnchorPane
	Dim title As Label
	Dim t As Int
	Dim i As Int
	Dim tg As String
	searchText = searchText.ToLowerCase 
	t = lstView.items.Size - 1
	For i = 0 To t
		ap = lstView.Items.Get(i)
     	title = ap.GetNode(0)
		tg = title.text
		tg = tg.ToLowerCase 
		If tg = searchText Then
			Return i	  
		End If
	Next
	Return -1
End Sub

'Description: search for text from a listview and return boolean
'Tag: b4j, listview, text, search
Sub ListViewTextExist(lstView As ListView, searchText As String) As Boolean
	Dim ap As AnchorPane
	Dim title As Label
	Dim t As Int
	Dim i As Int
	Dim tg As String
	searchText = searchText.ToLowerCase 
	t = lstView.items.Size - 1
	For i = 0 To t
		ap = lstView.Items.Get(i)
     	title = ap.GetNode(0)
		tg = title.text
		tg = tg.ToLowerCase 
		If tg = searchText Then
			Return True	  
		End If
	Next
	Return False
End Sub

'Description: search for text from a listview and scroll to its location
'Tag: b4j, listview, text, search, scroll to
Sub ListViewScroll2Text(lstView As ListView, searchText As String)
	Dim ap As AnchorPane
	Dim title As Label
	Dim t As Int
	Dim i As Int
	Dim tg As String
	searchText = searchText.ToLowerCase 
	t = lstView.items.Size - 1
	For i = 0 To t
		ap = lstView.Items.Get(i)
     	title = ap.GetNode(0)
		tg = title.text
		tg = tg.ToLowerCase 
		If tg = searchText Then
			lstView.RequestFocus
			lstView.SelectedIndex = i
			lstView.ScrollTo(i)
			Exit
		End If
	Next
End Sub

'Description: search for tag from a listview and scroll to its location
'Tag: b4j, listview, text, search, scroll to
Sub ListViewScroll2Tag(lstView As ListView, searchTag As String)
	Dim ap As AnchorPane
	Dim title As Label
	Dim t As Int
	Dim i As Int
	Dim tg As String
	searchTag = searchTag.ToLowerCase 
	t = lstView.items.Size - 1
	For i = 0 To t
		ap = lstView.Items.Get(i)
     	title = ap.GetNode(0)
		tg = title.tag
		tg = tg.ToLowerCase 
		If tg = searchTag Then
			lstView.RequestFocus
			lstView.SelectedIndex = i
			lstView.ScrollTo(i)
			Exit
		End If
	Next
End Sub

'Description: scroll to a particular location of listview
'Tag: b4j, listview, scroll to
Sub ListViewScroll2Index(lstView As ListView, idx As Int)
	Dim t As Int
	t = lstView.items.Size - 1
	If idx <= t Then
		lstView.RequestFocus
		lstView.SelectedIndex = idx
		lstView.ScrollTo(idx)
	End If
End Sub

'Description: search for tag from a listview and return boolean
'Tag: b4j, listview, text, search
Sub ListViewTagExist(lstView As ListView, searchTag As String) As Boolean
	Dim ap As AnchorPane
	Dim title As Label
	Dim t As Int
	Dim i As Int
	Dim tg As String
	searchTag = searchTag.ToLowerCase 
	t = lstView.items.Size - 1
	For i = 0 To t
		ap = lstView.Items.Get(i)
     	title = ap.GetNode(0)
		tg = title.Tag
		tg = tg.ToLowerCase 
		If tg = searchTag Then
			Return True	  
		End If
	Next
	Return False
End Sub

' get input from a user
Sub InputBox(rld As DialogsX, Title As String, Prompt As String, DefaultText As String) As String
	Dim dlgIR As String = Null
	dlgIR = rld.TextInputDialog4(Title, Prompt, DefaultText, 600)
	If dlgIR.EqualsIgnoreCase(Null) Then
		Return ""
	Else
		Return dlgIR
	End If
End Sub

' show a yesno msgbox
Sub Confirm(rld As DialogsX, Title As String, Msg As String) As String
	Dim dlgYNresult As Boolean
	dlgYNresult = rld.ConfirmationDialog(Title,Msg,"") 
	Select Case dlgYNresult
	Case True
		Return "Yes"
	Case Else
		Return "No"
	End Select
End Sub


' check if a value is blank and warn user is so
Sub IsBlankString(frm As Form, valueToCheck As String, title As String) As Boolean
	valueToCheck = valueToCheck.Trim
	If valueToCheck.Length = 0 Or valueToCheck = Null Or valueToCheck = "null" Then
    	Dim msg As String
		msg = "The " & title & " cannot be blank, please enter the " & title.ToLowerCase  & "!" 
		MsgBoxError(frm,title,msg)
		Return True
	Else
        Return False
    End If
End Sub

Sub IsBlankTextField1(frm As Form, valueToCheck As TextField, title As String) As Boolean
	valueToCheck.text = valueToCheck.text.Trim
	If valueToCheck.text.Length = 0 Then
    	Dim msg As String
		msg = "The " & title & " cannot be blank, please enter the " & title.ToLowerCase  & "!" 
		MsgBoxError(frm,title,msg)
		Return True
	Else
        Return False
    End If
End Sub

Sub IsBlankTextArea1(frm As Form, valueToCheck As TextArea, title As String) As Boolean
	valueToCheck.text = valueToCheck.text.Trim
	If valueToCheck.text.Length = 0 Then
    	Dim msg As String
		msg = "The " & title & " cannot be blank, please enter the " & title.ToLowerCase  & "!" 
		MsgBoxError(frm,title,msg)
		Return True
	Else
        Return False
	End If
End Sub

Sub IsBlankCombo(frm As Form, valueToCheck As ComboBox, title As String) As Boolean
	If valueToCheck.value = "" Then
    	Dim msg As String
		msg = "The " & title & " cannot be blank, please select the " & title.ToLowerCase  & "!" 
		MsgBoxError(frm,title,msg)
		Return True
	Else
        Return False
    End If
End Sub

' check if a value is blank and warn user is so
Sub IsBlank(rld As DialogsX, valueToCheck As String, title As String) As Boolean
	valueToCheck = valueToCheck.Trim
	If valueToCheck.Length = 0 Or valueToCheck = Null Or valueToCheck = "null" Then
    	Dim msg As String
		msg = "The " & title & " cannot be blank, please enter the " & title.ToLowerCase  & "!" 
		'i.ShowMessageDialog(msg,title,i.messageType_ERROR)
		rld.ErrorDialog(title,msg,"") 
		Return True
	Else
        Return False
	End If
End Sub

' check if a value is blank and warn user is so
Sub MsgBoxIsBlank(rld As Form, valueToCheck As String, title As String) As Boolean
	valueToCheck = valueToCheck.Trim
	If valueToCheck.Length = 0 Or valueToCheck = Null Or valueToCheck = "null" Then
    	Dim msg As String
		msg = "The " & title & " cannot be blank, please enter the " & title.ToLowerCase  & "!" 
		MsgBoxWarn(rld, title,msg) 
		Return True
	Else
        Return False
    End If
End Sub

Sub IsBlank1(frm As Form, valueToCheck As String, title As String) As Boolean
	valueToCheck = valueToCheck.Trim
	If valueToCheck.Length = 0 Or valueToCheck = Null Or valueToCheck = "null" Then
    	Dim msg As String
		msg = "The " & title & " cannot be blank, please enter the " & title.ToLowerCase  & "!" 
		MsgBoxError(frm,title,msg)
		Return True
	Else
        Return False
    End If
End Sub

' convert a list containing maps to json
Sub List2JSON(lst As List) As String
	Dim sOut As String
	Dim jsonGen As JSONGenerator
    jsonGen.Initialize2(lst)
    sOut = jsonGen.ToString
	Return sOut
End Sub

' convert a json string to a map
Sub Json2Map(jsonText As String) As Map
	Dim json As JSONParser
	Dim Map1 As Map
	Map1.Initialize
	Try
		If jsonText.length > 0 Then 
			json.Initialize(jsonText) 
			Map1 = json.NextObject
		End If
		Return Map1
	Catch
		Return Map1
	End Try
End Sub

Sub Map2Json(m As Map) As String
	Dim gen As JSONGenerator
	Dim outJSON As String
	gen.Initialize(m)
	outJSON = gen.ToString
	Return outJSON
End Sub

Sub Map2JsonPretty(m As Map) As String
	Dim gen As JSONGenerator
	Dim outJSON As String
	gen.Initialize(m)
	outJSON = gen.ToPrettyString(4)
	Return outJSON
End Sub

' convert a map to a json string, long version
Sub MapToJSON(sm As Map, bEnclose As Boolean) As String
    ' convert a map to a json string
    Dim iCnt As Int
    Dim iTot As Int
    Dim sb As StringBuilder
    sb.Initialize
    If bEnclose = True Then sb.Append("{")
    ' get size of map
    iTot = sm.Size - 1
    iCnt = 0
    For Each mKey As String In sm.Keys
        Dim mValue As String = sm.Get(mKey)
		mKey = mKey.Replace(QUOTE,"")
		mValue = mValue.Replace(QUOTE,"")
        sb.Append(QUOTE).Append(mKey).Append(QUOTE).Append(":").Append(QUOTE).Append(mValue).Append(QUOTE)
        If iCnt < iTot Then sb.Append(",")
        iCnt = iCnt + 1
    Next
    If bEnclose = True Then sb.Append("}")
    Return sb.ToString
End Sub

' return all keys from a map delimited
Sub MapKeys(sm As Map, sDelim As String) As String
    Dim iCnt As Int
    Dim iTot As Int
    Dim sb As StringBuilder
    sb.Initialize
    ' get size of map
    iTot = sm.Size - 1
    iCnt = 0
    For Each mKey As String In sm.Keys
        mKey = mKey.Replace(QUOTE,"")
		sb.Append(mKey)
		If iCnt < iTot Then sb.Append(sDelim)
        iCnt = iCnt + 1
    Next
    Return sb.ToString
End Sub
' return a quoted string
Sub InQuotes(sValue As String) As String
	sValue = RemDelim(sValue,QUOTE)
	sValue = RemPrefix(sValue,QUOTE)
	If sValue = QUOTE Then sValue = ""
	Return QUOTE & sValue & QUOTE
End Sub

' return a quoted string
Sub InQuotes1(sValue As String) As String
	sValue = RemDelim(sValue,QUOTE)
	sValue = RemPrefix(sValue,QUOTE)
	If sValue = QUOTE Then sValue = ""
	Return "$" & QUOTE & sValue & QUOTE & "$"
End Sub

' remove some unwanted characters from a string
Public Sub CleanValue(sValue As String) As String
	sValue = sValue.replace(" ","")
	sValue = sValue.Replace(".","")
	sValue = sValue.Replace("-","")
	sValue = sValue.Replace("&","")
	sValue = sValue.trim
	Return sValue
End Sub

Sub CInt(o As Object) As Int
	Dim ox As String = o
	ox = GetNumbers(ox)
	If ox = "" Then ox = "0"		
  	Return Floor(ox)
End Sub

'Description - convert your fx.color to an int
Sub PaintToInt(pnt As Paint) As Int
	Return fx.Colors.To32Bit(pnt)
End Sub

'Description - convert your int to an fx.color
Sub Int2Paint(intt As Int) As Paint
	Return fx.Colors.From32Bit(intt)
End Sub

Sub Long2Hex(lngValue As String) As String
	Dim HexARGB As String = Bit.ToHexString(lngValue)
	Dim HexRGB As String = "#" & HexARGB.SubString2(2,8)
	Return HexRGB
End Sub

Sub Rgb2Hex(r As Int, g As Int, b As Int) As String
	Dim intC As Int
	Dim sh As String
	intC = fx.Colors.RGB(r,g,b)
	sh = Bit.ToHexString(intC)
	sh = sh.touppercase
	sh = "#" & Right(sh,6)
	Return sh
End Sub

'Description: add a single line to a listview
'Tag: listview, add single line
Sub ListViewAddOneLine(lv As ListView, Line1 As String, Value As Object)
  Dim ap As AnchorPane
  ap.Initialize("")
  Dim lbl1 As Label
  lbl1.Initialize("")
  lbl1.Text = Line1                  
  lbl1.Font = fx.DefaultFont(14)
  lbl1.Tag = Value
  ap.AddNode(lbl1, 0, 0, lv.Width, 20dip)
  ap.Tag = Value
  lv.Items.Add(ap)
End Sub

Sub ListViewSetItemTag(lstView As ListView, idxPos As Int, Value As Object)
	Dim ap As AnchorPane
	Dim title As Label
	ap = lstView.items.Get(idxPos)
	title = ap.GetNode(0)
	title.tag = Value
	ap.Tag = Value
End Sub

'Description: add two lines to a listview
'Tag: listview, add two lines
Sub ListViewAddTwoLines(lv As ListView, Line1 As String, Line2 As String, ID As Object)
	Dim ap As AnchorPane
   	ap.Initialize("")
	' Line 1
   	Dim lbl1 As Label
   	lbl1.Initialize("title")
	lbl1.Text = Line1
	lbl1.Font = fx.DefaultFont(12)
   	lbl1.Tag = ID
   	ap.AddNode(lbl1, 0, 0, lv.Width, 20dip)
	' Line 2
   	Dim lbl2 As Label
   	lbl2.Initialize("category")
   	lbl2.Text = Line2
   	lbl2.Font = fx.DefaultFont(10)
   	ap.AddNode(lbl2, 0, 20dip, lv.Width, 20dip)
	' Add the anchorpane with the labels to the listview
   	lv.Items.Add(ap)
End Sub

Sub asJO(o As JavaObject) As JavaObject
	Return o
End Sub

Sub MvSearch(delimiter As String, Mv As String, searchfor As String) As Boolean
	Mv = Mv.tolowercase
	searchfor = searchfor.ToLowerCase
	Dim spItems As List = Mv2List(delimiter,Mv)
	Return OnList(spItems,searchfor)	
End Sub

Sub MvPos(delimiter As String, mv As String, searchfor As String) As Int
	mv = mv.tolowercase
	searchfor = searchfor.ToLowerCase
	Dim spItems As List = Mv2List(delimiter,mv)
	Return spItems.indexof(searchfor)
End Sub

Public Sub IsValidEmail(sEmailAddress As String) As Boolean
	Dim MatchEmail As Matcher = Regex.Matcher("^(?i)[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])$", sEmailAddress)
	If MatchEmail.Find = True Then
		Return True
	Else
		Return False
	End If
End Sub
 
Sub Mv2List(delimiter As String, Mv As String) As List
	Dim lst As List
	lst.Initialize
	Dim spItems() As String = StrParse(delimiter,Mv)
	lst.AddAll(spItems)
	Return lst
End Sub
 
' convert a json string to a list
Sub Json2List(strValue As String) As List
	Dim lst As List
	lst.Initialize
	If strValue.Length = 0 Then
		Return lst
	End If
	Try
		Dim parser As JSONParser
		parser.Initialize(strValue)
		Return parser.NextArray
	Catch
		Return lst
	End Try
End Sub

Sub RedirectOutput (Dir As String, FileName As String)
   #if RELEASE
	Dim out As OutputStream = File.OpenOutput(Dir, FileName, False) 'Set to True to append the logs
	Dim ps As JavaObject
	ps.InitializeNewInstance("java.io.PrintStream", Array(out, True, "utf8"))
	Dim jo As JavaObject
	jo.InitializeStatic("java.lang.System")
	jo.RunMethod("setOut", Array(ps))
	jo.RunMethod("setErr", Array(ps))
   #end if
End Sub


Sub LogAction(sAction As String)
	Dim sLine As String = $"${DateTimeNow}: ${sAction}"$
	TextWriter_Append(File.DirApp,"PenNPaper.log",sLine)
End Sub

Sub TextWriter_Append(dir As String, fileName As String, sLine As String)
 	Dim TextWriter1 As TextWriter
	TextWriter1.Initialize(File.OpenOutput(dir, fileName, True))
    TextWriter1.WriteLine(sLine)
	TextWriter1.Close
End Sub

Sub TextReader(dir As String, fileName As String)
	Dim TextReader1 As TextReader
	TextReader1.Initialize(File.OpenInput(dir, fileName))
	Dim line As String
	line = TextReader1.ReadLine
	Do While line <> Null
		'Log(line) 'write the line to LogCat
		'process the line
		line = TextReader1.ReadLine
	Loop
	TextReader1.Close
End Sub

Public Sub DateTimeNow() As String
	Dim lNow As Long
	Dim dt As String
	lNow = DateTime.Now
	DateTime.DateFormat = "yyyy-MM-dd HH:mm"
	dt = DateTime.Date(lNow)
	Return dt
End Sub

Sub MvQuoteEach(strMV As String, delim As String) As String
	strMV = strMV.Replace(QUOTE,"")
	Dim sp() As String = StrParse(delim,strMV)
	Dim lst As List
	lst.Initialize
	For Each strItem As String In sp
		strItem = InQuotes(strItem)
		lst.add(strItem)
	Next
	Return MvFromList(lst,",")
End Sub

Sub ListSingleQuote(lst As List)
	Dim lstTot As Int = lst.Size - 1
	Dim lstCnt As Int 
	For lstCnt = 0 To lstTot
		Dim strItem As String = lst.Get(lstCnt)
		strItem = "'" & strItem & "'"
		lst.Set(lstCnt,strItem)
	Next
End Sub


' return the package name
Sub GetPackage() As String
	Dim joBA As JavaObject
	joBA.InitializeStatic("anywheresoftware.b4a.BA")
	Return joBA.GetField("packageName")
End Sub

' return a delimited string from a list
Sub MvFromList(lst As List, Delim As String) As String
	Dim lTot As Int
	Dim lCnt As Int
	Dim lStr As StringBuilder
	lStr.Initialize 
	lTot = lst.Size - 1
	For lCnt = 0 To lTot
		lStr.Append(lst.Get(lCnt))
		If lCnt <> lTot Then lStr.Append(Delim)
	Next
	Return lStr.tostring
End Sub

Sub MvFromKeys(lst As Map, Delim As String) As String
	Dim lStr As StringBuilder
	lStr.Initialize 
	For Each strKey As String In lst.Keys
		lStr.Append(strKey).Append(Delim)
	Next
	lStr.Remove(lStr.Length-Delim.Length,lStr.Length)	
	Return lStr.tostring
End Sub

Sub JoinArray(Delimiter As String, varArray() As String) As String
	Dim sb As StringBuilder
	sb.Initialize
	For Each strLine As String In varArray
		sb.Append(strLine).Append(Delimiter)
	Next
	If sb.ToString.EndsWith(Delimiter) Then
		sb.Remove(sb.Length-Delimiter.Length,sb.Length)
	End If
	Return sb.tostring
End Sub

Sub Join(Delimiter As String, lst As List) As String
	Return MvFromList(lst,Delimiter)
End Sub

Sub ListSearch(lst As List, searchFor As String) As Boolean
	searchFor = LCase(searchFor)
	For Each strItem As String In lst
		strItem = strItem.Trim.tolowercase
		If strItem = searchFor Then
			Return True
			Exit
		End If
	Next
	Return False
End Sub

Sub MvFromListSingleQuote(lst As List, Delim As String) As String
	Dim lTot As Int
	Dim lCnt As Int
	Dim lStr As StringBuilder
	lStr.Initialize 
	lTot = lst.Size - 1
	For lCnt = 0 To lTot
		lStr.Append("'").Append(lst.Get(lCnt)).Append("'")
		If lCnt <> lTot Then lStr.Append(Delim)
	Next
	Return lStr.tostring
End Sub

' copy db from assets
Sub CopyDatabase(Database As String, bReplace As Boolean)
	Database = Database.ToLowerCase
	If bReplace = True Then
		File.Copy(File.DirAssets,Database, File.dirapp,Database) 
	Else
		If File.Exists(File.dirapp,Database) = False Then
			File.Copy(File.DirAssets,Database, File.dirapp,Database) 
		End If
	End If
End Sub

' copy db from assets
Sub CopyDatabase1(Database As String, database1 As String, bReplace As Boolean)
	Database = Database.ToLowerCase
	If bReplace = True Then
		File.Copy(File.DirAssets,Database, File.dirapp,database1) 
	Else
		If File.Exists(File.dirapp,database1) = False Then
			File.Copy(File.DirAssets,Database, File.dirapp,database1) 
		End If
	End If
End Sub



Sub ShowToast(tt As ToastMessageShow, sAppName As String, sMsg As String)
	tt.ToastTitleColor = fx.Colors.Cyan
	tt.ToastMessageColor = fx.Colors.Yellow
	tt.ToastShow4(sAppName,sMsg, tt.TOAST_INFO_ICON)
End Sub

Sub ListFolders(folder As String) As List
   Dim folders As List
   folders.Initialize
   For Each f As String In File.ListFiles(folder)
     If File.IsDirectory(folder, f) Then folders.Add(File.Combine(folder,f))
   Next
   Return folders
End Sub

Sub FindFiles(Path As String, mList As List)
  Dim FileList, FolderList As List
  Dim FileFound As String
  Dim mPos As Int
  If mList.IsInitialized = False Then mList.Initialize 
  FileList.Initialize
  FolderList.Initialize
  If Path = "" Then Path = File.DirApp

  If File.IsDirectory(Path,"") Then
    Try
      FileList = File.ListFiles(Path)
      If FileList.IsInitialized Then
        If FileList.Size > 0 Then
          FileFound = Path
          mList.Add(FileFound)
          For i = 0 To FileList.Size - 1
            FileFound = FileList.Get(i)
            If File.IsDirectory(Path & "/" & FileFound,"") Then
              FolderList.Add(Path & "\" & FileFound)
            Else
              mList.Add(Path & "\" & FileFound)
            End If
          Next
        End If
      End If
    Catch
      Log("FindFiles: " & LastException & " " & Path & " " & FileList.Size & " (File)")
    End Try
    'Recursive search for files
    Try
      If FolderList.IsInitialized Then
        If FolderList.Size > 0 Then
          For i = 0 To FolderList.Size - 1
            FileFound = FolderList.Get(i)
            FindFiles(FileFound,mList)
          Next
        End If
      End If
    Catch
      Log("FindFiles: " & LastException & " " & FolderList.Size & " " & FileFound & " (Folder)")
    End Try
	' remove the path from this list
	mPos = mList.IndexOf(Path)
	If mPos >= 0 Then mList.RemoveAt(mPos)  
  End If
End Sub

Sub Right(Text As String, Length As Long) As String
   If Length>Text.Length Then Length=Text.Length
   Return Text.SubString(Text.Length-Length)
End Sub

Sub FilterListOnExtension(lstFiles As List, ext As String) As List
	Dim lTot As Int
	Dim lCnt As Int
	Dim nList As List
	Dim lStr As String
	Dim extLen As Int
	nList.Initialize
	extLen = ext.length
	lTot = lstFiles.Size-1
	For lCnt = 0 To lTot
		lStr = lstFiles.Get(lCnt)
		If Right(lStr,extLen) = ext Then
			nList.Add(lStr)
		End If
	Next
	Return nList
End Sub

Sub Len(Text As String) As Int
	Return Text.Length
End Sub

Sub Space(HM As Int) As String
	Dim RS As String = ""
	Do While Len(RS) < HM
		RS = RS & " "
	Loop
	Return RS
End Sub

Public Sub EscapeHtml(Raw As String) As String
   Dim sb As StringBuilder
   sb.Initialize
   For i = 0 To Raw.Length - 1
     Dim C As Char = Raw.CharAt(i)
     Select C
       Case CRLF
         sb.Append("<BR/>")
		Case Chr(9)
         sb.Append("&nbsp;&nbsp;")
	   Case QUOTE
         sb.Append("&quot;")
       Case "'"
         sb.Append("&#39;")
       Case "<"
         sb.Append("&lt;")
       Case ">"
         sb.Append("&gt;")
       Case "&"
         sb.Append("&amp;")
       Case "ö"
         sb.Append("&ouml;")
       Case "ä"
         sb.Append("&auml;")
       Case "ü"
         sb.Append("&uuml;")
       Case "Ö"
         sb.Append("&Ouml;")
       Case "Ä"
         sb.Append("&Auml;")
       Case "Ü"
         sb.Append("&Uuml;")
       Case "ß"
         sb.Append("&szlig;")
       Case Else
         sb.Append(C)
     End Select
   Next
   Return sb.ToString
End Sub

Public Sub ReEscapeHtml(Raw As String) As String
	Raw = Raw.Replace("<BR>", CRLF)
	Raw = Raw.Replace("&nbsp;&nbsp;", Chr(9))
	Raw = Raw.Replace("&quot;", QUOTE)
	Raw = Raw.Replace("&apos;", "'")
	Raw = Raw.Replace("&#39;", "'")
	Raw = Raw.Replace("&lt;", "<")
	Raw = Raw.Replace("&gt;", ">")
	Raw = Raw.Replace("&amp;", "&")
	Raw = Raw.Replace("&ouml;", "ö")
	Raw = Raw.Replace("&auml;", "ä")
	Raw = Raw.Replace("&uuml;", "ü")
	Raw = Raw.Replace("&Ouml;", "Ö")
	Raw = Raw.Replace("&Auml;", "Ä")
	Raw = Raw.Replace("&Uuml;", "Ü")
	Raw = Raw.Replace("&szlig;", "ß")
	Raw = Raw.Replace("lt;", "<")
	Raw = Raw.Replace("gt;", ">")
	Raw = Raw.Replace("quot;", """")
	Raw = Raw.Replace("apos;", "'")
   Return Raw
End Sub

Public Sub EscapeURL(Raw As String) As String
   Dim sb As StringBuilder
   sb.Initialize
   For i = 0 To Raw.Length - 1
     Dim C As Char = Raw.CharAt(i)
	 Select C
       Case CRLF
         sb.Append("%0A")
         'sb.Append("%0A%0D")
		Case Chr(0)
         	sb.Append("%20")
		Case Chr(32)
         	sb.Append("%20")
		Case "!" 	
			sb.Append("%21")
		Case """"
			sb.Append("%22")
		Case "#" 	
			sb.Append("%23")
		Case "$" 	
			sb.Append("%24")
		Case "%" 	
			sb.Append("%25")
		Case "&" 	
			sb.Append("%26")
		Case "'" 	
			sb.Append("%27")
		Case "(" 	
			sb.Append("%28")
		Case ")" 	
			sb.Append("%29")
		Case "*" 	
			sb.Append("%2A")
		Case "+" 	
			sb.Append("%2B")
		Case "," 	
			sb.Append("%2C")
		Case "/" 	
			sb.Append("%2F")
		Case ":" 	
			sb.Append("%3A")
		Case ";" 	
			sb.Append("%3B")
		Case "=" 	
			sb.Append("%3D")
		Case "?" 	
			sb.Append("%3F")
		Case "@" 	
			sb.Append("%40")
		Case "[" 	
			sb.Append("%5B")
		Case "]" 	
			sb.Append("%5D")
		Case "<"
			sb.Append("%3C")
		Case ">"
			sb.Append("%3E")
		 Case "-"
			sb.Append("%20")

		' UMLAUTE
		Case "Ä"
			sb.Append("%C3%84")
		Case "ä"
			sb.Append("%C3%A4")
		Case "Ö"
			sb.Append("%C3%96")
		Case "ö"
			sb.Append("%C3%B6")
		Case "Ü"
			sb.Append("%C3%9C")
		Case "ü"
			sb.Append("%C3%BC")
		Case "ß"
			sb.Append("%C3%9F")
       	Case Else
         	sb.Append(C)
     End Select
   Next
   Return sb.ToString
End Sub

'Define a connection to MySQL server
Sub MySQLConnectionString(serverIP As String,  serverPort As String, serverDB As String) As String
	Dim sb As StringBuilder
	sb.Initialize 
	sb.Append("jdbc:mysql://").Append(serverIP).Append(":").Append(serverPort).Append("/").Append(serverDB)
	Return sb.tostring
End Sub

'Define a connection string to Microsoft SQL server
Sub MSSQLConnectionString(serverIP As String,  serverPort As String, serverDB As String) As String
	Dim sb As StringBuilder
	sb.Initialize 
	sb.Append("jdbc:jtds:sqlserver://").Append(serverIP).Append(":").Append(serverPort).Append("/").Append(serverDB)
	Return sb.tostring
End Sub

'Initialize a connection to SQLite database
Sub InitializeSQLite(Dir As String, fileName As String, createIfNeeded As Boolean) 'ignore
	SQLite.InitializeSQLite(Dir, fileName, createIfNeeded)
	DatabaseType = 0
End Sub

Public Sub File_GetExtension(path As String) As String  'ignore
	Dim pos As Int = path.lastIndexOf(".")
	Return path.substring(pos + 1)
End Sub

Public Sub File_HasExtension(path As String) As Boolean  'ignore
	Dim pos As Int = path.lastIndexOf(".")
	Return (pos > 0)
End Sub

Public Sub File_ToBytes (Dir As String, FileName As String) As Byte()
	Return Bit.InputStreamToBytes(File.OpenInput(Dir, FileName))
End Sub

Public Sub File_CreateFromAsset(Folder As String, FileName As String) As Boolean
	Dim Result As Boolean = True
	If Not(File.Exists(Folder, FileName)) Then
		Try
			File.WriteString(Folder, FileName, File.ReadString(File.DirAssets, FileName))
		Catch
			Result = False
		End Try
	End If
	Return Result
End Sub

Public Sub Label_SetTextColor(Lbl As Label, Color As Paint)
	If Lbl.IsInitialized Then
		CSSUtils.SetStyleProperty(Lbl, "-fx-text-fill", CSSUtils.ColorToHex(Color))
	End If
End Sub

Public Sub Pane_AddToolTip(p As Pane, msg As String)
	Dim joToolTip As JavaObject
	Dim joToolTip2 As JavaObject = joToolTip.InitializeNewInstance("javafx.scene.control.Tooltip", Array(msg))
	joToolTip.RunMethod("install", Array(p, joToolTip2))
End Sub
'Initialize a connection to MSAccess database
Sub InitializeMsAccess(Dir As String, fileName As String)
	SQLite.Initialize("net.ucanaccess.jdbc.UcanaccessDriver", "jdbc:ucanaccess://" & File.Combine(Dir,fileName) & ";memory=true")
	DatabaseType = 0
End Sub

'Initialize a connection to MySQL server and returns True if successful
Sub InitializeMySQL(serverIP As String,  serverPort As String, serverDB As String, login As String, password As String, poolSize As Int) As Boolean
	Log("init mysql")
	DatabaseType = 1
	UsePool = True
	Try
		Dim jdbcUrl As String
		jdbcUrl = MySQLConnectionString(serverIP,serverPort,serverDB)
       	pool.Initialize("com.mysql.jdbc.Driver", jdbcUrl, login, password)
   		' change pool size...
		Dim jo As JavaObject = pool
    	jo.RunMethod("setMaxPoolSize", Array(poolSize))	
		Return True
    Catch
		Log("InitializeMySQL: "&LastException.Message)
	   Return False
    End Try
End Sub

'Initialize a connection to Microsoft SQL server
Sub InitializeMSSQL(serverIP As String,  serverPort As String, serverDB As String ,login As String, password As String, poolSize As Int) As Boolean
	DatabaseType = 2
	Try
		Dim jdbcUrl As String
		jdbcUrl = MSSQLConnectionString(serverIP,serverPort,serverDB)
		pool.Initialize("net.sourceforge.jtds.jdbc.Driver", jdbcUrl, login, password)
		' change pool size...	
		Dim jo As JavaObject = pool
		jo.RunMethod("setMaxPoolSize", Array(poolSize))
		Return True
	Catch
		Log("InitializeMSSQL: " & LastException.Message)
		Return False
	End Try
End Sub

'Update a single mapped record and return true if successful
Sub SQLRecordUpdate(xSQL As SQL, TableName As String, Fields As Map, PrimaryKey As String, PrimaryValue As String) As Boolean
	Dim w As Map
	w.Initialize
	w.Put(PrimaryKey, PrimaryValue)
	Return SQLRecordUpdateWhere(xSQL,TableName,Fields,w)
End Sub


'Update a mapped record and return true if successful
Sub SQLRecordUpdateWhere(xSQL As SQL, TableName As String, Fields As Map, WhereFieldEquals As Map) As Boolean
	If WhereFieldEquals.Size = 0 Then
		Log("WhereFieldEquals map empty!")
		Return False
	End If
	If Fields.Size = 0 Then
		Log("Fields empty")
		Return False
	End If
	Fields = DeDuplicateMap(Fields)
	WhereFieldEquals = DeDuplicateMap(WhereFieldEquals)
	Dim sb As StringBuilder
	xSQL.BeginTransaction
	Try
		sb.Initialize
		sb.Append("UPDATE ").Append(TableName).Append(" SET ")
		Dim args As List
		args.Initialize
		For i=0 To Fields.Size-1
			If i<>Fields.Size-1 Then
				sb.Append(Fields.GetKeyAt(i)).Append("=?,")
			Else
				sb.Append(Fields.GetKeyAt(i)).Append("=?")
			End If
			args.Add(Fields.GetValueAt(i))
		Next
    
		sb.Append(" WHERE ")
		For i = 0 To WhereFieldEquals.Size - 1
			If i > 0 Then 
				sb.Append(" AND ")
			End If
			sb.Append(WhereFieldEquals.GetKeyAt(i)).Append(" = ?")
			args.Add(WhereFieldEquals.GetValueAt(i))
		Next
		Log("SQLRecordUpdateWhere: " & sb.ToString)
		xSQL.ExecNonQuery2(sb.ToString, args)
		xSQL.TransactionSuccessful
		Return True 
	Catch
		Log("SQLRecordUpdateWhere: " & LastException)
		xSQL.Rollback
		Return False
	End Try
End Sub

'Insert a single map record and return true if successful
Sub SQLRecordInsert(xSQL As SQL, TableName As String, nRecord As Map) As Boolean
	Dim nList As List
	nList.Initialize
	nList.Add(nRecord)
	Return SQLRecordInsertMaps(xSQL, TableName, nList)
End Sub

Sub DeDuplicateMap(oldMap As Map) As Map
	Dim nMap As Map
	Dim strValue As Object
	nMap.Initialize
	For Each strKey As String In oldMap.Keys
		 strValue = oldMap.Get(strKey)
		 strKey = strKey.ToLowerCase
		 nMap.Put(strKey,strValue) 
	Next
	Return nMap
End Sub

'Insert Mapped Records to database and return true if successful
Sub SQLRecordInsertMaps(xSQL As SQL, TableName As String, ListOfMaps As List) As Boolean
	Dim sb, columns, values As StringBuilder
	'Small check for a common error where the same map is used in a loop
	If ListOfMaps.Size > 1 And ListOfMaps.Get(0) = ListOfMaps.Get(1) Then
		Log("Same Map found twice in list. Each item in the list should include a different map object.")
		Return False
	End If
	xSQL.BeginTransaction
	Try
		For i1 = 0 To ListOfMaps.Size - 1
			sb.Initialize
			columns.Initialize
			values.Initialize
			Dim listOfValues As List
			listOfValues.Initialize
			sb.Append("INSERT INTO " & TableName & " (")
			Dim m As Map
			m = ListOfMaps.Get(i1)
			m = DeDuplicateMap(m)
			For i2 = 0 To m.Size - 1
				Dim col As String
				Dim value As Object	
				col = m.GetKeyAt(i2)
				value = m.GetValueAt(i2)
				If i2 > 0 Then
					columns.Append(", ")
					values.Append(", ")
				End If
				columns.Append(col)
				
				values.Append("?")
				listOfValues.Add(value)
			Next
			sb.Append(columns.ToString)
			sb.Append(") VALUES (")
			sb.Append(values.ToString)
			sb.Append(")")
			If i1 = 0 Then Log("InsertMaps (first query out of " & ListOfMaps.Size & "): " & sb.ToString)
			Log("InsertMaps: " & sb.ToString)
			jSQL.ExecNonQuery2(sb.ToString, listOfValues)
		Next
		xSQL.TransactionSuccessful
		Return True
	Catch
		Log("SQLRecordInsertMaps: " & LastException)
		xSQL.Rollback
		Return False
	End Try
End Sub

'Get a connection to SQL server
Sub SQLGet() As SQL
	If DatabaseType = 0 Then
		Return SQLite
	Else
		Return pool.GetConnection
	End If
End Sub

'Close the database connection
Sub SQLClose(mySQL As SQL)
	If DatabaseType <> 0 Then
		mySQL.Close
	End If
End Sub

'Determines if a record exists and returns true
Sub SQLRecordExists(xSQL As SQL, TableName As String, PrimField As String, PrimValue As String) As Boolean
	Dim mr As Map = SQLExecuteMap(xSQL, "SELECT " & PrimField & " From " & TableName & " WHERE lower(" & PrimField & ") = ?", Array As String(PrimValue.tolowercase))
	If mr.IsInitialized = False Then
		Return False
	Else
		Return True 
	End If
End Sub

'Execute a select query and returns a single record
Sub SQLExecuteMap(xSQL As SQL, Query As String, StringArgs() As String) As Map
	Dim res As Map
	Dim cur As ResultSet
	If StringArgs <> Null Then 
		cur = xSQL.ExecQuery2(Query, StringArgs)
	Else
		cur = xSQL.ExecQuery(Query)
	End If
	Log("ExecuteMap: " & Query)
	If cur.NextRow = False Then
		'Log("No records found.")
		Return res
	End If
	res.Initialize
	For i = 0 To cur.ColumnCount - 1
		Dim fValue As String = cur.GetString2(i)
		fValue = FixNull(fValue)
		res.Put(cur.GetColumnName(i).ToLowerCase, fValue)
	Next
	cur.Close
	Return res
End Sub

Sub FixNull(sObj As Object) As String
	Dim sValue As String
	If sObj = Null Then
		sValue = ""
	Else
		sValue = CStr(sObj)
	End If
	sValue = sValue.Replace("NULL","").Replace("null","")
	Return sValue
End Sub


Sub CStr(o As Object) As String
	Return "" & o
End Sub


'Execute a query and return a list of Mapped records
Sub SQLExecuteMaps(xSQL As SQL, Query As String, args As List) As List
	Dim l As List
	l.Initialize
	Dim cur As ResultSet
	Try
		cur = xSQL.ExecQuery2(Query, args)
		Do While cur.NextRow
			Dim res As Map
			res.Initialize
			For i = 0 To cur.ColumnCount - 1
				Dim fValue As String = cur.GetString2(i)
				fValue = FixNull(fValue)
				res.Put(cur.GetColumnName(i).ToLowerCase, fValue)
			Next
			l.Add(res)
		Loop
		cur.Close
		Return l
	Catch
		Log("SQLExecuteMaps: " & LastException)
		Return l
	End Try
End Sub

'Read a record from the database and return it as a map
Sub SQLRecordRead(xSQL As SQL, TableName As String, PrimaryKey As String, PrimaryValue As String) As Map
	Return SQLExecuteMap(xSQL, "SELECT * FROM " & TableName & " WHERE lower(" & PrimaryKey & ") = ?",Array As String(PrimaryValue.tolowercase))
End Sub

'Delete single/multiple records specifying a primary key
Sub SQLRecordDelete(xSQL As SQL, TableName As String, KeyField As String, KeyValue As String) As Boolean
	Dim w As Map
	w.Initialize 
	w.Put(KeyField,KeyValue)
	Return SQLRecordDeleteWhere(xSQL,TableName,w)
End Sub

Sub SQLRecordDeleteWhere(xSQL As SQL, TableName As String, WhereFieldEquals As Map) As Boolean
   Dim sb As StringBuilder
   sb.Initialize
   sb.Append("DELETE FROM ").Append(TableName).Append(" WHERE ")
   If WhereFieldEquals.Size = 0 Then
      Log("WhereFieldEquals map empty!")
      Return False
   End If
   Dim args As List
   args.Initialize
   For i = 0 To WhereFieldEquals.Size - 1
      If i > 0 Then sb.Append(" AND ")
      sb.Append(WhereFieldEquals.GetKeyAt(i)).Append(" = ?")
      args.Add(WhereFieldEquals.GetValueAt(i))
   Next
   Log("DeleteRecord: " & sb.ToString)
   xSQL.BeginTransaction
   Try
       xSQL.ExecNonQuery2(sb.ToString, args)
   	   xSQL.TransactionSuccessful
	   Return True
	Catch
		xSQL.Rollback
		Return False
	End Try
End Sub

'Configure tooltip behaviour
Public Sub ConfigureTooltip(OpenDelay As Long,VisibleDuration As Long,CloseDelay As Long)

	Dim MEJO As JavaObject = Me
	Dim ClassShortName As String = MEJO.RunMethod("toString",Null)
	ClassShortName = ClassShortName.SubString(ClassShortName.LastIndexOf("."))
	Dim ModJO As JavaObject
	ModJO.InitializeStatic(GetPackageName(Me) & ClassShortName)

	If ModJO.RunMethod("setTooltipTimers",Array(OpenDelay, VisibleDuration, CloseDelay)) = False  Then
		Log($"*******${CRLF}Tooltip Configuration failed${CRLF}*******"$)
	End If

End Sub

'Return the current PackageName
Private Sub GetPackageName(Module As Object) As String
	Dim ModJo As JavaObject = Module
	Dim MoStr As String = ModJo.RunMethod("toString",Null)
	Return MoStr.SubString2(MoStr.LastIndexOf(" ")+1,MoStr.LastIndexOf("."))
End Sub

#if java

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import javafx.scene.control.Tooltip;
import javafx.util.Duration;

  /**
   * Returns true if successful.
   * Current defaults are 1000, 5000, 200;
   */
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public static boolean setTooltipTimers(long openDelay, long visibleDuration, long closeDelay)
  {
    try
    {
      Field f = Tooltip.class.getDeclaredField("BEHAVIOR");
      f.setAccessible(true);


      Class[] classes = Tooltip.class.getDeclaredClasses();
      for (Class clazz : classes)
      {
        if (clazz.getName().equals("javafx.scene.control.Tooltip$TooltipBehavior"))
        {
          Constructor ctor = clazz.getDeclaredConstructor(Duration.class, Duration.class, Duration.class, boolean.class);
          ctor.setAccessible(true);
          Object tooltipBehavior = ctor.newInstance(new Duration(openDelay), new Duration(visibleDuration), new Duration(closeDelay), false);
          f.set(null, tooltipBehavior);
          break;
        }
      }
    }
    catch (Exception e)
    {

      return false;
    }
    return true;
  }


#end if

'convert a string to a date
Sub String2Date(sDate As String) As Long
	Dim lng As Long
	Dim OrigFormat As String=DateTime.DateFormat
	If Date.Length > 10 Then
		DateTime.DateFormat = "yyyy-MM-dd"
		DateTime.DateFormat = "HH:mm:ss"
		Dim d As String = Date.SubString2(0,11)
		Dim t As String = Date.SubString(12)
		lng = DateTime.DateTimeParse(d,t)
	Else
		DateTime.DateFormat = "yyyy-MM-dd"
		lng = DateTime.Dateparse(sDate)
	End If
	DateTime.DateFormat=OrigFormat
	Return lng
End Sub

'convert a date to a string
Sub Date2String(lDate As Long, withTime As Boolean) As String
	Dim OrigFormat As String=DateTime.DateFormat
	If withTime Then
		DateTime.DateFormat="yyyy-MM-dd'T'HH:mm:ss"
	Else
		DateTime.DateFormat="yyyy-MM-dd"
	End If
	Dim MyDate As String =DateTime.Date(lDate)
	DateTime.DateFormat=OrigFormat
	Return MyDate
End Sub


'convert a string to monetary format
Sub MakeMoney(sValue As String) As String
	If sValue.Length = 0 Then Return "0.00"
	If sValue = "null" Then sValue = "0.00"
	sValue = sValue.Replace(",","")
	sValue = Val(sValue)
	If sValue = "0" Then sValue = "000"
	sValue = Round2(sValue,2)
	Return NumberFormat2(sValue, 1, 2, 2, True)
End Sub

Sub MapProperty2ListQuote(om As List,prop As String,def As String) As List
	Dim lst As List: lst.initialize
	Dim mtot As Int = om.Size - 1
	Dim mcnt As Int = 0
	For mcnt = 0 To mtot
		Dim omm As Map = om.Get(mcnt)
		Dim strvalue As String = GetDefault(omm,prop,def)
		lst.Add(QUOTE & strvalue & QUOTE)
	Next
	Return lst
End Sub

'convert a string to a percentage
Sub Percentage(sValue As String) As String
    If sValue = "" Then sValue = "0.00"	
	If sValue.Length = 0 Then Return "0.00"
	If sValue = "null" Then sValue = "0.00"
	sValue = sValue.Replace(",","")
	sValue = Val(sValue)
	If sValue = "0" Then sValue = "0.00"
	sValue = Round2(sValue,2)
	sValue = sValue & "%"
	Return sValue
End Sub

Sub TimeAgo(dt As String) As String
	If dt.IndexOf(" ") = -1 Then Return ""
	Dim diff As Period
	diff.Initialize
	DateTime.DateFormat="yyyy-MM-dd"
	DateTime.TimeFormat="HH:mm:ss"
	Dim mtime() As String = Regex.split(" ", dt)
	Dim dd As String = mtime(0)
	Dim tt As String = mtime(1)
	Dim pd As Long = DateTime.DateTimeParse(dd,tt)
	diff = DateUtils.PeriodBetween(pd,DateTime.now)
	Dim ta As String
	If diff.Years <> 0 Then
		ta = $"${diff.years} year(s) ago"$
		Return ta
	End If
	If diff.Months <> 0 Then
		ta = $"${diff.months} month(s) ago"$
		Return ta
	End If
	If diff.Days <> 0 Then
		ta = $"${diff.days} day(s) ago"$
		Return ta
	End If
	If diff.Hours <> 0 Then
		ta = $"${diff.hours} hour(s) ago"$
		Return ta
	End If
	If diff.Minutes <> 0 Then
		ta = $"${diff.minutes} minute(s) ago"$
		Return ta
	End If
	If diff.Seconds <> 0 Then
		ta = $"${diff.seconds} second(s) ago"$
		Return ta
	End If
End Sub


'Verify if an import is valid
Sub IsImportValid(m As Map, fields As List) As Boolean
	Dim vCnt As Int = 0
	If (fields.Size - 1) = 0 Then Return True
	For Each strField As String In fields
		Dim strValue As String = m.GetDefault(strField.ToLowerCase,"")
		If strValue.Length = 0 Then
			vCnt = vCnt + 1
		End If
	Next
	If vCnt = 0 Then
		Return True
	Else
		Return False
	End If
End Sub

'Return a random string
Sub RandomString(Length As Int, LowerCase As Boolean, UpperCase As Boolean, Numbers As Boolean, AdditionalChars As String) As String
	Dim source As String
	If LowerCase = True Then
		source = source &"abcdefghijklmnopqrstuvwxyz"
	End If
	If UpperCase = True Then
		source = source &"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	End If
	If Numbers = True Then
		source = source &"0123456789"
	End If
	If AdditionalChars.Length > 0 Then
		source = source&AdditionalChars
	End If

	Dim SB As StringBuilder
	SB.Initialize
	For i = 1 To Length
		Dim r As Int = Rnd(0,source.Length-1)
		SB.Append(source.SubString2(r,r+1))
	Next
	Return SB.ToString
End Sub

'Return a random password
Sub GeneratePassword(IntNum As Int) As String
	Return RandomString(IntNum,True,True,True,"")
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

'return an image path for a variance (up, down, same)
Public Sub UpDownSame(variance As String) As String
	If variance < 0 Then Return "../images/up.png"
	If variance > 0 Then Return "../images/down.png"
	If variance = 0 Then Return "../images/same.png"
	Return ""
End Sub


'delete a folder recursively
Sub DeleteFolderRecursive(Folder As String)
	Try
   For Each f As String In File.ListFiles(Folder)
     If File.IsDirectory(Folder, f) Then
       DeleteFolderRecursive (File.Combine(Folder, f))
     End If
     If File.Exists(Folder,f) = True Then File.Delete(Folder, f)
   Next
   Catch
   	Log(LastException)
   End Try
End Sub