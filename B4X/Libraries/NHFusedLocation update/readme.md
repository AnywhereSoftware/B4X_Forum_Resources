###  NHFusedLocation update by hatzisn
### 10/26/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/123878/)

<https://www.b4x.com/android/forum/threads/b4x-fused-location-b4xlibrary.116055/>  
  
An update to NHFusedLocation library has been posted in the 1st message of this thread.  
  
  
  
These are the changes:  
  

```B4X
'It is initialized like this  
flp.Initialize("fl", Me)  
  
  
'And this event is raised  
Private Sub fl_LocationChanged(Location1 As Location)  
  
End Sub  
  
'You can change the parent object also  
'Usage case you Initialize the NHFusedLocation in Starter  
'and in Main you set the following to raise the event above  
'in Main  
  
flp.Parent = Me
```