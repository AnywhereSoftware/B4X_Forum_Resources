### Windows Notifications Library by hatzisn
### 12/14/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/144755/)

Good evening all,  
  
I created for my needs a library that shows windows notifications and it does not break the code in other platforms (tested in windows 10 & 11, Raspbian Linux and Ubuntu/Debian Linux with X11 - not tested with Mac –> please test and report any problems). It is based on this code by [USER=52836]@Daestrum[/USER]  
  
<https://www.b4x.com/android/forum/threads/any-established-way-for-b4j-to-produce-notifications-for-macos-win10.124929/post-830759>  
  
In order to test it create a new UI project and add a combobox in the Designer. Then replace all the code in Main with the following:  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
    Private ComboBox1 As ComboBox  
    Private ntf As Notifications  
    Dim img As Image  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Title = "Trial"  
    MainForm.Show  
    ntf.Initialize  
   
    ComboBox1.Items.AddAll(Array As String("ERROR", "INFO", "NONE", "WARNING"))  
End Sub  
  
Sub Button1_Click  
    img.Initialize(File.DirAssets,"recipe-rice-icon-16.png")  
    'You may pass null  
    img = Null  
    Dim sMessage As String = "This is a long message of text and I am writting a lot of funny staff and continuing doing this. This is a long message of text and I am writting a"  
    Log(sMessage.Length)  
    Select Case ComboBox1.SelectedIndex  
        Case 0  
            ntf.ShowNotification(img, sMessage, "Trial App Message", ntf.IconError)  
        Case 1  
            ntf.ShowNotification(img, sMessage, "Trial App Message", ntf.IconInfo)  
        Case 2  
            ntf.ShowNotification(img, sMessage, "Trial App Message", ntf.IconNone)  
        Case 3  
            ntf.ShowNotification(img, sMessage, "Trial App Message", ntf.IconWarning)  
    End Select  
   
End Sub
```