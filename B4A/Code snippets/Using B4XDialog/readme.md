### Using B4XDialog by Cadenzo
### 10/31/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/163871/)

This is a part of [my Code Snippets collection](https://www.b4x.com/android/forum/threads/create-and-navigate-to-b4xpage.163854/), needed in many projects.  
  
In many projects I add my DialogClass with basic user actions like choosing an option, input text or just asking yes or no. It is based on [B4XDialog](https://www.b4x.com/android/forum/threads/b4x-xui-b4xdialog-custom-dialogs.99756/#content) and for each project I can add the specific dialogs to the basic ones. This is also a good demonstration, how [Resumable Subs and "Wait for"](https://www.b4x.com/android/forum/threads/b4x-resumable-subs-sleep-wait-for.78601/#content) works.  
  

```B4X
    Dim dlg As DialogClass  :  dlg.Initialize(Me, Root, "")  
    wait for (dlg.ShowInputDialog("my question", [some explanations], [ a hint], [default answer], [mode like 'number'], "")) complete (result As String)  
    If result <> dlg.DIALOGCANCEL Then  
        'result' is the user-anwer  
    End If
```

  
  

```B4X
Sub Class_Globals  
    Private sendermodule As Object  
    Private s_EventName As String  
    Private Root As B4XView 'ignore  
    Private xui As XUI  
    Private Dialog As B4XDialog  
    Public DIALOGCANCEL As String = "[DIALOGCANCEL]", DIALOGNEGATIV As String = "[DIALOGNEGATIV]"  
    Public SelectedValue As Object  
    Private li_temp As List  
    Public s_SearchTemplate As String  
    Private clvList As CustomListView  
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize(module As Object, pg As B4XView, event As String)  
    sendermodule = module  
    s_EventName = event  
    Root = pg  
End Sub  
  
#if B4A  
Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event  
    If KeyCode = KeyCodes.KEYCODE_BACK And Dialog.Close(xui.DialogResponse_Cancel) Then Return True  
    Return False  
End Sub  
#End If  
  
Sub MsgDialog(msg As String, titel As String, pos As String, cancel As String, neg As String) As ResumableSub  
    Dim sf As Object = xui.Msgbox2Async(msg, titel, pos, cancel, neg, Null)  
    Wait For (sf) Msgbox_Result (Result As Int)  
    Return Result 'xui.DialogResponse_P  
End Sub  
  
Sub YesNoDialog(Msg As String, title As String) As ResumableSub  
    Dim bOK As Boolean  
    Dim bmp As Bitmap = LoadBitmap(File.DirAssets, "MyQuestionLogo.png")  
    Dim sf As Object = xui.Msgbox2Async(Msg, title, "Yes", "", "No", bmp)  
    Wait For (sf) Msgbox_Result (Result As Int)  
    If Result = xui.DialogResponse_Positive Then  
        bOK = True  
    End If  
    Return bOK  
End Sub  
  
Sub SetDialogTheme(dlg As B4XDialog) 'SetDialogLightTheme  
    dlg.BackgroundColor = xui.Color_White  
    dlg.ButtonsColor = xui.Color_White  
    dlg.BorderColor = xui.Color_Gray  
    dlg.ButtonsTextColor = 0xFF007DC3  
End Sub  
  
Sub SetCLVTheme(clv As CustomListView, textcolor As Int)  
    clv.sv.ScrollViewInnerPanel.Color = 0xFFDFDFDF  
    clv.sv.Color = Dialog.BackgroundColor  
    clv.DefaultTextBackgroundColor = xui.Color_White  
    clv.DefaultTextColor = textcolor  
End Sub  
  
Sub SetSearchDialogTheme(search As B4XSearchTemplate, textcolor As Int)  
    If textcolor = 0 Then textcolor = 0xFF5B5B5B 'https://www.b4x.com/android/forum/threads/b4x-share-your-b4xdialog-templates-theming-code.131243/#content  
    search.SearchField.TextField.TextColor = textcolor  
    search.SearchField.NonFocusedHintColor = textcolor  
    SetCLVTheme(search.CustomListView1, textcolor)  
    If search.SearchField.lblV.IsInitialized Then search.SearchField.lblV.TextColor = textcolor  
    If search.SearchField.lblClear.IsInitialized Then search.SearchField.lblClear.TextColor = textcolor  
    SetDialogTheme(Dialog)  
End Sub  
  
Sub ShowListDialog(li As List, title As String) As ResumableSub  
    Dim iIndex As Int = -1  
    Dim dlg As B4XDialog : dlg.Initialize(Root) : Dialog = dlg  
    SetDialogTheme(dlg)  
    dlg.Title = title  
'    dlg.BackgroundColor = xui.Color_RGB(0, 0x4d, 0x40)  
'    dlg.VisibleAnimationDuration = 500  
  
    
    Dim options As B4XListTemplate  
    options.Initialize  
    SetCLVTheme(options.CustomListView1, 0xFF5B5B5B)  
    'options.CustomListView1.DefaultTextBackgroundColor = xui.Color_RGB(0, 0x4d, 0x40)  
    options.Resize(options.mBase.Width,options.mBase.Height - 10dip)  
    
    options.Options = li  
    Wait For (Dialog.ShowTemplate(options, "", "", "CANCEL")) Complete (Result As Int)  
    If Result = xui.DialogResponse_Positive Then  
        Dim sSel As String = options.SelectedItem  
        For i = 0 To li.Size - 1  
            If li.Get(i) = sSel Then iIndex = i  
        Next  
    End If  
    Return iIndex  
End Sub  
  
Sub ShowInputDialog(titel As String, labeltitel As String, hint As String, text As String, mode As String, negtext As String) As ResumableSub  
    Dim sInput As String  
    Dim dlg As B4XDialog : dlg.Initialize(Root) : Dialog = dlg  
    SetDialogTheme(dlg)  
    dlg.Title = titel  
    
    Dim input As B4XInputTemplate : input.Initialize  
    input.lblTitle.Text = labeltitel  
    input.Text = text  
    input.TextField1.EditTextHint = hint  
    input.TextField1.TextColor = 0xFF5B5B5B  
    input.lblTitle.TextColor = 0xFF5B5B5B  
    If mode = "number" Then  
        input.ConfigureForNumbers(False, False)  
    End If  
    Wait For (Dialog.ShowTemplate(input, "OK", negtext, "CANCEL")) Complete (Result As Int)  
    If Result = xui.DialogResponse_Positive Then  
        sInput = input.Text  
    Else if Result = xui.DialogResponse_Negative Then  
        sInput = DIALOGNEGATIV  
    Else  
        sInput = DIALOGCANCEL  
    End If  
    
    Return sInput  
End Sub  
  
Sub ShowSearchDialog(li As List) As ResumableSub  
    Dim sSelected As String  
    Dim dlg As B4XDialog : dlg.Initialize(Root) : Dialog = dlg 'B4XSearchTemplate  
    Dim seach As B4XSearchTemplate : seach.Initialize  
    'seach.Resize(modH.GetDlgWidth, modH.GetDlgHight * 0.6)  
    seach.SetItems(li)  
    SetSearchDialogTheme(seach, 0)  
    Dim rs As Object = Dialog.ShowTemplate(seach, "", "", "CANCEL")  
    If s_SearchTemplate <> "" Then  
        Sleep(100) 'https://www.b4x.com/android/forum/threads/solved-b4xsearchtemplate-how-to-pre-set-text.135952/  
        seach.SearchField.Text = s_SearchTemplate  
    End If  
    Wait For (rs) Complete (Result As Int)  
    If Result = xui.DialogResponse_Positive Then  
        s_SearchTemplate = seach.SearchField.TextField.Text  
        sSelected = seach.SelectedItem  
    End If  
    Return sSelected  
End Sub
```