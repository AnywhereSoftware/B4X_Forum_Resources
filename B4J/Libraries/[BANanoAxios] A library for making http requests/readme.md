### [BANanoAxios] A library for making http requests. by Mashiane
### 02/27/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/128099/)

Ola  
  
[Download](https://github.com/Mashiane/BANanoAxios)  
  
[Example Source Code](https://github.com/Mashiane/BANanoVuetifyAD3/tree/main/Tutorials/Part48/B4J)  
  
**NB: The example source code is biased towards BVAD3, but the library itself is independent.**  
  
[MEDIA=youtube]rBggPVhJ7R4[/MEDIA]  
  
This library has been birthed, yes, again for personal use, anyway, decided to share it anyway.  
  
If you want to know the differences between Axios and Fetch, go here.  
  
Fore more details, check this out..  
  
[Differences between Axios and Fetch](https://www.geeksforgeeks.org/difference-between-fetch-and-axios-js-for-making-http-requests/#:~:text=Axios%20has%20the%20ability%20to,does%20not%20support%20upload%20progress.)  
  
**BANanoAxios**  

- **SetBasicAuthorization** (username As String, password As String) **As BANanoAxios**
set basic authorization for this connection- **SetCORS** (b As Boolean) **As BANanoAxios**
set cors - true (cors), false (no-cors)- **SetOrigin** (value As String) **As BANanoAxios**
set origin- **SetURL** (ep As String) **As BANanoAxios**
set the url to process, this is set on initialize- **AddHeader** (prop As String, value As String) **As BANanoAxios**
add a header value- **AddParameter** (prop As String, value As String) **As BANanoAxios**
add a parameter value- **AddOption** (prop As String, value As String) **As BANanoAxios**
add an option- **AddData** (prop As String, value As Object) **As BANanoAxios**
add a data value- **SetAccessControlAllowOrigin** (value As String) **As BANanoAxios**
set access control allow origin- **SetAccessControlAllowCredentials** (value As Boolean) **As BANanoAxios**
set access control allow credentials- **SetAccessControlAllowMethods** (value As String) **As BANanoAxios**
set access control allow methods- **SetAccessControlAllowHeaders** (value As String) **As BANanoAxios**
set access control allow headers- **SetContentType** (value As String) **As BANanoAxios**
set the content type- **SetTimeOut** (timeout As Int) **As BANanoAxios**
set the timeout- **Get As BANanoPromise**
get an endpoint and return a promise- **SetResponseType** (rType As String) **As BANanoAxios**
set the response type, use stream for images- **SetBaseURL** (url As String) **As BANanoAxios**
set base url- **SetMode** (mode As String) **As BANanoAxios**
set mode- **Post As BANanoPromise**
post to an endpoint and return a promise- **Put As BANanoPromise**
put to an endpoint and return a promise- **Patch As BANanoPromise**
patch to an endpoint and return a promise- **Delete As BANanoPromise**
delete an endpoint and return a promise- **FromJSON**
convert record response to something readable- **GetWait As Map**
execute a get and wait- **PostWait** (rec As Map) **As String**
execute a post and wait- **PutWait** (rec As Map) **As String**
execute a put and wait- **DeleteWait As String**
execute a delete and wait- **PatchWait As String**
execute a patch and wait- **SetResponseEncoding** (re As String) **As BANanoAxios**
set response encoding- **onUploadProgress** (module As Object, methodName As String)
on uploadprogress- **onDownloadProgress** (module As Object, methodname As String)
on onDownloadProgress- **SetMaxContentLength** (ml As Int) **As BANanoAxios**
set maxcontentlength- **SetMaxBodyLength** (mbl As Int) **As BANanoAxios**
set maxBodyLength- **SetDecompress** (b As Boolean) **As BANanoAxios**
set decompress- **SetCredentials** (s As String) **As BANanoAxios**
set credentials- **GetStatusText** (xStatus As String) **As String**
get the status text
  
  
Enjoy!