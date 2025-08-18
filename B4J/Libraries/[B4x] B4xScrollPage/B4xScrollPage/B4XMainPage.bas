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


'github desktop ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=github&Args=..\..\

'B4A ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4A\B4xScrollPage.b4a
'B4J ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4J\B4xScrollPage.b4j


	'Added example of saving page data

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI


	Private AppName As String = "B4xScrollPAge-Demo"
	
	'B4xScrollPage1
	Private B4xScrollPage1 As B4xScrollPage
	Private CLV As CustomListView
	Type DataType(Text As Object, Value As Object)
	Dim SP1Data As List
	
	'B4xscrollPage2
	Private B4xScrollPage2 As B4xScrollPage
	Private TextArea1 As B4XView
		
	'B4xscrollPage3
	Type FileDataType(FilePath As String, Filename As String)
	Dim CurrentFileData As FileDataType
	Dim CurrentFileText As String
	Private B4xScrollPage3 As B4xScrollPage
	Private B4XImageView1 As B4XImageView
	Private btnSave As B4XView
	Dim SP3Data As List
	Private pnSaveBG As B4XView
	
	Private SettingData As Boolean
End Sub

Public Sub Initialize
		
		xui.SetDataFolder(AppName)
		
		If File.Exists(xui.DefaultFolder,"Page1.txt") = False Then
			File.Copy(File.DirAssets,"Page1.txt",xui.DefaultFolder,"Page1.txt")
			File.Copy(File.DirAssets,"Page2.txt",xui.DefaultFolder,"Page2.txt")
			File.Copy(File.DirAssets,"Page3.txt",xui.DefaultFolder,"Page3.txt")
			File.Copy(File.DirAssets,"Page4.txt",xui.DefaultFolder,"Page4.txt")
			File.Copy(File.DirAssets,"Page5.txt",xui.DefaultFolder,"Page5.txt")
		End If
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.GetManager.SetTitle(Me,"B4xScrollPage")
	
	'Required because B4xScrollpage loads a layout
	#If b4a or b4i
	Sleep(0)
	#end if
	
	'CustomListView
	SetB4xScrollPage1
	
	'Text View
	SetB4xScrollPage2
	
	'Image View
	SetB4xScrollPage3
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


#Region B4xScrollPage1
Private Sub SetB4xScrollPage1
	'B4x CustomListview

	'Required call
	B4xScrollPage1.pnContent.LoadLayout("Content1")
	
	Dim DataList As List
	DataList.Initialize
	SP1Data.Initialize
	
	For i = 0 To 4
		Dim DataList As List
		DataList.Initialize
		For j = 0 To 99
			Dim Data1 As DataType = CreateDataType($"Page ${i+1} Item ${j + 1}"$ ,(i+1)*100+j + 1)
			DataList.Add(Data1)
		Next
		SP1Data.Add(DataList)
	Next
	
	
	'Required Call
	B4xScrollPage1.setPageCount(SP1Data.Size,0)
	
	B4xScrollPage1.RepeatTime = 105
	
End Sub

'B4xScrollPage Required sub
Private Sub B4xScrollPage1_SetPageData(Index As Int)
	CLV.Clear
	Dim DataList As List = SP1Data.Get(Index)
	For Each DT As DataType In DataList
		CLV.AddTextItem(DT.Text, DT.Value)
	Next
	CLV.ScrollToItem(0)
End Sub

Private Sub CLV_ItemClick (Index As Int, Value As Object)
	Log("Item Selected " & Value)
End Sub

#End Region B4xScrollPage1





#Region B4xScrollPage2

Private Sub SetB4xScrollPage2
	
	'Required call
	B4xScrollPage2.pnContent.LoadLayout("Content2")
	
	
	'Required Call
	B4xScrollPage2.setPageCount(5,0)
	
	B4xScrollPage2.RepeatTime = 125
	
End Sub


Private Sub B4xScrollPage2_SetPageData(Index As Int)
	SettingData = True
	Dim FileName As String = "Page" & (Index + 1) & ".txt"
	Dim Text As String = File.ReadString(xui.DefaultFolder,FileName)
	TextArea1.Text = Text
	CurrentFileText = Text
	CurrentFileData = CreateFileDataType(xui.DefaultFolder,FileName)
	SettingData = False
End Sub

Private Sub TextArea1_TextChanged (Old As String, New As String)
	If SettingData Then Return
	If New = CurrentFileText Then
		#if b4j
		B4xScrollPage2.B4XPlusMinus1.mBase.Enabled = True
		#End If
		#if B4a or B4i
		B4xScrollPage2.B4XPlusMinus1.mBase.Enabled = True
		B4xScrollPage2.B4XPlusMinus1.lblMinus.Enabled = True
		B4xScrollPage2.B4XPlusMinus1.lblPlus.Enabled = True
		#End If
		btnSave.Enabled = False
		pnSaveBG.Color = xui.Color_Transparent
	Else
		#if B4j
		B4xScrollPage2.B4XPlusMinus1.mBase.Enabled = False
		#End If
		#if B4a or B4i
		B4xScrollPage2.B4XPlusMinus1.mBase.Enabled = False
		B4xScrollPage2.B4XPlusMinus1.lblMinus.Enabled = False
		B4xScrollPage2.B4XPlusMinus1.lblPlus.Enabled = False
		#End If
		btnSave.Enabled = True
		pnSaveBG.Color = xui.Color_Red
	End If
End Sub

Sub btnSave_Click
	File.WriteString(CurrentFileData.FilePath,CurrentFileData.Filename,TextArea1.Text)
	CurrentFileText = TextArea1.Text
	#If B4j
	B4xScrollPage2.B4XPlusMinus1.mBase.Enabled = True
	#end If
	#if b4a or B4i
	B4xScrollPage2.B4XPlusMinus1.mBase.Enabled = True
	B4xScrollPage2.B4XPlusMinus1.lblMinus.Enabled = True
	B4xScrollPage2.B4XPlusMinus1.lblPlus.Enabled = True
		#End If
	btnSave.Enabled = False
	pnSaveBG.Color = xui.Color_Transparent
End Sub


#End Region B4xScrollPage2





#Region B4xScrollPage3

Private Sub SetB4xScrollPage3
	'Required call
	B4xScrollPage3.pnContent.LoadLayout("Content3")
	
	SP3Data.Initialize
	
	SP3Data.Add(CreateFileDataType(File.DirAssets,"Image1.gif"))
	SP3Data.Add(CreateFileDataType(File.DirAssets,"Image2.gif"))
	SP3Data.Add(CreateFileDataType(File.DirAssets,"Image3.gif"))
	SP3Data.Add(CreateFileDataType(File.DirAssets,"Image4.gif"))
	SP3Data.Add(CreateFileDataType(File.DirAssets,"Image5.gif"))
	
	
	'Required Call
'	B4xScrollPage3.setPageCount(5,0)
	B4xScrollPage3.SetPageNames(Array As String("Pic1","Pic2","Pic3","Pic4","Pic5"),0)
	
	B4xScrollPage3.RepeatTime = 500
	
End Sub

Private Sub B4xScrollPage3_SetPageData(Index As Int)
	Dim FDT As FileDataType = SP3Data.Get(Index)
	B4XImageView1.Load(FDT.FilePath,FDT.Filename)
	
End Sub

#End Region B4xScrollPage3

Public Sub CreateDataType (Text As Object, Value As Object) As DataType
	Dim t1 As DataType
	t1.Initialize
	t1.Text = Text
	t1.Value = Value
	Return t1
End Sub



Public Sub CreateFileDataType (FilePath As String, Filename As String) As FileDataType
	Dim t1 As FileDataType
	t1.Initialize
	t1.FilePath = FilePath
	t1.Filename = Filename
	Return t1
End Sub

