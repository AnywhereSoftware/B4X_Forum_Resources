Type=Class
Version=2.2
B4J=true
@EndOfDesignText@
'KeyValueStore: v1.01
Sub Class_Globals
	Private sql1 As SQL
	Private tempFolder = File.DirTemp, tempFile = "key_value_temp.dat" As String
End Sub

'Initializes the store and sets the store file.
Public Sub Initialize (Dir As String, FileName As String)
	If sql1.IsInitialized Then sql1.Close
	sql1.InitializeSQLite(Dir, FileName, True)
	CreateTable
End Sub

'Puts a simple value in the store.
'Strings, number types and booleans are considered "simple" values.
Public Sub PutSimple(Key As String, Value As Object) As Boolean
	Try
		start(Key)
		insertQuery(Key, Value)
		Return complete(True)
	Catch
		Return complete(False)
	End Try
End Sub

'Puts an object in the store. This method uses RandomAccessFile.WriteObject to save the object in the store.
'It is capable of writing the following types of objects: Lists, Arrays, Maps, Strings, primitive types and user defined types.
'Combinations of these types are also supported. For example, a Map with several lists of arrays can be written.
'The element type inside a collection must be a String OR primitive Type.
Public Sub PutObject(Key As String, Value As Object) As Boolean
	Return putObjectInternal(Key, Value, False, "")
End Sub

'Similar to PutObject. Encrypts the object before writing it. Note that you can use it to store "simple" types as well.
Public Sub PutEncyptedObject(Key As String, Value As Object, Password As String) As Boolean
	Return putObjectInternal(Key, Value, True, Password)
End Sub

'Puts a bitmap in the store.
Public Sub PutBitmap(Key As String, Value As Image) As Boolean
	Try
		start(Key)
		Dim out As OutputStream
		out.InitializeToBytesArray(100)
		Dim b As Image = Value
		b.WriteToStream(out)
		insertQuery(Key, out.ToBytesArray)
		out.Close
		Return complete(True)
	Catch
		Return complete(False)
	End Try
End Sub

'Reads the data from the input stream and saves it in the store.
Public Sub PutInputStream(Key As String, Value As InputStream) As Boolean
	Try
		start(Key)
		Dim out As OutputStream
		out.InitializeToBytesArray(100)
		File.Copy2(Value, out)
		Value.Close
		insertQuery(Key, out.ToBytesArray)
		out.Close
		Return complete(True)
	Catch
		Return complete(False)
	End Try
End Sub

'Removes the key and value mapped to this key.
Public Sub Remove(Key As String)
	sql1.ExecNonQuery2("DELETE FROM main WHERE key = ?", Array As Object(Key))
End Sub

'Returns a list with all the keys.
Public Sub ListKeys As List
	Dim c As ResultSet = sql1.ExecQuery("SELECT key FROM main")
	Dim res As List
	res.Initialize
	Do While c.NextRow
		res.Add(c.GetString2(0))
	Loop
	Return res
End Sub

'Tests whether a key is available in the store.
Public Sub ContainsKey(Key As String) As Boolean
	Return sql1.ExecQuerySingleResult2("SELECT count(key) FROM main WHERE key = ?", _
		Array As String(Key)) > 0
End Sub

'Deletes all data from the store.
Public Sub DeleteAll
	sql1.ExecNonQuery("DROP TABLE main")
	CreateTable
End Sub

'Returns a "simple" value. See PutSimple.
Public Sub GetSimple(Key As String) As String
	Dim c As ResultSet = getCursor(Key)
	If c.NextRow = False Then
		c.Close
		Return ""
	End If
	Dim res As String = c.GetString2(0)
	c.Close
	Return res
End Sub

'Returns an InputStream from the store. See PutInputStream.
Public Sub GetInputStream(Key As String) As InputStream
	Dim c As ResultSet = getCursor(Key)
	If c.NextRow = False Then 
		c.Close
		Return Null
	End If
	Dim buffer() As Byte = c.GetBlob2(0)
	Dim In As InputStream
	In.InitializeFromBytesArray(buffer, 0, buffer.Length)
	c.Close
	Return In
End Sub

'Returns a bitmap from the store. See PutBitmap.
Public Sub GetBitmap(Key As String) As Image
	Dim c As ResultSet = getCursor(Key)
	Dim b As Image
	If c.NextRow = False Then 
		c.Close
		Return b
	End If
	Dim buffer() As Byte = c.GetBlob2(0)
	Dim In As InputStream
	In.InitializeFromBytesArray(buffer, 0, buffer.Length)
	b.Initialize2(In)
	In.Close
	c.Close
	Return b
End Sub

'Returns an object from the store. See PutObject.
Public Sub GetObject(Key As String) As Object
	Return getObjectInternal(Key, False, "")
End Sub

'Returns an encrypted object from the store. See PutEncryptedObject.
Public Sub GetEncryptedObject(Key As String, Password As String) As Object
	Return getObjectInternal(Key, True, Password)
End Sub

'Closes the store.
Public Sub Close
	sql1.Close
End Sub

Private Sub getObjectInternal(Key As String, decrypt As Boolean, password As String) As Object
	Dim c As ResultSet = getCursor(Key)
	If c.NextRow = False Then
		c.Close
		Return Null
	End If
	Dim buffer() As Byte = c.GetBlob2(0)
	Dim raf As RandomAccessFile
	raf.Initialize3(buffer, False)
	Dim res As Object
	If decrypt Then
		res = raf.ReadEncryptedObject(password, raf.CurrentPosition)
	Else
		res = raf.ReadObject(raf.CurrentPosition)
	End If
	raf.Close
	c.Close
	Return res
End Sub

Private Sub getCursor(Key As String) As ResultSet
	Return sql1.ExecQuery2("SELECT value FROM main WHERE key = ?", Array As String(Key))
End Sub

Private Sub insertQuery(Key As String, Value As Object)
	sql1.ExecNonQuery2("INSERT INTO main VALUES(?, ?)", Array As Object(Key, Value))
End Sub

'creates the main table (if it does not exist)
Private Sub CreateTable
	sql1.ExecNonQuery("CREATE TABLE IF NOT EXISTS main(key TEXT PRIMARY KEY, value NONE)")
End Sub

Private Sub start (Key As String)
	sql1.BeginTransaction
	sql1.ExecNonQuery2("DELETE FROM main WHERE key = ?", Array As Object(Key))
End Sub

Private Sub complete(success As Boolean) As Boolean
	If success Then
		sql1.TransactionSuccessful
	Else
		Log("Error saving object: " & LastException)
		sql1.Rollback
	End If
	Return success
End Sub

Private Sub putObjectInternal(Key As String, Value As Object, encrypt As Boolean, password As String) As Boolean
	Try
		start(Key)
		Dim raf As RandomAccessFile
		File.Delete(tempFolder, tempFile)
		raf.Initialize(tempFolder, tempFile, False)
		If encrypt Then
			raf.WriteEncryptedObject(Value, password, raf.CurrentPosition)
		Else
			raf.WriteObject(Value, True, raf.CurrentPosition)
		End If
		raf.Flush
		Dim buffer(raf.CurrentPosition) As Byte
		raf.ReadBytes(buffer, 0, buffer.Length, 0)
		raf.Close
		insertQuery(Key, buffer)
		Return complete(True)
	Catch
		Return complete(False)
	End Try
End Sub


