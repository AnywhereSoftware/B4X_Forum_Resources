B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=13.4
@EndOfDesignText@
'===============================================================================================================================
'	I'm Robert Valentino - been on B4X for some time.  
'
'	Wanted to be able to handle HttpCodes didn't see anything available so I wrote this Code Module
'
'===============================================================================================================================
Sub Process_Globals
	Private Const  Version			As String	= "1.1"		'Ignore
	
    Public  IsInitialized           As Boolean 	= False	
    Private HttpCodes 				As Map
End Sub

Public  Sub Initialize
	
			IsInitialized	= True
	
		    HttpCodes.Initialize
    		HttpCodes.Put(100, "Continue")
    		HttpCodes.Put(101, "Switching Protocols")
    		HttpCodes.Put(102, "Processing")
    		HttpCodes.Put(200, "OK")
    		HttpCodes.Put(201, "Created")
    		HttpCodes.Put(202, "Accepted")
    		HttpCodes.Put(203, "Non-Authoritative Information")
    		HttpCodes.Put(204, "No Content")
    		HttpCodes.Put(205, "Reset Content")
    		HttpCodes.Put(206, "Partial Content")
			HttpCodes.Put(207, "Multi-Status")
    		HttpCodes.Put(300, "Multiple Choices")
    		HttpCodes.Put(301, "Moved Permanently")
    		HttpCodes.Put(302, "Found")
    		HttpCodes.Put(303, "See Other")
    		HttpCodes.Put(304, "Not Modified")
    		HttpCodes.Put(305, "Use Proxy")
    		HttpCodes.Put(307, "Temporary Redirect")
    		HttpCodes.Put(308, "Permanent Redirect")
    		HttpCodes.Put(400, "Bad Request")
    		HttpCodes.Put(401, "Unauthorized")
    		HttpCodes.Put(402, "Payment Required")
    		HttpCodes.Put(403, "Forbidden")
    		HttpCodes.Put(404, "Not Found")
    		HttpCodes.Put(405, "Method Not Allowed")
    		HttpCodes.Put(406, "Not Acceptable")
    		HttpCodes.Put(407, "Proxy Authentication Required")
    		HttpCodes.Put(408, "Request Timeout")
    		HttpCodes.Put(409, "Conflict")
    		HttpCodes.Put(410, "Gone")
    		HttpCodes.Put(411, "Length Required")
    		HttpCodes.Put(412, "Precondition Failed")
    		HttpCodes.Put(413, "Payload Too Large")
    		HttpCodes.Put(414, "URI Too Long")
    		HttpCodes.Put(415, "Unsupported Media Type")
    		HttpCodes.Put(416, "Range Not Satisfiable")
    		HttpCodes.Put(417, "Expectation Failed")
    		HttpCodes.Put(426, "Upgrade Required")
    		HttpCodes.Put(500, "Internal Server Error")
    		HttpCodes.Put(501, "Not Implemented")
    		HttpCodes.Put(502, "Bad Gateway")
    		HttpCodes.Put(503, "Service Unavailable")
    		HttpCodes.Put(504, "Gateway Timeout")
    		HttpCodes.Put(505, "HTTP Version Not Supported")
End Sub

Public  Sub GetHttpDescription(Code As Int) As String
			If  IsInitialized = False Then
				Initialize				
			End If
			
	    	If 	HttpCodes.ContainsKey(Code) Then
    	    	Return HttpCodes.Get(Code)
    		Else
	        	Return "Unknown HTTP Code"
    		End If
End Sub

Public  Sub IsHttpSuccess(Code As Int) As Boolean
			If  IsInitialized = False Then
				Initialize				
			End If
	
    		' Only continue if success (2xx range)
    		If 	Code >= 200 And Code <= 299 Then
        		Return True
    		Else
        		Return False
    		End If
End Sub


Public  Sub IsHttpError(Code As Int) As Boolean
			If  IsInitialized = False Then
				Initialize				
			End If
	
    		' Return True if code is an error (4xx or 5xx)
    		If 	Code >= 400 And Code <= 599 Then
        		Return True
    		Else
        		Return False
    		End If
End Sub


Public  Sub HttpCategory(Code As Int) As String
			If  IsInitialized = False Then
				Initialize
			End If
			
			If 	Code >= 100 And Code <= 199 Then
        		Return "Informational"
    		Else If Code >= 200 And Code <= 299 Then
        			Return "Success"
    		Else If Code >= 300 And Code <= 399 Then
        			Return "Redirection"
    		Else If Code >= 400 And Code <= 499 Then
        			Return "Client Error"
    		Else If Code >= 500 And Code <= 599 Then
        			Return "Server Error"
    		Else
        		Return "Unknown"
    		End If
End Sub


