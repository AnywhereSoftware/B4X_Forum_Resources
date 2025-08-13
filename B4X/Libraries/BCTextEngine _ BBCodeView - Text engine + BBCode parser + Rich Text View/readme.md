###  BCTextEngine / BBCodeView - Text engine + BBCode parser + Rich Text View by Erel
### 12/31/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/106207/)

Be open minded.  
  
![](https://www.b4x.com/basic4android/images/i_view64_p9fVifsimf.png)  
  
This is a cross platform library with several features:  
  
- Text drawing engine.  
- Text layout engine.  
- BBCode parser.  
- Two custom views that connect everything:  
 BBCodeView - multiline, scrollable with support for embedded views.  
 BBLabel - lightweight label.  
- NEW: BBScrollingLabel: <https://www.b4x.com/android/forum/threads/b4x-bbscrollinglabel-rich-text-scrolling-label.114310/>  
  
![](https://www.b4x.com/basic4android/images/F0DYcnZwgV.gif)  
  
  
The library and the code inside can be used for all kinds of things related to text. You can for example use it as an alternative to CSBuilder where you have more control over the text drawing.  
  
I will explain the main use case of BBCodeView.  
Our layout is usually made of boxes. The boxes positions and sizes can change, however no matter what, the content is split into boxes.  
  
With BBCodeView, text is the king. The text layout engine builds the layout based on the text. This is similar to html code. However, unlike html where you need to run a monstrous engine (WebView) inside your app, here there is no additional engine. BBCodeView is made of a ScrollView with an ImageView and additional views that you can add.  
This means that you don't need to anything special to interact with the internal views and you can add any view you like inside the text.  
  
Lets start with a simple example:  
1. Create a layout with BBCodeView.  
2. Initialize a BCTextEngine object. This should be called after the BBCodeViews and BBLabels were added.  

```B4X
TextEngine.Initialize (Activity)  
BBCodeView1.Text = $"Hello world!"$
```

  
  
You can use all kinds of BBCode tags to format the text and add non-text elements inside.  

```B4X
BBCodeView1.Text = $"Hello world!"$
```

  
  
![](https://www.b4x.com/basic4android/images/java_Cv9hBtIpbV.png)  
  
The supported tags are:  
[Plain]  
 **- Bold.  
 - Underline.  
 [- Clickable link. The LinkClicked event is raised when the content is clicked. Examples:  
<world!>  
[hello](https://www.b4x.com)  
[Plain] - prevents the internal text from being parsed.  
 - Changes the text color. Example:  
Hello  
![]( - Adds an image. Can be local or remote. Examples:<br /><br /><img src=)]( - Clickable link. The LinkClicked event is raised when the content is clicked. Examples:<br /><a rel=%22nofollow%22 href=%22world!%22>world!</a><br /><a rel=%22nofollow%22 href=%22https://www.b4x.com%22>hello</a><br />[Plain] - prevents the internal text from being parsed.<br /> - Changes the text color. Example:<br /><span style=%22color:#ff00ff;%22>Hello</span><br /><img src=' - Adds an image. Can be local or remote. Examples:<br /><br /><img src=' 'width and height are optional for local images. Omit the dir parameter for assets files.<br /><img src=' 'width and height are required for remote images.<br />[Vertical] - Changes the vertical offset. Example:<br />[Vertical=30]aaa[/Vertical]<br />[TextSize] - Changes the text size. Example: [TextSize=25]asdasd[/TextSize]<br />[Alignment] - Changes the horizontal alignment. One of the following values: Left, Right or Center.<br />Example: [Alignment=Center]Title[/Alignment]<br />[View] - Adds a custom view. Example:<br />[View=Btn1/]<br />[/Plain]<br />[Span] -  Creates an unbreakable section. Supports the following keys: MinWidth and Alignment. You can use it to create columns (see the example).<br />[plain]<br />[INDENT]- Indention level. Example:<br />[INDENT=2]<br /><ul><li>- Creates an ordered or unordered list. See the attached examples.</li>[FontAwesome] and [MaterialIcons] - Inserts a FontAwesome or Material Icons icon. Example:
[FontAwesome=0xF034/]
Supports the following keys: Size (text size) and Vertical (vertical offset).
[E] - Adds a sequence of characters that will be treated as a single complex character. Useful for complex emojis such as flags. Example
[E=??/]
[Font] - Sets a custom font that was previously added to TextEngine.CustomFonts. See this post for more information: <a rel=%22nofollow%22 href=%22https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/post-702304%22>https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/post-702304</a>
[a] - Adds an anchor. Used with BBCodeView.ScrollToAnchor. See example: <a rel=%22nofollow%22 href=%22https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/post-938548%22>https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/post-938548</a>
[/plain]
View, Img, FontAwesome and MaterialIcons tags should end with /].
You can also use vertical as a key inside View and Img tags.

Adding views is done in two steps:
1. Create a view and add it to BBCodeView.Views map.
2. Add it with the View tag.

<pre><code><br />Dim btn As Button<br />btn.Initialize("btn")<br />btn.Text = "Click!"<br />btn.SetLayoutAnimated(0, 0, 0, 100dip, 40dip)<br />BBCodeView1.Views.Put("btn", btn)<br />BBCodeView1.Text = $"Lets add a button here [View=btn Vertical=10/]. Do you see it?"$<br /></code></pre>

<img src='https://www.b4x.com/basic4android/images/java_ROTR5mX3ls.png'>

The cross platform b4xlib is attached. Note that it depends on<a rel=%22nofollow%22 href=%22https://www.b4x.com/android/forum/attachments/jbitmapcreator-zip.80211/%22> jBitmapCreator v4.71</a>+ which is available in <a rel=%22nofollow%22 href=%22https://www.b4x.com/android/forum/threads/106461/#content%22>B4J v7.50</a> and <a rel=%22nofollow%22 href=%22https://www.b4x.com/android/forum/threads/106451/#content%22>B4i v5.80</a>.
B4A library: <a rel=%22nofollow%22 href=%22https://www.b4x.com/android/forum/attachments/bitmapcreator-zip.81067/%22>https://www.b4x.com/android/forum/attachments/bitmapcreator-zip.81067/</a> (copy to the internal folder).
It is recommended to use Java 9+ on B4J. You will get better results on high DPI screens.

(The example adds a CustomListView to the layout. This can cause an issue in B4A if the layout becomes scrollable.)



<strong>Updates</strong>

- v1.96 - Fixes an issue caused by rounding errors related to the device scale calculations. Mainly relevant to B4i.
- v1.95 - New anchors feature: <a rel=%22nofollow%22 href=%22https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/post-938548%22>https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/post-938548</a>
- v1.93 - Fix issues with Arabic scripts.
- v1.92 - MinGapBetweenLines field is now public. It can be used to make the lines more dense.
- v1.91 - Fixes several issues with Arabic languages.
- v1.90 - Fixes an issue where auto detect url stops working after the view is resized.
- v1.89 - Adds support for Arabic. Make sure to set BBCodeView/BBLabel.RTL = True. This version requires B4A 11.0+, B4i 7.5+ or B4J 9.1+
- v1.88 - Fixes an issue with MaterialIcons tag.
- v1.87 - BBCodeView - Links are underlined automatically when the user moves the cursor or presses on the link. Note that it is only enabled when lazy loading is enabled.
Example was updated and it is now based on B4XPages. B4i - There is an important inline OBJC code in example that you should add to prevent unwanted URL clicks when the user scrolls the BBCodeView.
- v1.86 - Initial support for right to left languages: <a rel=%22nofollow%22 href=%22https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/post-779309%22>https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/post-779309</a>
- v1.84 - Fixes bugs related to handling of complex characters.
- v1.81 - Adds an option for asynchronous drawing. This is an advanced option. You can see an usage example in the <a rel=%22nofollow%22 href=%22https://www.b4x.com/android/forum/threads/b4x-b4xpages-pleroma-mastodon-client-step-1.119426/#post-747319%22>Pleroma </a>client.
- v1.80 - Fixes several bugs. Allows disabling word wrap in BBLabel.
- v1.77 - Fixes issue with bold fonts in iOS 13 and exposes BBCodeView_BaseResize, it s is needed in B4A when we want to resize BBCodeView.
- v1.76 - New VowelsCodePoints set. Usage example: <a rel=%22nofollow%22 href=%22https://www.b4x.com/android/forum/threads/b4x-bctextengine-unicode-problem.117893/post-737764%22>https://www.b4x.com/android/forum/threads/b4x-bctextengine-unicode-problem.117893/post-737764</a>
               Fix for wrapping issue with indented lines.
- v1.75 - B4i only - fixes an issue where wrong colors can appear.
- v1.74 - Fixes an issue with non-breaking white space.
- v1.73 - Adds support for kerning - dynamic spacing between characters based on the specific characters. Example here: <a rel=%22nofollow%22 href=%22https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/post-711296%22>https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/post-711296</a>
Kerning is enabled by default. It has some overhead. In most cases it shouldn't be significant. You can disable kerning with TextEngine.KerningEnabled = False.
- v1.72 - BCTextRun.Text field was added back. Fixed issue where setting BBLabel.Text to an empty string didn't remove the text.
- v1.71 - New Font tag: <a rel=%22nofollow%22 href=%22https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/post-702304%22>https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/post-702304</a>
- v1.70 - Adds support for complex characters such as emojis. Most emojis can be added directly and the text engine will recognize the sequences automatically. In some cases such as with flags you should use the new 'E' tag to add the emoji. See the examples.
- v1.65 - Fixes an issue where the designer text color was ignored. The set text color is used as the default color.
New BBLabel.DisableResizeEvent field. This is used by BCToast library which removes the internal ImageView from BBLabel after it is drawn.

- v1.64 - New property: WordBoundariesThatCanConnectToPrevWord - sets the split characters that will be connected to the previous word. Default value is ".,:".
- BBCodeDesigner v1.00 - B4J utility that helps with writing and testing BBCode strings:

<img src='https://www.b4x.com/basic4android/images/java_olBorAQt9N.png'>

1.63 - Views tags support the width and height properties.
1.62 - Adds support for Justify alignment.
1.61 - New BBCodeView.ExternalRuns property. This allows setting the styled text directly. Usage example: <a rel=%22nofollow%22 href=%22https://www.b4x.com/android/forum/threads/b4x-bctextengine-parser-b4x-code-highlighter.109308/%22>https://www.b4x.com/android/forum/threads/b4x-bctextengine-parser-b4x-code-highlighter.109308/</a>

1.60 - Important update. Adds support for "lazy loading". In this mode the text is only drawn when it becomes visible and is removed when it becomes invisible.
With this change it is possible to use BBCodeView to show text made of thousands of lines.
Lazy loading is enabled by default. It is set in the designer. Uncheck this option if you want to get a single bitmap with all the text.

1.58 - Removes the background BitmapCreator that is not used by BBCode parser.
1.57 - BCTextEngine.WordBoundaries is now a public variable. Its default value is: "&*+-/.<>=\' ,:{}" & TAB & CRLF & Chr(13)
You can modify it and change the list of characters that are treated as separators.
1.56 - The '(' character is no longer considered a separator character.
1.55 - Underline tag accepts Color and Thickness parameters:

<img src='https://www.b4x.com/basic4android/images/java_4JJvdNeT0E.png'>

       - Named colors are supported. Same names as available with XUI.
1.52 - Fixes a bug with images in BBLabels.
1.51 - Changes the way the BBLabel ImageView is set to make it possible to measure it.
1.50 - Large update. New BBLabel custom view. This is the lightweight version of BBCodeView. It is not scrollable and doesn't handle events.
- TextEngine.Initialize expects the parent view. It then searches the views tree for BB views and sets the engine. It is no longer needed to set the TextEngine for each view.
- New MaterialIcons and FontAwesome tags.
- The text can be set with the designer.
The examples were updated.

1.06 - New Indent and List tags.

<img src='https://www.b4x.com/basic4android/images/firefox_VF1FJGFOeE.png'>

See the examples.

1.05 - New Span tag. The Span tag creates an unbreakable content. It supports the following keys: MinWidth and Alignment.
You can use it to create tables:

<img src='https://www.b4x.com/basic4android/images/firefox_595n6GLQ5W.png'>

Width dimensions can be set with %x units. The percentage is relative to BBCodeView width.

1.03 - Fixes a drawing issue.
1.02 - New BBCodeView.Padding field. Can be used to change the padding. Default value is:
<pre><code><br />'left, top, right, bottom<br />If xui.IsB4J Then<br />   Padding.Initialize(5dip, 5dip, 20dip, 5dip) 'leaves space for the scroll bar.<br />Else<br />   Padding.Initialize(5dip, 5dip, 5dip, 5dip)<br />End If<br /></code></pre>

1.01 - Fixes a compilation issue in release mode.
         The Img.Dir parameter is not needed when loading files from the assets folder.

Another example with a bit more logic is available here: <a rel=%22nofollow%22 href=%22https://www.b4x.com/android/forum/threads/b4x-beta-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/page-2#post-665369%22>https://www.b4x.com/android/forum/threads/b4x-beta-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/page-2#post-665369</a>

<strong> BCTextEngine is an internal library. </strong></ul>'>'>'>)**