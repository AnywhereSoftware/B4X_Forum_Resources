### Get Visible Area Of Scrollpane by keirS
### 08/12/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/121151/)

Couldn't find a solution to this when searching. If you use the Scrollpane's width and height property to calculate the viewable area it is including the scrollbars so gives you the wrong answer.  
  
Call Get GetVisibleRect to get a B4XRect for the coordinates of the visible area of the Scrollpane.  
  
  
  

```B4X
Sub GetVisibleRect(SC As ScrollPane) As B4XRect  
    Dim R As B4XRect  
    R.Initialize(CalcHOffSet(SC),CalcVOffSet(SC),CalcHOffSet(SC)+ GetViewPortWidth(SC), CalcVOffSet(SC) + GetViewPortHeight(SC))  
    Return R  
     
     
End Sub  
  
Sub GetViewPortHeight(SC As ScrollPane) As Double  
    Dim JOSC As JavaObject = SC  
    Return JOSC.RunMethodJO("getViewportBounds",Null).RunMethod("getHeight",Null)  
     
     
End Sub  
  
Sub GetViewPortWidth(SC As ScrollPane) As Double  
    Dim JOSC As JavaObject = SC  
    Return JOSC.RunMethodJO("getViewportBounds",Null).RunMethod("getWidth",Null)  
     
End Sub  
  
  
Sub CalcVOffSet(SC As ScrollPane) As Double  
  
    Dim JOSC As JavaObject = SC  
    Dim VMin As Double = JOSC.RunMethod("getVmin",Null)  
    Dim VMax As  Double  = JOSC.RunMethod("getVmax",Null)  
    Dim VSCroll As  Double = JOSC.RunMethod("getVvalue",Null)  
    Dim ContentHeight As Double = JOSC.RunMethodJO("getContent",Null).RunMethodJO("getLayoutBounds",Null).RunMethod("getHeight",Null)  
    Dim ViewPortHeight As Double = GetViewPortHeight(SC)  
      
    Return Max(0,  ContentHeight - ViewPortHeight) * (VSCroll - VMin) / (VMax - VMin)  
End Sub  
  
Sub CalcHOffSet(SC As ScrollPane) As Double  
    Dim JOSC As JavaObject = SC  
    Dim HMin As Double = JOSC.RunMethod("getHmin",Null)  
    Dim HMax As  Double  = JOSC.RunMethod("getHmax",Null)  
    Dim HSCroll As  Double = JOSC.RunMethod("getHvalue",Null)  
    Dim ContentHeight As Double = JOSC.RunMethodJO("getContent",Null).RunMethodJO("getLayoutBounds",Null).RunMethod("getWidth",Null)  
    Dim ViewPortWidth As Double = GetViewPortWidth(SC)  
    Return Max(0,  ContentHeight - ViewPortWidth) * (HSCroll - HMin) / (HMax - HMin)  
End Sub
```