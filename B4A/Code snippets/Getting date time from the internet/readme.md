### Getting date time from the internet by Steve Kwok
### 06/03/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/118595/)

The local date time of phone or handheld device would be easily affected by user setting.   
In order to get the **accurate** date time, we can make use of the **http header** requested from any stable website!  
  
In Chrome, pressing F12 and refreshing, we can see the date from the response.  
![](https://i.imgur.com/g6b5rx5.png)  
  
By using library OkHttp, OkHttpClient instance works together with OkHttpRequest instance to get the http header:  

```B4X
Sub sendHeaderRequest()  
    Dim hc As OkHttpClient  
    hc.Initialize("hc")  
    Dim req As OkHttpRequest  
    strUrl = m_lsturl.Get(2)  
    req.InitializeHead(strUrl)  
    hc.Execute(req, 1)  
End Sub  
  
Sub hc_ResponseSuccess (Response As OkHttpResponse, TaskId As Int)  
    Log("ResponseSuccess")  
    Log(map2Json(Response.GetHeaders))  
    strResult = convertToHkDate(Response.GetHeaders.Get("date"))  
    Response.Release  
    CallSubDelayed2(strModule, strCallback, strResult)  
End Sub  
  
Sub hc_ResponseError (Response As OkHttpResponse, Reason As String, StatusCode As Int, TaskId As Int)  
    Log("ResponseError")  
    Log($"ResponseError. Reason: ${Reason}, Response: ${Response.ErrorResponse}"$)  
    Response.Release  
    CallSubDelayed2(strModule, strCallback, strResult)  
End Sub
```

  
  
The okHttpResponse instance contains Headers in form as a Map:  

```B4X
{  
    "x-frame-options": [  
        "SAMEORIGIN"  
    ],  
    "content-type": [  
        "text\/html"  
    ],  
    "connection": [  
        "keep-alive"  
    ],  
    "location": [  
        "https:\/\/hk.yahoo.com\/?p=us"  
    ],  
    "content-language": [  
        "en"  
    ],  
    "content-security-policy": [  
        "frame-ancestors 'self' https:\/\/*.techcrunch.com https:\/\/*.yahoo.com https:\/\/*.aol.com https:\/\/*.huffingtonpost.com https:\/\/*.oath.com https:\/\/*.verizonmedia.com https:\/\/*.publishing.oath.com; sandbox allow-forms allow-same-origin allow-scripts allow-popups allow-popups-to-escape-sandbox allow-presentation; report-uri https:\/\/csp.yahoo.com\/beacon\/csp?src=ats&site=frontpage&region=US&lang=en-US&device=desktop&yrid=&partner=;"  
    ],  
    "date": [  
        "Wed, 03 Jun 2020 10:07:50 GMT"  
    ],  
    "cache-control": [  
        "no-store, no-cache, max-age=0, private"  
    ],  
    "x-xss-protection": [  
        "1; report=\"https:\/\/csp.yahoo.com\/beacon\/csp?src=fp-hpkp-www\""  
    ],  
    "expires": [  
        "-1"  
    ],  
    "set-cookie": [  
        "RRC=st=1591178870&cnt=1; expires=Wed, 03-Jun-2020 10:08:20 GMT; path=\/; domain=.www.yahoo.com; HttpOnly"  
    ],  
    "content-length": [  
        "12"  
    ],  
    "server": [  
        "ATS"  
    ],  
    "strict-transport-security": [  
        "max-age=31536000"  
    ]  
}[/CODE]  
  
The sample coding is: [URL='https://drive.google.com/file/d/19Vy29Grra9Zvq_aakTxA9qtLZaI5-29V/view?usp=sharing']sample coding[/URL]  
  
The working screen is:  
[IMG]https://i.imgur.com/HmiFaAo.png[/IMG]
```