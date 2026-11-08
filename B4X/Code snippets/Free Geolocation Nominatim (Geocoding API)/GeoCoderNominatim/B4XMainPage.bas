B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private TextArea1 As B4XView
	Private TextArea2 As B4XView
	Private B4XFloatTextField1 As B4XFloatTextField
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "GeoCoderNominatim")

	B4XFloatTextField1.SmallLabelTextSize = 6
	B4XFloatTextField1.HintLabelSmallOffsetX = 10
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub B4XFloatTextField1_TextChanged (Old As String, New As String)
	TextArea1.Text = ""
	TextArea2.Text = ""
End Sub

Private Sub B4XFloatTextField1_EnterPressed
	Dim Search As String = B4XFloatTextField1.Text
	
	TextArea1.Text = ""
	TextArea2.Text = ""

	If Search.Length = 0 Then Return
	
	B4XFloatTextField1.TextField.Enabled = False
	
	Wait For (GeoCoderNominatim(Search)) Complete (Result As String)
	
	TextArea1.Text = JsonPretty(Result)
	
	If isJson(Result) Then
		Dim Coordinates As Map = GetGeoCoder(Result)
		TextArea2.Text = Coordinates.Get("lat") & ", " & Coordinates.Get("lon") & CRLF & Coordinates.Get("display_name")
	End If
	
	B4XFloatTextField1.TextField.Enabled = True
End Sub

Sub GeoCoderNominatim(Query As String) As ResumableSub
	Dim ResultURL As String
	Dim j As HttpJob
	Dim Parameter() As String = Array As String ("q", Query, "format", "json", "limit", "1", "addressdetails", "1")
	Try
		j.Initialize("", Me)
		j.Download2("https://nominatim.openstreetmap.org/search", Parameter)
		j.GetRequest.SetHeader("Content-Type","application/json")
		Wait For (j) JobDone(j As HttpJob)
		If j.Success Then
			ResultURL = j.GetString
		Else
			Log(j.ErrorMessage)
		End If
	Catch
		Log(LastException)
	End Try
	j.Release
	Return ResultURL
End Sub

Public Sub GetGeoCoder(JsonText As String) As Map
	Dim Result As Map
	Try
		Dim JSON As JSONParser
		JSON.Initialize(JsonText)
		Dim mRoot As List = JSON.NextArray
		Result = mRoot.Get(0)
	Catch
		Log(LastException)
	End Try
	Return Result
End Sub

Public Sub JsonPretty(JsonText As String) As String
	Dim Result As String
	Try
		Dim JSON As JSONParser
		JSON.Initialize(JsonText)
		Dim mRoot As List = JSON.NextArray
		Dim JSONGenerator As JSONGenerator
		JSONGenerator.Initialize2(mRoot)
		Result = JSONGenerator.ToPrettyString(2)
	Catch
		Log(LastException)
	End Try
	Return Result
End Sub

Public Sub isJson(JsonText As String) As Boolean
	If Regex.IsMatch($"[{\[]{1}([,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t]|".*?")+[}\]]{1}"$, JsonText.Trim) And JsonText.Length > 2  Then Return True
	Return False
End Sub
