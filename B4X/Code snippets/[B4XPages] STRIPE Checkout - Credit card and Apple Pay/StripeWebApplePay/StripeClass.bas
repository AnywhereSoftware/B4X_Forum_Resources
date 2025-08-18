B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.01
@EndOfDesignText@
'
'STRIPE comms Class
'Version 1.0
'(c) 2020, Digitwell Solutions Ltd
' STRIPE API Reference https://stripe.com/docs/api
' Requires StringUtils, (ok)HTTP and (ok)HTTPUTils, JSON

Sub Class_Globals
	Private StripeAPIKey   As String 'ignore
	Private StripeOtherKey As String

	Private xui As XUI


	Private CallReturns As Map
	Public const CR_UNKNOWN As Int = -1
	Public const CR_OK         As Int = 200
	Public const CR_BADREQUEST As Int = 400
	Public const CR_UNAUTHORISED As Int = 401
	Public const CR_REQUESTFAILED As Int = 402
	Public const CR_NOTFOUND As Int = 404
	Public const CR_CONFLICT As Int = 409
	Public const CR_TOOMANYREQUESTS As Int = 429
	Public const CR_ANY500 As Int = 500
	
	Public const STRIPEURL As String = "https://api.stripe.com/v1"
	
	Public const stURLCheckoutSession As String = STRIPEURL& "/checkout/sessions"
	

	Public LastError As String
	Public LastResponseCode As Int
	
	Private su As StringUtils

End Sub

'Initializes the object. Expects thew API keys. Can be called multiple times
public Sub Initialize(apikey As String, otherkey As String)
	
	Log("initialising stripe")
	CallReturns.Initialize
	CallReturns.Put(CR_UNKNOWN,"unknown error")
	CallReturns.Put(CR_OK,"ok")
	CallReturns.Put(CR_BADREQUEST,"The request was unacceptable")
	CallReturns.Put(CR_UNAUTHORISED,"The API key is not valid")
	CallReturns.Put(CR_REQUESTFAILED,"Request has failed")
	CallReturns.Put(CR_NOTFOUND,"Request has failed")
	CallReturns.Put(CR_CONFLICT,"Request has failed")
	CallReturns.Put(CR_TOOMANYREQUESTS,"Request has failed")
	CallReturns.Put(CR_ANY500,"Internal Server Error")

	StripeAPIKey = apikey
	StripeOtherKey = otherkey

End Sub



#region Checkout Sessions

public Sub CreateACheckoutSession(callb As Object, SessionInfo As Map)
	wait for (CreateRemoteCheckoutSession(SessionInfo)) complete (ret As Map)
	If (xui.SubExists(callb,"STC_CreateCheckoutSession",1)) Then	CallSubDelayed2(callb,"STC_CreateCheckoutSession",ret) 'ignore
	
End Sub


private Sub CreateRemoteCheckoutSession(checkoutinfo As Map) As ResumableSub
	Private ret As Map
	Private job As HttpJob
	Private urlstr As String = convertMaptoURLEncode(checkoutinfo)
	
	
	Private su As StringUtils
'	Log($"URL STRING Is ${su.DecodeUrl(urlstr,"UTF8")}"$)
	LastError = ""
	
	job.Initialize("",Me)
	job.PostString(stURLCheckoutSession , urlstr)
	job.GetRequest.SetHeader("Authorization","Bearer "&StripeOtherKey)
	job.GetRequest.SetContentType("application/x-www-form-urlencoded")
	Wait For (job) JobDone(job As HttpJob) : LastResponseCode = job.response.Statuscode
	If (job.Success) Then
		ret = ParseCreateRemoteCheckoutSession(job.GetString)
	Else
		LastError = job.ErrorMessage
		ret = CreateMap("error":job.ErrorMessage)
	End If
	
	ret = BuildReturnMap(job.Success,LastResponseCode,ret)
	job.Release
	Return ret
End Sub

private Sub ParseCreateRemoteCheckoutSession(s As String) As Map
'	Log("CheckoutSession" & s)
	Return GetMapReturn(s)
End Sub


#end region


#region Helper Functions

public Sub ExtractStripeError(resp As String) As String
	Private retn As String = ""
	
	Private g As JSONParser
	g.Initialize(resp)
	
	Try
		Private mp As Map = g.NextObject
		Private err As Map = mp.getdefault("error",CreateMap())
		
		retn = $"${err.GetDefault("code","")} ${err.GetDefault("message","")}"$
	Catch
		retn = ""
	End Try
	
	Return retn
End Sub

private Sub GetMapReturn(s As String) As Map
	Private ParseR As JSONParser
	Private ret As Map
	ParseR.Initialize(s)
	
	Try
		ret = ParseR.NextObject
	Catch
		ret.Initialize
		LastError = LastException.Message
	End Try
	
	Return ret
End Sub

private Sub convertMaptoURLEncode(mp As Map) As String
	Private s As String = ""
	Private needand As Boolean = False
	
	For Each ky As String In mp.Keys
		Private o As Object = mp.Get(ky)
		If needand Then
			s = s & "&"
		End If
		If o Is Map Then
			Private m As Map = o
			s = s & convertSubMaptoURLEncode(ky,m,ky)
		else if checkfornumber(o) Then
			Private n As Double = o
			s = s & ky & "="& NumberFormat2(n,0,2,0,False)
		Else
			Private st As String = o
			s = s & ky & "=" &su.EncodeUrl(st,"UTF8")
		End If
		needand = True
	Next
	Return s
End Sub

private Sub convertSubMaptoURLEncode(prefix As String,mp As Map,prevprefix As String) As String
	Private s As String = ""
	Private needand As Boolean = False
	Private actprefix As String = ""
	If (prevprefix.Length > 0) Then
		actprefix = ""
	Else
		actprefix = prefix
	End If


	For Each ky As String In mp.Keys
		Private o As Object = mp.Get(ky)
		If needand Then
			s = s & "&"
		End If
		If (o Is Map) Then
			Private m As Map = o
			
			s = s & convertSubMaptoURLEncode(ky,M,prevprefix & "["&ky & "]")
		else If checkfornumber(o) Then
			#if B4a
			Private n As Int = o
			#else if B4I
			Private n As Double = o
			#End If
			s = s & prevprefix & su.EncodeUrl(actprefix & "["&ky & "]","UTF8")&"="& NumberFormat2(n,0,0,0,False)
		Else
			Private st As String = o
			s = s & prevprefix & su.EncodeUrl(actprefix & "["&ky & "]","UTF8")&"="& su.EncodeUrl(st,"UTF8")
		End If
		needand = True
	Next
	Return s
	
End Sub

Sub checkfornumber(o As Object ) As Boolean
	If (o Is Int Or o Is Long Or o Is Float Or o Is Double) Then Return True
	Return False
End Sub

' Returns True, if there was an error, false if not.
Sub checkiferrorobject(obj As Map) As Boolean   'ignore
	If Not(LastResponseCode = CR_OK) Then
		Return True
	End If
	
	If (obj.Size = 1 And obj.ContainsKey("error")) Then
		Return True
	End If
	
	Return False
End Sub

private Sub BuildReturnMap(success As Boolean,resp As Int,data As Map) As Map
	Private mp As Map = CreateMap()
	mp.Put("success",success)
	mp.Put("responsecode",resp)
	mp.Put("data",data)
	
	Return mp
End Sub

#end region Helper Functions

