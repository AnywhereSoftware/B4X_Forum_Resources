B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
Sub Class_Globals
	
	' Request strings can be constructed based on the params defined in the JavaScriptSDK
	' one difference: put "" around each and every name, type, ...
	' https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/DynamoDB.html

	Private bc As ByteConverter
	Private md As MessageDigest
	
	Private cAccessKey As String = ""
	Private cSecretAccessKey As String = ""
	Private cRegion As String = ""
	Private cHost As String = ""
	Private cService As String = "dynamodb"
	Private cEndpoint As String = ""
	
	Private content_type As String = "application/x-amz-json-1.0"
	Private cMethod As String = "POST"
	Private cService As String = "dynamodb"
	Private cAlgorithm As String = "AWS4-HMAC-SHA256"
	
	Private dBackupTimeZone As Double
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(AccessKey As String, _
	                  SecretAccessKey As String, _
					  Region As String)
	
	cAccessKey = AccessKey
	cSecretAccessKey = SecretAccessKey
	cRegion = Region
		
	cHost = cService & "." & cRegion & ".amazonaws.com"
	cEndpoint = "https://" & cHost & "/"
	
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Creates the request and returns the HttpJob
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub GetHTTPJob(Operation As String, request As String) As HttpJob
	
	Dim amz_target As String = "DynamoDB_20120810." & Operation
	
	Dim j As HttpJob
	j.Initialize("", Me)
	
	dBackupTimeZone = DateTime.TimeZoneOffset
	DateTime.SetTimeZone(0)
	
	Dim time As Long = DateTime.Now
	DateTime.DateFormat = "yyyyMMdd'T'HHmmss'Z'"
	Dim amz_date As String = DateTime.Date(time)
	DateTime.DateFormat = "yyyyMMdd"
	Dim date_stamp As String = DateTime.Date(time)
	DateTime.SetTimeZone(dBackupTimeZone)
			
	Dim canonical_headers  As String = "content-type:" & content_type & CRLF & "host:" & cHost & CRLF & "x-amz-date:" & amz_date & CRLF & "x-amz-target:" & amz_target & CRLF
	Dim signed_headers As String = "content-type;host;x-amz-date;x-amz-target"
	Dim payload_hash As String = GetHexSHA256Hash(request)
	Dim canonical_request As String = cMethod & CRLF & "/" & CRLF & "" & CRLF & canonical_headers & CRLF & signed_headers & CRLF & payload_hash
	Dim credential_scope As String = date_stamp & "/" & cRegion & "/" & cService & "/" & "aws4_request"
	Dim string_to_sign As String = cAlgorithm & CRLF & amz_date & CRLF & credential_scope & CRLF & GetHexSHA256Hash(canonical_request)
	Dim signing_key() As Byte = GetSignatureKey(cSecretAccessKey, date_stamp, cRegion, cService)
	Dim signature As String = bc.HexFromBytes(Sign(string_to_sign, signing_key)).ToLowerCase
	Dim authorization_header As String = cAlgorithm & " " & "Credential=" & cAccessKey & "/" & credential_scope & ", " &  "SignedHeaders=" & signed_headers & ", " & "Signature=" & signature
	
	j.PostString(cEndpoint, request)
	j.GetRequest.SetContentType(content_type)
	j.GetRequest.SetHeader("Host", cHost)
	j.GetRequest.SetHeader("X-Amz-Date", amz_date)
	j.GetRequest.SetHeader("X-Amz-Target", amz_target)
	j.GetRequest.SetHeader("Authorization", authorization_header)
	
	Return j
	
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Gets the SHA256 hash of the string
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Sub GetHexSHA256Hash(s As String) As String
	Dim bytes() As Byte = s.GetBytes("UTF8")
	Dim hash() As Byte = md.GetMessageDigest(bytes, "SHA-256")
	Return bc.HexFromBytes(hash).ToLowerCase
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Gets the signature key, returns a byte array
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Sub GetSignatureKey(SecretKey As String, DateStamp As String, RegionName As String, ServiceName As String) As Byte()
	Dim sSecret As String = ("AWS4" & SecretKey)
	Dim kSecret() As Byte = sSecret.GetBytes("UTF8")
	Dim kDate() As Byte = Sign(DateStamp, kSecret)
	Dim kRegion() As Byte = Sign(RegionName, kDate)
	Dim kService() As Byte = Sign(ServiceName, kRegion)
	Dim kSigning() As Byte = Sign("aws4_request", kService)
	Return kSigning
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Sign method, returns a byte array
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Sub Sign(sStringToSign As String, SecretAccessKey() As Byte) As Byte()
	
	#If B4A or B4J
	Dim m As Mac
	Dim k As KeyGenerator
	k.Initialize("HMACSHA256")
	k.KeyFromBytes(SecretAccessKey)
	m.Initialise("HMACSHA256", k.Key)
	m.Update(sStringToSign.GetBytes("UTF8"))
	Dim b() As Byte
	b = m.Sign
	Return b
	#End If
	
	#If B4I
	Dim no As NativeObject = Me
	Dim res As Object = no.RunMethod("hmacForKeyAndData::", Array(no.ArrayToNSData(SecretAccessKey), no.ArrayToNSData(sStringToSign.GetBytes("utf8"))))
	Return no.NSDataToArray(res)
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

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Returns the result of the HTTP job and releases the job
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Sub GetHttpJobResult(j As HttpJob) As String
	Dim sResult As String = ""
	If j.Success Then
		sResult = j.GetString
	Else
		sResult = j.ErrorMessage
	End If
	j.Release
	Return sResult
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Creates an On-Demand table
' Set SortKey = "" for using only the PartitionKey
' https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_CreateTable.html
' 
' Note: It's usually easier to create tables in the AWS Web Console (examplary URL):
' https://eu-central-1.console.aws.amazon.com/dynamodbv2/home?region=eu-central-1#tables
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub CreateOnDemandTable(TableName As String, PartitionKey As String, SortKey As String) As ResumableSub
	
	If TableName = "" Or PartitionKey = "" Then Return "Invalid table name or missing partition key"
	
	Dim req As String = "{" & CRLF
	
	req = req & $""KeySchema": [{"KeyType": "HASH","AttributeName": "${PartitionKey}"}"$
	If SortKey <> "" Then req = req & $",{"KeyType": "RANGE","AttributeName": "${SortKey}"}"$
	req = req & "]," & CRLF
	
	req = req & $""TableName": "${TableName}","$ & CRLF
	
	req = req & $""AttributeDefinitions": [{"AttributeName": "${PartitionKey}","AttributeType": "S"}"$
	If SortKey <> "" Then req = req & $"{"AttributeName": "${SortKey}","AttributeType": "S"}"$
	req = req & "]," & CRLF
	
	req = req & $""BillingMode": "PAY_PER_REQUEST""$ & CRLF
		
	req = req & "}"
		
	Dim j As HttpJob = GetHTTPJob("CreateTable", req)
	
	Wait For (j) JobDone(j As HttpJob)
			
	Return GetHttpJobResult(j)
	
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Lists the existing tables
' https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ListTables.html
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub ListTables(ExclusiveStartTableName As String) As ResumableSub
	
	Dim req As String = "{" & CRLF
	If ExclusiveStartTableName <> "" Then req = req & $""ExclusiveStartTableName": " ${ExclusiveStartTableName}""$
	req = req & "}"
	
	Dim j As HttpJob = GetHTTPJob("ListTables", req)
	
	Wait For (j) JobDone(j As HttpJob)
			
	Return GetHttpJobResult(j)
	
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Deletes a table
' https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_DeleteTable.html
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub DeleteTable(TableName As String) As ResumableSub
	
	If TableName = "" Then Return "Invalid table name"
	
	Dim req As String = $"{"TableName": "${TableName}"}"$
	
	Dim j As HttpJob = GetHTTPJob("DeleteTable", req)
	
	Wait For (j) JobDone(j As HttpJob)
			
	Return GetHttpJobResult(j)
		
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Creates or replaces an item
' https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_PutItem.html
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub PutItem(TableName As String, Item As Map) As ResumableSub
	
	If TableName = "" Then Return "Invalid table name"
	If Item = Null Or Item.Size = 0 Then Return "No parameters"
	
	Dim req As String = $"{"TableName": "${TableName}", "Item": {"$
	
	For Each key As String In Item.Keys
		req = req & $""${key}" : {"S":"${Item.Get(key)}"},"$
	Next
	req = req.SubString2(0, req.Length - 1)	
	
	req = req & "}}"
	
	Dim j As HttpJob = GetHTTPJob("PutItem", req)
	
	Wait For (j) JobDone(j As HttpJob)
			
	Return GetHttpJobResult(j)
	
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Deletes an item
' https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_DeleteItem.html
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub DeleteItem(TableName As String, PartitionKeyName As String, PartitionKeyValue As String, _
	                  SortKeyName As String, SortKeyValue As String) As ResumableSub
	
	If TableName = "" Then Return "Invalid table name"
	If PartitionKeyName = "" Then Return "Invalid partition key name"
	If PartitionKeyValue = "" Then Return "Invalid partition key value"
	
	
	Dim sKey As String = ""
	If SortKeyName = "" Or SortKeyValue = "" Then
		sKey = $""Key": {"${PartitionKeyName}": {"S": "${PartitionKeyValue}"}}"$
	Else
		sKey = $""Key": {"${PartitionKeyName}": {"S": "${PartitionKeyValue}"}, "${SortKeyName}": {"S": "${SortKeyValue}"}}"$
	End If

	Dim req As String = $"{"TableName": "${TableName}",${sKey}}"$
	
	Dim j As HttpJob = GetHTTPJob("DeleteItem", req.Trim)
	
	Wait For (j) JobDone(j As HttpJob)
			
	Return GetHttpJobResult(j)
	
End Sub


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Gets an item
' https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_GetItem.html
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub GetItem(TableName As String, PartitionKeyName As String, PartitionKeyValue As String, _
										SortKeyName As String, SortKeyValue As String) As ResumableSub
		
	If TableName = "" Then Return "Invalid table name"
	If PartitionKeyName = "" Then Return "Invalid partition key name"
	If PartitionKeyValue = "" Then Return "Invalid partition key value"
	
	Dim sKey As String = ""
	If SortKeyName = "" Or SortKeyValue = "" Then
		sKey = $""Key": {"${PartitionKeyName}": {"S": "${PartitionKeyValue}"}}"$
	Else
		sKey = $""Key": {"${PartitionKeyName}": {"S": "${PartitionKeyValue}"}, "${SortKeyName}": {"S": "${SortKeyValue}"}}"$
	End If
	
	Dim req As String = $"{"TableName": "${TableName}",${sKey}}"$
	
	Dim j As HttpJob = GetHTTPJob("GetItem", req.Trim)
	
	Wait For (j) JobDone(j As HttpJob)
			
	Return GetHttpJobResult(j)
	
End Sub



