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
#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

	' Views bound from MainPage.bjl.
	' rbCanvas and rbBC must belong to the same ToggleGroup in the designer
	' so that selecting one deselects the other automatically.
	Private Panel1 As B4XView
	Private pnlButtons As B4XView
	Private lblStatus As B4XView
	Private rbCanvas As B4XRadioButton
	Private rbBC As B4XRadioButton
	Private cbHoles As B4XView
	
	' Logic classes
	Private mJTSDrawAutoTest As JTSDrawAutoTest
	Private mJTSDrawSpeedTest As JTSDrawSpeedTest
	Private mJTSDrawTestSuite As JTSDrawTestSuite
	Private mJTSExamples As JTSExamples
	Private mJTSTest As JTSTest
	Private mJts As JTSManager

	' Shared canvas
	Private mCanvas As B4XCanvas

	' Drawing regions, computed once when the canvas is first used.
	' regionA / regionB: left+right (landscape) or top+bottom (portrait).
	' mFullRegion: entire Panel1 area (STRtree example).
	Private mRegionA As B4XRect
	Private mRegionB As B4XRect
	Private mFullRegion As B4XRect
	Private mRegionsReady As Boolean
	Private pnlJTSDrawTestSuit As B4XView
	Private pnlSpeedTest As B4XView
	Private rbCanvasSpeed As B4XRadioButton
	Private rbBCSpeed As B4XRadioButton
	Private btnStop As Button
	Private sbNumberOfGeoms As B4XSeekBar
	Private sbMaxSize As B4XSeekBar
	Private cbStyle As B4XComboBox
End Sub

'Main page: wires layout views to the five logic classes and handles all
'user interactions.
'
'Drawing regions are computed lazily on first use from the canvas size.
'They split Panel1 horizontally (landscape) or vertically (portrait).
'
'JTSExamples and JTSTest share mJts. The three Draw classes each receive
'the same shared mJts, mCanvas and lblStatus from here.
Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event is called once, before the page becomes visible.
Private Sub B4XPage_Created(Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	mCanvas.Initialize(Panel1)
	mJts.Initialize("FLOATING", 0)
	mJTSDrawAutoTest.Initialize(lblStatus, mCanvas, mJts)
	mJTSDrawSpeedTest.Initialize(lblStatus, mCanvas, mJts)
	sbNumberOfGeoms.Value = mJTSDrawSpeedTest.NumberOfGeometrics	
	sbMaxSize.Value = mJTSDrawSpeedTest.MaxGeomSize
	cbStyle.SetItems(Array As String("strok & fill","no fill","no stroke"))
	cbStyle.SelectedIndex = 0
	mJTSDrawTestSuite.Initialize(lblStatus, mCanvas, mJts)
	mJTSExamples.Initialize(mJts)
	mJTSTest.Initialize(mJts)	

	' Default to Canvas mode; show the first visual test.
	rbCanvas.Checked = True
	
End Sub

'##########################################################################
'# Region helpers
'##########################################################################

'Computes mRegionA, mRegionB and mFullRegion from the current canvas size.
'Called lazily so that the JavaFX layout pass has had time to set Panel1
'dimensions before we read them.
Private Sub EnsureRegions
	If mRegionsReady Then Return
	Dim w As Float = mCanvas.TargetRect.Width
	Dim h As Float = mCanvas.TargetRect.Height
	If w = 0 Or h = 0 Then Return
	mFullRegion.Initialize(0, 0, w, h)
	If w >= h Then
		' Landscape: side-by-side split
		mRegionA.Initialize(0,     0, w / 2, h)
		mRegionB.Initialize(w / 2, 0, w,     h)
	Else
		' Portrait: top/bottom split
		mRegionA.Initialize(0, 0,     w, h / 2)
		mRegionB.Initialize(0, h / 2, w, h)
	End If
	mRegionsReady = True
End Sub

'##########################################################################
'# JTSExamples buttons
'##########################################################################

Private Sub btnUnion_Click
	lblStatus.Text = ""
	mJTSExamples.endSTRtree
	EnsureRegions
	mJTSExamples.DrawUnionExample(mCanvas, mRegionA, mRegionB)
End Sub

Private Sub btnSTRtree_Click
	lblStatus.Text = ""
	mJTSExamples.endSTRtree
	EnsureRegions
	mJTSExamples.DrawSTRtreeExample(mCanvas, mFullRegion)
End Sub

Private Sub btnAffine_Click
	lblStatus.Text = ""
	mJTSExamples.endSTRtree
	EnsureRegions
	mJTSExamples.DrawAffineExample(mCanvas, mRegionA, mRegionB)
End Sub

'##########################################################################
'# JTSTest
'##########################################################################

Private Sub btnWrapperTest_Click
	mJTSExamples.endSTRtree
	lblStatus.Text = ""
	mCanvas.DrawRect(mCanvas.TargetRect, xui.Color_White, True, 0)
	mJTSTest.RunAll
	lblStatus.Text = $"${mJTSTest.GetPassedCount} PASS / ${mJTSTest.GetFailedCount} FAIL${CRLF}See the log for details."$
End Sub

'##########################################################################
'# JTSDrawTestSuite navigation
'##########################################################################

Private Sub btnPrev_Click
	lblStatus.Text = ""
	mJTSDrawTestSuite.PrevTest
End Sub

Private Sub btnNext_Click
	lblStatus.Text = ""
	mJTSDrawTestSuite.NextTest
End Sub

Private Sub rbCanvas_Checked
	mJTSDrawTestSuite.SetMode(False)
End Sub

Private Sub rbBC_Checked
	mJTSDrawTestSuite.SetMode(True)
End Sub

'##########################################################################
'# JTSDrawAutoTest
'##########################################################################

Private Sub btnAutoTest_Click
	mJTSExamples.endSTRtree
	lblStatus.Text = ""
	mJTSDrawAutoTest.RunAll   ' writes "N PASS / M FAIL" to lblStatus internally
End Sub

'##########################################################################
'# JTSDrawSpeedTest
'##########################################################################

Private Sub btnSpeedTest_Click
	lblStatus.Text = ""
	mJTSExamples.endSTRtree
	pnlButtons.Visible = False
	pnlSpeedTest.Visible = True
	rbCanvasSpeed.Checked = True
	Wait For (mJTSDrawSpeedTest.RunAll) Complete (r As Boolean)
	pnlButtons.Visible = True
	pnlSpeedTest.Visible = False
End Sub

Private Sub btnStop_Click
	mJTSDrawSpeedTest.Stop
End Sub

Private Sub rbBCSpeed_Checked
	mJTSDrawSpeedTest.DrawingMethode = mJTSDrawSpeedTest.DRAWING_METHODE_BITMAPCREATOR
End Sub

Private Sub rbCanvasSpeed_Checked
	mJTSDrawSpeedTest.DrawingMethode = mJTSDrawSpeedTest.DRAWING_METHODE_CANVAS
End Sub

Private Sub cbHoles_CheckedChange(Checked As Boolean)
	mJTSDrawSpeedTest.WithHoles = Checked
End Sub

Private Sub btnDrawTestSuit_Click
	mJTSExamples.endSTRtree
	pnlJTSDrawTestSuit.Visible = True
	pnlButtons.Visible = False
	mJTSDrawTestSuite.SetMode(rbBC.Checked)
End Sub

Private Sub btnJTSDrawTestSuitOK_Click
	pnlButtons.Visible = True
	pnlJTSDrawTestSuit.Visible = False
End Sub



Private Sub sbNumberOfGeoms_ValueChanged (Value As Int)
	mJTSDrawSpeedTest.NumberOfGeometrics = Value
End Sub



Private Sub sbMaxSize_ValueChanged (Value As Int)
	mJTSDrawSpeedTest.MaxGeomSize = Value
End Sub

Private Sub cbStyle_SelectedIndexChanged (Index As Int)
	Select Case Index
		Case 0
			mJTSDrawSpeedTest.Fill = True
			mJTSDrawSpeedTest.Stroke = True
		Case 1
			mJTSDrawSpeedTest.Fill = False
			mJTSDrawSpeedTest.Stroke = True
		Case 2
			mJTSDrawSpeedTest.Fill = True
			mJTSDrawSpeedTest.Stroke = False
	End Select
End Sub

#if b4J
Private Sub Panel1_MouseDragged (EventData As MouseEvent)
	CallSub2(mJTSExamples,"DragEvent",CreateMap("x":EventData.x,"y":EventData.Y))
End Sub

Private Sub Panel1_MousePressed (EventData As MouseEvent)
	CallSub2(mJTSExamples,"DragEvent",CreateMap("start":True,"x":EventData.x,"y":EventData.Y))
End Sub

Private Sub Panel1_MouseReleased (EventData As MouseEvent)
	CallSub2(mJTSExamples,"DragEvent",CreateMap("stop":True,"x":EventData.x,"y":EventData.Y))
End Sub
#else if B4A
Private Sub Panel1_Touch (Action As Int, X As Float, Y As Float)
	Dim p As Panel = Panel1
	Select Case Action
		Case p.ACTION_DOWN
			p.Tag = True
			CallSub2(mJTSExamples,"DragEvent",CreateMap("start":True,"x":x,"y":Y))
		Case p.ACTION_UP
			p.Tag = False
			CallSub2(mJTSExamples,"DragEvent",CreateMap("stop":True,"x":x,"y":Y))
		Case p.ACTION_MOVE
			CallSub2(mJTSExamples,"DragEvent",CreateMap("x":x,"y":Y))
	End Select
End Sub
#end if

