### GoogleMapsextra custom infowindow by astronald
### 02/01/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/127166/)

i try changue default view color of infowindow to transparent  
![](https://www.b4x.com/android/forum/attachments/107217)![](https://www.b4x.com/android/forum/attachments/107218)  
I don't know if there is an easier way  
  
I succes it with this code  
  

```B4X
            sub InfoAdaptador_GetInfoContents(Marca As Marker) As View  
                'edit layout components from infopanel  
               
               infoPanel.Parent.Color = Colors.Transparent  
                return infoPanel  
            end sub
```

  
  
this code only works second time show infowindow  
i solve this add fake marker and show this (Release Mode)  

```B4X
     FakeMark = gmap.AddMarker(0,0,"Fake")  
        FakeMark.Snippet=0  
        FakeMark.InfoWindowShown=True  
        FakeMark.Remove
```

  
   
and add to GetInfoContents  
  

```B4X
Sub InfoAdaptador_GetInfoContents(Mark As Marker) As View  
  
    Try  
        If Mark.Snippet = 0 Then  
            Return infoPanel  
        Else 'Normal operation  
  
             'Work with panel  
  
              infoPanel.Parent.Color = Colors.Transparent  
        End If  
       
        Catch  
        Log(LastException.Message)  
    End Try  
    Return infoPanel  
End if
```

  
  
This is not the most elegant solution but it works!!!  
  
I would like to know if there is another option, I think that the library already has a defined layout so it is necessary to hide it.