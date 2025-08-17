B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX

End Sub

Public Sub GetCountries(SortField As String,SortAscending As Boolean) As List
	
	
	Dim AndFilters As List
	AndFilters.Initialize
	
	Dim F As Filters
	F.Initialize
	
	
	'Using regex so we can do a case insensitive search. (?i) Turns on case insensitve match in Regex
	
	If Main.tfCountry.Text <> "" Then
		AndFilters.Add(F.Regex_(AccessDB.DOC_COUNTRY,$"(?i)${Main.tfCountry.Text}"$))
	End If
	
	If Main.tfAbbrev.Text <> "" Then
		AndFilters.Add(F.Regex_(AccessDB.DOC_ABBREVIATION,$"(?i)${Main.tfAbbrev.Text}"$))
	End If
	If Main.tfCity.Text <> "" Then
		AndFilters.Add(F.Regex_(AccessDB.DOC_CITY,$"(?i)${Main.tfcity.Text}"$))
	End If
	If Main.tfContinent.Text <> "" Then
		AndFilters.Add(F.Regex_(AccessDB.DOC_CONTINENT,$"(?i)${Main.tfContinent.Text}"$))
	End If
	If Main.tfCurrency.Text <> "" Then
		AndFilters.Add(F.Regex_(AccessDB.DOC_CURRENCY_NAME,$"(?i)${Main.tfCurrency.Text}"$))
	End If
	
	'It is important that the search parameters are of the same type as the data contained in the fields.
	If Main.tfPopMin.Text <> "" Then
		AndFilters.Add(F.Gte(AccessDB.DOC_POPULATION,NE_Utils.ToInt(Main.tfPopMin.Text)))
	End If
	If Main.tfPopMax.Text <> "" Then
		AndFilters.Add(F.Lte(AccessDB.DOC_POPULATION,NE_Utils.ToInt(Main.tfPopMax.Text)))
	End If
	If Main.tfTempMin.Text <> "" Then
		AndFilters.Add(F.Gte(AccessDB.DOC_TEMPERATURE,NE_Utils.ToDouble(Main.tfTempMin.Text)))
	End If
	If Main.tfTempMax.Text <> "" Then
		AndFilters.Add(F.Lte(AccessDB.DOC_TEMPERATURE,NE_Utils.ToDouble(Main.tfTempMax.Text)))
	End If
	
	Dim Collection As NitriteCollection = AccessDB.DB.GetCollection("countries")
	Log(Collection.Size)
	
	Dim FO As FindOptions = FindOptions_Static.Sort(SortField,SortAscending)
	
	
	If AndFilters.Size > 0 Then
		Return Collection.Find3(F.And_(NE_Utils.ToArray(AndFilters)),FO).ToList
	Else
		Return Collection.Find4(FO).ToList
	End If
	
	
End Sub



