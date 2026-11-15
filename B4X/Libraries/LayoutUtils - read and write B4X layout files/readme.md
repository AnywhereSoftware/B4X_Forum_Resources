###  LayoutUtils - read and write B4X layout files by Erel
### 11/09/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/172516/)

\*\*\* Work in progress. The API is not final \*\*\*  
  
BalConvterer and JsonLayouts (<https://www.b4x.com/android/forum/threads/b4x-jsonlayouts-synchronize-json-and-binary-layouts.167398/#content>) are tools that convert the binary layout files to json format. They retain the structure exactly as in the binary file. LayoutUtils evolved from these tools and provides a higher level representation of the layout data. It can be used to manipulate layout files. As layout files are loaded from the assets folder, and the assets folder is read-only, it is not possible to manipulate layouts at runtime (maybe in the future…). The expected usage of this tool is as a macro or custom build action.   
  
For example:  

```B4X
Layout.Initialize.ReadFromBinary(File.DirApp, "..\Files\MainPage.bjl") 'initialize and load the layout.  
Dim Button1Layout As BLView = Layout.ViewsMap.Get("Button1") 'get a BLView from the layout  
Button1Layout.ExtraProperties.Put("text", Layout.CreateProperty("new text: " & DateTime.Time(DateTime.Now))) 'change its property  
Dim vv As BLVariantValues = Button1Layout.VariantValues.Get(0) 'number of VariantValues = number of layout variants  
vv.HAnchor = Layout.ANCHOR_BOTH  
vv.X1 = 5 'left (don't use dip here)  
vv.X2 = 5 'right  
Layout.WriteToBinary(File.DirApp, "..\Files\MainPage.bjl") 'write back
```

  
  
There is a useful Describe method that prints the layout content. CodeBundle will be updated to use this output instead of the low level json output which is significantly more verbose and less clear.