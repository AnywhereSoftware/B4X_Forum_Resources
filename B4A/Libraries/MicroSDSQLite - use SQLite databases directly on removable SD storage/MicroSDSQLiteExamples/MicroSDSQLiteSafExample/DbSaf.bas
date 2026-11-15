B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=13.4
@EndOfDesignText@
#Region  Code module attributes
    #IgnoreWarnings: 12
#End Region

Sub Process_Globals
    Public SQL1 As SQL
    Public Store As MicroSDSQLite
    Private HubReady As Boolean
    Private SafUriFile As String = "microsdsqlite_saf_uri.txt"
    Private SafDbRelativePath As String = "MicroSDSQLiteSafExample/saf-example.db"
End Sub

Public Sub Initialize
    If HubReady Then Return
    Store.Initialize("Store")
    HubReady = True
End Sub

Public Sub StartDemo As String
    Initialize

    If File.Exists(File.DirInternal, SafUriFile) Then
        If Store.SetSafFolderUri(File.ReadString(File.DirInternal, SafUriFile)) = False Then
            Return "Saved SAF folder could not be used: " & Store.LastError
        End If
        If Store.HasSafFolderPermission Then Return RunDemo
    End If

    Store.PickSafFolder
    Return "Android folder picker opened. Choose an allowed SD-card folder. Do not choose the SD-card root."
End Sub

Private Sub Store_SafFolderSelected(Success As Boolean, FolderUri As String)
    If Success = False Then
        Notify("SAF folder was not selected: " & Store.LastError)
        Return
    End If

    File.WriteString(File.DirInternal, SafUriFile, FolderUri)

    If Store.SetSafFolderUri(FolderUri) = False Then
        Notify("Selected SAF folder could not be used: " & Store.LastError)
        Return
    End If

    Notify(RunDemo)
End Sub

Private Sub RunDemo As String
    If Store.OpenSafDatabaseAtRelativePath(SQL1, SafDbRelativePath, True) = False Then
        Return "SAF Mode open failed: " & Store.LastError
    End If

    Try
        SQL1.ExecNonQuery("CREATE TABLE IF NOT EXISTS notes (id INTEGER PRIMARY KEY AUTOINCREMENT, body TEXT NOT NULL, created_at INTEGER NOT NULL)")
        SQL1.ExecNonQuery2("INSERT INTO notes(body, created_at) VALUES (?, ?)", Array As Object("Hello from SAF Mode", DateTime.Now))

        Dim count As String = SQL1.ExecQuerySingleResult("SELECT COUNT(*) FROM notes")
        Dim fdPath As String = Store.SafFdPath
        Store.CloseSafDatabase(SQL1)

        Return "SAF Mode worked." & CRLF & "Rows in notes: " & count & CRLF & "SQLite opened: " & fdPath
    Catch
        Dim msg As String = LastException.Message
        CloseQuietly
        Return "SAF Mode failed: " & msg
    End Try
End Sub

Private Sub CloseQuietly
    If Store.HasOpenSafDatabase Then Store.CloseSafDatabase(SQL1)
End Sub

Private Sub Notify(Message As String)
    Log(Message)
    CallSubDelayed2(Main, "DbSaf_Message", Message)
End Sub

Private Sub Store_Error (Operation As String, Message As String)
    Notify("MicroSDSQLite error in " & Operation & ": " & Message)
End Sub
