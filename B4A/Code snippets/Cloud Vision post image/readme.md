### Cloud Vision post image by yiankos1
### 11/25/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/124913/)

Hello,  
  
After 4 hours searching i figure it out how to post an image to Cloud Vision API in order to check if content is safe:  
  

```B4X
Private job As HttpJob  
  
        Private googlekey As String = "YOUR API KEY"  
  
'Encode image to Base64   
        Dim img () As Byte  
        img=Bit.InputStreamToBytes(File.OpenInput(File.DirAssets, "10554.jpg"))  
        Dim su As StringUtils  
        Dim encoded As String  
        encoded = su.EncodeBase64(img)  
  
'Post data  
        Private data As String = $"{  
  "requests": [  
    {  
      "image": {  
        "content": "${encoded}"  
      },  
      "features": [  
        {  
          "type": "SAFE_SEARCH_DETECTION"  
        }  
      ]  
    }  
  ]  
}"$  
  
        job.Initialize("ocr",Me)  
        job.PostString("https://vision.googleapis.com/v1/images:annotate?key=" & googlekey, data)  
        job.GetRequest.SetContentType("application/json")  
   
        Wait For (job) JobDone(job As HttpJob)  
        If job.Success Then  
            'Log(job.GetString)  
            Dim parser As JSONParser  
            parser.Initialize(job.GetString)  
            Dim root As Map = parser.NextObject  
            Dim responses As List = root.Get("responses")  
            For Each colresponses As Map In responses  
                Dim safeSearchAnnotation As Map = colresponses.Get("safeSearchAnnotation")  
                Dim spoof As String = safeSearchAnnotation.Get("spoof")  
                Dim racy As String = safeSearchAnnotation.Get("racy")  
                Dim medical As String = safeSearchAnnotation.Get("medical")  
                Dim adult As String = safeSearchAnnotation.Get("adult")  
                Dim violence As String = safeSearchAnnotation.Get("violence")  
                Log(violence)  
            Next  
        Else  
            Log(job.ErrorMessage)  
        End If
```