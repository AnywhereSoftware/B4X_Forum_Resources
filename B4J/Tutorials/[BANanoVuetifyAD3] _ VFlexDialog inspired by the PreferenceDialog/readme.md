### [BANanoVuetifyAD3] : VFlexDialog inspired by the PreferenceDialog by Mashiane
### 07/27/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/141779/)

Hi there  
  
The VFlexDialog is inspired by the ease of use in the PreferenceDialog. It exists to enable the ease of creating forms by developers. Its baseline are the VDialog, VForms and VFields. If you have used any of these including the VMsgBox, then you are right at home.  
  
The screen shots below have all been created by just calling utility functions to build the Dialog. Each dialog has a title, sub-title, yes, no, cancel buttons and these are dynamic and changeable via run time.  
  
The only ceveat about the VFlexDialog is that you have to create your controls on **Initialize** of your page because its based on the functionality of the VForm + VField. Unlike the Dynamic Form which can be created at runtime, this is specific to Design Time creation.  
  
To use it, drop a VFlexDialog inside a VContainer, specify the Title, Sub-Title, Yes/No/Cancel captions, colours, visibility etc and then create your Dialog Structure. You can also place controls side by side as demonstrated in these examples.  
  
NB: The elements on the VFlexDialog as VForm + VFields, so their respective events will apply.  
  
**Example 1**  
  
![](https://www.b4x.com/android/forum/attachments/131396)  
  
The source code that produces this UI is…  
  
In **Class\_Globals**  
  

```B4X
    Private txtfirstname As VField     'ignore  
    Private txtlastname As VField     'ignore  
    Private txtbio As VField     'ignore  
    Private cbolang As VField     'ignore  
    Private colhair As VField     'ignore  
    Private dpdob As VField     'ignore  
    Private txtheight As VField     'ignore  
    Private filimage As VField     'ignore  
    Private imgprofile As VField     'ignore  
    Private radgender As VField     'ignore  
    Private rngsalary As VField     'ignore  
    Private ratservice As VField     'ignore  
    Private sldloan As VField     'ignore  
    Private teltel As VField     'ignore  
    Private timmeet As VField     'ignore  
    Private pwdpass As VField     'ignore  
    Private swtactive As VField     'ignore  
    Private chkagree As VField     'ignore  
    Private VFlexDialog1 As VFlexDialog
```

  
  
In **Initialize**  
  

```B4X
Sub BuildPreferences  
    VFlexDialog1.Clear  
    'create options  
    Dim options As Map = CreateMap()  
    options.Put("eng", "English")  
    options.Put("afr", "Afrikaans")  
    options.Put("xho", "Xhosa")  
    options.Put("nde", "isiNdebele")  
    options.Put("zul", "isiZulu")  
    options.Put("sep", "Sepedi")  
    options.Put("ses", "Sesotho")  
    options.Put("tsw", "Setswana")  
    options.Put("swa", "seSwati")  
    options.Put("tsh", "Tshivenda")  
    options.Put("xit", "Xitsonga")  
     
    'ROW 1  
    VFlexDialog1.AddTextField(1, 1, "firstname", "First Name","Anele")  
    VFlexDialog1.AddTextField(1, 2, "lastname", "First Name","Mbanga")  
    'ROW 2  
    VFlexDialog1.AddTextArea(2, 1, "bio", "Biography","")  
    'ROW 3  
    VFlexDialog1.AddAutoComplete(3, 1, "lang", "Language", options, "eng", True)  
    VFlexDialog1.AddColor(3, 2, "hair", "Enter hair color","black")  
    'ROW 4  
    VFlexDialog1.AddDate(4, 1, "dob", "Enter Date of Birth","1973-04-15")  
    VFlexDialog1.AddDouble(4, 2, "height", "Enter your height","1.85")  
    'ROW 5  
    VFlexDialog1.AddFileInput(5, 1,"image", "Please upload your image")  
    VFlexDialog1.AddImage(5, 2, "profile", "./assets/myself.jpg", "100", "100")  
    '  
    Dim gender As Map = CreateMap()  
    gender.Put("male", "Male")  
    gender.Put("female", "Female")  
    gender.Put("other", "Other")  
    'ROW 6  
    VFlexDialog1.AddRadioGroup(6, 1, "gender", "Gender", gender,"male", True)  
    VFlexDialog1.AddRange(6, 2, "salary", "Salary Range", 5000, 10000, 100, 6000)  
     
    'ROW 7  
    VFlexDialog1.AddRating(7, 1, "service", 5, "How can you rate our service?", 2)  
    VFlexDialog1.AddSlider(7, 2, "loan", "Loan amount", 1000, 5000, 50, 1500)  
     
    'ROW 8  
    VFlexDialog1.AddTelephone(8, 1, "tel", "Telephone", "")  
    VFlexDialog1.AddTime(8, 2, "meet", "Time of Meeting","09:00")  
     
    'ROW 9  
    VFlexDialog1.AddPassword(9, 1, "pass", "Enter your password","", True)  
     
    'ROW 10  
    VFlexDialog1.AddSwitch(10, 1, "active","Active", True, True)  
    VFlexDialog1.AddCheckBox(10, 2, "agree", "I agree with Terms & Conditions",True)  
    '  
    VFlexDialog1.Refresh  
    'get the vFields for bindings  
    'COMPULSORY - get the created views to link events to them and also execute automatic bindstate.  
    txtfirstname = VFlexDialog1.Get("firstname")  
    txtlastname = VFlexDialog1.Get("lastname")  
    txtbio = VFlexDialog1.Get("bio")  
    cbolang = VFlexDialog1.Get("lang")  
    colhair = VFlexDialog1.Get("hair")  
    dpdob = VFlexDialog1.Get("dob")  
    txtheight = VFlexDialog1.Get("height")  
    filimage = VFlexDialog1.Get("image")  
    imgprofile = VFlexDialog1.Get("profile")  
    radgender = VFlexDialog1.Get("gender")  
    rngsalary = VFlexDialog1.Get("salary")  
    ratservice = VFlexDialog1.Get("service")  
    sldloan = VFlexDialog1.Get("loan")  
    teltel = VFlexDialog1.Get("tel")  
    timmeet = VFlexDialog1.Get("meet")  
    pwdpass = VFlexDialog1.Get("pass")  
    swtactive = VFlexDialog1.Get("active")  
    chkagree = VFlexDialog1.Get("agree")  
    'Log(VFlexDialog1.Declarations)  
    'Log(VFlexDialog1.Gets)  
End Sub
```

  
  
**Things to Note**  
  
Each element is defined to sit inside a grid. For example,  
  

```B4X
VFlexDialog1.AddTextField(1, 1, "firstname", "First Name","Anele")
```

  
  
This means the element will sit on R1C1.  
  
**Automatic BindState**  
  
As the elements created are VFields, they are bound by those terms and conditions. To be able to effect automatic bindstate in this case, after the building of the VFlexDialog by the **.Refresh** call  
  

```B4X
 VFlexDialog1.Refresh
```

  
  
We need to get each view created by the VFlexDialog, with calls like…  
  

```B4X
    pwdpass = VFlexDialog1.Get("pass")
```

  
  
This is mandatory for this to work.  
  
Ceveat: The code to create the elements is not direct use of the Abstract Designer, so the variable declarations in Class\_Globals are manual, thus we cannot generate members.  
However this does not stop one from dropping VFields with similar names on the abstract designer & then generating members & then remove them to avoid a conflict.  
  
**Events**  
  
As an example, when one clicks this element..  
  
![](https://www.b4x.com/android/forum/attachments/131399)  
  
The File Selector is activated and once someone selects a file, it is uploaded to the assets folder. The name of the element that is a FileInput is named "image", so a image\_change event will be trapped. Uploading the file to the server. This goes exactly the same with buttons and other events.  
  

```B4X
Private Sub image_Change(fileObj As Map)  
    page.refs = vuetify.GetRefs  
    'has the file been specified  
    If banano.IsNull(fileObj) Or banano.IsUndefined(fileObj) Then Return  
    'show the loading indicator  
    filimage.UpdateLoading(page, True)  
    'get file details  
    Dim fileDet As FileObject  
    fileDet = BANanoShared.GetFileDetails(fileObj)  
    'get the file name  
    Dim fn As String = fileDet.FileName  
    'you can check the size here  
    Dim fs As Long = fileDet.FileSize  
    If fs >= 5000 Then  
    End If  
    'start uploading the file to assets folder  
    fileDet = BANanoShared.UploadFileWait(fileObj)  
    'get the status of the upload  
    Dim sstatus As String = fileDet.Status  
    Select Case sstatus  
        Case "error"  
            'hide the uploader  
            filimage.UpdateLoading(page, False)  
            vuetify.ShowSnackBarError($"The file '${fn}' was not uploaded successfully!"$)  
        Case "success"  
            vuetify.ShowSnackBarSuccess($"The file '${fn}' was uploaded successfully!"$)  
    End Select  
    'get the upload full path  
    Dim fp As String = fileDet.FullPath  
    'update state of some element like an image  
    imgprofile.SetValue(page, fp)  
    'hide the uploading status  
    filimage.UpdateLoading(page, False)  
End Sub
```

  
  
**PLEASE SEE POST #7 FOR IMPORTANT UPDATES**