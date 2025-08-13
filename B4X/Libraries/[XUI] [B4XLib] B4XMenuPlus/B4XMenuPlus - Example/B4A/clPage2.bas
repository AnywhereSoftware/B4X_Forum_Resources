B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.45
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Public mpPage2 As B4XMenuPlus
	
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	
	Root.LoadLayout( "page2" )
	
	mpPage2.Initialize( Me, Root, "MCpage2" )
	
	mpPage2.AddItem( "p2_1", "Item 1" )
	mpPage2.AddItem( "p2_2", "Item 2" )
	
	mpPage2.ShowMenu
	
End Sub

Private Sub B4XPage_MenuClick( Tag As String )
		
	If mpPage2.MenuClick( Tag )= False Then Log( "B4XPage_MenuClick page2: " & mpPage2.Error )

End Sub
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub MCpage2_p2_1()
	Log( "Click page2: p2_1" )
End Sub
