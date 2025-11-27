### iOS 26.1 Liquid Glass by Alex_197
### 11/21/2025
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/169402/)

Hi all.  
  
To all who don't like iOS 26.1 liquid glass - add these 2 lines into Main. It will turn it off.  

```B4X
'iOS26.1  
    #PlistExtra: <key>UIDesignRequiresCompatibility</key><true/>  
    #PlistExtra: <key>UIUserInterfaceStyle</key><string>Light</string>
```