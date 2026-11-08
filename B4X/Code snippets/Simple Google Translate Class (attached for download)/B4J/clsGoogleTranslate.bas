B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'sl - source language code (auto For autodetection)
'tl - translation language
'q - source Text / word
'ie - encoding of the input (default: utf-8)
'oe - encoding of the output, the results (default: utf-8)
'dt - may be included more than once And specifies what To Return in the reply.
't - translation of source Text
'at - alternate translations
'rm - transcription / transliteration of source And translated texts
'bd - dictionary, in Case source Text Is one word (you get translations with articles, reverse translations, etc.)
'md - definitions of source Text, If it's one word
'ss - synonyms of source Text, If it's one word
'ex - examples
'rw - See also list.
'dj - Json response with names. (dj = 1)
'hl - language of the interface (default:en)
'srcrom - seems To be present when the source Text has no spelling suggestions

'fr - frances
'en - engles
'it - italian

'Text translator between languages
'Default.
'Source: "auto" (auto detect language)
'Target: "en" (english)
Sub Class_Globals
	Private mSource = "auto" As String
	Private mTarget = GetDeviceLanguage As String
End Sub

'Initialize language translator
Public Sub Initialize As clsGoogleTranslate
	Return Me
End Sub

'Initialize source lenguage
'Default: "auto" (auto detect language)
Public Sub Source(mSourceLenguage As String)  As clsGoogleTranslate
	mSource = mSourceLenguage
	Return Me
End Sub

'Initialize target lenguage
'Default device language
Public Sub Target(mTargetLenguage As String)  As clsGoogleTranslate
	mTarget = mTargetLenguage
	Return Me
End Sub

'Sets the texts to translate.
Public Sub Text(Query As String) As ResumableSub
	Dim Result As String
	If Query.Trim.Length = 0 Then Return Result

	Dim Link As String = "https://translate.google.com/m?"
	Dim Parameters() As String = Array As String ("sl", mSource, "tl", mTarget, "q", Regex.Replace("\n",Query.Trim,""))

	Wait For (GetHttpGoogleTraslate(Link, Parameters)) Complete (RequestResult As String)
	If RequestResult.Trim.Length = 0 Then 
		Return RequestResult
	End If

	Result = GetClassHtmlValue(RequestResult, "result-container")
	Return Result.Trim
End Sub

Private Sub GetHttpGoogleTraslate(Link As String, Parameters() As String) As ResumableSub
	Dim Result As String
	Dim j As HttpJob
	Try
		j.Initialize("", Me)
		j.Download2(Link, Parameters)
		j.GetRequest.SetHeader("Content-Type", "text/html; charset=utf-8")
		j.GetRequest.Timeout = 60 * DateTime.TicksPerSecond
		Wait For (j) JobDone(j As HttpJob)
		If j.Success Then
			Result = j.GetString
		End If
	Catch
		Log(LastException)
	End Try
	j.Release
	Return Result
End Sub

Public Sub GetClassHtmlValue(Html As String, ClassName As String) As String
	Dim Result, Pattern As String = $"<*.*class="[^"]*?${ClassName}[^"]*?">(.*?)<\/*.*?>"$
	Dim Matcher As Matcher = Regex.Matcher(Pattern, Html)
	If Matcher.Find Then Result = Matcher.Group(1)
	Return Result
End Sub

Private Sub GetDeviceLanguage As String
	Dim jo As JavaObject
	jo = jo.InitializeStatic("java.util.Locale").RunMethod("getDefault", Null)
	Return jo.RunMethod("getLanguage", Null)
End Sub