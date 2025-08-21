B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public const DB_BOOL As String = "BOOL"
	Public const DB_INT As String = "INT"
	Public const DB_STRING As String = "STRING"
	Public const DB_REAL As String = "REAL"
	Public const DB_DATE As String = "DATE"
	Public const DB_BLOB As String = "BLOB"
	Private recType As Map
	Type ResultSet(response As String, result As List, command As String, types As List, args As List, query As String)
End Sub


'initialize the class, a field named "id" is assumed to be an integer
Public Sub Initialize() As BANanoSQLite
	recType.Initialize
	AddIntegers(Array("id"))
	Return Me
End Sub

'execute the query and wait
Sub GetResultSet(query As String, res As String) As ResultSet
	Dim tt As List
	tt.Initialize
	Dim aa As List
	aa.Initialize
	Dim dataList As List
	dataList.Initialize
	Dim resmap As Map = Json2Map(query)
	Dim scommand As String = resmap.GetDefault("command", "")
	Dim stypes As List = resmap.GetDefault("types", tt)
	Dim sargs As List = resmap.GetDefault("args", aa)
	Dim ssql As String = resmap.GetDefault("sql","")
	'	
	Dim resmap1 As Map = Json2Map(res)
	Dim gr As ResultSet
	gr.Initialize
	gr.query = ssql
	gr.args = sargs
	gr.command = scommand
	gr.types = stypes
	gr.response = resmap1.GetDefault("response","")
	gr.result = resmap1.GetDefault("data", dataList)
	Return gr
End Sub

'return a sql to delete record of table where one exists
Sub DeleteAll(tblName As String) As String
	Dim sb As String = $"DELETE FROM ${EscapeField(tblName)}"$
	Dim m As Map
	m.Initialize
	m.Put("sql", sb)
	m.Put("args", Null)
	m.Put("types", Null)
	m.Put("command", "delete")
	Dim res As String = Map2Json(m)
	Return res
End Sub

'convert a map to a json string
Sub Map2Json(mp As Map) As String
	Dim JSON As BANanoJSONGenerator
	JSON.Initialize(mp)
	Return JSON.ToString
End Sub

'convert a list to json
Sub List2Json(mp As List) As String
	Dim JSON As BANanoJSONGenerator
	JSON.Initialize2(mp)
	Return JSON.ToString
End Sub


'convert a json string to a map
Sub Json2Map(strJSON As String) As Map
	Dim json As BANanoJSONParser
	Dim Map1 As Map
	Map1.Initialize
	Map1.clear
	Try
		If strJSON.length > 0 Then
			json.Initialize(strJSON)
			Map1 = json.NextObject
		End If
		Return Map1
	Catch
		Return Map1
	End Try
End Sub

' convert a json string to a list
Sub Json2List(strValue As String) As List
	Dim lst As List
	lst.Initialize
	lst.clear
	If strValue.Length = 0 Then
		Return lst
	End If
	Try
		Dim parser As BANanoJSONParser
		parser.Initialize(strValue)
		Return parser.NextArray
	Catch
		Return lst
	End Try
End Sub

'return a sql to update all records of table
Sub UpdateAll(tblName As String, tblFields As Map) As String
	Dim listOfTypes As List = GetMapTypes(tblFields)
	Dim args As List = GetMapValues(tblFields)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"UPDATE ${EscapeField(tblName)} SET "$)
	Dim i As Int
	Dim iTot As Int = tblFields.Size - 1
	For i = 0 To iTot
		Dim col As String = tblFields.GetKeyAt(i)
		sb.Append(col)
		If i <> iTot Then
			sb.Append(" = ?,")
		Else
			sb.Append(" = ?")
		End If
	Next
	Dim m As Map
	m.Initialize
	m.Put("sql", sb.tostring)
	m.Put("args", args)
	m.Put("types", listOfTypes)
	m.Put("command", "update")
	Dim res As String = Map2Json(m)
	Return res
End Sub


'return a sql to select record of table where one exists
Sub SelectWhere(tblName As String, tblfields As List, tblWhere As Map, orderBy As List) As String
	Dim listOfTypes As List = GetMapTypes(tblWhere)
	Dim listOfValues As List = GetMapValues(tblWhere)
	'are we selecting all fields or just some
	Dim fld1 As String = tblfields.Get(0)
	Dim selFIelds As String = ""
	Select Case fld1
		Case "*"
			selFIelds = "*"
		Case Else
			selFIelds = JoinFields(",", tblfields)
	End Select
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"SELECT ${selFIelds} FROM ${EscapeField(tblName)} WHERE "$)
	Dim i As Int
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			sb.Append(" AND ")
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		sb.Append(col)
		sb.Append(" = ?")
	Next
	If orderBy <> Null Then
		'order by
		Dim stro As String = JoinFields(",", orderBy)
		If stro.Length > 0 Then
			sb.Append(" ORDER BY ").Append(stro)
		End If
	End If
	Dim m As Map
	m.Initialize
	m.Put("sql", sb.tostring)
	m.Put("args", listOfValues)
	m.Put("types", listOfTypes)
	m.Put("command", "selectwhere")
	Dim res As String = Map2Json(m)
	Return res
End Sub

'return a sql to update records of table where one exists
Sub UpdateWhere(tblName As String, tblfields As Map, tblWhere As Map) As String
	Dim listOfTypes As List = GetMapTypes(tblfields)
	Dim listOfTypes1 As List = GetMapTypes(tblWhere)
	listOfTypes.AddAll(listOfTypes1)
	Dim listOfValues As List = GetMapValues(tblfields)
	Dim listOfValues1 As List = GetMapValues(tblWhere)
	listOfValues.AddAll(listOfValues1)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"UPDATE ${EscapeField(tblName)} SET "$)
	Dim i As Int
	Dim iTot As Int = tblfields.Size - 1
	For i = 0 To iTot
		Dim col As String = tblfields.GetKeyAt(i)
		sb.Append(EscapeField(col))
		If i <> iTot Then
			sb.Append("= ?,")
		Else
			sb.Append("= ?")
		End If
	Next
	sb.Append($" WHERE "$)
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			sb.Append(" AND ")
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		sb.Append(EscapeField(col))
		sb.Append(" = ?")
	Next
	Dim m As Map
	m.Initialize
	m.Put("sql", sb.tostring)
	m.Put("args", listOfValues)
	m.Put("types", listOfTypes)
	m.Put("command", "updatewhere")
	Dim res As String = Map2Json(m)
	Return res
End Sub

'get the list of types
private Sub GetMapTypes(sourceMap As Map) As List
	Dim listOfTypes As List
	listOfTypes.Initialize
	Dim iCnt As Int
	Dim iTot As Int
	iTot = sourceMap.Size - 1
	For iCnt = 0 To iTot
		Dim col As String = sourceMap.GetKeyAt(iCnt)
		Dim colType As String = recType.GetDefault(col,"STRING")
		Select Case colType
			Case "VARCHAR(20)", "VARCHAR(10)", "VARCHAR(30)", "VARCHAR(40)"
				listOfTypes.add("s")
			Case "VARCHAR(50)", "VARCHAR(100)", "VARCHAR(255)"
				listOfTypes.add("s")
			Case "STRING","VARCHAR","TEXT","DATE","DATETIME"
				listOfTypes.add("s")
			Case "INTEGER", "INT", "BOOL"
				listOfTypes.add("i")
			Case "BLOB"
				listOfTypes.add("b")
			Case "REAL","FLOAT","DOUBLE"
				listOfTypes.add("d")
		End Select
	Next
	Return listOfTypes
End Sub

'get map values
private Sub GetMapValues(sourceMap As Map) As List
	Dim listOfValues As List
	listOfValues.Initialize
	Dim iCnt As Int
	Dim iTot As Int
	iTot = sourceMap.Size - 1
	For iCnt = 0 To iTot
		Dim value As String = sourceMap.GetValueAt(iCnt)
		listOfValues.Add(value)
	Next
	Return listOfValues
End Sub

'get map keys
private Sub GetMapKeys(sourceMap As Map) As List
	Dim listOfValues As List
	listOfValues.Initialize
	Dim iCnt As Int
	Dim iTot As Int
	iTot = sourceMap.Size - 1
	For iCnt = 0 To iTot
		Dim value As String = sourceMap.GetKeyAt(iCnt)
		listOfValues.Add(value)
	Next
	Return listOfValues
End Sub

'specify strings field types, this is default for all strings
Sub AddStrings(fieldNames As List) As BANanoSQLite
	For Each strfld As String In fieldNames
		recType.Put(strfld,"STRING")
	Next
	Return Me
End Sub

'specify integer field types
Sub AddIntegers(fieldNames As List) As BANanoSQLite
	For Each strfld As String In fieldNames
		recType.Put(strfld,"INT")
	Next
	Return Me
End Sub

'specify double field types
Sub AddDoubles(fieldNames As List) As BANanoSQLite
	For Each strfld As String In fieldNames
		recType.Put(strfld,"DOUBLE")
	Next
	Return Me
End Sub

'specify boolean field types
Sub AddBooleans(fieldNames As List) As BANanoSQLite
	For Each strfld As String In fieldNames
		recType.Put(strfld,"BOOL")
	Next
	Return Me
End Sub

'specify blobs field types
Sub AddBlobs(fieldNames As List) As BANanoSQLite
	For Each strfld As String In fieldNames
		recType.Put(strfld,"BLOB")
	Next
	Return Me
End Sub


Private Sub EscapeField(f As String) As String
	Return $"[${f}]"$
End Sub

'return a sql command to create the table
public Sub CreateTable(tblName As String, tblFields As Map, PK As String) As String
	Dim fldName As String
	Dim fldType As String
	Dim fldTot As Int
	Dim fldCnt As Int
	fldTot = tblFields.Size - 1
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("(")
	For fldCnt = 0 To fldTot
		fldName = tblFields.GetKeyAt(fldCnt)
		fldType = tblFields.Get(fldName)
		If fldCnt > 0 Then
			sb.Append(", ")
		End If
		sb.Append(EscapeField(fldName))
		sb.Append(" ")
		sb.Append(fldType)
		If fldName.EqualsIgnoreCase(PK) Then
			sb.Append(" PRIMARY KEY")
		End If
	Next
	sb.Append(")")
	'define the qry to execute
	Dim query As String = "CREATE TABLE IF NOT EXISTS " & EscapeField(tblName) & " " & sb.ToString
	Dim m As Map
	m.Initialize
	m.Put("sql", query)
	m.Put("args", Null)
	m.Put("types", Null)
	m.Put("command", "createtable")
	Dim res As String = Map2Json(m)
	Return res
End Sub

'return a sql insert statement
Sub Insert(tblName As String, tblFields As Map) As String
	Dim sb As StringBuilder
	Dim columns As StringBuilder
	Dim values As StringBuilder
	Dim listOfValues As List = GetMapValues(tblFields)
	Dim listOfTypes As List = GetMapTypes(tblFields)
	Dim iCnt As Int
	Dim iTot As Int
	sb.Initialize
	columns.Initialize
	values.Initialize
	sb.Append($"INSERT INTO ${EscapeField(tblName)} ("$)
	iTot = tblFields.Size - 1
	For iCnt = 0 To iTot
		Dim col As String = tblFields.GetKeyAt(iCnt)
		If iCnt > 0 Then
			columns.Append(", ")
			values.Append(", ")
		End If
		columns.Append(EscapeField(col))
		values.Append("?")
	Next
	sb.Append(columns.ToString)
	sb.Append(") VALUES (")
	sb.Append(values.ToString)
	sb.Append(")")
	Dim m As Map
	m.Initialize
	m.Put("sql", sb.ToString)
	m.Put("args", listOfValues)
	m.Put("types", listOfTypes)
	m.Put("command", "insert")
	Dim res As String = Map2Json(m)
	Return res
End Sub

'join list to multi value string
private Sub JoinFields(delimiter As String, lst As List) As String
	Dim i As Int
	Dim sb As StringBuilder
	Dim fld As String
	sb.Initialize
	fld = lst.Get(0)
	fld = EscapeField(fld)
	sb.Append(fld)
	For i = 1 To lst.size - 1
		Dim fld As String = lst.Get(i)
		fld = EscapeField(fld)
		sb.Append(delimiter).Append(fld)
	Next
	Return sb.ToString
End Sub


'return a sql to select record of table where one exists
Sub SelectAll(tblName As String, tblfields As List, orderBy As List) As String
	'are we selecting all fields or just some
	Dim fld1 As String = tblfields.Get(0)
	Dim selFIelds As String = ""
	Select Case fld1
		Case "*"
			selFIelds = "*"
		Case Else
			selFIelds = JoinFields(",", tblfields)
	End Select
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"SELECT ${selFIelds} FROM ${EscapeField(tblName)}"$)
	If orderBy <> Null Then
		'order by
		Dim stro As String = JoinFields(",", orderBy)
		If stro.Length > 0 Then
			sb.Append(" ORDER BY ").Append(stro)
		End If
	End If
	Dim m As Map
	m.Initialize
	m.Put("sql", sb.tostring)
	m.Put("args", Null)
	m.Put("types", Null)
	m.Put("command", "select")
	Dim res As String = Map2Json(m)
	Return res
End Sub

'return a sql to delete record of table where one exists
Sub DeleteWhere(tblName As String, tblWhere As Map) As String
	Dim listOfTypes As List = GetMapTypes(tblWhere)
	Dim listOfValues As List = GetMapValues(tblWhere)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"DELETE FROM ${EscapeField(tblName)} WHERE "$)
	Dim i As Int
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			sb.Append(" AND ")
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		sb.Append(col)
		sb.Append(" = ?")
	Next
	Dim m As Map
	m.Initialize
	m.Put("sql", sb.tostring)
	m.Put("args", listOfValues)
	m.Put("types", listOfTypes)
	m.Put("command", "deletewhere")
	Dim res As String = Map2Json(m)
	Return res
End Sub


#if PHP
function preparesqlite($db, $sql, $types, $values) {
		/* Bind parameters. Types: s = string, i = integer, d = double,  b = blob */
		$stmt = $db->prepare($sql);
		if(is_array($types)){
			$n = count($types);
			for($i = 0; $i < $n; $i++) {
				$param_type = $types[$i];
				$param_value = $values[$i];
				$loc = $i + 1;
				switch($param_type){
					case "s":
						$stmt->bindValue($loc, $param_value, SQLITE3_TEXT);
						break;
					case "i":
						$stmt->bindValue($loc, $param_value, SQLITE3_INTEGER);
						break;
					case "d":
						$stmt->bindValue($loc, $param_value, SQLITE3_FLOAT);
						break;
					case "b":
						$stmt->bindValue($loc, $param_value, SQLITE3_BLOB);
						break;
				}
			}
		}
		return $stmt;
}

function BANanoSQLite($dbname,$data) {
   	$db;
	//set the header
	header('content-type: application/json; charset=utf-8');
   	$db = new SQLite3($dbname);
	if(!$db) {
  		$response = $db->lastErrorMsg();
  		$output = json_encode(Array("response" => $response));
  		die($output);
	}
	//data Is json, set it As a php variable
	$data = json_decode($data, True);
	//get the command To execute
	$command = $data["command"];
	$sql = $data["sql"];
	$values = $data["args"];
	$types = $data["types"];
	switch($command){
		Case "select":
		    $stmt = preparesqlite($db, $sql, $types, $values);
			$res = $stmt->execute();
			$rows = Array();
			while($row = $res->fetchArray()) {
				$rows[] = $row;
			}
			$output = json_encode(array("response" => "OK", "data" => $rows));
	  		echo $output;
			break;
		case "deletewhere":
			//build the prepared statement
			$stmt = preparesqlite($db, $sql, $types, $values);
			$res = $stmt->execute();
			$affRows = $db->changes();
			$output = json_encode(array("response" => "OK", "data" => $affRows));
	  		echo $output;
			break;
	   	case "updatewhere":
			//build the prepared statement
			$stmt = preparesqlite($db, $sql, $types, $values);
			$res = $stmt->execute();
			$affRows = $db->changes();
			$output = json_encode(array("response" => "OK", "data" => $affRows));
	  		echo $output;
			break;
		case "selectwhere":
			//build the prepared statement
			$stmt = preparesqlite($db, $sql, $types, $values);
			$res = $stmt->execute();
			$rows = Array();
			while($row = $res->fetchArray()) {
				$rows[] = $row;
			}
			$output = json_encode(array("response" => "OK", "data" => $rows));
	  		echo $output;
			break;
		case "insert":
			$stmt = preparesqlite($db, $sql, $types, $values);
			$res = $stmt->execute();
			$last_row_id = $db->lastInsertRowID();
			$output = json_encode(array("response" => "OK", "data" => $last_row_id));
	  		echo $output;
			break;
		default:
		    $stmt = preparesqlite($db, $sql, $types, $values);
			$res = $stmt->execute();
			$rows = Array();
			while($row = $res->fetchArray()) {
				$rows[] = $row;
			}
			$output = json_encode(array("response" => "OK", "data" => $rows));
	  		echo $output;
			break;
	}
	$db->close();
}
#End If