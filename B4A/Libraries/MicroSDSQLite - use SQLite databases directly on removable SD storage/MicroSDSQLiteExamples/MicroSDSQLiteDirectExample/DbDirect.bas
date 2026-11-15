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
End Sub

Public Sub Initialize
    If HubReady Then Return
    Store.Initialize("Store")
    HubReady = True
End Sub

Public Sub RunDemo As String
    Initialize

    Dim dbDir As String = Store.ResolveRemovableSubDir("MicroSDSQLiteDirectExample")
    If dbDir = "" Then Return "No mounted removable storage folder was found for this app."

    If Store.EnsureDirectory(dbDir) = False Then
        Return "Could not create the Direct Mode folder: " & Store.LastError
    End If

    If Store.OpenDatabase(SQL1, dbDir, "direct-example.db", True) = False Then
        Return "Direct Mode open failed: " & Store.LastError
    End If

    Try
        SQL1.ExecNonQuery("CREATE TABLE IF NOT EXISTS notes (id INTEGER PRIMARY KEY AUTOINCREMENT, body TEXT NOT NULL, created_at INTEGER NOT NULL)")
        SQL1.ExecNonQuery2("INSERT INTO notes(body, created_at) VALUES (?, ?)", Array As Object("Hello from Direct Mode", DateTime.Now))

        Dim count As String = SQL1.ExecQuerySingleResult("SELECT COUNT(*) FROM notes")
        Dim dbPath As String = Store.CombinePath(dbDir, "direct-example.db")
        Store.CloseDatabase(SQL1, True)

        Return "Direct Mode worked." & CRLF & "Rows in notes: " & count & CRLF & "Database path: " & dbPath
    Catch
        Dim msg As String = LastException.Message
        CloseQuietly
        Return "Direct Mode failed: " & msg
    End Try
End Sub

Private Sub CloseQuietly
    If Store.HasOpenDatabase Then Store.CloseDatabase(SQL1, False)
End Sub

Private Sub Store_Error (Operation As String, Message As String)
    Log("MicroSDSQLite error in " & Operation & ": " & Message)
End Sub
