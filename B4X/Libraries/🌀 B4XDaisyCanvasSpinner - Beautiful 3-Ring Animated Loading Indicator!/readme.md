###  🌀 B4XDaisyCanvasSpinner - Beautiful 3-Ring Animated Loading Indicator! by Mashiane
### 03/04/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170490/)

Hi Fam  
  
If you are looking to replace standard OS progress bars with something modern, fluid, and cross-platform, look no further. I'd like to introduce the **B4XDaisyCanvasSpinner**—a sleek, animated loading spinner built entirely from scratch using B4XCanvas and B4XPath. We have set the opacity of our DaisyOverlay to 0 for this and put the loader on top.  
  
![](https://www.b4x.com/android/forum/attachments/170380) ![](https://www.b4x.com/android/forum/attachments/170381)  
  
Inspired by popular CSS web loaders (specifically loader-1.css), this component features three concentric colored rings that spin smoothly at different speeds using a single Timer. Because it's purely drawn using the canvas, it is completely cross-platform for B4A, B4i, and B4J!  
  
**✨ Key Features:**  

- **Fully Customizable:** Easily change the Size, Primary Color, Secondary Color, Tertiary Color, and Stroke Width directly through the Designer Properties or programmatically.
- **Smart Architecture:** Utilizes three transparent overlay panels to ensure 100% perfect concentricity and smooth, independent rotation.
- **Easy Integration:** Comes with helpful methods like AttachTo (to instantly expand and center over a target view) and AddToParent for fine-grained coordinate placement.

**🛠️ Simple Usage Example:** You can add it via the Visual Designer, or easily instantiate it in code.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private spinner As B4XDaisyCanvasSpinner ' Declare the spinner  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.Color = xui.Color_White  
      
    ' Initialize the spinner  
    spinner.Initialize(Me, "spinner")  
      
    ' Customize colors and stroke programmatically  
    spinner.Color1 = 0xFF3498DB ' Primary Blue  
    spinner.Color2 = 0xFFDB213A ' Secondary Red  
    spinner.Color3 = 0xFFDEC52D ' Tertiary Yellow  
    spinner.StrokeWidth = 3dip  
      
    ' Attach the spinner full-screen to the given view (e.g., an overlay panel or the Root)  
    spinner.AttachTo(Root)   
      
    ' Show the spinner  
    spinner.Show  
End Sub  
  
Private Sub StopLoading  
    ' Hide the spinner when your background task finishes  
    spinner.Hide   
End Sub
```

  
  
Enjoy creating stunning and responsive UIs, and let me know your thoughts or suggestions in the thread below!  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>  
  
**Origin Story…**  
  
Whilst our component is purely native based on B4XCanvas… If you have been using SithasoDaisy5, you will remember this from the webloader we use. So I wanted to prove to myself this can be done natively too. This is inspired by this loader… you might remember on ABM, has been my favourate loader eversince.  
  

```B4X
/*Loader 1- Spinning */  
  
#loader-1 #loader{  
    position: relative;  
    left: 50%;  
    top: 50%;  
    height: 20vw;  
    width: 20vw;  
    margin: -10vw 0 0 -10vw;   
    border: 3px solid transparent;  
    border-top-color: #3498db;  
    border-bottom-color: #3498db;   
    border-radius: 50%;  
    z-index: 2;  
    -webkit-animation: spin 2s linear infinite;  
    -moz-animation: spin 2s linear infinite;  
    -o-animation: spin 2s linear infinite;  
    animation: spin 2s linear infinite;  
}  
#loader-1 #loader:before{  
    content: "";  
    position: absolute;  
    top:2%;  
    bottom: 2%;  
    left: 2%;  
    right: 2%;   
    border: 3px solid transparent;  
    z-index: 2;  
    border-top-color: #db213a;  
    border-radius: 50%;  
    -webkit-animation: spin 3s linear infinite;  
    -moz-animation: spin 3s linear infinite;  
    -o-animation: spin 3s linear infinite;  
    animation: spin 3s linear infinite;  
}  
#loader-1 #loader:after{  
    content: "";  
    position: absolute;  
    top:5%;  
    bottom: 5%;  
    left: 5%;  
    right: 5%;   
    border: 3px solid transparent;  
    border-top-color: #dec52d;  
    z-index: 2;  
    border-radius: 50%;  
    -webkit-animation: spin 1.5s linear infinite;  
    -moz-animation: spin 1.5s linear infinite;  
    -o-animation: spin 1.5s linear infinite;  
    animation: spin 1.5s linear infinite;  
}  
/*Keyframes for spin animation */  
@-webkit-keyframes spin {  
    0%   {  
        -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */  
        -ms-transform: rotate(0deg);  /* IE 9 */  
        transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */  
    }  
    50% {  
        -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */  
        -ms-transform: rotate(360deg);  /* IE 9 */  
        transform: rotate(180deg);  /* Firefox 16+, IE 10+, Opera */  
    }  
    100% {  
        -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */  
        -ms-transform: rotate(360deg);  /* IE 9 */  
        transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */  
    }  
}  
  
@-moz-keyframes spin {  
    0%   {  
        -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */  
        -ms-transform: rotate(0deg);  /* IE 9 */  
        transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */  
    }  
    50% {  
        -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */  
        -ms-transform: rotate(360deg);  /* IE 9 */  
        transform: rotate(180deg);  /* Firefox 16+, IE 10+, Opera */  
    }  
    100% {  
        -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */  
        -ms-transform: rotate(360deg);  /* IE 9 */  
        transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */  
    }  
}  
@-o-keyframes spin {  
    0%   {  
        -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */  
        -ms-transform: rotate(0deg);  /* IE 9 */  
        transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */  
    }  
    50% {  
        -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */  
        -ms-transform: rotate(360deg);  /* IE 9 */  
        transform: rotate(180deg);  /* Firefox 16+, IE 10+, Opera */  
    }  
    100% {  
        -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */  
        -ms-transform: rotate(360deg);  /* IE 9 */  
        transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */  
    }  
}  
@keyframes spin {  
    0%   {  
        -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */  
        -ms-transform: rotate(0deg);  /* IE 9 */  
        transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */  
    }  
    50% {  
        -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */  
        -ms-transform: rotate(360deg);  /* IE 9 */  
        transform: rotate(180deg);  /* Firefox 16+, IE 10+, Opera */  
    }  
    100% {  
        -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */  
        -ms-transform: rotate(360deg);  /* IE 9 */  
        transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */  
    }  
}
```

  
  
So yeah, you can port CSS & HTML to a working native component. Nothing is really impossible.  
  
Yeah ! #JohnWickAccent