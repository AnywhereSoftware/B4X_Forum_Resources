B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'VivaWalletLocalEFTPOS... using this API:
'https://developer.vivawallet.com/apis-for-point-of-sale/card-terminals-devices/peer-to-peer-communication/point-to-point-protocol-rest-api/#section/Get-Support
'This Class created by Georgios Kantzas, Magma
'Anything you need... you can find me at B4X Forum as Magma...

Sub Class_Globals
	Private fx As JFX
'set from outside - before transactions
	Public aadeProviderId As String ="" 'DEMO: "999"
	Public aadeProviderSignatureData As String=""
	Public aadeProviderSignature As String=""

'-----------------
	Public state As String
	Public sType As String
	Public transactionId As String
	Public aadeTransactionId As String
	Public isSuccess As Boolean
	Public isAbortRequested As Boolean
	Public message As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

public Sub LocalRequestSalesPayment(iptopost As String,  sessionid As String, amount As Int) As ResumableSub
	
	
	Private j As HttpJob
	j.Initialize("viva",Me)

	Dim m As Map = CreateMap("sessionId": sessionid, "amount": amount)
	
	m.Put("aadeProviderId",aadeProviderId)
	m.Put("aadeProviderSignature",aadeProviderSignature)
	m.Put("aadeProviderSignatureData",aadeProviderSignatureData)
	
	Dim json As String = m.As(JSON).ToString
	
	Log(json)

	j.postString(iptopost & "/pos/v1/sale",json)

	J.GetRequest.SetContentType("application/json")

	Wait For (j) JobDone(j As HttpJob)

	If j.Success=True Then

		Dim jsonstring As String=j.GetString
		Dim m As Map = jsonstring.As(JSON).ToMap 'ignore
		state=m.Get("state")
		sType=m.Get("sessionType")

		j.release

		Return True

	Else
		j.Release
		Return False
	End If

End Sub


public Sub LocalRetrieveSessionbyId(iptopost As String, sessionID1 As String) As ResumableSub
	
	
	Private j As HttpJob
	j.Initialize("viva",Me)
	
	j.download(iptopost & "/pos/v1/sessions/" & sessionID1)

	Wait For (j) JobDone(j As HttpJob)
	
	If j.Success=True Then

		Dim jsonstring As String=j.GetString.As(String)'.Replace(QUOTE,"'")

		Dim parser As JSONParser
		parser.Initialize(jsonstring)

		Log(jsonstring)
		Dim m As Map = parser.NextObject 
		state=m.Get("state")
		sType=m.Get("sessionType")
		
		
		If m.ContainsKey("payloadData")=True Then
			Dim payloaddata As Map = m.get("payloadData")
			
			If payloaddata.ContainsKey("cancelResponse")=True Then 
				Dim abortresponse As Map = payloaddata.Get("cancelResponse")
				isSuccess=abortresponse.Get("isSuccess")
			End If

			If payloaddata.ContainsKey("abortResponse")=True Then
				Dim abortresponse As Map = payloaddata.Get("abortResponse")
				isSuccess=abortresponse.Get("isSuccess")
			End If
			
			If payloaddata.ContainsKey("saleResponse")=True Then
				Dim saleresponse As Map = payloaddata.Get("saleResponse")
				transactionId=saleresponse.Get("transactionId")
				aadeTransactionId=saleresponse.get("aadeTransactionId")
				isSuccess=saleresponse.Get("isSuccess")
				isAbortRequested = saleresponse.Get("isAbortRequested")
				message=saleresponse.Get("message")
			End If

		End If
		
		j.release
		
		Return jsonstring

	Else
		j.Release
		
		Return "error"

	End If
	
End Sub

public Sub LocalClear

	state=""
	sType=""
	transactionId=""
	aadeTransactionId=""
	isSuccess=False
	isAbortRequested=False
	message=""

End Sub

public Sub LocalAbortSalesPayment(iptopost As String,  sessionid As String, amount As Int) As ResumableSub
	
	
	Private j As HttpJob
	j.Initialize("viva",Me)

	Dim m As Map = CreateMap("sessionId": sessionid)
	Dim json As String = m.As(JSON).ToString

	j.postString(iptopost & "/pos/v1/abort",json)

	J.GetRequest.SetContentType("application/json")

	Wait For (j) JobDone(j As HttpJob)

	If j.Success=True Then

		Dim jsonstring As String=j.GetString
		Dim m As Map = jsonstring.As(JSON).ToMap 'ignore
		state=m.Get("state")
		sType=m.Get("sessionType")
		
		j.release

		Return True

	Else
		j.Release
		Return False
	End If

End Sub



public Sub LocalRequestPreAuthPayment(iptopost As String,  sessionid As String, amount As Int) As ResumableSub
	
	
	Private j As HttpJob
	j.Initialize("viva",Me)

	Dim m As Map = CreateMap("sessionId": sessionid, "amount": amount)
	Dim json As String = m.As(JSON).ToString

	j.postString(iptopost & "/pos/v1/preauth-completion",json)

	J.GetRequest.SetContentType("application/json")

	Wait For (j) JobDone(j As HttpJob)

	If j.Success=True Then

		Dim jsonstring As String=j.GetString
		Dim m As Map = jsonstring.As(JSON).ToMap 'ignore
		state=m.Get("state")
		sType=m.Get("sessionType")

		j.release

		Return True

	Else
		j.Release
		Return False
	End If

End Sub


public Sub LocalRefund(iptopost As String,  sessionid As String, amount As Int, transId As String) As ResumableSub
Log(sessionid)	
Log(amount)
Log(transId)
	
	Private j As HttpJob
	j.Initialize("viva",Me)

	Dim m As Map = CreateMap("sessionId": sessionid, "amount": amount, "transactionId": transId)
	Dim json As String = m.As(JSON).ToString

	j.postString(iptopost & "/pos/v1/refund",json)

	J.GetRequest.SetContentType("application/json")

	Wait For (j) JobDone(j As HttpJob)

	If j.Success=True Then

		Dim jsonstring As String=j.GetString
		Dim m As Map = jsonstring.As(JSON).ToMap 'ignore
		state=m.Get("state")
		sType=m.Get("sessionType")

		j.release

		Return True

	Else
		j.Release
		Return False
	End If

End Sub

