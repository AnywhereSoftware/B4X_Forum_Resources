### FlexibleTable, JumpToRowAndSelect problem by RB Smissaert
### 05/20/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/167084/)

In the flexibletable class (Table) I added a routine to incrementally add to the table with a list of 1D string arrays.  
This was needed to deal with very large text files.  
All working fine.  
I came across a problem though with the routine JumpToRowAndSelect, in that it didn't go to the specified row.  
Running the same line again:  
  

```B4X
oTable.JumpToRowAndSelect(0, iRow - 1)
```

  
  
Did did the job, but I thought this wasn't quite the right solution, so I looked for other ways to fix this.  
I came up with this solution, which works fine and seems to be fine as well when used in other situations, so when not  
incrementally adding to a table:  
  

```B4X
Private Sub SVF_ScrollChanged(Position As Int)  
      
    'Log("SVF_ScrollChanged, Position: " & Position)  
    'Log("SVF_ScrollChanged, SV2.VerticalScrollPosition: " & SV2.VerticalScrollPosition)  
    'Log("Sub SVF_ScrollChanged, cMP.PageCode: " & cMP.PageCode & ", " & Enums.arrB4XPagesNames(cMP.PageCode))  
      
    '————————————————————————————————  
    'this was added to solve a problem where Go2Row didn't go to the last row when run via page P_TXT  
    'seems it can be used always, so maybe we don't need the If clause  
    '————————————————————————————————  
    If cMP.PageCode = Enums.eB4XPages.iTextData Then  
        Position = SV2.VerticalScrollPosition  
    End If  
      
    SVFScrolls = True  
      
    If Position <> 0 Then 'added this to avoid the problem with scroll back to row zero with an initial down scroll  
        If SV2Scrolls = False Then  
            Scroll(SV2PosX, Position)  
            SV2.VerticalScrollPosition = Position  
        End If  
    End If  
      
    SVFScrolls = False  
      
End Sub
```

  
  
Maybe Klaus could comment if this solution would always work or if it could fail.  
The whole scrolling related code is a bit complex, so I couldn't work this out.  
  
RBS