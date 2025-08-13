### RichEditor view by somed3v3loper
### 12/04/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/66319/)

Hello all ,  
  
A wrapper for this library <https://github.com/wasabeef/richeditor-android>  
  
  
**SMMRichEditor  
Author:** SMM  
**Version:** 0.05  

- **SMMRichEditor**
Events:

- **\_textchanged** (new As String)
- Fields:
- **ba As BA**
- Methods:
- **AddToParent** (Parent As ViewGroup, left As Int, top As Int, width As Int, height As Int)
- **BringToFront**
- **DesignerCreateView** (base As PanelWrapper, lw As LabelWrapper, props As Map)
- **Initialize** (EventName As String)
- **Invalidate**
- **Invalidate2** (arg0 As Rect)
- **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **IsInitialized As Boolean**
- **RemoveView**
- **RequestFocus As Boolean**
- **SendToBack**
- **SetBackgroundImage** (arg0 As Bitmap)
- **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
- **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
- **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)
- **clearFocusEditor**
- **focusEditor**
- **insertImage** (path As String, alt As String)
- **insertLink** (url As String, text As String)
- **insertTodo**
- **loadCSS** (cssFile As String)
- **redo**
- **removeFormat**
- **setAlignCenter**
- **setAlignLeft**
- **setAlignRight**
- **setBlockquote**
- **setBold**
- **setBullets**
- **setIndent**
- **setItalic**
- **setNumbers**
- **setOutdent**
- **setPadding** (left As Int, top As Int, width As Int, height As Int)
- **setStrikeThrough**
- **setSubscript**
- **setSuperscript**
- **setUnderline**
- **undo**
- Properties:
- **Background As Drawable**
- **Color As Int** *[write only]*
- **EditorBackgroundColor As Int** *[write only]*
- **EditorFontColor As Int** *[write only]*
- **EditorFontSize As Int** *[write only]*
- **EditorHeight As Int** *[write only]*
- **Enabled As Boolean**
- **FontSize As Int** *[write only]*
Font size should have a value between 1-7- **Heading As Int** *[write only]*
- **Height As Int**
- **Html As String**
- **Left As Int**
- **Padding()() As Int**
- **Parent As Object** *[read only]*
- **Placeholder As String** *[write only]*
- **Tag As Object**
- **TextBackgroundColor As Int** *[write only]*
- **TextColor As Int** *[write only]*
- **Top As Int**
- **Visible As Boolean**
- **Width As Int**

  
  
**Note : You have to add files in CopytoAssetsFolder.zip to your project's Assets (Add to IDE File tab)**  
  
  
I do not understand html images very well :D but to insert from Assets use this line  
  

```B4X
re.insertImage("file:///android_asset"&"/txt.png","text")
```

re is SMMRichEditor  
  
**V 2 adds a method (re.Html) to setting or getting HTML   
V 0.03 adds TextColor (not tested) requested in post #25  
  
V0.04 added loadCSS(String cssFile) , setBullets() , setNumbers(), focusEditor() , clearFocusEditor()**   
  
**V0.05 (I have updated library references above :))**  
  
0.16 I think I wrapped all available methods :)   
There is an ugly sample attached now Sorry for that it is just to get you started