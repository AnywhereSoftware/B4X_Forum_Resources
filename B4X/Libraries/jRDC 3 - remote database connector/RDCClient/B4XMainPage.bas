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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=ClientExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private const ServerUrl As String = "http://192.168.1.102:17178/rdc"
	Private rdc As RDCManager
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	rdc.Initialize(ServerUrl)
End Sub

Private Sub Button1_Click
	Wait For (rdc.ExecuteQuery("select_animal", Array(15))) Complete (Result As RDCResult) 'queries are defined in the server config.properties file
	If Result.Success Then
		Log(Result.Data.ToString(0))
		If Result.Data.Size > 0 Then
			Dim Name As String = Result.Data.GetValue(0, "name")
			Dim id As Int = Result.Data.GetValue(0, "id")
			Dim blob() As Byte = Result.Data.GetValue(0, "image")
			If blob <> Null Then
				Dim img As B4XBitmap = rdc.BytesToImage(blob)
				'
			End If
			Log(Name)
			Log(id)
		Else
			Log("no matched id")
		End If
	Else
		Log("error: " & Result.ErrorMessage)
	End If
	
	InsertRecord("test", xui.LoadBitmap(File.DirAssets, "logo.png"))
	InsertBatch
End Sub

Private Sub InsertRecord (Name As String, Img As B4XBitmap)
	Dim rs As Object = rdc.ExecuteCommand("insert_animal", Array(Name, rdc.ImageToBytes(Img)))
	Wait For (rs) Complete (Result As RDCResult)
	If Result.Success Then
		Log("inserted successfully (1)")
	Else
		Log(Result.ErrorMessage)
	End If
End Sub

Private Sub InsertBatch
	Dim commands As List = B4XCollections.CreateList(Null)
	commands.Add(rdc.CreateRDCCommand("insert_animal", Array("aaa", Null)))
	commands.Add(rdc.CreateRDCCommand("insert_animal", Array("bbb", Null)))
	commands.Add(rdc.CreateRDCCommand("insert_animal", Array("ccc", Null)))
	Wait For (rdc.ExecuteBatch(commands)) Complete (Result As RDCResult)
	If Result.Success Then
		Log("inserted successfully (3)")
	Else
		Log(Result.ErrorMessage)
	End If
End Sub