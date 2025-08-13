### Dynamic plain HTML form web-page by peacemaker
### 08/31/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/142644/)

If you start building your first [Server web app](https://www.b4x.com/android/forum/threads/server-building-web-servers-with-b4j.37172) - this is the simplest example of the dynamically generated web-page with just a plain HTML form code, without any JavaScript, CSS… Just a bare functional.  
It helps to pass your settings into the web-app and show back some info from the app.  
Only code of the app handler (**class module "grabber\_settings" -** note it's referenced in the HTML-form code) is shown where all is done - receiving form fields and reply to the user (to web-browser) by HTML-code.  
The generated web-page is self-refreshed each 10 seconds to update the status on the screen.  
Some links are to the variables in Main app module, ignore them (it's for main app function: [grabber of RTSP video stream](https://www.b4x.com/android/forum/threads/how-to-grab-rtsp-in-console-b4j-app-under-linux.142409/) to .jpg-frames).  
  

```B4X
'Class module  
Sub Class_Globals  
End Sub  
  
Public Sub Initialize  
  
End Sub  
  
Sub Handle(req As ServletRequest, resp As ServletResponse)  
    Try  
        Dim Params As Map = req.ParameterMap  
'        Log(CRLF & "————" & CRLF & "Method: " & req.Method)  
'        Log("ContentType: " & req.ContentType)  
'        Log(req.GetSession.GetAttributesNames)  
'        Log(Params)  
   
        Dim form_result, ResponseText As StringBuilder  
        form_result.Initialize  
        ResponseText.Initialize  
   
        Dim new_url As String = req.GetParameter("RTSP_URL")  
        If new_url <> "" Then  
            If new_url <> Main.RTSP_URL Then  
                Main.Grabbing = False  
                Main.RTSP_URL = new_url  
                Main.Save_Settings  
                form_result.Append("New URL is saved.").Append(CRLF)  
            Else  
                form_result.Append("URL was not changed.").Append(CRLF)  
            End If  
        End If  
   
        Dim new_url As String = req.GetParameter("frames_path")  
        If new_url <> "" Then  
            If new_url <> Main.Frames_Path Then  
                If File.Exists(new_url, "") Then  
                    Main.Frames_Path = new_url  
                    Main.Save_Settings  
                    form_result.Append("New path is saved.").Append(CRLF)  
                Else  
                    form_result.Append("New path was WRONG: non-existent, ignored.").Append(CRLF)  
                End If  
            Else  
                form_result.Append("Path was not changed.").Append(CRLF)  
            End If  
        End If  
   
        If Params.ContainsKey("btnStart") Then  
            Main.LastGrabbingError = ""  
            Main.LastOutputFile = ""  
            Main.Grabbing = True  
            Main.Save_Settings  
            form_result.Append("Service is started.").Append(CRLF)  
        End If  
        If Params.ContainsKey("btnStop") Then  
            Main.Grabbing = False  
            Main.Save_Settings  
            form_result.Append("Service is stopped.").Append(CRLF)  
        End If  
   
        ResponseText.Append($"<html><body><meta http-equiv="refresh" content="10">"$)    'auto-refresh web-page  
        ResponseText.Append("Server v." & Main.ver & " time: " & DateTime.Time(DateTime.Now))  
        ResponseText.Append("<form method='POST' action='grabber_settings'>")  
   
        Dim rtsp_form As String = $"Source IP-camera RTSP address: <input type="text" name="RTSP_URL" size="35" value="$ & Main.RTSP_URL & "></input>"  
        rtsp_form = rtsp_form & $"<button type="Submit">Save URL</button>"$  
        ResponseText.Append(rtsp_form)  
   
        Dim rtsp_form As String = $"Grabbed frames path: <input type="text" name="frames_path" size="65" value="$ & Main.Frames_Path & "></input>"  
        rtsp_form = rtsp_form & $"<button type="Submit">Save path</button>"$  
        ResponseText.Append("<br>").Append(rtsp_form)  
   
        ResponseText.Append("<br>").Append("Grabbing service: " & (IIf(Main.Grabbing, $"<button type="Submit" name="btnStop">STOP</button>"$, _  
        $"<button type="Submit" name="btnStart">START !</button>"$)))  
        ResponseText.Append("</form>")  
        If form_result.Length > 0 Then  
            ResponseText.Append("<br>").Append(form_result.ToString)      
        End If  
       If Main.LastOutputFile <> "" Then  
            Dim path As String = File.GetFileParent(Main.LastOutputFile)  
            Dim FileExt As String = Main.LastOutputFile.SubString2(Main.LastOutputFile.Length - 4, Main.LastOutputFile.Length)  
            Dim Files As List = File.ListFiles(path)  
            Dim counter As Long  
            For i = 0 To Files.Size - 1  
                Dim fn As String = Files.Get(i)  
                If fn.EndsWith(FileExt) Then  
                    counter = counter + 1  
                End If  
            Next  
   
            ResponseText.Append("<br>").Append("LastOutputFile: " & Main.LastOutputFile & "<br>" & FileExt & "-frames totally grabbed = " & counter)  
        End If  
        If Main.LastGrabbingError <> "" Then  
            ResponseText.Append("<br>").Append("LastGrabbingError: " & Main.LastGrabbingError)  
        End If  
   
        ResponseText.Append("</body></html>")  
   
        resp.Write(ResponseText.ToString)   'pass the reply HTML text to user's browser  
    Catch  
        resp.SendError(500, "Server internal error")  
    End Try  
    Log(form_result)  
End Sub
```

  
  

1. Saving the parameters from fields
![](https://www.b4x.com/android/forum/attachments/133182)2. Error reporting
![](https://www.b4x.com/android/forum/attachments/133184)
Runtime errors reporting:
![](https://www.b4x.com/android/forum/attachments/133181)3. Working and reporting about the status
![](https://www.b4x.com/android/forum/attachments/133183)
NOTE: Sign "!" in any file path is forbidden, do not use it, it's a special symbol for Java programs.