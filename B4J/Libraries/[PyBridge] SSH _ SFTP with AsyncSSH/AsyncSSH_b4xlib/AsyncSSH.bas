B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
	Private Py As PyBridge
	Private mCallback As Object 'ignore
	Private mEventName As String 'ignore
	Public mSsh, mSFTP, mConn As PyWrapper
End Sub


Public Sub Initialize (Callback As Object, EventName As String, Bridge As PyBridge)
	mCallback = Callback
	mEventName = EventName
	Py = Bridge
	mSsh = Py.ImportModule("asyncssh")
End Sub

'Connects to the SSH server, without verifying the host.
'Host - Host address.
'Port - Listening port. Default is 22.
'Username / Password - user credentials.
Public Sub ConnectSkipHostsCheck(Host As String, Port As Int, Username As String, Password As String) As ResumableSub
	Wait For (Connect(Host, Port, Username, Password, Null)) Complete (Result As PyWrapper)
	Return Result
End Sub

'Connects to the SSH server and verifies that the host signature is known.
'Host - Host address.
'Port - Listening port. Default is 22.
'Username / Password - user credentials.
'KnownHosts - Path to the known_hosts file.
Public Sub Connect (Host As String, Port As Int, Username As String, Password As String, KnownHosts As Object) As ResumableSub
	Wait For (mSsh.RunAwait("connect", Array(Host), CreateMap("username": Username, "password": Password, _
		"known_hosts": KnownHosts, "port": Port))) Complete (Conn As PyWrapper)
	If Conn.IsSuccess Then
		mConn = Conn
		Wait For (StartSFTPClient(mConn)) Complete (SFTP As PyWrapper)
		If SFTP.IsSuccess Then
			mSFTP = SFTP
		End If
		Return SFTP
	End If
	Return Conn
End Sub

'Run a command on the remote system and collect its output. Result.Value is a Map that holds the process completion state.
'It includes the following keys: stdout, stderr and exit_status.
'Command - terminal command.
'TimeoutMs - Process timeout. Pass 0 to wait indefinitely. Result.IsSuccess will be False if the timeout reached.
Public Sub RunCommand (Command As String, TimeoutMs As Long) As ResumableSub
	Dim args As Map = CreateMap()
	If TimeoutMs > 0 Then args.Put("timeout", TimeoutMs / 1000)
	Wait For (mConn.RunAwait("run", Array(Command), args)) Complete (Result As PyWrapper)
	Wait For (ObjectToDict(Result, Array("stdout", "stderr", "exit_status")).Fetch) Complete (Result As PyWrapper)
	Return Result
End Sub

Private Sub ObjectToDict (Obj As PyWrapper, Fields As List) As PyWrapper
	Dim entries As List = B4XCollections.CreateList(Null)
	For Each key As String In Fields
		entries.Add(Array(key, Obj.GetField(key)))
	Next
	Return Py.Builtins.Run("dict").Arg(entries)
End Sub

'SFTPClient docs: https://asyncssh.readthedocs.io/en/stable/api.html#asyncssh.SFTPClient
Private Sub StartSFTPClient (Conn As PyWrapper) As ResumableSub
	Wait For (Conn.RunAwait("start_sftp_client", Null, Null)) Complete (Result As PyWrapper)
	Return Result
End Sub

'Downloads one or more files. Check Result.IsSuccess to determine whether the operation was successful.
'RemotePath - Remote file or folder or list of files.
'LocalDir - Local destination folder.
'Recurse - Whether to download subfolders. Relevant when RemotePath points to a folder.
Public Sub SFTPGet(RemotePath As Object, LocalDir As String, Recurse As Boolean) As ResumableSub
	Dim rs As Object = mSFTP.RunAwait("get", Array(RemotePath, LocalDir), CreateMap("recurse": Recurse))
	Wait For (rs) Complete (Result As PyWrapper)
	Return Result
End Sub

'Uploads one or more files. Check Result.IsSuccess to determine whether the operation was successful.
'LocalPath - Local file or folder or list of files.
'RemotePath - Remote destination folder.
'Recurse - Whether to upload subfolders. Relevant when LocalPath points to a folder.
Public Sub SFTPPut(LocalPath As Object, RemotePath As String, Recurse As Boolean) As ResumableSub
	Dim rs As Object = mSFTP.RunAwait("put", Array(LocalPath, RemotePath), CreateMap("recurse": Recurse))
	Wait For (rs) Complete (Result As PyWrapper)
	Return Result
End Sub

'Tests whether the remote path exists. Result.Value is a boolean flag.
Public Sub SFTPExists(RemotePath As Object) As ResumableSub
	Wait For (mSFTP.RunAwait("exists", Array(RemotePath), Null)) Complete (Result As PyWrapper)
	Return Result
End Sub

'Deletes the remote path. Check Result.IsSuccess to determine whether the operation was successful.
Public Sub SFTPRemove(RemotePath As Object) As ResumableSub
	Wait For (mSFTP.RunAwait("remove", Array(RemotePath), Null)) Complete (Result As PyWrapper)
	Return Result
End Sub

'Lists the entries in the remote path. Remote.Value is a list of Maps. Each Map includes the following keys:
'name, size, mtime (modified time) and folder (True if folder).
Public Sub SFTPList(RemotePath As String) As ResumableSub
	Wait For (mSFTP.RunAwait("readdir", Array(RemotePath), Null)) Complete (Result As PyWrapper)
	If Result.IsSuccess Then
		Result = Py.Map_(Py.Lambda($"name: {'name': name.filename, 'size': name.attrs.size, 'mtime': int(name.attrs.mtime * 1000),
				"folder": name.attrs.type == 2}"$), Result).ToList
		Wait For (Result.Fetch) Complete (Result As PyWrapper)
	End If
	Return Result
End Sub

'Creates a folder. Check Result.IsSuccess to determine whether the operation was successful.
Public Sub SFTPMkDir(RemotePath As String) As ResumableSub
	Wait For (mSFTP.RunAwait("mkdir", Array(RemotePath), Null)) Complete (Result As PyWrapper)
	Return Result
End Sub

'Recursively deletes a directory tree.
'Check Result.IsSuccess to determine whether the operation was successful.
'RemotePath - Folder to delete.
'VerifyToken - Pass 10 otherwise the method does nothing. This is a security measure to prevent misuse.
Public Sub SFTPRemoveTree(RemotePath As String, VerifyToken As Int) As ResumableSub
	If VerifyToken <> 10 Then
		Log("Read docs")
		Return Null
	End If
	Wait For (mSFTP.RunAwait("rmtree", Array(RemotePath), Null)) Complete (Result As PyWrapper)
	Return Result
End Sub
'Removes a folder. Folder must be empty. Check Result.IsSuccess to determine whether the operation was successful.
Public Sub SFTPRmDir(RemotePath As String) As ResumableSub
	Wait For (mSFTP.RunAwait("rmdir", Array(RemotePath), Null)) Complete (Result As PyWrapper)
	Return Result
End Sub

Private Sub CloseSFTPClient As ResumableSub
	mSFTP.Run("exit")
	Wait For (mSFTP.RunAwait("wait_closed", Null, Null)) Complete (Result As PyWrapper)
	Return Result
End Sub

'Closes the connection.
Public Sub CloseConnection As ResumableSub
	If mSFTP.IsInitialized Then
		Wait For (CloseSFTPClient) Complete (Result As PyWrapper)
	End If
	mConn.Run("close")
	Wait For (mConn.RunAwait("wait_closed", Null, Null)) Complete (Result As PyWrapper)
	Return Result
End Sub