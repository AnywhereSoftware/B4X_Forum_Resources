B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
Sub Class_Globals
	#if B4A
	Private ion As Object
	Private OldIntent As Intent
	#end if
	Type LoadResult (Success As Boolean, Dir As String, FileName As String, RealName As String, Size As Long, Modified As Long, MimeType As String)
	
End Sub

Public Sub Initialize

End Sub

#if B4A
Public Sub SaveAs (Source As InputStream, MimeType As String, Title As String) As ResumableSub
	Dim intent As Intent
	intent.Initialize("android.intent.action.CREATE_DOCUMENT", "")
	intent.AddCategory("android.intent.category.OPENABLE")
	intent.PutExtra("android.intent.extra.TITLE", Title)
	intent.SetType(MimeType)
	StartActivityForResult(intent)
	Wait For ion_Event (MethodName As String, Args() As Object)
	If -1 = Args(0) Then 'resultCode = RESULT_OK
		Dim result As Intent = Args(1)
		Dim jo As JavaObject = result
		Dim ctxt As JavaObject
		Dim ContentResolver As JavaObject = ctxt.InitializeContext.RunMethodJO("getContentResolver", Null)
		Dim out As OutputStream = ContentResolver.RunMethod("openOutputStream", Array(jo.RunMethod("getData", Null), "wt"))
		File.Copy2(Source, out)
		out.Close
		Return True
	End If
	Return False
End Sub

Public Sub Load As ResumableSub
	Dim cc As ContentChooser
	cc.Initialize("cc")
	cc.Show("text/*", "Choose text file")
	Wait For CC_Result (Success As Boolean, Dir As String, FileName As String)
	Dim res As LoadResult = CreateLoadResult(Success, Dir, FileName)
	If res.Success Then ExtractInformationFromURI(res.FileName, res)
	Return res
End Sub

Private Sub StartActivityForResult(i As Intent)
	Dim jo As JavaObject = GetBA
	ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)
	jo.RunMethod("startActivityForResult", Array(ion, i))
End Sub

Private Sub GetBA As Object
	Return Me.As(JavaObject).RunMethod("getBA", Null)
End Sub

Private Sub ExtractInformationFromURI (Uri As String, res As LoadResult)
	Try
		
	Dim resolver As ContentResolver
	resolver.Initialize("")
	Dim u As Uri
	u.Parse(Uri)
	Dim rs As ResultSet = resolver.Query(u, Null, "", Null, "")
	If rs.NextRow Then
		Dim columns As B4XSet = B4XCollections.CreateSet
		For i = 0 To rs.ColumnCount - 1
			columns.Add(rs.GetColumnName(i))
		Next
		If columns.Contains("_display_name") Then res.RealName = rs.GetString("_display_name")
		If columns.Contains("_size") Then res.Size = rs.GetLong("_size")
		If columns.Contains("last_modified") Then res.Modified = rs.GetLong("last_modified")
		If columns.Contains("mime_type") Then res.MimeType = rs.GetString("mime_type")
	End If
	rs.Close
	
	Catch
		Log("error extracting information from file provider")
		Log(LastException)
	End Try
End Sub

Public Sub CheckForReceivedFiles As LoadResult
	Dim Activity As Activity = B4XPages.GetNativeParent(B4XPages.MainPage)
	If IsRelevantIntent(Activity.GetStartingIntent) Then
		Dim in As Intent = Activity.GetStartingIntent
		Dim uri As String
		If in.HasExtra("android.intent.extra.STREAM") Then
			uri = in.As(JavaObject).RunMethod("getParcelableExtra", Array("android.intent.extra.STREAM"))
		Else
			uri = in.GetData
		End If
		Dim res As LoadResult = CreateLoadResult(True, "ContentDir", uri)
		ExtractInformationFromURI(res.FileName, res)
		Return res
	End If
	Return CreateLoadResult(False, "", "")
End Sub

Private Sub IsRelevantIntent(in As Intent) As Boolean
	If in.IsInitialized And in <> OldIntent And in.Action = in.ACTION_VIEW Then
		OldIntent = in
		Return True
	End If
	Return False
End Sub

#else if B4i
Public Sub SaveAs(ParentPage As Object, AnchorView As Object, Text As String) As ResumableSub
	Dim avc As ActivityViewController
	avc.Initialize("avc", Array(Text))
	avc.Show(B4XPages.GetNativeParent(ParentPage), AnchorView)
	Wait For avc_Complete (Success As Boolean, ActivityType As String)
	Return Success
End Sub

Public Sub Load (ParentPage As Object, AnchorView As Object) As ResumableSub
	Dim DocumentPicker As DocumentPickerViewController
	DocumentPicker.InitializeImport("picker", Array("public.text"))
	DocumentPicker.Show(B4XPages.GetNativeParent(ParentPage), AnchorView)
	Wait For Picker_Complete (Success As Boolean, URLs As List)
	If Success And URLs.Size > 0 Then
		Return UrlToLoadResult(URLs.Get(0))
	End If
	Return CreateLoadResult(False, "", "")
End Sub

Public Sub UrlToLoadResult(url As String) As LoadResult
	Dim res As LoadResult = CreateLoadResult(IIf(File.Exists(url, ""), True, False), url, "")
	res.RealName = res.Dir.SubString(res.Dir.LastIndexOf("/") + 1)
	res.Size = File.Size(res.Dir, "")
	Return res
End Sub
#end if

Private Sub CreateLoadResult (Success As Boolean, Dir As String, FileName As String) As LoadResult
	Dim t1 As LoadResult
	t1.Initialize
	t1.Success = Success
	t1.Dir = Dir
	t1.FileName = FileName
	Return t1
End Sub

