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
	Private AS_FeatureRequest1 As AS_FeatureRequest
	Private xSupabase As Supabase
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS_FeatureRequest Example")
	
	xSupabase.Initialize("https://xxx.supabase.co","xxx")
	xSupabase.InitializeEvents(Me,"Supabase")
	
	'creates a new anon user if it has not yet been created for the current device
	Wait For (xSupabase.Auth.isUserLoggedIn) Complete (isLoggedIn As Boolean)
	
	If isLoggedIn = False Then
		
		Wait For (xSupabase.Auth.LogIn_Anonymously) Complete (AnonymousUser As SupabaseUser)
		If AnonymousUser.Error.Success Then
			Log("Successfully created an anonymous user")
		Else
			Log("Error: " & AnonymousUser.Error.ErrorMessage)
		End If
	
	End If
	
	LoadOpenRequests
	
End Sub

Private Sub LoadOpenRequests
	
	Dim CallFunction As Supabase_DatabaseRpc = xSupabase.Database.CallFunction
	CallFunction.Parameters(CreateMap("appid":1)) 'Change this to the app id in the dt_FeatureRequestApp
	CallFunction.Rpc("GetFeatureRequests".ToLowerCase)
	Wait For (CallFunction.Execute) Complete (RpcResult As SupabaseRpcResult)
	
	AS_FeatureRequest1.Clear 'Clears the list
	
	If RpcResult.Error.Success Then
		'Log(RpcResult.Data)
		
		Dim parser As JSONParser
		parser.Initialize(RpcResult.Data)
		Dim jRoot As List = parser.NextArray
		For Each Row As Map In jRoot
			
			Dim StatusText As String = ""
			Select Row.Get("status")
				Case 0
					StatusText = "Submitted"
				Case 1
					StatusText = "Planned"
				Case 2
					StatusText = "In Development"
				Case 3
					StatusText = "Testing"
				Case 4
					StatusText = "Done"
			End Select
			
			Dim lstChips As List : lstChips.Initialize
			lstChips.Add(AS_FeatureRequest1.CreateItemChip(StatusText,xui.Color_ARGB(255,45, 136, 121),xui.Color_White))
			If Row.Get("ispremiumfeature") Then lstChips.Add(AS_FeatureRequest1.CreateItemChip("Premium",xui.Color_ARGB(255,141, 68, 173),xui.Color_White))
			
			AS_FeatureRequest1.AddItem(Row.Get("title"),Row.Get("description"),lstChips,AS_FeatureRequest1.UserVoteStatus2Text(Row.Get("uservotestatus")),Row.Get("votecount"),Row.Get("id"))
				
		Next
		
	End If
	
End Sub

Private Sub AS_FeatureRequest1_Voted(isUpvote As Boolean,Value As Object)
	Dim Insert As Supabase_DatabaseInsert = xSupabase.Database.InsertData
	Insert.From("dt_FeatureRequestUserUpvotes")
	Dim InsertMap As Map = CreateMap("FeatureRequestId":Value,"isUpvote":isUpvote,"AppId":1)'Change this to the app id in the dt_FeatureRequestApp
	Wait For (Insert.Insert(InsertMap).Execute) Complete (Result As SupabaseDatabaseResult)
	Log(Result.Error.ErrorMessage)
End Sub