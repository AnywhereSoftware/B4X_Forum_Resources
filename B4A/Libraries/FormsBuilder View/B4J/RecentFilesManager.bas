B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.31
@EndOfDesignText@
'version 1.01
#Event: Click (RecentFile As String)
Sub Class_Globals
	Private RecentFiles As B4XOrderedMap
	Private xui As XUI
	Private const RecentFilesListFile As String = "RecentFiles.txt"
	Private mFilesMenu As Menu
	Private const RecentFileTag As String = "RecentFile"
	Public MaxFiles As Int = 5
	Private mCallback As Object
	Private mEventName As String
End Sub

Public Sub Initialize (Callback As Object, EventName As String, FilesMenu As Menu)
	mCallback = Callback
	mEventName = EventName
	RecentFiles = B4XCollections.CreateOrderedMap
	mFilesMenu = FilesMenu
	If File.Exists(xui.DefaultFolder, RecentFilesListFile) Then
		For Each f As String In File.ReadList(xui.DefaultFolder, RecentFilesListFile)
			If File.Exists(f, "") Then RecentFiles.Put(File.GetName(f), f)
		Next
		RecentFiles.Remove("")
	End If
	UpdateRecentList
End Sub

Private Sub UpdateRecentList
	For i = mFilesMenu.MenuItems.Size - 1 To 0 Step -1
		Dim m As MenuItem = mFilesMenu.MenuItems.Get(i)
		If m.Tag <> Null And m.Tag = RecentFileTag Then
			mFilesMenu.MenuItems.RemoveAt(i)
		End If
	Next
	If RecentFiles.Size > 0 Then
		Dim joSepMi As JavaObject
		Dim sep As MenuItem = joSepMi.InitializeNewInstance("javafx.scene.control.SeparatorMenuItem", Null)
		sep.Tag = RecentFileTag
		mFilesMenu.MenuItems.Add(sep)
		Dim keys As List = RecentFiles.Keys
		For i = keys.Size - 1 To 0 Step -1
			Dim f As String = keys.Get(i)
			Dim m As MenuItem
			m.Initialize(File.GetName(f), "mnuRecentFile")
			m.Tag = RecentFileTag
			mFilesMenu.MenuItems.Add(m)
		Next
	End If
End Sub

Private Sub mnuRecentFile_Action
	Dim mi As MenuItem = Sender
	Dim f As String = RecentFiles.GetDefault(mi.Text, "")
	If f = "" Then Return
	CallSub2(mCallback, mEventName & "_Click", f)
End Sub

Public Sub AddFile (FullPath As String)
	If FullPath = "" Then Return
	Dim name As String = File.GetName(FullPath)
	RecentFiles.Remove(name)
	RecentFiles.Put(name, FullPath)
	Do While RecentFiles.Size > MaxFiles
		RecentFiles.Remove(RecentFiles.Keys.Get(0))		
	Loop
	UpdateRecentList
End Sub

Public Sub SaveList
	Dim files As List
	files.Initialize
	For Each k As String In RecentFiles.Keys
		files.Add(RecentFiles.Get(k))
	Next
	File.WriteList(xui.DefaultFolder, RecentFilesListFile, files)
End Sub