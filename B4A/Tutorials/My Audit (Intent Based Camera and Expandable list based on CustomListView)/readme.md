### My Audit (Intent Based Camera and Expandable list based on CustomListView) by Johan Schoeman
### 10/03/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/123057/)

Have combined **[Expandable List Based on CustomListView](https://www.b4x.com/android/forum/threads/expandable-list-based-on-customlistview.81445/)** and [**Intent Based Camera**](https://www.b4x.com/android/forum/threads/intent-based-camera.69215/) to create attached project. The plan is to use this for auditing purposes. Once I am done with this project it will create a PDF from the audit (thinking of using iText with some inline java code. Have already created a sample project with iText - see image at the end of this posting.  
  
1. Questions for the audit is in the /Files folder of the attached project (myaudit.txt) - the questions are populated from this file.  
2. Once an item of the list has been expanded, click on the camera icon. Take a snapshot and click "OK". The image will be loaded into the open expandable list  
3. Click on the icon to the left of the camera icon. It will enable an edittext box so that you can add a comment(s) - multi line  
4. If one of the check boxes has been set and the expandable listview is collapsed, the "title" text color will change from white to yellow so that one knows that the question has been answered.  
  
***Sample code:***  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: B4A Expandable List  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#AdditionalJar: itextg-5.5.10.jar  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
      
    Private ion As Object  
    Private const tempImageFile As String = "tempimage.jpg"  
    Private lastPicture As Bitmap  
      
    Dim activityname As String = "My Audit"  
      
  
End Sub  
  
Sub Globals  
    Private clv1 As CustomListView  
    Private lblTitle As B4XView  
    Private pnlTitle As B4XView  
    Private pnlExpanded As B4XView  
    Private xui As XUI  
    Private expandable As CLVExpandable  
    Dim List1 As List  
    Private ImageView1 As ImageView  
      
    Private ImageView2 As ImageView  
      
      
    Private EditText1 As EditText  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("1")  
    expandable.Initialize(clv1)  
  
    Log(File.DirRootExternal)  
    Log(File.DirAssets)  
      
    ReadListExample  
      
    For i = 0 To List1.Size - 1  
        Dim p As B4XView = CreateItem(0xFF000000, List1.Get(i), 350dip)  
        clv1.Add(p, expandable.CreateValue(p, "some value"))  
    Next  
      
      
End Sub  
  
Sub CreateItem(clr As Int, Title As String, ExpandedHeight As Int) As B4XView  
    Dim p As B4XView = xui.CreatePanel("")  
    p.SetLayoutAnimated(0, 0, 0, clv1.AsView.Width, ExpandedHeight)  
    p.LoadLayout("Item")  
    p.SetLayoutAnimated(0, 0, 0, p.Width, p.GetView(0).Height) 'resize it to the collapsed height  
    lblTitle.Text = Title  
    pnlTitle.Color = clr  
    pnlExpanded.Color = ShadeColor(0x33000055)  
    Return p  
End Sub  
  
Sub ShadeColor(clr As Int) As Int  
    Dim argb() As Int = GetARGB(clr)  
    Dim factor As Float = 0.75  
    Return xui.Color_RGB(argb(1) * factor, argb(2) * factor, argb(3) * factor)  
End Sub  
  
Sub GetARGB(Color As Int) As Int()  
    Private res(4) As Int  
    res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)  
    res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)  
    res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)  
    res(3) = Bit.And(Color, 0xff)  
    Return res  
End Sub  
  
  
Sub clv1_ItemClick (Index As Int, Value As Object)  
    expandable.ToggleItem(Index)  
'    Log("value = " & Value)  
   
    Sleep(400)  ' stops error  
    Dim pnlItems As B4XView = clv1.GetPanel(Index).GetView(1)   'pnlExpanded is Second Item on Item layout  
'    Dim mbm As B4XBitmap = pnlItems.GetView(0).GetBitmap        'the imageview that holds the pic is at index = 1  
      
    Dim pnlItems As B4XView = clv1.GetPanel(Index).GetView(1)  
    Dim rbYes As RadioButton = pnlItems.GetView(1)  
    Dim rbNo As RadioButton = pnlItems.GetView(2)  
    Dim rbNA As RadioButton = pnlItems.GetView(3)  
      
    If rbYes.Checked = True Or rbNo.Checked = True Or rbNA.Checked = True Then    'mbm.IsInitialized = True Or  
        Dim pnlTitle As B4XView = clv1.GetPanel(Index).GetView(0)   'pnlTitle is First Item on Item layout  
        pnlTitle.GetView(0).TextColor = Colors.Yellow  
    End If  
          
  
'    'Title Panel …  
'    Dim pnlTitle As B4XView = clv1.GetPanel(Index).GetView(0)   'pnlTitle is First Item on Item layout  
'    pnlTitle.GetView(0).Text = "This is a New Title"            'lblTitle is first pnlTitle View  
'  
'    'Items Panel …  
'    Dim pnlItems As B4XView = clv1.GetPanel(Index).GetView(1)   'pnlExpanded is Second Item on Item layout  
'    pnlItems.GetView(0).Text = "ABC"      '1st panel view  
'    pnlItems.GetView(1).Text = "123"      '2nd panel view  
      
End Sub  
  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
  
Sub ReadListExample  
      
    'We are not initializing the list because it just holds the list that returns from File.ReadList  
    List1 = File.ReadList(File.DirAssets, "myaudit.txt")  
    'Msgbox("List1.Size = " & List1.Size & CRLF & "The third item is: " & List1.Get(2), "")  
End Sub  
  
  
'Sub Button1_Click  
'    Log("clicked")  
'    Dim index As Int  
'    index=clv1.GetItemFromView(Sender)  
'    handlepicture(index)  
'     
'End Sub  
  
  
Sub handlepicture(index As Int)  
      
    Activity.LoadLayout("2")  
    If lastPicture.IsInitialized Then ImageView1.Bitmap = lastPicture  
    TakePicture  
    Activity.RemoveViewAt(1)                                         'remove the imageview that displays the captured image  
    Sleep(400)  
    Activity.RemoveViewAt(1)                                         'remove the button TAKE PICTURE  
          
    Dim pnlItems As B4XView = clv1.GetPanel(index).GetView(1)        'pnlExpanded is Second Item on Item layout  
    Sleep(400)  
    lastPicture = lastPicture.Resize(100dip, 100dip, True).Rotate(90)  
    pnlItems.GetView(0).SetBitmap(lastPicture)                       'the imageview that holds the pic is at index = 1  
    pnlItems.GetView(0).Visible = True  
      
End Sub  
  
  
Sub TakePicture  
    Dim i As Intent  
    i.Initialize("android.media.action.IMAGE_CAPTURE", "")  
    File.Delete(Starter.provider.SharedFolder, tempImageFile)  
    Dim u As Object = Starter.provider.GetFileUri(tempImageFile)  
    i.PutExtra("output", u) 'the image will be saved to this path  
    Try  
        StartActivityForResult(i)  
    Catch  
        ToastMessageShow("Camera is not available.", True)  
        Log(LastException)  
    End Try  
    Activity.Title = activityname  
End Sub  
  
'result arrives here  
Sub ion_Event (MethodName As String, Args() As Object) As Object  
  
    If Args(0) = -1 Then  
        Try  
            Dim in As Intent = Args(1)  
            If File.Exists(Starter.provider.SharedFolder, tempImageFile) Then  
                lastPicture = LoadBitmapSample(Starter.provider.SharedFolder, tempImageFile, ImageView1.Width, ImageView1.Height)  
                ImageView1.Bitmap = lastPicture  
  
            Else If in.HasExtra("data") Then 'try to get thumbnail instead  
                Dim jo As JavaObject = in  
                lastPicture = jo.RunMethodJO("getExtras", Null).RunMethod("get", Array("data"))  
            End If  
        Catch  
            Log(LastException)  
        End Try  
    End If  
    If lastPicture.IsInitialized Then ImageView1.Bitmap = lastPicture  
    Return Null  
End Sub  
  
  
Sub StartActivityForResult(i As Intent)  
    Dim jo As JavaObject = GetBA  
    ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)  
    jo.RunMethod("startActivityForResult", Array As Object(ion, i))  
End Sub  
  
Sub GetBA As Object  
    Dim jo As JavaObject  
    Dim cls As String = Me  
    cls = cls.SubString("class ".Length)  
    jo.InitializeStatic(cls)  
    Return jo.GetField("processBA")  
End Sub  
  
  
  
Sub ImageView3_Click  
      
    Log("clicked")  
    Dim index As Int  
    index=clv1.GetItemFromView(Sender)  
    handlepicture(index)  
      
End Sub  
  
Sub ImageView4_Click  
      
    EditText1.SingleLine = False  
  
    Dim index As Int  
    index=clv1.GetItemFromView(Sender)  
    Dim pnlItems As B4XView = clv1.GetPanel(index).GetView(1)        'pnlExpanded is Second Item on Item layout  
    Sleep(400)  
    pnlItems.GetView(6).Visible = True  
  
End Sub
```

  
  
***Take note of the Manifest!***  
  
  
  
2. ![](https://www.b4x.com/android/forum/attachments/100852)  
  
**Created PDF with iText and inline Java code.**  
![](https://www.b4x.com/android/forum/attachments/100853)