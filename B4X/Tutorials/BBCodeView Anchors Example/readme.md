###  BBCodeView Anchors Example by Erel
### 05/24/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/148130/)

![](https://www.b4x.com/android/forum/attachments/142262) ![](https://www.b4x.com/android/forum/attachments/142263)  
  
A small, cross platform, example of using the new anchors feature of BBCodeView.  
  
It reads a CSV file with information about US politicians. The data is used to populate a BBCodeView and B4XDialog+B4XSearchTemplate.  
  
The bbcode looks like:  

```B4X
For Each pol As Politician In politicians  
        sb.Append($"  
[a="${pol.Name}"][TextSize=18]${pol.Name}[/TextSize][/a]  
    Twitter: @${pol.TwitterUserName}  
    Birthday: $Date{pol.Birthday}  
    ${pol.Party}  
"$)  
    Next
```

  
Note the "a" tag at the beginning.  
  
The anchors are used in this code:  

```B4X
Private Sub btnJumpTo_Click  
    Wait For (dialog.ShowTemplate(SearchTemplate, "", "", "Cancel")) Complete (result As Int)  
    If result = xui.DialogResponse_Positive Then  
        BBCodeView1.ScrollToAnchor(SearchTemplate.SelectedItem)  
    End If  
End Sub
```

  
  
The generated bbcode text can get quite large. I wouldn't use BBCodeView like this with a larger dataset.