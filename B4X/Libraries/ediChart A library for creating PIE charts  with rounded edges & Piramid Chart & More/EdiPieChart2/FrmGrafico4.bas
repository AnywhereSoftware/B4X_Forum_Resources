B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private CmdPopola As B4XView
	Private CmdPopolaNormal As B4XView

	Private ImageView1 As B4XView
	
	Private Panel1 As B4XView
	
	Private ediPiramidGlass1 As ediPiramidGlass
	Private ediPiramidGlass2 As ediPiramidGlass
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("PiramidFlat") 
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


Private Sub CmdPopola_Click
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
	'ediPiramidGlass1.Grafico(lista,True)
	'ediPiramidGlass2.Grafico(lista,True)
	ediPiramidGlass1.GraficoAnimato(lista,True)
	ediPiramidGlass2.GraficoAnimato(lista,True)
End Sub



Private Sub CmdPopolaNormal_Click
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
	'ediPiramidGlass1.Grafico(lista,True)
	'ediPiramidGlass2.Grafico(lista,True)
	ediPiramidGlass1.GraficoAnimato(lista,False)
	ediPiramidGlass2.GraficoAnimato(lista,False)
	
End Sub