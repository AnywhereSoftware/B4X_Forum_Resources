### Scroll background color by words in a string. by Juan Perz
### 08/17/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/120845/)

![](https://www.b4x.com/android/forum/attachments/98007)  
Hi.  
This code will be part of an app that I am trying to make.  
The most difficult part of the code is made by Erel (Thanks).  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private WordsToHighlight As B4XSet  
    Dim BBCodeView1 As BBCodeView  
    Private TextEngine As BCTextEngine  
    Dim myString As String = "Put here the string you want to use."  
    Dim listIndex As List  
    Dim listWordsSpaces As List  
    Private Button1 As B4XView     
    Dim count As Int = 0       
    Dim sb1 As StringBuilder   
    Dim sb2 As StringBuilder  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    listIndex.Initialize  
    listIndex = getIndexListWordsSpaces(myString)  
    listWordsSpaces.Initialize  
    listWordsSpaces = getListWordsSpaces(myString, listIndex)  
    sb1.Initialize  
    sb2.Initialize  
    sb1.Append("[TextSize=20]") ' Put the text size here  
    sb1.Append(myString)  
    sb1.Append("[/TextSize]")  
    TextEngine.Initialize(MainForm.RootPane)  
    WordsToHighlight = B4XCollections.CreateSet2(listWordsSpaces)  
    BBCodeView1.Text = sb1.ToString  
    AddBackgroundPanels  
End Sub  
  
Sub Button1_Click  
    WordsToHighlight = B4XCollections.CreateSet2(Array(listWordsSpaces.Get(count),""))  
    count = count + 1  
    sb2.Initialize  
    sb2.Append(sb1.ToString)  
    If count = listIndex.Size Then  
        count = 0  
    Else  
        sb2.Insert(listIndex.Get(count-1)+13, "[plain]")  
        sb2.Insert(listIndex.Get(count)+7+13, "[/plain]")  
        BBCodeView1.Text = sb2.ToString  
    End If  
    AddBackgroundPanels  
End Sub  
  
Sub getIndexListWordsSpaces(str As String) As List  
    Dim indexF As List  
    Dim index As Int = 0  
    Dim index0 As Int  
    indexF.Initialize                                 
    indexF.Add(index)                               
    index = str.IndexOf2(" ",index+1)             
    indexF.Add(index)                               
    Do While index <> -1                               
        index0 = index                               
        index = str.IndexOf2(" ",index+1)         
        If index > index0 + 1 Then                   
            indexF.Add(index0+1)                     
            indexF.Add(index)                       
        Else                                           
            If index = -1 Then                         
                indexF.Add(index0+1)                 
            Else                                       
                indexF.Add(index)                   
            End If  
        End If  
    Loop  
    If str.SubString(indexF.Get(indexF.Size-1)) = "" Then  
        indexF.RemoveAt(indexF.Size-1)  
    End If  
    Return indexF  
End Sub  
  
Sub getListWordsSpaces(str As String, listIndexM As List) As List  
    Dim listWordsSpaces As List  
    listWordsSpaces.Initialize  
    For i=0 To listIndexM.Size-2  
        listWordsSpaces.Add(str.SubString2(listIndexM.Get(i),listIndexM.Get(i+1)))  
    Next  
    listWordsSpaces.Add(str.SubString(listIndexM.Get(i)))  
    Return listWordsSpaces  
End Sub  
  
' Erel's solution to put the Bacground Color.  
Private Sub AddBackgroundPanels  
    For Each x As B4XView In BBCodeView1.sv.ScrollViewInnerPanel.GetAllViewsRecursive  
        If x.Tag = "background" Then  
            x.RemoveViewFromParent  
        End If  
    Next  
    Dim scale As Float = TextEngine.mScale  
    For Each line As BCTextLine In BBCodeView1.Paragraph.TextLines  
        For Each un As BCUnbreakableText In line.Unbreakables  
            For Each s As BCSingleStyleSection In un.SingleStyleSections  
                If WordsToHighlight.Contains(s.Run.Text) Then  
                    Dim pnl As B4XView = xui.CreatePanel("")  
                    pnl.Color = 0xFF00D2FF  
                    pnl.Tag = "background"  
                    BBCodeView1.sv.ScrollViewInnerPanel.AddView(pnl, BBCodeView1.Padding.Left + s.AbsoluteStartX / scale - 2dip, _  
                     BBCodeView1.Padding.Top + (line.BaselineY - s.MaxHeightAboveBaseLine) / scale - 2dip, _  
                        s.Width / scale + 4dip, (s.MaxHeightBelowBaseLine + s.MaxHeightAboveBaseLine) / scale + 4dip)  
                    pnl.SendToBack  
                End If  
            Next  
        Next  
    Next  
End Sub
```