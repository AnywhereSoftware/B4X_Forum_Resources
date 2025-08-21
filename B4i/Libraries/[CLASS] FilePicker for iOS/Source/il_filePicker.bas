B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.5
@EndOfDesignText@
Sub Class_Globals
	Type fileatt(path As String, filename As String, isdir As Boolean, isselected As Boolean)
	Public Extensions_allfiles As Int = 0
	Public Extensions_audioformats As Int = 1
	Public Extensions_imageformats As Int = 2
	Public Extensions_videoformats As Int = 3
	Public Extensions_adobeformats As Int = 4
	Public Extensions_officeformats As Int = 5
	Public Extensions_archiveformats As Int = 6
	Public Extensions_domunetformats As Int = 7
	Public Extensions_flashformats As Int = 8
	Private SenderEvent As String 'ignore
	Private SenderCallObject As Object
	Private toadPanel As Panel
	Private vpW, vpH As Float 'ignore
	Private filedialogtv As TableView
	Private filedialogpnl,filedialogtvpnl As Panel 
	Private filedialogcancel, filedialokadd As Label 
	Private filedialogpath, filedialogstartingpathnew As String
	Private toAddFileMap As Map
	Private selectedExtension() As Int
End Sub

'CallBack (Sender page)
'CallPanel (Panel that will hold tha player like Page.Rootpanel)
'Event (Object Event to handle CallSub() Method)
'StartPath (Set the path where the Dialog should show on start)
'fileExtension (Array as int, set the file extension you want to filer)
Public Sub Initialize(CallBack As Object, CallPanel As Panel, Event As String, StartPath As String)
	SenderEvent = Event
	SenderCallObject = CallBack
	 
	toadPanel.Initialize("toadPanel")
	vpW = CallPanel.Width
	vpH = CallPanel.Height
	  
	filedialogstartingpathnew = StartPath
	toAddFileMap.Initialize
	
	filedialogtv.Initialize("filedialogtableview",False)
	filedialogtv.Color = Colors.White
	
	filedialogpnl.Initialize("filedialogpnl")
	filedialogpnl.Color = Colors.White

	CallPanel.AddView(filedialogpnl,0,vpH*1.2,vpW,vpH)
	
	filedialogtvpnl.Initialize("")
	filedialogtvpnl.Color = Colors.White

	filedialogcancel.Initialize("filedialogcancel")
	filedialogcancel.Color = Colors.Transparent
	filedialogcancel.Font = Font.CreateFontAwesome(16)
	filedialogcancel.TextColor = Colors.RGB(54,54,54)
	filedialogcancel.Text = Chr(0xF104) & "   Cancel"
	filedialogcancel.TextAlignment = filedialogcancel.ALIGNMENT_LEFT
	
	filedialokadd.Initialize("filedialokadd")
	filedialokadd.Color = Colors.Transparent
	filedialokadd.Font = Font.CreateFontAwesome(16)
	filedialokadd.TextColor = Colors.RGB(33,151,255)
	filedialokadd.Text = "Add   " & Chr(0xF00C)
	filedialokadd.TextAlignment = filedialogcancel.ALIGNMENT_RIGHT
	
	filedialogpnl.AddView(filedialogcancel,vpW*0.025,0,vpW*0.2,vpH*0.075)
	filedialogpnl.AddView(filedialokadd,vpW*0.775,0,vpW*0.2,vpH*0.075)
	filedialogpnl.AddView(filedialogtvpnl,0,vpH*0.075,vpW,vpH*0.925)
 
	'fill table view
	filedialogtvpnl.AddView(filedialogtv, 0, 0, filedialogtvpnl.Width, filedialogtvpnl.Height)
	filedialogtv.RowHeight = filedialogtvpnl.Height/14
End Sub

'Set the file extension you would like to filter
Public Sub fp_setFileExtensions(fileExtension() As Int)
	selectedExtension = fileExtension
End Sub
 
Private Sub toadPanel_Click
	'do nothing
End Sub

'show the filedialog. loaded from startingpath you have set on initialize
Public Sub fp_show
	filedialogpath = filedialogstartingpathnew 'reset the path to starting path
	addfiletofiledialog(filedialogpath)
End Sub
 
Private Sub addfiletofiledialog(path As String)
	If path = "" Then path = File.DirDocuments
	fileFiledialogtv(filedialogpath, filedialogstartingpathnew)
	toAddFileMap.Clear
	
	filedialogpnl.Left = 0
	filedialogpnl.Top = vpH*1.2
	filedialogpnl.BringToFront
	filedialogpnl.SetLayoutAnimated(600,0.9,0,0,filedialogpnl.Width,filedialogpnl.Height)
End Sub

Private Sub fileFiledialogtv(path As String, startingpath As String)
	filedialogtv.Clear

	Dim filelist As List = File.ListFiles(File.Combine(path,""))
	filelist.Sort(True) 'sort list

	Dim folderimg As Bitmap = LoadBitmap(File.DirAssets,"foldericon.png")
	Dim folderimgup As Bitmap = LoadBitmap(File.DirAssets,"foldericonup.png")
	Dim insidefolder As Boolean = False
	
	If path <> startingpath Then
		Dim tc As TableCell = filedialogtv.AddSingleLine("")
		Dim ColoredTitle As AttributedString
		ColoredTitle.Initialize("...", Font.CreateNew(16), Colors.RGB(31,31,31))
		tc.Text = ColoredTitle
		tc.Bitmap = folderimgup
		tc.ShowSelection = False
		tc.Tag = 9999
		tc.CustomView = CreateItem(tc,"filedialogtvclick",filedialogtvpnl.Width,filedialogtv.RowHeight)
		insidefolder = True
	End If
	
	If filelist.Size > 0 Then		
		For i = 0 To filelist.Size-1
			Dim item_filename As String = filelist.Get(i)
			If File.IsDirectory(path,item_filename) Then
				addnewItemtoTv(True,item_filename,path,folderimg)
			Else
				For j = 0 To selectedExtension.Length-1
					Dim extstr As String = fp_getFileExtension(selectedExtension(j))
					If extstr <> "all" Then 
						If item_filename.Contains(".") Then 
							Dim fileextension As String = item_filename.SubString2(item_filename.LastIndexOf("."),item_filename.Length)
							If extstr.Contains(fileextension) Then 
								addnewItemtoTv(False,item_filename,path,getIconBitmap(selectedExtension(j)))
							End If
						Else 
							Exit
						End If
					Else 
						addnewItemtoTv(False,item_filename,path,getIconBitmap(selectedExtension(j)))	
						Exit
					End If
				Next
			End If
		Next
	Else
		If insidefolder = False Then 
			Dim tc As TableCell = filedialogtv.AddSingleLine("")
			Dim ColoredTitle As AttributedString
			ColoredTitle.Initialize("(No file available)", Font.CreateNew(15), Colors.ARGB(100,31,31,31))
			tc.Text = ColoredTitle
			tc.ShowSelection = False			
		End If
	End If
	filedialogtv.ReloadAll
End Sub

Private Sub addnewItemtoTv(isdir As Boolean, filename As String, path As String, icon As Bitmap)
	Dim myfile As fileatt
	myfile.Initialize
	myfile.path = path
	myfile.filename = filename
	myfile.isdir = isdir
	myfile.isselected = False
					
	Dim tc As TableCell = filedialogtv.AddSingleLine("")
	Dim ColoredTitle As AttributedString
	ColoredTitle.Initialize(filename, Font.CreateNew(16), Colors.RGB(31,31,31))
	tc.Text = ColoredTitle
	tc.Bitmap = icon
	tc.ShowSelection = False
	tc.Tag = myfile
	tc.AccessoryType = tc.ACCESSORY_NONE
	tc.CustomView = CreateItem(tc,"filedialogtvclick",filedialogtvpnl.Width,filedialogtv.RowHeight)
End Sub

Private Sub CreateItem(tc As TableCell,tveventname As String, weidth As Float, height As Float) As Panel
	Dim p As Panel
	p.Initialize(tveventname)
	p.Color = Colors.Transparent
	p.Width = weidth
	p.Height = height
	p.Tag = tc
	Return p
End Sub

Private Sub filedialogtvclick_Click
	Dim pnl As Panel = Sender
	Dim tc As TableCell = pnl.Tag
		
	If tc.Tag = 9999 Then 
		Dim onefolderup As String = filedialogpath.SubString2(0,filedialogpath.LastIndexOf("/")+1)
		filedialogpath = onefolderup
		fileFiledialogtv(filedialogpath,filedialogstartingpathnew)
	Else 
		Dim myfile As fileatt = tc.Tag
		If myfile.isdir Then 
			filedialogpath = File.Combine(filedialogpath,myfile.filename) 'update filedialogpath here
			fileFiledialogtv(filedialogpath,filedialogstartingpathnew)
		Else 
			If myfile.isselected = False Then 
				myfile.isselected = True 
				toAddFileMap.Put(myfile.filename,myfile)
				tc.AccessoryType = tc.ACCESSORY_CHECKMARK
				tc.Update
			else if myfile.isselected Then 
				myfile.isselected = False
				tc.AccessoryType = tc.ACCESSORY_NONE
				toAddFileMap.Remove(myfile.filename)
				tc.Update
			End If
		End If				
	End If
	
	pnl.Color = Colors.ARGB(50,200,200,200)
	Sleep(200)
	pnl.Color = Colors.Transparent
End Sub

Private Sub filedialokadd_Click 'add songs to songlist
	If toAddFileMap.Size > 0 Then
		If SubExists(SenderCallObject,SenderEvent & "_selectedFiles",1) Then
			CallSubDelayed2(SenderCallObject,SenderEvent & "_selectedFiles",toAddFileMap)
		End If
	Else 
		If SubExists(SenderCallObject,SenderEvent & "_msg",1) Then
			CallSubDelayed2(SenderCallObject,SenderEvent & "_msg","no_files_added_fromfiledialog")
		End If
		Return		
	End If
	filedialogpnl.SetLayoutAnimated(600,0.9,0,vpH*1.2,filedialogpnl.Width,filedialogpnl.Height)
End Sub

Private Sub getIconBitmap(extension As Int) As Bitmap 'ignore
	Return LoadBitmap(File.DirAssets,"fileicon.png")
	
	'you can set a specific icon for each file extension if you like
'	Select extension
'		Case 1 'audio file
'			Return LoadBitmap(File.DirAssets,"audioicon.png")
'		Case 2 'image filew
'			Return LoadBitmap(File.DirAssets,"imageicon.png")
'		Case 3 'video file
'			Return LoadBitmap(File.DirAssets,"videoicon.png")
'		Case 4 'adobe file
'			Return LoadBitmap(File.DirAssets,"adobeicon.png")
'		Case 5 'office file
'			Return LoadBitmap(File.DirAssets,"officeicon.png")
'		Case 6 'archive file
'			Return LoadBitmap(File.DirAssets,"archiveicon.png")
'		Case 7 'document file
'			Return LoadBitmap(File.DirAssets,"documenticon.png")
'		Case 8 'flash file
'			Return LoadBitmap(File.DirAssets,"flashicon.png")
'		Case Else 'any file
'			Return LoadBitmap(File.DirAssets,"fileicon.png")
'	End Select
End Sub

'Return the file extension as a string
Public Sub fp_getFileExtension(extension As Int) As String
	Select extension	
		Case 1 'audio file
			Return ".m4a .aac .mp3 .ac3 .ec3 .wav .wma"
		Case 2 'image filew
			Return ".tiff .gif .png .bmp .jpg .jpeg .raw .eps .tga"
		Case 3 'video file
			Return ".flv .mp4 .avi .wmv .mov .mpeg .ts .m4v .mpg"
		Case 4 'adobe file
			Return ".pdf .ai .psd .ps .eps"
		Case 5 'office file
			Return ".doc .dot .docx .xls .xlm .xlsm .csv .ppt .pot .pps .ppam .xltx .xltm .xlt .accda .accdr .accdt .mdb"
		Case 6 'archive file
			Return ".rar .zip .cab .7zp .cab .arj .lzh"
		Case 7 'document file
			Return ".txt"
		Case 8 'flash file
			Return ".fla .swf"
		Case Else 'any file
			Return "all"
	End Select
End Sub
 
Private Sub filedialogpnl_Click
	'do nothing (filte rbackground clickes)
End Sub

Private Sub filedialogcancel_Click
	filedialogpnl.SetLayoutAnimated(600,0.9,0,vpH*1.2,filedialogpnl.Width,filedialogpnl.Height)
End Sub
   
 
