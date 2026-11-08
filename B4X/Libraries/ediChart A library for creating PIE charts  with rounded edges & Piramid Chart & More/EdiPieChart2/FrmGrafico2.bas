B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private CmdPopola As Button
	Private CmdPopolaNormal As Button
	Private ediBar3d1 As ediBar3d
	Private ediBar3d2 As ediBar3d
	Private ImageView1 As ImageView
	
	Private Panel1 As B4XView
	
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("Bar3d")
	
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
	'ediPiramidChart1.Grafico(lista,True)
	'ediBarRound3d1.Grafico(lista,True)
	ediBar3d1.GraficoAnimato(lista,True)
	ediBar3d2.GraficoAnimato(lista,True)
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
	'ediPiramidChart1.Grafico(lista,True)
	'ediBarRound3d1.Grafico(lista,True)
	ediBar3d1.GraficoAnimato(lista,False)
	ediBar3d2.GraficoAnimato(lista,False)
	
End Sub