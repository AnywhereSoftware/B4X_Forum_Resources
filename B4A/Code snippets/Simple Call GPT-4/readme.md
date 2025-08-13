### Simple Call GPT-4 by instahery
### 08/03/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/149403/)

Hello friends, maybe someone is interested in developing GPT easily….  
  
Following simple steps.  
1. Create Account at <https://app.promptbetter.ai> and generate API Token  
2. See <https://www.b4x.com/android/forum/threads/android-json-tutorial.6923/>  
3. See <https://www.b4x.com/android/forum/threads/openai.145858/#content>  
  
  
>>>>>>  
Try  
 Processing  
 Dim m As Map = CreateMap("n":1,"stop":"None","model": "gpt-3.5-turbo", "prompt": sTexto,"max\_tokens":450,"temperature":0.5) '  
 Dim js As JSONGenerator  
 js.Initialize(m)  
 Log(js.ToString)  
 Dim req As HttpJob  
 req.Initialize("",Me)  
 req.PostString("<https://api.promptbetter.ai/v1/ivt5jssh/run/(yourfilenamecreate)>",js.ToString)  
 req.GetRequest.SetHeader("Accept","application/json")  
 req.GetRequest.SetHeader("Authorization","Bearer <<ID/Key/token from <https://api.promptbetter.ai> >> ")  
 req.GetRequest.SetContentType("application/json")  
 Wait For (req) jobdone(req As HttpJob)  
 If req.Success Then  
 sucessResponse   
 Log(req.GetString)  
 Dim parser As JSONParser  
 parser.Initialize(req.GetString)  
 Dim jRoot As Map = parser.NextObject  
 Dim mx As Map 'helper map for navigating  
 mx = jRoot.Get("data")  
 Dim text As String = mx  
 Escreve\_Bot(text.Trim)  
 Else  
 edEscrever.Enabled=True  
 Log(req.ErrorMessage)  
 End If  
 req.Release  
 Catch  
 Log(LastException)  
 End Try  
>>>>>  
  
thanks