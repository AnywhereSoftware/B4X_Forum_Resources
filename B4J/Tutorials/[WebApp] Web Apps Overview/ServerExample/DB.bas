B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=2.18
@EndOfDesignText@

Sub Process_Globals
	Public pool As ConnectionPool
End Sub

Public Sub init
	Dim JdbcUrl As String = Main.settings.Get("JdbcUrl")
	Dim driverClass As String = Main.settings.Get("DriverClass")
	Dim dbuser As String = Main.settings.Get("DBUser")
	Dim dbpassword As String = Main.settings.Get("DBPassword")
	pool.Initialize(driverClass, JdbcUrl, dbuser, dbpassword)
End Sub

Public Sub CreateUserTableIfNeeded
	Dim sql1 As SQL = pool.GetConnection
	If sql1.ExecQuerySingleResult("SELECT count(*) FROM information_schema.tables WHERE table_name = 'b4j_users'") = 0 Then
		Dim ct As String = "CREATE TABLE `b4j_users` (`name` VARCHAR(50) PRIMARY KEY, " _ 
			 & " `hash` BLOB, `salt` BLOB)"
		sql1.ExecNonQuery(ct)
	End If
	sql1.Close
End Sub

Public Sub CheckUserExist (name As String) As Boolean
	Dim sq As SQL = pool.GetConnection
	Dim count As Int = sq.ExecQuerySingleResult2("SELECT count(name) FROM b4j_users WHERE name = ? COLLATE utf8_unicode_ci", _
		Array As String(name))
	sq.Close
	Return count > 0
End Sub

Public Sub CheckCredentials(User As String, Password As String) As Boolean
	Dim sq As SQL = pool.GetConnection
	Dim rs As ResultSet = sq.ExecQuery2("SELECT hash, salt FROM b4j_users WHERE name = ? COLLATE utf8_unicode_ci", _
		Array As Object(User))
	Dim res As Boolean = False
	If rs.NextRow Then
		Dim hash() As Byte = CalcHash(Password, rs.GetBlob("salt"))
		Dim storedHash() As Byte = rs.GetBlob("hash")
		If hash.Length = storedHash.Length Then
			res = True
			For i = 0 To hash.Length - 1
				If hash(i) <> storedHash(i) Then
					res = False
					Exit
				End If
			Next
		End If
	End If
	rs.Close
	sq.Close
	Return res
End Sub

Public Sub AddUser(User As String, Password As String)
	Dim salt(48) As Byte
	Dim sr As SecureRandom
	sr.GetRandomBytes(salt)
	Dim hash() As Byte = CalcHash(Password, salt)
	Dim sq As SQL = pool.GetConnection
	sq.ExecNonQuery2("INSERT INTO b4j_users VALUES (?, ?, ?)", _
		Array As Object(User, hash, salt))
	sq.Close
End Sub

Public Sub CalcHash(Password As String, salt() As Byte) As Byte() 
	Dim md As MessageDigest
	Dim spassword() As Byte = md.GetMessageDigest(Password.GetBytes("UTF8"), "SHA-512")
	Dim pbAndSalt(spassword.Length + salt.Length) As Byte
	Dim bc As ByteConverter
	bc.ArrayCopy(spassword, 0, pbAndSalt, 0, spassword.Length)
	bc.ArrayCopy(salt, 0, pbAndSalt, spassword.Length, salt.Length)
	Return md.GetMessageDigest(pbAndSalt, "SHA-512")
End Sub