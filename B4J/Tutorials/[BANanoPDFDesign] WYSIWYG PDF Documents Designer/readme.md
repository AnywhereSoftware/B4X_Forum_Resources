### [BANanoPDFDesign] WYSIWYG PDF Documents Designer by Mashiane
### 11/18/2019
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/111443/)

Ola  
  
**NB: Update browser settings to view PDF internally!!!**  
  
[Test Drive](https://github.com/Mashiane/BANanoPDFMake/raw/master/Run-BANanoPDFDesign.zip)  
  
We started with [BANanoPDFMake](https://www.b4x.com/android/forum/threads/bananopdfmake-client-side-pdf-document-generation.111304/), which was a coding based approach to creating PDF Documents. To be able to display the documents in the browser using the pre-built in PDF viewer, we went on to [BANanoPDFView](https://www.b4x.com/android/forum/threads/bananopdfview-jquery-in-browser-pdf-viewer.111351/#content)  
  
The nice thing about the viewer is that internally one does not even have to activate the 'preview of pdf' documents in the browser.  
  
[MEDIA=youtube]Ci0UprUINyk[/MEDIA]  
  
Why BANanoPDFDesign? Well, I was coding a PDF document, this involved debugging the document to ensure that it displays as expected. With breaks inbetween, this process took 3 hours for a single page report. Originally this was an excel report, not so complex but as I am new to PDFMake it was a little tricky too. So my dilemna is, I have about 5 other documents that I need to generate and not also for the app im doing but this I will use for other things too and other webapps going forward.  
  
So I figured that I could spend a lot of hours creating a WYSIWYG designer and making it perfect so that my life is easier going forward creating reports. BANanoPDFDesign then came to life.  
  
This stand alone web app will have a treeview, a viewing area for your pdf document and then a property bag to create / update / delete some settings.  
  
The property bag allows a variety of input controls. You will recall that our first attempts for a property bag in B4J was discussed on this [thread](https://www.b4x.com/android/forum/threads/mashpropertybag.71947/#post-457241). We have followed a similar approach and also followed some approaches used in the new XUI PreferenceDialog.  
  
This is just an example of the property bag controls one can add.  
  
![](https://www.b4x.com/android/forum/attachments/85581)  
  
1. You create a document and specify its settings eg security etc. You can save and then compile the document. Once compiled, the pdf document will be viewable on the app. This means anytime you update anything on the report you are able to see how it will be right on the spot.  
  
One accesses the document structure by selecting the document on the tree.  
  
![](https://www.b4x.com/android/forum/attachments/85582)  
  
2. PDF also uses global styles as discussed before, these now can be easily configured by creating each style and then saving this. We use an accordion to separate the property bag sections. Each time you save a style, these are saved to the list of available styles for this document.  
  
![](https://www.b4x.com/android/forum/attachments/85583)  
  
3. Creating Pages  
  
One will be able to create multiple pages for the document and add the various items needed e.g. tables, lists, columns, texts, images, etc to make their document come to life.  
  
Now that I think about it, one could be able to use this as part of a PDF generating reporting engine for their webapps.  
  
Later!