### [Web] [SithasoDaisy5] Using LeafLet Maps by Mashiane
### 05/25/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/167157/)

Hi Fam  
  
The next update of SithasoDaisy will have Leaflet Maps. These will be available via the abstract designer…  
  
![](https://www.b4x.com/android/forum/attachments/164326)  
  
One will be able to trap both map and marker events…  
  
So far, we have these events  
  

```B4X
#Event: BaseLayerChange (e As BANanoEvent)  
#Event: OverlayAdd (e As BANanoEvent)  
#Event: OverlayRemove (e As BANanoEvent)  
#Event: LayerAdd (e As BANanoEvent)  
#Event: LayerRemove (e As BANanoEvent)  
#Event: ZoomLevelsChange (e As BANanoEvent)  
#Event: Resize (e As BANanoEvent)  
#Event: Unload (e As BANanoEvent)  
#Event: ViewReset (e As BANanoEvent)  
#Event: Load (e As BANanoEvent)  
#Event: ZoomStart (e As BANanoEvent)  
#Event: MoveStart (e As BANanoEvent)  
#Event: Zoom (e As BANanoEvent)  
#Event: Move (e As BANanoEvent)  
#Event: ZoomEnd (e As BANanoEvent)  
#Event: MoveEnd (e As BANanoEvent)  
#Event: PopupOpen (e As BANanoEvent)  
#Event: PopupClose (e As BANanoEvent)  
#Event: AutopanStart (e As BANanoEvent)  
#Event: TooltipOpen (e As BANanoEvent)  
#Event: TooltipClose (e As BANanoEvent)  
#Event: LocationError (e As BANanoEvent)  
#Event: LocationFound (e As BANanoEvent)  
#Event: Click (e As BANanoEvent)  
#Event: DblClick (e As BANanoEvent)  
#Event: MouseDown (e As BANanoEvent)  
#Event: MouseUp (e As BANanoEvent)  
#Event: MouseOver (e As BANanoEvent)  
#Event: MouseOut (e As BANanoEvent)  
#Event: MouseMove (e As BANanoEvent)  
#Event: ContextMenu (e As BANanoEvent)  
#Event: Keypress (e As BANanoEvent)  
#Event: PreClick (e As BANanoEvent)  
#Event: ZoomAnim (e As BANanoEvent)
```

  
  
And one is able to set up properties via the abstract designer and add markers and other things via code.  
  
  
![](https://www.b4x.com/android/forum/attachments/164327)  
  
Trapping Events  
  

```B4X
Private Sub llmap_ZoomLevelsChange (e As BANanoEvent)  
    Log("llmap_ZoomLevelsChange")  
    Log(e)  
End Sub  
  
Private Sub llmap_Zoom (e As BANanoEvent)  
    Log("llmap_Zoom")  
    Log(e)  
End Sub  
  
Private Sub llmap_Click (e As BANanoEvent)  
    Log("llmap_Click")  
    Log(e)  
End Sub
```