### [PyBridge] Create pdf with fpdf2 by Erel
### 03/26/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/166313/)

<https://py-pdf.github.io/fpdf2/index.html>  
  
This is a console app, based on the console template: [[PyBridge] Console (non-ui) project template](https://www.b4x.com/android/forum/threads/166094/#content)   
  
Dependency: pip install fpdf2  

```B4X
'Html - html string  
'img - Background image. Can be array of bytes or a string with the path to the image file.  
Public Sub HtmlToPDF (Html As Object, img As Object) As PyWrapper  
    Dim Code As String = $"  
import fpdf  
  
def HtmlToPDF (Html, img):  
    pdf = fpdf.FPDF()  
    pdf.add_page()  
    if not img is None:  
        pdf.image(img, x=0, y=0, w=210, h=297)  
    pdf.write_html(Html)  
    return pdf.output()  
"$  
    Return Py.RunCode("HtmlToPDF", Array(Html, img), Code)  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/162922)