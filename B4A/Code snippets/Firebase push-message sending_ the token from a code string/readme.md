### Firebase push-message sending: the token from a code string by peacemaker
### 04/30/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/166801/)

ServiceAccount JSON-file is required for Firebase push-message sending. It's dangerous to use this JSON-file in the app as-is.  
But it's possible to save it's content into a code string, like:  
  
> Private const ServiceAccountFilePath As String = $"{  
>  "type": "service\_account",  
>  "project\_id": "projectname",  
>  "private\_key\_id": "506268f56cawcwdcwdca63783c9624e304a",  
>  "private\_key": "—–BEGIN PRIVATE KEY—–\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCuWkUTYGNb368Q\nogCkj/P+0v96+5DvyQK0zV/bZA3pLVePpXaoautHFO/8Hxz+k0ZeSTqDQq8zJU6z\n17QFPqY9hyZ0Oz7HvKPXL8QQk7vawQiYObG1nHTaWoC0u9MqPUH4hi9kselP0oRF\navXJ2GzZHEfvRUQhbPRCcFpxKXAGo+PzZqFBh87LxxH+F13vQs5mc59Gj40oLlHt\nt8+ZfjyLwXc9MhIHORtEahYpd7BHxoWLEnNjpWYff7xFVDj91qnjvHSCSzDCi+6J\nODYZC4vm0gYhvMODtOolU+biqpMywKwBccgmFoGFxlEvO+IMnHOCxugYJEKOQHJh\nZWReEtGRAgMBAAECggEAINhMjvvne9VFq4J5UIb11hl1m3tssF9TrS/LUQ8mN7kc\n96iaE9wgeoGNPBe4ZJTl+rkc1sFnM+FhVCvcc+h7dLfTHK5Ug1gcHVuYOe86wlj+\n/35O5gGVWdUweMGbd2K2em/+QDkOAO3uM1ft5deUIACEyVoGp+iIkR5Eg038Y\nHZO9IjEP/I4RrKSN1/eNqpkkItpjIoyNV7drrvrk9BZ4XFHJJICzGYRqPtpe8i1\nl+WVceUv+z887GdJYptZFQ+iZN2gw6OKRp46i5S2NCz/eg7ZO2xU5My1ee/AbGpC\nWa7y0JBSY5HH+yIZCRc71wRGrQqvXTaFUXBFu9oRYQKBgQDwTEByk7iDXqdN19Dm\nK0AQ0Xu3cwreMz2ZxnvoSVRdRLpehNjcS660n4Ut5YbHOlixI8AMNGf+t3t3dzlW\nQrvqcjh8nQjhXgQ6JfY1W4XF0zy9kpMxuN+nsEkupuSWt8z9KJz3BAFr3FyOMri3\nFvuo1BkTjd58txaoGySmuTdUHQKBgQC5vt+gJRN4GS+P1wUEQiLjW9ifC35BdEM1\nDuDJu7ESAQwJtkA7dW5L+EYyZMOIEZJ2IKwo5/AwCJu3kATJOnzqe1RJv6+X+2Ue\nogjKVZyg8Q3t9v+y1skkvZUvcvIala+83Yg1tdHXKtchOxch74a6i4JgBV8aZtzEfv4OBVRBQKBgQCTeHhk2Lt4A/LxFu2hFBHxQF6IqxWUYCYB5YnNeJNJ2g/2Sdk8\n+UVynCODk0Uvp2Me8y29T7wy2i/vlT+e7L2emBKKh2UXyjcV6I49GLn0OjsgrH+h\nGDBKHSoMc2f+BzbKds492jt1EnvK2N37nyM67U+mbH6KU2KYMHBB0ZFfEQKBgBMz\npzyP+KZGvEL7cHpTN/YXDZrLfl7X3QbEJfrU22ZIE22BmLxM1H0oCmG1Rv1vC5wI\nnqOP7qWYjjh4u/XthPJck4cYONfWVkrHZ287UHjW0qDSEvby+1JAAwcns92JseQt\nZqJezHWY6Sp3SFnqwBvSxkSU6ZL6JUJvXk4rRhDdAoGAZa/m2KqIVzj4WIvbh4rg\nZQDkPUsa1ZThmUSQh4euYOBLtbI098OPENaeyG8xlqEF2oGOkqUP6i4MrY5H1izJ\ntYheYa7Q4gALtPVXQDbFF1Ovb+7OCX79zGiaTZO2mS7FDuP3Fbyu3mzrN+4V14iP\nKV0V2vyzJDzMUT3Ho3BPoTI=\n—–END PRIVATE KEY—–\n",  
>  "client\_email": "[EMAIL]firebase-adminsdk-fbsvc@projectname.iam.gserviceaccount.com[/EMAIL]",  
>  "client\_id": "13302134889356049942",  
>  "auth\_uri": "<https://accounts.google.com/o/oauth2/auth>",  
>  "token\_uri": "<https://oauth2.googleapis.com/token>",  
>  "auth\_provider\_x509\_cert\_url": "<https://www.googleapis.com/oauth2/v1/certs>",  
>  "client\_x509\_cert\_url": "[https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc@projectname.iam.gserviceaccount.com](https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40projectname.iam.gserviceaccount.com)",  
>  "universe\_domain": "googleapis.com"  
> } "$ 'change

and use in the sending Android-app with "GetTokenValueFromJSON" sub:  
  

```B4X
'from JSON-file, DANGEROUS to store ServiceAccount JSON file !  
Private Sub GetTokenValue (FilePath As String) As String  
    Dim GoogleCredentials As JavaObject  
    GoogleCredentials.InitializeStatic("com.google.auth.oauth2.GoogleCredentials")  
    Dim Credentials As JavaObject = GoogleCredentials.RunMethodJO("fromStream", Array(File.OpenInput(FilePath, ""))) _  
        .RunMethod("createScoped", Array(Array As String("https://www.googleapis.com/auth/firebase.messaging")))  
    Credentials.RunMethod("refreshIfExpired", Null)  
    Return Credentials.RunMethodJO("getAccessToken", Null).RunMethod("getTokenValue", Null)  
End Sub  
  
'from string with JSON-file content  
Private Sub GetTokenValueFromJSON (firebase_adminsdk_json_string As String) As String  
    Dim bc As ByteConverter  
    Dim bytes() As Byte = bc.StringToBytes(firebase_adminsdk_json_string, "UTF8")  
    Dim InputStream As InputStream  
    InputStream.InitializeFromBytesArray(bytes, 0, bytes.Length)  
     
    Dim GoogleCredentials As JavaObject  
    GoogleCredentials.InitializeStatic("com.google.auth.oauth2.GoogleCredentials")  
    Dim Credentials As JavaObject = GoogleCredentials.RunMethodJO("fromStream", Array(InputStream)) _  
        .RunMethod("createScoped", Array(Array As String("https://www.googleapis.com/auth/firebase.messaging")))  
    Credentials.RunMethod("refreshIfExpired", Null)  
    Return Credentials.RunMethodJO("getAccessToken", Null).RunMethod("getTokenValue", Null)  
End Sub
```

  
  
Or is it also non-safe ?