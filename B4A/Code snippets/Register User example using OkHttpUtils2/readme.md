### Register User example using OkHttpUtils2 by aeric
### 01/26/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/52293/)

**Register User example using OkHttpUtils2**  
  
![](https://www.b4x.com/android/forum/attachments/77216) ![](https://www.b4x.com/android/forum/attachments/77217) ![](https://www.b4x.com/android/forum/attachments/77218) ![](https://www.b4x.com/android/forum/attachments/77219) ![](https://www.b4x.com/android/forum/attachments/77220) ![](https://www.b4x.com/android/forum/attachments/77221)  
  
[TABLE]  
[TR]  
[TH]Updates:[/TH]  
[/TR]  
[TR]  
[TD]This project is deprecated. Please check **User Login + MySQL PHP API**  
<https://www.b4x.com/android/forum/threads/user-login-mysql-php-api.117826/>[/TD]  
[/TR]  
[/TABLE]  
  
**Introduction**  
This code snippet is based on the [thread](https://www.b4x.com/android/forum/threads/user-registration-using-httputils2-php-mysql-and-mail.42745/) posted by [USER=35245]KMatle[/USER] in Tutorials & Examples. You can modify the layout and add in to your apps so that registered members can use your app by logging in using their user id and password.  
  
**How it works**  
This app starts by checking for connection by sending a request to the server and wait for a reply. The PHP script in the server will process the request and send back a JSON string. The screen will show "Connection success" if it is getting a response from the server.  
  
Tap on the 'Register' button and the app will open up a new activity where information such as user id, password and email are required for the registration process. The data submitted will be stored in a MySQL database. An email will be sent to the user. If the user id or email is already registered before, a message will show "The user id '[YourUserID]' or email ([YourEmail]) is already in use". Open the email and click on the link to finish the registration process.  
  
After successful register, you can press the 'Login' button to open up the Login activity. If you try to log in without activating your account at the first place, the app will show a message "Account is not activated!". Key in your user id and password and tap on the 'Login' button. If user id and password are incorrect, the app will show a message "Wrong User ID or Password!". If log in success, the app will show a message "Welcome, [YourFullName]" in a new activity showing a list of registered members in a listview.  
  
This code snippet demonstrates of the usage of :  
1. HttpUtils2 to connect to MySQL database located in a free hosting provider (using PHP web services and JSONParser)  
2. Multiple Activity and Layout  
3. SQL commands to Insert and Update records in MySQL database tables  
4. Regular expression to check the email format  
5. PHP Mail() function to send mail to the new member for activation and notify the administrator.  
6. ListView for populating records stored in MySQL database table  
  
Note that you can add more functions such as password hashing, retrieve forgotten password and using Captcha verification.  
  
Version 1.1 (Update 07 July 2015)  
- Rename a field in database table tbl\_member from "status" to "reg\_status"  
- Added "(Online)" beside user name in listview  
- Added a Log out button and signout.php  
- Fixed signin.php showing 'null' user name  
  
Version 1.2 (Update 10 Mar 2016)  
[- Retrieve Password](https://www.b4x.com/android/forum/threads/register-user-example-using-httputils2.52293/page-3#post-408142)  
[- Reset Password](https://www.b4x.com/android/forum/threads/register-user-example-using-httputils2.52293/page-3#post-408159)  
  
Reupload PHP files (Update 19 Apr 2016)  
Due to many confusion of **register.php** in a line of code somewhere in signup.php script, I have reuploaded **PHP.zip** in attachment. Sorry for the inconvenience.  
  
Version 1.3 (Update 08 Feb 2019)  
- Set targetSdkVersion=26  
- Replaced HttpUtils2 with OkHttpUtils2  
- Changed conflicting Job names with module names  
- Added Change Password activity  
- Removed Forgot Password activity  
- Replaced MySQL functions in PHP script with MySQLi functions  
- Added db.php in PHP script to store global variables  
  
**B4A Codes**  
[SPOILER="Main activity"]  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: Demo  
    #VersionCode: 4  
    #VersionName: 1.3  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: portrait  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: False  
#End Region  
  
Sub Process_Globals  
    Dim strURL As String = "http://demo.computerise.my/b4a/register-user-php/"    ' Remote / Production  
    'Dim strURL As String = "http://192.168.43.191:8000/register-user-php/"        ' Local / Development  
End Sub  
  
Sub Globals  
    Private Panel1 As Panel  
    Private lblTitle As Label  
    Private lblVersion As Label  
    Private btnLogin As Button  
    Private btnRegister As Button  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("frmStart")  
    lblVersion.Text = "v 1.3"  
    TestConnection  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub Activity_KeyPress(KeyCode As Int) As Boolean  
    Dim Answ As Int  
    Dim Txt As String  
  
    If KeyCode = KeyCodes.KEYCODE_BACK Then    ' Checks if the KeyCode is BackKey  
        Txt = "Do you really want to quit the program ?"  
        Answ = Msgbox2(Txt, "A T T E N T I O N", "Yes", "", "No", Null) ' MessageBox  
        If Answ = DialogResponse.POSITIVE Then    ' If return value is Yes then  
            Return False    ' the Event will not be consumed       
        Else                ' we leave the program  
            Return True        ' the Event will be consumed to avoid  
        End If                ' leaving the program  
    Else  
        Return True            ' the Event will be consumed to avoid  
    End If  
End Sub  
  
Sub lblTitle_Click  
    Dim p As PhoneIntents  
    Dim Url As String = "http://computerise.my"  
    StartActivity(p.OpenBrowser(Url))  
End Sub  
  
Sub btnLogin_Click  
    StartActivity("Login")  
End Sub  
  
Sub btnRegister_Click  
    StartActivity("Register")  
End Sub  
  
Sub TestConnection  
    Dim Connect As HttpJob  
    Connect.Initialize("Connect", Me)  
    Connect.Download(strURL & "connect.php")  
    ProgressDialogShow("Connecting to server…")  
End Sub  
  
Sub JobDone (Job As HttpJob)  
    ProgressDialogHide  
    If Job.Success = True Then  
        Dim ret As String  
        ret = Job.GetString  
        Dim parser As JSONParser  
        parser.Initialize(ret)   
        If Job.JobName = "Connect" Then  
            Dim act As String = parser.NextValue  
            If act = "Connected" Then  
                ToastMessageShow("Connection success", True)  
            End If   
        End If  
    Else  
        ToastMessageShow("Error: " & Job.ErrorMessage, True)  
    End If  
    Job.Release  
End Sub
```

  
[/SPOILER]  
  
[SPOILER="Register activity"]  

```B4X
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: False  
#End Region  
  
Sub Process_Globals  
  
End Sub  
  
Sub Globals  
    Dim txtUserID As EditText  
    Dim txtPassword As EditText  
    Dim txtFullName As EditText  
    Dim txtLocation As EditText  
    Dim txtEmail As EditText  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("frmRegister")  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub btnRegister_Click  
    Dim strUserID As String = txtUserID.Text.Trim  
    If strUserID = "" Then  
        Msgbox("Please enter User ID", "Error")  
        Return  
    End If  
    Dim strPassword As String = txtPassword.Text.Trim  
    If strPassword = "" Then  
        Msgbox("Please enter Password", "Error")  
        Return  
    End If  
    Dim strFullName As String = txtFullName.Text.Trim  
    If strFullName = "" Then  
        Msgbox("Please enter Full Name", "Error")  
        Return  
    End If  
    Dim strLocation As String = txtLocation.Text.Trim  
    If strLocation = "" Then  
        Msgbox("Please enter Location", "Error")  
        Return  
    End If  
    Dim strEmail As String = txtEmail.Text.Trim  
    If strEmail = "" Then  
        Msgbox("Please enter Email", "Error")  
        Return  
    End If  
    If Validate_Email(strEmail) = False Then  
        Msgbox("Email format is incorrect", "Error")  
        Return  
    End If  
  
    Dim Job1 As HttpJob  
    Job1.Initialize("Register", Me)  
    Job1.Download2(Main.strURL & "signup.php", _  
      Array As String("Action", "Register", _  
      "UserID", txtUserID.Text, _  
      "Password", txtPassword.Text, _  
      "FullName", txtFullName.Text, _  
      "Location", txtLocation.text, _  
      "Email", txtEmail.Text))  
    ProgressDialogShow("Connecting to server…")  
End Sub  
  
Sub JobDone (Job As HttpJob)  
    ProgressDialogHide  
    If Job.Success Then  
        Dim parser As JSONParser  
        Dim res As String  
        Dim action As String  
        res = Job.GetString   
        parser.Initialize(res)           
        Select Job.JobName  
            Case "Register"  
                action = parser.NextValue  
                If action = "Mail" Then  
                    Msgbox("An email was sent to " & txtEmail.Text & ". Please click on the link to finish registration", "Registration")  
                    Activity.Finish  
                Else If action = "MailInUse" Then  
                    Msgbox("The user id '" & txtUserID.Text & "' or email (" & txtEmail.Text & ") is already in used", "Registration")  
                Else  
                    Msgbox("Server does not return expected result.", "Registration")  
                End If  
        End Select  
    Else  
        'Log("Error: " & Job.ErrorMessage)  
        ToastMessageShow("Error: " & Job.ErrorMessage, True)  
    End If  
    Job.Release  
End Sub  
  
' // Source: https://www.b4x.com/android/forum/threads/validate-a-correctly-formatted-email-address.39803/  
Sub Validate_Email(EmailAddress As String) As Boolean  
    Dim MatchEmail As Matcher = Regex.Matcher("^(?i)[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])$", EmailAddress)  
  
    If MatchEmail.Find = True Then  
        'Log(MatchEmail.Match)  
        Return True  
    Else  
        'Log("Oops, please double check your email address…")  
        Return False  
    End If  
End Sub
```

  
[/SPOILER]  
  
[SPOILER="Login activity"]  

```B4X
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: False  
#End Region  
  
Sub Process_Globals  
    Dim strUserID As String  
    Dim strUserName As String  
End Sub  
  
Sub Globals  
    Dim txtUserID As EditText  
    Dim txtPassword As EditText  
    Dim lblMessage As Label  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("frmLogin")  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub btnLogin_Click  
    'Dim strUserID As String = txtUserID.Text.Trim  
    lblMessage.Text = ""  
    strUserID = txtUserID.Text.Trim  
    If strUserID = "" Then  
        Msgbox("Please enter User ID", "Error")  
        Return  
    End If  
    Dim strPassword As String = txtPassword.Text.Trim  
    If strPassword = "" Then  
        Msgbox("Please enter Password", "Error")  
        Return  
    End If  
  
    Dim Job2 As HttpJob  
    Job2.Initialize("Login", Me)  
    Job2.Download2(Main.strURL & "signin.php", _  
    Array As String("user_id", strUserID, "password", strPassword))  
    ProgressDialogShow("Connecting to server…")  
End Sub  
  
Sub JobDone (Job As HttpJob)  
    ProgressDialogHide  
    If Job.Success = True Then  
        Dim ret As String  
        Dim act As String   
        ret = Job.GetString    
        Dim parser As JSONParser  
        parser.Initialize(ret)   
        act = parser.NextValue  
        If act = "Not Found" Then  
            ToastMessageShow("Login failed", True)  
            lblMessage.Text = "Wrong User ID or Password!"  
            lblMessage.TextColor = Colors.Red  
        Else If act = "Not Activated" Then  
            ToastMessageShow("Login failed", True)  
            lblMessage.Text = "Account is not activated!"  
            lblMessage.TextColor = Colors.Blue       
        Else If act = "Error" Then  
            ToastMessageShow("Login failed", True)  
            lblMessage.Text = "An error has occured!"  
            lblMessage.TextColor = Colors.Red  
        Else  
            strUserName = act  
            StartActivity("Member")  
            Activity.Finish  
        End If  
    Else  
        'Log("Error: " & Job.ErrorMessage)  
        ToastMessageShow("Error: " & Job.ErrorMessage, True)  
    End If  
    Job.Release  
End Sub  
  
'Sub btnForgotMyPassword_Click  
'    StartActivity("Forgot")  
'End Sub  
  
Sub btnResetMyPassword_Click  
    StartActivity("Reset")  
End Sub
```

  
[/SPOILER]  
  
[SPOILER="Member activity"]  

```B4X
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: False  
#End Region  
  
Sub Process_Globals  
  
End Sub  
  
Sub Globals  
    Type TwoLines (First As String, Second As String)  
    Private ListView1 As ListView  
    Private btnLogout As Button  
    Private lblMessage As Label  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("frmMember")  
    lblMessage.Text = "Welcome, " & Login.strUserName  
    LoadMemberList  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub LoadMemberList  
    Dim Job3 As HttpJob  
    Job3.Initialize("Member", Me)  
    Job3.Download(Main.strURL & "member.php")  
    ProgressDialogShow("Downloading list of registered members")  
End Sub  
  
Sub LogMeOut  
    Dim Job4 As HttpJob  
    Job4.Initialize("LogOut", Me)  
    Job4.Download2(Main.strURL & "signout.php", _  
    Array As String("user_id", Login.strUserID))  
    ProgressDialogShow("Logging out…")  
End Sub  
  
Sub JobDone (Job As HttpJob)  
    ProgressDialogHide  
    If Job.Success = True Then  
        Dim strReturn As String = Job.GetString  
        Dim parser As JSONParser  
        parser.Initialize(strReturn)  
        If Job.JobName = "Member" Then  
            Dim Members As List  
            Dim strOnline As String  
            Members = parser.NextArray 'returns a list with maps  
            For i = 0 To Members.Size - 1  
                Dim m As Map  
                m = Members.Get(i)  
                Dim TL As TwoLines  
                If m.Get("online") = "Y" Then  
                    strOnline = " (Online)"  
                Else  
                    strOnline = ""  
                End If  
                TL.First = m.Get("user_id") & strOnline  
                TL.Second = m.Get("location")  
                ListView1.AddTwoLines2(TL.First, TL.Second, TL)  
            Next  
        Else If Job.JobName = "LogOut" Then  
            Dim act As String = parser.NextValue  
            If act = "LoggedOut" Then  
                ToastMessageShow("Logout successful", True)           
                StartActivity(Main)  
                Activity.Finish  
            End If           
        Else  
            ToastMessageShow("Error: Invalid Value", True)  
        End If  
    Else  
        'Log("Error: " & Job.ErrorMessage)  
        ToastMessageShow("Error: " & Job.ErrorMessage, True)  
    End If  
    Job.Release  
End Sub  
  
Sub btnChangePassword_Click  
    StartActivity("Change")  
End Sub  
  
Sub btnLogout_Click  
    LogMeOut  
End Sub
```

  
[/SPOILER]  
  
[SPOILER="Reset activity"]  

```B4X
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: False  
#End Region  
  
Sub Process_Globals  
  
End Sub  
  
Sub Globals  
    Private txtEmail As EditText  
    Dim strEmail As String  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("frmReset")  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub btnSubmit_Click  
    strEmail = txtEmail.Text.Trim  
    If strEmail = "" Then  
        Msgbox("Please enter Email", "Error")  
        Return  
    End If  
    If Validate_Email(strEmail) = False Then  
        Msgbox("Email format is incorrect", "Error")  
        Return  
    End If  
    Dim Job5 As HttpJob  
    Job5.Initialize("ResetPassword", Me)  
    Job5.Download2(Main.strURL & "reset-password.php", _  
      Array As String("Action", "RequestPasswordReset", _  
      "Mail", strEmail))  
    ProgressDialogShow("Connecting to server…")  
End Sub  
  
Sub JobDone (Job As HttpJob)  
    ProgressDialogHide  
    If Job.Success Then  
    Dim res As String, action As String  
        res = Job.GetString   
        Dim parser As JSONParser  
        parser.Initialize(res)  
        Select Job.JobName  
            Case "ResetPassword"  
                action = parser.NextValue  
                If action = "ValidEmail" Then  
                    Msgbox("An email was sent to " & strEmail & " to reset your password.", "Reset Password")               
                Else If action = "InvalidEmail" Then  
                    Msgbox("The email is not registered in our database.", "Reset Password")  
                End If  
        End Select  
    Else  
        'Log("Error: " & Job.ErrorMessage)  
        ToastMessageShow("Error: " & Job.ErrorMessage, True)  
    End If  
    Job.Release  
End Sub  
  
' // Source: https://www.b4x.com/android/forum/threads/validate-a-correctly-formatted-email-address.39803/  
Sub Validate_Email(EmailAddress As String) As Boolean  
    Dim MatchEmail As Matcher = Regex.Matcher("^(?i)[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])$", EmailAddress)  
  
    If MatchEmail.Find = True Then  
        'Log(MatchEmail.Match)  
        Return True  
    Else  
        'Log("Oops, please double check your email address…")  
        Return False  
    End If  
End Sub
```

  
[/SPOILER]  
  
[SPOILER="Change activity"]  

```B4X
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: False  
#End Region  
  
Sub Process_Globals  
  
End Sub  
  
Sub Globals  
    Private txtEmail As EditText  
    Private txtPassword1 As EditText  
    Private txtPassword2 As EditText  
    Private txtPassword3 As EditText  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("frmChange")  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub btnSubmit_Click  
    Dim strEmail As String = txtEmail.Text.Trim  
    If strEmail = "" Then  
        Msgbox("Please enter Your Email", "Error")  
        Return  
    End If  
    Dim strPassword1 As String = txtPassword1.Text.Trim  
    If strPassword1 = "" Then  
        Msgbox("Please enter Current Password", "Error")  
        Return  
    End If  
    Dim strPassword2 As String = txtPassword2.Text.Trim  
    If strPassword2 = "" Then  
        Msgbox("Please enter New Password", "Error")  
        Return  
    End If  
    Dim strPassword3 As String = txtPassword3.Text.Trim  
    If strPassword3 = "" Then  
        Msgbox("Please reenter New Password", "Error")  
        Return  
    End If  
    If strPassword2 <> strPassword3 Then  
        Msgbox("New Password not match", "Error")  
        Return  
    End If  
  
    Dim Job6 As HttpJob  
    Job6.Initialize("Change", Me)  
    Job6.Download2(Main.strURL & "change-password.php", _  
    Array As String("Email", strEmail, _  
    "Password1", strPassword1, _  
    "Password2", strPassword2))  
    ProgressDialogShow("Connecting to server…")  
End Sub  
  
Sub JobDone (Job As HttpJob)  
    ProgressDialogHide  
    If Job.Success = True Then  
        Dim ret As String  
        Dim act As String  
        ret = Job.GetString  
        Dim parser As JSONParser  
        parser.Initialize(ret)  
        act = parser.NextValue  
        If act = "Success" Then  
            Msgbox("Password updated successfully!", "Change Password")  
        Else If act = "Not Found" Then   
            Msgbox("Email or Password not correct!", "Change Password")  
        Else If act = "Error" Or act = "Failed" Then  
            Msgbox("An error occured!", "Change Password")  
        Else ' Failed  
            Msgbox("Uncaught error!", "Change Password")  
        End If  
    Else  
        'Log("Error: " & Job.ErrorMessage)  
        ToastMessageShow("Error: " & Job.ErrorMessage, True)  
    End If  
    Job.Release  
End Sub
```

  
[/SPOILER]  
  
**PHP Scripts**  
  
[SPOILER="connect.php"]  
[PHP]<?php  
 print json\_encode("Connected");  
?>[/PHP]  
[/SPOILER]  
  
[SPOILER="db.php"]  
[PHP]<?php  
 $host = "localhost";  
 $user = "myuser";  
 $pass = "mypassword";  
 $db = "demo\_b4a";  
 $mysqli = new mysqli($host, $user, $pass, $db) or die($mysqli->error);  
  
 // $server = "<http://demo.computerise.my/b4a/>";  
 $server = "<http://192.168.43.191:8000/register-user-php/>";  
 $admin = "mailer@computerise.my";  
 $sender = "no-reply@computerise.my";  
?>[/PHP]  
[/SPOILER]  
  
[SPOILER="signup.php"]  
[PHP]<?php  
 require 'db.php';  
 try  
 {  
 if(!isset($\_GET['Action']) || empty($\_GET['Action']))  
 {  
 print json\_encode("Parameter Error");  
 exit;  
 }   
 $action = $mysqli->escape\_string($\_GET["Action"]);  
  
 switch ($action)  
 {  
 case "Register":  
 if (!isset($\_GET['UserID']) || empty($\_GET['UserID']) ||  
 !isset($\_GET['Email']) || empty($\_GET['Email']) ||  
 !isset($\_GET['Password']) || empty($\_GET['Password']) ||  
 !isset($\_GET['FullName']) || empty($\_GET['FullName']) ||  
 !isset($\_GET['Location']) || empty($\_GET['Location']))  
 {  
 print json\_encode("Parameter Error");  
 exit;  
 }  
 $user = $mysqli->escape\_string($\_GET["UserID"]);  
 $email = $mysqli->escape\_string($\_GET["Email"]);  
 $password = $mysqli->escape\_string($\_GET["Password"]);  
 $fullname = $mysqli->escape\_string($\_GET["FullName"]);  
 $location = $mysqli->escape\_string($\_GET["Location"]);  
 $sql = "SELECT \* FROM tbl\_member";  
 $sql .= " WHERE email = '".$email."'";  
 $sql .= " OR user\_id = '".$user."'";  
 $result = $mysqli->query($sql);  
 $count = $result->num\_rows;  
 if ($count == 0)  
 {  
 $randomnumber = mt\_rand(111111, 999999);  
 $sql = "INSERT INTO tbl\_member";  
 $sql .= " (user\_id, user\_name, pass\_word,";  
 $sql .= " email, location,";  
 $sql .= " reg\_status, reg\_no, online)";  
 $sql .= " VALUES (";  
 $sql .= " '$user', '$fullname', '$password',";  
 $sql .= " '$email', '$location',";  
 $sql .= " 'M', $randomnumber, 'N')";  
 $mysqli->query($sql);  
 $to = $email;  
 $subject = "B4A Register User Demo";  
 $message = "Hi ".$user.","."\r\n";  
 $message .= "Please click on this link to finish";  
 $message .= " the registration process:";  
 $message .= " ".$server."signup.php?Action=Mail";  
 $message .= "&Mail=".$email;  
 $message .= "&RegNo=".$randomnumber;  
 $message = wordwrap($message, 70, "\r\n");  
 $headers = "From: ".$sender."\r\n";  
 $headers .= "Reply-To: ".$sender."\r\n";  
 $headers .= "X-Mailer: PHP/".phpversion();  
  
 mail($to, $subject, $message, $headers);  
 // Notify me of new sign up  
 $to = $admin;  
 $subject = "New member";  
 $message = "New member (".$user.") has signed up using our demo app.";  
 mail($to, $subject, $message, $headers);  
 print json\_encode("Mail");  
 }  
 else  
 print json\_encode("MailInUse");  
 break;  
 case "Mail":  
 if (!isset($\_GET['RegNo']) || empty($\_GET['RegNo']) ||  
 !isset($\_GET['Mail']) || empty($\_GET['Mail']))  
 {  
 print json\_encode("Parameter Error");  
 exit;  
 }   
 $regno = $mysqli->escape\_string($\_GET["RegNo"]);  
 $mail = $mysqli->escape\_string($\_GET["Mail"]);  
 $sql = "SELECT \*";  
 $sql .= " FROM tbl\_member";  
 $sql .= " WHERE email = '$mail'";  
 $sql .= " AND reg\_no = $regno";  
 $sql .= " AND reg\_status = 'M'";  
 $result = $mysqli->query($sql);  
 $count = $result->num\_rows;  
 if ($count == 0)  
 {  
 print json\_encode("This registration is not valid / email address is already registered");  
 }  
 else  
 {  
 $sql = "UPDATE tbl\_member";  
 $sql .= " SET reg\_status = 'R'";  
 $sql .= " WHERE email = '$mail'";  
 $sql .= " AND reg\_no = $regno";  
 $mysqli->query($sql);  
 echo("$mail is registered now :-)");  
 print json\_encode("Success");  
 }  
 break;  
 default:  
 echo("Unauthorized action! Please use the app to register.");  
 }  
 }  
 catch (Exception $e)  
 {  
 print json\_encode("Failed");  
 echo '<br />Caught exception: '.$e->getMessage()."\n";  
 }   
?>[/PHP][/SPOILER]  
  
[SPOILER="signin.php"]  
[PHP]<?php  
 require 'db.php';  
 try  
 {  
 if (!isset($\_GET['user\_id']) || empty($\_GET['user\_id']) ||  
 !isset($\_GET['password']) || empty($\_GET['password']))  
 {  
 print json\_encode("Parameter Error");  
 exit;  
 }   
 $uid = $mysqli->escape\_string($\_GET["user\_id"]);  
 $pwd = $mysqli->escape\_string($\_GET["password"]);  
  
 $sql = "SELECT user\_name, reg\_status";  
 $sql .= " FROM tbl\_member";  
 $sql .= " WHERE user\_id = '".$uid."'";  
 $sql .= " AND pass\_word = '".$pwd."'";  
 $result = $mysqli->query($sql);  
 if ($mysqli->errno)  
 {  
 print json\_encode("Error");  
 echo "<br />".$mysqli->error;  
 exit;  
 }  
 else  
 {  
 if ($result->num\_rows == 0)  
 {  
 print json\_encode("Not Found");  
 exit;  
 }  
 $row = $result->fetch\_row();  
 if ($row[1] == "M")  
 {  
 print json\_encode("Not Activated");  
 }  
 else  
 {  
 print json\_encode($row[0]);  
 $sql = "UPDATE tbl\_member";  
 $sql .= " SET Online = 'N'";  
 $sql .= " WHERE now()-time\_stamp > 60";   
 $mysqli->query($sql);  
 $sql = "UPDATE tbl\_member";  
 $sql .= " SET logins = logins + 1,";  
 $sql .= " Online = 'Y',";  
 $sql .= " time\_stamp = now()";  
 $sql .= " WHERE user\_id = '$uid'";  
 $mysqli->query($sql);  
 }  
 }  
 }  
 catch (Exception $e)  
 {  
 print json\_encode("Failed");  
 echo '<br />Caught exception: '.$e->getMessage()."\n";  
 }  
?>[/PHP][/SPOILER]  
  
[SPOILER="signout.php"]  
[PHP]<?php  
 require 'db.php';  
 try  
 {  
 if(!isset($\_GET['user\_id']) || empty($\_GET['user\_id']))  
 {  
 print json\_encode("Parameter Error");  
 exit;  
 }   
 $uid = $mysqli->escape\_string($\_GET["user\_id"]);  
 $sql = "SELECT online";  
 $sql .= " FROM tbl\_member";  
 $sql .= " WHERE user\_id = '$uid'";  
 $result = $mysqli->query($sql);  
 $count = $result->num\_rows;  
 if ($count == 0)  
 {  
 print json\_encode("NotMember");  
 }  
 else  
 {  
 $sql = "UPDATE tbl\_member";  
 $sql .= " SET online = 'N'";  
 $sql .= " WHERE user\_id = '".$uid."'";  
 $mysqli->query($sql);  
 print json\_encode("LoggedOut");  
 }  
 }  
 catch (Exception $e)  
 {  
 print json\_encode("Failed");  
 echo '<br />Caught exception: '.$e->getMessage()."\n";  
 }  
?>[/PHP]  
[/SPOILER]  
  
[SPOILER="member.php"]  
[PHP]<?php  
 require 'db.php';  
 try  
 {  
 $sql = "SELECT user\_id, location, online";  
 $sql .= " FROM tbl\_member";  
 $sql .= " ORDER BY id DESC";  
 $result = $mysqli->query($sql);  
 if ($mysqli->errno)  
 {  
 header("HTTP/1.1 500 Internal Server Error");  
 echo $sql.'\n';  
 echo $mysqli->error;  
 }  
 else  
 {  
 $rows = array();  
 while ($row = $result->fetch\_assoc())  
 {  
 $rows[] = $row;  
 }  
 print json\_encode($rows);  
 }  
 }  
 catch (Exception $e)  
 {  
 print json\_encode("Failed");  
 echo '<br />Caught exception: '.$e->getMessage()."\n";  
 }  
?>[/PHP][/SPOILER]  
  
[SPOILER="change-password.php"]  
[PHP]<?php  
require 'db.php';  
try  
{  
 if (!isset($\_GET['Email']) || empty($\_GET['Email']) ||  
 !isset($\_GET['Password1']) || empty($\_GET['Password1']) ||  
 !isset($\_GET['Password2']) || empty($\_GET['Password2']))  
 {  
 print json\_encode("Parameter Error");  
 exit;  
 }  
 $email = $mysqli->escape\_string($\_GET["Email"]);  
 $password1 = $mysqli->escape\_string($\_GET["Password1"]);  
 $password2 = $mysqli->escape\_string($\_GET["Password2"]);  
 $sql = "SELECT \* FROM tbl\_member";  
 $sql .= " WHERE email = '".$email."'";  
 $sql .= " AND pass\_word = '".$password1."'";  
 $result = $mysqli->query($sql);  
 $count = $result->num\_rows;  
 if ($count == 0)  
 {   
 print json\_encode("Not Found");  
 echo("<br />User not found or incorrect password");  
 }  
 else  
 {  
 $sql = "UPDATE tbl\_member";  
 $sql .= " SET pass\_word = '".$password2."'";  
 $sql .= " WHERE email = '".$email."'";  
 $sql .= " AND pass\_word = '".$password1."'";  
 $mysqli->query($sql);   
 print json\_encode("Success");  
 echo("<br />$email has been updated");  
 }  
}  
catch (Exception $e)  
{  
 print json\_encode("Failed");  
 echo '<br />Caught exception: '.$e->getMessage()."\n";  
}   
?>[/PHP]  
[/SPOILER]  
  
[SPOILER="reset-password.php"]  
[PHP]<?php  
 require 'db.php';  
 try  
 {  
 if(!isset($\_GET['Action']) || empty($\_GET['Action']))  
 {  
 print json\_encode("Parameter Error");  
 exit;  
 }  
 $action = $mysqli->escape\_string($\_GET["Action"]);  
 switch ($action)  
 {  
 case "RequestPasswordReset":  
 if(!isset($\_GET['Mail']) || empty($\_GET['Mail']))  
 {  
 print json\_encode("Parameter Error");  
 exit;  
 }   
 $email = $mysqli->escape\_string($\_GET["Mail"]);  
 $sql = "SELECT user\_name";  
 $sql .= " FROM tbl\_member";  
 $sql .= " WHERE email = '" . $email . "'";  
 $result = $mysqli->query($sql);  
 if ($mysqli->errno)  
 {  
 print json\_encode("MySQL\_Error");  
 echo "<br />MySQL\_Error: ".$mysqli->error;  
 exit;  
 }  
 $count = $result->num\_rows;  
 if ($count == 0)  
 {  
 print json\_encode("InvalidEmail");  
 exit;  
 }  
 else  
 {  
 // Generate a random code and update to reg\_no  
 $verify\_code = mt\_rand(100000, 999999);  
 $row = $result->fetch\_row();  
 $username = $row[0];  
 $sql = "UPDATE tbl\_member";  
 $sql .= " SET reg\_no = '" . $verify\_code . "'";  
 $sql .= " WHERE email = '" . $email . "'";  
 $mysqli->query($sql);  
 if ($mysqli->errno)  
 {  
 print json\_encode("MySQL\_Error");  
 echo "<br />MySQL\_Error: ".$mysqli->error;  
 exit;  
 }  
 // Send email to user to confirm the reset  
 $to = $email;  
 $subject = 'Request to reset your password';  
 $message = "Hi " . $username . ",\r\n";  
 $message .= "We have received a request from you to reset your password.\r\n";  
 $message .= "If this action is not requested by you,";  
 $message .= " please ignore this email.\r\n";  
 $message .= "Otherwise, click the link below:\r\n";  
 $message .= $server."reset-password.php?Action=ConfirmPasswordReset";  
 $message .= "&Mail=".$email;  
 $message .= "&Code=".$verify\_code . "\r\n\r\n";  
 $message .= "If not working, please copy the link to your browser.\r\n\r\n";  
 $message .= "Regards,\r\n";  
 $message .= "Aeric";  
 $message = wordwrap($message, 70, "\r\n");  
 $headers = "From: ".$sender."\r\n";  
 $headers .= "Reply-To: ".$sender."\r\n";  
 $headers .= "X-Mailer: PHP/" . phpversion();  
 mail($to, $subject, $message, $headers);  
 print json\_encode("ValidEmail");  
 }  
 break;  
 case "ConfirmPasswordReset":  
 if (!isset($\_GET['Mail']) || empty($\_GET['Mail']) ||  
 !isset($\_GET['Code']) || empty($\_GET['Code']))  
 {  
 print json\_encode("Parameter Error");  
 exit;  
 }  
 $email = $mysqli->escape\_string($\_GET["Mail"]);  
 $code = $mysqli->escape\_string($\_GET["Code"]);  
 $sql = "SELECT user\_name";  
 $sql .= " FROM tbl\_member";  
 $sql .= " WHERE email = '" . $email . "'";  
 $sql .= " AND reg\_no = " . $code;  
 $result = $mysqli->query($sql);  
 if ($mysqli->errno)  
 {  
 print json\_encode("MySQL\_Error");  
 echo "<br />MySQL\_Error: ".$mysqli->error;  
 exit;  
 }  
 $count = $result->num\_rows;  
 if ($count == 0)  
 {  
 print json\_encode("InvalidEmailOrCode");  
 exit;  
 }  
 // Generate a default password randomly (e.g. pw1234)  
 // You may use other method to generate a more complex password with alphanumeric  
 $rand\_number = mt\_rand(1000, 9999);  
 $default = "pw" . $rand\_number;  
 $row = $result->fetch\_row();  
 $username = $row[0];  
 $sql = "UPDATE tbl\_member";  
 $sql .= " SET pass\_word = '" . $default . "'";  
 $sql .= " WHERE email = '" . $email . "'";  
 $mysqli->query($sql);  
 if ($mysqli->errno)  
 {  
 print json\_encode("MySQL\_Error");  
 echo "<br />MySQL\_Error: ".$mysqli->error;  
 exit;  
 }  
 $to = $email;  
 $subject = 'Your New Password';  
 $message = "Hi ".$username.",\r\n";  
 $message .= "Your password has been reset.";  
 $message .= " Please use your new password to log in.\r\n";  
 $message .= "Password: " . $default;  
 $message = wordwrap($message, 70, "\r\n");  
 $headers = "From: ".$sender."\r\n";  
 $headers .= "Reply-To: ".$sender."\r\n";  
 $headers .= "X-Mailer: PHP/" . phpversion();  
 mail($to, $subject, $message, $headers);  
 //print json\_encode("PasswordChanged");  
 echo "Your password has been reset.<br />Your new password is sent to $email.";  
 break;  
 default:  
 echo("Unauthorized action! Please use the app to reset your password.");  
 }  
 }  
 catch (Exception $e)  
 {   
 print json\_encode("Failed");  
 echo '<br />Caught exception: '.$e->getMessage()."\n";  
 }  
?>[/PHP]  
[/SPOILER]  
  
**Code also available in Github**  
  
[pyhoon/Register-User-B4A](https://github.com/pyhoon/Register-User-B4A)  
  
[pyhoon/Register-User-PHP](https://github.com/pyhoon/Register-User-PHP)