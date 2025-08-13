### AddMenuItem in B4XPages for B4A and B4i by Cadenzo
### 10/08/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/143409/)

In my opinion it is very useful and good user experience, to organize all options in a context menu of an page (loosing space for buttons only for the main options).  
  
In B4A you can do it with **B4XPages.AddMenuItem(Me, "Option 1"), …** With B4XPages you can almost use the same code for B4A and B4i , but in this case it will not work with B4i , and we need a view lines of extra code here.  
  
First for the in page loaded view with B4i Designer edit Button **Top Right #1**: "Button Type" =Text, "Tag" = "menu", "Text" = "…", "Size" = 32  
  

```B4X
Sub Class_Globals  
    Private s_Menu() As String  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    s_Menu = Array As String("Option 1", "Option 2",  "Option 3", "Option 4")  
      
    #if B4A  
    For Each sName As String In s_Menu  
        B4XPages.AddMenuItem(Me, sName)  
    Next  
    #End If  
      
End Sub  
  
Sub B4XPage_MenuClick (Tag As String)  
    If Tag = "menu" Then 'für iOS Hauptmenü, quasi Sub pg_BarButtonClick (Tag As String)  
        #if B4i  
        Dim sheet As ActionSheet  
        sheet.Initialize("sheet", "", "Cancel", "", s_Menu)  
        sheet.Show(Root)  
        Wait For sheet_Click (result As String)  
        B4XPage_MenuClick(result)  
        #End If  
    Else  
        Dim iIndex As Int = GetIndexInArray(s_Menu, Tag)  
        Select iIndex  
            Case 0 'Option 1  
                  
            Case 1 'Option 2  
                  
            Case 2 'Option 3  
                  
            Case 3 'Option 4  
                  
        End Select  
    End If  
End Sub  
  
Sub GetIndexInArray(arr() As String, txt As String) As Int  
    Dim iIndex As Int = -1, iCount As Int = 0  
    For Each sTxt As String In arr  
         If sTxt = txt Then iIndex = iCount  
        iCount = iCount + 1  
    Next  
    Return iIndex  
End Sub
```