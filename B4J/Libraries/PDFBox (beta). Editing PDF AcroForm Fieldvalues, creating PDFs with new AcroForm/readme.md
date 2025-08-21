### PDFBox (beta). Editing PDF AcroForm Fieldvalues, creating PDFs with new AcroForm by DonManfred
### 03/04/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/111258/)

This is a partial wrap for [Apache PDFBox](https://pdfbox.apache.org/).  
  
In this early stage i am focusing on manipulating PDF AcroForms and building new PDF with AcroForm.  
It is also possible to create some javascript which can run when you open the PDF on acrobat.  
  
The Examplecode and the needed Objects i got my inspiration from one of the [Examples](https://carbonrider.github.io/pdfbox_tutorial/pdf_new_form.html).  
  
  
Example Code (just my test code)  

```B4X
    'Building a new PDF with AcroForm  
  
    'PDDocument pdDocument = new PDDocument();  
    Dim r As PDRectangle  
    Dim hlp As FontandColorHelper  
  
    Dim doc As PDDocument  
    doc.Initialize("")  
    Dim cat As PDDocumentCatalog = doc.DocumentCatalog  
    Dim json As PDActionJavaScript  
    json.Initialize("",$"var now = util.printd('yyyy-mm-dd', new Date());  
  var oField = this.getField('Field1');  
  oField.value = now;"$)  
    cat.OpenAction =  json ' the Field "Field1" is used here…  
  
    Dim page As PDPage  
    page.Initialize(r.A4)  
  
    doc.addPage(page)  
    '  
    Dim acroform As PDAcroForm  
    acroform.Initialize(doc)  
  
    cat.AcroForm = acroform  
    '  
    Dim res As PDResources  
    res.Initialize  
    res.putFont(hlp.COURIER,"Cour")  
    acroform.DefaultResources = res  
    '  
    Dim textfield As PDTextField  
    textfield.Initialize("",acroform)  
    textfield.PartialName = "Field1" ' This is the Field we are refering in the javascript above.  
    textfield.DefaultValue = "B4X rules"  
    textfield.DefaultAppearance = "/Cour 12 Tf 0 0 1 rg"  
  
    acroform.addField(textfield)  
    textfield.Value = ""  
  
    '  
    Dim widget As PDAnnotationWidget = textfield.Widget  
  
    Dim rect As PDRectangle  
    rect.Initialize(50,750,300,20)  
    widget.Rectangle = rect  
    widget.Page = page  
  
    Dim fieldAppearance As PDAppearanceCharacteristicsDictionary  
    fieldAppearance.Initialize  
    fieldAppearance.BorderColour = hlp.createColor(Array As Float(8,16,32))  
    fieldAppearance.Background = hlp.createColor(Array As Float(32,64,8))  
  
    widget.AppearanceCharacteristics = fieldAppearance  
    widget.Printed = True  
  
    page.addAnnotation(widget)  
    '  
    '  
    doc.save("d:/sample_form.pdf")  
    doc.close()
```

  
  
The attached sample\_form.pdf is the PDF created by this Code ;-)  
  
The new Example i added does the following:  
- It exports a XFDF File from a given pdf with acroform.  
- It inports a sample XFDF and fill the PDF Acroform with the data from the XFDF.  
- Now working with another PDF the Example uses a Template PDF and adds a AcroForm onto this PDF. The newly generated PDF if saved.  
  
If you want to add Javascript for the generated AcroForm you can use this code for example.  

```B4X
        Dim js As PDActionJavaScript  
        js.Initialize($"var anzahl1 = this.getField("Pos1Anzahl");  
var preis1 = this.getField("Pos1Summe");  
  
var anzahl2 = this.getField("Pos2Anzahl");  
var preis2 = this.getField("Pos2Summe");  
  
var anzahl3 = this.getField("Pos3Anzahl");  
var preis3 = this.getField("Pos3Summe");  
  
var anzahl4 = this.getField("Pos4Anzahl");  
var preis4 = this.getField("Pos4Summe");  
  
var gesamt = this.getField("GesamtNetto");  
var mwst = this.getField("MWST");  
  
var gesamtbrutto = this.getField("EndPreis");  
  
var netto = (anzahl1.value*preis1.value)+(anzahl2.value*preis2.value)+(anzahl3.value*preis3.value)+(anzahl4.value*preis4.value)  
gesamt.value = netto;  
gesamtbrutto.value = netto+((netto/100)*mwst.value);"$)  
        widget.Action = js
```

  
What it does:  
It get the fields for pos1amount, pos1sum, pos2amount, pos2sum, pos3amount, pos3sum and pos4amount, pos4sum.  
It then calculate the tax (in german MWSt) and a endprice including Tax.  
The generated values are set into the fields.  
  
There are much more nice gimmicks you can do with the Acrobat internal Javascript. :D:cool:  
  
Download the PDFBox jar here:  
<https://www.dropbox.com/s/1wh9ldpumahqks5/AddLibsPDFBox.zip?dl=0>  
  
**PDFBox**  
*<link>…|<https://www.b4x.com></link>*  
**Author:** DonManfred  
**Version:** 0.29