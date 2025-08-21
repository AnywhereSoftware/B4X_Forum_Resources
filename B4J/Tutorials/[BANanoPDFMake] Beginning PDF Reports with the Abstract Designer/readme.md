### [BANanoPDFMake] Beginning PDF Reports with the Abstract Designer by Mashiane
### 07/20/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/120374/)

I am excited about this.  
  
[BANanoPDFMake](https://www.b4x.com/android/forum/threads/bananopdfmake-client-side-pdf-document-generation.111304/#content) enables one to create PDF reports for their BANano apps client side. Thanks to [USER=974]@alwaysbusy[/USER]'s advice on how I could take this next phase of this reporting system forward.  
  
This attemps for one to use the abstract designer to drop html elements on their stage and using [html-to-pdfmake](https://github.com/Aymkdn/html-to-pdfmake) library, your layout can then be converted to a proper pdf document. Fortunately for BANanoPDFMake, all I had to do was to add a new method. **AddHTML** and everything else works the same. AddHTML just adds the HTML block from your layout to the current document. So whilst you can code you can also use the abstract designer for your PDF.  
  
![](https://www.b4x.com/android/forum/attachments/97409)  
  
**Reproduction**.  
  
*1. Create your layout.* Currently BANanoPDFMake comes with the PDFAnchor and PDFDiv custom views. The PDFDiv tag is where most of the tags exists.  
  
The tags that come with PDFDiv are the following:  
  

```B4X
List: div|p|span|br|b|strong|i|em|s|ul|ol|li|hr|table|thead|tbody|tfoot|tr|th|td|h1|h2|h3|h4|h5|h6|a|u
```

  
  
Whilst the anchor is just the anchor with href.  
  
The nice thing is you can style your elements with the **style** tag to your hearts desire, limited to the styles that can be converted by html-to-pdfmake. Whilst this is not a fully fledged reporting engine approach, it does a decent job for these tasks.  
  
2. *Load the layout, .GetHTML and then feed the html from the layout to BANanoPDFMake*.  
  

```B4X
Sub FromLayout  
    Dim maker As PDFMaker  
    maker.Initialize  
    maker.defaultStyle.fontSize = 12  
    maker.pageSize = "A4"  
    maker.pageOrientation = "potrait"  '/potrait  
    maker.SetPageMargins(40, 60, 40, 60)  
    maker.title = "PDFMake from Layout"  
    maker.author = "TheMash"  
      
    BANano.LoadLayout("#body", "pdf1")  
    '  
    maker.AddHTML("#body")  
    '  
    'we have passed a class=red in one of the components  
    Dim red As PDFStyle = maker.CreateStyle("red").SetColor("red")  
    maker.AddStyle(red)  
    'format all <strong> elements  
    Dim htmlstring As PDFStyle = maker.CreateStyle("html-strong").SetBackground("yellow")  
    maker.AddStyle(htmlstring)  
      
    maker.Download("bananopdfmake.pdf")  
End Sub
```

  
  
As we have passed some "class" names in our HTML layout items, we need to tell BANanoPDFMake about this. We create a style and sets its color to red. Our html element in the "classes" propertybag item has "red" specified. For paragraphs that have differently formatted text, we create child spans inside the paragraph with the needed formatting.  
  
For this example above, we have 3 images, 1 = layout, 2 = web-browser (we have not hidden the parent element) and 3 = pdf output.  
  
#Will Keep You Posted!