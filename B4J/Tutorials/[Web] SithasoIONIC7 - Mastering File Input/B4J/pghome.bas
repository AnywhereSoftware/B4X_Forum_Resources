B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
#IgnoreWarnings:12, 9
Sub Process_Globals
	Public app As IonicApp
	Private banano As BANano			'ignore
	Public name As String = "home"
	Public title As String = "File Upload"
	Public icon As String = "logo-ionic"
	Public path As String = "/"
	Public color As String = ""
	Private home As SHIonTab		'ignore
	'Uncomment the elements you will want to access via code
	'Private homeroute As SHIonRoute		'ignore
	'Private homenav As SHIonNav		'ignore
	'Private homepage As SHLabel		'ignore
	'Private homeheader As SHIonHeader		'ignore
	'Private hometoolbar As SHIonToolbar		'ignore
	'Private homestartbuttons As SHIonButtons		'ignore
	'Private hometitle As SHIonTitle		'ignore
	'Private homeendbuttons As SHIonButtons		'ignore
	'Private homecontent As SHIonContent		'ignore
	'Private homefooter As SHIonFooter		'ignore
	Private homegrid As SHIonGrid		'ignore
	Private homegridr1 As SHIonRow		'ignore
	Private homegridr1c1 As SHIonCol		'ignore
	Private displaypicture As SHIonImg		'ignore
	Private btnupload As SHIonButton		'ignore
	Private fileupload As SHIonFileInput		'ignore
End Sub

Sub Initialize(ionapp As IonicApp)			'ignore
	app = ionapp
	'add this layout to the router-outlet
	'banano.LoadLayoutAppend(app.PageViewer, "homelayout")
	'
	home.Initialize(Me, "home", "home")
	home.Title = "File Upload"
	home.Tab = "home"
	home.HasHeader = True
	home.MenuButtonAutoHide = False
	home.ContentIonPadding = True
	home.CenterContent = True
	home.HasFooter = True
	home.AddToParent("mainpagetabs", home.CustProps)
	'Uncomment the elements you will want to access via code
	'
	'homeroute.Initialize(Me, "homeroute", "homeroute")
	'homeroute.LinkExisting
	'
	'homenav.Initialize(Me, "homenav", "homenav")
	'homenav.LinkExisting
	'
	'homepage.Initialize(Me, "homepage", "homepage")
	'homepage.LinkExisting
	'
	'homeheader.Initialize(Me, "homeheader", "homeheader")
	'homeheader.LinkExisting
	'
	'hometoolbar.Initialize(Me, "hometoolbar", "hometoolbar")
	'hometoolbar.LinkExisting
	'
	'homestartbuttons.Initialize(Me, "homestartbuttons", "homestartbuttons")
	'homestartbuttons.LinkExisting
	'
	'hometitle.Initialize(Me, "hometitle", "hometitle")
	'hometitle.LinkExisting
	'
	'homeendbuttons.Initialize(Me, "homeendbuttons", "homeendbuttons")
	'homeendbuttons.LinkExisting
	'
	'homecontent.Initialize(Me, "homecontent", "homecontent")
	'homecontent.LinkExisting
	'
	'homefooter.Initialize(Me, "homefooter", "homefooter")
	'homefooter.LinkExisting
	'assign values from layout
	name = home.PgName
	title = home.PgTitle
	icon = home.PgIcon
	path = home.PgPath
	color = home.PgIconColor
	'
	homegrid.Initialize(Me, "homegrid", "homegrid")
	homegrid.AddToParent("homecontent", homegrid.CustProps)
	'
	homegridr1.Initialize(Me, "homegridr1", "homegridr1")
	homegridr1.AddToParent("homegrid", homegridr1.CustProps)
	'
	homegridr1c1.Initialize(Me, "homegridr1c1", "homegridr1c1")
	homegridr1c1.Display = "flex"
	homegridr1c1.AlignItems = "ion-align-items-center"
	homegridr1c1.JustifyContent = "ion-justify-content-center"
	homegridr1c1.Sizes = "all=12; xs=?; sm=?; md=?; lg=?; xl=?"
	homegridr1c1.AddToParent("homegridr1", homegridr1c1.CustProps)
	'
	displaypicture.Initialize(Me, "displaypicture", "displaypicture")
	displaypicture.Alt = "Display"
	displaypicture.Height = "200px"
	displaypicture.Src = "./assets/13.jpg"
	displaypicture.Width = "100%"
	displaypicture.AddToParent("homegridr1c1", displaypicture.CustProps)
	'
	btnupload.Initialize(Me, "btnupload", "btnupload")
	btnupload.Text = "Upload File"
	btnupload.Expand = "full"
	btnupload.Shape = "round"
	btnupload.AddToParent("homefooter", btnupload.CustProps)
	'
	fileupload.Initialize(Me, "fileupload", "fileupload")
	fileupload.AcceptType = "image"
	fileupload.Capture = "environment"
	fileupload.Visible = False
	fileupload.AddToParent("homefooter", fileupload.CustProps)
	
	
	'add page to the app page collection
	app.AddPagePath(name, title, icon, path)
	BuildPage
End Sub

'show this page
Sub Show
	app.NavigateTo(path, "forward")
End Sub
'
Sub getName As String		'ignore
	Return name
End Sub
'
Sub getIcon As String		'ignore
	Return icon
End Sub
'
Sub getTitle As String		'ignore
	Return title
End Sub
'
Sub getPath As String		'ignore
	Return path
End Sub
Sub getColor As String		'ignore
	Return color
End Sub
'
'start building the page
Private Sub BuildPage
End Sub

Private Sub btnupload_click (e As BANanoEvent)
	e.PreventDefault
	'click the file input to trap the change event
	fileupload.click
End Sub

Private Sub fileupload_change (e As BANanoEvent)
	'has the file been specified
	Dim fileObj As Map = fileupload.GetFile
	If banano.IsNull(fileObj) Or banano.IsUndefined(fileObj) Then Return
	'get file details
	Dim fileDet As FileObject
	fileDet = modSithasoIonic.GetFileDetails(fileObj)
	'get the file name
	Dim fn As String = fileDet.FileName
	'you can check the size here
	Dim fs As Long = fileDet.FileSize
	If fs >= 5000 Then
	End If
	'**** UPLOAD
	'fileDet = modSithasoIonic.UploadFileWait(fileObj)
	'fileDet = modSithasoIonic.UploadFileOptionsWait(fileObj, "../assets", "n")
	'get the file name
	'Dim fn As String = fileDet.FileName
	'get the status of the upload
	'Dim sstatus As String = fileDet.Status
	'Select Case sstatus
	'Case "error"
	'Case "success"
	'End Select
	'the the full upload path of the file
	'Dim fp As String = fileDet.FullPath
	'**** UPLOAD
	'Dim fJSON As Map = BANano.Await(modSithasoIonic.readAsJsonWait(fileObj))
	'Dim fBuffer As Object = BANano.Await(modSithasoIonic.readAsArrayBufferWait(fileObj))
	'Dim fText As String = BANano.Await(modSithasoIonic.readAsTextWait(fileObj))
	Dim fText As String = banano.Await(modSithasoIonic.readAsDataURLWait(fileObj))
	'update state of some element like an image
	'for vfield use SetValue
	displaypicture.src = fText
	'clear the file input
	'fileupload.Value = ""
End Sub