B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.8
@EndOfDesignText@
'Author: T201016
'Module Class Version 1.01
Sub Class_Globals
	Private sql As SQL
	Public  strings As Map
	Public  Locale  As String
	Public  Device  As String
	Public  UsrLng  As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize (Dir As String, FileName As String)
	Dim folder As String
	Dim NumberOfMatches As Int

	If Dir = File.DirAssets Then
		folder = File.DirInternal
		File.Copy(Dir, FileName, folder, "strings.db")
	Else
		folder = Dir
	End If

	sql.Initialize(folder, "strings.db", False)
	strings.Initialize

	Device = FindLocale

    #Region  *** Preference Manager 
	If Main.pmr.GetAll.Size = 0 Then 'if size = 0 then set default
		Main.pmr.SetString ("lang", Device)
	End If
	Locale = Main.pmr.GetString("lang")
	UsrLng = Locale
	#End Region
	
	NumberOfMatches = sql.ExecQuerySingleResult2("SELECT count(*) FROM data WHERE lang = ?", Array As String(Locale))
	If NumberOfMatches = 0 Then
		Locale = "en"
		UsrLng = "en"
	End If
	LoadStrings
End Sub

'Forces the localizator to use a specific language (two letters code)
Public Sub ForceLocale(Language As String)
	Locale = Language
	LoadStrings
End Sub

Private Sub LoadStrings
	strings.Clear
	Dim rs As ResultSet = sql.ExecQuery2("SELECT key, value FROM data WHERE lang = ?", Array As String(Locale))
	Do While rs.NextRow
		strings.Put(rs.GetString2(0), rs.GetString2(1))
	Loop
	rs.Close
End Sub

'Localizes the items from the list and returns a new list.
Public Sub LocalizeList(Items As List) As List
	Dim res As List
	res.Initialize
	For Each s As String In Items
		res.Add(Localize(s))
	Next
	Return res
End Sub

'Localizes the given key.
'If the key does not match then the key itself is returned.
'Note that the key matching is case insensitive.
Public Sub Localize(Key As String) As String
	Return strings.GetDefault(Key.ToLowerCase, Key)
End Sub

'Localizes a key with one or more parameters. The parameters need to be defined in the values.
Public Sub LocalizeParams(key As String, Params As List) As String
	Dim value As String = Localize(key)
	For i = 0 To Params.Size - 1
		value = value.Replace("{" & (i + 1) & "}", Params.Get(i))
	Next
	Return value
End Sub

Public Sub LocalizeLayout(PanelOrActivity As Panel)
	For Each v As View In PanelOrActivity.GetAllViewsRecursive
		If v Is Label Then 'this will catch all of Label subclasses which includes EditText, Button and others
			Dim lbl As Label = v
			lbl.Text = Localize(lbl.Text)
		End If
		If v Is EditText Then
			Dim et As EditText = v
			et.Hint = Localize(et.Hint)
		End If
	Next
End Sub

Public Sub FindLocale As String
	Dim jo As JavaObject
	jo = jo.InitializeStatic("java.util.Locale").RunMethod("getDefault", Null)
	Return jo.RunMethod("getLanguage", Null)
End Sub

'Returns the current locale.
Public Sub getLanguage As String
	Return Locale
End Sub