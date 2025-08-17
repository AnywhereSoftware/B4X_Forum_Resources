### jRLDialogsX - Dialogs Library by rwblinn
### 11/22/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/52416/)

jRLDialogsX is an open source B4J Dialogs Library providing a comprehensive set of Dialogs.  
The library is coded as a B4J Class with Inline Java, no additional libraries or wrappers required.  
**Note:** Requirements minimum B4J v5.80 and Java JDK v8 (8u40+).  
  
Version: 1.88 - Attached the B4J library, source code, full example.  
  
**How to Use**  

- Copy jrldialogsx.jar, jrldialogsxfiles.jar and xml to the B4J additional library folder.
- In the B4J project, select **jrldialogsx** from the B4J IDE Libs tab.
- See folder **Examples** - the fullexample is a **must read,** get started with the InformationDialog.

**Version Control**  
[SPOILER="Change Log"]  
20221122 (v1.88) NEW: Set button CSS style; AlertSelectionDialog (buttons selection); CustomAlert (hightly configurable dialog) (See Post #91)  
20190407 (v1.87) NEW: SimpleFormDialog - DatePicker via option "D"; YesNoCancel dialog - if Cancel text is empty, the cancel button is not created;NEW: ListDialog, ListDialog2 - if DefaultItem = -1 then no item selected;UPD: Documentation & Examples; Published on GitHub  
20180326 (v1.86) NEW: ListFindDialog Set or get content of textfield FindItem  
20180312 (v1.85) NEW: DidYouKnow2 dialog with prev / next tip buttons; ExtendedDialog Show or hide the less details hyperlink button; UPD: ListFindDialog search field across dialog window, moved buttons OK & cancel down; UPD: Documentation & Examples. See Post #73  
20171025 (v1.80) NEW: jRLDialogsXFiles.jar holding additional files from the library Files folder. This file must be located in the B4J Additional Libraries folder.; NEW: ListFindDialog with a find item option - first non Inline Java Dialog (requires jRLDialogsXFiles.jar); UPD: Icons (for dialogs DidYouKnow and LoginDialog2) are included in jRLDialogsXFiles.jar; UPD: LoginDialog and Login2Dialog2 with textfield horizontal grow option; UPD: Documentation & Examples. See Post #60  
20170906 (v1.77) UPD: SimpleformDialog set request focus on first field; UPD: Minor changes  
20170822 (v1.76) NEW: Library renamed from jRLDialogs8 to jRLDialogsX; UPD: Minor changes  
20170802 (v1.75) NEW: PDF Documentation  
20170711 (v1.74) NEW: SimpleFormDialog ComboBox Field with field value comma separated string, SimpleFormDialog Property ComboBox editable; UPD: Examples. See Post #60  
20170703 (v1.72) NEW:ToastMessageAlert Information,Warning,Error; MessageHTMLDialog3 with OK/Cancel, MessageHTML show/hide details button; UPD: Examples. See Post #58  
20170626 (v1.68) NEW:MessageDialog set wrap;SimpleFormDialog set inputfield width;MessageHTMLDialog2;Overview;UPD:Examples. See Post #56  
20170620 (v1.65) NEW:Localization Show Details Hyperlink Button for Dialogs Extended, Message, MessageHTML; NEW: Extended Dialog option Message & MessageHTML Dialogs;UPD: Examples. See Post #55  
20170612 (v1.62) NEW:SliderDialog; NEW:SimpleFormDialog CheckBox Field; NEW: Extended Dialog option show content expanded; NEW: DoNotAskAgainDialog; UPD: Fields padding removed; UPD: Examples. See Post #53.  
20170601 (v1.59) NEW:SimpleFormDialog TextArea Field, option to split form fields; FIX: ConfirmDialog; UPD: Examples. See Post #50.  
20170531 (v1.58) NEW:ToastMessage set background and border line color; UPD: Examples. See Post #49.  
20170530 (v1.57) NEW:ColorNameDialog and ColorPickerDialog to get Color as Paint; NEW:ToastMessage set font size and border width; UPD:Toastmessage using default colors; UPD:Examples. See Post #47.  
20170528 (v1.56) NEW:SimpleFormDialog (create n label:field pairs; field=Text or Password or Numeric); MultiInputFieldDialog (create n label:textfield pairs); IntegerInputDialog; Full Example reworked. See Post #46.  
20170525 (v1.53) NEW:TimePicker (24h), TimePicker (12h), TextInputDialog4 (with option to set the width of the textfield, no label used); More examples. See Post #44.  
20170522 (v1.50) NEW:String localisation Username Label/Prompt, Password Label/Prompt, OK/Cancel Button, YES/NO Button, Login Button, Select Button. See Post #42.  
20160801 (v1.47) UPD:Set default selected item for ChoiceDialog, SelectDialog, ListDialog, and ListDialog2; Example 1 converted to B4J Visual Designer.  
20160411 (v1.46) UPD:MessageHTMLDialog handles anchors if defined like href="#myanchor" … name="myanchor" …  
20151011 (v1.45) UPD:Textfield gets initial focus when openeing dialog TextInputDialog, TextInputDialog2, TextInputDialog3, LoginDialog, LoginDialog2, TextAreaDialog  
20150910 (v1.40) NEW:SetParentWindow; FIX: ToastMessage center screen  
20150828 (v1.30) NEW:ToastMessage  
20150604 (v1.20 )NEW:TextAreaDialog  
20150617 (v1.11) UPD:TextInputDialog3 added hint for checking null  
20150512 (v1.10) NEW:TextInputDialog3  
20150406 (v1.00) NEW:SpinnerIntegerDialog, SpinnerDoubleDialog, SpinnerListDialog  
20150405 (v0.90) NEW:TextInputDialog2, DatePickerDialog  
20150404 (v0.80) NEW:SelectDialog; FIX: ListDialog, ListDialog2 removed expand option  
20150403 (v0.70) NEW:ListDialog, ListDialog2  
20150402 (v0.60) NEW:LoginDialog2, DidYouKnowDialog, ExceptionDialog, Message, MessageHTMLDialog  
20150401 (v0.50) NEW:ExtendedDialog, LoginDialog  
20150331 (v0.40) NEW:YesNoCancelDialog  
20150330 (v0.10) NEW:First Version  
[/SPOILER]  
  
**Simple Example Information Dialog with localized OK Button Text**  

```B4X
Sub Process_Globals  
  ..  
  'Define the dialog using jrldialogsX  
  Private Dlg As DialogsX  
End Sub  
Sub AppStart (Form1 As Form, Args() As String)  
  …  
  'Init the dialog  
  Dlg.Initialize  
  'Localize (optional)  
  Dlg.OKButtonText = "Thank You"  
  'Use the dialog to show Information Dialog  
  Dlg.InformationDialog("About", "jRLDialogX Information Dialog Example", "Hello World")  
End Sub
```