### [B4x] B4xTooltip_DSE by stevel05
### 11/12/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/172531/)

This is a utility to allow setting most of the tooltip settings from within the designer script. It uses Json entered into the Tooltip field which is parsed and applied in the designer script.  
  
I started with good intentions of making this Android as well, until I saw what little Android offers in terms of tooltips. I did include the available code to add tooltips, but because of the way they work and limited functionality, it would be preferable to use the BCTooltip library for Android. There is no Json for the Android lib, it's just Text and no tuning.  
  
For Android just pass the text in the designer:  

```B4X
B4xTooltip_DSE.SetTooltip("Test",Button1)
```

  
  
So in B4j, this is an example of a full configuration file which can be added to the Tooltip field of the target node in the designer:  

```B4X
{  
    Tooltip : {  
  
  
        Font : {  
            FontFamily : "Arial",  
            FontSize : 12,  
            Bold : "False",  
            Italic : "True"  
        },  
  
        ShowDelay : 100,  
        HideDelay : 100,  
        ShowDuration : 2000,  
  
        _Comment : "TextAlignment can be one of CENTER, JUSTIFY, LEFT, RIGHT",  
        TextAlignment : "CENTER",  
  
        -Comment : "'OverrunStyle can be one of CENTER_ELLIPSIS, CENTER_WORD_ELLIPSIS, CLIP, ELLIPSIS, LEADING_ELLIPSIS, LEADING_WORD_ELLIPSIS, WORD_ELLIPSIS",  
        TextOverrun : "ELLIPSIS",  
  
        _Comment : "ContentDisplay can be one of BOTTOM, CENTER, GRAPHIC_ONLY, LEFT, RIGHT, TEXT_ONLY, TOP",  
        ContentDisplay : "TOP",  
  
        Graphic : {  
            Graphic : "Pane1",  
            GraphicTextGap : 10  
        },  
        Height: 150,  
        Width : 100,  
        WrapText : "True",  
  
        Style :     "-fx-border-color:white;  
                     -fx-border-width:1;"  
   
    }  
}
```

  
  
Then pass the views on which you have a configuration to the designer script in the designer:  
  

```B4X
B4xTooltip_DSE.SetTooltipFromJson(Button1, Button2, Button3, Button5, Button4, Button6)
```

  
  
As you can see there are a few fields available. You do no need to specify any that you don't want to change. The simplest would be  

```B4X
{  
  
    Tooltip: {  
        Text : "This is a long Tooltip"  
    }  
   
}
```

  
  
But would add nothing to just typing the text in the field.  
  
The Graphic can be any node, add it to the designer and it will be removed when the script runs. Each script must have separate graphics if you want to add them to more than 1 Tooltip.  
  
Let me know if there is anything you think I have missed or you would like added.  
  
B4xLib and Project are attached.  
  
Let me know how you get on with it.  
  
Update to Version 0.2:  

- Added case for TextOverrun
- A bit of error reporting on unrecognized keys