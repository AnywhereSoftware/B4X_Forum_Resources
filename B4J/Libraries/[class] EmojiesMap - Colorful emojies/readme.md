### [class] EmojiesMap - Colorful emojies by Erel
### 03/10/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/139055/)

![](https://www.b4x.com/android/forum/attachments/126510)  
  
Usage:  

```B4X
BBLabel1.ParseData.Views.Initialize  
BBLabel2.ParseData.Views.Initialize  
Dim s As String = $"[TextSize=20]Label with colorful emojies: ? ?? ❤? ?‍? ??:)[/TextSize]"$  
BBLabel1.Text = Emojies.ProcessText(s, BBLabel1.ParseData.Views, 32dip, 10)  
s = $"Using hex code - this is a single emoji made of 4 codepoints: ${Emojies.CodePointsToString(Array As Int(0x1f468, 0x1f469, 0x1f466, 0x1f466))}"$  
BBLabel2.Text = Emojies.ProcessText(s, BBLabel2.ParseData.Views, 64dip, 20)
```

  
  
Now for the explanation:  
The JavaFX text rendering engine doesn't support glyphs with multiple colors. Emojies are rendered in quite an ugly way:  
  
![](https://www.b4x.com/android/forum/attachments/126511)  
EmojiesMap workarounds this limitation using a large set of images. I've used EmojiTwo: <https://github.com/EmojiTwo/emojitwo>, though once you understand the process you can use other sets of images including custom images.  
The first step is to build a map that maps the "hex values" to the images.  
The map is then serialized using B4XSerializator and the generated data file is added to the shared files folder.  
It is done by calling the CreateEmojies sub inside the class. You don't need to do it unless you want to replace the images set.  
  
The next step is to process the string, find matching emojies and replace them with IMG tags.  
And that's it.  
  
This is a B4J class, it should be trivial to make it cross platform. This specific use case is not relevant for B4A / B4i as the mobile devices do render the emojies properly.  
  
The example project with the class and the data file is available here: <https://www.b4x.com/b4j/files/EmojiesMap.zip>