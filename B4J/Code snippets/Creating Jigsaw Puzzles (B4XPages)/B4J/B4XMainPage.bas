B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Diff As WorldPosition
		
	Private RectWidth As Float
	Private RectHeight As Float

	Private TouchCapture As B4XView
	
	Type WorldPosition(x As Float, Y As Float)
		
	Type PuzzlePiece(Left As Float, Top As Float, FinalLeft As Float, FinalTop As Float, Width As Float, FinalWidth As Float, Height As Float, FinalHeight As Float, Bitmap As B4XBitmap, _
	GridPositionX As Int, GridPositionY As Int, WorldPositionDiff As WorldPosition, Placed As Boolean, SideInsets As Inset, AddedToCLV As Boolean)
	
	Type PuzzleCell(Left As Float, Top As Float, Width As Float, Height As Float, GridPositionX As Int, GridPositionY As Int, Placed As Boolean)

	Type CellRects(OutterRect As B4XRect, InnerRect As B4XRect)
	
	Type Inset(Top As Int, Right As Int, Bottom As Int, Left As Int)
	
	Private PieceBitmap As B4XBitmap
		
	Private TouchedPieceView As B4XView
			
	Private PuzzlePieceList, RackPieceList As List
			
	Private JFX As JFX
		
	Private DrawJigSawShape As JigsawShape
	
	Private PieceSize, OverLap As Float 'Just one side of the safezone. Needs to be added to all sides
	
	Private puzzle_Size As Int = 7	'Change this to change puzzle size. This represent how many pieces to show on one row or column of the puzzle.
	
	Private inset_array As List
	
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	DrawJigSawShape.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
			
	PuzzlePieceList.Initialize
		
	RackPieceList.Initialize
	
	inset_array.Initialize
	inset_array.AddAll(Array As Int(0, 2))
	
	PreparePuzzleImage
		
	CreatePuzzle(puzzle_Size)
					
	DrawPieces
End Sub

'This used to prepare the image by creating extra pixels by the left, right, top and bottom to allow for drawing interconnected jigaw pieces
Sub PreparePuzzleImage
	PieceSize = Root.Width / puzzle_Size
	OverLap = PieceSize * 0.33333	'30% of the piece width(safezone). The jigsaw shape coordinates have been designed to match this overlap
	
	RectWidth = PieceSize
	RectHeight = PieceSize
	PieceBitmap = JFX.LoadImage(File.DirAssets, Rnd(1, 9) & ".png")

	Private PuzzleImageCanvas As B4XCanvas
	Private PuzzleImageRect, PuzzleBgRect As B4XRect
	Private PuzzleImageView As B4XView = xui.CreatePanel("")
		
	PuzzleImageView.SetLayoutAnimated(0, 0, 0, Root.Width + OverLap * 2, Root.Width + OverLap * 2)
	PuzzleImageCanvas.Initialize(PuzzleImageView)
		
	PuzzleBgRect.Initialize(0, 0, PuzzleImageView.Width, PuzzleImageView.Width)
	PuzzleImageRect.Initialize(OverLap, OverLap, Root.Width + OverLap, Root.Width + OverLap)
	
	PuzzleImageCanvas.drawrect(PuzzleBgRect, xui.Color_Transparent, True, 0)
	PuzzleImageCanvas.DrawBitmap(PieceBitmap, PuzzleImageRect)
	
	PieceBitmap = PuzzleImageCanvas.CreateBitmap
	
'	SaveImage(PuzzleImageCanvas, "Prepared Image") 'This saves the prepared image
End Sub

Sub SaveImage(canvas_to_save As B4XCanvas, image_name As String)
	'saves the bitmap of layer(2)
	Dim Out As OutputStream
	xui.SetDataFolder("SimpleDrawMethods")
	Out = File.OpenOutput("C:\temp\", image_name & ".png", False)
	canvas_to_save.CreateBitmap.WriteToStream(Out, 100, "PNG")
	Out.Close
End Sub

#Region Create Puzzle And Piece
Sub CreatePuzzle(PuzzleSize As Int)
	Private FinalLeft As Float = 0
	Private FinalTop As Float = 0
			
	For x = 0 To PuzzleSize - 1
		For y = 0 To PuzzleSize - 1
			PuzzlePieceList.Add(CreatePuzzlePiece(FinalLeft, FinalTop, RectWidth, RectHeight, PieceBitmap, x, y))
			FinalTop = FinalTop + RectHeight
		Next
		
		FinalTop = 0
		FinalLeft = FinalLeft + RectWidth
	Next

End Sub

Sub CreatePuzzlePiece(FinalLeft As Float, FinalTop As Float, Width As Float, Height As Float, Bitmap As B4XBitmap, PositionX As Int, PositionY As Int) As PuzzlePiece
	Private Piece As PuzzlePiece
	Piece.Initialize
	
	Private deltaX, deltaY As Int
	
	If PositionX = 0 Then
		deltaX = 1
	Else If PositionX > 0 And PositionX < puzzle_Size - 1 Then
		deltaX = 2
	Else If PositionX = puzzle_Size - 1 Then
		deltaX = 1
	End If
	
	If PositionY = 0  Then
		deltaY = 1
	Else If PositionY > 0 And PositionY < puzzle_Size - 1  Then
		deltaY = 2
	Else If PositionY = puzzle_Size - 1 Then
		deltaY = 1
	End If
	
	Piece.Left = FinalLeft
	Piece.Top = FinalTop
	
	Piece.FinalLeft = Piece.Left - OverLap
	Piece.FinalTop =  Piece.Top - OverLap
	
	Piece.Width = Width
	Piece.Height = Height
	
	Piece.FinalWidth = Width + (OverLap * deltaX)
	Piece.FinalHeight = Height + (OverLap * deltaY)
	
	'Correct for overlap empty side on left and top
	Private xCorrection, yCorrection As Float
	
	If PositionX > 0 Then
		xCorrection = OverLap
	Else
		xCorrection = 0
	End If

	If PositionY > 0 Then
		yCorrection = OverLap
	Else
		yCorrection = 0
	End If
	
	Piece.Bitmap = Bitmap.Crop(Max(0, Piece.FinalLeft + xCorrection), Max(0, Piece.FinalTop + yCorrection), Piece.Width + (OverLap * 2)	, Piece.Height + (OverLap * 2)) 'Crop bitmap
	'//////////////////////////////////////////////////
	
	Piece.GridPositionX = PositionX
	Piece.GridPositionY = PositionY
	
	Piece.WorldPositionDiff = GetWorldPosition(0, 0)
	
	Piece.Placed = False
	
	Piece.SideInsets = CheckPuzzleSides(PositionX, PositionY)
	
	Return Piece
End Sub
#End Region

#Region Puzzle sides and Inset
Sub CheckPuzzleSides(PositionX As Int, PositionY As Int) As Inset
	Private piece_inset As Inset
	
	piece_inset.Top = GetTopInset(PositionX, PositionY)
	piece_inset.Right = GetRightInset(PositionX)
	piece_inset.Bottom = GetBottomInset(PositionY)
	piece_inset.Left = GetLeftInset(PositionX, PositionY)
	
	Return piece_inset
End Sub

Sub GetLeftInset(PositionX As Int, PositionY As Int) As Int
	Private LeftInset As Int
	
	If PositionX = 0 Then
		LeftInset = 1
		Return LeftInset
	End If
	
	For Each Piece As PuzzlePiece In PuzzlePieceList
		If Piece.GridPositionX = Max(0, PositionX -1) And Piece.GridPositionY = Max(0, PositionY) Then
			If Piece.SideInsets.Right = 0 Then
				LeftInset = 2
			Else If Piece.SideInsets.Right = 2 Then
				LeftInset = 0
			Else
				LeftInset = 1
			End If
		End If
	Next
	
	Return LeftInset
End Sub

Sub GetTopInset(PositionX As Int, PositionY As Int) As Int
	Private TopInset As Int
	
	If PositionY = 0 Then
		TopInset = 1
		Return TopInset
	End If
		
	For Each Piece As PuzzlePiece In PuzzlePieceList
		If Piece.GridPositionX = Max(0, PositionX) And Piece.GridPositionY = Max(0, PositionY - 1) Then
			If Piece.SideInsets.Bottom = 0 Then
				TopInset = 2
			Else If Piece.SideInsets.Bottom = 2 Then
				TopInset = 0
			Else
				TopInset = 1
			End If
		End If
	Next
	
	Return TopInset
End Sub

Sub GetBottomInset(PositionY As Int) As Int
	Private BottomInset As Int
	
	If PositionY = puzzle_Size - 1 Then
		BottomInset = 1
		Return BottomInset
	End If
	
	BottomInset = inset_array.Get(Rnd(0, 2))
	
	Return BottomInset
End Sub

Sub GetRightInset(PositionX As Int) As Int
	Private RightInset As Int
	
	If PositionX = puzzle_Size - 1 Then
		RightInset = 1
		Return RightInset
	End If

	RightInset = inset_array.Get(Rnd(0, 2))
	
	Return RightInset
End Sub
#End Region

Sub DrawPieces
	
	Private image_no As Int = 0
		
	For Each Piece As PuzzlePiece In PuzzlePieceList

		Private PieceShapeData As PieceShapeData = DrawJigSawShape.CreatePieceShape(0, 0, Piece.Width + (OverLap * 2) _
		, Piece.Height + (OverLap * 2), OverLap, Piece.SideInsets.Top, Piece.SideInsets.Right, Piece.SideInsets.Bottom, Piece.SideInsets.Left) '-/+ overlap to avoid dragging piece with empty overlap areas
			
		Private PieceViewCanvas As B4XCanvas
		Private PieceView As B4XView = xui.CreatePanel("RackPiece")
	
		PieceView.SetLayoutAnimated(0, 0, 0, Piece.Width + (OverLap * 2), Piece.Width + (OverLap * 2))
	
		PieceViewCanvas.Initialize(PieceView)
		

		'PieceViewCanvas.DrawRect(PieceShapeData.SafeZoneRect, xui.Color_Red, False, 1)
		'PieceViewCanvas.DrawRect(PieceShapeData.FullRect, xui.Color_Green, False, 1)
		PieceViewCanvas.ClipPath(PieceShapeData.PiecePath)
		PieceViewCanvas.DrawBitmap(Piece.Bitmap, PieceShapeData.FullRect)
		'PieceViewCanvas.DrawPath(PieceShapeData.PiecePath, xui.Color_Gray, False, 1)
		PieceViewCanvas.RemoveClip

		'Save piece image
	'	SaveImage(PieceViewCanvas, image_no)
		image_no = image_no + 1
		
		Root.AddView(PieceView, Piece.FinalLeft, Piece.FinalTop, Piece.Width + (OverLap * 2), Piece.Height + (OverLap * 2))
		
		Sleep(50)
		
		RackPieceList.Add(PieceView)
	Next
	TouchCapture.BringToFront	
End Sub

Sub TouchCapture_Touch (Action As Int, X As Float, Y As Float)
	Select Action
		Case 0 'down
			TouchedPieceView = CheckTouchedPiece(X, Y)
			If TouchedPieceView.IsInitialized Then
				TouchedPieceView.BringToFront
			End If
		Case 1 'up
			If TouchedPieceView.IsInitialized Then
				TouchCapture.BringToFront
			End If
		Case 2 'moving
			If TouchedPieceView.IsInitialized Then
				TouchedPieceView.Left = X - Diff.x
				TouchedPieceView.top = Y - Diff.y
			End If
	End Select
End Sub


Sub CheckTouchedPiece(x As Float, y As Float) As B4XView
	For Each PieceView As B4XView In RackPieceList
		If x > PieceView.Left + OverLap And y > PieceView.Top + OverLap And x < PieceView.Left + PieceView.Width - OverLap And y < PieceView.Top + PieceView.Height - OverLap Then
			Diff = GetWorldPosition(x - PieceView.Left, y - PieceView.Top)
			Return PieceView
		End If
	Next
	
	Return Null
End Sub

Sub GetWorldPosition(x As Float, y As Float) As WorldPosition
	Private position As WorldPosition
	position.Initialize
	
	position.x = x
	position.y = y
	
	Return position
End Sub