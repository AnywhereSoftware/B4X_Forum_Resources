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
	Private Button1 As B4XView
	Private Button2 As B4XView
	Private EdiPieChart21 As EdiPieChart2
	Private ediPiramidChart1 As ediPiramidChart
	Private ediBarRound3d1 As ediBarRound3d
	Private PageGrafico2 As FrmGrafico2
	Private PageGrafico3 As FrmGrafico3
	Private PageGrafico4 As FrmGrafico4
	Private BtnPage2 As B4XView
	Private BtnPage3 As B4XView
	Private BtnPage4 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	PageGrafico2.Initialize
	PageGrafico3.Initialize
	PageGrafico4.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage2")
	B4XPages.AddPage("FrmGrafico2",PageGrafico2)
	B4XPages.AddPage("FrmGrafico3",PageGrafico3)
	B4XPages.AddPage("FrmGrafico4",PageGrafico4)
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button2_Click

	Dim lista As List
	lista.Initialize
	Dim num1 As Int
	num1=(Rnd(3,13))
	For i = 1 To num1
		Dim e As Elemento
		e.Initialize
		e.Nome = "Item " & i
		e.Valore = Rnd(10, 200)
		lista.Add(e)
	Next
	'not sorted
	ediPiramidChart1.GraficoAnimato(lista,False)
	ediBarRound3d1.GraficoAnimato(lista,False)
	EdiPieChart21.GraficoAnimato(lista,False)
End Sub


Private Sub Button1_Click
	Dim lista As List
	lista.Initialize
	Dim num1 As Int
	num1=(Rnd(3,13))
	For i = 1 To num1
		Dim e As Elemento
		e.Initialize
		e.Nome = "Item " & i
		e.Valore = Rnd(10, 200)
		lista.Add(e)
	Next
	'sorted
	ediPiramidChart1.GraficoAnimato(lista,True)
	ediBarRound3d1.GraficoAnimato(lista,True)
	EdiPieChart21.GraficoAnimato(lista,True)

	'ediBarRound3d1.Grafico
	
End Sub



Private Sub BtnPage2_Click
	B4XPages.ShowPage("FrmGrafico2")
End Sub

Private Sub BtnPage3_Click
	B4XPages.ShowPage("FrmGrafico3")
End Sub

Private Sub BtnPage4_Click
	B4XPages.ShowPage("FrmGrafico4")
End Sub