### QuickCurl v1.3: by Maxcfgos
### 03/15/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/170591/)

This wrapper is a lightweight utility designed to bridge the gap between cURL commands and B4X code. It’s built to be a "plug-and-play" tool for testing APIs and generating production-ready code.  
  
**Features:**   
Zero Warnings: Fully optimized to avoid B4X compiler warnings (handles DebugMode and TimeoutSeconds correctly).  
**Smart Export:** The ExportB4X function generates code using Smart Strings ($"…"$) and a clean variable-based structure (url, payload).  
Auto-Content-Type: Automatically detects if a payload is JSON and applies SetContentType just like your manual production modules do.  
Nested JSON Support: Includes a recursive FlattenJson helper to turn complex API responses into a simple, readable list.  
  
**Examples**  
1.Test a cURL live (The Execute method)Use this when you want to run a cURL command directly inside your app to see the result.  

```B4X
Sub btnRunTest_Click  
    Dim qc As QuickCurl  
    qc.Initialize  
      
    Dim myCommand As String = $"curl -X POST "https://httpbin.org/post" -d '{"item": "coffee"}'"$  
      
    ' Execute with a 5 second timeout  
    Wait For (qc.Execute(myCommand, 5)) Complete (Result As Map)  
      
    If Result.Get("success") Then  
        Log("Status: " & Result.Get("status"))  
          
        ' Print everything we found in the JSON response  
        Dim flat As List = Result.Get("flat_json")  
        For Each line As String In flat  
            Log("Data Found -> " & line)  
        Next  
    Else  
        Log("Error: " & Result.Get("error"))  
    End If  
End Sub
```

  
  
2. Turn a cURL into B4X Code (The ExportB4X method)  
  

```B4X
Sub GenerateMyCode  
    Dim qc As QuickCurl  
    qc.Initialize  
      
    Dim rawCurl As String = "curl -H 'tenant: walak-web' https://api.conexen.services/api/test"  
      
    ' Get the formatted B4X code  
    Dim b4xCode As String = qc.ExportB4X(rawCurl)  
      
    ' Output it to the log so you can copy/paste it into your project  
    Log(b4xCode)  
End Sub
```

  
  
**The Result Map Breakdown**  
  
When you call Execute, the Map returned contains exactly these keys:  
  
success: (Boolean) Did the request work?  
  
type: (String) The method used (GET, POST, etc.).  
  
status: (Int) HTTP Code (e.g., 200, 404).  
  
response: (String) The raw text from the server.  
  
is\_json: (Boolean) Was the response a JSON object?  
  
data: (Object) The parsed Map or List from the JSON.  
  
flat\_json: (List) A flat list of "key: value" strings for easy reading.  
  
error: (String) The error message if success is false.