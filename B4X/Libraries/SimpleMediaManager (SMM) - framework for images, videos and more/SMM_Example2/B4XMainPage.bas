B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=SMM_Example2.zip

Sub Class_Globals
	Private Root As B4XView 'ignore
	Private CustomListView1 As CustomListView
	Private PCLV As PreoptimizedCLV
	Private xui As XUI
	Type MyImageData (IndexOfFirstImage As Int)
	Private MediaManager As SimpleMediaManager
End Sub

Public Sub Initialize
	
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	'Stress test this example in RELEASE mode!
	B4XPages.SetTitle(Me, "SMM Example #2")
	Root = Root1
	Root.LoadLayout("1")
	MediaManager.Initialize
	PCLV.Initialize(Me, "PCLV", CustomListView1)
	Dim height As Int
	If xui.IsB4J Then height = 200dip Else height = 150dip
	For i = 1 To 600 Step 4
		PCLV.AddItem(height, xui.Color_White, CreateMyImageData(i))
	Next
	PCLV.ShowScrollBar = False 'no fast scrolling
	PCLV.ExtraItems = 3
	PCLV.Commit
End Sub

Sub CustomListView1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	For Each i As Int In PCLV.VisibleRangeChanged(FirstIndex, LastIndex)
		Dim item As CLVItem = CustomListView1.GetRawListItem(i)
		Dim pnl As B4XView = xui.CreatePanel("")
		item.Panel.AddView(pnl, 0, 0, item.Panel.Width, item.Panel.Height)
		Dim data As MyImageData = item.Value
		'Create the item layout
		pnl.LoadLayout("item")
		For x = 0 To 3
			pnl.GetView(x).GetView(1).Text = data.IndexOfFirstImage + x
			MediaManager.SetMedia(pnl.GetView(x).GetView(0), $"https://picsum.photos/id/${data.IndexOfFirstImage + x}/200/300.jpg"$)
		Next
	Next
	'The purpose of this call is to find panels that are no longer in the views tree and cancel any ongoing request that is no longer relevant.
	'It also happens automatically from time to time but in this case, as many requests are sent frequently, it is better to force it to trim the cache.
	'Note that you need to add HU2_PUBLIC to the build configuration.
	MediaManager.TrimMediaCache
End Sub



Public Sub CreateMyImageData (IndexOfFirstImage As Int) As MyImageData
	Dim t1 As MyImageData
	t1.Initialize
	t1.IndexOfFirstImage = IndexOfFirstImage
	Return t1
End Sub