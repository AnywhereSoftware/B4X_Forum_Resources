### B4j Print JavaFX8 + 17 by stevel05
### 08/10/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/49836/)

Here is a B4j library written in B4j to access the full Printer modules provided with JavaFX8. Full source code is available.  
  
At it's simplest, you can print a node using:  

```B4X
    Dim P As Printer = Printer_Static.GetDefaultPrinter  
    Dim PJ As PrinterJob = PrinterJob_Static.CreatePrinterJob2(P)  
    PJ.PrintPage(lblTest)  
    PJ.EndJob
```

  
  
Or with dialogs:  
  

```B4X
    Dim PJ As PrinterJob = PrinterJob_Static.CreatePrinterJob  
    PJ.ShowPageSetupDialog(Null)  
    PJ.ShowPrintDialog(Null)  
    PJ.PrintPage(MainForm.RootPane)  
    PJ.EndJob
```

  
  
Code to scale a view to print on a single page.  

```B4X
Sub ScaleOutput(P As Printer,N As Node) As Node  
    Dim PL As PageLayout = P.GetDefaultPageLayout  
    Dim ScaleX,ScaleY As Double  
    Dim NJO As JavaObject = N  
    Dim JO As JavaObject = N  
    ScaleX = PL.GetPrintableWidth / JO.RunMethodJO("getBoundsInParent",Null).RunMethod("getWidth",Null)  
    ScaleY = PL.GetPrintableHeight / JO.RunMethodJO("getBoundsInParent",Null).RunMethod("getHeight",Null)  
    Dim SJO As JavaObject  
    SJO.InitializeNewInstance("javafx.scene.transform.Scale",Array(ScaleX,ScaleY))  
    NJO.RunMethodJO("getTransforms",Null).RunMethod("add",Array(SJO))  
    Return NJO  
End Sub
```

  
  

```B4X
    'Print with dialogs  
    Dim PJ As PrinterJob = PrinterJob_Static.CreatePrinterJob  
    If PJ.ShowPageSetupDialog(Null) Then  
        If PJ.ShowPrintDialog(Null) Then  
'            PJ.PrintPage(MainForm.RootPane)  
            PJ.PrintPage(ScaleOutput(PJ.GetPrinter,MainForm.RootPane))  
            PJ.EndJob  
        Else  
            PJ.CancelJob  
        End If  
    Else  
        PJ.CancelJob  
    End If  
  
    'Removes transforms added by ScaleOutput  
    MainForm.RootPane.As(JavaObject).Runmethod("getTransforms",Null).as(List).Clear
```

  
  

```B4X
'where N would be MainForm.Rootpane in the above example  
N.As(JavaObject).Runmethod("getTransforms",Null).as(List).Clear
```

  
  
Depends on: JavaFX8, JavaObject  
  
Documentation (apart from that in the library) is available here: <http://docs.oracle.com/javase/8/javafx/api/index.html?javafx/print/Printer.html>  
Click on javafx.print in the All Classes Packages frame to see all the relevant classes.  
  
I've ignored Enums where strings are acceptable for simplicity's sake.  
  
V0.6 fix improperly formed XMLmessage displayed in IDE help (post #6)  
V0.7 added #RaisesSynchronousEvents to PrinterJob module as described here : <https://www.b4x.com/android/forum/threads/b4j-b4xpages-trouble-getting-jfx8print-dialogs-to-work.133964/>  
V 0.8 Released as a B4xLib Enums now return string values instead of ENum objects.  
V0.9  

- Added JobSettings.SetOutputPath (Javafx 17+)
- GetPrinterByName to Printer\_Static
- SearchPrinters to Printer\_Static
- Added MaintainAspectRatio to the ScaleOutput example method

  
  
Full code is in Printer.zip if you just want to look at the project without unzipping the B4xlib  
Enjoy  
  
**Update V0.9  
  
JavaFX17** adds SetOutputFile to JobSettings, which means you can now print to PDF without dialogs while setting the target filepath. Something like this:  
  

```B4X
    Dim P As Printer = Printer_Static.GetPrinterByName("Microsoft Print to PDF")  
    If Initialized(P) Then  
        Dim PJ As PrinterJob = PrinterJob_Static.CreatePrinterJob2(P)  
        PJ.GetJobSettings.SetOutputFile("D:\Test.pdf")  
        PJ.PrintPage(ScaleOutput(P,MainForm.RootPane, True))  
        PJ.PrintPage(lblTest)  
        PJ.EndJob  
    Else  
        Log("Printer Not found")  
    End If  
  
    'Removes transforms added by ScaleOutput  
    MainForm.RootPane.As(JavaObject).Runmethod("getTransforms",Null).as(List).Clear
```

  
  
This is intended to work with print drivers that allow redirecting the print to a file. Tested with Microsoft Print to PDF driver.  
  
You will get an entry in the Logs if you try to use this with JavaFX < 17.  
  
For convenience I have added Printer\_Static.GetPrinterByName method as in the example code, and a Printer\_Static.SearchPrinters("PDF"). See [post #142](https://www.b4x.com/android/forum/threads/b4j-print-javafx8-17.49836/post-1030618) for an example.  
  
Also added MaintainAspectRatio to the ScaleOutput Method:  
  

```B4X
Sub ScaleOutput(P As Printer, N As Node, MaintainAspectRatio As Boolean) As Node  
    Dim PL As PageLayout = P.GetDefaultPageLayout  
    Dim ScaleX,ScaleY As Double  
    Dim NJO As JavaObject = N  
    Dim JO As JavaObject = N  
    ScaleX = PL.GetPrintableWidth / JO.RunMethodJO("getBoundsInParent",Null).RunMethod("getWidth",Null)  
    ScaleY = PL.GetPrintableHeight / JO.RunMethodJO("getBoundsInParent",Null).RunMethod("getHeight",Null)  
    If MaintainAspectRatio Then  
        ScaleX = Min(ScaleX, ScaleY)  
        ScaleY = ScaleX  
    End If  
    Dim SJO As JavaObject  
    SJO.InitializeNewInstance("javafx.scene.transform.Scale",Array(ScaleX,ScaleY))  
    NJO.RunMethodJO("getTransforms",Null).RunMethod("add",Array(SJO))  
    Return NJO  
End Sub
```