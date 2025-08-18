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
	
	Private SDB As AWSSimpleDB
	
	Private taLogs As B4XView
	Private taResults As B4XView
	Private tbDomain As B4XView
	Private tbItem As B4XView
	Private tbAttributeName As B4XView
	Private tbAttributeValue As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	
	Root = Root1
	Root.LoadLayout("MainPage")
	
	B4XPages.SetTitle(Me, "AWS SimpleDB")
	
	' Initializes AWSSimpleDB
	' Put strings in Main.Process_Globals to obfuscate them in B4A and B4J
	SDB.Initialize(Main.SimpleDBAccessKey, _
	               Main.SimpleDBSecretAccessKey, _
				   Main.SimpleDBEndPoint)
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


Private Sub btnCreateDomain_Click

	If tbDomain.Text = "" Then Return
	
	Wait For(SDB.SendRequest(SDB.CreateDomainRequest(tbDomain.Text))) Complete (Result As String)
	
	taLogs.Text = Result
	taResults.Text = ""
	
End Sub

Private Sub btnDeleteDomain_Click
	
	If tbDomain.Text = "" Then Return
	
	Wait For(SDB.SendRequest(SDB.DeleteDomainRequest(tbDomain.Text))) Complete (Result As String)
	
	taLogs.Text = Result
	taResults.Text = ""
	
End Sub

Private Sub btnListDomains_Click
	
	Wait For(SDB.SendRequest(SDB.ListDomainsRequest)) Complete (Result As String)
	taLogs.Text = Result

	taResults.Text = SDB.GetDomainsFromListDomainsResult(Result)
	
End Sub

Private Sub btnPutAttribute_Click
	
	If tbDomain.Text = "" Then Return
	If tbItem.Text = "" Then Return
	If tbAttributeName.Text = "" Then Return
	If tbAttributeValue.Text = "" Then Return
	
	Wait For(SDB.SendRequest(SDB.PutAttributeRequest(tbDomain.Text, tbItem.Text, tbAttributeName.Text, tbAttributeValue.Text, True))) Complete (Result As String)
	taLogs.Text = Result
	
	taResults.Text = ""
	
End Sub

Private Sub btnGetAttributes_Click
	
	If tbDomain.Text = "" Then Return
	If tbItem.Text = "" Then Return
	
	Wait For(SDB.SendRequest(SDB.GetAttributesRequest(tbDomain.Text, tbItem.Text))) Complete (Result As String)
	taLogs.Text = Result
	
	taResults.Text = SDB.GetAttributesFromGetAttributesResult(Result)
	
End Sub

Private Sub btnDeleteItem_Click
	
	If tbDomain.Text = "" Then Return
	If tbItem.Text = "" Then Return
	
	Wait For(SDB.SendRequest(SDB.DeleteAttributesRequest(tbDomain.Text, tbItem.Text))) Complete (Result As String)
	taLogs.Text = Result
	
	taResults.Text = ""
	
End Sub