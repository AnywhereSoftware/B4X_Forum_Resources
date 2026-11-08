B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=MTPExample.zip
'Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe


'pip install C:\Users\H\Downloads\projects\mtp-main
'python -m mtp.create_new_comtype_modules_from_wpd_dlls

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Py As PyBridge
	Private AnotherProgressBar1 As AnotherProgressBar
	Private btnFindDevice As B4XView
	Private WinAccess As PyWrapper
	Private clvFiles As CustomListView
	Private ITEM_TYPE_DEVICE = 1, ITEM_TYPE_DIRECTORY = 2, ITEM_TYPE_FILE = 3, ITEM_TYPE_ROOT = 5 As Int
	Type MTPDevice (Name As String, Serial As String, Remote As PyWrapper)
	Type ItemData (ItemType As Int, ITEM As Object, Name As String)
	Private KnownDevices As List
	Private RemoteDevice As MTPDevice
	Private Breadcrumbs As List
	Private B4XBreadCrumb1 As B4XBreadCrumb
	Private pnlBusy As B4XView
	Private btnUploadFile As B4XView
	Private FileChooser As FileChooser
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	clvFiles.DefaultTextBackgroundColor = xui.Color_White
	Py.Initialize(Me, "Py")
	Dim opt As PyOptions = Py.CreateOptions("Python/python/python.exe")
	Py.Start(opt)
	BusyState(True)
	Wait For Py_Connected (Success As Boolean)
	BusyState(False)
	If Success = False Then
		LogError("Failed to start Python process.")
		Return
	End If
	btnFindDevice.Enabled = True
	WinAccess = Py.ImportModule("mtp.win_access")
	KnownDevices.Initialize
	Breadcrumbs.Initialize
	FileChooser.Initialize
End Sub

Private Sub btnFindDevice_Click
	clvFiles.Clear
	KnownDevices.Clear
	Dim RemoteDevices As PyWrapper = WinAccess.Run("get_portable_devices")
	Dim DevicesNames As PyWrapper = Py.Map_(Py.Lambda("dev: (dev.name, dev.serialnumber)"), RemoteDevices).ToList
	Wait For (DevicesNames.Fetch) Complete (DevicesNames As PyWrapper)
	Dim devices As List = DevicesNames.Value 'each item is an array of objects (name, serial).
	If devices.Size = 0 Then
		xui.MsgboxAsync("No device found", "")
		Return
	End If
	For i = 0 To devices.Size - 1
		Dim o() As Object = devices.Get(i)
		KnownDevices.Add(CreateMTPDevice(o(0), o(1), RemoteDevices.Get(i)))
	Next
	ShowDevicesList
End Sub

Private Sub CloseDeviceIfNeeded
	If RemoteDevice.IsInitialized Then 
		Log("closing device")
		RemoteDevice.Remote.Run("close")
	End If
	Dim RemoteDevice As MTPDevice 'it will be uninitialized
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	CloseDeviceIfNeeded
	Sleep(200)
	Return True
End Sub

Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub

Private Sub BusyState (Busy As Boolean)
	AnotherProgressBar1.Visible = Busy
	pnlBusy.Visible = Busy
End Sub


Private Sub clvFiles_ItemClick (Index As Int, Value As Object)
	UpdateList(Value, True)
End Sub

Private Sub UpdateList(ItemData As ItemData, AddToBreadcrumbs As Boolean)
	Select ItemData.ItemType
		Case ITEM_TYPE_DEVICE
			RemoteDevice = ItemData.Item
			Dim portables As PyWrapper = RemoteDevice.Remote.Run("get_content").ToList
			ShowPortables (portables)
		Case ITEM_TYPE_DIRECTORY
			Dim portables As PyWrapper = ItemData.Item.As(PyWrapper).Run("get_children").ToList
			ShowPortables(portables)
		Case ITEM_TYPE_ROOT
			ShowDevicesList
		Case ITEM_TYPE_FILE
			DownloadFile(ItemData)
			AddToBreadcrumbs = False
	End Select
	If AddToBreadcrumbs Then 
		Breadcrumbs.Add(ItemData)
		UpdateBreadcrumbs
		
	End If
End Sub

Private Sub GetTopItemData As ItemData
	Return Breadcrumbs.Get(Breadcrumbs.Size - 1)
End Sub

Private Sub DownloadFile (ItemData As ItemData)
	BusyState(True)
	Dim output As String = File.Combine(File.DirApp, ItemData.Name) 'File.DirApp is read-only with standalone packages. Use XUI.DefaultFolder instead.
	ItemData.ITEM.As(PyWrapper).Run("download_file").Arg(output)
	Wait For (Py.Flush) Complete (Success As Boolean)
	BusyState(False)
	If Success Then
		Dim fx As JFX
		fx.ShowExternalDocument(xui.FileUri(output, ""))
	Else
		xui.MsgboxAsync("Failed to download file: " & LastException, "")
	End If
End Sub

Private Sub UpdateBreadcrumbs
	Dim items As List
	items.Initialize
	For Each id As ItemData In Breadcrumbs
		items.Add(IIf(id.Name.Length > 10, id.Name.SubString2(0, 10) & "...", id.Name))
	Next
	B4XBreadCrumb1.Items = items
	btnUploadFile.Enabled = GetTopItemData.ItemType = ITEM_TYPE_DIRECTORY
End Sub

Private Sub B4XBreadCrumb1_CrumbClick (Crumbs As List)
	Breadcrumbs = B4XCollections.SubList(Breadcrumbs, 0, Crumbs.Size)
	UpdateBreadcrumbs
	UpdateList(GetTopItemData, False)
End Sub

Private Sub ShowDevicesList
	CloseDeviceIfNeeded
	clvFiles.Clear
	Breadcrumbs.Clear
	Breadcrumbs.Add(CreateItemData(ITEM_TYPE_ROOT, Null, "Root"))
	B4XBreadCrumb1.mBase.Visible = True
	btnUploadFile.Enabled = False
	UpdateBreadcrumbs
	For Each dev As MTPDevice In KnownDevices
		clvFiles.AddTextItem($"${dev.Name}: (${dev.Serial})"$, CreateItemData(ITEM_TYPE_DEVICE, dev, dev.Name))
	Next
End Sub

Private Sub ShowPortables (Portables As PyWrapper)
	clvFiles.Clear
	Dim FilesData As PyWrapper = Py.Map_(Py.Lambda("file: (file.name, file.size, file.content_type)"), Portables).ToList
	BusyState(True)
	Wait For (FilesData.Fetch) Complete (FilesData As PyWrapper)
	BusyState(False)
	If FilesData.IsSuccess = False Then
		xui.MsgboxAsync("Failed to list files: " & LastException, "")
		Return
	End If
	Dim fd As List = FilesData.Value
	For i = 0 To fd.Size - 1
		Dim o() As Object = fd.Get(i)
		Dim ContentType As Int
		Select o(2).As(Int)
			Case 0, 1
				ContentType = ITEM_TYPE_DIRECTORY
			Case 2
				ContentType = ITEM_TYPE_FILE
			Case Else
				Log("Unexpected type")
				Continue
		End Select
		Dim Value As Object = CreateItemData(ContentType, Portables.Get(i), o(0))
		If ContentType = ITEM_TYPE_DIRECTORY Then
			clvFiles.AddTextItem($"${o(0)} (folder)"$, Value)
		Else
			Dim size As Long = o(1)
			Dim SizeString As String = IIf(size < 10000, NumberFormat(size, 0, 0) & " bytes", NumberFormat(size / 1024, 0, 0) & " kb")
			clvFiles.AddTextItem($"${o(0)}	${SizeString}"$, Value)
		End If
	Next
End Sub

Public Sub CreateMTPDevice (Name As String, Serial As String, Remote As PyWrapper) As MTPDevice
	Dim t1 As MTPDevice
	t1.Initialize
	t1.Name = Name
	t1.Serial = Serial
	t1.Remote = Remote
	Return t1
End Sub

Public Sub CreateItemData (ItemType As Int, Item As Object, Name As String) As ItemData
	Dim t1 As ItemData
	t1.Initialize
	t1.ItemType = ItemType
	t1.Item = Item
	t1.Name = Name
	Return t1
End Sub

Private Sub pnlBusy_MouseClicked (EventData As MouseEvent)
	EventData.Consume
End Sub

Private Sub btnUploadFile_Click
	Dim res As String = FileChooser.ShowOpen(B4XPages.GetNativeParent(Me))
	If res <> "" Then
		Dim id As ItemData = GetTopItemData
		id.ITEM.As(PyWrapper).Run("upload_file").Arg(File.GetName(res)).Arg(res)
		BusyState(True)
		Wait For (Py.Flush) Complete (Success As Boolean)
		BusyState(False)
		If Success = False Then
			Log(LastException)
			xui.MsgboxAsync("Failed to upload file: " & LastException, "")
		Else
			UpdateList(id, False)
		End If
	End If
End Sub

