B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Private Sub Class_Globals
	Private lJSONParts As List
	Private sJSONPath As StringBuilder
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	lJSONParts.Initialize
	sJSONPath.Initialize
End Sub

'<code>
'Sub Class_Globals
'	Private Root As B4XView
'	Private xui As XUI
'	Private jsp As JSONPath
'End Sub
'
'Public Sub Initialize
''	B4XPages.GetManager.LogEvents = True
'End Sub
'
''This event will be called once, before the page becomes visible.
'Private Sub B4XPage_Created (Root1 As B4XView)
'	Root = Root1
'	Root.LoadLayout("MainPage")
'	jsp.Initialize
'End Sub
'
''You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
'
'Sub Button1_Click
'	jsp.BuildPath.GetJSONObjectValueWithTheKey("mylists").GetJSONArrayValueInPosition(2).GetJSONArrayValueInPosition(0).GetJSONObjectValueWithTheKey("mykey")
'	Log(jsp.JSONPath)
'	
'	Dim sJSON As String = $"{"mylists":[[{"mykey":"nikos1"},{"mykey":"george1"}],[{"mykey":"nikos2"},{"mykey":"george2"}],[{"mykey":"nikos3"},{"mykey":"george3"}]]}"$
'	Log(jsp.GetValueAccordingToPath(sJSON))
'End Sub
'</code>
Sub Instructions
	
End Sub


Public Sub setJSONPath(sPath As String)
	sJSONPath.Append(sPath)
	lJSONParts.Clear
	lJSONParts.AddAll(Regex.Split(".", sJSONPath.ToString))
End Sub

Public Sub getJSONPath As String
	Return sJSONPath.ToString
End Sub

Public Sub BuildPath As JSONPath
	Try
		sJSONPath.Remove(0, sJSONPath.Length)
	Catch
		Log(LastException)
	End Try
	sJSONPath.Append("JSON")
	Return Me
End Sub


Public Sub GetJSONArrayValueInPosition(ObjectPositionInArray As Int) As JSONPath
	sJSONPath.Append(".").Append("ja").Append($"(${ObjectPositionInArray})"$)
	lJSONParts.Clear
	lJSONParts.AddAll(Regex.Split(".", sJSONPath.ToString))
	Return Me
End Sub

Public Sub GetJSONObjectValueWithTheKey(KeyOfTheObject As String) As JSONPath
	sJSONPath.Append(".").Append("jo").Append($"("${KeyOfTheObject}")"$)
	lJSONParts.Clear
	lJSONParts.AddAll(Regex.Split("\.", sJSONPath.ToString))
	Return Me
End Sub


Public Sub GetValueAccordingToPath(sJSON As String) As Object
	Dim lJSONList As List
	Dim mJSONObject As Map
	Dim oValue As Object

	
	For ii=1 To lJSONParts.Size - 1
		If ii=1 Then
			Dim sJSONPathStep As String = lJSONParts.Get(ii).As(String)
			Dim sBetweenParentheses As String = sJSONPathStep.SubString2(sJSONPathStep.IndexOf("(")+1, sJSONPathStep.IndexOf(")"))
			
			Dim jp As JSONParser
			jp.Initialize(sJSON)
			
			Select Case True
				Case sJSONPathStep.StartsWith("ja")
					lJSONList = jp.NextArray
					oValue = lJSONList.Get(sBetweenParentheses.As(Int))
				Case sJSONPathStep.StartsWith("jo")
					mJSONObject = jp.NextObject
					oValue = mJSONObject.Get(sBetweenParentheses.Replace("""", ""))
			End Select
		End If
		If ii>1 Then
			Dim sJSONPathStep As String = lJSONParts.Get(ii).As(String)
			Dim sBetweenParentheses As String = sJSONPathStep.SubString2(sJSONPathStep.IndexOf("(")+1, sJSONPathStep.IndexOf(")"))
			
			Select Case True
				Case sJSONPathStep.StartsWith("ja")
					lJSONList = oValue
					oValue = lJSONList.Get(sBetweenParentheses.As(Int))
				Case sJSONPathStep.StartsWith("jo")
					mJSONObject = oValue
					oValue = mJSONObject.Get(sBetweenParentheses.Replace("""", ""))
			End Select
		End If
	Next
	
	Return oValue
	
End Sub
