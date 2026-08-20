B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
	Private mDiagnostics As UIDiagnostics
	Private mLastCallSucceeded As Boolean
End Sub

' Creates a bridge for the common Object-based widget protocol.
Public Sub Initialize As UIWidgetBridge
	Try
		mDiagnostics = UI.Diagnostics
	Catch
		mDiagnostics.Initialize
	End Try
	mLastCallSucceeded = True
	Return Me
End Sub

' Replaces the default diagnostic collector.
Public Sub SetDiagnostics(Diagnostics As UIDiagnostics) As UIWidgetBridge
	If Diagnostics = Null Then Return Me
	If Diagnostics.IsInitialized = False Then Return Me
	mDiagnostics = Diagnostics
	Return Me
End Sub

Public Sub GetDiagnostics As UIDiagnostics
	Return mDiagnostics
End Sub

Public Sub LastCallSucceeded As Boolean
	Return mLastCallSucceeded
End Sub

' Keeps the existing public compatibility contract: the optional
' ParticipatesInLayout sub is deliberately not required here.
Public Sub IsWidgetProtocol(Widget As Object) As Boolean
	If Widget = Null Then Return False
	Return SubExists(Widget, "SetParent") _
		And SubExists(Widget, "SetPosition") _
		And SubExists(Widget, "SetSize") _
		And SubExists(Widget, "Render") _
		And SubExists(Widget, "GetContentSize")
End Sub

' Widgets without this optional sub continue to participate by default.
Public Sub IsLayoutParticipant(Widget As Object) As Boolean
	If Widget = Null Then Return False
	If SubExists(Widget, "ParticipatesInLayout") = False Then Return True
	Try
		Dim result As Boolean = CallSub(Widget, "ParticipatesInLayout")
		Return result
	Catch
		Report("ParticipatesInLayout", Widget, LastException.Message)
		Return False
	End Try
End Sub

Public Sub SetParent(Widget As Object, Parent As B4XView) As Boolean
	If IsWidgetProtocol(Widget) = False Then Return Report("SetParent", Widget, "Object does not implement the widget protocol.")
	Try
		CallSub2(Widget, "SetParent", Parent)
		Return True
	Catch
		Return Report("SetParent", Widget, LastException.Message)
	End Try
End Sub

Public Sub SetPosition(Widget As Object, Left As Int, Top As Int) As Boolean
	If IsWidgetProtocol(Widget) = False Then Return Report("SetPosition", Widget, "Object does not implement the widget protocol.")
	Try
		CallSub3(Widget, "SetPosition", Left, Top)
		Return True
	Catch
		Return Report("SetPosition", Widget, LastException.Message)
	End Try
End Sub

Public Sub SetSize(Widget As Object, Width As Int, Height As Int) As Boolean
	If IsWidgetProtocol(Widget) = False Then Return Report("SetSize", Widget, "Object does not implement the widget protocol.")
	Try
		CallSub3(Widget, "SetSize", Width, Height)
		Return True
	Catch
		Return Report("SetSize", Widget, LastException.Message)
	End Try
End Sub

Public Sub Render(Widget As Object) As Boolean
	If IsWidgetProtocol(Widget) = False Then Return Report("Render", Widget, "Object does not implement the widget protocol.")
	Try
		CallSub(Widget, "Render")
		Return True
	Catch
		Return Report("Render", Widget, LastException.Message)
	End Try
End Sub

' Temporarily detaches a widget when the tree moves or is recycled.
' New widgets may expose Detach to preserve native views and bindings.
' Legacy widgets continue through Unmount without changing their syntax.
Public Sub Unmount(Widget As Object) As Boolean
	If Widget = Null Then Return False
	If SubExists(Widget, "Unmount") = False Then Return True
	Try
		CallSub(Widget, "Unmount")
		Return True
	Catch
		Return Report("Unmount", Widget, LastException.Message)
	End Try
End Sub

' Temporarily detaches a widget for recycling or a tree move. Older custom
' widgets safely fall back to their existing Unmount implementation.
Public Sub Detach(Widget As Object) As Boolean
	If Widget = Null Then Return False
	Dim operation As String = "Detach"
	If SubExists(Widget, operation) = False Then operation = "Unmount"
	If SubExists(Widget, operation) = False Then Return True
	Try
		CallSub(Widget, operation)
		Return True
	Catch
		Return Report(operation, Widget, LastException.Message)
	End Try
End Sub

' Permanently releases a widget when its declarative identity is discarded.
' Dispose is optional so existing custom widgets remain source-compatible.
Public Sub Dispose(Widget As Object) As Boolean
	If Widget = Null Then Return False
	Dim operation As String = "Dispose"
	If SubExists(Widget, operation) = False Then operation = "Unmount"
	If SubExists(Widget, operation) = False Then Return True
	Try
		CallSub(Widget, operation)
		Return True
	Catch
		Return Report(operation, Widget, LastException.Message)
	End Try
End Sub

Public Sub GetContentSize(Widget As Object, MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize
	mLastCallSucceeded = False
	If IsWidgetProtocol(Widget) = False Then
		Report("GetContentSize", Widget, "Object does not implement the widget protocol.")
		Return result
	End If
	Try
		Dim value As List = CallSub3(Widget, "GetContentSize", MaxWidth, MaxHeight)
		If value = Null Then Return result
		If value.IsInitialized = False Then Return result
		For Each item As Object In value
			result.Add(item)
		Next
		mLastCallSucceeded = True
		Return result
	Catch
		Report("GetContentSize", Widget, LastException.Message)
		Return result
	End Try
End Sub

' Returns the safe content rectangle (system bars excluded) in the local
' coordinate space of Root. Result list: (left, top, width, height).
' Root is normally the Activity or the panel the widget is mounted on.

' Returns the safe content rectangle (system bars excluded) in the local
' coordinate space of Root. Result list: (left, top, width, height).
' Root is normally the Activity or the panel the widget is mounted on.
Public Sub GetSafeBounds(Root As B4XView, Left As Int, Top As Int, Width As Int, Height As Int) As List
	Dim result As List
	result.Initialize
	result.Add(Left)
	result.Add(Top)
	result.Add(Max(0, Width))
	result.Add(Max(0, Height))
	If Root = Null Then Return result
	If Root.IsInitialized = False Then Return result
	Try
		Dim context As JavaObject
		context.InitializeContext
		Dim window As JavaObject = context.RunMethod("getWindow", Null)
		Dim decor As JavaObject = window.RunMethod("getDecorView", Null)
		Dim rootInsets As JavaObject = decor.RunMethod("getRootWindowInsets", Null)
		If rootInsets.IsInitialized = False Then Return result

		Dim sdk As JavaObject
		sdk.InitializeStatic("android.os.Build$VERSION")
		Dim sdkInt As Int = sdk.GetField("SDK_INT")
		Dim insetLeft, insetTop, insetRight, insetBottom As Int

		If sdkInt >= 30 Then
			Dim insetTypes As JavaObject
			insetTypes.InitializeStatic("android.view.WindowInsets$Type")
			Dim systemBars As Int = insetTypes.RunMethod("systemBars", Null)
			Dim ime As Int = insetTypes.RunMethod("ime", Null)
			Dim combinedTypes As Int = Bit.Or(systemBars, ime)
			Dim nativeInsets As JavaObject = rootInsets.RunMethodJO("getInsets", Array As Object(combinedTypes))
			If nativeInsets.IsInitialized Then
				insetLeft = nativeInsets.GetField("left")
				insetTop = nativeInsets.GetField("top")
				insetRight = nativeInsets.GetField("right")
				insetBottom = nativeInsets.GetField("bottom")
			End If
		Else If sdkInt >= 20 Then
			insetLeft = rootInsets.RunMethod("getSystemWindowInsetLeft", Null)
			insetTop = rootInsets.RunMethod("getSystemWindowInsetTop", Null)
			insetRight = rootInsets.RunMethod("getSystemWindowInsetRight", Null)
			insetBottom = rootInsets.RunMethod("getSystemWindowInsetBottom", Null)
		End If

		Dim decorLocation(2) As Int
		Dim rootLocation(2) As Int
		decor.RunMethod("getLocationOnScreen", Array(decorLocation))
		Dim rootView As JavaObject = Root
		rootView.RunMethod("getLocationOnScreen", Array(rootLocation))

		Dim decorWidth As Int = decor.RunMethod("getWidth", Null)
		Dim decorHeight As Int = decor.RunMethod("getHeight", Null)
		If decorWidth <= 0 Or decorHeight <= 0 Then Return result

		Dim safeLeft As Int = decorLocation(0) + insetLeft
		Dim safeTop As Int = decorLocation(1) + insetTop
		Dim safeRight As Int = decorLocation(0) + decorWidth - insetRight
		Dim safeBottom As Int = decorLocation(1) + decorHeight - insetBottom

		Dim contentLeft As Int = Left + Max(0, safeLeft - rootLocation(0))
		Dim contentTop As Int = Top + Max(0, safeTop - rootLocation(1))
		Dim contentRight As Int = Left + Width - Max(0, rootLocation(0) + Width - safeRight)
		Dim contentBottom As Int = Top + Height - Max(0, rootLocation(1) + Height - safeBottom)

		result.Clear
		result.Add(contentLeft)
		result.Add(contentTop)
		result.Add(Max(0, contentRight - contentLeft))
		result.Add(Max(0, contentBottom - contentTop))
	Catch
		result.Clear
		result.Add(Left)
		result.Add(Top)
		result.Add(Max(0, Width))
		result.Add(Max(0, Height))
	End Try
	Return result
End Sub

Public Sub ReportError(Operation As String, Widget As Object, Message As String) As Boolean
	mLastCallSucceeded = False
	Dim widgetName As String = "Object"
	If Widget <> Null Then widgetName = GetType(Widget)
	mDiagnostics.ReportError(Operation, widgetName & ": " & Message)
	Return False
End Sub

Private Sub Report(Operation As String, Widget As Object, Message As String) As Boolean
	Return ReportError(Operation, Widget, Message)
End Sub