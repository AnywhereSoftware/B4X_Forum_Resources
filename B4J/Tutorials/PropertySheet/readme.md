### PropertySheet by Erel
### 01/04/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/50863/)

[jControlsFX library v1.20](https://www.b4x.com/android/forum/threads/controlsfx-library.50700/#post-317140) includes a control named PropertySheet. With this control it is very simple to create forms with many fields.  
  
The data for these fields comes from a custom type instance.  
The editor type used by each field is determined from the field type.  
  
![](http://www.b4x.com/basic4android/images/SS-2015-02-18_16.53.50.png)  
  
The PropertySheet Set method expects two parameters: the type instance and a metadata map that describes the fields.  
  
The above screenshot was taken from this program:  

```B4X
Sub Process_Globals  
   Private fx As JFX  
   Private MainForm As Form  
   Private sheet As PropertySheet  
   Type Record(Text As String, Number As Double, _  
     Color As Paint, Fnt As Font, Choices As String, YesNo As Boolean)  
   Private cutils As ControlsUtils  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
   cutils.DisableCssWarnings  
   MainForm = Form1  
   MainForm.Show  
   sheet.Initialize("sheet")  
   MainForm.RootPane.AddNode(sheet, 0, 0, 400, 400)  
   Dim rec As Record  
   rec.Initialize  
   Dim meta As Map = CreateMap("Text": sheet.CreateMeta("Text", "Category1", "Text Text"), _  
     "Number": sheet.CreateMeta("Some Number", "Category1", "Number Number"), _  
     "Color": sheet.CreateMeta("Nice Color", "Category2", "Nice color"), _  
     "Fnt": sheet.CreateMeta("Favorite Font", "Category2", ""), _  
     "YesNo": sheet.CreateMeta("Yes?", "Category2", ""), _  
     "Choices": sheet.CreateMeta("Choose one", "Category3", _  
       "choose one from the list").SetChoices(Array("Choice 1", "Choice 2", "Choice 3")))  
   sheet.Set(rec, meta)  
End Sub
```

  
  
**Editors**  
  
The property editor is derived from the field type:  
  
String - Text field.  
Numbers (other than Long) - Numbers field.  
Paint - Color picker.  
Long - Date picker.  
Font - Font picker.  
  
You can also set the possible values by calling PropertyMetaData.SetChoices.  
  
**Metadata**  
  
The metadata map, maps between the fields names, **which are case sensitive**, and PropertyMetaData objects which are created with PropertySheet.CreateMeta.  
  
The metadata includes:  
Name - The text that appears at the left side of the property.  
Category - The property category. This is used when the sheet is in category mode to categorize the properties.  
Description - The property tooltip.  
You can also call SetChoices to define the possible values.  
  
**Data**  
  
Whenever the user modifies a value, the value is automatically updated in the type instance.  
  
**Example**  
  
![](http://www.b4x.com/basic4android/images/SS-2015-02-18_17.09.02.png)  
  
The attached short example creates 10 records and uses RandomAccessFile.WriteB4XObject to save and later load the data from a file.  
  
**Tip: switch jControlsFX with jControlsFX9 if using Java 9+.**