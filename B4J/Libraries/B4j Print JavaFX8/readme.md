### B4j Print JavaFX8 by stevel05
### 10/19/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/49836/)

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
  
Full code is in Printer.zip if you just want to look at the project without unzipping the B4xlib  
Enjoy