### CharSequence / TagCSBuilder by Quandalle
### 01/27/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/127015/)

With **CSBuilder** you can format (color, size,…) a string that will be usable for most of the methods and properties of B4A objects that generally accept a String type to display.  
(see Erel’s Tutorial describing CsBuilder : <https://www.b4x.com/android/forum/threads/charsequence-csbuilder-tutorial.76226/#content> )  
  
For example the display of a label with a text in various colors is obtained with CSBuilder by the following code :  

```B4X
Dim cs as csbuilder  
cs.Initialize.Color(Colors.Red).Append("Hello ")  
cs.Bold.Color(Colors.Green).Append("Colorful ").Pop.Pop  
cs.Append("World!").PopAll  
Label1.Text = cs
```

  
  
![](https://www.b4x.com/android/forum/attachments/107019)  
  

**[SIZE=5]The TagCSBuilder Class[/SIZE]**

  
**TagCSBuilder** is a class built on top of CSBuilder. With **TagCSbuilder** the formatting information is not provided by method calls but by tags included in the string. The previous example becomes :  

```B4X
Dim tcs as TagCsbuilder  
Tcs.Initialize.ATS("<C red>hello<B><C green><P 2>World")  
Label1.text = tcs.getcs
```

  
the tag <C xx> allows to define the color, the tag <B> to put in bold the tag <P 2> is the equivalent of two calls to the pop function. The final call to popall has been omitted, because it is automatically integrated in the GetCS method.  
  
   

**[SIZE=5]Tag structure[/SIZE]**

  
A tag begins with the lower sign "<" and ends with the upper sign ">"  
The tag contains a letter in upper or lower case followed optionally by 1 or 2 parameters separated by a comma. Spaces are not significant in the parameters :  
  

- **<L>** : tag with no parameter
- **<Lparam1>** or **<L param1 >** : tags with 1 parameter
- **<Lparam1,param2>** or **<L param1, param2 >** tag with 2 parameters

  
   

**[SIZE=5]List of Tags [/SIZE]**

  
   

- <AN> : Align Normal span (end with pop)
- <AO> : ALIGN\_OPPOSITE
- <AC> : ALIGN\_CENTER
- <B> : Bold
- <Ccolor> Set text color
- <Ftypeface> Set Text Typeface
- <Gcolor> : Set background color
- <H event> : Hyperlink (stop by <P> )
- <H Event, word> : hyperlink to event
- <K> Strikethrough
- <L> append a Linefeed
- <Ln> append n x Linefeed
- <Mx> set Margin of xdip
- <Mx,y> set Margin of xdip for first line and y for other lines
- <Obullet> : add a icon bullet
- <Obullet, size> add a icOn bullet of a specific size
- <P> Pop (close a span open by previous tag)
- <Pn> Pop n times
- <PA> PopAll
- <Qcolor> Quote the paragrapgh with color
- <Ssize> set text Size of x
- <Tx> Set a Tabstop at position xdip
- <T> : append a Tab char
- <U> Underline
- <X+> Superscript span (end with pop)
- <X-> Subscript span (end with pop)
- <Vint> Vertical align
- <0xhexvalue> append a char defiend by hexvalue
- <<> escape char <
- <>> escape char >

  
**Color**  
the color parameter is used with several tags : C, G, Q  
it can be one of the following values :   

- hexadecimal ; #RRGGBB ( ex #FF0000 for red)
- int : int color as define in VBa for example colors.blue
- index : int index of the ColorsMap properties
- text: key in the colormap properties

the ColorsMap is a pre-initialized, map with the standard color. For example a position 0 it is the black  
  
example : to set the back color you can uses on of the following forms :  
  
  
<C0> : color at position 0 of the ColorsMap  
<C black> : color named black in the ColorsMap  
<C#000000> : Hexadecimal value in RGB of the black color  
<Cxxxx> : where x is for exampel the value return by Colors.black  
  
**Typeface**  
The typeface parameter is uses in the F tag. It can take one of the following values :  
   

- index : int index of the ColorsMap properties
- text: key in the colormap properties

the TypefacesMap is a pre-initialized, map with the some typeface. For example to set the type face FONTAWESOME you can uses on of the folowing forms  
  
  
<F1> : typeface at position 1 of the TypefacesMap propertie  
<F awesome> key in the TypefaceMap propertie  
  
  
**Icon Bullet**  
The bullet is an icon character easily acessible without using a hex value  
it can take one of the following values :  

- index : int index of the BulletsMap properties
- text: key in the BulletsMap properties
- hex value in the form : 0x01F2

the the BulletsMap is a pre-initialized, map with the some icon cahracter. For example to add the check mark you can uses on of the folowing forms  
<O1> : icon at position 1 of the BulletsMap propertie  
<O check> key in the BulletsMap propertie  
  
  
   

**[SIZE=5]TagCSBuilder Methods[/SIZE]**

  
   

- **Initialize** : initialize class
- **ATS** : **A**ppend a **T**agged **S**tring
- **ANS** : **A**ppend **N**on tagged **S**tring
- **Clear** : clear current charsequenece
- **GetCS** : return the underlying CS

  
  

**[SIZE=5]TagCSBuilder Properties[/SIZE]**

  
  

- **BulletsMap** : mapping of icon names and their code
- **TypefacesMap** mapping of TYpeface and their values
- **ColorsMap** mapping of colors and their values
- **BulletTypeFace** : Typeface used for the <O> tag

  
  

**[SIZE=5]Example Program[/SIZE]**

  
  
The attached example program tests all the methods, properties and TAGs of the TagCSBuilder class.  
It is divided into 4 pages (Tabstrip component). The content of each page is only realized with a label component and the use of TagCSBuilder.  
  
**Header**  

![](https://www.b4x.com/android/forum/attachments/107026)

  
**Page 1**  

![](https://www.b4x.com/android/forum/attachments/107027)

  
**Page 2**  

![](https://www.b4x.com/android/forum/attachments/107028)

  
**Page 3**  

![](https://www.b4x.com/android/forum/attachments/107029)

  
**Page 4**  

![](https://www.b4x.com/android/forum/attachments/107030)  
  
**CONCLUSION**

  
The zip file includes the example program and the source of the TagCSBuilder class.  
This way you can improve this class and share the improvements.  
  
TagCSBuilder is specific to Android and thus to B4A. It cannot be adapted to other tools B4J, B4i. For a cross-platform need [B4X] there is the Rich Text View. ( see : <https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/>