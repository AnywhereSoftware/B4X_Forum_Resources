B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Private recType As Map
	Public DB_VARCHAR_20 As String = "VARCHAR(20)"
	Public DB_VARCHAR_10 As String = "VARCHAR(10)"
	Public DB_VARCHAR_30 As String = "VARCHAR(30)"
	Public DB_VARCHAR_40 As String = "VARCHAR(40)"
	Public DB_VARCHAR_50 As String = "VARCHAR(50)"
	Public DB_VARCHAR_100 As String = "VARCHAR(100)"
	Public DB_VARCHAR_255 As String = "VARCHAR(255)"
	Public DB_STRING As String = "TEXT"
	Public DB_INT As String = "INT"
	Public DB_FLOAT As String = "FLOAT"
	Public DB_BLOB As String = "BLOB"
	Public DB_BOOL As String = "BOOL"
	Public DB_REAL As String = "REAL"
	Public DB_DATE As String = "DATE"
	Type ResultSet(response As String, result As List, command As String, types As List, args As List, query As String)
End Sub

'initialize the class, a field named "id" is assumed to be an integer
Public Sub Initialize() As BANanoMySQL
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

'convert a map to a json string using BANanoJSONGenerator
Sub Map2Json(mp As Map) As String
	Dim JSON As BANanoJSONGenerator
	JSON.Initialize(mp)
	Return JSON.ToString
End Sub

'specify strings field types, this is default for all strings
Sub AddStrings(fieldNames As List) As BANanoMySQL
	For Each strfld As String In fieldNames
		recType.Put(strfld,"STRING")
	Next
	Return Me
End Sub

'specify integer field types
Sub AddIntegers(fieldNames As List) As BANanoMySQL
	For Each strfld As String In fieldNames
		recType.Put(strfld,"INT")
	Next
	Return Me
End Sub

'specify double field types
Sub AddDoubles(fieldNames As List) As BANanoMySQL
	For Each strfld As String In fieldNames
		recType.Put(strfld,"DOUBLE")
	Next
	Return Me
End Sub

'specify blob field types
Sub AddBlobs(fieldNames As List) As BANanoMySQL
	For Each strfld As String In fieldNames
		recType.Put(strfld,"BLOB")
	Next
	Return Me
End Sub

'excape fields with ``
Private Sub EscapeField(f As String) As String
	Return $"`${f}`"$
End Sub

'return string for test connection operation
Sub TestConnection() As String
	Dim m As Map
	m.Initialize
	m.Put("sql", "")
	m.Put("args", Null)
	m.Put("types", Null)
	m.Put("command", "connection")
	Dim res As String = Map2Json(m)
	Return res
End Sub

' return string to create database
Sub CreateDatabase(dbName As String) As String
	Dim SQL As String = $"CREATE DATABASE IF NOT EXISTS ${EscapeField(dbName)} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci"$
	Dim m As Map
	m.Initialize
	m.Put("sql", SQL)
	m.Put("args", Null)
	m.Put("types", Null)
	m.Put("command", "createdb")
	Dim res As String = Map2Json(m)
	Return res
End Sub

'drop the database
Sub DropDataBase(dbName As String) As String
	Dim SQL As String = $"DROP DATABASE ${EscapeField(dbName)}"$
	Dim m As Map
	m.Initialize
	m.Put("sql", SQL)
	m.Put("args", Null)
	m.Put("types", Null)
	m.Put("command", "dropdb")
	Dim res As String = Map2Json(m)
	Return res
End Sub

'return a sql command to create the table
public Sub CreateTable(tblName As String, tblFields As Map, PK As String, Auto As String) As String
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
			sb.Append(" NOT NULL PRIMARY KEY")
		End If
		If fldName.EqualsIgnoreCase(Auto) Then
			sb.Append(" AUTO_INCREMENT")
		End If
	Next
	sb.Append(")")
	'define the qry to execute
	Dim query As String = "CREATE TABLE IF NOT EXISTS " & EscapeField(tblName) & " " & sb.ToString
	query = query & " ENGINE=MyISAM CHARACTER SET utf8 COLLATE utf8_unicode_ci"
	Dim m As Map
	m.Initialize
	m.Put("sql", query)
	m.Put("args", Null)
	m.Put("types", Null)
	m.Put("command", "createtable")
	Dim res As String = Map2Json(m)
	Return res
End Sub

'return sql command to drop a table
public Sub DropTable(tblName As String) As String
	'define the qry to execute
	Dim query As String = "DROP TABLE " & EscapeField(tblName)
	Dim m As Map
	m.Initialize
	m.Put("sql", query)
	m.Put("args", Null)
	m.Put("types", Null)
	m.Put("command", "droptable")
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
			Case "REAL","FLOAT","DOUBLE"
				listOfTypes.add("d")
			Case "BLOB"
				listOfTypes.Add("b")
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

'join list to mv string
private Sub Join(delimiter As String, lst As List) As String
	Dim i As Int
	Dim sb As StringBuilder
	Dim fld As String
	sb.Initialize
	fld = lst.Get(0)
	sb.Append(fld)
	For i = 1 To lst.size - 1
		Dim fld As String = lst.Get(i)
		sb.Append(delimiter).Append(fld)
	Next
	Return sb.ToString
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
		sb.Append(EscapeField(col))
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
		sb.Append(EscapeField(col))
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

#if PHP
function SendEmail($from,$to,$cc,$subject,$msg) { 
	$msg = str_replace("\n.", "\n..", $msg); 
	// use wordwrap() if lines are longer than 70 characters 
	$msg = wordwrap($msg,70,"\r\n"); 
	//define from header 
	$headers = "From:" . $from . "\r\n"; 
	$headers .= "Cc: " . $cc . "\r\n"; 
	$headers .= "X-Mailer:PHP/" . phpversion(); 
	// send email 
	$response = (mail($to,$subject,$msg,$headers)) ? "success" : "failure"; 
    $output = json_encode(array("response" => $response)); 
    header('content-type: application/json; charset=utf-8'); 
    echo($output); 
} 

function prepareStatement($conn,$sql, $types, $values) {
	//paramater types to execute
	/* Bind parameters. Types: s = string, i = integer, d = double,  b = blob */
	$a_params = array();
	$param_type = '';
	$n = count($types);
	for($i = 0; $i < $n; $i++) {
		$param_type .= $types[$i];
	}
	$a_params[] = & $param_type;
	//values to execute
	for($i = 0; $i < $n; $i++) {
		$a_params[] = & $values[$i];
	}
	/* Prepare statement */
	$stmt = $conn->prepare($sql);
	if($stmt === false) {
		$response = $conn->error;
		$output = json_encode(array("response" => $response));
    	die($output);
	}
	/* use call_user_func_array, as $stmt->bind_param('s', $param); does not accept params array */
	call_user_func_array(array($stmt, 'bind_param'), $a_params);
	return $stmt;
}

//update the connection settings with your own settings
function BANanoMySQL($data) {
	//define these so that they cannot be changed
	DEFINE ('DB_HOST', 'localhost');
	DEFINE ('DB_USER', 'root');
	DEFINE ('DB_PASSWORD', '');
	DEFINE ('DB_NAME', 'bananomysql2');
	//set the header
	header('content-type: application/json; charset=utf-8');
	//connect To MySQL
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
	//we cannot connect Return an error
	If ($conn->connect_error) {
		$response = $conn->connect_error;
    	$output = json_encode(Array("response" => $response));
    	die($output);
	}
	mysqli_set_charset($conn, 'utf8');
	//data Is json, set it As a php variable
	$data = json_decode($data, true);
	//get the command To execute
	$command = $data["command"];
	$sql = $data["sql"];
	$values = $data["args"];
	$types = $data["types"];
	$sql = mysqli_real_escape_string($conn, $sql);
	Try {
	$conn->autocommit(False);
	//process the commands
	switch($command){
		Case "select":
			$result = $conn->query($sql);
			If (!$result){
				$response = $conn->error;
				$output = json_encode(Array("response" => $response));
				die($output);
			}
			// Fetch all
			$rows = Array();
			While ($row = $result->fetch_assoc()) {
				$rows[] = $row;
			}
			$output = json_encode(array("response" => "OK", "data" => $rows));
			break;
		case "deletewhere":
			//build the prepared statement
			$stmt = prepareStatement($conn, $sql, $types, $values);
			/* Execute statement */
			$result = $stmt->execute();
			if ($result){
				//get affected rows
    			$affRows = $conn->affected_rows;
				//the response should be ok
				$output = json_encode(array("response" => "OK", "data" => $affRows));
			} else {
				$response = $conn->error;
				$output = json_encode(array("response" => $response));
			}
			break;
		case "updatewhere":
			$stmt = prepareStatement($conn, $sql, $types, $values);
			/* Execute statement */
			$result = $stmt->execute();
			if ($result){
				//get affected rows
    			$affRows = $conn->affected_rows;
				//the response should be ok
				$output = json_encode(array("response" => "OK", "data" => $affRows));
			} else {
				$response = $conn->error;
				$output = json_encode(array("response" => $response));
			}
			break;
		case "update":
			$stmt = prepareStatement($conn, $sql, $types, $values);
			$result = $stmt->execute();
			if ($result){
				//get affected rows
    			$affRows = $conn->affected_rows;
				//the response should be ok
				$output = json_encode(array("response" => "OK", "data" => $affRows));
			} else {
				$response = $conn->error;
				$output = json_encode(array("response" => $response));
			}
			break;
		case "selectwhere":
			$stmt = prepareStatement($conn, $sql, $types, $values);
			/* Execute statement */
			$result = $stmt->execute();
			if ($result) {
				// Fetch all
				$result = $stmt->get_result();
				$rows = array();
				while ($row = $result->fetch_assoc()) {
					$rows[] = $row;
				}
				$output = json_encode(array("response" => "OK", "data" => $rows));
			} else {
				$response = $conn->error;
				$output = json_encode(array("response" => $response));
			}
			break;
		case "insert":
			$stmt = prepareStatement($conn, $sql, $types, $values);
			/* Execute statement */
			$result = $stmt->execute();
			if ($result) {
				//get last insert id
    			$lastId = $conn->insert_id;
				//get affected rows
    			//$affRows = $conn->affected_rows;
				//the response should be ok
				$output = json_encode(array("response" => "OK", "data" => $lastId));
			} else {
				$response = $conn->error;
				$output = json_encode(array("response" => $response));
			}
			break;
		default:
			if ($conn->query($sql) === TRUE) {
				$response = "OK";
			} else {
				$response = $conn->error;
			}
			$output = json_encode(array("response" => $response));
			break;
	}
		echo($output);
		$conn->close();
	} catch(Exception $e) {
		$conn->rollback();
  		throw $e;
	}
}
#end if