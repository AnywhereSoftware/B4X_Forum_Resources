B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=12.8
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	
	Public localize As Map
	Public LocExcelWB As ReadableWorkbook
	Public LocExcelSH As ReadableSheet
	' Must be Excel Version 97-2003 without any macro!
	Public LocExelFile As String = "TD_localize.xls"
End Sub

' Fill Localize Map with translated strings
' Map Key = StringKey
' Map Value = String
' Language = 2 Char ISO Code
' Language = empty = from device
' Return true if successfull, fals if failed
public Sub readExcelToMap(Language As String, Clear As Boolean) As Boolean
	Try
		' if empty get device locale
		If Language = "" Then
			Dim r As Reflector
			r.Target = r.RunStaticMethod("java.util.Locale", "getDefault", Null, Null)
			Language = r.RunMethod("toString")
		End If
		
		' open workbook and sheet
		' Must be Excel Version 97-2003 without any macro!
		LocExcelWB.Initialize(File.DirAssets,"TD_Localize.xls")
		
		If LocExcelWB.IsInitialized Then
			LocExcelSH = LocExcelWB.GetSheet(0)
			' get Language column
			Dim LngCol As Long
			For y = 0 To LocExcelSH.ColumnsCount -1
				If LocExcelSH.GetCellValue(y,0).Contains(Language) Then
					LngCol = y
					Exit
				End If
			Next
			
			' fill map
			localize.initialize
			If Clear Then 
				localize.clear
			End If
			Dim key As String
			Dim value As String
			If LocExcelSH.IsInitialized Then
				For x = 1 To LocExcelSH.RowsCount -1
					key = LocExcelSH.GetCellValue(0,x)
					value = LocExcelSH.GetCellValue(LngCol,x)
					localize.Put(key,value)
				Next
			End If
			
			' close
			LocExcelWB.Close
		Else
			Return False
		End If

		Return True
	Catch
		Log(LastException)
		Return False
	End Try
End Sub

' Fill database Localize with translated strings
' Language = 2 Char ISO Code
' Language = empty = from device
' Return true if successfull, false if failed
public Sub InitializeDB(Language As String) As Boolean
	Try
		' if empty get device locale
		If Language = "" Then
			Dim r As Reflector
			r.Target = r.RunStaticMethod("java.util.Locale", "getDefault", Null, Null)
			Language = r.RunMethod("toString")
		End If
				
		If Starter.tDLocalizeSQL.IsInitialized Then
			' open and populate resultset
			Dim rs As ResultSet = Starter.tDLocalizeSQL.ExecQuery("SELECT * FROM localize ORDER BY StringKey ASC")
			' clear table localize
			If rs.RowCount > 0 Then
				Starter.tDLocalizeSQL.ExecNonQuery("DELETE FROM localize where rowid > 0")
			End If
			' open workbook and sheet
			' Must be Excel Version 97-2003 without any macro!
			LocExcelWB.Initialize(File.DirAssets,"TD_Localize.xls")
			
			If LocExcelWB.IsInitialized Then
				LocExcelSH = LocExcelWB.GetSheet(0)
				' get Language column
				Dim LngCol As Long
				Dim Lng1 As String = Language.ToLowerCase
				Dim Lng2 As String
				For y = 1 To LocExcelSH.ColumnsCount -1
					key = LocExcelSH.GetCellValue(y,0)
					key = key.ToLowerCase
					If Lng1.Contains(key) Then
						LngCol = y
						Exit
					End If
				Next
				' insert new translated string
				Dim key As String
				Dim value As String
				
				If LocExcelSH.IsInitialized And rs.IsInitialized Then
					Log("Fill Database TDLocalize Table localize.....")
					Log("Starting with: " & _
						Starter.tDLocalizeSQL.ExecQuerySingleResult("Select count(*) FROM localize") _
						& " rows")
					Starter.tDLocalizeSQL.BeginTransaction
					' insert current used locale in 1st row
					Dim strSQL As String = "INSERT OR IGNORE INTO localize (stringKey,String) VALUES ("
					strSQL = strSQL & "'currentLNG','" & Language & "')"
					Log("used locale: " & Language)
					Starter.tDLocalizeSQL.ExecNonQuery(strSQL)
					' insert translated strings
					For x = 1 To LocExcelSH.RowsCount -1
						key = LocExcelSH.GetCellValue(0,x)
						value = LocExcelSH.GetCellValue(LngCol,x)
						Dim strSQL As String = "INSERT OR IGNORE INTO localize (stringKey,String) VALUES ("
						strSQL = strSQL & "'" & key & "','" & value & "')"
						Starter.tDLocalizeSQL.ExecNonQuery(strSQL)
					Next
					Starter.tDLocalizeSQL.TransactionSuccessful
					Starter.tDLocalizeSQL.EndTransaction
					Log("Inserted at final: " & _
						Starter.tDLocalizeSQL.ExecQuerySingleResult("Select count(*) FROM localize") _
						& " rows")
				End If
				' close resultset
				rs.close
				' close
				LocExcelWB.Close
			End If
			Return True
		Else
			Return False
		End If
	Catch
		Log(LastException)
		Return False
	End Try
End Sub

' return translated string on base of given key
public Sub getString(Key As String) As String
	If Starter.tDLocalizeSQL.IsInitialized Then
		Dim rs As ResultSet = Starter.tDLocalizeSQL.ExecQuery( _
			"SELECT * FROM Localize WHERE stringKey ='" & Key & "'")
		Dim res As String
		If rs.RowCount = 1 Then
			rs.Position = 0
			res = rs.GetString("String")
		Else
			res = ""
		End If
		rs.Close
		Return res
	End If
End Sub

' return locale of strings in the table
public Sub getLng As String
	If Starter.tDLocalizeSQL.IsInitialized Then
		Dim rs As ResultSet = Starter.tDLocalizeSQL.ExecQuery( _
			"SELECT * FROM Localize WHERE stringKey = 'currentLNG'")
		Dim res As String
		If rs.RowCount = 1 Then
			rs.Position = 0
			res = rs.GetString("String")
		Else
			res = ""
		End If
		rs.Close
		Return res
	End If
End Sub