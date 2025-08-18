### [B4XLib] B4XCheckInternetLM by LucaMs
### 08/22/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/133628/)

Very simple cross-platform library to test if an Internet connection is active.  
  
It has only one method, **Check**:  

```B4X
Public CheckInternet As B4XCheckInternetLM  
  
Wait For (CheckInternet.Check(True)) Complete(Result As Boolean)  
If Result Then  
'  
Else  
'  
End If
```

  
Set the **DialogToo** parameter to False if you just want to test the presence of an active Internet connection, to True if you want to show a B4XDialog that gives the user time to activate one or "abort" the operation.  
  
To test, the library downloads the page <https://google.com>. A different address can be set via the **URL** property.  
  
It exposes the properties for the B4XDialog texts:  
  
**DlgTitle  
DlgMsg  
DlgYesText  
DlgCancelText**  
  
and the B4XDialog itself, so you can change its appearance.  
  
Library and B4XPages example attached.  
  
**V. 1.10**  
Added an indispensable property :confused: to set the Root of the current B4XPages open (name: **ParentView**)  
  
I am also attaching a second example, which has two B4XPages, just to show that the new property is indispensable and how to use it.