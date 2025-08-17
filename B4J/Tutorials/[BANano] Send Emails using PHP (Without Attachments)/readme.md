### [BANano] Send Emails using PHP (Without Attachments) by Mashiane
### 09/05/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/162924/)

Hi Fam  
  
BANAnoInlinePhp is a functionality in BANano to call PHP functions. You can have PHP embedded in BANano inside **#If PHP** **#End If** tags.  
  
In AppStart, ensure that you configure PHP to work  
  

```B4X
'set php settings  
BANano.PHP_NAME = "appname.php"  
BANano.PHPHost = "http://www.mydomain.com/appname"  
BANano.PHPAddHeader("Access-Control-Allow-Origin: *")
```

  
  
Remember, the PHPHost should match exactly to the path of your PHP parent folder. For public hosting, this is the **actual** webserver address & not localhost.  
  
We will define a couple of functions to send email. To send the email in this case, we will specify ***from, to, cc, subject and message.***  
  

```B4X
'build code to send email  
'to send email via gmail, you need to set less secure apps on https://myaccount.google.com/  
Sub BuildSendEmail(fromEmail As String, toEmail As String, ccEmail As String, subject As String, message As String) As Map  
    message = message.replace(CRLF,"|")  
    Dim Se As Map = CreateMap()  
    Se.put("from", fromEmail)  
    Se.put("to", toEmail)  
    Se.put("cc", ccEmail)  
    Se.put("subject", subject)  
    Se.put("msg", message)  
    Return Se  
End Sub  
  
'send an email  
'to send email via gmail, you need to set less secure apps on https://myaccount.google.com  
'1. Click Security  
'<code>  
''send an email  
'to send email via gmail, you need to set less secure apps on https://myaccount.google.com  
'Dim bOK As Boolean = BANano.Await(SendEmailWait("from@gmail.com", "to@gmail.com", "cc@gmail.com", "Test Email", "Have you received this||…"))  
'</code>  
Sub SendEmailWait(fromEmail As String, toEmail As String, ccEmail As String, subject As String, message As String) As Boolean  
    Dim res As String = BANano.CallInlinePHPWait("SendEmail", BuildSendEmail(fromEmail, toEmail, ccEmail, subject, message))    'ignore  
    Dim result As Map = BANano.FromJson(res)  
    Dim sstatus As String = result.Get("status")  
  c  If sstatus = "success" Then  
        Return True  
    Else  
        Return False  
    End If  
End Sub
```

  
  
Now, we will add PHP script inside our BANano App  
  

```B4X
#if PHP  
function SendEmail($from,$to,$cc,$subject,$msg) {  
    $msg = str_replace("|", "\r\n", $msg);  
    $msg = str_replace("\n.", "\n..", $msg);  
    // use wordwrap() if lines are longer than 70 characters  
    //$msg = wordwrap($msg,70,"\r\n");  
    //define from header  
    $headers = "From:" . $from . "\r\n";  
    $headers .= "Reply-To:" . $from . "\r\n";  
    $headers .= "Cc: " . $cc . "\r\n";  
    $headers .= "X-Mailer:PHP/" . phpversion();  
    $headers .= "MIME-Version: 1.0\r\n";  
    //$headers .= "Content-type: text/html; charset=utf-8\r\n";  
    $headers .= "Content-Type: text/plain; charset=utf-8"."\r\n";  
    $headers .= "Content-Transfer-Encoding: 8bit"."\r\n";  
    // send email  
    $response = (mail($to,$subject,$msg,$headers)) ? "success" : "failure";  
    $output = json_encode(array("response" => $response));  
    header('content-type: application/json; charset=utf-8');  
    die($output);  
    }  
#End If
```

  
  
The php code here will be included in the appname.php file when the project is being compiled.  
  
To send our email, we will just call  
  

```B4X
Dim bOK As Boolean = BANano.Await(SendEmailWait("from@gmail.com", "to@gmail.com", "cc@gmail.com", "Test Email", "Have you received this||…"))
```

  
  
In our app.  
  
Enjoy!  
  
PS:  
  
For more content on how to call php functions inside BANano, check this thread.  
  
<https://www.b4x.com/android/forum/threads/php-the-ultimate-file-management-php-functions.134401/#content>