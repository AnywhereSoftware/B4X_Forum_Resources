### Printing pdf documents by andrewmp
### 10/26/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/135445/)

For all those that need to print complete pdf documents, specifically from a pdf viewer (PDFBoxWrapper)  
  

```B4X
   ' For testing  
    Dim mp As Map=GetPrinters  
       
    For n=0 To mp.Size-1  
       
         Dim s As String = mp.GetKeyAt(n)  
         Dim m As Map=mp.GetValueAt(n)  
       
        If s = "EPSON WF-2650 Series" Then ' print to arbitrary printer in list to test  
            Dim obj As Object=m.GetValueAt(0) ' print using tray at index 0  
            PrintPDFDocument("c:\temp\All_D.pdf",s,obj,2) ' "EPSON WF-2650 Series" , "PDFCreator"  
        End If  
       
    Next  
  
Public Sub PrintPDFDocument(pdffile As String,printername As String,mtray As Object,copies as Int) As Boolean  
    Dim r As Boolean=False  
    If File.Exists("",pdffile) Then  
        r=asJO(Me).RunMethod("PrintPDFDoc",Array As Object(pdffile,printername,mtray,copies))  
    End If  
    Return r  
End Sub  
  
Public Sub GetPrinters() As Map  
   
    Dim m As Map  
    m.Initialize  
    m=asJO(Me).RunMethod("getPrinterList", Array As String())  
    Return m  
     
End Sub  
   
Sub asJO(o As JavaObject) As JavaObject  
    Return o  
End Sub  
  
#if java  
  
import java.lang.reflect.*;  
   
import java.awt.print.PrinterJob;  
import java.io.File;  
  
import javax.print.*;  
import javax.print.attribute.AttributeSet;  
import javax.print.attribute.HashAttributeSet;  
import javax.print.attribute.HashPrintRequestAttributeSet;  
import javax.print.attribute.PrintRequestAttributeSet;  
import javax.print.attribute.standard.Media;  
import javax.print.attribute.standard.MediaTray;  
import javax.print.attribute.standard.PrinterName;  
import javax.print.attribute.standard.Copies;  
import java.awt.*;  
import java.awt.print.PageFormat;  
import java.awt.print.Printable;  
  
import org.apache.pdfbox.pdmodel.PDDocument;  
import org.apache.pdfbox.printing.PDFPageable;  
  
import java.io.Console;  
//import java.util.HashMap;  
//import java.util.Map;  
import anywheresoftware.b4a.*;  
import anywheresoftware.b4a.objects.collections.Map;  
   
public static Boolean PrintPDFDoc(String docpath,String printername,MediaTray Tray,Integer copies)  throws Exception {  
   
    Boolean result=false;  
   
    PDDocument document = new PDDocument();  
   
    try  
    {  
         
        document = PDDocument.load(new File(docpath));  
         
        PrintService myPrintService = findPrintService(printername);  
         
        if (myPrintService != null) {  
         
            PrintRequestAttributeSet pset = new HashPrintRequestAttributeSet();  
          
            PrinterJob job = PrinterJob.getPrinterJob();  
             
            if (Tray!=null)  {  
                 MediaTray selectedTray = (MediaTray) Tray;  
            
                pset.add(selectedTray);  
             }  
              
            if (copies>0)  {  
                 pset.add(new Copies(copies));  
            } else {  
                 pset.add(new Copies(1));  
            }  
  
            job.setPageable(new PDFPageable(document));  
            job.setPrintService(myPrintService);  
            job.print(pset);              
            result=true;  
        }  
        document.close();  
         
    } catch (Exception e) {  
        e.printStackTrace();  
          
    }  
   
    return result;  
  
}      
  
private static PrintService findPrintService(String printerName) {  
    PrintService[] printServices = PrintServiceLookup.lookupPrintServices(null, null);  
    for (PrintService printService : printServices) {  
        if (printService.getName().trim().equals(printerName)) {              
            return printService;          
        }  
    }  
    return null;  
}  
  
   
public static Object getPrinterList() throws Exception  
{  
    Map mpPrt = new Map();  
    mpPrt.Initialize();  
    PrintService[] printServices = PrintServiceLookup.lookupPrintServices(null, null);  
    for (PrintService printService : printServices) {  
       
        Map mp = new Map();  
        mp.Initialize();  
       
        DocFlavor flavor = DocFlavor.SERVICE_FORMATTED.PRINTABLE;  
       
        Object o = printService.getSupportedAttributeValues(Media.class, flavor, null);  
   
        if (o != null && o.getClass().isArray()) {  
            for (Media media : (Media[]) o) {  
                //System.out.println(MediaTray);  
                if (media instanceof MediaTray) {  
                   // System.out.println(media.getValue() + " : " + media;  
                   mp.Put(media.getValue(), media);  
                }  
            };  
        }  
        String pn = printService.getName().trim();  
        mpPrt.Put(pn,mp.getObject());  
    }  
   
    return mpPrt.getObject() ;  
  
}  
#End If
```

  
  
There is probably a way to print using the javafx.print I got fed up trying to figure out the methods in the library, let me know if is possible…