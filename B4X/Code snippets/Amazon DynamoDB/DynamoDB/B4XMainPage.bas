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
	
	' Put your keys in Main.Process_Globals to obfuscate them in B4A and B4J
	Private DynamoDBAccessKey As String = ""
	Private DynamoDBSecretAccessKey As String = ""
	Private DynamoDBRegion As String = "eu-central-1"
	
	Private Root As B4XView
	Private xui As XUI
	
	Private DDB As AWSDynamoDB
		
	Private tbTable As B4XView
	Private tbPartitionKey As B4XView
	Private tbSortKey As B4XView
	Private taLogs As B4XView
	Private tbValue1 As B4XView
	Private tbValue2 As B4XView
	Private tbValue3 As B4XView
	Private tbKey1 As B4XView
	Private tbKey2 As B4XView
	Private tbKey3 As B4XView
			
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	
	Root = Root1
	Root.LoadLayout("MainPage")
	
	B4XPages.SetTitle(Me, "AWS DynamoDB")
	
	' Initializes AWSDynamoDB
	DDB.Initialize(DynamoDBAccessKey, _
	               DynamoDBSecretAccessKey, _
				   DynamoDBRegion)
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub btnCreateTable_Click

	If tbTable.Text = "" Or tbPartitionKey.Text = "" Then Return
	
	Wait For(DDB.CreateOnDemandTable(tbTable.Text, tbPartitionKey.Text, tbSortKey.Text)) Complete (Result As String)
	taLogs.Text = Result
		
End Sub

Private Sub btnListTables_Click
	
	Wait For(DDB.ListTables("")) Complete (Result As String)
	taLogs.Text = Result
	
End Sub

Private Sub btnDeleteTable_Click
	
	If tbTable.Text = "" Then Return
	
	Wait For(DDB.DeleteTable(tbTable.Text)) Complete (Result As String)
	taLogs.Text = Result
	
End Sub

Private Sub btnPutItem_Click
		
	If tbTable.Text = "" Or tbPartitionKey.Text = "" Or tbValue1.Text = "" Then Return
	
	Dim Item As Map
	Item.Initialize
	Item.Put(tbPartitionKey.Text, tbValue1.Text)
	
	If tbKey2.Text <> "" And tbValue2.Text <> "" Then Item.Put(tbKey2.Text, tbValue2.Text)
	If tbKey3.Text <> "" And tbValue3.Text <> "" Then Item.Put(tbKey3.Text, tbValue3.Text)
	
	Wait For(DDB.PutItem(tbTable.Text, Item)) Complete (Result As String)
	taLogs.Text = Result
			
End Sub

Private Sub tbPartitionKey_TextChanged (Old As String, New As String)
	tbKey1.Text = New
End Sub

Private Sub tbSortKey_TextChanged (Old As String, New As String)
	tbKey2.Text = New
End Sub

Private Sub btnDeleteItem_Click
	
	If tbTable.Text = "" Or tbPartitionKey.Text = "" Or tbValue1.Text = "" Then Return
		
	Wait For(DDB.DeleteItem(tbTable.Text, tbPartitionKey.Text, tbValue1.Text, tbSortKey.Text, tbValue2.Text)) Complete (Result As String)
	taLogs.Text = Result
		
End Sub

Private Sub btnGetItem_Click
	
	If tbTable.Text = "" Or tbPartitionKey.Text = "" Or tbValue1.Text = "" Then Return
		
	Wait For(DDB.GetItem(tbTable.Text, tbPartitionKey.Text, tbValue1.Text, tbSortKey.Text, tbValue2.Text)) Complete (Result As String)
	taLogs.Text = Result
		
End Sub

Private Sub btnTestValues_Click
	tbTable.Text = "TestTable"
	tbPartitionKey.Text = "ID"
	tbSortKey.Text = "ID2"
	tbKey1.Text = "ID"
	tbKey2.Text = "ID2"
	tbKey3.Text = "Parameter"
	tbValue1.Text = "Value ID 1"
	tbValue2.Text = "Value ID2 1"
	tbValue3.Text = "Value Parameter 1"
End Sub