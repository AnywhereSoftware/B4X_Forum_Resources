B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
Sub Class_Globals
	
	#If B4J
	Private fx As JFX
	#End If
	
	Private su As StringUtils
	
	Private cAccessKey As String = ""
	Private cSecretAccessKey As String = ""
	Private cEndPoint As String = ""
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(AccessKey As String, _
	                  SecretAccessKey As String, _
					  EndPoint As String)
	
	cAccessKey = AccessKey
	cSecretAccessKey = SecretAccessKey
	cEndPoint = EndPoint
		
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Signs the string with the secret access key
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Sub Sign(sStringToSign As String, sSecretAccessKey As String) As String
	
	#If B4A or B4J
	Dim m As Mac
	Dim k As KeyGenerator
	k.Initialize("HMACSHA256")
	k.KeyFromBytes(sSecretAccessKey.GetBytes("UTF8"))
	m.Initialise("HMACSHA256", k.Key)
	m.Update(sStringToSign.GetBytes("UTF8"))
	Dim b() As Byte
	b = m.Sign
	Return su.EncodeUrl(su.EncodeBase64(b), "UTF8")
	#End If	
	
	#If B4I
	Dim no As NativeObject = Me
	Dim keyb() As Byte
	keyb = sSecretAccessKey.GetBytes("UTF8")
	Dim res As Object = no.RunMethod("hmacForKeyAndData::", Array(no.ArrayToNSData(keyb), no.ArrayToNSData(sStringToSign.GetBytes("utf8"))))
	Dim b() As Byte = no.NSDataToArray(res)
	Return su.EncodeUrl(su.EncodeBase64(b), "UTF8")
	#End If
	
End Sub

#if OBJC
#import <CommonCrypto/CommonHMAC.h>

- (NSData*) hmacForKeyAndData:(NSData*)cKey :(NSData*) cData
{
  unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
  CCHmac(kCCHmacAlgSHA256, [cKey bytes], [cKey length], [cData bytes], [cData length], cHMAC);
  return [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
}
#End If

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Sends a request and returns the result
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub SendRequest(sRequest As String) As ResumableSub
	Dim j As HttpJob
	j.Initialize("", Me)
	j.Download(sRequest)
	Wait For (j) JobDone(j As HttpJob)
	Dim sResult As String = ""
	If j.Success = True Then sResult = j.GetString
	j.Release
	Return sResult
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Creates the timestamp
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Sub CreateTimeStamp As String
	Dim dBackupTimeZone As Double = DateTime.TimeZoneOffset
	DateTime.SetTimeZone(0)
	DateTime.DateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
	Dim s As String = DateTime.Date(DateTime.Now).Replace(":","%3A")
	DateTime.SetTimeZone(dBackupTimeZone)
	Return s
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Creates a 'CreateDomain' request
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub CreateDomainRequest(sDomain As String) As String
	
	Dim sTimestamp As String = CreateTimeStamp
	
	Dim sStringToSign As String = "GET" & CRLF & _
					 			  cEndPoint & CRLF & _
					  			  "/" & CRLF & _
					  			  "AWSAccessKeyId=" & cAccessKey & _
					  			  "&Action=CreateDomain" & _
					  			  "&DomainName=" & sDomain & _
					  			  "&SignatureMethod=HmacSHA256" & _
					  			  "&SignatureVersion=2" & _
					  			  "&Timestamp=" & sTimestamp & _
					  			  "&Version=2009-04-15"
	
	Dim sSignature As String = Sign(sStringToSign, cSecretAccessKey)
	
	Dim sRequest As String = "https://" & cEndPoint & "/" & _
							 "?Action=CreateDomain" & _
					  		 "&AWSAccessKeyId=" & cAccessKey & _
					  		 "&DomainName=" & sDomain & _
					  		 "&SignatureVersion=2" & _
					  		 "&SignatureMethod=HmacSHA256" & _
					  		 "&Timestamp=" & sTimestamp & _
					  		 "&Version=2009-04-15" & _
					  		 "&Signature=" & sSignature

	Return sRequest
	
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Creates a 'DeleteDomain' request
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub DeleteDomainRequest(sDomain As String) As String
	Dim sTimestamp As String = CreateTimeStamp
	
	Dim sStringToSign As String = "GET" & CRLF & _
					 			  cEndPoint & CRLF & _
					  			  "/" & CRLF & _
					  			  "AWSAccessKeyId=" & cAccessKey & _
					  			  "&Action=DeleteDomain" & _
					  			  "&DomainName=" & sDomain & _
					  			  "&SignatureMethod=HmacSHA256" & _
					  			  "&SignatureVersion=2" & _
					  			  "&Timestamp=" & sTimestamp & _
					  			  "&Version=2009-04-15"
	
	Dim sSignature As String = Sign(sStringToSign, cSecretAccessKey)
	
	Dim sRequest As String = "https://" & cEndPoint & "/" & _
							 "?Action=DeleteDomain" & _
					  		 "&AWSAccessKeyId=" & cAccessKey & _
					  		 "&DomainName=" & sDomain & _
					  		 "&SignatureVersion=2" & _
					  		 "&SignatureMethod=HmacSHA256" & _
					  		 "&Timestamp=" & sTimestamp & _
					  		 "&Version=2009-04-15" & _
					  		 "&Signature=" & sSignature

	Return sRequest
	
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Creates a 'ListDomains' request
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub ListDomainsRequest As String
	
	Dim sTimestamp As String = CreateTimeStamp
	
	Dim sStringToSign As String = "GET" & CRLF & _
					 			  cEndPoint & CRLF & _
					  			  "/" & CRLF & _
					  			  "AWSAccessKeyId=" & cAccessKey & _
					  			  "&Action=ListDomains" & _
					  			  "&SignatureMethod=HmacSHA256" & _
					  			  "&SignatureVersion=2" & _
					  			  "&Timestamp=" & sTimestamp & _
					  			  "&Version=2009-04-15"
	
	Dim sSignature As String = Sign(sStringToSign, cSecretAccessKey)
	
	Dim sRequest As String = "https://" & cEndPoint & "/" & _
							 "?Action=ListDomains" & _
					  		 "&AWSAccessKeyId=" & cAccessKey & _
					  		 "&SignatureVersion=2" & _
					  		 "&SignatureMethod=HmacSHA256" & _
					  		 "&Timestamp=" & sTimestamp & _
					  		 "&Version=2009-04-15" & _
					  		 "&Signature=" & sSignature

	Return sRequest
	
	
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Extracts the domains from the request result
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub GetDomainsFromListDomainsResult(ListDomainsResult As String) As String
	
	Dim result As String = ""
	
	If ListDomainsResult <> Null And ListDomainsResult.Length > 0 Then
	
		Dim ls() As String = Regex.Split("DomainName", ListDomainsResult)
		For Each s As String In ls
			If s.StartsWith(">") And s.EndsWith("</") Then
				result = result & s.Replace(">", "").Replace("</", "") & CRLF
			End If
		Next
	End If
	
	Return result
	
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Puts an attribute for the item
' Note: you can pass multiple attributes with Attribute.x.Name
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub PutAttributeRequest(Domain As String, _
	                           Item As String, _
						       AttributeName As String, _
						       AttributeValue As String, _
						       Replace As Boolean) As String
	
	Dim sReplace As String = "true"
	If Replace = False Then sReplace = "false"
	
	Dim sTimestamp As String = CreateTimeStamp
	
	Dim sStringToSign As String = "GET" & CRLF & _
					 			  cEndPoint & CRLF & _
					  			  "/" & CRLF & _
					  			  "AWSAccessKeyId=" & cAccessKey & _
					  			  "&Action=PutAttributes" & _
								  "&Attribute.1.Name=" & AttributeName & _
								  "&Attribute.1.Replace=" & sReplace & _
								  "&Attribute.1.Value=" & AttributeValue & _
								  "&DomainName=" & Domain & _
								  "&ItemName=" & Item & _
					  			  "&SignatureMethod=HmacSHA256" & _
					  			  "&SignatureVersion=2" & _
					  			  "&Timestamp=" & sTimestamp & _
					  			  "&Version=2009-04-15"
	
	Dim sSignature As String = Sign(sStringToSign, cSecretAccessKey)
	
	Dim sRequest As String = "https://" & cEndPoint & "/" & _
							 "?Action=PutAttributes" & _
							 "&DomainName=" & Domain & _
							 "&ItemName=" & Item & _
					  		 "&Attribute.1.Name=" & AttributeName & _
							 "&Attribute.1.Replace=" & sReplace & _
							 "&Attribute.1.Value=" & AttributeValue & _
					  		 "&Version=2009-04-15" & _
							 "&Timestamp=" & sTimestamp & _
							 "&Signature=" & sSignature & _
					  		 "&SignatureVersion=2" & _
					  		 "&SignatureMethod=HmacSHA256" & _
							 "&AWSAccessKeyId=" & cAccessKey
	
	Return sRequest
	
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Gets all attributes for an item
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub GetAttributesRequest(Domain As String, Item As String) As String
	
	Dim sTimestamp As String = CreateTimeStamp
	
	Dim sStringToSign As String = "GET" & CRLF & _
					 			  cEndPoint & CRLF & _
					  			  "/" & CRLF & _
					  			  "AWSAccessKeyId=" & cAccessKey & _
					  			  "&Action=GetAttributes" & _
								  "&DomainName=" & Domain & _
								  "&ItemName=" & Item & _
					  			  "&SignatureMethod=HmacSHA256" & _
					  			  "&SignatureVersion=2" & _
					  			  "&Timestamp=" & sTimestamp & _
					  			  "&Version=2009-04-15"
	
	Dim sSignature As String = Sign(sStringToSign, cSecretAccessKey)
	
	Dim sRequest As String = "https://" & cEndPoint & "/" & _
							 "?Action=GetAttributes" & _
							 "&DomainName=" & Domain & _
							 "&ItemName=" & Item & _
					  		 "&Version=2009-04-15" & _
							 "&Timestamp=" & sTimestamp & _
							 "&Signature=" & sSignature & _
					  		 "&SignatureVersion=2" & _
					  		 "&SignatureMethod=HmacSHA256" & _
							 "&AWSAccessKeyId=" & cAccessKey
	
	Return sRequest
	
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Extracts the attributes from the request result
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub GetAttributesFromGetAttributesResult(GetAttributesResult As String) As String
	
	Dim result As String = ""
	
	If GetAttributesResult <> Null And GetAttributesResult.Length > 0 Then
	
		Dim ls() As String = Regex.Split("Attribute><", GetAttributesResult)
		For Each s As String In ls
			Dim ls2() As String = Regex.Split("</Name><Value>", s)
			If ls2 <> Null And ls2.Length = 2 Then
				result = result & ls2(0).Replace("Name>","").Trim & " " & ls2(1).Replace("</Value></","").Trim & CRLF
			End If
		Next
	End If
	
	Return result
	
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Create a 'Delete Attributes' for all attributes and the item request
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub DeleteAttributesRequest(Domain As String, Item As String) As String
	
	Dim sTimestamp As String = CreateTimeStamp
	
	Dim sStringToSign As String = "GET" & CRLF & _
					 			  cEndPoint & CRLF & _
					  			  "/" & CRLF & _
					  			  "AWSAccessKeyId=" & cAccessKey & _
					  			  "&Action=DeleteAttributes" & _
					  			  "&DomainName=" & Domain & _
								  "&ItemName=" & Item & _
					  			  "&SignatureMethod=HmacSHA256" & _
					  			  "&SignatureVersion=2" & _
					  			  "&Timestamp=" & sTimestamp & _
					  			  "&Version=2009-04-15"
	
	Dim sSignature As String = Sign(sStringToSign, cSecretAccessKey)
	
	Dim sRequest As String = "https://" & cEndPoint & "/" & _
							 "?Action=DeleteAttributes" & _
							 "&DomainName=" & Domain & _
							 "&ItemName=" & Item & _
					  		 "&Version=2009-04-15" & _
							 "&Timestamp=" & sTimestamp & _
							 "&Signature=" & sSignature & _
					  		 "&SignatureVersion=2" & _
					  		 "&SignatureMethod=HmacSHA256" & _
							 "&AWSAccessKeyId=" & cAccessKey
	
	Return sRequest
	
End Sub

