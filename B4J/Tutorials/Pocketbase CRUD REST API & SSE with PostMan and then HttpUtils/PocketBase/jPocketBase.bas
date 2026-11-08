B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
#Event: ClientToken (Response As String)
#Event: SSE (Action As String, Response As Map)
#Event: Connected (Status As Boolean)
#Event: Disconnected (Status As Boolean)

Sub Class_Globals
	Private baseUrl As String
	Public ClientID As String
	Public UserToken As String
	Private mCallBack As Object
	Private mEvent As String
	Private hc As OkHttpClient
	Private const PackageName As String = "b4j.example" '<------ change as needed
	Public gout As OutputStream
End Sub

'<code>
'Dim pb As jPocketBase
'pb.Initialize(Me, "pb", "http://127.0.0.1:8090/api")
'</code>
Public Sub Initialize(Module As Object, event As String, url As String)
	baseUrl = url
	ClientID = ""
	mCallBack = Module
	mEvent = event
End Sub

'<code>
'Dim u As Map = CreateMap()
'u.Put("email", txtEmail.text)
'u.Put("password", txtpassword.Text)
'u.Put("passwordConfirm", txtConfirmPassword.Text)
'u.Put("username", txtUsername.Text)
'u.Put("name", txtName.Text)
'Wait For(pb.Create("users", u)) Complete (Result As Map)
'txtID.Text = Result.GetDefault("id", "")
'Log(Result)
'</code>
Sub Create(collectionName As String, u As Map) As ResumableSub
	Dim out As Map = CreateMap()
	'convert map
	Dim qs As String = Map2Json(u)
	'
	Dim j As HttpJob
	j.Initialize("pb", Me)
	j.PostString($"${baseUrl}/collections/${collectionName}/records"$, qs)
	j.GetRequest.SetContentType("application/json")
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		out = Json2Map(j.GetString)
	Else	
		out = Json2Map(j.ErrorMessage)
	End If
	j.Release
	Return out
End Sub

'<code>
'Dim u As Map = CreateMap()
'u.Put("identity", txtEmail.text)
'u.Put("password", txtpassword.Text)
'Wait For(pb.authWithPassword(u)) Complete (Result As Map)
'Dim record As Map = Result.Get("record")
'Dim token As String = Result.GetDefault("token","")
'txtToken.Text = token
'txtID.Text = record.GetDefault("id", "")
'Log(Result)
'</code>
Sub authWithPassword(u As Map) As ResumableSub
	Dim out As Map = CreateMap()
	'convert map
	Dim qs As String = Map2Json(u)
	'
	Dim j As HttpJob
	j.Initialize("pb", Me)
	j.PostString($"${baseUrl}/collections/users/auth-with-password"$, qs)
	j.GetRequest.SetContentType("application/json")
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		out = Json2Map(j.GetString)
	Else	
		out = Json2Map(j.ErrorMessage)
	End If
	j.Release
	Return out
End Sub

'<code>
'Dim u As Map = CreateMap()
'u.Put("email", txtEmail.text)
'Wait For(pb.requestPasswordReset(u)) Complete (Result As Map)
'Log(Result)
'</code>
Sub requestPasswordReset(u As Map) As ResumableSub
	Dim out As Map = CreateMap()
	'convert map
	Dim qs As String = Map2Json(u)
	'
	Dim j As HttpJob
	j.Initialize("pb", Me)
	j.PostString($"${baseUrl}/collections/users/request-password-reset"$, qs)
	j.GetRequest.SetContentType("application/json")
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		out = Json2Map(j.GetString)
	Else	
		out = Json2Map(j.ErrorMessage)
	End If
	j.Release
	Return out
End Sub

'<code>
'Dim u As Map = CreateMap()
'u.Put("email", txtEmail.text)
'u.Put("username", txtUsername.text)
'u.Put("oldPassword", txtOldPassword.text)
'u.Put("password", txtpassword.text)
'u.Put("passwordConfirm", txtConfirmPassword.text)
'u.Put("name", txtName.text)
'Wait For(pb.Update("users", "xxx", u)) Complete (Result As Map)
'Log(Result)
'</code>
Sub Update(collectionName As String, id As String, u As Map) As ResumableSub
	Dim out As Map = CreateMap()
	'convert map
	Dim qs As String = Map2Json(u)
	'
	Dim j As HttpJob
	j.Initialize("pb", Me)
	j.PatchString($"${baseUrl}/collections/${collectionName}/records/${id}"$, qs)
	j.GetRequest.SetContentType("application/json")
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		out = Json2Map(j.GetString)
	Else	
		out = Json2Map(j.ErrorMessage)
	End If
	j.Release
	Return out
End Sub

'<code>
'Wait For(pb.Read("users", "xxx")) Complete (Result As Map)
'Log(Result)
'</code>
Sub Read(collectionName As String, id As String) As ResumableSub
	Dim out As Map = CreateMap()
	Dim j As HttpJob
	j.Initialize("pb", Me)
	j.Download($"${baseUrl}/collections/${collectionName}/records/${id}"$)
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		out = Json2Map(j.GetString)
	Else	
		out = Json2Map(j.ErrorMessage)
	End If
	j.Release
	Return out
End Sub

'<code>
'Wait For(pb.Delete("users", "xxx")) Complete (Result As Map)
'Log(Result)
'</code>
Sub Delete(collectionName As String, id As String) As ResumableSub
	Dim out As Map = CreateMap()
	Dim j As HttpJob
	j.Initialize("pb", Me)
	j.Delete($"${baseUrl}/collections/${collectionName}/records/${id}"$)
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		out = Json2Map(j.GetString)
	Else	
		out = Json2Map(j.ErrorMessage)
	End If
	j.Release
	Return out
End Sub

'<code>
'Wait For(pb.ReadPage("users", 1)) Complete (Result As Map)
'Log(Result)
'</code>
Sub ReadPage(collectionName As String, id As String) As ResumableSub
	Dim out As Map = CreateMap()
	Dim j As HttpJob
	j.Initialize("pb", Me)
	j.Download2($"${baseUrl}/collections/${collectionName}/records"$, Array As String("page", id))
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		out = Json2Map(j.GetString)
	Else	
		out = Json2Map(j.ErrorMessage)
	End If
	j.Release
	Return out
End Sub



private Sub Map2QueryString(sm As Map) As String
	' convert a map to a querystring string
	Dim SU As StringUtils
	Dim iCnt As Int
	Dim iTot As Int
	Dim sb As StringBuilder
	Dim mValue As String
	sb.Initialize
	
	' get size of map
	iTot = sm.Size - 1
	iCnt = 0
	For Each mKey As String In sm.Keys
		mValue = sm.Get(mKey)
		mValue = SU.EncodeUrl(mValue, "UTF8")
		mKey = mKey.Trim
		If mKey.EndsWith("=") = False Then mKey = mKey & "="
		sb.Append(mKey).Append(mValue)
		If iCnt < iTot Then sb.Append("&")
		iCnt = iCnt + 1
	Next
	Return sb.ToString
End Sub

private Sub Json2Map(jsonText As String) As Map
	Dim json As JSONParser
	Dim Map1 As Map
	Map1.Initialize
	Try
		If jsonText.length > 0 Then
			json.Initialize(jsonText)
			Map1 = json.NextObject
		End If
		Return Map1
	Catch
		Return Map1
	End Try
End Sub

private Sub Map2Json(m As Map) As String
	Dim gen As JSONGenerator
	Dim outJSON As String
	gen.Initialize(m)
	outJSON = gen.ToString
	Return outJSON
End Sub

Sub Map2JsonPretty(m As Map) As String
	Dim gen As JSONGenerator
	Dim outJSON As String
	gen.Initialize(m)
	outJSON = gen.ToPrettyString(4)
	Return outJSON
End Sub

Sub Connect2SSE As ResumableSub
	hc.Initialize("hc")
	Dim req As OkHttpRequest
	req.InitializeGet($"${baseUrl}/realtime"$)
	hc.Execute(req, 0)
	Return True
End Sub

Sub DisconnectSSE
	If gout.IsInitialized Then 
		gout.Flush
		gout.Close
	End If
End Sub

Private Sub hc_ResponseError (Response As OkHttpResponse, Reason As String, StatusCode As Int, TaskId As Int)
	Log("Error: " & StatusCode)
	Response.Release
End Sub

Private Sub hc_ResponseSuccess (Response As OkHttpResponse, TaskId As Int)
	CallSubDelayed2(mCallBack, mEvent & "_Connected", True)
	Dim out As JavaObject
	out.InitializeNewInstance($"${PackageName}.jpocketbase$MyOutputStream"$, Array(Me))
	gout = out
	Response.GetAsynchronously("req", out, False, 0)
	Wait For req_StreamFinish (Success As Boolean, TaskId As Int)
	CallSubDelayed2(mCallBack, mEvent & "_Disconnected", True)
End Sub

Private Sub Data_Available (Buffer() As Byte)
	Dim out As String = BytesToString(Buffer, 0, Buffer.Length, "UTF-8")
	'the event will possibly have 3 items, id, event & data
	'replace the control characters
	Dim items As List = StrParse(CRLF, out)
	If items.Size = 3 Then
		Dim strID As String = items.Get(0)
		Dim strEvent As String = items.Get(1)
		Dim strData As String = items.Get(2)
		'
		strID = strID.replace("id:", "")
		strEvent = strEvent.replace("event:", "")
		If strData.StartsWith("\{") = False Then
			strData = "{" & strData & "}"
		End If
		'
		Select Case strEvent
		Case "PB_CONNECT"
			ClientID = strID
			CallSubDelayed2(mCallBack, mEvent & "_ClientToken", ClientID)
		Case Else
			Dim m As Map = Json2Map(strData)
			Dim action As String = m.Get("data").As(Map).Get("action")
			Dim record As Map = m.Get("data").As(Map).Get("record")
			CallSubDelayed3(mCallBack, mEvent & "_SSE", action, record )
		End Select
	End If
End Sub

Sub Subscribe(collections As List) As ResumableSub
	Dim out As Map = CreateMap()
	out.Put("clientId", ClientID)
	out.Put("subscriptions", collections)
	'convert map
	Dim qs As String = Map2Json(out)
	'
	Dim j As HttpJob
	j.Initialize("pb", Me)
	j.PostString($"${baseUrl}/realtime"$, qs)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		j.Release
		Return True
	Else
		j.Release
		Return False
	End If
End Sub

private Sub StrParse(Delimiter As String, MV As String) As List
	Delimiter = FixDelimiter(Delimiter)
	Dim spData() As String = Regex.Split(Delimiter, MV)
	Dim lst As List
	lst.Initialize
	lst.AddAll(spData)
	Return lst
End Sub

private Sub FixDelimiter(sValue As String) As String
	If sValue = "|" Then sValue = "\|"
	If sValue = "." Then sValue = "\."
	If sValue = "\" Then sValue = "\\"
	If sValue = "^" Then sValue = "\^"
	If sValue = "$" Then sValue = "\$"
	If sValue = "?" Then sValue = "\?"
	If sValue = "*" Then sValue = "\*"
	If sValue = "+" Then sValue = "\+"
	If sValue = "(" Then sValue = "\("
	If sValue = ")" Then sValue = "\)"
	If sValue = "[" Then sValue = "\["
	If sValue = "]" Then sValue = "\]"
	If sValue = "{" Then sValue = "\{"
	If sValue = "}" Then sValue = "\}"
	If sValue = ";" Then sValue = "\;"
	Return sValue
End Sub

#if Java
import java.io.*;
public static class MyOutputStream extends OutputStream {
    B4AClass cls;
    private boolean closed;
    public MyOutputStream (B4AClass cls) {
        this.cls = cls;
    }
   
    public void write(int b) throws IOException {
        if (closed)
            throw new IOException("closed");
        cls.getBA().raiseEventFromDifferentThread (null, null, 0, "data_available", true, new Object[] {new byte[] {(byte)b}});
    }
    public void write(byte b[], int off, int len) throws IOException {
        if (closed)
            throw new IOException("closed");
        byte[] bb = new byte[len];
        System.arraycopy(b, off, bb, 0, len);
        cls.getBA().raiseEventFromDifferentThread (null, null, 0, "data_available", true, new Object[] {bb});
    }
    public void close() {
        closed = true;
    }
}
#End If
