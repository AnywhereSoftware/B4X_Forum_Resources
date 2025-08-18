B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
Sub Class_Globals
	Private CLV As CustomListView
	Private mReader As FlickrFeedReader
	Private xui As XUI
	Private AnotherProgressBar1 As AnotherProgressBar
End Sub

Public Sub Initialize (Parent As B4XView, Reader As FlickrFeedReader)
	Parent.LoadLayout("1")
	mReader = Reader
	Resume
	CreateFirstItems
End Sub

Private Sub CreateFirstItems
	Do Until mReader.FlickrPhotos.Size > 0
		Sleep(100)
	Loop
	UpdateItems(0)
End Sub

Private Sub UpdateItems (LastIndex As Int)
	If LastIndex > = CLV.Size - 5 Then
		For i = CLV.Size To Min(LastIndex + 5, mReader.FlickrPhotos.Size - 1)
			Dim fp As FlickrPhoto = mReader.FlickrPhotos.Get(i)
			Dim p As B4XView = xui.CreatePanel("")
			p.SetLayoutAnimated(0, 0, 0, CLV.AsView.Width, 500dip)
			CLV.Add(p, fp)
'			Log("Number of CLV items: " & CLV.Size)
		Next
	End If
End Sub

Public Sub GetCurrentIndex As Int
	Return CLV.LastVisibleIndex
End Sub

Public Sub NewPhotoAvailable
	CLV_VisibleRangeChanged(CLV.FirstVisibleIndex, CLV.LastVisibleIndex)
End Sub

Public Sub Pause
	mReader.Stop
End Sub

Public Sub Resume
	mReader.Start(Me)
End Sub

Private Sub CLV_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	FirstIndex = FirstIndex - 2
	LastIndex = LastIndex + 2
	For i = Max(0, FirstIndex - 10) To Min(LastIndex + 10, CLV.Size - 1)
		Dim p As B4XView = CLV.GetPanel(i)
		If IsVisible(i, FirstIndex, LastIndex) Then
			Dim fp As FlickrPhoto = CLV.GetValue(i)
			If p.NumberOfViews = 0 Then
				p.LoadLayout("Item")
				p.GetView(1).Text = fp.Title
			End If
		Else
			p.RemoveAllViews
		End If
	Next
	UpdatePhotos(FirstIndex, LastIndex)
	UpdateItems(LastIndex)
End Sub

Private Sub UpdatePhotos(FirstIndex As Int, LastIndex As Int)
	Dim EverythingGood As Boolean = True
	For i = Max(0, FirstIndex) To Min(CLV.Size - 1, LastIndex)
		Dim fp As FlickrPhoto = CLV.GetValue(i)
		If mReader.DownloadedPhotos.ContainsKey(fp.Id) Then
			Dim iv As B4XView = CLV.GetPanel(i).GetView(0)
			SetBitmapAndResizeImageViewWidth(mReader.DownloadedPhotos.Get(fp.Id), iv)
		Else
			EverythingGood = False
		End If
	Next
	AnotherProgressBar1.Visible = Not(EverythingGood)
End Sub



Private Sub IsVisible(Index As Int, FirstIndex As Int, LastIndex As Int) As Boolean
	Return Index >= FirstIndex - 2 And Index <= LastIndex + 2
End Sub

Private Sub SetBitmapAndResizeImageViewWidth (bmp As B4XBitmap, iv As B4XView)
	Dim bmpRatio As Float = bmp.Width / bmp.Height
	Dim width As Int = iv.Height * bmpRatio
	iv.SetLayoutAnimated(0, iv.Parent.Width / 2 - width / 2, 0, width, iv.Height)
	iv.SetBitmap(bmp)
	#if B4A
	Dim iiv As ImageView = iv
	iiv.Gravity = Gravity.FILL
	#End If
End Sub