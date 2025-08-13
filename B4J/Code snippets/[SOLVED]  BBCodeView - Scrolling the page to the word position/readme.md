### [SOLVED]  BBCodeView - Scrolling the page to the word position. by T201016
### 10/16/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143556/)

Hi,  
The source code included with the 'SourceCodeBBCodeView.txt' file will allow you to  
the ability to search any phrase forward and backward along with scrolling text in BBCodeView.  
  
You will get it through two procedures:  
 1.btnPreviousWord\_Action,  
 2. btnNextWord\_Action  
   
 I was based on an [example](https://www.b4x.com/android/forum/threads/b4x-scroll-background-color-by-words-in-a-string.120977/#content).  
  

```B4X
Sub AddBackgroundPanels As ResumableSub  
    For Each x As B4XView In BBCodeView1.sv.ScrollViewInnerPanel.GetAllViewsRecursive  
        If x.Tag = "background" Then  
            x.RemoveViewFromParent  
        End If  
    Next  
    Dim StyleSection As String  
    Dim scale As Float = TextEngine.mScale  
    For Each line As BCTextLine In BBCodeView1.Paragraph.TextLines  
        For Each un As BCUnbreakableText In line.Unbreakables  
            For Each s As BCSingleStyleSection In un.SingleStyleSections  
                StyleSection = s.Run.Text  
                If WordsToHighlight.Contains(StyleSection) = True And StyleSection.ToLowerCase.IndexOf(TextFind.Text.ToLowerCase) > -1 Then  
                    Dim pnl As B4XView = xui.CreatePanel("")  
                    pnl.Color = 0x5FFF0000  
                    pnl.Tag = "background"  
                    BBCodeView1.sv.ScrollViewInnerPanel.AddView(pnl, BBCodeView1.Padding.Left + s.AbsoluteStartX / scale - 4dip, _  
                    BBCodeView1.Padding.Top + (line.BaselineY - s.MaxHeightAboveBaseLine) / scale - 4dip, _  
                    s.Width / scale + 8dip, (s.MaxHeightBelowBaseLine + s.MaxHeightAboveBaseLine) / scale + 8dip)  
                    'Scrolling the page to the word position  
                    BBCodeView1.sv.ScrollViewOffsetY = BBCodeView1.Padding.Top + (line.BaselineY - s.MaxHeightAboveBaseLine) / scale - 4dip  
                    pnl.SendToBack  
                    Return True  
                End If  
            Next  
        Next  
    Next  
    Return False  
End Sub  
  
Private Sub btnPreviousWord_Action  
Try  
    Do While True  
        If steps = 1 And steps = wordcount Then  
            Main.cutils.ShowNotification3("THE BEGINNING OF THE SEARCH", "Beginning of the search,"&CRLF&"There are no more sophisticated words.", Main.cutils.ICON_WARNING, Main.MainForm, "BOTTOM_CENTER", 2000)  
            btnPreviousWord.Enabled = False  
            btnNextWord.Enabled = True  
            btnPreviousWord.TextColor = xui.Color_LightGray  
            btnNextWord.TextColor = xui.Color_Black  
            Return  
        End If  
        
        WordsToHighlight = B4XCollections.CreateSet2(Array(listWordsSpaces.Get(count-2),""))  
        
        count = count - 1  
        sb2.Initialize  
        sb2.Append(sb1.ToString)  
        sb2.Insert(listIndex.Get(count-1)+13, "[plain]")  
        sb2.Insert(listIndex.Get(count)+7+13, "[/plain]")  
        BBCodeView1.Text = sb2.ToString  
  
        Wait For (AddBackgroundPanels) Complete (Result As Boolean)  
  
        If Result Then  
            steps = steps - 1  
            If steps < 1 Then steps = 1  
  
            If steps = 1 Then  
                Main.cutils.ShowNotification3("THE BEGINNING OF THE SEARCH", "Beginning of the search,"&CRLF&"There are no more sophisticated words.", Main.cutils.ICON_WARNING, Main.MainForm, "BOTTOM_CENTER", 2000)  
                btnPreviousWord.Enabled = False  
                btnNextWord.Enabled = True  
                btnPreviousWord.TextColor = xui.Color_LightGray  
                btnNextWord.TextColor = xui.Color_Black  
                Exit  
            Else  
                btnPreviousWord.Enabled = True  
                btnNextWord.Enabled = True  
                btnPreviousWord.TextColor = xui.Color_Black  
                btnNextWord.TextColor = xui.Color_Black  
                Exit  
            End If  
        End If  
    Loop  
Catch  
    If steps < 1 Then steps = 1  
    count = 0  
    Return  
End Try  
End Sub  
  
Private Sub btnNextWord_Action  
Try  
    Do While True  
        WordsToHighlight = B4XCollections.CreateSet2(Array(listWordsSpaces.Get(count),""))  
        sb2.Initialize  
        sb2.Append(sb1.ToString)  
        count = count + 1  
        If count >= listIndex.Size Then  
            count = listIndex.Size - 1  
            WordsToHighlight = B4XCollections.CreateSet2(Array(listWordsSpaces.Get(count),""))  
        End If  
        sb2.Insert(listIndex.Get(count-1)+13, "[plain]")  
        sb2.Insert(listIndex.Get(count)+7+13, "[/plain]")  
        BBCodeView1.Text = sb2.ToString  
  
        Wait For (AddBackgroundPanels) Complete (Result As Boolean)  
  
        If Result Then  
            steps = steps + 1  
            If steps > wordcount Then steps = wordcount  
  
            If steps = wordcount Then  
                If steps = 1 Then count = 0  
                Main.cutils.ShowNotification3("COMPLETING TEXT SEARCH", "Completing !"&CRLF&"There are no more sophisticated words.", Main.cutils.ICON_WARNING, Main.MainForm, "BOTTOM_CENTER", 2000)  
                btnPreviousWord.Enabled = True  
                btnNextWord.Enabled = False  
                btnPreviousWord.TextColor = xui.Color_Black  
                btnNextWord.TextColor = xui.Color_LightGray  
                Exit  
            Else  
                btnPreviousWord.Enabled = steps > 1  
                If btnPreviousWord.Enabled Then  
                    btnPreviousWord.TextColor = xui.Color_Black  
                Else  
                    btnPreviousWord.TextColor = xui.Color_LightGray  
                End If  
                btnNextWord.Enabled = True  
                btnNextWord.TextColor = xui.Color_Black  
                Exit  
            End If  
        End If  
    Loop  
Catch  
    If steps > wordcount Then steps = wordcount  
    count = listIndex.Size - 1  
    Return  
End Try  
End Sub
```