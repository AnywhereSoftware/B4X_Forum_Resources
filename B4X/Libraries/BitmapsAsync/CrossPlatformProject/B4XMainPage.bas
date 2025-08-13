B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView 'ignore
	Private CustomListView1 As CustomListView
	Private PCLV As PreoptimizedCLV
	Private xui As XUI
	Type MyImageData (IndexOfFirstImage As Int)
	Private ImageLoader As BitmapsAsync

End Sub

Public Sub Initialize
	
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	ImageLoader.Initialize
	PCLV.Initialize(Me, "PCLV", CustomListView1)
	Dim height As Int
	If xui.IsB4J Then height = 200dip Else height = 150dip
	For i = 1 To 600 Step 4
		PCLV.AddItem(height, xui.Color_White, CreateMyImageData(i))
	Next
	PCLV.ShowScrollBar = False 'no fast scrolling
	PCLV.ExtraItems = 5
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
			DownloadAndSetImage($"https://picsum.photos/id/${data.IndexOfFirstImage + x}/200/300.jpg"$, pnl.GetView(x).GetView(0).Tag) 'https://www.b4x.com/android/forum/threads/117992/#content
		Next
	Next
End Sub

Sub DownloadAndSetImage(Url As String, iv As B4XImageView)
	Dim j As HttpJob
	j.Initialize("", Me)
	j.Download(Url)
	Wait For (j) JobDone (j As HttpJob)
	If j.Success Then
		Try
			'the item might have already been removed
			If iv.mBase.Parent.Parent.IsInitialized Then
				Wait For (ImageLoader.LoadFromHttpJob(j, 500dip, 500dip)) Complete (bmp As B4XBitmap)
				If bmp.IsInitialized And iv.mBase.Parent.IsInitialized Then
					iv.Bitmap = bmp
				End If
			End If
		Catch
			Log(LastException)
		End Try
	End If
	j.Release
End Sub


Public Sub CreateMyImageData (IndexOfFirstImage As Int) As MyImageData
	Dim t1 As MyImageData
	t1.Initialize
	t1.IndexOfFirstImage = IndexOfFirstImage
	Return t1
End Sub