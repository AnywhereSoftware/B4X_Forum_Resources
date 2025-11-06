### GSheet Library (integrate google sheets into your B4X apps easily) by fernando1987
### 11/01/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/138967/)

**Gsheet  
  
Author:** Fernando Arevalo  
**Version:** 1.0  
  
**Functions:**  

- **Process\_Globals** As String

**B4A, B4I**  

- **Initialize** (ClientId As String)

**B4J**  

- **Initialize**(ClientId As String,ClientSecret As String)

**B4X**  

- **SpreadsheetsId** As String
The ID of your document. This is the big long aplha-numeric code in the middle of the document's URL.- **Sheets\_name** As String
Name of the sheet we are going to work on- **Sub delete**(id As Int)
id: row number to delete- **Updatesheet**(id As String, l As List)
id: row number to Update and l: list of new items- **UpdateSheet\_range**(range As String, value As String)
range: position of the value to be updated example: "A2". value: new value- **insert\_list**(l As List)
**l**: list of new items, these items will be added in the next empty row( if a list is created with the total or partial elements of a database it will be added as a single query immediately to your sheet)
  
  
**Gsheetplus  
  
Author:** Fernando Arevalo  
**Version:** 1.0  
  
**Functions:**  

- **Process\_Globals** As String

**B4A, B4I**  

- **Initialize** (ClientId As String)

**B4J**  

- **Initialize**(ClientId As String,ClientSecret As String)

**B4X**  

- **SpreadsheetsId** As String
The ID of your document. This is the big long aplha-numeric code in the middle of the document's URL.- **Sheets\_name** As String
Name of the sheet we are going to work on- **Sub delete**(id As Int)
id: row number to delete- **Updatesheet**(id As String, l As List)
id: row number to Update and l: list of new items- **UpdateSheet\_range**(range As String, value As String)
range: position of the value to be updated example: "A2". value: new value- **insert\_list**(l As List)
**l**: list of new items, these items will be added in the next empty row( if a list is created with the total or partial elements of a database it will be added as a single query immediately to your sheet)- **copytodrive**(title As String,sheetcopy As String)
creates a copy in the drive of the account with which you enter a selected sheet you must define the name of the new spreadsheet (**title**) and the name of the sheet to copy (**sheetcopy**)- **createtitle**( l As List, sheetsname As String, fontsize As Int,bold As Boolean)
**l:** list of titles, **sheetsname:** name of the sheet where the titles will be inserted- **create\_spreadsheets**(title1 As String)
**title:** name of the new spreadsheet- **create\_sheets**(name\_sheets As String,SpreadsheetId As String)
**name\_sheets:** name of the new sheet, **SpreadsheetId:**The ID of your document- **deletesheet**(sheetsname As String )
**name\_sheets:** name of the sheet for delete into spreadsheet- **newspreadsheetsid** As String
allows to retrieve the id after creating a new spreadsheet or after backing up one in drive to save it in a database or variable it is recommended to put a wait of 2s before calling the value of this variable- **newnamesheet** As String
allows you to retrieve the name of the new sheet created to save it in a database or variable it is recommended to wait for 2s before calling the value of this variable
  
  
  
**NOTE:**  
  
This library is **not free**, because, it took a lot of time and gray hair to create all the methods and learn how the api works.  
Please **write GSheets or GSheetplus** in the order description, thanks.  
  
  
  
Thanks for your understanding. :)  
  
This library depends the Google OAuth2 class:  
<https://www.b4x.com/android/forum/threads/class-b4x-google-oauth2.79426/>  
follow the tutorial in this topic to create your project in google console developer, enable google dive and google sheets apis, make sure to add your package name to your project, and create an oauth screen.  
  
Add this in your manifest:  
  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase)
```

  
  
Read example for v4 api:  

```B4X
Sub GetSheet  
table1.ClearAll  
    Dim j As HttpJob  
    j.Initialize("", Me)  
    j.Download("https://sheets.googleapis.com/v4/spreadsheets/17YACjfqxKHDCXM_N7Jnq9BC_KzzkEgXLKzHDwaIM5Zs/values/Example!A2:Z?key=xxxxxxxxxxxxxxxxxxxxxxxxx")  
    Wait For (j) JobDone(j As HttpJob)  
    If j.Success Then  
        Dim parser As JSONParser  
        parser.Initialize(j.GetString.Trim)  
        Dim root As Map = parser.NextObject  
        'Dim majorDimension As String = root.Get("majorDimension")  
        Dim values As List = root.Get("values")  
   
        For Each colvalues As List In values  
   
  Dim id1 As Int = colvalues.Get("4")  
            Dim create As String = colvalues.Get("3")  
            Dim Telephone1 As Int = colvalues.Get("0")  
            Dim Age1 As Int = colvalues.Get("2")  
            Dim Name1 As String = colvalues.Get("1")  
            If colvalues.Size > 0 Then  
             table1.AddRow(Array As String(id1,Telephone1,Name1,Age1,create))  
            End If  
   
        Next  
        Dim range As String = root.Get("range")  
        Log(range)  
    End If  
  
   
  
    j.Release  
End Sub
```

  
  
Read example with Gsheets  

```B4X
Sub GetSheet  
  
   
    Table1..ClearAll  
    s.GetSheet(Me)  
    Wait For get_result(x As List)  
   
    For Each col As Map In x  
   
        Table1.AddRow(Array As String(col.Get("1"),col.Get("Téléphone"),col.Get("Name"),col.Get("Age"),col.Get("created")))  
   
    Next  
   
End Sub
```

  
  
Example connect:  
  

```B4X
#Region  Activity Attributes  
    #FullScreen: false  
    #IncludeTitle: FALSE  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
  
    Dim s As GSheets  
    Private conect1 As Button  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    s.Initialize(Me, "s")'your Clientid google developers console, activate google drive api and google sheets api  
    s.Sheets_name = "Example"  
    s.SpreadsheetsId = "1FHx-a_a4afTQ3L5hXJIOttCVaJNngO3113E-qqFOjbk"  
    Activity.LoadLayout("sheets1")  
   
End Sub  
  
'Connect  
Sub connect1_Click  
    s.connect  
End Sub  
  
Sub Activity_Resume  
  
s.oauth2.CallFromResume(Activity.GetStartingIntent)  
   
End Sub
```

  
  
  
**Advantages:**  

- **It is not linked to paying an external api**
- **the google sheet api is totally free**
- **You can integrate multiple apps into a single project in the google console**
- **Easy to use and integrate**

**Download page:  
  
Download Gsheetsplus:**  
<https://b4xapp.com/item/gsheetplus->  
  
**Download Gsheets:**  
<https://b4xapp.com/item/gsheets->  
  
  
  
Important in the verification screen of your project in google cloud activate this permission:  
![](https://www.b4x.com/android/forum/attachments/142542)  
  
  
B4J Example google sheet:  
[Sheet for example](https://docs.google.com/spreadsheets/d/1FHx-a_a4afTQ3L5hXJIOttCVaJNngO3113E-qqFOjbk/edit?gid=0#gid=0)  
  
  
B4A Example google sheet:  
[Sheet for example](https://docs.google.com/spreadsheets/d/1rSe34K-uTDmHdQObDSa9Nr0Hm6UPlf818OKC4FkioUU/edit?gid=0#gid=0)