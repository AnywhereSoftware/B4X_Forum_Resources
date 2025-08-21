B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#Event: OnDone (success as boolean)

Sub Class_Globals
	Private pCaller As Object
	Private pEventName As String
	Private pEmail As String
	Private pAPIKey As String
	Private pIsSuccessful As Boolean
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize (aCaller As Object, aEventName As String, aEmail As String, aApikey As String)
	pCaller = aCaller
	pEventName = aEventName
	pEmail = aEmail
	pAPIKey = aApikey
End Sub

public Sub UpdateACMEChallenges (zonename As String, challenges() As String) 
	Dim lcv As Int
	pIsSuccessful = True
		
	Wait for (GetZoneID(zonename)) Complete (zoneid As String)
	
	If pIsSuccessful Then
		Wait for (GetDNSRecordIds ("TXT", "_acme-challenge." & zonename, zoneid)) Complete (dnsids As List)
		For lcv = 0 To dnsids.Size - 1
			If pIsSuccessful Then 
				Wait For (RemoveDNSRecord(zoneid, dnsids.Get(lcv))) Complete (statuscode As Int)
			End If
		Next
	End If
	
	If pIsSuccessful Then
		For lcv = 0 To challenges.Length- 1
			If pIsSuccessful Then
				Wait for (CreateDNSRecord(zoneid, "TXT", "_acme-challenge." & zonename, challenges(lcv), 120, -1, False)) Complete (statuscode As Int)
			End If
		Next
	End If
	
	If SubExists (pCaller, pEventName & "_OnDone") Then
		CallSub2(pCaller, pEventName & "_OnDone", pIsSuccessful)
	End If
End Sub

'eg: name = wapps.net
private Sub GetZoneID (name As String) As ResumableSub
	Dim http As HttpJob, url As String = "https://api.cloudflare.com/client/v4/zones?name=" & name
	http.Initialize("http", Me)
	http.Download(url)
	http.GetRequest.SetHeader("X-Auth-Email", pEmail)
	http.GetRequest.SetHeader("X-Auth-Key", pAPIKey)
	http.GetRequest.SetHeader("Content-Type", "application/json")
	
	'see: https://api.cloudflare.com/#zone-list-zones
	wait for (http) JobDone (http As HttpJob)
	Dim js As JSONParser, response As String = http.GetString, statuscode As Int = http.Response.StatusCode
	http.Release
	DoLog(url, statuscode, response)
	js.Initialize(response)
	Dim map1 As Map = js.NextObject
	Dim results As List = map1.Get("result")	
	Dim map2 As Map = results.Get(0)
	
	Return map2.Get("id")	
End Sub

'eg: dnstype = TXT, dnsname = _acme_challenge.wapps.net, zoneid = id as received from GetZoneID
private Sub GetDNSRecordIds (dnstype As String, dnsname As String, zoneid As String) As ResumableSub
	Dim http As HttpJob, url As String = "https://api.cloudflare.com/client/v4/zones/" & zoneid & "/dns_records?type=" & dnstype & "&name=" & dnsname
	http.Initialize("http", Me)
	http.Download(url)
	http.GetRequest.SetHeader("X-Auth-Email", pEmail)
	http.GetRequest.SetHeader("X-Auth-Key", pAPIKey)
	http.GetRequest.SetHeader("Content-Type", "application/json")
	
	'see https://api.cloudflare.com/#dns-records-for-a-zone-list-dns-records
	wait for (http) JobDone (http As HttpJob)
	Dim response As String = http.GetString, statuscode As Int = http.Response.StatusCode
	http.Release
	DoLog(url, statuscode, response)
	Dim js As JSONParser, result As List
	result.Initialize
	
	js.Initialize(response)
	
	Dim map1 As Map = js.NextObject
	Dim results As List = map1.Get("result")
	Dim lcv As Int
	For lcv = 0 To results.Size - 1
		Dim dns As Map = results.Get(lcv)
		result.Add(dns.Get("id"))
	Next
	
	Return result
End Sub

private Sub RemoveDNSRecord (zoneid As String, dnsid As String) As ResumableSub
	Dim http As HttpJob, url As String = "https://api.cloudflare.com/client/v4/zones/" & zoneid & "/dns_records/" & dnsid
	http.Initialize("http", Me)
	http.Delete(url)
	http.GetRequest.SetHeader("X-Auth-Email", pEmail)
	http.GetRequest.SetHeader("X-Auth-Key", pAPIKey)
	http.GetRequest.SetHeader("Content-Type", "application/json")
	
	'see https://api.cloudflare.com/#dns-records-for-a-zone-delete-dns-record
	wait for (http) JobDone (http As HttpJob)
	Dim statuscode As Int = http.Response.StatusCode
	http.Release

	DoLog(url, statuscode, "")
	Return statuscode
End Sub

private Sub CreateDNSRecord (zoneid As String, dnstype As String, dnsname As String, content As String, ttl As Int, priority As Int, proxied As Boolean) As ResumableSub
	'Set POST data
	Dim inp As Map
	inp.Initialize
	inp.Put("type", dnstype)
	inp.Put("name", dnsname)
	inp.Put("content", content)
	inp.Put("ttl", ttl)
	If priority > - 1 Then inp.Put("priority", priority)
	If proxied Then
		inp.Put("proxied", "true")
	Else
		inp.Put("proxied", "false")
	End If
	
	Dim js As JSONGenerator
	js.Initialize(inp)

	'Do POST request
	Dim http As HttpJob, url As String = "https://api.cloudflare.com/client/v4/zones/" & zoneid & "/dns_records"
	http.Initialize("http", Me)
	http.PostString (url, js.ToString)
	http.GetRequest.SetHeader("X-Auth-Email", pEmail)
	http.GetRequest.SetHeader("X-Auth-Key", pAPIKey)
	http.GetRequest.SetHeader("Content-Type", "application/json")
	
	'see https://api.cloudflare.com/#dns-records-for-a-zone-create-dns-record
	wait for (http) JobDone (http As HttpJob)
	Dim statuscode As Int = http.Response.StatusCode
	http.Release

	DoLog(url, statuscode, "")
	Return statuscode
End Sub

private Sub DoLog (url As String, statuscode As Int, response As String) 'ignore
	Log ("[" & statuscode & "] " & url)
End Sub