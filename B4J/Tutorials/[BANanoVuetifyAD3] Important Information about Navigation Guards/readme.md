### [BANanoVuetifyAD3] Important Information about Navigation Guards by Mashiane
### 01/20/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/137797/)

Hi there  
  
These are primarily used to guard navigations either by redirecting it or cancelling it.  
  
**Global Navigation Guards**  
  
You have **beforeEach** (page) and **afterEach** (page), these can be placed in **pgIndex.**  
  

```B4X
'before each page is rendered  
Sub beforeEach(boTo As Map, boFrom As Map, boNext As BANanoObject)   'ignoreDeadCode  
    Log("beforeEach…")  
    vuetify.Loading(True)  
    Dim sToPage As String = boTo.Get("name")  
    Log(boTo)  
    Log(boFrom)  
    'the page we are going to  
    'vuetify.SaveRoute(boTo, False)  
    'check authentication  
    'If vuetify.Authenticated = False Then  
        'user is not authenticated, go to login page  
    '    vuetify.NavigateToNext(boNext, "login")  
    '    Return  
    'End If  
    'continue navigation  
    vuetify.NavigateToNext(boNext, "")  
End Sub
```

  
  
You can get the name the page the app will navigate to and depending on that process whatever command.  
  

```B4X
'after each page is rendered  
Sub afterEach(boTo As Map, boFrom As Map)   'ignoreDeadCode  
    vuetify.Loading(False)  
End Sub
```

  
  
For example, above we are saying, before each page, show the loader and afterEach page, hide the loader.  
  
***NB: If you use global navigation guards in pgIndex, there is no need to have local navigation guards.***  
  
**Local Navigation Guards**  
  
You have **beforeEnter.** This called before the **beforeCreate** Life Cycle Event. In this example we show a loader and hide it on mounted. These are placed per route component page, ie. class with AddRouter call  
  

```B4X
Sub beforeEnter(boTo As Map, boFrom As Map, boNext As BANanoObject)   'ignoreDeadCode  
    vuetify.Loading(True)  
    'the page we are going to  
    'vuetify.SaveRoute(boTo, False)  
    'check authentication  
    'If vuetify.Authenticated = False Then  
    'user is not authenticated, go to login page  
    '    vuetify.NavigateToNext(boNext, "login")  
    '    Return  
    'End If  
    'continue navigation  
    vuetify.NavigateToNext(boNext, "")  
End Sub  
  
Sub mounted  
    'hide the loader  
    vuetify.Loading(False)  
End Sub
```

  
  
For more details, see the Kitchen Sink.