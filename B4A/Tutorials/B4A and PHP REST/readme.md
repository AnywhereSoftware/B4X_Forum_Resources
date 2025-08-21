### B4A and PHP REST by Songwut K.
### 02/21/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/114223/)

Thanks [USER=1]@Erel[/USER] for free version that I plan to buy but donate instead.  
  
I'll share my B4A knowledge in Thailand, your great product must popular, later.  
  
PHP is well known for web developer, it cheap resource and easy to learn in Thailand.  
Backend system easy manage by PHP & MySQL but till now, 2020 no one share how to use with B4A.  
  
This is my first app that I try to learn from many post in webboard.  
I don't have best practice about b4a and php, so this is my share that can help myself to remind.  
  
![](https://www.b4x.com/android/forum/attachments/88968)  
  
My concept is get text from B4A texbox r\_hospital, after click Button1 data will send to my server with data in textbox r\_hospital.  
  
some part of B4A Code  
  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
End Sub  
  
Sub Globals  
    ' Gen by B4A Designer  
  
    Private Label1 As Label  
    Private Button1 As Button  
    Private hospital As Label  
    Private php As Label  
    Private server As Label  
    Private Button2 As Button  
    Private Label5 As Label  
    Private Label6 As Label  
    Private Label7 As Label  
  
    Private r_hospital As EditText  ' input box  
    Private t_hospital As Label     ' pull data from server to show  
    Private r_php As Label            ' pull data from server to show  
    Private r_agent As Label        ' pull data from server to show  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Activity1") ' Link from Designer  
End Sub  
  
  
Sub Button1_Click  
    ProgressDialogShow("Fetching data : "&r_hospital.Text)  ' Show message when click button  
    Dim Job As HttpJob  
    Job.Initialize("dsrest", Me)   ' Init HttpJob  
    Job.PostString("https://(myweb)/demo.php","hospital="&r_hospital.text ) ' POST to url with text from box  
End Sub  
  
Sub Button2_Click  
    ExitApplication  ' click to quit  
End Sub  
  
  
Sub JobDone(Job As HttpJob)  
    ProgressDialogHide  
    If Job.Success Then  
        Dim res As String  
        res = Job.GetString                  ' Result from php store to res  
        Log("Response from server: " & res)  ' Show all of result from server to log  
        Dim parser As JSONParser  
        parser.Initialize(res)               ' Parse JSON to variable  
      
        Dim m As Map  
        m = parser.NextObject                 ' Parse object to Map  
        If m.Size = 0 Then  
            t_hospital.Text="Empty"             ' If empty data show empty message  
        Else  
            t_hospital.Text= m.Get("hospital")   ' get data from server to label  
            r_php.Text= m.Get("php")  
            r_agent.Text= m.Get("agent")  
        End If  
    Else  
        Log(Job.ErrorMessage)                    ' Error detect  
        ToastMessageShow("Error: " & Job.ErrorMessage, True)  
    End If  
    Job.Release  
End Sub
```

  
  
you must check these library  
  
![](https://www.b4x.com/android/forum/attachments/88970)