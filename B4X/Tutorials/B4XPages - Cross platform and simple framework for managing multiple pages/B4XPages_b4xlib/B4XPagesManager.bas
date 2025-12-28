B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#Event: Appear
#Event: Disappear
#Event: Foreground
#Event: Background
#if B4J or B4A
#Event: CloseRequest As ResumableSub
#End If
#if B4J or B4i
#Event: Resize (Width As Int, Height As Int)
#End If
#Event: Created (Root1 As B4XView)
#if B4i
#Event: KeyboardStateChanged (Height As Float)
#Event: MenuClick (Tag As String)
#Else If B4J
#Event: IconifiedChanged (Iconified As Boolean)
#Else If B4A
#Event: PermissionResult (Permission As String, Result As Boolean)
#Event: MenuClick (Tag As String)
#End If

Sub Class_Globals
	Private IdToB4XPage As B4XOrderedMap
	Private RootB4XToPage As B4XOrderedMap
	#if B4A
	Private Context As JavaObject
	Type B4XPageParent (NativeType As Activity, MenuItems As List)
	Type B4AMenuItem (Title As Object, Bitmap As B4XBitmap, Tag As String, AddToBar As Boolean, NativeMenuItem As JavaObject)
	#else if B4J
	Type B4XPageParent (NativeType As Form)
	#else if B4i
	Type B4XPageParent (NativeType As Page)
	#end if
	Type B4XPageInfo (B4XPage As Object, Id As String, Created As Boolean, _
		Title As Object, Root As B4XView, IsFirst As Boolean, _
		Parent As B4XPageParent _
	)
	Public mStackOfPageIds As B4XSet
	Private xui As XUI 'ignore
	#if B4J
	Private mMainForm As Form
	#else if B4A
	Private mMainForm As Activity
	Public ShowUpIndicator As Boolean = True
	Public ActionBar As JavaObject
	#else if B4i
	Private mMainForm As NavigationController
	#End If
	Public IsForeground As Boolean
	Public TransitionAnimationDuration As Int = 100
	Public MainPage As B4XMainPage
	Private StackString As String
	Public LogEvents As Boolean = False
End Sub

#if B4J
Public Sub Initialize (MainForm As Form)
#else if B4A
Public Sub Initialize (Activity As Activity)
#else if B4i
Public Sub Initialize (NavControl As NavigationController)
#end if
	IdToB4XPage.Initialize
	RootB4XToPage.Initialize
	mStackOfPageIds.Initialize
	#if B4J
	mMainForm = MainForm
	#Else If B4A
	Context.InitializeContext
	mMainForm = Activity
	CheckMainActivityOrientations
	Dim jo As JavaObject = Me
	Dim module As JavaObject
	module.InitializeStatic(jo.RunMethodJO("getActivityBA", Null).GetField("className")).SetField("dontPause", True)
	#Else If B4i
	mMainForm = NavControl
	#End If
	B4XPages.InternalSetPagesManager(Me)
	MainPage.Initialize
	Dim NonMainPageWasAdded As Boolean = IdToB4XPage.Size > 0
	IdToB4XPage.Put("~~~~~temp~~~~", CreateB4XPageInfo(MainPage, "", False, ""))
	BackgroundStateChanged(True)
	IdToB4XPage.Remove("~~~~~temp~~~~")
	AddPageAndCreate("MainPage", MainPage)
	If LogEvents = False Then
		Log("Call B4XPages.GetManager.LogEvents = True to enable logging B4XPages events.")
	End If
	If NonMainPageWasAdded Then
		If Not(xui.IsB4i) Then
			RaiseEvent(GetTopPage, "B4XPage_Appear", Null)
		End If
	End If
End Sub

#if B4A
Private Sub CheckMainActivityOrientations
	
	Dim jo As JavaObject
	jo.InitializeContext
	
	ActionBar = jo.RunMethod("getActionBar", Null)
	If ActionBar.IsInitialized = False Then
		Dim jme As JavaObject = Me
		Dim IsAppCompat As Boolean = jme.RunMethod("checkIfAppCompat", Array(jo))
		If IsAppCompat Then
			ActionBar = jo.RunMethod("getSupportActionBar", Null)
		End If
		
	End If
	Dim pi As JavaObject = jo.RunMethodJO("getPackageManager", Null).RunMethod("getPackageInfo", Array(Application.PackageName, 1))
	Dim activities() As Object = pi.GetField("activities")
	For Each Act As JavaObject In activities
		Dim name As String = Act.GetField("name")
		If name.EndsWith(".main") Then
			Dim screenOrientation As Int = Act.GetField("screenOrientation")
			If screenOrientation = -1 Then
				LogColor("#SupportedOrientations attribute must be set to landscape or portrait.", xui.Color_Red)
			End If
		End If
	Next
End Sub

#if Java
public boolean checkIfAppCompat(android.app.Activity act) {
	return act.getClass().getSuperclass().getName().equals("androidx.appcompat.app.AppCompatActivity");
}
#End If

Public Sub Activity_ActionBarHomeClick
	Dim pi As B4XPageInfo = GetTopPage
	If pi <> Null Then
		If CloseRequestExists (pi) Then
			HandleCloseRequest(pi)
		Else
			ClosePage(pi.B4XPage)
		End If
	End If
End Sub
#End If

Public Sub AddPage (Id As String, B4XPage As Object)
	Dim IdToLower As String = Id.ToLowerCase
	If IdToB4XPage.ContainsKey(IdToLower) Then
		Log($"Page with this id already exists: ${IdToLower}!"$)
		Return
	End If
	IdToB4XPage.Put(IdToLower, CreateB4XPageInfo(B4XPage, IdToLower, False, Id))
	If IdToB4XPage.Size = 1 Then ShowPage(IdToLower)
End Sub

Public Sub AddPageAndCreate (Id As String, B4XPage As Object)
	AddPage (Id, B4XPage)
	CreatePageIfNeeded(GetPageFromId(Id))
End Sub

Public Sub ShowPage (Id As String)
	Dim pi As B4XPageInfo = GetPageFromId(Id)
	If pi = GetTopPage Then Return
	CreatePageIfNeeded(pi)
	TopPageDisappear
	#if B4A
	Dim Top As B4XPageInfo = GetTopPage
	If Top <> Null Then
		Top.Root.RemoveViewFromParent
	End If
	#Else If B4i
	If mStackOfPageIds.Contains(pi.Id) Then
		Dim index As Int = mStackOfPageIds.AsList.IndexOf(pi.Id)
		For i = mStackOfPageIds.Size - 1 To index + 1 Step - 1
			mStackOfPageIds.Remove(mStackOfPageIds.AsList.Get(i))
		Next
	End If
	#End If
	mStackOfPageIds.Remove(pi.Id)
	ShowPageImpl(pi)
	mStackOfPageIds.Add(pi.Id)
	TopPageAppear
End Sub

Public Sub ShowPageAndRemovePreviousPages (Id As String)
	If GetTopPage = Null Then
		ShowPage(Id)
		Return
	End If
	Dim pi As B4XPageInfo = GetPageFromId(Id)
	CreatePageIfNeeded(pi)
	TopPageDisappear
	#if B4i
	mMainForm.SetPagesStack(Array(pi.Parent.NativeType))
	#else
	For Each Id As String In mStackOfPageIds.AsList
		Dim PageToRemove As B4XPageInfo = GetPageFromId(Id)
		#if B4A
		PageToRemove.Root.RemoveViewFromParent
		#Else If B4J
		If PageToRemove.Id = pi.Id Then Continue
		PageToRemove.Parent.NativeType.Close
		#End If
	Next
	#End If
	mStackOfPageIds.Clear
	mStackOfPageIds.Add(pi.Id)
	If xui.IsB4A Or xui.IsB4J Then
		ShowPageImpl(pi)
	End If
	TopPageAppear
End Sub

Public Sub ClosePage (B4XPage As Object)
	Dim pi As B4XPageInfo = FindPIFromB4XPage(B4XPage)
	If mStackOfPageIds.Contains(pi.Id) = False Then Return
	If xui.IsB4i And GetTopPage <> pi Then
		Log("Only top page can be closed")
		Return
	Else If xui.IsB4i And mStackOfPageIds.Size = 1 Then
		Log("First page cannot be closed")
		Return
	End If
	Dim IsClosingTopPage As Boolean = GetTopPage = pi
	ClosePageImpl(pi)
	If IsClosingTopPage Then
		TopPageDisappear
	End If
	If xui.IsB4A And mStackOfPageIds.Size = 1 Then Return 'went to home
	mStackOfPageIds.Remove(pi.Id)
	If IsClosingTopPage Then
		If xui.IsB4A Then ShowPageImpl(GetTopPage)
		TopPageAppear
	End If
End Sub


#if B4i
Private Sub B4iPage_Appear
	Dim page As Page = Sender
	Dim pi As B4XPageInfo = RootB4XToPage.Get(page.RootPanel)
	mStackOfPageIds.Add(pi.Id)
	UpdateStackString
	RaiseEvent(pi, "B4XPage_Appear", Null)
End Sub

Private Sub B4iPage_Disappear
	Dim page As Page = Sender
	Dim pi As B4XPageInfo = RootB4XToPage.Get(page.RootPanel)
	RaiseEvent(pi, "B4XPage_Disappear", Null)
	If GetTopPage = pi Then
		mStackOfPageIds.Remove(pi.Id)
	End If
	UpdateStackString
End Sub

Private Sub B4iPage_Resize (Width As Float, Height As Float)
	RaiseEvent(GetPageInfoFromRoot(Sender), "B4XPage_Resize", Array(Width, Height))
End Sub

Private Sub B4iPage_KeyboardStateChanged (Height As Float)
	Dim page As Page
	If (Sender Is Page) = False Then
		Dim pi As B4XPageInfo = GetTopPage
		If pi <> Null Then
			page = pi.Parent.NativeType
		End If
	Else
		page = Sender
	End If
	If page.IsInitialized Then
		RaiseEvent(GetPageInfoFromRoot(page.RootPanel), "B4XPage_KeyboardStateChanged", Array(Height))
	End If
End Sub

Private Sub B4iPage_BarButtonClick (Tag As String)
	Dim page As Page = Sender
	RaiseEvent(GetPageInfoFromRoot(page.RootPanel), "B4XPage_MenuClick", Array(Tag))
End Sub
#End If

Private Sub TopPageDisappear
	If xui.IsB4J Then Return
	Dim pi As B4XPageInfo = GetTopPage
	If pi = Null Then Return
	If Not(xui.IsB4i) Then
		If IsForeground Then
			RaiseEventWithResult(pi, "B4XPage_Disappear", Null)
		End If
	End If
End Sub

Private Sub TopPageAppear
	Dim pi As B4XPageInfo = GetTopPage
	If pi = Null Then Return
	pi.Parent.NativeType.Title = pi.Title
	If Not(xui.IsB4i) Then
		If IsForeground Then
			RaiseEvent(pi, "B4XPage_Appear", Null)
		End If
	End If
	#if B4A
	If ShowUpIndicator And ActionBar.IsInitialized Then
		ActionBar.RunMethod("setDisplayHomeAsUpEnabled", Array(mStackOfPageIds.Size > 1))
	End If
	UpdateMenuItems
	#End If
	UpdateStackString
End Sub

Public Sub FindPIFromB4XPage (Page As Object) As B4XPageInfo
	For Each pi As B4XPageInfo In IdToB4XPage.Values
		If pi.B4XPage = Page Then
			Return pi
		End If
	Next
	Return Null
End Sub

Private Sub ClosePageImpl (pi As B4XPageInfo) 'ignore
	#if B4A
	If mStackOfPageIds.Size = 1 Then
		Dim i As Intent
		i.Initialize(i.ACTION_MAIN, "")
		i.AddCategory("android.intent.category.HOME")
		i.Flags = 0x10000000
		StartActivity(i)
	Else
		pi.Root.RemoveViewFromParent
	End If
	#Else If B4J
	pi.Parent.NativeType.Close
	#Else If B4i
	mMainForm.RemoveCurrentPage2(TransitionAnimationDuration > 0)
	#End If
End Sub

Private Sub ShowPageImpl (pi As B4XPageInfo)
	#if B4j
	pi.Parent.NativeType.Show
	Dim jo As JavaObject = pi.Parent.NativeType
	jo.GetFieldJO("stage").RunMethod("requestFocus", Null)
	#else if B4A
	If pi.Root.Parent.IsInitialized Then pi.Root.RemoveViewFromParent
	Dim pnl As Panel = pi.Root
	If TransitionAnimationDuration > 0 Then
		mMainForm.AddView(pnl, 0, 0, 20dip, 20dip)
		pnl.SetLayoutAnimated(TransitionAnimationDuration, 0, 0, 100%x, 100%y)
	Else
		mMainForm.AddView(pnl, 0, 0, 100%x, 100%y)
	End If
	#Else If B4i
	mMainForm.ShowPage2(pi.Parent.NativeType, TransitionAnimationDuration > 0)
	#End If
End Sub

Private Sub CreatePageIfNeeded(pi As B4XPageInfo)
	If pi.Created Then Return
	pi.IsFirst = IdToB4XPage.Size = 1
	CreatePageImpl (pi)
	pi.Created = True
	RootB4XToPage.Put(pi.Root, pi)
	LogEvent(pi, "B4XPage_Created")
	CallSub2(pi.B4XPage, "B4XPage_Created", pi.root)
	
End Sub

Public Sub SetTitle (B4XPage As Object, Title As Object)
	Dim pi As B4XPageInfo = FindPIFromB4XPage(B4XPage)
	pi.Title = Title
	pi.Parent.NativeType.Title = Title
End Sub

Private Sub CreatePageImpl (pi As B4XPageInfo)
#if B4J
	If pi.IsFirst Then
		pi.Parent = CreateB4XPageParent(mMainForm)
	Else
		Dim f As Form
		f.Initialize("MainForm", mMainForm.RootPane.Width, mMainForm.RootPane.Height)
		pi.Parent = CreateB4XPageParent(f)
	End If
	pi.Root = pi.Parent.NativeType.RootPane
	pi.Parent.NativeType.Title = pi.Title
#Else If B4A
	pi.Root = xui.CreatePanel("root")
	pi.root.SetLayoutAnimated(0, 0, 0, 100%x, 100%y) 
	pi.Parent = CreateB4XPageParent(mMainForm)
	pi.Parent.MenuItems.Initialize
#Else If B4i
	Dim page As Page
	page.Initialize("B4iPage")
	pi.Parent = CreateB4XPageParent(page)
	pi.Root = pi.Parent.NativeType.RootPanel
	pi.Parent.NativeType.Title = pi.Title
#End If
End Sub

Public Sub GetPage (Id As String) As Object
	Return GetPageFromId(Id).B4XPage
End Sub

Private Sub GetPageFromId (id As String) As B4XPageInfo
	Dim pi As B4XPageInfo = IdToB4XPage.Get(id.ToLowerCase)
	If pi = Null Then
		Log("Error: page id not found: " & id)
		Log("Ids: " & IdToB4XPage.Keys) 'ignore
	End If
	Return pi
End Sub

Public Sub GetPageInfoFromRoot (Root As B4XView) As B4XPageInfo
	Return RootB4XToPage.Get(Root)
End Sub


#if B4J
Private Sub MovePageToTop (pi As B4XPageInfo)
	mStackOfPageIds.Remove(pi.Id)
	mStackOfPageIds.Add(pi.Id)
	UpdateStackString
End Sub
#end if

Private Sub CreateB4XPageInfo (B4XPage As Object, Id As String, Created As Boolean, Title As Object) As B4XPageInfo
	Dim t1 As B4XPageInfo
	t1.Initialize
	t1.B4XPage = B4XPage
	t1.Id = Id
	t1.Created = Created
	t1.Title = Title
	Return t1
End Sub

#if B4J
Public Sub MainForm_FocusChanged (HasFocus As Boolean)
	Dim frm As Form = Sender
	Dim pi As B4XPageInfo = GetPageInfoFromRoot(frm.RootPane)
	If pi = Null Then Return
	If HasFocus Then
		MovePageToTop(pi)
	End If
End Sub

Public Sub MainForm_Closed
	Dim frm As Form = Sender
	Dim pi As B4XPageInfo = GetPageInfoFromRoot(frm.RootPane)
	RaiseEventWithResult(pi, "B4XPage_Disappear", Null)
	mStackOfPageIds.Remove(pi.Id)
	If mStackOfPageIds.Size = 0 Then
		BackgroundStateChanged(False)
	End If
	UpdateStackString
End Sub

Public Sub MainForm_IconifiedChanged (Iconified As Boolean)
	Dim frm As Form = Sender
	Dim pi As B4XPageInfo = GetPageInfoFromRoot(frm.RootPane)
	RaiseEvent(pi, "B4XPage_IconifiedChanged", Array(Iconified))
End Sub

Public Sub MainForm_CloseRequest (EventData As Event)
	Dim frm As Form = Sender
	Dim pi As B4XPageInfo = GetPageInfoFromRoot(frm.RootPane)
	If pi <> Null And CloseRequestExists (pi) Then
		EventData.Consume
		HandleCloseRequest (pi)
	End If
End Sub
#end if

#if B4A
Public Sub Activity_KeyPress (KeyCode As Int) As Boolean
	If KeyCode = KeyCodes.KEYCODE_BACK Then
		Dim pi As B4XPageInfo = GetTopPage
		If CloseRequestExists(pi) Then
			HandleCloseRequest(pi)
		Else
			ClosePage(pi.B4XPage)
		End If
		Return True
	End If
	Return False
End Sub

Public Sub AddMenuItem (B4XPage As Object, Title As Object) As B4AMenuItem
	Dim mi As B4AMenuItem
	mi.Initialize
	mi.Title = Title
	mi.Tag = Title
	FindPIFromB4XPage(B4XPage).Parent.MenuItems.Add(mi)
	Return mi
End Sub

Private Sub UpdateMenuItems
	Context.RunMethod("invalidateOptionsMenu", Null)
End Sub

Public Sub CreateMenu (Menu As Object)
	Dim pi As B4XPageInfo = GetTopPage
	If pi = Null Then Return
	Dim jo As JavaObject = Menu
	For Each mi As B4AMenuItem In pi.Parent.MenuItems
		Dim NativeMenuItem As JavaObject = jo.RunMethod("add", Array(mi.Title))
		If mi.Bitmap.IsInitialized Then
			Dim bd As BitmapDrawable
			bd.Initialize(mi.Bitmap)
			NativeMenuItem.RunMethod("setIcon", Array(bd))
		End If
		If mi.AddToBar Then
			NativeMenuItem.RunMethod("setShowAsAction", Array(1)) 'SHOW_AS_ACTION_IF_ROOM
		End If
		Dim listener As JavaObject
		listener.InitializeNewInstance(Application.PackageName & ".b4xpagesmanager$PagesMenuListener", Array(pi.B4XPage, mi.Tag))
		NativeMenuItem.RunMethod("setOnMenuItemClickListener", Array(listener))
	Next
End Sub

#if Java
public static class PagesMenuListener implements android.view.MenuItem.OnMenuItemClickListener {
	private B4AClass target;
	private String tag;
	public PagesMenuListener(B4AClass target, String tag) {
		this.target = target;
		this.tag = tag;
	}
 	public boolean onMenuItemClick(android.view.MenuItem item) {
		target.getBA().raiseEventFromUI(null, "b4xpage_menuclick", tag);
		return true;
	}
}
#End If
#end if



#if B4J or B4A

Private Sub CloseRequestExists (pi As B4XPageInfo) As Boolean
	Return xui.SubExists(pi.B4XPage, "B4XPage_CloseRequest", 0)
End Sub

Private Sub HandleCloseRequest (pi As B4XPageInfo)
	LogEvent(pi, "B4XPage_CloseRequest")
	Dim rs As ResumableSub = CallSub(pi.B4XPage, "B4XPage_CloseRequest")
	Wait For (rs) Complete (ShouldClose As Boolean)
	If ShouldClose Then
		ClosePage(pi.B4XPage)
	End If
End Sub
#end if

Public Sub RaiseEvent (TargetPage As B4XPageInfo, SubName As String, Params() As Object)
	If TargetPage = Null Then Return
	Dim length As Int
	If Params = Null Then length = 0 Else length = Params.Length
	LogEvent(TargetPage, SubName)
	If xui.SubExists(TargetPage.B4XPage, SubName, length) = False Then Return
	Select length
		Case 0
			CallSubDelayed(TargetPage.B4XPage, SubName)
		Case 1
			CallSubDelayed2(TargetPage.B4XPage, SubName, Params(0))
		Case 2
			CallSubDelayed3(TargetPage.B4XPage, SubName, Params(0), Params(1))
		Case Else
			Log("Too many parameters")
	End Select
End Sub

Public Sub RaiseEventWithResult (TargetPage As B4XPageInfo, SubName As String, Params() As Object) As Object
	If TargetPage = Null Then Return Null
	Dim length As Int
	If Params = Null Then length = 0 Else length = Params.Length
	LogEvent(TargetPage, SubName)
	If xui.SubExists(TargetPage.B4XPage, SubName, length) = False Then Return Null
	Select length
		Case 0
			Return CallSub(TargetPage.B4XPage, SubName)
		Case 1
			Return CallSub2(TargetPage.B4XPage, SubName, Params(0))
		Case 2
			Return CallSub3(TargetPage.B4XPage, SubName, Params(0), Params(1))
		Case Else
			Log("Too many parameters")
	End Select
	Return Null
End Sub

Public Sub MainForm_Resize(Width As Double, Height As Double)
	Dim w As Int = Width
	Dim h As Int = Height
	RaiseEvent(GetPageInfoFromRoot(Sender), "B4XPage_Resize", Array(w, h))
End Sub

'Returns the page info of the top page.
Public Sub GetTopPage As B4XPageInfo
	If mStackOfPageIds.Size = 0 Then Return Null
	Return IdToB4XPage.Get(mStackOfPageIds.AsList.Get(mStackOfPageIds.Size - 1))
End Sub

#if B4A
Private Sub CreateB4XPageParent (NativeType As Object) As B4XPageParent
#Else If B4J
Private Sub CreateB4XPageParent (NativeType As Form) As B4XPageParent
#else if B4i
Private Sub CreateB4XPageParent (NativeType As Page) As B4XPageParent
#end if
	Dim t1 As B4XPageParent
	t1.Initialize
	t1.NativeType = NativeType
	Return t1
End Sub

Public Sub Activity_Resume
	Dim ShouldRaise As Boolean = IsForeground = False
	BackgroundStateChanged(True)
	If ShouldRaise Then
		RaiseEvent(GetTopPage, "B4XPage_Appear", Null)
	End If
End Sub

Private Sub BackgroundStateChanged (NewState As Boolean)
	If IsForeground = NewState Then Return
	IsForeground = NewState
	Dim ev As String
	If IsForeground Then ev = "B4XPage_Foreground" Else ev = "B4XPage_Background"
	For Each pi As B4XPageInfo In IdToB4XPage.Values
		If xui.SubExists(pi.B4XPage, ev, 0) Then
			LogEvent(pi, ev)
			If IsForeground Then
				CallSubDelayed(pi.B4XPage, ev)
			Else
				CallSub(pi.B4XPage, ev)
			End If
		End If
	Next
End Sub

Public Sub Activity_Pause
	RaiseEventWithResult(GetTopPage, "B4XPage_Disappear", Null)
	BackgroundStateChanged(False)
End Sub

Private Sub LogEvent (pi As B4XPageInfo, ev As String)
	If LogEvents Then
		Dim msg As String = $"*** ${pi.Id}: ${ev} ${StackString}"$
		Log(msg)
	End If
End Sub

Public Sub UpdateStackString
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("[")
	If mStackOfPageIds.Size > 0 Then
		For Each id As String In mStackOfPageIds.AsList
			sb.Append(id).Append(", ")
		Next
		sb.Remove(sb.Length - 2, sb.Length)
	End If
	sb.Append("]")
	StackString = sb.ToString
End Sub

