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

Public Sub GetAddresses(SortField As String,SortAscending As Boolean) As List
	
	
	Dim AndFilters As List
	AndFilters.Initialize
	
	Dim F As Filters
	F.Initialize
	
	
	'Using regex so we can do a case insensitive search. (?i) Turns on case insensitve match in Regex
	
	If Main.tfFirstName.Text <> "" Then
		AndFilters.Add(F.Regex_(AccessDB.DOC_FIRST_NAME,$"(?i)${Main.tfFirstName.Text}"$))
	End If
	
	If Main.tfLastName.Text <> "" Then
		AndFilters.Add(F.Regex_(AccessDB.DOC_LAST_NAME,$"(?i)${Main.tfLastName.Text}"$))
	End If
	If Main.tfCompanyName.Text <> "" Then
		AndFilters.Add(F.Regex_(AccessDB.DOC_COMPANY_NAME,$"(?i)${Main.tfCompanyName.Text}"$))
	End If
	If Main.tfAddress.Text <> "" Then
		AndFilters.Add(F.Regex_(AccessDB.DOC_ADDRESS,$"(?i)${Main.tfAddress.Text}"$))
	End If
	If Main.tfCity.Text <> "" Then
		AndFilters.Add(F.Regex_(AccessDB.DOC_CITY,$"(?i)${Main.tfCity.Text}"$))
	End If
	
	'It is important that the search parameters are of the same type as the data contained in the fields.
	If Main.tfPostcode.Text <> "" Then
		AndFilters.Add(F.Regex_(AccessDB.DOC_POSTCODE,$"(?i)${Main.tfPostcode.Text}"$))
	End If
	If Main.tfCounty.Text <> "" Then
		AndFilters.Add(F.Regex_(AccessDB.DOC_COUNTY,$"(?i)${Main.tfCounty.Text}"$))
	End If
	
	Dim Collection As NitriteCollection = AccessDB.DB.GetCollection(AccessDB.COLLECTION_NAME)
	
	Dim FO As FindOptions = FindOptions_Static.Sort(SortField,SortAscending)
	
	
	If AndFilters.Size > 0 Then
		Return Collection.Find3(F.And_(NE_Utils.ToArray(AndFilters)),FO).ToList
	Else
		Return Collection.Find4(FO).ToList
	End If
	
	
End Sub



