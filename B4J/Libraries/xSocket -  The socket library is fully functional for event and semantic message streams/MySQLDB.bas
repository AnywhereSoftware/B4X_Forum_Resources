B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private mysql As SQL
	Type DictEntries(DicName As String, Word As String, DicContent As String)
End Sub

Public Sub Initialize
	mysql.Initialize("com.mysql.cj.jdbc.Driver", $"jdbc:mysql://localhost:3306/${Main.config.Get("DATABASE")}?user=${Main.config.Get("USER")}&password=${Main.config.Get("PASS")}&useUnicode=True&characterEncoding=utf8"$)
End Sub

Public Sub GetTuDien(word As String) As String
	Dim Cursor As ResultSet
	Cursor = mysql.ExecQuery($"SELECT word,mean,dic FROM tudien_2 WHERE word = '${word}'"$)
	Dim lst As List
	lst.Initialize
	
	Do While Cursor.NextRow
		Dim word As String = Cursor.GetString("word")
		Dim mean As String = Cursor.GetString("mean")
		Dim dic As String = Cursor.GetString("dic")
		Dim item As DictEntries
		item.Initialize
		item.Word = word
		item.DicContent = mean
		item.DicName = ConvertDictName(dic)
		lst.Add(item)
	Loop
	
	Dim jfile As jFileSupport
	Dim json As String = jfile.ObjectClassToJSON(lst)
		
	Return json
End Sub

Public Sub GetPaliDigital(word As String) As String
	Dim Cursor As ResultSet
	Cursor = mysql.ExecQuery($"SELECT word,mean FROM indexsearch_2 WHERE word = '${word}'"$)
	Dim lst As List
	lst.Initialize
	
	Do While Cursor.NextRow
		Dim word As String = Cursor.GetString("word")
		Dim mean As String = Cursor.GetString("mean")
		
		Dim item As DictEntries
		item.Initialize
		item.Word = word
		item.DicContent = mean
		item.DicName = "Pali Digital"
		lst.Add(item)
	Loop
	
	Dim jfile As jFileSupport
	Dim json As String = jfile.ObjectClassToJSON(lst)
		
	Return json
End Sub

Public Sub GetSanskrit(word As String) As String
	Dim Cursor As ResultSet
	Cursor = mysql.ExecQuery($"SELECT word,mean,dic FROM sanskrit_2 WHERE word = '${word}'"$)
	Dim lst As List
	lst.Initialize
	
	Do While Cursor.NextRow
		Dim word As String = Cursor.GetString("word")
		Dim mean As String = Cursor.GetString("mean")
		Dim dic As String = Cursor.GetString("dic")
		
		Dim item As DictEntries
		item.Initialize
		item.Word = word
		item.DicContent = mean
		item.DicName = ConvertDictName(dic)
		lst.Add(item)
	Loop
	
	Dim jfile As jFileSupport
	Dim json As String = jfile.ObjectClassToJSON(lst)
		
	Return json
End Sub

Sub ConvertDictName(dicshort As String) As String
	Dim Cursor As ResultSet
	Cursor = mysql.ExecQuery($"SELECT dic_info FROM info_dictionary WHERE dic_short = '${dicshort}'"$)
	Dim dicinfo As String
	Do While Cursor.NextRow
		dicinfo = Cursor.GetString("dic_info")		
	Loop
		
	Return dicinfo
End Sub