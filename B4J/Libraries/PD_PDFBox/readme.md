### PD_PDFBox by behnam_tr
### 10/16/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/172303/)

A B4J wrapper for Apache PDFBox 2.0.37 to generate PDF documents.  
  
**Key Features:**  

- **Percentage-based layout:** All positions and dimensions expressed as % of the page
- **Text & paragraphs:** Persian/Arabic shaping, auto line-wrap and page-break
- **Tables:** Simple CreateTable → AddRow → EndTable API with auto-repeating headers
- **Graphics:** Lines, rectangles, and images
- **Page numbering:** Auto footer with customizable format, size, and position
- **Fonts:** System fonts (Windows) or custom .ttf files (e.g. Vazir)
- **Printing:** Direct-to-printer support
- **Chainable layout:** Every draw method returns the next Y position in %

```B4X
Dim pdf As PD_PDFBox  
pdf.Initialize  
pdf.SetCustomFont("Vazir-Light.ttf", "Vazir-Bold.ttf")  
pdf.AddPage("A4", False)  
y = pdf.AddText("Hello world!", 10, 5, 80, 5, 14, "#000000", "RIGHT", "MIDDLE", True)  
y = y+1  
y = pdf.AddText("Hello world 2 !", 10, y, 80, 5, 14, "#000000", "RIGHT", "MIDDLE", True)  
pdf.Save(File.DirApp, "test.pdf")
```

  
  
need jars - copy to b4j library folder : {"commons-logging-1.3.6.jar", "fontbox-2.0.37.jar", "icu4j-60.2.jar", "pdfbox-2.0.37.jar"}  
  
Download Full Example : lib + jars + sample >> [**Download**](https://drive.google.com/file/d/18Fk8ORiHYIj7pkfeZ9GvzwhcChifG6qi/view?usp=drivesdk)