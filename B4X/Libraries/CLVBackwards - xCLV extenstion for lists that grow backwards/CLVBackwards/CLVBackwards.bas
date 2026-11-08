B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
'v1.00
Sub Class_Globals
	Private mCLV As CustomListView
	Public Spacer As B4XView
	Private xui As XUI
	#if B4i
	Private jclv As NativeObject
	#else
	Private jclv As JavaObject
	#End If
	Private items As List
	Private SpacerItem As CLVItem
	Public SpacerRemoved As Boolean
	Private RefreshIndex As Int
End Sub

Public Sub Initialize (CLV As CustomListView)
	mCLV = CLV
	jclv = mCLV 'ignore
	Spacer = xui.CreatePanel("")
	Spacer.SetLayoutAnimated(0, 0, 0, CLV.AsView.Width, 100000dip)
	CLV.Add(Spacer, Null)
	#if B4i
	items = jclv.GetField("__items").RunMethod("object", Null)
	Dim sv As ScrollView = CLV.sv
	sv.Bounces = False
	#else
	items = jclv.GetFieldJO("_items").RunMethod("getObject", Null)
	#End If
	SpacerItem = items.Get(0)
End Sub

Public Sub AddItem (Pnl As B4XView, Value As Object)
	Dim h As Int = Pnl.Height
	Pnl.Height = 0
	mCLV.Add(Pnl, Value)
	Dim LastItem As CLVItem = items.Get(mCLV.Size - 1)
	items.RemoveAt(mCLV.Size - 1)
	items.InsertAt(1, LastItem)
	Spacer.Height = Spacer.Height - h
	SpacerItem.Size = Spacer.Height
	LastItem.Offset = Spacer.Height
	LastItem.Panel.Top = LastItem.Offset
	Pnl.Height = h
	Pnl.Parent.Height = h
	LastItem.Size = h
	RefreshIndex = RefreshIndex + 1
	Dim MyIndex As Int = RefreshIndex
	Sleep(30)
	If MyIndex = RefreshIndex Then
		mCLV.Refresh
	End If
End Sub

Public Sub IsReady As ResumableSub
	Sleep(50)
	Do While mCLV.sv.ScrollViewOffsetY  = 0
		mCLV.sv.ScrollViewOffsetY = mCLV.sv.ScrollViewContentHeight - mCLV.sv.Height
		Sleep(50)
	Loop
	Return True
End Sub

Public Sub RemoveTheSpacer
	Dim y As Int = mCLV.sv.ScrollViewOffsetY
	mCLV.RemoveAt(0)
	SpacerRemoved = True
	ScrollToNow(y - Spacer.Height)
	Sleep(0)
	ScrollToNow(y - Spacer.Height)
End Sub

Public Sub ScrollToItemNow (Index As Int)
	Dim item As CLVItem = items.Get(Index)
	ScrollToNow(item.Offset)
End Sub

Private Sub ScrollToNow (TargetY As Int)
	#if B4J
	mCLV.sv.ScrollViewOffsetY = TargetY
	#else if B4i
	Dim sv As ScrollView = mCLV.sv
	sv.ScrollTo(0, TargetY, False)
	#Else If B4A
	Dim sv As ScrollView = mCLV.sv
	sv.ScrollToNow(TargetY)
	sv.ScrollPosition = TargetY
	#End If
End Sub
