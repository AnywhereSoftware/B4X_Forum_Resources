### OpenAI usage statistics by udg
### 02/04/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165432/)

Hi all,  
I'm having some fun in building a personal assistant based on OpenAI's ChatGPT4.   
The following snippet could be handy to meter tokens usage as seen on the Dashboard kindly provided by OpenAI. Although mine is a WIP (work in progress), everything seems to work correctly so here it is. Please amend it if needed and post your corrections on a new Thread (then I will modify the code below in order to have the amended snippet here)  
  
**Note**: the AdminKey is not the same as the Project Key. You have to generate it on your OpenAI's reserved area once logged in  
  

```B4X
Sub Class_Globals  
    'Private fx As JFX  
    Private GPT_ProjectKey As String = '<your Project Key>  
    Private GPT_OrgKey As String = '<your Organization Key>  
    Private GPT_ProjectID As String = '<your Project ID>  
    Private GPT_AdminKey As String = '<your Admin Key>  
    Public verbose As Boolean = True 'used to show Logs  
End Sub  
  
Public Sub Initialize(ShowLogs As Boolean)  
    verbose = ShowLogs  
End Sub  
  
Public Sub QueryUsage(start_time As Long, end_time As Long) As ResumableSub  
    Dim Tot_itk As Long     'total input tokens  
    Dim Tot_otk As Long        'total number of output token  
    Dim Tot_mdr As Long        'total number of model requests  
      
    Dim q_string As String  
    'q_string = $"start_time=${start_time}&end_time=${end_time}&bucket_width=1h&limit=24"$    'by the hour  
    q_string = $"start_time=${start_time}&end_time=${end_time}&bucket_width=1d&limit=31"$    'by the day  
    Wait For (MakeQueryUsage(q_string)) Complete (res As Map)  
    If res.Get("success") Then  
        'Totals from first page of data  
        Tot_itk = res.get("itk")  
        Tot_otk = res.get("otk")  
        Tot_mdr = res.get("mdr")  
        'check if there are any other pages and loop on them  
        Dim continua As Boolean = (res.Get("success") And res.Get("more"))  
        'Eventual pagination  
        Do While continua  
            If verbose Then LogColor("******pagination******", 0xFF0000FF)  
            Dim pstring As String = $"start_time=${start_time}&end_time=${end_time}&bucket_width=1d&limit=31&page=${res.Get("np")}"$  
            Wait For (MakeQueryUsage(pstring)) Complete (res2 As Map)  
            'Adding to totals freom currente page  
            Tot_itk = Tot_itk + res2.get("itk")  
            Tot_otk = Tot_otk + res2.get("otk")  
            Tot_mdr = Tot_mdr + res2.get("mdr")  
            continua = (res2.Get("success") And res2.Get("more"))  
        Loop   
    End If  
      
    'Grand Totals for the whole periood  
    Dim gtotals As Map  
    gtotals.Initialize  
    gtotals.Put("itk", Tot_itk)  
    gtotals.Put("otk", Tot_otk)  
    gtotals.Put("mdr", Tot_mdr)  
      
    Return gtotals  
End Sub  
  
'Call API completions endpoint  
Private Sub MakeQueryUsage(param As String) As ResumableSub  
    Dim usage As Map  
    usage.Initialize  
      
    Dim req As HttpJob  
    req.Initialize("", Me)  
    req.Download("https://api.openai.com/v1/organization/usage/completions?"&param)  
    req.GetRequest.SetHeader("Authorization", "Bearer " & GPT_AdminKey)  
    req.GetRequest.SetHeader("Content-Type", "application/json")  
      
    Wait For (req) JobDone(req As HttpJob)  
    If req.Success Then  
        usage = ParseJUsage(req.GetString)  
        usage.Put("success", True)  
        If verbose Then   
            If verbose Then Log(req.GetString)  
            Log($"Total Input Tokens in page: ${usage.Get("itk")}"$)  
            Log($"Total Output Tokens in page: ${usage.Get("otk")}"$)  
            Log($"Total Model Requests in page: ${usage.Get("mdr")}"$)  
        End If  
          
    Else  
        If verbose Then Log( "ERROR: " & req.ErrorMessage)  
        usage.Put("success", False)  
        usage.Put("error", req.ErrorMessage)  
    End If  
    req.Release  
      
    Return usage  
End Sub  
  
'Parse an  Usage JSON string  
Private Sub ParseJUsage(json As String) As Map  
    Dim Tot_itk As Long     'total input tokens in a given page  
    Dim Tot_otk As Long        'total number of output token in a given page  
    Dim Tot_mod As Long        'total number of model requests in a given page  
      
    Dim parser As JSONParser  
    parser.Initialize(json)  
    Dim root As Map  
    root = parser.NextObject  
      
    Dim jobject As String  = root.Get("object")                    'page  
    'Buckets in page  
    Dim jdata As List = root.Get("data")  
    For j = 0 To jdata.Size-1  
        'start time  
        Dim m1 As Map = jdata.Get(j)  
        Dim Ustime As Long = m1.Get("start_time")  
        Dim Tstime As Long = DateUtils.UnixTimeToTicks(Ustime)  
        'end time  
        Dim Uetime As Long = m1.Get("end_time")  
        Dim Tetime As Long = DateUtils.UnixTimeToTicks(Uetime)  
        If verbose Then  
            Log($"Bucket start time: ${DateTime.Date(Tstime)}"$)  
            Log($"Bucket end time: ${DateTime.Date(Tetime)}"$)  
        End If  
        ' Count token from a bucket  
        Dim jresults As List = m1.Get("results")  
        For k = 0 To jresults.Size-1  
            Dim m2 As Map = jresults.Get(k)  
            Dim itk As Long = m2.Get("input_tokens")  
            Tot_itk = Tot_itk + itk  
            Dim otk As Long = m2.Get("output_tokens")  
            Tot_otk = Tot_otk + otk  
            Dim mdr As Long = m2.Get("num_model_requests")  
            Tot_mod = Tot_mod + mdr  
            If verbose Then  
                'Log(jresults.Size)  
                Log($"Input Tokens in bucket: ${itk}"$)  
                Log($"Output Token in bucket: ${otk}"$)  
                Log($"Model Requests in bucket: ${mdr}"$)  
            End If  
        Next  
    Next  
      
    Dim jmore As Boolean = root.Get("has_more")  
    Dim jnextp As String = root.Get("next_page")  
      
    Dim res As Map  
    res.Initialize  
    res.Put("more", jmore)  
    res.Put("np", jnextp)  
    res.Put("itk", Tot_itk)  
    res.Put("otk", Tot_otk)  
    res.Put("mdr", Tot_mod)  
      
    Return res  
End Sub  
</code>  
  
An the calling code (clsChatGPT1 is the temporary name I gave to my class):  
<code>  
Private wrk_chat As clsChatGPT1  
wrk_chat.Initialize(False)  
  
DateTime.DateFormat = "dd/MM/yyyy HH:mm:ss"  
Dim ticks As Long = DateTime.DateParse("01/02/2025 00:00:01")  
Dim Uticks As Long = DateUtils.TicksToUnixTime(ticks)                        'start time in Unix time format  
Dim ticks As Long = DateTime.DateParse("03/02/2025 23:59:00")  
Dim U2ticks As Long = DateUtils.TicksToUnixTime(ticks)                        'end time in Unix time format  
Wait For (wrk_chat.QueryUsage(Uticks, U2ticks)) Complete (totals As Map)  
LogColor($"Total Input Tokens: ${totals.Get("itk")}"$, 0xFFFF0000)  
LogColor($"Total Output Tokens: ${totals.Get("otk")}"$, 0xFFFF0000)  
LogColor($"Total Model Requests: ${totals.Get("mdr")}"$, 0xFFFF0000)  
</code>
```