### [BANanoPDFMake] Client Side PDF Document Generation by Mashiane
### 11/13/2019
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/111304/)

Ola  
  
[Download](https://github.com/Mashiane/BANanoPDFMake)  
  
Phew. A dream come through. Very excited right now…  
  
![](https://www.b4x.com/android/forum/attachments/85460)  
  
BANanoPDFMake is a wrap of the wonderful and amazing javascript library [PDFMake](http://pdfmake.org/#/)  
  
What I have tried to do here is to simplify this as much as possible. This means one can create a PDF document as simply as..  
  

```B4X
Sub basic  
    Dim maker As PDFMaker  
    maker.Initialize  
    maker.AddString("First paragraph")  
    maker.AddString("Another paragraph, this time a little bit longer to make sure, this line will be divided into at least two lines")  
    maker.Open  
End Sub
```

  
  
There is quiet a lot that the PDFMake JS library does in simple ways. You will note that the code included herein is split into classes that are easy to follow and even enhance. This will get you going in terms of generating PDF documents. This for me will be a MS Word replacement due to the reporting functionality needed on my side. At most PDF seems to be more professional looking than Excel reports at times.  
  
Explore the example code in the pdfIndex code module. I have attached here an example PDF of what that has produced.  
  
**What's Available and usable?**  
  

- Multiple Pages
- Password Protection & other security e.g. copying, annotation
- Compression
- QRCode
- Styling
- Lists
- Columns
- Tables (rowspans, colspans, borders, background etc)
- Headers & Footers
- Margins
- URL Clickable Links
- Watermark
- PageSize
- PageMode - landscape / potrait
- Write at XY pos (absolutePosition / relativePosition) when necessary
- ToC (table of contents)
- Images

  
Try it out now and tell us your thoughts!  
  
Ta!  
  
PS: Off to add this to the project i'm doing.. One of the things I appreciate about this JS Library is the ability of giving end users flexibility. You can create anything you want with it. Thanks to PDFMake!  
  
You have to experience this for yourself. ;) The code is easy to follow I hope for the examples.  
  
These are **pdf** and **pgindex** modules.