### b4j Get Battery Info by jkhazraji
### 02/07/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/170235/)

Using jShell library we can get the laptop battery information as name, serial number, manufacturer, design and current capacity as well as charge remaining (taken from:<https://www.b4x.com/android/forum/threads/execute-windows-vbs-scripts-from-b4j.73612/#content>)  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
    Private ChargeRemaining As Int  
   
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    'MainForm.Show  
    Dim shl As Shell  
    shl.Initialize("shl", "powercfg", _  
     Array As String("/batteryreport"))  
    shl.WorkingDirectory = "."  
    shl.Run(10000) 'set a timeout of 10 seconds  
  
End Sub  
  
Sub shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    If Success And ExitCode = 0 Then  
        Log("Success")  
        Log("Full output: " & StdOut)  
       
        ' Find the HTML file path in the output  
        Dim htmlFilePath As String = ExtractHtmlFilePath(StdOut)  
       
        If htmlFilePath <> "" Then  
            ' Clean the path (remove trailing period if present)  
            If htmlFilePath.EndsWith(".") Then  
                htmlFilePath = htmlFilePath.SubString2(0, htmlFilePath.Length - 1)  
            End If  
           
            Log("HTML file path: " & htmlFilePath)  
           
            ' Check if file exists  
            If File.Exists(htmlFilePath, "") Then  
                ' Read the HTML file content  
                Dim html As String = File.ReadString(htmlFilePath, "")  
                ParseBatteryData(html)  
            Else  
                ' Try alternative approach - search for battery-report.html in the Objects folder  
                htmlFilePath = FindBatteryReportFile  
                If htmlFilePath <> "" Then  
                    Dim html As String = File.ReadString(htmlFilePath, "")  
                    ParseBatteryData(html)  
                Else  
                    Log("Could not find battery-report.html file")  
                    xui.MsgboxAsync("Could not find battery report file", "Error")  
                End If  
            End If  
        Else  
            Log("Could not extract HTML file path from output")  
            ' Try to generate the report to a specific location  
            GenerateBatteryReportToSpecificLocation  
        End If  
    Else  
        Log("Error: " & StdErr)  
        xui.MsgboxAsync("Failed to generate battery report: " & StdErr, "Error")  
    End If  
    'ExitApplication ' Optional - remove if you want app to continue  
End Sub  
  
Sub ExtractHtmlFilePath(output As String) As String  
    ' Look for .html extension in the output  
    Dim pattern As String = "(C:\\.*?\.html)"  
    Dim matcher As Matcher = Regex.Matcher(pattern, output)  
    If matcher.Find Then  
        Return matcher.Group(1)  
    End If  
   
    ' Alternative pattern for paths with spaces or special characters  
    Dim pattern2 As String = "(\w:.*?\.html)"  
    Dim matcher2 As Matcher = Regex.Matcher(pattern2, output)  
    If matcher2.Find Then  
        Return matcher2.Group(1)  
    End If  
   
    Return ""  
End Sub  
  
Sub FindBatteryReportFile As String  
    ' Try to find the battery report file in common locations  
    Dim possiblePaths As List  
    possiblePaths.Initialize  
   
    ' Add current directory  
    possiblePaths.Add(File.DirApp & "\battery-report.html")  
   
    ' Try Objects folder (common in B4J projects)  
    possiblePaths.Add(File.DirApp & "\Objects\battery-report.html")  
   
    ' Try user's documents folder  
    Dim j As JavaObject  
    j.InitializeStatic("java.lang.System")  
    Dim userHome As String = j.RunMethod("getProperty", Array As Object("user.home"))  
    possiblePaths.Add(userHome & "\battery-report.html")  
   
    For Each path As String In possiblePaths  
        If File.Exists(path, "") Then  
            Return path  
        End If  
    Next  
   
    Return ""  
End Sub  
  
Sub GenerateBatteryReportToSpecificLocation  
    ' Generate battery report to a known location  
    Dim knownPath As String = File.DirApp & "\battery-report.html"  
    Dim shl2 As Shell  
    shl2.Initialize("shl2", "powercfg", Array As String("/batteryreport", "/output", knownPath))  
    shl2.WorkingDirectory = "."  
    shl2.Run(10000)  
    Wait For shl2_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    If Success And ExitCode = 0 Then  
        If File.Exists(knownPath, "") Then  
            Dim html As String = File.ReadString(knownPath, "")  
            ParseBatteryData(html)  
        Else  
            xui.MsgboxAsync("Failed to generate battery report to known location", "Error")  
        End If  
    Else  
        xui.MsgboxAsync("Failed to generate battery report: " & StdErr, "Error")  
    End If  
End Sub  
  
Sub ParseBatteryData(html As String)  
    Try  
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''  
       
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''  
        ' Parse for DESIGN CAPACITY - multiple possible patterns  
        Dim designCapacity As String = ""  
        Dim patterns As List  
        patterns.Initialize  
       
        ' Try different possible patterns  
        patterns.Add("DESIGN CAPACITY</span></td><td>(\d+,\d+)\s*mWh")  
        patterns.Add("DESIGN CAPACITY[^>]*>(\d+,\d+)\s*mWh")  
        patterns.Add("DESIGN CAPACITY.*?<td[^>]*>(\d+,\d+)")  
        patterns.Add(">DESIGN CAPACITY<.*?<td[^>]*>(\d+,\d+)")  
       
        For Each pattern As String In patterns  
            Dim matcher As Matcher = Regex.Matcher(pattern, html)  
            If matcher.Find Then  
                designCapacity = matcher.Group(1)  
                Exit  
            End If  
        Next  
       
        ' Parse for FULL CHARGE CAPACITY  
        Dim fullChargeCapacity As String = ""  
        Dim patterns2 As List  
        patterns2.Initialize  
       
        patterns2.Add("FULL CHARGE CAPACITY</span></td><td>(\d+,\d+)\s*mWh")  
        patterns2.Add("FULL CHARGE CAPACITY[^>]*>(\d+,\d+)\s*mWh")  
        patterns2.Add("FULL CHARGE CAPACITY.*?<td[^>]*>(\d+,\d+)")  
        patterns2.Add(">FULL CHARGE CAPACITY<.*?<td[^>]*>(\d+,\d+)")  
       
        For Each pattern As String In patterns2  
            Dim matcher As Matcher = Regex.Matcher(pattern, html)  
            If matcher.Find Then  
                fullChargeCapacity = matcher.Group(1)  
                Exit  
            End If  
        Next  
       
        If designCapacity <> "" And fullChargeCapacity <> "" Then  
            ' Remove commas for calculation  
            Dim designClean As String = designCapacity.Replace(",", "")  
            Dim fullChargeClean As String = fullChargeCapacity.Replace(",", "")  
           
            ' Convert to numbers  
            Dim designVal As Int = designClean  
            Dim fullChargeVal As Int = fullChargeClean  
           
            ' Calculate battery health percentage  
            Dim health As Double = (fullChargeVal / designVal) * 100  
           
            ' Display results  
            Log("Design Capacity: " & designCapacity & " mWh")  
            Log("Full Charge Capacity: " & fullChargeCapacity & " mWh")  
            Log("Battery Health: " & NumberFormat(health, 1, 2) & "%")  
            Log("Battery Manufacturer: " & ParseBatteryManufacturer(html))  
            Log("Serial  Number:" & ParseBatterySerialNumber(html))  
            Log("Chemistry:" & ParseBatteryChemistry(html) )  
           
           
            ' Show in a message box  
            xui.MsgboxAsync("Battery Status:" & CRLF & CRLF & _  
                "✓ Design Capacity: " & designCapacity & " mWh" & CRLF & _  
                "✓ Full Charge Capacity: " & fullChargeCapacity & " mWh" & CRLF & CRLF & _  
                "🔋 Battery Health: " & NumberFormat(health, 1, 2) & "%"  & CRLF & CRLF & _  
                "Battery Name: " & ParseBatteryName(html)  & CRLF & CRLF & _  
                "Battery Manufacturer: " & ParseBatteryManufacturer(html) & CRLF & CRLF & _  
                "Serial number: " & ParseBatterySerialNumber(html)  & CRLF & CRLF & _  
                "Chemistry: " & ParseBatteryChemistry(html) , "Battery Report")  
            BatteryChargeRemain  
        Else  
            Log("Could not find battery capacity data in HTML")  
            Log("HTML snippet search:")  
            ' Try a more aggressive search  
            FindCapacityValues(html)  
        End If  
    Catch  
        Log("Error parsing HTML: " & LastException)  
        xui.MsgboxAsync("Error parsing battery data", "Error")  
    End Try  
End Sub  
  
Sub FindCapacityValues(html As String)  
    ' Alternative: Look for any numbers that look like capacities (typically in thousands)  
    Dim pattern As String = "(\d{1,3}(?:,\d{3})+)\s*mWh"  
    Dim matcher As Matcher = Regex.Matcher(pattern, html)  
    Dim matches As List  
    matches.Initialize  
   
    Do While matcher.Find  
        matches.Add(matcher.Group(1))  
    Loop  
   
    If matches.Size >= 2 Then  
        ' Assume first two large numbers are the capacities  
        Dim designCapacity As String = matches.Get(0)  
        Dim fullChargeCapacity As String = matches.Get(1)  
       
        ' Remove commas for calculation  
        Dim designClean As String = designCapacity.Replace(",", "")  
        Dim fullChargeClean As String = fullChargeCapacity.Replace(",", "")  
       
        Dim designVal As Int = designClean  
        Dim fullChargeVal As Int = fullChargeClean  
        Dim health As Double = (fullChargeVal / designVal) * 100  
       
        xui.MsgboxAsync("Battery Status (auto-detected):" & CRLF & CRLF & _  
            "Design Capacity: ~" & designCapacity & " mWh" & CRLF & _  
            "Full Charge Capacity: ~" & fullChargeCapacity & " mWh" & CRLF & CRLF & _  
            "Battery Health: ~" & NumberFormat(health, 1, 2) & "%", _  
            "Battery Report (Estimated)")  
    Else  
        ' Last resort: Save HTML to file for debugging  
        File.WriteString(File.DirApp, "debug_battery.html", html)  
        Log("Could not parse data. HTML saved to: " & File.DirApp & "\debug_battery.html")  
        xui.MsgboxAsync("Could not parse battery data. Debug file created.", "Error")  
    End If  
End Sub  
Sub ParseBatteryName(html As String) As String  
    Dim namePatterns As List = Array As String($"NAME</span></td><td>([^<]+)"$, "Battery name.*?<td[^>]*>([^<]+)",">Name<.*?<td[^>]*>([^<]+)","Battery Name.*?:.*?<td>([^<]+)","<td>NAME</td>.*?<td>([^<]+)</td>",$"\"name\"[^>]*>([^<]+)"$)  
   
    For Each pattern As String In namePatterns  
        Dim matcher As Matcher = Regex.Matcher(pattern, html)  
        If matcher.Find Then  
            Dim name As String = matcher.Group(1).Trim  
            If name.Length > 0 Then  
                Return name  
            End If  
        End If  
    Next  
   
    Return "Unknown"  
End Sub  
  
Sub ParseBatteryManufacturer(html As String) As String  
    Dim manufacturerPatterns As List = Array As String("MANUFACTURER</span></td><td>([^<]+)","Manufacturer.*?<td[^>]*>([^<]+)",">Manufacturer<.*?<td[^>]*>([^<]+)","Battery manufacturer.*?:.*?<td>([^<]+)","<td>MANUFACTURER</td>.*?<td>([^<]+)</td>",$"\"manufacturer\"[^>]*>([^<]+)"$,"Mfg.*?:.*?<td>([^<]+)")  
   
    For Each pattern As String In manufacturerPatterns  
        Dim matcher As Matcher = Regex.Matcher(pattern, html)  
        If matcher.Find Then  
            Dim manufacturer As String = matcher.Group(1).Trim  
            If manufacturer.Length > 0 Then  
                Return manufacturer  
            End If  
        End If  
    Next  
   
    Return "Unknown"  
End Sub  
Sub ParseBatterySerialNumber(html As String) As String  
    Dim serialPatterns As List = Array As String("SERIAL NUMBER</span></td><td>([^<]+)","Serial.*?number.*?<td[^>]*>([^<]+)",">Serial number<.*?<td[^>]*>([^<]+)","Battery serial.*?:.*?<td>([^<]+)","<td>SERIAL NUMBER</td>.*?<td>([^<]+)</td>",$"\"serial.*?\"[^>]*>([^<]+)"$,$"SN.*?:.*?<td>([^<]+)"$,$"Serial.*?:.*?<td>([^<]+)"$)  
   
    For Each pattern As String In serialPatterns  
        Dim matcher As Matcher = Regex.Matcher(pattern, html)  
        If matcher.Find Then  
            Dim serial As String = matcher.Group(1).Trim  
            If serial.Length > 0 Then  
                Return serial  
            End If  
        End If  
    Next  
   
    Return "Unknown"  
End Sub  
  
Sub ParseBatteryChemistry(html As String) As String  
    Dim chemistryPatterns As List = Array As String("CHEMISTRY</span></td><td>([^<]+)","Chemistry.*?<td[^>]*>([^<]+)",">Chemistry<.*?<td[^>]*>([^<]+)","Battery chemistry.*?:.*?<td>([^<]+)","<td>CHEMISTRY</td>.*?<td>([^<]+)</td>",$"\"chemistry\"[^>]*>([^<]+)"$,"Battery type.*?:.*?<td>([^<]+)")  
   
    For Each pattern As String In chemistryPatterns  
        Dim matcher As Matcher = Regex.Matcher(pattern, html)  
        If matcher.Find Then  
            Dim chemistry As String = matcher.Group(1).Trim  
            If chemistry.Length > 0 Then  
                Return chemistry  
            End If  
        End If  
    Next  
   
    Return "Unknown"  
End Sub  
Sub ExtractAdditionalBatteryInfo(html As String) As String  
    Try  
        Dim info As String  
        ' Extract battery cycles if available  
        Dim cyclePattern As String = "CYCLE COUNT</span></td><td>(\d+)"  
        Dim cycleMatcher As Matcher = Regex.Matcher(cyclePattern, html)  
        If cycleMatcher.Find Then  
            info= info & "Cycle Count: " & cycleMatcher.Group(1) & CRLF  
        End If  
       
        ' Extract manufacture date if available  
        Dim datePattern As String = "MANUFACTURE DATE</span></td><td>([^<]+)"  
        Dim dateMatcher As Matcher = Regex.Matcher(datePattern, html)  
        If dateMatcher.Find Then  
            info= info & "Manufacture Date: " & dateMatcher.Group(1) & CRLF  
        End If  
    Catch  
        Log(LastException.Message)  
        ' Ignore errors in additional info extraction  
    End Try  
    Return info  
End Sub  
  
Sub BatteryChargeRemain  
    Log("Reading battery status…")  
    Dim BatterySh As Shell  
    BatterySh.Initialize("Battery", "c:\windows\system32\cscript.exe", Array As String("//nologo", "battery.vbs"))  
    BatterySh.WorkingDirectory = "WinBattery\"  
    BatterySh.Run(10000)  
   
End Sub  
  
Sub Battery_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    If Success And ExitCode = 0 Then  
        If IsNumber(StdOut) Then  
            ChargeRemaining= StdOut  
            Log ("Charge remainig: " & ChargeRemaining)  
            xui.MsgboxAsync(ChargeRemaining, "Charge Remaining")  
        Else  
            Log("Oops… Battery not found…")  
        End If  
   
    Else  
        Log("Error: " & StdErr & StdOut)  
   
    End If  
   
End Sub
```

  
Example output:  
  
  
  
![](https://www.b4x.com/android/forum/attachments/169732)