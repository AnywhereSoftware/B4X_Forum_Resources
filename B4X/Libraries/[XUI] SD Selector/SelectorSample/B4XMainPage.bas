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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=SelectorExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private fourSelector1 As fourSelector
	Private fourSelectorPlus1 As fourSelectorPlus
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	fourSelector1.SetItems(0,Array As String("Bracelet", "necklace", "ring", "choker"))
	fourSelector1.SetItems(1,Array As String("gold", "silver", "platinum", "copper"))
	fourSelector1.SetItems(2,Array As String("emerald", "diamond", "zircon", "brilliant", "pearls","Amber", "amethyst", "jade", "onyx", "quartz"))
	fourSelector1.SetItems(3,Array As String("Gucci", "Bulgari", "Morellato", "Pandora"))
	
	fourSelector1.SetItemIndex(0,2)
	
	fourSelectorPlus1.SetItems("One","Two","Three","Four")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
Public Sub fourSelector1_ChangeValue (nSelector As Int,Index As Int)
	Log($"Selecotr: ${nSelector} - Index: ${Index} - Value: ${fourSelector1.GetItemValue(nSelector)}"$)
End Sub

Public Sub fourSelectorPlus1_ChangeValue (Index As Int, Text As String)
	Log(Index)
	Log(Text)
End Sub

Public Sub fourSelectorPlus1_CenterClick
	Log("Click")
End Sub