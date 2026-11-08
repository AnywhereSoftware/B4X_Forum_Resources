B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
'version: 1.20
'Class module
Sub Class_Globals
	Type cuContact (Id As Long, DisplayName As String)
	Type cuEmail (Email As String, EmailType As String)
	Type cuPhone (Number As String, PhoneType As String)
	Type cuEvent (DateString As String, EventType As String)
	Type cuOrganization(Company As String, Title As String)
	Private mailTypes, phoneTypes, eventTypes As Map
	Private cr As ContentResolver
	Private dataUri, contactUri, rawContactUri As Uri
	Private GroupSources As Map
End Sub

Public Sub Initialize
	dataUri.Parse("content://com.android.contacts/data")
	contactUri.Parse("content://com.android.contacts/contacts")
	rawContactUri.Parse("content://com.android.contacts/raw_contacts")
	cr.Initialize("cr")
	mailTypes.Initialize
	mailTypes.Put("1", "home")
	mailTypes.Put("2", "work")
	mailTypes.Put("3", "other")
	mailTypes.Put("4", "mobile")
	
	phoneTypes.Initialize
	phoneTypes.Put("1", "home")
	phoneTypes.Put("2", "mobile")
	phoneTypes.Put("3", "work")
	phoneTypes.Put("4", "fax_work")
	phoneTypes.Put("5", "fax_home")
	phoneTypes.Put("6", "pager")
	phoneTypes.Put("7", "other")
	phoneTypes.Put("8", "callback")
	phoneTypes.Put("9", "car")
	phoneTypes.Put("10", "company_main")
	phoneTypes.Put("11", "isdn")
	phoneTypes.Put("12", "main")
	phoneTypes.Put("13", "other_fax")
	phoneTypes.Put("14", "radio")
	phoneTypes.Put("15", "telex")
	phoneTypes.Put("16", "tty_tdd")
	phoneTypes.Put("17", "work_mobile")
	phoneTypes.Put("18", "work_pager")
	phoneTypes.Put("19", "assistant")
	phoneTypes.Put("20", "mms")
	
	eventTypes.Initialize
	eventTypes.Put("1", "anniversary")
	eventTypes.Put("2", "other")
	eventTypes.Put("3", "birthday")
End Sub

'Returns a List with cuContact items based on the given name.
'Name - Name to look for.
'Exact - Whether to search for the exact name or to search for names that contain the given value.
'VisibleOnly - Whether to return only visible contacts.
Public Sub FindContactsByName(Name As String, Exact As Boolean, VisibleOnly As Boolean) As List
	Return FindContactsIdFromData("vnd.android.cursor.item/name", "data1", Name, "=", Exact, VisibleOnly)
End Sub

'Similar to FindContactsByName. Finds contacts based on the mail address.
Public Sub FindContactsByMail(Mail As String, Exact As Boolean, VisibleOnly As Boolean) As List
	Return FindContactsIdFromData("vnd.android.cursor.item/email_v2", "data1", Mail, "=", Exact, VisibleOnly)
End Sub

'Similar to FindContactsByName. Finds contacts based on the notes field.
Public Sub FindContactsByNotes(Note As String, Exact As Boolean, VisibleOnly As Boolean) As List
	Return FindContactsIdFromData("vnd.android.cursor.item/note", "data1", Note, "=", Exact, VisibleOnly)
End Sub

'Similar to FindContactsByName. Finds contacts based on the phone number.
Public Sub FindContactsByPhone(PhoneNumber As String, Exact As Boolean, VisibleOnly As Boolean) As List
	Return FindContactsIdFromData("vnd.android.cursor.item/phone_v2", "data1", PhoneNumber, "=", Exact, VisibleOnly)
End Sub

'Returns the starred contacts.
Public Sub FindContactsByStarred(Starred As Boolean) As List
	Dim value As String
	If Starred Then value = "1" Else value = "0"
	Return FindContactsIdFromData("vnd.android.cursor.item/name", "starred", value,"=", True, True)
End Sub
'Returns all contacts.
Public Sub FindAllContacts(VisibleOnly As Boolean) As List
	Return FindContactsIdFromData("vnd.android.cursor.item/name", "data1", "null", "<>", True, VisibleOnly)
End Sub
'Returns all contacts with a photo.
Public Sub FindContactsWithPhotos As List
	Return FindContactsIdFromData("vnd.android.cursor.item/photo", "data15", "null", "<>", True, False)
End Sub

Public Sub GetNameFromId (id As String) As String
	Dim crsr As Cursor = cr.Query(dataUri, Array As String("contact_id", "display_name"), "contact_id = ?", _
		Array As String(id), "")
	Dim name As String
	If crsr.RowCount = 0 Then
		Log("Contact not found: " & id)
	Else
		crsr.Position = 0
		name = crsr.GetString2(1)
	End If
	crsr.Close
	Return name
End Sub

Private Sub FindContactsIdFromData (Mime As String, DataColumn As String, Value As String, Operator As String, _
	Exact As Boolean, VisibleOnly As Boolean) As List
	If Not(Exact) Then
		Operator = "LIKE"
		Value = "%" & Value & "%"
	End If
	Dim selection As String = "mimetype = ? AND " & DataColumn & " " & Operator & " ? "
	If VisibleOnly Then selection = selection & " AND in_visible_group = 1"
	Dim crsr As Cursor = cr.Query(dataUri, Array As String("contact_id", "display_name"), selection, _
		Array As String(Mime, Value), "")
	Dim res As List
	res.Initialize
	Dim m As Map
	m.Initialize
	For i = 0 To crsr.RowCount - 1
		crsr.Position = i
		Dim cu As cuContact
		cu.Initialize
		cu.Id = crsr.GetLong("contact_id")
		cu.DisplayName = crsr.GetString("display_name")
		If m.ContainsKey(cu.Id) Then Continue
		m.Put(cu.Id, Null)
		res.Add(cu)
	Next
	crsr.Close
	Return res
End Sub

Public Sub GetOrganization(Id As Long) As cuOrganization
	Dim organizations As List = GetData("vnd.android.cursor.item/organization", Array As String("data1", "data4"), _
		Id, Null)
	Dim o As cuOrganization
	If organizations.Size > 0 Then
		o.Initialize
		Dim obj() As Object = organizations.Get(0)
		o.Company = obj(0)
		o.Title = obj(1)
	End If
	Return o
End Sub

'Returns a List with cuEmail items.
Public Sub GetEmails(Id As Long) As List
	Dim res As List
	res.Initialize
	For Each obj() As Object In GetData("vnd.android.cursor.item/email_v2", Array As String("data1", "data2"), Id, Null)
		Dim e As cuEmail
		e.Initialize
		e.Email = obj(0)
		e.EmailType = mailTypes.Get(obj(1))
		res.Add(e)
	Next
	Return res
End Sub
'Returns a List with cuEvents items.
Public Sub GetEvents(Id As Long) As List
	Dim res As List
	res.Initialize
	For Each obj() As Object In GetData("vnd.android.cursor.item/contact_event", Array As String("data1", "data2"), Id, Null)
		Dim e As cuEvent
		e.Initialize
		e.DateString = obj(0)
		e.EventType = eventTypes.Get(obj(1))
		res.Add(e)
	Next
	Return res
End Sub

'Returns a List with cuPhone items.
Public Sub GetPhones(id As Long) As List
	Dim res As List
	res.Initialize
	For Each obj() As Object In GetData("vnd.android.cursor.item/phone_v2", Array As String("data1", "data2"), id, Null)
		Dim p As cuPhone
		p.Initialize
		p.Number = obj(0)
		p.PhoneType = phoneTypes.Get(obj(1))
		res.Add(p)
	Next
	Return res
End Sub

'Returns the note field.
Public Sub GetNote(id As Long) As String
	Dim raw As List = GetData("vnd.android.cursor.item/note", Array As String("data1"), id, Null)
	If raw.Size = 0 Then Return ""
	Dim obj() As Object = raw.Get(0)
	Return obj(0)
End Sub

'Returns the thumbnail photo of the given contact. Returns an uninitialized bitmap if no photo is available.
Public Sub GetPhoto(Id As Long) As Bitmap
	Dim raw As List = GetData("vnd.android.cursor.item/photo", Array As String("data15"), Id, Array As Boolean(True))
	Dim bmp As Bitmap
	If raw.Size > 0 Then
		Dim obj() As Object = raw.Get(0)
		Dim bytes() As Byte = obj(0)
		If bytes <> Null Then
			Dim In As InputStream
			In.InitializeFromBytesArray(bytes, 0, bytes.Length)
			bmp.Initialize2(In)
			In.Close
		End If
	End If
	Return bmp
End Sub

'Gets whether the contact is "starred".
Public Sub GetStarred(Id As Long) As Boolean
	Dim crsr As Cursor = cr.Query(contactUri, Array As String("starred"), "_id = ?", Array As String(Id), "")
	crsr.Position = 0
	Dim starred As Boolean = crsr.GetInt("starred") = 1
	crsr.Close
	Return starred
End Sub


Private Sub GetData(Mime As String, DataColumns() As String, Id As Long, Blobs() As Boolean) As List
	Dim crsr As Cursor = cr.Query(dataUri, DataColumns, "mimetype = ? AND contact_id = ?", _
		Array As String(Mime, Id), "")
	Dim res As List
	res.Initialize
	For i = 0 To crsr.RowCount - 1
		crsr.Position = i
		Dim row(DataColumns.Length) As Object
		For c = 0 To DataColumns.Length - 1
			If  Blobs <> Null And Blobs(c) = True Then
				row(c) = crsr.GetBlob2(c)
			Else
				row(c) = crsr.GetString2(c)
			End If
		Next
		res.Add(row)
	Next
	crsr.Close
	Return res
End Sub
'Sets the note field of the given id.
Public Sub SetNote(Id As Long, Note As String)
	Dim v As ContentValues
	v.Initialize
	v.PutString("data1", Note)
	SetData("vnd.android.cursor.item/note", v, Id, True)
End Sub

Public Sub AddNote(Id As Long, Note As String)
	Dim v As ContentValues
	v.Initialize
	v.PutString("data1", Note)
	SetData("vnd.android.cursor.item/note", v, Id, False)
End Sub


'Adds an email field to the given contact id.
'EmailType - One of the email types strings (see Initialize method).
Public Sub AddEmail(Id As Long, Email As String, EmailType As String)
	Dim v As ContentValues
	v.Initialize
	v.PutString("data1", Email)
	v.PutInteger("data2", GetKeyFromValue(mailTypes, EmailType, 3))
	SetData("vnd.android.cursor.item/email_v2", v, Id, False)
End Sub

'Adds a phone field to the given contact id.
'PhoneType - One of the phone types strings (see Initialize method).
Public Sub AddPhone(Id As Long, PhoneNumber As String, PhoneType As String)
	Dim v As ContentValues
	v.Initialize
	v.PutString("data1", PhoneNumber)
	v.PutInteger("data2", GetKeyFromValue(phoneTypes, PhoneType, 7))
	SetData("vnd.android.cursor.item/phone_v2", v, Id, False)
End Sub

'Deletes the given phone number.
Public Sub DeletePhone(Id As Long, PhoneNumber As String)
	DeleteData("vnd.android.cursor.item/phone_v2", PhoneNumber, Id)
End Sub
'Deletes the given email address.
Public Sub DeleteEmail(Id As Long,Email As String)
	DeleteData("vnd.android.cursor.item/email_v2", Email, Id)
End Sub

'Small utility to find the type integer value from the type name
Private Sub GetKeyFromValue(m As Map, v As String, defaultValue As Int) As Int
	Dim t As Int = defaultValue
	For i = 0 To m.Size - 1
		If m.GetValueAt(i) = v Then
			t = m.GetKeyAt(i)
			Exit
		End If
	Next
	Return t
End Sub

Private Sub DeleteData(Mime As String, Data1Value As String, Id As Long)
	cr.Delete(dataUri, "mimetype = ? AND data1 = ? AND contact_id = ?", Array As String(Mime, Data1Value, Id))
End Sub
Private Sub SetData(Mime As String, Values As ContentValues, Id As Long, Update As Boolean)
	If Update Then
		cr.Update(dataUri, Values, "mimetype = ? AND contact_id = ?", Array As String(Mime, Id))
	Else
		Dim crsr As Cursor = cr.Query(contactUri, Array As String("name_raw_contact_id"), _
			"_id = ?", Array As String(Id), "")
		If crsr.RowCount = 0 Then
			Log("Error getting raw_contact_id")
			crsr.Close
			Return
		End If
		crsr.Position = 0
		Values.PutString("raw_contact_id", crsr.GetString("name_raw_contact_id"))
		crsr.Close
		Values.PutString("mimetype", Mime)
		cr.Insert(dataUri, Values)
	End If
End Sub

'Sets the starred state of the given id.
Public Sub SetStarred (Id As Long, Starred As Boolean)
	Dim values As ContentValues
	values.Initialize
	values.PutBoolean("starred", Starred)
	cr.Update(contactUri, values, "_id = ?", Array As String(Id))
End Sub

'Deletes the contact with the given Id.
Public Sub DeleteContact(Id As Long)
	cr.Delete(rawContactUri, "contact_id = ?", Array As String(Id))
End Sub

'Returns a Map. The keys are the account names and the values are the account types.
Public Sub GetAccounts(Id As Long) As Map
	Dim uri As Uri
	uri.Parse("content://com.android.contacts/contacts/" & Id & "/entities")
	Dim c As Cursor = cr.Query(uri, Array As String("account_name", "account_type"), "", Null, "")
	Dim m As Map
	m.Initialize
	For i = 0 To c.RowCount - 1
		c.Position = i
		m.Put(c.GetString("account_name"), c.GetString("account_type"))
	Next
	c.Close

	Return m
End Sub

Private Sub FillGroupSources
	If GroupSources.IsInitialized = False Then
		GroupSources.Initialize
		Dim gu As Uri
		gu.Parse("content://com.android.contacts/groups")
		Dim c As Cursor = cr.Query(gu, Array As String("sourceid", "title"), "", Null, "")
		For i = 0 To c.RowCount - 1
			c.Position = i
			GroupSources.Put(c.GetString("sourceid"), c.GetString("title"))
		Next
	End If
End Sub

Public Sub GetGroups(Id As Long) As List
	FillGroupSources
	Dim uri As Uri
	uri.Parse("content://com.android.contacts/contacts/" & Id & "/entities")
	Dim c As Cursor = cr.Query(uri, Array As String("group_sourceid"), "", Null, "")
	Dim groups As List
	groups.Initialize
	For i = 0 To c.RowCount - 1
		c.Position = i
		If c.GetString("group_sourceid") <> Null Then
			Dim source As String = c.GetString("group_sourceid")
			If GroupSources.ContainsKey(source) Then
				groups.Add(GroupSources.Get(source))
			End If
		End If
	Next
	c.Close
	Return groups
End Sub

'Inserts a new contact and returns the cuContact object of this contact.
Public Sub InsertContact(Name As String, Phone As String) As cuContact
	Dim values As ContentValues
	values.Initialize
	values.PutNull("account_name")
	values.PutNull("account_type")
	Dim rawUri As Uri = cr.Insert(rawContactUri, values)
	Dim rawContactId As Long = rawUri.ParseId
	
	values.Initialize
	values.PutLong("raw_contact_id", rawContactId)
	values.PutString("mimetype", "vnd.android.cursor.item/phone_v2")
	values.PutString("data1", Phone)
	cr.Insert(dataUri, values)
	
	values.Initialize
	values.PutLong("raw_contact_id", rawContactId)
	values.PutString("mimetype", "vnd.android.cursor.item/name")
	values.PutString("data1", Name)
	cr.Insert(dataUri, values)
	Dim cu As cuContact
	cu.Initialize
	Dim crsr As Cursor = cr.Query(dataUri, Array As String("contact_id", "display_name"), "raw_contact_id = ?", _
		Array As String(rawContactId), "")
	crsr.Position = 0
	cu.DisplayName = crsr.GetString("display_name")
	cu.Id = crsr.GetLong("contact_id")
	Return cu
End Sub

'useful for debugging
Private Sub printCursor(c As Cursor) 'ignore
	For r = 0 To c.RowCount - 1
		c.Position = r
		For col = 0 To c.ColumnCount - 1
			Try
				Log(c.GetColumnName(col) & ": " & c.GetString2(col))
			Catch
				Log(c.GetColumnName(col) & ": " & LastException)
			End Try
		Next
		Log("***************")
	Next
End Sub
