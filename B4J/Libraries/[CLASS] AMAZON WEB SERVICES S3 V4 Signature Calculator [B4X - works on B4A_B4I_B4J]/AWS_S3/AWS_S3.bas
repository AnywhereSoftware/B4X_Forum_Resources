B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'************************************************************************************
'
'This class module calculates V4 signatures and creates URI and Authorization strings
'for Amazon Web Services (AWS) Simple Storage Service (S3) REST API requests, 
'facilitating creation of AWS S3 PUT/GET/DELETE requests, for introduction see:
'
'http://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html
'
'It works, unaltered on both B4A, B4J and B4I
'
'Following characteristics/restrictions are adopted:
'
'   o Authentication with AWS Signature version 4 using a HTTP Authorization header,
'     this dictates appropriate request authentication guide is via:
'
'     http://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-auth-using-authorization-header.html
' 
'   o Payloads passed as a single chunk, this dictates appropriate request 
'     authentication guide is via:
'
'     http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
' 
'Calls:
'
'   URI
'
'   Authorization
'
'   Signature
'
'   FullHeaderMap
'
'   HexSHA256Hash
'
'   HMACSHA256
'
'Properties:
'
'   AWS_URI_Is_Path_Style
'       True = URI is "path style", e.g.:
'              https://<endpoint>/<bucketname>/<filename>
'       False = URI is "virtual hosted style", e.g.:
'               https://<bucketname>.<endpoint>/<filename>
'	AWS_Access_Key_ID
'	AWS_Secret_Access_Key
'	AWS_Region
'       where S3 bucket resides, as per:
'       http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region
'       e.g.:
'           ap-southeast-2
'	AWS_End_Point
'       where S3 bucket can be accessed, as per:
'       http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region
'       e.g.:
'           s3-ap-southeast-2.amazonaws.com
'	AWS_S3_Bucket_Name
'	AWS_S3_File_Name
'       full name of file in bucket, including any pseudo folders, e.g.:
'           examplefile.txt
'           pseudofolder1/pseudofolder2/examplefile.txt
'	AWS_S3_HttpMethod
'       "GET", "PUT" or "DELETE"
'	AWS_S3_Query_map
'       map of URI query parameter key, value pairs
'       e.g:
'            URI is:
'                https://s3.amazonaws.com/examplebucket?prefix=somePrefix&marker=someMarker&Max-keys=20
'            URI query parameter key, value pairs:
'                "prefix", "somePrefix"
'                "marker", "someMarker"
'                "max-keys", "20"
'       e.g:
'            URI is:
'                https://s3.amazonaws.com/examplebucket?acl
'            URI query parameter key, value pairs:
'                "acl", ""
'       e.g:
'            URI does not include a "?"
'                AWS_S3_Query_map is Null
'	AWS_S3_Payload
'   AWS_S3_Content_Type
'       type of AWS_S3_Payload, typically "application/x-www-form-urlencoded" if
'       byte payload or "" if no payload
'	AWS_S3_OtherHeader_map
'       map of other request header key, value pairs - exclude following 
'       headers which are added automatically:
'             host
'             content-type - if AWS_S3_Content_Type is defined
'             x-amz-content-sha256 
'             x-amz-date
'       following headers must be added to this map:
'             any other x-amz-* headers
'       consider including all other headers in order to prevent data tampering
'
'Requirements:
'
'   o B4A/B4J libraries:
'
'         ByteConverter (version 1.10 or later)
'         Encryption (version 1.10 or later)
'
'   o B4I libraries:
'
'         iEncryption (version 1.02 or later)
'         iRandomAccessFile (version 1.72 or later)
'
'Update history:
'
'   24 Jun 17 - 1.0
'   26 Jun 17 - 1.1 - o added AWS_URI_Is_Path_Style and AWS_End_Point properties
'                     o replaced AWS_S3_Header_map with AWS_S3_OtherHeader_map (now
'                       automatically builds default headers)
'                     o added URI call to automatically generate http job URI
'                     o added Authorization call to automatically generate full
'                       http job Authorization string 
'                     o added FullHeaderMap call to generate full header map for
'                       input to http job
'                     o changed AWS_S3_Payload to a byte array instead of string
'                     o changed HexSHA256Hash call's input to a byte array instead 
'                       of string
'   28 Jun 17 - 1.2 - o added AWS_S3_Content_Type property and tidy up around this
'   30 Jun 17 - 1.3 - o made cross platform B4A, B4J and B4I
'   20 Oct 17 - 1.4 - o replaced AWS_S3_GMT_DateTime with AWS_S3_Local_DateTime
'                       and handled GMT/local timezones internally
'   18 Oct 18 - 1.5 - o modified handling of GMT/local timezones internally
'   08 Oct 19 - 1.6 - o modified handling of SetTimeZone as per:
'                       https://www.b4x.com/android/forum/threads/day-light-saving-with-long-running-b4j-apps.110252/#post-688311
'   09 Apr 21 - 1.7 - o modified handling of GMT as per:
'                       https://www.b4x.com/android/forum/threads/b4x-format-dates-in-gmt-time-zone-without-changing-the-apps-time-zone.129502/
'
'************************************************************************************
Sub Class_Globals
	
	Public AWS_URI_Is_Path_Style As Boolean
	Public AWS_Access_Key_ID As String
	Public AWS_Secret_Access_Key As String
	Public AWS_Region As String
	Public AWS_End_Point As String

	Public AWS_S3_Bucket_Name As String
	Public AWS_S3_File_Name As String
	Public AWS_S3_HttpMethod As String
	Public AWS_S3_Query_map As Map
	Public AWS_S3_Payload() As Byte
	Public AWS_S3_Content_Type As String
	Public AWS_S3_OtherHeader_map As Map

	Private AWS_GMTFormatter As GMTFormatter
	Private AWS_S3_GMT As Long
	
End Sub

'************************************************************************************
'
'This procedure initializes an instance
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       None
'
'Notes on this procedure:
'
'       None
'
'************************************************************************************
Public Sub Initialize

	AWS_S3_Query_map.Initialize
	AWS_S3_OtherHeader_map.Initialize
	
	AWS_S3_GMT = DateTime.Now

	'NOTE: in order to test against signature examples in AWS documentation we have  
	'to force date to be 20130524T000000Z
	'If you wish to do this then uncomment following 3 lines

'	DateTime.SetTimeZone(0)
'	DateTime.DateFormat = "yyyyMMdd'T'HHmmss'Z'"
'	AWS_S3_GMT = DateTime.DateParse("20130524T000000Z")

End Sub
'************************************************************************************
'
'This procedure creates a CanonicalRequest as per:
'    http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
'    Task 1: Create a Canonical Request
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       CanonicalRequest
'
'Notes on this procedure:
'
'       <HTTPMethod>\n
'       <CanonicalURI>\n
'       <CanonicalQueryString>\n
'       <CanonicalHeaders>\n
'       <SignedHeaders>\n
'       <HashedPayload>'
'
'************************************************************************************
Private Sub CanonicalRequest As String
	
	Private wrk_str As String
	
	'Components are separated by \n which is Chr(10) which is CRLF
	
	wrk_str = AWS_S3_HttpMethod & CRLF
	
	wrk_str = wrk_str & CanonicalURI & CRLF
	
	wrk_str = wrk_str & CanonicalQueryString & CRLF
	
	wrk_str = wrk_str & CanonicalHeaders & CRLF
	
	wrk_str = wrk_str & SignedHeaders & CRLF
	
	wrk_str = wrk_str & HexSHA256Hash(AWS_S3_Payload)

	Return wrk_str

End Sub

'************************************************************************************
'
'This procedure creates a CanonicalURI as per:
'    http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
'    Task 1: Create a Canonical Request
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       CanonicalURI
'
'Notes on this procedure:
'
'       o CanonicalURI is URI-encoded ("/" excluded) version of absolute path 
'         component of URI — everything starting with "/" that follows domain name 
'         and up to end of string or to question mark character ("?") if there are 
'         query string parameters
'       o Example:
'            URI is (path style):
'                https://s3-ap-southeast-2.amazonaws.com/mybucket/myfolder/myphoto.jpg
'            absolute path is:
'                /mybucket/myfolder/myphoto.jpg
'       o Example:
'            URI is (virtual hosted style):
'                https://mybucket/s3-ap-southeast-2.amazonaws.com/myfolder/myphoto.jpg
'            absolute path is:
'                /myfolder/myphoto.jpg
'
'************************************************************************************
Private Sub CanonicalURI As String
	
	Private wrk_str As String
	
	'Build absolute path component of URI
	
	wrk_str = "/"
	
	'If URI is path style, add bucket name to work string
	If AWS_URI_Is_Path_Style Then
		wrk_str = wrk_str & AWS_S3_Bucket_Name & "/"
	End If
	
	'Add file name to work string
	wrk_str = wrk_str & AWS_S3_File_Name
	
	'URI-encode ("/" excluded)
	wrk_str = UriEncode(wrk_str, False)
	
	Return wrk_str

End Sub

'************************************************************************************
'
'This procedure creates a CanonicalQueryString as per:
'    http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
'    Task 1: Create a Canonical Request
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       CanonicalQueryString
'
'Notes on this procedure:
'
'       o CanonicalQueryString specifies URI-encoded query string parameters -
'         parameter key names and values are URI-encoded individually then
'         parameters are sorted alphabetically by key name
'       o Example:
'            URI is:
'                https://s3.amazonaws.com/examplebucket?prefix=somePrefix&marker=someMarker&Max-keys=20
'            canonical query string is (line breaks are added for readability):
'                URI-encode("marker") + "=" + URI-encode("someMarker") + "&" +
'                URI-encode("max-keys") + "=" + URI-encode("20") + "&" +
'                URI-encode("prefix") + "=" + URI-encode("somePrefix")
'       o When a request targets a subresource, corresponding query parameter value
'         will be an empty string (""), for example:
'            URI is:
'                https://s3.amazonaws.com/examplebucket?acl 
'            canonical query string is:
'                URI-encode("acl") + "=" + ""
'       o If URI does not include a "?", there is no query string in request, and 
'         canonical query string is:
'                ""
'
'************************************************************************************
Private Sub CanonicalQueryString As String
	
	Private wrk_str As String
	Private wrk_key As String
	Private wrk_value As String
	Private wrk_list As List
	
	wrk_list.Initialize

	'For each key, value pair of query string parameters map...
	For Each wrk_key As String In AWS_S3_Query_map.Keys
		
		Private wrk_data As KeyValueType
		
		'URI-encode query header key
		wrk_data.key = UriEncode(wrk_key, True)

		'Get value and URI-encode it
		wrk_value = AWS_S3_Query_map.Get(wrk_key)
		wrk_data.value = UriEncode(wrk_value, True)
		
		'Save URI-encoded keys and values in temporary list
		wrk_list.Add(wrk_data)

	Next
	
	'Sort temporary list
	wrk_list.SortTypeCaseInsensitive("key", True)
		
	Private wrk_data As KeyValueType
	
	'For each URI-encoded key, value pair of temporary list...
	For wrk_ptr = 0 To wrk_list.Size - 1
		
		wrk_data = wrk_list.get(wrk_ptr)
		
		'Append & to work string if it is not blank
		If wrk_str <> "" Then wrk_str = wrk_str & "&"
		
		'Append key=value to work string
		wrk_str = wrk_str & wrk_data.key & "=" & wrk_data.value
		
	Next

	Return wrk_str

End Sub

'************************************************************************************
'
'This procedure creates a CanonicalHeaders as per:
'    http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
'    Task 1: Create a Canonical Request
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       CanonicalHeaders
'
'Notes on this procedure:
'
'       o CanonicalHeaders is a list of request headers with their values - 
'         individual header name and value pairs are separated by newline 
'         character ("\n") i.e. CRLF - header names must be in lowercase and must 
'         be sorted alphabetically as indicated here:
'
'             Lowercase(<HeaderName1>)+":"+Trim(<value>)+"\n"
'             Lowercase(<HeaderName2>)+":"+Trim(<value>)+"\n"
'             ...
'             Lowercase(<HeaderNameN>)+":"+Trim(<value>)+"\n"
'
'       o CanonicalHeaders must include following headers, all others are optional:
'
'             Host header
'             Content-Type header - if present in request
'             Any x-amz-* headers - e.g. if temporary security credentials are
'                 used then request will include x-amz-security-token header
'
'       o Consider including all headers in order to prevent data tampering
'       o x-amz-content-sha256 header is required for all AWS Signature Version 4 
'         requests - it provides a hash of request payload - if there is no payload
'         then provide hash of an empty string
'       o Example (note sorted lowercase header names and trimmed values:
'            host:s3.amazonaws.com\n
'            x-amz-content-sha256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\n
'            x-amz-date:20130708T220855Z
'
'************************************************************************************
Private Sub CanonicalHeaders As String
	
	Private wrk_str As String
	Private wrk_ptr As Int
	Private wrk_map As Map
	Private wrk_value As String
	Private wrk_list As List

	wrk_map.Initialize
	
	'Copy full header map to temporary map
	wrk_map = FullHeaderMap
	
	wrk_list.Initialize

	'For each key, value pair of temporary map...
	For Each wrk_key As String In wrk_map.Keys
		
		Private wrk_data As KeyValueType
		
		'Get key
		wrk_data.key = wrk_key

		'Get value
		wrk_data.value = wrk_map.Get(wrk_key)
		
		'Save keys and values in temporary list
		wrk_list.Add(wrk_data)

	Next
	
	'Sort temporary list
	wrk_list.SortTypeCaseInsensitive("key", True)
		
	Private wrk_data As KeyValueType

	'For each key, value pair of temporary list...
	For wrk_ptr = 0 To wrk_list.Size - 1
		
		wrk_data = wrk_list.Get(wrk_ptr)
		
		'Get value and trim it
		wrk_value = wrk_data.value
		wrk_value = wrk_value.Trim
		
		'Append lowercase key:value to work string
		wrk_str = wrk_str & wrk_data.key.ToLowerCase & ":" & wrk_value
		
		'Append \n (CRLF) to work string
		wrk_str = wrk_str & CRLF

	Next

	Return wrk_str

End Sub

'************************************************************************************
'
'This procedure creates a SignedHeaders as per:
'    http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
'    Task 1: Create a Canonical Request
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       SignedHeaders
'
'Notes on this procedure:
'
'       o SignedHeaders is an alphabetically sorted, semicolon-separated list of 
'         lowercase request header names - same headers that are included in 
'         CanonicalHeaders string
'       o Example (referring to example in CanonicalHeaders) equivalent SignedHeaders
'         would be:
'            host;x-amz-content-sha256;x-amz-date
'
'************************************************************************************
Private Sub SignedHeaders As String
	
	Private wrk_str As String
	Private wrk_map As Map
	Private wrk_list As List
	Private wrk_ptr As Int

	wrk_map.Initialize
	
	'Copy full header map to temporary map
	wrk_map = FullHeaderMap
	
	wrk_list.Initialize

	'For each key, value pair of temporary map...
	For Each wrk_key As String In wrk_map.Keys
		
		Private wrk_data As KeyValueType
		
		'Get key
		wrk_data.key = wrk_key

		'Get value
		wrk_data.value = wrk_map.Get(wrk_key)
		
		'Save keys and values in temporary list
		wrk_list.Add(wrk_data)

	Next
	
	'Sort temporary list
	wrk_list.SortTypeCaseInsensitive("key", True)
		
	Private wrk_data As KeyValueType

	'For each key, value pair of temporary map...
	For wrk_ptr = 0 To wrk_list.Size - 1
		
		wrk_data = wrk_list.Get(wrk_ptr)
		
		'Append ; to work string if it is not blank
		If wrk_str <> "" Then wrk_str = wrk_str & ";"
		
		'Append lowercase key to work string
		wrk_str = wrk_str & wrk_data.key.ToLowerCase

	Next

	Return wrk_str

End Sub

'************************************************************************************
'
'This procedure creates a StringToSign as per:
'    http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
'    Task 2: Create a String to Sign
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       StringToSign
'
'Notes on this procedure:
'
'       "AWS4-HMAC-SHA256" + "\n" +
'       timeStampISO8601Format + "\n" +
'       <Scope> + "\n" +
'       Hex(SHA256Hash(<CanonicalRequest>))
'
'************************************************************************************
Private Sub StringToSign As String
	
	Private wrk_str As String
	
	'Components are separated by \n which is Chr(10) which is CRLF
	
	wrk_str = "AWS4-HMAC-SHA256" & CRLF
	
	wrk_str = wrk_str & timeStampISO8601Format & CRLF
	
	wrk_str = wrk_str & Scope & CRLF
	
	wrk_str = wrk_str & HexSHA256Hash(CanonicalRequest.GetBytes("UTF8"))

	Return wrk_str

End Sub

'************************************************************************************
'
'This procedure creates a timeStampISO8601Format as per:
'    http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
'    Task 2: Create a String to Sign
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       timeStampISO8601Format
'
'Notes on this procedure:
'
'       o None
'
'************************************************************************************
Private Sub timeStampISO8601Format As String
	
	AWS_GMTFormatter.Initialize("yyyyMMdd'T'HHmmss'Z'")

	Return AWS_GMTFormatter.Format(AWS_S3_GMT)
	
End Sub

'************************************************************************************
'
'This procedure creates a Scope as per:
'    http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
'    Task 2: Create a String to Sign
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       Scope
'
'Notes on this procedure:
'
'       date.Format(<YYYYMMDD>) + "/" + <region> + "/" + <service> + "/aws4_request"
'
'************************************************************************************
Private Sub Scope As String
	
	Private wrk_str As String
	
	AWS_GMTFormatter.Initialize("yyyyMMdd")

	wrk_str = AWS_GMTFormatter.Format(AWS_S3_GMT) & "/"
	wrk_str = wrk_str & AWS_Region & "/"
	wrk_str = wrk_str & "s3" & "/aws4_request"

	Return wrk_str
	
End Sub

'************************************************************************************
'
'This procedure creates a SigningKey as per:
'    http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
'    Task 3: Calculate Signature
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       SigningKey
'
'Notes on this procedure:
'
'       SigningKey           = HMAC-SHA256(<DateRegionServiceKey>, "aws4_request")'
'       DateRegionServiceKey = HMAC-SHA256(<DateRegionKey>, "<aws-service>")
'       DateRegionKey        = HMAC-SHA256(<DateKey>, "<aws-region>")
'       DateKey              = HMAC-SHA256("AWS4"+"<SecretAccessKey>", "<YYYYMMDD>")
'
'************************************************************************************
Private Sub SigningKey As String
	
	Return HMACSHA256(DateRegionServiceKey, "aws4_request", True)

End Sub

Private Sub DateRegionServiceKey As String
	
	Return HMACSHA256(DateRegionKey, "s3", True)

End Sub

Private Sub DateRegionKey As String
	
	Return HMACSHA256(DateKey, AWS_Region, True)

End Sub

Private Sub DateKey As String
	
	AWS_GMTFormatter.Initialize("yyyyMMdd")

	Return HMACSHA256("AWS4" & AWS_Secret_Access_Key, AWS_GMTFormatter.Format(AWS_S3_GMT), False)
	
End Sub

'************************************************************************************
'
'This procedure creates a HexSHA256Hash of a supplied byte array
'
'Input parameters are:
'
'       input = byte array to be mangled
'
'Returns:
'
'       HexSHA256Hash
'
'Notes on this procedure:
'
'       o HexSHA256Hash is lowercase hexadecimal string of SHA256 hash of input 
'         byte array
'       o Has some distant parentage at:
'         https://www.b4x.com/android/forum/threads/amazon-s3-library.38699/
'
'************************************************************************************

'
'[Method] - lowercase hexadecimal string of SHA256 hash of input byte array
'
'input = byte array to be mangled
Public Sub HexSHA256Hash(input() As Byte) As String
	
	Private wrk_bc As ByteConverter
	Private wrk_md As MessageDigest
	Private wrk_hash() As Byte
	Private wrk_str As String
	
	'Get SHA256 hash of input byte array
	wrk_hash = wrk_md.GetMessageDigest(input, "SHA-256")
	
	'Get hex of SHA256 hash of input byte array
	wrk_str = wrk_bc.HexFromBytes(wrk_hash)
	
	'Return lowercase hex of SHA256 hash of input byte array
	Return wrk_str.ToLowerCase

End Sub

#If B4A
'************************************************************************************
'
'This procedure creates a HMACSHA256 of a supplied string for a given key
'
'Input parameters are:
'
'       key = key
'       input = string to be mangled
'       key_is_hex_string = flag to indicate if key is hex string (True) or 
'                           character string (False)
'
'Returns:
'
'       HMACSHA256
'
'Notes on this procedure:
'
'       o Based on:
'         https://www.b4x.com/android/forum/threads/porting-of-b4a-amazon-web-services-v4-signature-calculator.81036/#post-513785
'
'************************************************************************************

'
'[Method] - lowercase hexadecimal string of HMAC-SHA256 of key and input string
'
'key = key
'input = string to be mangled
'key_is_hex_string = flag to indicate if key is hex string (True) or character string (False)
Public Sub HMACSHA256(key As String, input As String, key_is_hex_string As Boolean) As String

	Private wrk_mac As Mac
	Private wrk_key As KeyGenerator
	Private wrk_bc As ByteConverter
	Private wrk_byte() As Byte
	
	Private wrk_scrw As String = "HMACSHA256"
	wrk_key.Initialize(wrk_scrw)
	If key_is_hex_string Then
		wrk_key.KeyFromBytes(wrk_bc.HexToBytes(key))
	Else
		wrk_key.KeyFromBytes(key.GetBytes("UTF8"))
	End If
	wrk_mac.Initialise(wrk_scrw, wrk_key.Key)
	wrk_mac.Update(input.GetBytes("UTF8"))
	wrk_byte = wrk_mac.Sign
	
	Return wrk_bc.HexFromBytes(wrk_byte).ToLowerCase
	
End Sub
#Else If B4J
'************************************************************************************
'
'This procedure creates a HMACSHA256 of a supplied string for a given key
'
'Input parameters are:
'
'       key = key
'       input = string to be mangled
'       key_is_hex_string = flag to indicate if key is hex string (True) or 
'                           character string (False)
'
'Returns:
'
'       HMACSHA256
'
'Notes on this procedure:
'
'       o Based on:
'         https://www.b4x.com/android/forum/threads/porting-of-b4a-amazon-web-services-v4-signature-calculator.81036/#post-513785
'
'************************************************************************************

'
'[Method] - lowercase hexadecimal string of HMAC-SHA256 of key and input string
'
'key = key
'input = string to be mangled
'key_is_hex_string = flag to indicate if key is hex string (True) or character string (False)
Public Sub HMACSHA256(key As String, input As String, key_is_hex_string As Boolean) As String

	Private wrk_mac As Mac
	Private wrk_key As KeyGenerator
	Private wrk_bc As ByteConverter
	Private wrk_byte() As Byte
	
	Private wrk_scrw As String = "HMACSHA256"
	wrk_key.Initialize(wrk_scrw)
	If key_is_hex_string Then
		wrk_key.KeyFromBytes(wrk_bc.HexToBytes(key))
	Else
		wrk_key.KeyFromBytes(key.GetBytes("UTF8"))
	End If
	wrk_mac.Initialise(wrk_scrw, wrk_key.Key)
	wrk_mac.Update(input.GetBytes("UTF8"))
	wrk_byte = wrk_mac.Sign
	
	Return wrk_bc.HexFromBytes(wrk_byte).ToLowerCase
	
End Sub
#Else If B4I
'************************************************************************************
'
'This procedure creates a HMACSHA256 of a supplied string for a given key
'
'Input parameters are:
'
'       key = key
'       input = string to be mangled
'       key_is_hex_string = flag to indicate if key is hex string (True) or 
'                           character string (False)
'
'Returns:
'
'       HMACSHA256
'
'Notes on this procedure:
'
'       o Based on:
'         https://www.b4x.com/android/forum/threads/porting-of-b4a-amazon-web-services-v4-signature-calculator.81036/#post-513785
'
'************************************************************************************

'
'[Method] - lowercase hexadecimal string of HMAC-SHA256 of key and input string
'
'key = key
'input = string to be mangled
'key_is_hex_string = flag to indicate if key is hex string (True) or character string (False)
Public Sub HMACSHA256(key As String, input As String, key_is_hex_string As Boolean) As String

	Private wrk_no As NativeObject = Me
	Private wrk_mac As Object
	Private wrk_key() As Byte
	Private wrk_bc As ByteConverter
	Private wrk_byte() As Byte

	If key_is_hex_string Then
		wrk_key = wrk_bc.HexToBytes(key)
	Else
		wrk_key = key.GetBytes("UTF8")     
	End If
	Private wrk_scrw As String = "hmacForKeyAndData::"
    wrk_mac = wrk_no.RunMethod(wrk_scrw, Array(wrk_no.ArrayToNSData(wrk_key), wrk_no.ArrayToNSData(input.GetBytes("UTF8"))))
	wrk_byte = wrk_no.NSDataToArray(wrk_mac)
   
    Return wrk_bc.HexFromBytes(wrk_byte).ToLowerCase

End Sub
#End If

'************************************************************************************
'
'This procedure URI-encodes an input string, optionally encoding any "/"
'
'Input parameters are:
'
'       input = string to be URI-encoded
'       encodeSlash = flag to indicate if "/" to be encoded
'
'Returns:
'
'       None
'
'Notes on this procedure:
'
'       o This is a port of following java which is at:
'         http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html 
'
'       Public static String UriEncode(CharSequence input, boolean encodeSlash) {
'           StringBuilder result = new StringBuilder();
'           For (int i = 0; i < input.length(); i++) {
'               char ch = input.charAt(i);
'               If ((ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z') || (ch >= '0' && ch <= '9') || ch == '_' || ch == '-' || ch == '~' || ch == '.') {
'                   result.append(ch);
'               } else if (ch == '/') {
'                   result.append(encodeSlash ? "%2F" : ch);
'               } Else {
'                   result.append(toHexUTF8(ch));
'               }
'           }
'           Return result.toString();
'       }
'
'************************************************************************************
Private Sub UriEncode(input As String, encodeSlash As Boolean) As String

	Private wrk_i As Int
	Private wrk_ch As String
	Private wrk_result As String
	Private wrk_bc As ByteConverter
	Private wrk_int_array(1) As Int
	
	For wrk_i = 0 To input.Length - 1

		wrk_ch = input.CharAt(wrk_i)
		
		If ((Asc(wrk_ch) >= Asc("A") And Asc(wrk_ch) <= Asc("Z")) Or (Asc(wrk_ch) >= Asc("a") And Asc(wrk_ch) <= Asc("z")) Or (Asc(wrk_ch) >= Asc("0") And Asc(wrk_ch) <= Asc("9")) Or Asc(wrk_ch) = Asc("_") Or Asc(wrk_ch) = Asc("-") Or Asc(wrk_ch) = Asc("~") Or Asc(wrk_ch) = Asc(".")) Then

			wrk_result = wrk_result & wrk_ch
			
		Else If wrk_ch = "/" Then
			
			If encodeSlash Then
				
				wrk_result = wrk_result & "%2F"
				
			Else
				
				wrk_result = wrk_result & wrk_ch
				
			End If
			
		Else
			
			wrk_int_array(0) = Asc(wrk_ch)
			wrk_result = wrk_result & "%" & wrk_bc.HexFromBytes(wrk_bc.IntsToBytes(wrk_int_array)).SubString(6).ToUpperCase
			
		End If
			
	Next

	Return wrk_result

End Sub

'************************************************************************************
'
'This procedure creates a full header map
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       None
'
'Notes on this procedure:
'
'       o Automatically creates standard header key, value pairs for "host", 
'         "content-type" (if AWS_S3_Content_Type is defined), "x-amz-content-sha256" 
'         and "x-amz-date" then adds non standard key, value pairs of 
'         AWS_S3_OtherHeader_map
'
'************************************************************************************
Public Sub FullHeaderMap As Map
	
	Private wrk_map As Map
	
	wrk_map.Initialize
	
	'Add standard host header
	If AWS_URI_Is_Path_Style Then
		
		'https://<endpoint>/<bucketname>/<filename>
		wrk_map.Put("host", AWS_End_Point)

	Else
		
		'https://<bucketname>.<endpoint>/<filename>
		wrk_map.Put("host", AWS_S3_Bucket_Name & "." & AWS_End_Point)
		
	End If
	
	'If content type defined...
	If AWS_S3_Content_Type <> "" Then
		
		'Add content-type header
		wrk_map.Put("content-type", AWS_S3_Content_Type)
		
	End If

	'Add standard x-amz-content-sha256 header
	wrk_map.Put("x-amz-content-sha256", HexSHA256Hash(AWS_S3_Payload))

	'Add standard x-amz-date header
	AWS_GMTFormatter.Initialize("yyyyMMdd'T'HHmmss'Z'")
	wrk_map.Put("x-amz-date", AWS_GMTFormatter.Format(AWS_S3_GMT))

	'For all key, value pairs of AWS_S3_OtherHeader_map...
	For Each wrk_key As String In AWS_S3_OtherHeader_map.Keys
		
		'Add
		wrk_map.Put(wrk_key, AWS_S3_OtherHeader_map.Get(wrk_key))
		
	Next
	
	Return wrk_map

End Sub

'************************************************************************************
'
'This procedure creates request Signature as per:
'    http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
'    Task 3: Calculate Signature
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       Signature
'
'Notes on this procedure:
'
'       Signature = HMAC-SHA256(SigningKey, StringToSign)
'
'************************************************************************************
Public Sub Signature As String
	
	Return HMACSHA256(SigningKey, StringToSign, True)

End Sub

'************************************************************************************
'
'This procedure creates request URI
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       URI
'
'Notes on this procedure:
'
'       None
'
'************************************************************************************
Public Sub URI As String
	
	Private wrk_str As String
	Private wrk_val As String
	Private wrk_1st As Boolean = True
	
	If AWS_URI_Is_Path_Style Then
		
		'https://<endpoint>
		wrk_str = "https://" & AWS_End_Point

	Else
		
		'https://<bucketname>.<endpoint>
		wrk_str = "https://" & AWS_S3_Bucket_Name & "." & AWS_End_Point
		
	End If
	
	'Add CanonicalURI
	wrk_str = wrk_str & CanonicalURI
	
	'Add ? if have query headers
	If AWS_S3_Query_map.Size > 0 Then wrk_str = wrk_str & "?"

	For Each wrk_key As String In AWS_S3_Query_map.Keys
		
		'If not first query header, add "&"
		If Not(wrk_1st) Then wrk_str = wrk_str & "&"
		
		wrk_1st = False
		
		'Add query header key
		wrk_str = wrk_str & wrk_key
		
		'Get query header value
		wrk_val = AWS_S3_Query_map.Get(wrk_key)
		
		'Add query header value if not null
		If wrk_val <>"" Then wrk_str = wrk_str & "=" & wrk_val

	Next
	
	Return wrk_str
	
End Sub

'************************************************************************************
'
'This procedure creates request Authorization as per:
'    http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       URI
'
'Notes on this procedure:
'
'       None
'
'************************************************************************************
Public Sub Authorization As String

	Return "AWS4-HMAC-SHA256 Credential=" & AWS_Access_Key_ID & _
	       "/" & Scope & _
		   ",SignedHeaders=" & SignedHeaders & _
		   ",Signature=" & Signature

End Sub

#If OBJC
#import <CommonCrypto/CommonHMAC.h>

- (NSData*) hmacForKeyAndData:(NSData*)cKey :(NSData*) cData
{
  unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
  CCHmac(kCCHmacAlgSHA256, [cKey bytes], [cKey length], [cData bytes], [cData length], cHMAC);
  return [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
}
#End If
