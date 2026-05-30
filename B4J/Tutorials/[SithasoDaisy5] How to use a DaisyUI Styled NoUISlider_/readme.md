### [SithasoDaisy5] How to use a DaisyUI Styled NoUISlider? by Mashiane
### 05/23/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/171095/)

Hi Fam  
  
I needed a range selector using NoUISlider that can be easily customized for DaisyUI5. Whilst this was done it had a few bugs and I could not use it fully in SD5. After burning some tokens Im comfortable in sharing this with the world.  
  
![](https://www.b4x.com/android/forum/attachments/171609)  
  
Some other examples feature tooltips and also "pips"  
  
![](https://www.b4x.com/android/forum/attachments/171610)  
  
After initialization, one is able to add it to a page using..  
  

```B4X
nosWarning.Initialize(Me, "nosWarning", "nosWarning")  
    nosWarning.ParentID = "nosCol1"  
    nosWarning.StartValues = "25,75"  
    nosWarning.RangeMin = "0"  
    nosWarning.RangeMax = "100"  
    nosWarning.Connect = "true"  
    nosWarning.Color = "warning"  
    nosWarning.Size = "md"  
    nosWarning.SliderType = "legend"  
    nosWarning.Label = "Warning"  
    nosWarning.Tooltips = False  
    BANano.Await(nosWarning.AddComponent)
```

  
  
Trapping Events  
  

```B4X
Private Sub nosWarning_Change(Values As String)  
    app.ShowToastSuccess(Values)  
End Sub
```

  
  
  
That's it!  
  
#SharingTheGoodness