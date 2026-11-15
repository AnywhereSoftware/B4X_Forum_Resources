B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@

#If Documentation
Updates
V1.00
	-Release
#End If

#DesignerProperty: Key: Position,DisplayName: Position,FieldType: String,DefaultValue: bottom,List: top|bottom
#DesignerProperty: Key: Duration,DisplayName: Duration (ms),FieldType: Int,DefaultValue: 4000
#DesignerProperty: Key: Gap,DisplayName: Gap,FieldType: Int,DefaultValue: 14
#DesignerProperty: Key: VisibleToasts,DisplayName: Visible Toasts,FieldType: Int,DefaultValue: 3
#DesignerProperty: Key: Expand,DisplayName: Expand,FieldType: Boolean,DefaultValue: False
#DesignerProperty: Key: Offset,DisplayName: Offset,FieldType: Int,DefaultValue: 16
#DesignerProperty: Key: CloseButton,DisplayName: Close Button,FieldType: Boolean,DefaultValue: False
#DesignerProperty: Key: SwipeToDismiss,DisplayName: Swipe To Dismiss,FieldType: Boolean,DefaultValue: True

#Event: Dismiss (Toast As Map)
#Event: AutoClose (Toast As Map)
#Event: Action (Id As Object)
#Event: Cancel (Id As Object)

Sub Class_Globals
	Private mEventName As String
	Private mCallBack As Object
	Public mBase As B4XView
	Private xui As XUI
	Public Tag As Object


	'Views, collections and the shared frame timer.
	Private xpnl_Parent As B4XView
	Private lst_Toasts As List
	Private lst_History As List
	Private tmr_Main As Timer

	Private m_IdCounter As Long
	Private m_LastFrameTime As Long
	Private m_Expanded As Boolean
	Private m_Interacting As Boolean

	'Global appearance and type icons.
	Private m_Properties As Map
	Private m_Icons As Map
	Private m_ToastStyle As Map
	Private m_TitleStyle As Map
	Private m_DescriptionStyle As Map
	Private m_RegionStyle As Map

	'Viewport and component lifecycle.
	Private m_SafeAreaTop As Float
	Private m_SafeAreaBottom As Float
	Private m_Disposed As Boolean
	Private m_Paused As Boolean
End Sub

#Region Initialization

Public Sub Initialize(Callback As Object,EventName As String)

	mCallBack = Callback
	mEventName = EventName

	'Active toasts and history are managed separately.
	lst_Toasts.Initialize
	lst_History.Initialize
	m_Icons.Initialize
	m_ToastStyle.Initialize
	m_TitleStyle.Initialize
	m_DescriptionStyle.Initialize
	m_RegionStyle.Initialize

	'Defaults for appearance, stacking and automatic dismissal.
	m_Properties = CreateMap( _
		"position": "bottom", _
		"duration": 4000, _
		"gap": 14dip, _
		"visibleToasts": 3, _
		"expand": False, _
		"offset": 16dip, _
		"closeButton": False, _
		"swipeToDismiss": True)
	tmr_Main.Initialize("tmr_Main",16)

End Sub

'Attach once to a page/root. The empty viewport does not intercept input.
Public Sub CreateViewPerCode(Parent As B4XView,Left As Float,Top As Float,Width As Float,Height As Float)

	xpnl_Parent = Parent
	mBase = xui.CreatePanel("")
	Parent.AddView(mBase,Left,Top,Max(1dip,Width),Max(1dip,Height))
	mBase.Tag = Me

	'mBase is only an anchor. Toasts are siblings so empty areas remain interactive.
	mBase.Visible = False

End Sub

'Base type must be Object
Public Sub DesignerCreateView(Base As Object,Lbl As Label,Props As Map)

	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	xpnl_Parent = mBase.Parent
	mBase.Visible = False
	IniProps(Props)

End Sub

Private Sub IniProps(Props As Map)

	Dim Properties As Map = CopyMap(Props)

	'Convert designer distances to the current display density here.
	For Each Key As String In Array As String("Gap","Offset")
		If Properties.ContainsKey(Key) Then Properties.Put(Key,DipToCurrent(Properties.Get(Key)))
	Next

	Configure(Properties)

End Sub

#End Region

#Region Functions

'Provider options: position, duration, gap, visibleToasts, expand, offset, closeButton, swipeToDismiss.
Public Sub Configure(Options As Map)

	If Options.IsInitialized = False Then Return

	'Match option names without regard to case.
	For Each Key As String In Options.Keys
		For Each PropertyName As String In m_Properties.Keys
			If PropertyName.ToLowerCase = Key.ToLowerCase Then
				m_Properties.Put(PropertyName,Options.Get(Key))
				Exit
			End If
		Next
	Next

	'Normalize invalid positions and clamp negative distances.
	If m_Properties.Get("position") <> "top" Then m_Properties.Put("position","bottom")
	m_Properties.Put("visibleToasts",Max(1,m_Properties.Get("visibleToasts")))
	m_Properties.Put("gap",Max(0,m_Properties.Get("gap")))
	m_Properties.Put("offset",Max(0,m_Properties.Get("offset")))
	Rebuild

End Sub

'Options: id, description, icon, duration (-1 = infinite), dismissible, position,
'action/cancel ({label, Callback, EventName}), onDismiss/onAutoClose ({Callback, EventName}).
'Content: String, native view/B4XView, or {Callback, EventName} factory returning content.
Public Sub Show(Title As Object,Options As Map) As Object
	Return CreateToast(Title,"default",Options)
End Sub

Public Sub Message(Title As Object,Options As Map) As Object
	Return Show(Title,Options)
End Sub

Public Sub Success(Title As Object,Options As Map) As Object
	Return CreateToast(Title,"success",Options)
End Sub

Public Sub Error(Title As Object,Options As Map) As Object
	Return CreateToast(Title,"error",Options)
End Sub

Public Sub Info(Title As Object,Options As Map) As Object
	Return CreateToast(Title,"info",Options)
End Sub

Public Sub Warning(Title As Object,Options As Map) As Object
	Return CreateToast(Title,"warning",Options)
End Sub

Public Sub Loading(Title As Object,Options As Map) As Object
	Return CreateToast(Title,"loading",Options)
End Sub

'Body: native view/B4XView or factory Sub EventName(Id As Object, Body As B4XView).
'The factory sets Body.Height if a different height is needed.
'Use callback Sub names with an underscore, e.g. Toast_CustomBody, for Release builds.
Public Sub Custom(Body As Object,Options As Map) As Object
	Dim ToastData As Map = CopyMap(Options)
	ToastData.Put("custom",Body)
	Return CreateToast(Null,"default",ToastData)
End Sub

'Existing IDs merge options and retain stack order. Reusing a dismissed ID shows it again.
Public Sub CreateToast(Title As Object,ToastType As String,Options As Map) As Object

	If m_Disposed Then Return Null

	If mBase.IsInitialized = False Then
		Log("AS_DynamicToast: attach to a parent before showing a toast.")
		Return Null
	End If

	'Copy the options so the caller's Map remains unchanged.
	Dim ToastData As Map = CopyMap(Options)
	Dim Id As Object = ToastData.GetDefault("id",Null)

	'Generate an unused numeric ID when none is supplied.
	If Id = Null Or (Id Is String And Id = "") Then
		Do While True
			m_IdCounter = m_IdCounter + 1
			Id = m_IdCounter

			If HistoryIndex(Id) = -1 Then Exit
		Loop
	End If

	'For an existing ID, merge new options while retaining the previous ones.
	Dim HistoryIndexValue As Int = HistoryIndex(Id)
	Dim NewToastData As Map
	NewToastData.Initialize

	If HistoryIndexValue > -1 Then NewToastData = CopyMap(lst_History.Get(HistoryIndexValue))

	For Each Key As String In ToastData.Keys
		NewToastData.Put(Key,ToastData.Get(Key))
	Next

	NewToastData.Put("id",Id)
	NewToastData.Put("title",Title)
	NewToastData.Put("type",ToastType)
	NewToastData.Put("dismissible",ToastData.GetDefault("dismissible",True))
	NewToastData.Put("delete",False)

	'Update the history record without adding a duplicate entry.
	If HistoryIndexValue > -1 Then
		lst_History.Set(HistoryIndexValue,CopyMap(NewToastData))
	Else
		lst_History.Add(CopyMap(NewToastData))
	End If

	'Update the existing card or insert a new card at the front of the stack.
	Dim ToastItem As AS_DynamicToastItem = FindItem(Id)

	If ToastItem.IsInitialized Then
		ToastItem.Update(NewToastData)
	Else
		ToastItem.Initialize(Me,xpnl_Parent,NewToastData)
		lst_Toasts.InsertAt(0,ToastItem)
	End If

	Refresh
	StartFrames
	Return Id

End Sub

Public Sub Dismiss(Id As Object)
	Dim ToastItem As AS_DynamicToastItem = FindItem(Id)

	If ToastItem.IsInitialized Then ToastItem.Close(False,0,0)
End Sub

Public Sub DismissAll
	For Each ToastItem As AS_DynamicToastItem In ItemsSnapshot
		ToastItem.Close(False,0,0)
	Next
End Sub

'Active/pending toasts, newest first. Returned maps are defensive copies.
Public Sub GetActive As List

	Dim Result As List
	Result.Initialize

	For Each ToastItem As AS_DynamicToastItem In lst_Toasts
		If ToastItem.Closing = False Then Result.Add(CopyMap(ToastItem.Data))
	Next

	Return Result

End Sub

Public Sub GetHistory As List

	Dim Result As List
	Result.Initialize

	For Each ToastData As Map In lst_History
		Result.Add(CopyMap(ToastData))
	Next

	Return Result

End Sub

Public Sub ClearHistory
	lst_History.Clear
End Sub

'B4X equivalent of the source emitter Promise helper. Work returns
'Map("success": Boolean, "data": Object). Renderer callbacks receive data.
Public Sub Promise(Work As ResumableSub,Options As Map) As ResumableSub

	Dim PromiseOptions As Map = CopyMap(Options)
	Dim Id As Object = PromiseOptions.GetDefault("id",Null)

	If PromiseOptions.ContainsKey("loading") Then
		Dim LoadingOptions As Map = CopyMap(PromiseOptions)

		If LoadingOptions.Get("description") Is Map Then LoadingOptions.Remove("description")
		Id = Loading(PromiseOptions.Get("loading"),LoadingOptions)
	End If


	'Keep the loading card visible until the work completes.
	Wait For (Work) Complete (Result As Object)

	Dim SuccessResult As Boolean = True
	Dim Value As Object = Result


	'B4X returns success and data in a Map instead of using Promise rejection.
	If Result Is Map Then
		Dim WorkResult As Map = Result
		SuccessResult = WorkResult.GetDefault("success",True)
		Value = WorkResult.GetDefault("data",Result)
	End If

	Dim ResultType As String = "error"

	If SuccessResult Then ResultType = "success"

	If m_Disposed = False Then

		If PromiseOptions.ContainsKey(ResultType) Then

			If Id <> Null Then PromiseOptions.Put("id",Id)
			Dim Title As Object = ResolveWithData(PromiseOptions.Get(ResultType),Value)

			If PromiseOptions.ContainsKey("description") Then PromiseOptions.Put("description",ResolveWithData(PromiseOptions.Get("description"),Value))
			Id = CreateToast(Title,ResultType,PromiseOptions)

		Else If Id <> Null Then
			Dismiss(Id)
		End If

	End If

	If PromiseOptions.ContainsKey("finally") Then Invoke(PromiseOptions.Get("finally"),Null)
	Return Id

End Sub

Public Sub ToggleExpand
	m_Expanded = Not(m_Expanded)
	Refresh
End Sub

'Use a safe-area page root or supply explicit insets for a full-window root.
Public Sub SetSafeAreaInsets(Top As Float,Bottom As Float)
	m_SafeAreaTop = Max(0,Top)
	m_SafeAreaBottom = Max(0,Bottom)
	Refresh
End Sub

Private Sub Base_Resize(Width As Double,Height As Double)
	Resize(Width,Height)
End Sub

Public Sub Resize(Width As Double,Height As Double)
	If mBase.IsInitialized = False Then Return

	mBase.SetLayoutAnimated(0,mBase.Left,mBase.Top,Width,Height)
	Refresh
End Sub

Public Sub Refresh

	If mBase.IsInitialized = False Or m_Disposed Then Return

	'Track indexes and accumulated heights separately for the top and bottom stacks.
	Dim TopIndex,BottomIndex As Int
	Dim TopHeight,BottomHeight As Float

	For Each ToastItem As AS_DynamicToastItem In lst_Toasts
		Dim Position As String = ToastItem.Data.GetDefault("position",m_Properties.Get("position"))
		Dim Index As Int = BottomIndex
		Dim StackOffset As Float = BottomHeight

		If Position = "top" Then
			Index = TopIndex
			StackOffset = TopHeight
		End If

		'Pass each card its anchor and the combined height of the cards before it.
		ToastItem.Layout( _
			mBase.Left, _
			mBase.Top, _
			mBase.Width, _
			mBase.Height, _
			Position, _
			Index, _
			StackOffset, _
			m_Expanded Or m_Properties.Get("expand"), _
			m_SafeAreaTop, _
			m_SafeAreaBottom)

		If Position = "top" Then
			TopIndex = TopIndex + 1
			TopHeight = TopHeight + ToastItem.MeasuredHeight + m_Properties.Get("gap")
		Else
			BottomIndex = BottomIndex + 1
			BottomHeight = BottomHeight + ToastItem.MeasuredHeight + m_Properties.Get("gap")
		End If
	Next


	'Apply the stacking order from back to front so the newest card stays on top.
	For i = lst_Toasts.Size - 1 To 0 Step -1
		Dim StackItem As AS_DynamicToastItem = lst_Toasts.Get(i)
		StackItem.Panel.BringToFront
	Next

End Sub


Public Sub Dispose

	m_Disposed = True
	tmr_Main.Enabled = False

	'Release views and canvas resources before clearing the collections.
	For Each ToastItem As AS_DynamicToastItem In lst_Toasts
		ToastItem.Detach
	Next

	lst_Toasts.Clear
	lst_History.Clear
	m_Interacting = False

	If mBase.IsInitialized Then mBase.RemoveViewFromParent

End Sub

Public Sub Resume
	m_Paused = False

	'Do not subtract time spent in the background on the next frame.
	m_LastFrameTime = DateTime.Now

	If lst_Toasts.Size > 0 And m_Disposed = False Then tmr_Main.Enabled = True
End Sub

Public Sub Pause
	m_Paused = True
	tmr_Main.Enabled = False
	m_Interacting = False
End Sub

#End Region

#Region Properties

Public Sub setExpanded(Expanded As Boolean)
	m_Expanded = Expanded
	Refresh
End Sub

Public Sub getExpanded As Boolean
	Return m_Expanded
End Sub

Public Sub setIcons(Icons As Map)
	m_Icons = CopyMap(Icons)
	Rebuild
End Sub

Public Sub getIcons As Map
	Return CopyMap(m_Icons)
End Sub

Public Sub setToastStyle(ToastStyle As Map)
	m_ToastStyle = CopyMap(ToastStyle)
	Rebuild
End Sub

Public Sub getToastStyle As Map
	Return CopyMap(m_ToastStyle)
End Sub

Public Sub setTitleStyle(TitleStyle As Map)
	m_TitleStyle = CopyMap(TitleStyle)
	Rebuild
End Sub

Public Sub getTitleStyle As Map
	Return CopyMap(m_TitleStyle)
End Sub

Public Sub setDescriptionStyle(DescriptionStyle As Map)
	m_DescriptionStyle = CopyMap(DescriptionStyle)
	Rebuild
End Sub

Public Sub getDescriptionStyle As Map
	Return CopyMap(m_DescriptionStyle)
End Sub

Public Sub setStyle(Style As Map)
	m_RegionStyle = CopyMap(Style)
	Refresh
End Sub

Public Sub getStyle As Map
	Return CopyMap(m_RegionStyle)
End Sub

'Default: bottom
Public Sub setPosition(Position As String)
	Configure(CreateMap("position": Position))
End Sub

Public Sub getPosition As String
	Return m_Properties.Get("position")
End Sub

'Default: 4000 milliseconds
Public Sub setDuration(Duration As Long)
	Configure(CreateMap("duration": Duration))
End Sub

Public Sub getDuration As Long
	Return m_Properties.Get("duration")
End Sub

'Default: 14dip
Public Sub setGap(Gap As Float)
	Configure(CreateMap("gap": Gap))
End Sub

Public Sub getGap As Float
	Return m_Properties.Get("gap")
End Sub

'Default: 3
Public Sub setVisibleToasts(VisibleToasts As Int)
	Configure(CreateMap("visibleToasts": VisibleToasts))
End Sub

Public Sub getVisibleToasts As Int
	Return m_Properties.Get("visibleToasts")
End Sub

'Default: False
Public Sub setExpand(Expand As Boolean)
	Configure(CreateMap("expand": Expand))
End Sub

Public Sub getExpand As Boolean
	Return m_Properties.Get("expand")
End Sub

'Default: 16dip
Public Sub setOffset(Offset As Float)
	Configure(CreateMap("offset": Offset))
End Sub

Public Sub getOffset As Float
	Return m_Properties.Get("offset")
End Sub

'Default: False
Public Sub setCloseButton(CloseButton As Boolean)
	Configure(CreateMap("closeButton": CloseButton))
End Sub

Public Sub getCloseButton As Boolean
	Return m_Properties.Get("closeButton")
End Sub

'Default: True
Public Sub setSwipeToDismiss(SwipeToDismiss As Boolean)
	Configure(CreateMap("swipeToDismiss": SwipeToDismiss))
End Sub

Public Sub getSwipeToDismiss As Boolean
	Return m_Properties.Get("swipeToDismiss")
End Sub

#End Region

#Region Private Functions

Private Sub ResolveWithData(Content As Object,Value As Object) As Object

	If Content Is Map Then
		Dim ContentProperties As Map = Content
		Return CallSub2(ContentProperties.Get("Callback"),ContentProperties.Get("EventName"),Value)
	End If

	Return Content

End Sub

Public Sub ResolveContent(Content As Object) As Object

	If Content Is Map Then
		Dim ContentProperties As Map = Content
		Return CallSub(ContentProperties.Get("Callback"),ContentProperties.Get("EventName"))
	End If

	Return Content

End Sub

Public Sub Invoke(Handler As Object,Argument As Object)
	If Handler Is Map Then
		Dim HandlerProperties As Map = Handler

		If HandlerProperties.ContainsKey("Callback") And HandlerProperties.ContainsKey("EventName") Then CallSub2(HandlerProperties.Get("Callback"),HandlerProperties.Get("EventName"),Argument)
	End If
End Sub

Public Sub RemoveItem(ToastItem As AS_DynamicToastItem)

	Dim Index As Int = lst_Toasts.IndexOf(ToastItem)

	If Index > -1 Then lst_Toasts.RemoveAt(Index)
	ToastItem.Detach

	If lst_Toasts.Size <= 1 Then m_Expanded = False
	Refresh

	If lst_Toasts.Size = 0 Then tmr_Main.Enabled = False

End Sub

Public Sub SetInteracting(Value As Boolean)
	m_Interacting = Value
	m_LastFrameTime = DateTime.Now
End Sub

Private Sub ItemsSnapshot As List
	Dim Result As List
	Result.Initialize

	'A snapshot allows toasts to be removed during the frame loop.
	Result.AddAll(lst_Toasts)
	Return Result
End Sub

Private Sub FindItem(Id As Object) As AS_DynamicToastItem

	For Each ToastItem As AS_DynamicToastItem In lst_Toasts
		If SameId(ToastItem.Data.Get("id"),Id) Then Return ToastItem
	Next

	Dim EmptyItem As AS_DynamicToastItem
	Return EmptyItem

End Sub

Private Sub HistoryIndex(Id As Object) As Int

	For i = 0 To lst_History.Size - 1
		Dim ToastData As Map = lst_History.Get(i)

		If SameId(ToastData.Get("id"),Id) Then Return i
	Next

	Return -1

End Sub

Private Sub SameId(A As Object,B As Object) As Boolean
	If A = Null Or B = Null Then Return False

	'Numeric ID 1 and String ID "1" identify different toasts.
	If (A Is String) <> (B Is String) Then Return False

	If IsNumber(A) And IsNumber(B) Then Return A.As(Double) = B.As(Double)

	Return A = B
End Sub

Public Sub CopyMap(Source As Map) As Map

	Dim Result As Map
	Result.Initialize

	If Source.IsInitialized Then
		For Each Key As Object In Source.Keys
			Dim Value As Object = Source.Get(Key)

			'Copy nested option Maps as well; retain references to views and callbacks.
			If Value Is Map Then Value = CopyMap(Value)
			Result.Put(Key,Value)
		Next
	End If

	Return Result

End Sub

Public Sub ConfigValue(Key As String) As Object
	Return m_Properties.Get(Key)
End Sub

Private Sub Rebuild
	For Each ToastItem As AS_DynamicToastItem In lst_Toasts
		ToastItem.Build
	Next

	Refresh
End Sub

#End Region

#Region Animation

Private Sub StartFrames
	If tmr_Main.Enabled = False Then m_LastFrameTime = DateTime.Now
	tmr_Main.Enabled = Not(m_Paused)
End Sub

Private Sub tmr_Main_Tick

	Dim CurrentTime As Long = DateTime.Now
	Dim ElapsedTime As Long = Max(0,CurrentTime - m_LastFrameTime)
	m_LastFrameTime = CurrentTime

	For Each ToastItem As AS_DynamicToastItem In ItemsSnapshot
		ToastItem.StepFrame(ElapsedTime,m_Expanded Or m_Interacting)
	Next

End Sub

#End Region

#Region Events

Public Sub ItemClosed(ToastItem As AS_DynamicToastItem,Automatic As Boolean)

	Dim ToastData As Map = CopyMap(ToastItem.Data)

	'Automatic and manual dismissal have separate hooks and events.
	If Automatic Then
		If ToastData.ContainsKey("onAutoClose") Then Invoke(ToastData.Get("onAutoClose"),ToastData)
		EventAutoClose(ToastData)
	Else
		If ToastData.ContainsKey("onDismiss") Then Invoke(ToastData.Get("onDismiss"),ToastData)
		EventDismiss(ToastData)
	End If

End Sub

Public Sub ItemAction(ToastItem As AS_DynamicToastItem,IsCancel As Boolean)

	Dim Key As String = "action"

	If IsCancel Then Key = "cancel"

	'The callback may update the same ID. Keep that replacement card alive.
	Dim Revision As Long = ToastItem.Revision
	Invoke(ToastItem.Data.Get(Key),ToastItem.Data.Get("id"))

	If IsCancel Then
		EventCancel(ToastItem.Data.Get("id"))
	Else
		EventAction(ToastItem.Data.Get("id"))
	End If

	If ToastItem.Revision = Revision Then ToastItem.Close(False,0,0)

End Sub

Private Sub EventDismiss(ToastData As Map)
	If xui.SubExists(mCallBack,mEventName & "_Dismiss",1) Then
		CallSub2(mCallBack,mEventName & "_Dismiss",ToastData)
	End If
End Sub

Private Sub EventAutoClose(ToastData As Map)
	If xui.SubExists(mCallBack,mEventName & "_AutoClose",1) Then
		CallSub2(mCallBack,mEventName & "_AutoClose",ToastData)
	End If
End Sub

Private Sub EventAction(Id As Object)
	If xui.SubExists(mCallBack,mEventName & "_Action",1) Then
		CallSub2(mCallBack,mEventName & "_Action",Id)
	End If
End Sub

Private Sub EventCancel(Id As Object)
	If xui.SubExists(mCallBack,mEventName & "_Cancel",1) Then
		CallSub2(mCallBack,mEventName & "_Cancel",Id)
	End If
End Sub

#End Region
