### PDF Creator and viewer by spsp
### 07/03/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/119025/)

Hello,  
  
Here are 3 classes :  
- PdfCreator : create PDF  
- PDFViewer : render PDF  
- clsFormPDF : form to preview PDF (Page navigation, Zoom, Print, Save)  
  
PdfCreator and PDFViewer wraps [PDFBox](https://pdfbox.apache.org/)  
You have to download [pdfbox-app-2.0.20.jar](https://downloads.apache.org/pdfbox/2.0.20/pdfbox-app-2.0.20.jar) and copy it in the additional folder  
You have to download [icu4j-67\_1.jar](https://github.com/unicode-org/icu/releases/tag/release-67-1) and copy it in the additional folder for right to left and connected arabic characters  

```B4X
    #AdditionalJar: pdfbox-app-2.0.20.jar  
    #AdditionalJar: icu4j-67_1.jar
```

  
  
For right to left and connected arabic characters, you need to uses the "bidi" method to buld your string  

```B4X
    s=pdfcreator.bidi("صباحا")
```

  
  
The zip contains a small project which show how to create PDF and preview them  

- The fist is very simple, just few lines of text
- The second is a long list with image, table, page footer, text color, background color….
- The third use differents standard fonts and load a font from a file and display arabic characters

![](https://www.b4x.com/android/forum/attachments/95675)  
![](https://www.b4x.com/android/forum/attachments/95676)  
  
![](https://www.b4x.com/android/forum/attachments/95680)  
![](https://www.b4x.com/android/forum/attachments/96550)  
  
To create a PDF :  

1. Create an instance of pdfCreator and initialize it
2. Create page
3. Create content
4. Write on the content (text, image, rect)
5. Close content
6. Add page to PDF
7. repeat 2 to 6
8. write PDF to stream or file

  
spsp