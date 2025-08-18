### [BANanoVuetifyAD3] Improving Perceived Performance on 7.29+ by Mashiane
### 01/20/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/137742/)

Hi there  
  
I'm not going to kid you. Before BVAD3 shows the first page, it takes a lot of time to build and show the app e.g. calling all those .Initialize subs in each of the route pages, loading layouts, calling bindstates, checking all SubExists and all that etc etc.  
  
> Perceived performance measures how fast a user ***thinks*** your mobile app is.

  
So lets change this about BVAD3.  
  
1. In Main > AppStart, add this code  
  

```B4X
BANano.Header.OnDOMContentLoaded = BANanoShared.DOMContentLoaded
```

  
  
<https://developer.mozilla.org/en-US/docs/Web/API/Window/DOMContentLoaded_event>  
  
2. In each of your route pages, ensure that at least this code exists..  
  

```B4X
Sub beforeEnter(boTo As Map, boFrom As Map, boNext As BANanoObject)   'ignoreDeadCode  
    'show a loader  
    vuetify.Loading(True)  
    'continue navigating to this page  
    vuetify.NavigateToNext(boNext, "")  
End Sub  
  
Sub mounted   'ignoreDeadCode  
    'hide the loader  
    vuetify.Loading(False)  
End Sub
```

  
  
<https://router.vuejs.org/guide/advanced/navigation-guards.html>  
  
This has the effect of showing this loader before each page is shown, from the onset your browser page opens until your StartPage i.e root / is shown.  
  
That's it!!  
  
**NB: Any code being BANanoShared.AddLoader, BANAnoShared.ShowLoader, BANanoShared.HideLoader SHOULD BE REMOVED!**  
  
  
![](https://www.b4x.com/android/forum/attachments/124425)  
  
To **understand what happens**, here is the snippet.  
  

```B4X
'code for DOMContentLoaded  
Sub DOMContentLoaded As String  
    Dim str As String = $"var body = document.getElementById("body");  
    var loader1 = document.createElement("div");  
    loader1.setAttribute("id", "loader-1")  
    loader1.style.cssText = 'display:block;position:fixed;width:100%;height:100%;z-index:999999';  
    var loader = document.createElement("div");  
    loader.setAttribute("id", "loader")  
    loader1.appendChild(loader);  
    body.appendChild(loader1);"$  
    Return str  
End Sub  
  
Sub ShowLoader  
    Dim lEL As BANanoElement  
    lEL.Initialize("#loader-1")  
    Dim mStyle As Map = CreateMap()  
    mStyle.Put("display", "block")  
    lEL.SetStyle(BANano.ToJson(mStyle))  
End Sub  
  
Sub HideLoader  
    Dim lEL As BANanoElement  
    lEL.Initialize("#loader-1")  
    Dim mStyle As Map = CreateMap()  
    mStyle.Put("display", "none")  
    lEL.SetStyle(BANano.ToJson(mStyle))  
End Sub
```

  
  
And you will need this css. This can be saved in a file.  
  

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

  
  
Have fun!