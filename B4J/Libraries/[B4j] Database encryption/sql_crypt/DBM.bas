B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.9
@EndOfDesignText@
#IgnoreWarnings: 6,11,12
Sub Process_Globals
	Public sql As SQL
'	Private cp As HikariCP 'ignore
	Public isInlitialized As Boolean
	Private pool As ConnectionPool
	Private SQLite As SQL
	Public UsePool As Boolean
	Private nrbase As Int
	Public Error As String
	Public Er As Boolean
	Public crypt_column As List
	Private de As Crypter
'	Private phrase As String = "83mnS9oAwpnG72CV"
	Public debug As Boolean= False
End Sub


'Initialization of encryption and columns in the database
Sub InicjalizeCrypt(column As List, password As String, phrase  As String) 'ignore
	InitDe(phrase, password)
	crypt_column = column
End Sub


Sub InitializeSQLite(Dir As String, fileName As String, createIfNeeded As Boolean) 'ignore
	Log("init sqlite")
	SQLite.InitializeSQLite(Dir, fileName, createIfNeeded)
	UsePool = False
	nrbase=1
	SQLite.ExecNonQuery("PRAGMA journal_mode = wal")
End Sub


'Sub InicjalizeH2(filedatabase As String,password As String) 'ignore
'	Log("init H2")
'	Dim driver As String = "org.h2.Driver"
'	Dim url As String = $"jdbc:h2:${File.DirApp}\${filedatabase};CIPHER=AES"$
'	sql.Initialize2(driver,url,"user", password)
'	nrbase=3
'
'End Sub


'
Sub InitializeMySQL(jdbcUrl As String ,login As String, password As String, poolSize As Int) 'ignore
	Log("init mysql")
	UsePool = True
	Try
'		pool.Initialize("com.mysql.jdbc.Driver", jdbcUrl, login, password)
		pool.Initialize("org.mariadb.jdbc.Driver", jdbcUrl, login, password)
	Catch
		Log("Last Pool Init Except: "&LastException.Message)
	End Try

	' change pool size...
	Dim jo As JavaObject = pool
	jo.RunMethod("setMaxPoolSize", Array(poolSize))
	nrbase = 2
End Sub





Sub GetSQL() As SQL 'ignore
	Er=False
	Error = "No Error"

	Select nrbase
		Case 1:
			Return SQLite
		Case 2:
			Return pool.GetConnection
		Case 3:
'			Return cp.GetConnection
		Case 4:
			Return sql

	End Select
End Sub

Sub CloseSQL(mySQL As SQL) 'ignore
	If UsePool Then
		mySQL.Close
	End If
End Sub

'Sub GetSQL2() As SQL 'ignore
'	sql = cp.GetConnection
'End Sub
'
'Sub CloseSQL2(mySQL As SQL) 'ignore
'	cp.ClosePool
'End Sub


'slect from an array that does not contain encrypted columns
Sub SQLSelectClear(Query As String, Args As List) As List 'ignore

	Dim sql1 As SQL = GetSQL

	Dim l As List
	l.Initialize
	Dim cur As ResultSet
	Try
		cur = sql1.ExecQuery2(Query, Args)
	Catch
		If debug Then
			Log(LastException)
		End If
		Error = LastException
		Er = True
		Return l
	End Try
	Do While cur.NextRow
		Dim res As Map
		res.Initialize
		For i = 0 To cur.ColumnCount - 1
			If ChecCol(cur.GetColumnName(i).ToLowerCase) Then
				res.Put(cur.GetColumnName(i).ToLowerCase, cur.GetString2(i))
			Else
				res.Put(cur.GetColumnName(i).ToLowerCase, cur.GetString2(i))
			End If
		Next
		l.Add(res)
	Loop
	cur.Close

'	sql1.Close
'	cp.ClosePool
	Return l
End Sub

'results of all encrypted columns will be returned already as decrypted
Sub SQLSelect(Query As String, Args As List) As List 'ignore
'	sql=cp.GetConnection
	Dim sql1 As SQL = GetSQL

	Dim l As List
	l.Initialize
	Dim cur As ResultSet
	Try
		cur = sql1.ExecQuery2(Query, Args)
	Catch
		If debug Then
			Log(LastException)
		End If
		Error = LastException
		Er = True
		Return l
	End Try
	Do While cur.NextRow
		Dim res As Map
		res.Initialize
		For i = 0 To cur.ColumnCount - 1
			If ChecCol(cur.GetColumnName(i).ToLowerCase) Then
				res.Put(cur.GetColumnName(i).ToLowerCase, DecryptHash( cur.GetString2(i)))
			Else
				res.Put(cur.GetColumnName(i).ToLowerCase, cur.GetString2(i))
			End If
		Next
		l.Add(res)
	Loop
	cur.Close
	sql1.Close
'	cp.ClosePool
	Return l
End Sub


Sub SQLCreate( Query As String) As Int 'ignore

	Dim sql1 As SQL = GetSQL
	Dim res As Int
	Try
		sql1.ExecNonQuery(Query)
		res = 0
	Catch
		Log(LastException)
		res = -99999999
		Error = LastException
		Er = True
	End Try
'	cp.ClosePool

	Return res
End Sub

'if you use on encrypted columns you should prepare a query with BInsert function
Sub SQLInsert(Query As String, Args As List ) As Int 'ignore
'	sql=cp.GetConnection
'	sql = GetSQL
	Dim sql1 As SQL = GetSQL
	Dim Res As Int
	Try
		sql1.ExecNonQuery2(Query,Args)
'		Res = SQLSelectSingleResult(GetSQL,"SELECT LAST_INSERT_ID()",Null)
	Catch
		Log(LastException)
		Res = -99999999
		Error = LastException
		Er = True
	End Try
'	cp.ClosePool
'	sql1.Close
	Return Res
End Sub

'if you use on encrypted columns you should prepare a query with BSelect function
Sub SQLUpdate(Query As String, Arg As List) As Int 'ignore
'	sql=cp.GetConnection
'	sql = GetSQL
	Dim sql1 As SQL = GetSQL
	Dim Res As Int
	Try
		sql1.ExecNonQuery2(Query, Arg)
		Res = 0
	Catch
		Log(LastException)
		Res = -99999999
		Error = LastException
		Er = True
	End Try
'	cp.ClosePool
'	sql1.Close
	Return Res
End Sub


'if you use on encrypted columns you should prepare a query with BDelete function
Sub SQLDelete(Query As String, Arg As List) As Int 'ignore
'	sql=cp.GetConnection
'	sql = GetSQL
	Dim sql1 As SQL = GetSQL
	Dim Res As Int
	Try
		sql1.ExecNonQuery2(Query, Arg)
		Res = 0
	Catch
		Log(LastException)
		Res = -99999999
		Error = LastException
		Er = True
	End Try
'	cp.ClosePool
'	sql1.Close
	Return Res
End Sub

'for not crypt column in table
'if you want to use with encrypted columns then you have to encrypt the value first in the sql where section with EncryptHash function and if the result is encrypted then decrypt it later with DecryptHash.
Sub SQLSelectSingleResult(Query As String, Arg As List) As String 'ignore
'	sql=cp.GetConnection
'	sql = GetSQL
	Dim sql1 As SQL = GetSQL
	Dim res As String
	Try
		res = sql1.ExecQuerySingleResult2(Query, Arg)
	Catch
		Log(LastException)
		res = -99999999
		Error = LastException
		Er = True
	End Try
'	cp.ClosePool
	If res = Null Then
		Return "0"
	End If
'	sql1.Close
	Return res
End Sub

'select sql query builder for a table that contains encrypted columns
'Fields = Null then all record *
'LastArg = example: Limit 100 etc
'WhereFields = column with Crypt value in database
Sub BSelect(TableName As String, Fields As List, WhereFields As Map, OrderFields As Map, LastArg As List) As String 'ignore
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("SELECT ")
	If Fields.IsInitialized Then
		Dim fie As String=""
		For Each f As String In Fields
			fie=fie&f&", "
		Next
		fie = fie.SubString2(0,fie.Length-2)&" "
		sb.Append(fie)
	Else
		sb.Append("* ")
	End If
	sb.Append(" FROM " & TableName)
	If WhereFields.IsInitialized Then
		sb.Append(" WHERE ")
		For i = 0 To WhereFields.Size - 1
			Dim col As String = WhereFields.GetKeyAt(i)
			If ChecCol(col) Then
				Dim value As String = EncryptHash( WhereFields.GetValueAt(i))
			Else
				Dim value As String = WhereFields.GetValueAt(i)
			End If
			If i > 0 Then
				sb.Append(" AND ")
			End If
			sb.Append(col & "=" & $""${value}""$)
		Next
	End If
	If OrderFields.IsInitialized Then
		sb.Append(" ORDER BY ")
		For i = 0 To WhereFields.Size - 1
			Dim col As String = OrderFields.GetKeyAt(i)
			If i > 0 Then
				sb.Append(", ")
			End If
			sb.Append(col)
		Next
	End If
	If LastArg.IsInitialized Then
		sb.Append(" ")
		For Each arg As String In LastArg
			sb.Append(arg&" ")
		Next
	End If
	If debug Then
		Log(sb.ToString)
	End If
	Return sb.ToString
End Sub

'insert sql query builder for a table that contains encrypted columns
Sub BInsert(TableName As String, Fields As Map) As String 'ignore
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("INSERT INTO " & TableName & "(")
	For i = 0 To Fields.Size - 1
		Dim col As String = Fields.GetKeyAt(i)
		If i > 0 Then
			sb.Append(", ")
		End If
		sb.Append(col)
	Next
	sb.Append(") VALUES (")
	For i = 0 To Fields.Size - 1
		Dim col As String
		If ChecCol(Fields.GetKeyAt(i)) Then
			Dim v As String = Fields.GetValueAt(i)
			col = $""${EncryptHash(v)}""$
		Else
			Dim col As String = """"&Fields.GetValueAt(i)&""""
		End If
		If i > 0 Then
			sb.Append(", ")
		End If
		sb.Append(col)
	Next
	sb.Append(")")
	Return sb.ToString
End Sub

'delete sql query builder for a table that contains encrypted columns
Sub BDelete(TableName As String, WhereFields As Map) As String 'ignore
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("DELETE FROM " & TableName)
	If WhereFields.IsInitialized Then
		sb.Append(" WHERE ")
		For i = 0 To WhereFields.Size - 1
			Dim col As String = WhereFields.GetKeyAt(i)
			If ChecCol(col) Then
				Dim value As String = EncryptHash( WhereFields.GetValueAt(i))
			Else
				Dim value As String = WhereFields.GetValueAt(i)
			End If
			If i > 0 Then
				sb.Append(" AND ")
			End If
			sb.Append(col & "=" & $""${value}"$)
		Next
	End If
	Return sb.ToString
End Sub


'update sql query builder for a table that contains encrypted columns
Sub BUpdate(TableName As String, Fields As Map, WhereFields As Map) As String 'ignore
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("UPDATE " & TableName & " SET ")
	For i = 0 To Fields.Size - 1
		Dim col As String = Fields.GetKeyAt(i)
		Dim value As String = Fields.GetValueAt(i)
		If i > 0 Then
			sb.Append(", ")
		End If
		sb.Append(col & "=" & """"&value&"""")
	Next
	If WhereFields.IsInitialized Then
		sb.Append(" WHERE ")
		For i = 0 To WhereFields.Size - 1
			Dim col As String = WhereFields.GetKeyAt(i)
			Dim value As String = WhereFields.GetValueAt(i)
			If i > 0 Then
				sb.Append(" AND ")
			End If
			sb.Append(col & "=" & """"&value&"""")
		Next
	End If
	Return sb.ToString
End Sub


'function that encrypts selected columns in a table 
Sub EncryptTable(name_table As String, Column As List)
	Dim maxx As Int =1000
	Dim count As Int = SQLSelectSingleResult($"select count(*) from ${name_table}"$, Null)
	If debug Then
		Log($"Count row table: ${name_table} - > ${count}"$)
	End If
	Dim pak As Int = count/maxx
	Dim temp As List= crypt_column
	crypt_column = Column
	If count > maxx Then

		For i=0 To pak+1
			If i<= pak Then
				Dim val_list As List = SQLSelectClear(BSelect(name_table, crypt_column, Null,Null,Array As String($"limit ${maxx} offset ${i*maxx}"$)), Null)
			Else
				Dim val_list As List = SQLSelectClear(BSelect(name_table, crypt_column, Null,Null,Array As String($"limit ${count-(pak*maxx)} offset ${i*maxx}"$)), Null)
			End If
			If val_list.IsInitialized Then
				For Each m As Map In val_list
					Dim w As Map
					w.Initialize
					For ii=0 To m.Size-1
						w.put(m.GetKeyAt(ii), EncryptHash(m.GetValueAt(ii)))
					Next
					SQLUpdate(BUpdate(name_table, w, m), Null)
					If debug Then
						Log($"Crypt-> ${w} to ${m}"$)
					End If
				Next
			End If
			Log($"Pack no:${i}"$)
		Next
	Else
		Dim temp As List= crypt_column
		crypt_column = Column
		Dim val_list As List = SQLSelectClear(BSelect(name_table, crypt_column, Null,Null,Null), Null)
		If val_list.IsInitialized Then
			For Each m As Map In val_list
				Dim w As Map
				w.Initialize
				For i=0 To m.Size-1
					w.put(m.GetKeyAt(i), EncryptHash(m.GetValueAt(i)))
				Next
				SQLUpdate(BUpdate(name_table, w, m), Null)
				If debug Then
					Log($"Crypt-> ${w} to ${m}"$)
				End If
			Next
		End If
	End If
	crypt_column=  temp
End Sub

'function decrypts selected columns in the table 
Sub DecryptTable(name_table As String, Column As List)
	Dim maxx As Int =1000
	Dim count As Int = SQLSelectSingleResult($"select count(*) from ${name_table}"$, Null)
	If debug Then
		Log($"Count row table: ${name_table} - > ${count}"$)
	End If
	Dim pak As Int = count/maxx
	Dim temp As List= crypt_column
	crypt_column = Column
	If count > maxx Then
		For i=0 To pak+1
			If i<= pak Then
				Dim val_list As List = SQLSelectClear(BSelect(name_table, crypt_column, Null,Null,Array As String($"limit ${maxx} offset ${i*maxx}"$)), Null)
			Else
				Dim val_list As List = SQLSelectClear(BSelect(name_table, crypt_column, Null,Null,Array As String($"limit ${count-(pak*maxx)} offset ${i*maxx}"$)), Null)
			End If
			If val_list.IsInitialized Then
				For Each m As Map In val_list
					Dim w As Map
					w.Initialize
					For ii=0 To m.Size-1
						w.put(m.GetKeyAt(ii), DecryptHash(m.GetValueAt(ii)))
					Next
					SQLUpdate(BUpdate(name_table, w, m), Null)
					If debug Then
						Log($"Crypt-> ${w} to ${m}"$)
					End If
				Next
			End If
			Log($"Pack no:${i}"$)
		Next
	Else
		Dim temp As List= crypt_column
		crypt_column = Column
		Dim val_list As List = SQLSelectClear(BSelect(name_table, crypt_column, Null,Null,Null), Null)
		If val_list.IsInitialized Then
			For Each m As Map In val_list
				Dim w As Map
				w.Initialize
				For i=0 To m.Size-1
					w.put(m.GetKeyAt(i), DecryptHash(m.GetValueAt(i)))
				Next
				SQLUpdate(BUpdate(name_table, w, m), Null)
				If debug Then
					Log($"Decrypt-> ${m} to ${w}"$)
				End If
			Next
		End If
	End If
	crypt_column = temp
End Sub

'Like sql function for a table containing encrypted columns,
'parametr Like sql function for a table containing encrypted columns,
Sub BSelectLike(name_table As String, Like As Map) As List
	Dim out As List
	out.Initialize
	Dim l As List = SQLSelectClear($"select * from ${name_table}"$, Null)
	Dim s As String = Like.GetKeyAt(0)
	Dim s1 As String = Like.GetValueAt(0)
	For i=0 To l.Size-1
		Dim m As Map = l.Get(i)
		For j=0 To m.Size-1
			If m.GetKeyAt(j) = s Then
				Dim c1 As String = DecryptHash( m.GetValueAt(j))
				If c1.Contains(s1) Then
					For Each n As String In crypt_column
						If m.ContainsKey(n) Then
							If ChecCol(n) Then
								m.Put(n, DecryptHash(m.Get(n)))
							End If
						End If
					Next
					out.Add(m)
				End If
			End If
		Next
	Next
	Return out
End Sub

private Sub ChecCol(name As String) As Boolean
	For Each n As String In crypt_column
		If name = n Then
			Return True
		End If
	Next
	Return False
End Sub

'string encryption
Sub EncryptHash(value As String) As String
	Dim val As String = replacePL(value)
	Return de.encrypt(val)
End Sub

'string decryption 
public Sub DecryptHash(value As String) As String 'ignore
	Dim val As String = de.decrypt(value)
	Return dereplacePL(val)
End Sub


Private Sub InitDe(passphrase As String,password As String)
	Try
		de.Initialize(hash(passphrase), hash(password))
	Catch
		Log(LastException)
	End Try
End Sub

'generator password
public Sub GenerateRandomPassword(numChars As Int, numbers As Boolean, lowercase As Boolean, uppercase As Boolean, symbols As Boolean) As String

	Dim newPassword As String
          
	Dim uppercaseArray(26) As String = Array As String ("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z")
	Dim lowercaseArray(26) As String = Array As String ("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
	Dim numbersArray(10)   As String = Array As String ("0","1","2","3","4","5","6","7","8","9")
	Dim symbolsArray(12)   As String = Array As String ("@","$","%","&","?","#","!","*","+","-",";","_")
  
	Dim charList As List
	charList.Initialize
  
	If numbers   Then charList.AddAll(numbersArray)
	If lowercase Then charList.AddAll(lowercaseArray)
	If uppercase Then charList.AddAll(uppercaseArray)
	If symbols   Then charList.AddAll(symbolsArray)
  
	For i = 1 To numChars
		newPassword = newPassword & charList.Get(Rnd(0, charList.Size))
	Next
 
	Return newPassword
  
End Sub


private Sub hash(value As String) As String
	Dim ha As String
	If value.Length = 16 Then
		ha = value
	Else If value.Length > 16 Then
		ha = value.SubString2(0,16)
	Else
		Dim l As Int =value.Length-1
		Dim s As Int = 0
		Do While ha.Length<> 16
			ha = ha & value.SubString2(s,s+1)
			If s=l Then
				s=0
			Else
				s=s+1
			End If
		Loop
		
	End If
	Return ha
End Sub

'function that converts dialectic language characters into easily written equivalents ( example for Polish language)
public Sub replacePL(value As String) As String
	Dim val As String = value
	val = val.Replace("ą","a?")
	val = val.Replace("ś","s?")
	val = val.Replace("ł","l?")
	val = val.Replace("ż","z?")
	val = val.Replace("ź","z??")
	val = val.Replace("ć","c?")
	val = val.Replace("ń","n?")
	val = val.Replace("ę","e?")
	val = val.Replace("ó","o?")
	
	val = val.Replace("Ą","A?")
	val = val.Replace("Ś","S?")
	val = val.Replace("Ł","L?")
	val = val.Replace("Ż","Z?")
	val = val.Replace("Ź","Z??")
	val = val.Replace("Ć","C?")
	val = val.Replace("Ń","N?")
	val = val.Replace("Ę","E?")
	val = val.Replace("Ó","O?")
	If debug Then
'		Log(val)
	End If
	Return val
End Sub

public Sub dereplacePL(value As String) As String
	Dim val As String = value
	val = val.Replace("a?","ą")
	val = val.Replace("s?","ś")
	val = val.Replace("l?","ł")
	val = val.Replace("z?","ż")
	val = val.Replace("z??","ź")
	val = val.Replace("c?","ć")
	val = val.Replace("n?","ń")
	val = val.Replace("e?","ę")
	val = val.Replace("o?","ó")
	
	val = val.Replace("A?","Ą")
	val = val.Replace("S?","Ś")
	val = val.Replace("L?","Ł")
	val = val.Replace("Z?","Ż")
	val = val.Replace("Z??","Ź")
	val = val.Replace("C?","Ć")
	val = val.Replace("N?","Ń")
	val = val.Replace("E?","Ę")
	val = val.Replace("O?","Ó")
	If debug Then
'		Log(val)
	End If
	Return val
End Sub
