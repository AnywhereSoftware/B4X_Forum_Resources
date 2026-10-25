### Simple Native Printer Library by Peter Simpson
### 10/24/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/172360/)

Hello everyone,  
Here is a really simple library for printing your layouts or images with ease in B4J. This library is a slightly expanded version of the print routine Inline Java code used in the B4X 3D Charts library.  
  
This NativePrinter library uses the native JavaFX Printing API (javafx.print) to interact with the operating system's print spooler. Specifically, it relies on the javafx.print.PrinterJob class. When you call the print method, the library creates a PrinterJob. This library basically a mini version version of Steve's B4J Print JavaFX8 library which I've been using for years, I highly recommend using that library to print.  
  
With this library, you can set and print to the following paper sizes: A0, A1, A2, A3, A4, A5, A6, LEGAL, LETTER, NA\_LETTER, TABLOID, and JAPANESE\_POSTCARD. Alternatively, you can create your own custom paper sizes for labels, etc. I've attached a PDF file generated using the provided code example.  
  
**B4J library tab**  
![](https://www.b4x.com/android/forum/attachments/174427)  
  
**First initialise the library object**  

```B4X
Private Sub Button1_Click  
    NP.Initialize  
End Sub
```

  
  
**To print the currently displayed page**  

```B4X
Private Sub Button1_Click  
    NP.PrintContent(Root, True, False, "A4", 20, 20, 20, 20, "HIGH", "Print Form…")  
End Sub
```

  
  
**To print an imageview**  

```B4X
Private Sub Button2_Click  
    Dim IV As ImageView  
        IV.Initialize("")  
        IV.SetSize(555, 810) 'A great ImageView size for printing on A4 paper  
        IV.SetImage(XUI.LoadBitmap(File.DirAssets, "Invoice.jpg"))  
        IV.PreserveRatio = True  
  
    NP.PrintContent(IV, True, False, "A4", 20, 20, 20, 20, "HIGH", "Print Imageview…")  
End Sub
```

  
  
**B4J example test app screenshot - Printing a loaded layout file**  
![](https://www.b4x.com/android/forum/attachments/174428)  
  
**SS\_SimpleNativePrinter  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **NativePrinter**

- **Functions:**

- **Class\_Globals** As String
- **GetDefaultPrinter** As String
 *Returns the name of the system default printer.*- **GetPrinters** As List
 *Returns a list of all installed printers on the system.*- **Initialize** As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **PrintContent** (Target As Object, ShowDialog As Boolean, IsLandscape As Boolean, PaperSize As String, Top As Double, Right As Double, Bottom As Double, Left As Double, Quality As String, JobName As String) As String
 *Prints a UI layout, form, or image using native JavaFX printing.  
 Target: The object to print. Pass a layout root (B4XView) or an ImageView containing a bitmap.  
 ShowDialog: True to show the system print dialog, False to print directly to the default printer.  
 IsLandscape: True for landscape orientation, False for portrait.  
 PaperSize: Standard paper size as a string (e.g., "A4", "A3", "LETTER", "LEGAL").  
 Top, Right, Bottom, Left: Margins in typographical points (72 points = 1 inch).  
 Quality: Print quality level. Options: "HIGH", "NORMAL", "LOW", or "DRAFT".  
 JobName: The name of the print job (used for the print queue or default PDF filename).*- **PrintCustomContent** (Target As Object, ShowDialog As Boolean, IsLandscape As Boolean, PaperWidth As Double, PaperHeight As Double, Top As Double, Right As Double, Bottom As Double, Left As Double, Quality As String, JobName As String) As String
 *Prints a UI layout, form, or image using a custom paper size (finds the closest match supported by the printer).  
 Target: The object to print (B4XView or ImageView).  
 ShowDialog: True to show the system print dialog, False to print directly to the default printer.  
 IsLandscape: True for landscape orientation, False for portrait.  
 PaperWidth, PaperHeight: Custom dimensions in points (1 mm = 2.83465 points).  
 Top, Right, Bottom, Left: Margins in points.  
 Quality: Print quality level ("HIGH", "NORMAL", "LOW", or "DRAFT").  
 JobName: The name of the print job.*- **SetPrinter** (PrinterName As String) As String
 *Sets the printer to use by name before printing.  
 Pass an empty string ("") to revert to the system default printer.*- **Snapshot** (TargetView As B4XView) As B4XBitmap
 *Takes a full high quality snapshot of B4XViews and returns a B4XBitmap.  
 This method takes a higher quality snapshot than for example Root.Snapshot.  
 Example: Snapshot(Root), or basically any other view.  
 Uses slightly more memory for higher quality screenshots.*
  
  
**Enjoy…**