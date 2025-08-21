### CREATE, UPDATE, DELETE AND CONSULT REGISTERS ON GOOGLE SHEET FROM YOUR APPLICATIONS by fernando1987
### 04/02/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/115768/)

Searching the internet I found a service that allows you to convert any google sheet into a json api, it has a free version that allows you to consult and add data, connecting to the api is quite simple, as some of us have thought of using google sheet integrated to our developments by I want to show how this tool works.  
  
1. Create a new google spreadsheet  
2. They share the spreadsheet and if they want to be able to edit, delete and update data, they enable the permissions on the spreadsheet  
3. register for free at <https://sheet.best> Add a new sheet give it a name and copy the link of the shared sheet, and your API is ready to use and test  
  
Se necesitan las librerías JSON y OkhttpUtils2  
  

```B4X
sub API  
Dim j As HttpJob  
    j.Initialize("", Me)  
    j.Download("https://sheet.best/api/sheets/cf969697-682a-40e3-bad4-d54803eeeacf") 'change the address for your api'  
    Wait For (j) JobDone(j As HttpJob)  
    If j.Success Then  
        lvgeneral.Clear  
        Dim parser As JSONParser  
        parser.Initialize(j.GetString.Trim)  
        Dim root As List = parser.NextArray  
        For Each colroot As Map In root  
            Dim Id As String = colroot.Get("Id")  
            Dim Age As String = colroot.Get("Age")  
            Dim Name As String = colroot.Get("Name")  
            'Dim Created_at As String = colroot.Get("Created at")  
            lvgeneral.AddTwoLinesAndBitmap(Id, "Name: " & Name & " Age: " &Age , LoadBitmap(File.DirAssets,"usuario.png"))  
            lvgeneral.TwoLinesAndBitmap.SecondLabel.TextColor = 0xFF000000  
        Next  
    End If
```

  
  

```B4X
sub Update  
Dim mylist As List  
    mylist.Initialize  
    Dim m As Map  
  
  
    m.Initialize  
    m.Put("Id", lb_id.text)  
    m.Put("Age", lb_age.text)  
    m.put("Name", lb_name.Text)  
    m.put("Created at", "Fernando")  
    mylist.Add(m)  
    'Next  
'    Cursor1.Close  
  
    Dim j As JSONGenerator  
    j.Initialize2(mylist)  
    
    Dim job As HttpJob  
    job.Initialize("SendAssets", Me)  
    Dim text1 As JSONGenerator  
    text1.Initialize(m)  
    Dim SS As String  
    SS = text1.ToPrettyString(1)  
    job.PostString("https://sheet.best/api/sheets/cf969697-682a-40e3-bad4-d54803eeeacf", SS)  
  
    job.GetRequest.SetContentType("application/json")  
  
  
    Wait For (job) JobDone(job As HttpJob)  
    If job.Success = True  Then  
        Log("Response Length:" & job.GetString.Length & " bytes")  
        Log(job.GetString)  
    End If  
End Sub
```