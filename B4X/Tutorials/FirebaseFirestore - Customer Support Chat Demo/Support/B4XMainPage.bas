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
	Private fx As JFX
	Public Store As Firestore
	Public projectID As String = "ready-rent-7c179"
	Public authREST As FirebaseAuthREST
	Public authHELPER As FirebaseAuthRESTHelper
	Private ChatListView As CustomListView
	Private ChatPane As B4XView
	Dim ChatsListener,ChatListener As ListenerRegistration
	Private ProductsListener,UsersListener,SalesListener As ListenerRegistration
	Private Products,Users,Sales As List
	Private ChatImagePanel As B4XView
	Private ChatTitleLabel As B4XView
	Private ChatLastMessageLabel As B4XView
	Private Chats As Chat
	Private CurrentChat As String
	Private NewMessageLabel As B4XView
	Public imageCache As KeyValueStore
	Private TotalProductsLabel As B4XView
	Private TotalDeliveriesLabel As B4XView
	Private TotalSalesLabel As B4XView
	Private TotalUsersLabel As B4XView
	Private ViewSalesButton As B4XView
	Private ViewUsersButton As B4XView
	Private ViewProductsButton As B4XView
	Private ViewDeliveriesButton As B4XView
	Private DataTable As B4XTable
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("main")
	B4XPages.SetTitle(Me,"Ready Rent Support")
	
	authREST.Initialize
	authHELPER.Initialize(Me,"authHelper")
	authHELPER.GetAccessToken
	
	xui.SetDataFolder("ready-rent-support")
	imageCache.Initialize(xui.DefaultFolder,"images")
	
	Products.Initialize
	Users.Initialize
	Sales.Initialize
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
Private Sub B4XPage_CloseRequest As ResumableSub
	If ChatsListener.IsInitialized And ChatsListener.Enabled == True Then ChatsListener.Remove
	If SalesListener.IsInitialized And SalesListener.Enabled == True Then SalesListener.Remove
	If ProductsListener.IsInitialized And ProductsListener.Enabled == True Then ProductsListener.Remove
	If UsersListener.IsInitialized And UsersListener.Enabled == True Then UsersListener.Remove
	If ChatListener.IsInitialized And ChatListener.Enabled == True Then ChatListener.Remove
	Return True
End Sub


#Region AUTH
Private Sub authHelper_Authenticate
	Wait For (authREST.signInAnonymously(True)) complete (Data As Map)
	If Data.ContainsKey("idToken") Then
		Store.Initialize("Firestore",Me,Data.Get("idToken"),"(default)",projectID)
	Else
		Log("ErrorCode: " & authREST.getErrorCode(Data))
		Log("ErrorMessage: " & authREST.getErrorMessage(Data))
		Log("Reason: " & authREST.getErrorMap(Data).Get("reason"))
		Log("Domain: " & authREST.getErrorMap(Data).Get("domain"))
		Log("Message: " & authREST.getErrorMap(Data).Get("message"))
	End If
End Sub

Private Sub authHelper_AccessTokenAvailable (Success As Boolean, Token As String)
	Log("farh_AccessTokenAvailable")
	Log("Success: " & Success)
	Log("Token: " & Token)
	If Success Then
		Store.Initialize("Firestore",Me,Token,"(default)",projectID)
		Log("farh_AccessTokenAvailable")
	Else
		authHELPER.GetAccessToken
	End If
End Sub

Private Sub authHelper_RefreshToken(RefreshToken As String)
	Log("RefreshToken: " & RefreshToken)
	If RefreshToken.EqualsIgnoreCase("") == True And RefreshToken.EqualsIgnoreCase(Null) == True Then
		Log("farh_RefreshToken empty")
		authHELPER.GetAccessToken
	Else
		Log("farh_RefreshToken not empty")
		Wait For (authREST.refreshToken("refresh_token",RefreshToken)) complete (Data As Map)
		If Data.Size > 0 Then
			Store.Initialize("Firestore",Me,Data.Get("id_token"),"(default)",projectID)
			Log("farh_RefreshToken")
		Else
			Log("farh_RefreshToken failed")
			authHELPER.GetAccessToken
		End If
	End If
End Sub
#End Region

Private Sub Firestore_Ready
	Log("Firestore_Ready")
	Dim QueryMap As Map = CreateMap("orderBy":"timestamp","direction":"asc")
	ChatsListener = Store.CollectionListen2("chats",QueryMap)
	ProductsListener = Store.CollectionListen("properties")
	UsersListener = Store.CollectionListen("users")
	SalesListener = Store.CollectionListen("orders")
End Sub

Private Sub Firestore_CollectionChanged(Data As Map)
	Dim Document As Map = Data.Get("data")
	Select Data.Get("collection")
		Case "chats"
			Select Data.Get("type")
				Case Store.TYPE_ADDED
					ChatListView.Add(AddChat(Data),Data)
				Case Store.TYPE_MODIFIED
					For i = 0 To ChatListView.Size-1
						Dim item As Map = ChatListView.GetValue(i)
						Log(item)
						Log("------------")
						Log(Data.Get("id"))
						Log(item.Get("id"))
						Log(item.Get("id") == Data.Get("id"))
						If item.Get("id") == Data.Get("id") Then
							If i > 0 Then
								ChatListView.RemoveAt(i)
								ChatListView.InsertAt(0,AddChat(Data),Data)
							Else
								ChatListView.ReplaceAt(i,AddChat(Data),80dip,Data)
							End If
							Exit
						End If
					Next
			End Select
		Case "properties"
			Select Data.Get("type")
				Case Store.TYPE_ADDED
					Products.Add(Data)
					TotalProductsLabel.Text = $"${Products.Size} Products"$
			End Select
		Case "users"
			Select Data.Get("type")
				Case Store.TYPE_ADDED
'					Log(Data)
					Users.Add(Data)
					TotalUsersLabel.Text = $"${Users.Size} Users"$
			End Select
		Case "orders"
			Select Data.Get("type")
				Case Store.TYPE_ADDED
					Sales.Add(Data)
					TotalSalesLabel.Text = $"${Sales.Size} Sales"$
			End Select
	End Select
	
	If Data.Get("collection").As(String).Contains("chats") And Data.Get("collection").As(String).Contains("messages") Then
		Dim Document As Map = Data.Get("data")
		Select Data.Get("type")
			Case Store.TYPE_ADDED
				Dim Right As Boolean = False
				If Document.Get("sender_id") == 0 Then
					Right = True
				End If
				Chats.AddItem(Document.Get("message"),Document.Get("sender"), Right)
		End Select
	End If
End Sub

Private Sub AddChat(Data As Map) As B4XView
	Dim Document As Map = Data.Get("data")
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0,0,0,ChatPane.Width,80dip)
	p.LoadLayout("chat_item")
'	Log(Document.Get("product_photo_url"))
	Dim Link,Path As String
	Link = Document.Get("product_photo_url")
	Path = Link.Replace("https://firebasestorage.googleapis.com/v0/b/"&projectID&".appspot.com/o/","")
	Path = Path.Replace("?alt=media","")
	Path = Path.Replace("/","%2F")
'	Log($"https://firebasestorage.googleapis.com/v0/b/${projectID}.appspot.com/o/${Path}?alt=media"$)
	Utils.DownloadMedia3($"https://firebasestorage.googleapis.com/v0/b/${projectID}.appspot.com/o/${Path}?alt=media"$,ChatImagePanel)
	ChatTitleLabel.Text = Document.Get("title") & "-" & Document.Get("customer_name")
	If Document.ContainsKey("last_message") Then
		ChatLastMessageLabel.Text = Document.Get("last_message")
	Else
		ChatLastMessageLabel.Text = ""
	End If
	If CurrentChat == Data.Get("id") Then
		NewMessageLabel.Visible = False
	Else
		NewMessageLabel.Visible = True
	End If
	Return p
End Sub


Private Sub ChatListView_ItemClick (Index As Int, Value As Object)
	Dim Doc As Map = Value
	CurrentChat = Doc.Get("id")
	ChatPane.RemoveAllViews
	Chats.Initialize(ChatPane,Store,Doc.Get("id"),Doc.Get("data"))
	Dim path As PathBuilder
	path.Initialize
	path.Collection("chats").Document(Doc.Get("id")).Collection("messages")
	Dim QueryMap As Map = CreateMap("orderBy":"timestamp","direction":"asc")
	If ChatListener.IsInitialized And ChatListener.Enabled == True Then ChatListener.Remove
	ChatListener = Store.CollectionListen2(path.Complete,QueryMap)
End Sub


#Region IMAGE
Public Sub DownloadMedia(Link As String, iv As B4XView)
	Dim fileName,Key,Path As String
	'Get trim URL for path
	Path = Link.Replace("https://firebasestorage.googleapis.com/v0/b/"&projectID&".appspot.com/o/","")
	Path = Path.Replace("?alt=media","")
	Path = Path.Replace("%2F","/")
'	Log(Path)
	Dim Parts() As String = Regex.Split("/",Path)
	fileName = Parts(Parts.Length-1)
'	Log(fileName)
'	Log(fileName.Replace("-","").Replace(".","").Replace(" ",""))
	Key = fileName.Replace("-","").Replace(".","").Replace(" ","")
	If File.Exists(xui.DefaultFolder,fileName) And imageCache.ContainsKey(Key) Then
'		Log("SMM_MediaReady_Cache")
		iv.SetColorAndBorder(xui.Color_White,0dip,xui.Color_White,10dip)
		Utils.MediaManager2.SetMediaFromFile(iv,xui.DefaultFolder,fileName,"image/*",CreateMap(Utils.MediaManager2.REQUEST_RESIZE_MODE:"FILL"))
	Else
		Dim MIME As String = "png"
		If Link.Contains(".jpg") Or Link.Contains(".jpeg") Then
			MIME = "jpeg"
		End If
		Utils.MediaManager2.SetMediaWithExtra(iv,Link,"image/*",CreateMap(Utils.MediaManager2.REQUEST_RESIZE_MODE:"FILL",Utils.MediaManager2.REQUEST_CALLBACK: Me))
		Wait For (iv) SMM_MediaReady (Success As Boolean, SMMedia As SMMedia)
		If Success Then
			Log("SMM_MediaReady")
			Dim bmp As B4XBitmap = SMMedia.Media
			Dim Out As OutputStream
			Out = File.OpenOutput(xui.DefaultFolder, fileName, False)
			bmp.WriteToStream(Out, 100, MIME.ToUpperCase)
			Out.Close
			imageCache.Put(Key,fileName)
		End If
	End If
End Sub
#End Region

Private Sub ViewDeliveriesButton_Click
	
End Sub

Private Sub ViewProductsButton_Click
	DataTable.clear
	Dim Items As List
	Items.Initialize
	DataTable.AddColumn("Product",DataTable.COLUMN_TYPE_TEXT)
	DataTable.AddColumn("Price",DataTable.COLUMN_TYPE_TEXT)
	DataTable.AddColumn("City",DataTable.COLUMN_TYPE_TEXT)
	DataTable.AddColumn("Region",DataTable.COLUMN_TYPE_TEXT)
	For i = 0 To Products.Size-1
		Dim Data As Map = Products.Get(i)
		Dim Document As Map = Data.Get("data")
		Dim row(4) As Object
		row(0) = Document.get("title")
		row(1) = Document.get("price")
		row(2) = Document.get("city")
		row(3) = Document.get("region")
		Items.Add(row)
	Next
	Wait For (DataTable.SetData(Items)) Complete (Unused As Boolean)
End Sub

Private Sub ViewUsersButton_Click
	DataTable.clear
	Dim Items As List
	Items.Initialize
	DataTable.AddColumn("Name",DataTable.COLUMN_TYPE_TEXT)
	DataTable.AddColumn("Email",DataTable.COLUMN_TYPE_TEXT)
	DataTable.AddColumn("Contact",DataTable.COLUMN_TYPE_TEXT)
	For i = 0 To Users.Size-1
		Dim Data As Map = Users.Get(i)
		Dim Document As Map = Data.Get("data")
'		Log(Document)
		Dim Contact As String = Document.get("phone_number")
		Dim Name As String = Document.get("display_name")
		Dim Email As String = Document.get("email")
		Dim row(3) As Object
		row(0) = Name
		row(1) = Email
		row(2) = Contact
		Items.Add(row)
	Next
	Wait For (DataTable.SetData(Items)) Complete (Unused As Boolean)
End Sub

Private Sub ViewSalesButton_Click
	
End Sub