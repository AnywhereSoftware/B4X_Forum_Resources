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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private slb As xq_minilistbutton
	Private slb2 As xq_minilistbutton
	Private slb4 As xq_minilistbutton
	Private slb3 As xq_minilistbutton
	Private slb5 As xq_minilistbutton
	Private slb6 As xq_minilistbutton
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Dim cs As CSBuilder
	
	slb.Items.Clear
	slb.Items.Add("EN")
	slb.Items.Add("GR")
	slb.Items.Add("FR")
	slb.Items.Add("US")
	slb.ItemIndex = 0
	
    slb2.Items.Clear
	slb2.Items.Add("English")
	slb2.Items.Add("Greek")
	slb2.Items.Add("German")
	slb2.Items.Add("Spanish")
	slb2.ItemIndex = 0
	
	slb3.Items.Clear
	slb3.Items.Add("Left")
	slb3.Items.Add("Center")
	slb3.Items.Add("Right")
	slb3.ChangeChar = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF07E)).PopAll
	slb3.ItemIndex = 0
	
	slb4.Items.Clear
	slb4.Items.Add("Top")
	slb4.Items.Add("Middle")
	slb4.Items.Add("Bottom")
	slb4.ChangeChar = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF07D)).PopAll
	slb4.ItemIndex = 0
	
	slb5.Items.Clear
	slb5.Items.Add("Euro")
	slb5.Items.Add("Dollar")
	slb5.Items.Add("Yen")
	slb5.ChangeChar = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(22).Append(Chr(0xF153)).PopAll
	slb5.ItemIndex = 0
	
	slb6.Items.Clear
	slb6.Items.Add(cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(18).Append(Chr(0xF153)).PopAll)
	slb6.Items.Add(cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(18).Append(Chr(0xF155)).PopAll)
	slb6.Items.Add(cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(18).Append(Chr(0xF157)).PopAll)
	slb6.Items.Add(cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(18).Append(Chr(0xF154)).PopAll)
	slb6.ItemIndex = 0
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	
End Sub

Private Sub slb_Change
	xui.MsgboxAsync("You selected: " & slb.Selection, "B4X")
End Sub