### Randomize Re-Sort List by Magma
### 03/30/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/160188/)

Hi there…  
  
Yesterday update the google drive link for **[B4XDesigner](https://www.b4x.com/android/forum/threads/b4xdesigner-pre-preview.157988/)** and needed to add the "Names" of programmers "loose" their time (i think that all win - when sharing knowledge and ideas) for this project… but I want to be fair by showing all names contribute in that big project…  
  
![](https://www.b4x.com/android/forum/attachments/152326)  
  
  
**so needed to randomize the sort of the list… thought this way… i am sure there are better ways (you can share them here)  
  
Well my way:**  
  

```B4X
Sub shownames  
    Dim allnames As List  
    allnames.Initialize  
    allnames.Add("Georgios Kantzas - MAGMA")  
    allnames.Add("Aeric")  
    allnames.Add("OliverA")  
    allnames.Add("zed")  
    allnames.Add("CableGuy")  
    allnames.Add("Walterf25")  
    allnames.Add("Jahwsant")  
    allnames.Add("Jakebullet70")  
    allnames.Add("Alexander Stolte")  
    lblAbout.Text = "B4XDesigner About…" & CRLF & CRLF & "Created by (Randomized Series):" & CRLF & CRLF & showrndlist(allnames) & CRLF & CRLF & "Click Names to re-sort…"  
End Sub  
  
Sub showrndlist(aa As List) As String  
    Dim how As Int = aa.Size  
    Dim newlist As List  
    Dim newtext As String  
    newlist.Initialize  
    For k=0 To how-1  
        newlist.Add(aa.Get(k))     
    Next  
  
    Dim a As Int  
    Dim b As Int  
    Dim c As String  
    Dim d As String  
  
    For k=0 To NumberFormat2((how-1)/2,0,0,0,False)  
  
        Do Until a<>b  
        a =Rnd(0,how)  
        b =Rnd(0,how)  
        Loop  
         
        c=newlist.Get(a)  
        d=newlist.Get(b)  
         
        newlist.Set(a,d)  
        newlist.Set(b,c)  
  
    Next  
     
    For k=0 To how-1  
        newtext=newtext & newlist.Get(k)  
        If k<how-1 Then  
            newtext=newtext & ", "  
        End If  
    Next  
     
    Return newtext  
End Sub  
  
  
  
Private Sub lblAbout_MouseClicked (EventData As MouseEvent)  
    shownames  
End Sub
```