### [Web][SithasoDaisy5] Designing Forms with the Abstract Designer by Mashiane
### 04/27/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/165942/)

Hi Fam  
  
[SithasoDaisy5 Demo](https://sithaso-daisy5.vercel.app/)  
  
Before you start this tutorial, please ensure that your dev environment is setup by following this tutorial.  
  
<https://www.b4x.com/android/forum/threads/web-beginning-webapp-website-development-with-sithasodaisy5.166741/>  
  
Get your **FREE** copy of [**SithasoDaisy5**](https://github.com/Mashiane/SithasoDaisy5) here  
  
With SithasoDaisy5, you design your webapps and websites with the power of the abstract designer and generate events and and. In this sneak peak, I'd like to show you the simplicity of creating a form in the abstract designer, see it in real life and then perform some validation, saving the data to a map variable for later processing.  
  
We have designed our form using SDUI5Container, SDUI5Row, SDUI5Column and then some input components. The form is responsive for both mobile and large screens.  
  
**This thread will prove useful**  
  
<https://www.b4x.com/android/forum/threads/banano-v2-2-b4j-abstract-designer.101544/>  
  
Let's continue  
  
**Abstract Designer Form**  
  
![](https://www.b4x.com/android/forum/attachments/162248)  
  
  
**Reallife Form**  
  
![](https://www.b4x.com/android/forum/attachments/162249)  
  
**Source Code - Validate, Get Input Control Values, Save to a Map Variable**  
  
We then "generate members" from the abstract designer and then can validate and read the form details. Here is the complete source code of the **pgValidation** code module in the demo app.  
  

```B4X
'Static code module  
Sub Process_Globals  
    Private BANano As BANano        'ignore  
    Private app As SDUI5App            'ignore  
    Private btnCancel As SDUI5Button  
    Private btnSave As SDUI5Button  
    Private cboQualification As SDUI5Select  
    Private chkAgree As SDUI5CheckBox  
    Private chkBreakfast As SDUI5CheckBoxGroup  
    Private fpImage As SDUI5FileInput  
    Private gsActivities As SDUI5GroupSelect  
    Private pgTasks As SDUI5Progress  
    Private rdGender As SDUI5RadioGroup  
    Private rgSalary As SDUI5Range  
    Private rtService As SDUI5Rating  
    Private txtdob As SDUI5TextBox  
    Private txtfirstname As SDUI5TextBox  
    Private txtlastname As SDUI5TextBox  
    Private txtPersonalDetails As SDUI5TextArea  
End Sub  
  
  
Sub Show(MainApp As SDUI5App)  
    app = MainApp  
    BANano.LoadLayout(app.PageView, "validationview")  
    pgIndex.UpdateTitle("Validation")  
End Sub  
  
  
Private Sub btnSave_Click (e As BANanoEvent)  
    'begin validation of components  
    app.ResetValidation  
    'validate each of the elements  
    app.Validate(txtfirstname.IsBlank)  
    app.Validate(txtlastname.IsBlank)  
    app.Validate(txtdob.IsBlank)  
    app.Validate(chkBreakfast.IsBlank)  
    app.Validate(gsActivities.IsBlank)  
    app.Validate(rdGender.IsBlank)  
    app.Validate(rgSalary.IsBlank)  
    app.Validate(rtService.IsBlank)  
    app.Validate(cboQualification.IsBlank)  
    app.Validate(txtPersonalDetails.IsBlank)  
    app.Validate(chkAgree.IsBlank)  
    app.Validate(fpImage.IsBlank)  
    
'    app.Validate(txtEmail.IsBlank)  
'    app.Validate(txtTelephone.IsBlank)  
'    app.Validate(txtAddress.IsBlank)  
'    app.Validate(radGender.IsBlank)  
    'check the form status  
    If app.IsValid = False Then  
        app.ShowToastError("Please specify all required information!")  
        Return  
    End If  
    '  
    Dim rec As Map = CreateMap()  
    rec.Put("firstname", txtfirstname.Value)  
    rec.Put("lastname", txtlastname.Value)  
    rec.Put("date_of_birth", txtdob.Value)  
    rec.Put("breakfast", chkBreakfast.Value)  
    rec.Put("activities", gsActivities.Value)  
    rec.Put("gender", rdGender.Value)  
    rec.Put("salary", rgSalary.Value)  
    rec.Put("rate_service", rtService.Value)  
    rec.Put("qualification", cboQualification.Value)  
    rec.Put("personal_details", txtPersonalDetails.Value)  
    rec.Put("agree", chkAgree.Checked)  
    rec.Put("profile_image", fpImage.GetFile)  
    Log(rec)  
End Sub  
  
Private Sub btnCancel_Click (e As BANanoEvent)  
    
End Sub
```

  
  
Have Fun!