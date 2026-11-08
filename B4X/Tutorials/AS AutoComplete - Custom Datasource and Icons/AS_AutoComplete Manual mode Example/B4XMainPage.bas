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
	Private TextField1 As B4XView
	Private AS_AutoComplete1 As AS_AutoComplete

	Dim sql1 As SQL

End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS_AutoComplete Example")
	
	xui.SetDataFolder("AS_AutoCompleteExample")
	Wait For (File.CopyAsync(File.DirAssets, "Countries.db", xui.DefaultFolder, "Countries.db")) Complete (Success As Boolean)
	Log("Success: " & Success)
	
	#If B4J
	sql1.InitializeSQLite(xui.DefaultFolder, "Countries.db",True)
	#Else
	sql1.Initialize(xui.DefaultFolder, "Countries.db",True)
	#End If
	
	
	
	
	
	AS_AutoComplete1.Initialize(Me,"AS_AutoComplete1",Root,TextField1)

	#If B4A
	TextField1.As(EditText).Background = BackGround(xui.Color_Black)
	#End IF

	
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	AS_AutoComplete1.Resize(Width,Height)
End Sub

Private Sub B4XPage_KeyboardStateChanged (Height As Float)
	AS_AutoComplete1.KeyboardStateChanged(Height)
End Sub

#If B4A

Sub BackGround(Color As Int) As ColorDrawable
	Dim cdb As ColorDrawable

	cdb.Initialize(Color, 5dip)
	Return cdb
End Sub

#End If

Private Sub TextField1_TextChanged (Old As String, New As String)
	AS_AutoComplete1.TextChanged(New)
End Sub

Private Sub AS_AutoComplete1_ItemClicked(Item As AS_SelectionList_Item)
	Log("ItemClicked: " & Item.Text & " (" & Item.Value & ")")
	TextField1.Text = Item.Text
End Sub

Private Sub AS_AutoComplete1_RequestNewData(SearchText As String)
	
	Dim lstItems As List 'New List of AS_SelectionList_Item
	lstItems.Initialize
	
	'SQL query based on the search text
	Dim DR As ResultSet = sql1.ExecQuery2("SELECT * FROM dt_Country WHERE name LIKE ? ORDER BY name ASC",Array As String("%" & SearchText & "%"))
	
	Do While DR.NextRow
		
		'This is only required in this example, otherwise the flag emojis will not be displayed
		Dim Buffer() As Byte
		Buffer = DR.GetBlob("flag")
		Dim FlagEmoji As String = BytesToString(Buffer,0,Buffer.Length,"UTF-8")
	
		'Add item to the list
		lstItems.Add(AS_AutoComplete1.CreateItem(DR.GetString("name"),AS_AutoComplete1.TextToBitmap(FlagEmoji,xui.CreateDefaultFont(25),xui.Color_Black),DR.GetString("code")))
		
	Loop
	DR.Close
	
	AS_AutoComplete1.SetNewData(lstItems) 'Pass the list of items
	
End Sub

