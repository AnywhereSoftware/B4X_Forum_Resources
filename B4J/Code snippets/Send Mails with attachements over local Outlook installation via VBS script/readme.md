### Send Mails with attachements over local Outlook installation via VBS script by KMatle
### 02/10/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/127501/)

I use this script to send over 1500 Mails with invoices. Outlook starts in the background or foreground if it is started. You need an installed Outlook application.  
  
  

```B4X
Const olByValue = 1  
Const olMailItem = 0  
      
Dim oOApp  
Dim oOMail  
  
Set oOApp = CreateObject("Outlook.Application")  
Set oOMail = oOApp.CreateItem(olMailItem)  
  
With oOMail  
    .To = "customer@someserver.com"  
    .SentOnBehalfOfName = "myemailaddress@mycompany.com"  
    .Subject = "Subject"  
    .Body = "The mailbody"  
    '.Attachments.Add "C:\somefile.txt", olByValue, 1  
    '.Send -> send direct, .Save = Draft  
    .DeferredDeliveryTime = Date & " 22:00:00" 'delay if needed  
    .send  
End With
```

  
  
With the help of the TextWriter object (to create Windows files with the correct codepage) I create the script at runtime. The scriptfile contains a "header" with the definitions to get access to Outlook, and the send parameters for each mail with the file path to the attachment. At the end I start it via jShell.  
  
Please use Google to check more options (search for vbs & Outlook & send mails). Quite easy.   
  

```B4X
Dim Writer As TextWriter  
            Writer.Initialize2(File.OpenOutput(File.DirApp & "/SENDMAILVBS","sendmails.vbs", False),"cp1252")  
            Dim vbsscript As String  
              
              
            vbsscript=$"outFile="${File.DirApp}/SENDMAILVBS/${BatchName}.log""$ & CRLF  
            Writer.WriteLine(vbsscript)  
            vbsscript=$"Set FSO = CreateObject("Scripting.FileSystemObject")"$  
            Writer.WriteLine(vbsscript)  
            vbsscript="Set objFile = FSO.CreateTextFile(outFile,True)" & CRLF &CRLF  
            Writer.WriteLine(vbsscript)  
              
            vbsscript ="Const olByValue = 1" & CRLF & "Const olMailItem = 0" & CRLF & "Dim oOApp" & CRLF & "Dim oOMail" & CRLF & $"Set oOApp = CreateObject("Outlook.Application")"$ & CRLF  
            Writer.WriteLine(vbsscript)
```

  
  
for each mail  
  

```B4X
vbsscript= CRLF & "Set oOMail = oOApp.CreateItem(olMailItem)" & CRLF  
                        vbsscript=vbsscript& "With oOMail" & CRLF  
                        vbsscript=vbsscript& $" .To = "${Email}""$ &CRLF  
                        vbsscript=vbsscript& $".SentOnBehalfOfName = "xxxxx""$ & CRLF  
                        vbsscript=vbsscript& $".Subject = "The subject" & CRLF  
                          
                        MBody = $"Dear Mr. Smith, " & vbCrLf & vbCrLf & _  
                        "Line 2 " & vbCrLf & vbCrLf & _  
                        "Line 3" & vbCrLf & _  
                          
                        vbsscript=vbsscript& $".Body = "${MBody} "$ & CRLF  
                        vbsscript=vbsscript& $".Attachments.Add "${PDFFilePath&PDFFilename}" "$ & CRLF  
                        vbsscript=vbsscript& $".DeferredDeliveryTime = Date & " ${MailTimeSP.Value}:00:00""$ & CRLF  
                        vbsscript=vbsscript& $".Send()"$ & CRLF  
                        vbsscript=vbsscript& $"End With"$ & CRLF  
                        Writer.WriteLine(vbsscript)
```