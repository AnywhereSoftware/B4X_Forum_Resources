### Elevation Color by Blueforcer
### 03/24/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/139365/)

![](https://www.b4x.com/android/forum/attachments/126950)  
This extends Erels [XUI shadow function](https://www.b4x.com/android/forum/threads/b4x-xui-elevation-shadow.135767/#post-858848) to use the color parameter also in B4A, by using  
setOutlineAmbientShadowColor and setOutlineSpotShadowColor  
Works since API 28  
  

```B4X
Public Sub SetShadow (View As B4XView, Offset As Double, Color As Int)  
    #if B4J  
    Dim DropShadow As JavaObject  
    'You might prefer to ignore panels as the shadow is different.  
    'If View Is Pane Then Return  
    DropShadow.InitializeNewInstance(IIf(View Is Pane, "javafx.scene.effect.InnerShadow", "javafx.scene.effect.DropShadow"), Null)  
    DropShadow.RunMethod("setOffsetX", Array(Offset))  
    DropShadow.RunMethod("setOffsetY", Array(Offset))  
    DropShadow.RunMethod("setRadius", Array(Offset))  
    Dim fx As JFX  
    DropShadow.RunMethod("setColor", Array(fx.Colors.From32Bit(Color)))  
    View.As(JavaObject).RunMethod("setEffect", Array(DropShadow))  
    #Else If B4A  
    Offset = Offset * 2  
    View.As(JavaObject).RunMethod("setElevation", Array(Offset.As(Float)))  
    View.As(JavaObject).RunMethod("setOutlineAmbientShadowColor",Array(Color ))  
    View.As(JavaObject).RunMethod("setOutlineSpotShadowColor",Array(Color ))  
    #Else If B4i  
    View.As(View).SetShadow(Color, Offset, Offset, 0.5, False)  
    #End If  
End Sub
```

  
  
To set the alpha value of the shadow you need to add it to your manifest:  
the default values in the Material and AppCompat themes as of API 28 are 0.039 (3.9%) for ambientShadowAlpha and 0.19 (19%) for spotShadowAlpha  
  

```B4X
SetApplicationAttribute(android:theme, "@style/MyAppTheme")  
  
CreateResource(values-v20, theme.xml,  
<resources>  
    <style name="MyAppTheme" parent="@android:style/Theme.Material.Light">  
        <item name="android:ambientShadowAlpha">0.1</item>  
        <item name="android:spotShadowAlpha">0.4</item>  
    </style></resources>)
```