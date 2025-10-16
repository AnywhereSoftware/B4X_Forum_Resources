B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=13.4
@EndOfDesignText@
'DBCalls Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	Private SQL As SQL
	Private Folder As String = File.DirInternal
	Private DBName As String = "users.sqlite"
End Sub

' --- Initialize DB ---
Public Sub InitializeDB
	'File.Delete(Folder,DBName)		'uncomment if wanting to start with new data
	Dim found As Boolean = File.Exists(Folder,DBName)
	If Not(found) Then
		File.Copy(File.DirAssets,DBName,Folder,DBName)
	End If
	SQL.Initialize(Folder,DBName,False)
	'if admin user not found, add it.
	CreateDefaultAdmin
	'add regular user (comment out after first app run)
	CreateDefaultUser
End Sub

Private Sub CreateDefaultAdmin
	Dim query As String = "SELECT id FROM users WHERE is_admin=1"
	
	Try
		Dim rs As ResultSet = SQL.ExecQuery(query)
		If Not(rs.NextRow) Then
			' No admin found, create default admin
			InsertUser("admin","admin123!","admin@example.com",True)
		End If
		rs.Close		
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub CreateDefaultUser
	Dim query As String = "SELECT id FROM users WHERE username=?"
	Dim args() As Object = Array As String("myname")
	
	Try
		Dim rs As ResultSet = SQL.ExecQuery2(query,args)
		If Not(rs.NextRow) Then
			'insert a regular user (non-admin) for demonstration
			InsertUser("myname","myname","myname@email.com",False)			
		End If
		rs.Close		
	Catch
		Log(LastException)
	End Try
End Sub

' --- Insert new user ---
Public Sub InsertUser(username As String,password As String,email As String,isAdmin As Boolean)
	Dim query As String = "INSERT INTO users (username,password,email,is_admin) VALUES (?,?,?,?)"
	Dim args() As Object = Array As String(username,password,email,IIf(isAdmin,1,0))
	
	Try
		SQL.ExecNonQuery2(query,args)
	Catch
		Log(LastException)
	End Try
End Sub

' --- Update user ---
Public Sub UpdateUser(id As Int, username As String, password As String,email As String)
	Dim query As String = "UPDATE users SET username=?, password=?, email=? WHERE id=?"
	Dim args() As Object = Array As String(username,password,email,id)
	
	Try
		SQL.ExecNonQuery2(query,args)
	Catch
		Log(LastException)
	End Try
End Sub

' --- Delete user ---
Public Sub DeleteUser(id As Int)
	Dim query As String = "DELETE FROM users WHERE id=?"
	Dim args() As Object = Array As String(id)
	
	Try
		SQL.ExecNonQuery2(query,args)
	Catch
		Log(LastException)
	End Try
End Sub

' --- Get all users ---
Public Sub GetAllUsers As List
	Dim query As String = "SELECT id, username,email,is_admin FROM users ORDER BY username"
	Dim users As List
	users.Initialize
	
	Try
		Dim rs As ResultSet = SQL.ExecQuery(query)
		Do While rs.NextRow
			Dim u As Map
			u.Initialize
			u.Put("id", rs.GetInt("id"))
			u.Put("username", rs.GetString("username"))
			u.Put("email",rs.GetString("email"))
			u.Put("is_admin", rs.GetInt("is_admin") = 1)
			users.Add(u)
		Loop
		rs.Close		
	Catch
		Log(LastException)
	End Try
	Return users
End Sub

' --- Get user by ID ---
Public Sub GetUserById(id As Int) As List
	Dim query As String = "SELECT id, username, password, email, is_admin FROM users WHERE id=?"
	Dim args() As Object = Array As String(id)
	Dim user As List
	user.Initialize
	
	Try
		Dim rs As ResultSet = SQL.ExecQuery2(query,args)
		Do While rs.NextRow
			Dim u As Map
			u.Initialize			
			u.Put("id", rs.GetInt("id"))
			u.Put("username", rs.GetString("username"))
			u.Put("password", rs.GetString("password"))
			u.Put("email", rs.GetString("email"))
			u.Put("is_admin", rs.GetInt("is_admin") = 1)
			user.Add(u)
		Loop
		rs.Close		
	Catch
		Log(LastException)
	End Try
	Return user
End Sub


' --- Get user by username/password ---
Public Sub GetUserByName(uname As String, pw As String) As Map
	Dim query As String = "SELECT id,username,is_admin FROM users WHERE username=? AND password=?"
	Dim args() As Object = Array As String(uname,pw)
	
	Try
		Dim rs As ResultSet = SQL.ExecQuery2(query,args)
		Dim u As Map
		u.Initialize
		If rs.NextRow Then
			u.Put("id", rs.GetInt("id"))
			u.Put("username", rs.GetString("username"))
			u.Put("is_admin", rs.GetInt("is_admin") = 1)
		End If
		rs.Close		
	Catch
		Log(LastException)
	End Try
	Return u
End Sub

' --- Get user by email ---
Public Sub GetUserByEmail(email As String) As Map
	Dim query As String = "SELECT id,username,reset_code,reset_time FROM users WHERE email=?"
	Dim args() As Object = Array As String(email)
	
	Try
		Dim rs As ResultSet = SQL.ExecQuery2(query,args)
		Dim u As Map
		u.Initialize
		If rs.NextRow Then
			u.Put("id", rs.GetInt("id"))
			u.Put("username", rs.GetString("username"))
			u.Put("reset_code", rs.GetString("reset_code"))
			u.Put("reset_time", rs.GetLong("reset_time"))
		End If
		rs.Close		
	Catch
		Log(LastException)
	End Try
	Return u
End Sub

' --- Set reset code and timestamp ---
Public Sub SetResetCode(uid As Int, code As String, timestamp As Long)
	Dim query As String = "UPDATE users SET reset_code=?, reset_time=? WHERE id=?"
	Dim args() As Object = Array As String(code, timestamp, uid)
	
	Try
		SQL.ExecNonQuery2(query,args)
	Catch
		Log(LastException)
	End Try
End Sub

' --- Update password by user id ---
Public Sub UpdatePassword(uid As Int, newpass As String)
	Dim query As String = "UPDATE users SET password=? WHERE id=?"
	Dim args() As Object = Array As String(newpass, uid)
	
	Try
		SQL.ExecNonQuery2(query,args)
	Catch
		Log(LastException)
	End Try
End Sub




