### Conversion from CUrl to B4A by Wong Ka Chun
### 11/17/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/136103/)

It is quite convenient to upload images to public cloud server and share the image link to other people rather than share the real image files directly!  
The following code snippets showed how to upload and search images by CUrl command (provided by: <https://apidocs.imgur.com/>) and by B4A syntax.  
  
Image upload to imgur by CUrl vs B4A  
  
1. **Search image in imgur by keyword**:  

```B4X
curl –location -g –request GET 'https://api.imgur.com/3/gallery/search?q=monkey' –header 'Authorization: Client-ID {{clientId}}'
```

  

```B4X
' Search keyword of image (i.e. anonymous get)  
Public Sub sendGetRequest() As ResumableSub  
    Dim url2 As String = "https://api.imgur.com/3/gallery/search"  
    Dim auth As String = "Client-ID " & m_clientid    '<– your client id  
    Dim job As HttpJob  
    job.Initialize("get", Me)  
    job.Download2(url2, Array As String("q", "monkey"))  
    job.GetRequest.SetHeader("authorization", auth)  
    Wait For (job) JobDone(j As HttpJob)  
    If j.Success Then  
        Log(j.GetString)  
        Return True  
    End If  
    Return False  
End Sub
```

  
  
2. **Upload image anonymously to imgur:**  

```B4X
curl –location –request POST 'https://api.imgur.com/3/image' –header 'Authorization: Client-ID {{clientId}}' –form 'image="R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"'
```

  

```B4X
' Anonymous upload  
Public Sub sendPostRequest() As ResumableSub  
    Dim url As String = "https://api.imgur.com/3/image"  
    Dim auth As String = "Client-ID " & m_clientid '<– your client id  
    Dim job As HttpJob  
    job.Initialize("post", Me)  
    Dim mapData As Map  
    mapData.Initialize  
    mapData.Put("image", "R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7")  
    mapData.Put("type", "base64")  
    'Dim jsonGen As JSONGenerator  
    'jsonGen.Initialize(mapData)  
    job.PostMultipart(url, mapData, Null)  
    job.GetRequest.SetHeader("Authorization", auth)  
    Wait For (job) JobDone(j As HttpJob)  
    If j.Success Then  
        Log(j.GetString)  
        Return True  
    End If  
    Return False  
End Sub
```

  
  
3. **Upload image to imgur account (i.e. non-anonymous):**  

```B4X
curl -X POST -H "Authorization: Bearer {{accessToken}}" -F "image=R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" https://api.imgur.com/3/upload
```

  

```B4X
' Non-anonymous upload to user's account  
Public Sub sendPostRequest2() As ResumableSub  
    Dim url As String = "https://api.imgur.com/3/upload"  
    Dim auth As String = "BEARER " & m_accesstoken '<– your access token  
    Dim job As HttpJob  
    job.Initialize("post", Me)  
    Dim mapData As Map  
    mapData.Initialize  
    mapData.Put("image", "R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7")  
    mapData.Put("type", "base64")  
    job.PostMultipart(url, mapData, Null)  
    job.GetRequest.SetHeader("Authorization", auth)  
    Wait For (job) JobDone(j As HttpJob)  
    If j.Success Then  
        Log(j.GetString)  
        Return True  
    End If  
    Return False  
End Sub
```