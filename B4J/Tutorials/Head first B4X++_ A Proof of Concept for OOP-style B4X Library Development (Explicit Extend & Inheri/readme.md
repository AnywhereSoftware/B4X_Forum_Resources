### Head first B4X++: A Proof of Concept for OOP-style B4X Library Development (Explicit Extend & Inherit Classes) by Mashiane
### 07/11/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/171518/)

Hi Fam!  
  
When Toky dmed me a copy of a b4x demo where B4++ is used I was mind blown. One of the pain issues he raised is, here I quote..  
  
> One thing I don't like when wrapping js frameworks to BANano was this: REPETITIONS and B4X lacks of full inheritance/polymorphism. With B4X++, it can be changed.

  
This is very true for many of us who create b4x libraries, as a result I escape this partially by automation. **I sit there for a while and realize that 95% of the code I wrote is not there because the B4++ he used changed the world!**  
  
And the code he showed me was based on my [B4XDaisyUIKit](https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisyuikit-native-components-inspired-by-daisyui-tailwind.170352/) and he rewrote a component completely different using B4X++, lets check this extract..  
  
**B4XDaisyLoading in B4X++**  
  

```B4X
#Class B4XDaisyLoading Extends B4XDaisyTextBase  
  
#DesignerProperty: Key: Text, DisplayName: Text, FieldType: String, DefaultValue: Loading…, Description: Loading text.  
#DesignerProperty: Key: SpinnerStyle, DisplayName: Spinner Style, FieldType: String, DefaultValue: dots, List: dots|spinner|ring|ball|bars|infinity, Description: Loading style token.  
  
Sub Class_Globals  
    Private mSpinnerStyle As String = "dots"  
End Sub  
Public Sub Initialize(Callback As Object, EventName As String)  
    Super.Initialize(Callback, EventName)  
End Sub  
  
  
Override Sub ReadProps(Props As Map)  
    Super.ReadProps(Props)  
    If Text = "" Then Text = B4XDaisyVariants.GetPropString(Props, "Text", "Loading…")  
    mSpinnerStyle = B4XDaisyVariants.GetPropString(Props, "SpinnerStyle", mSpinnerStyle)  
End Sub  
  
Override Sub Refresh  
    Super.Refresh  
    If LabelView.IsInitialized Then LabelView.Text = LoadingPrefix & " " & Text  
End Sub  
  
Private Sub LoadingPrefix As String  
    Select mSpinnerStyle  
        Case "ring"  
            Return "○"  
        Case "bars"  
            Return "▮▮▮"  
        Case "ball"  
            Return "●"  
        Case "infinity"  
            Return "∞"  
        Case Else  
            Return "…"  
    End Select  
End Sub  
  
#End Class
```

  
  
Look, honestly, right now I dont really know what is happening here, but Im very very curious. Ive seen this methodology used in javascript frameworks. Seeing it done in this fashion and it works 100% is mind blowing for me.  
  
***Which is why I made this video overview below, to introduce myself to this amazing project and also prepare my ADHD for it. Hope you find it useful.***  
  
What is true: My B4XDaisyLoading component is -750 lines of code (including comments and space) vs Tokys version 40 lines of code! **An awesome 95% drop in the code written.**  
  
NB: Already Tody had demonstrated in a B4J project how one can use the same principle and methodolgy in this thread post.  
  
<https://www.b4x.com/android/forum/threads/object-oriented-programming-to-b4x-inheritance-polymorphism.64453/post-1048300>  
  
**Why this matters a great deal?**  
  
Well, I dont think even trying to justify this would make sense. 40 vs 750 code lines above is the proof.  
  
*Let me get a* [*Google NotebookLM*](https://notebooklm.google.com/notebook/b80f5e1a-aa83-4878-998c-ab5366ae1dc3) *perspective about the history of b4x and how b4x++ comes into the fold…*  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
**The Origins: Basic4ppc**  
  
The B4X language ecosystem was created by Erel Uziel, CEO of Anywhere Software, and initially launched in 2005 as **Basic4ppc**. Originally targeting Pocket PC handheld computers running the Windows Mobile operating system, the language was heavily influenced by Visual Basic. In its early years, it functioned as a procedural and structural language that implemented a unique, non-object-oriented way of adding objects to programs.  
  
Between 2005 and 2010, Basic4ppc evolved through several major versions:  

- **Version 3.0 (2006):** Introduced stand-alone compiling.
- **Version 4.0 (2006):** Added the ability to use external libraries.
- **Version 6.0 (2007):** Introduced optimized compiling, significantly improving performance on both desktop and device applications.
- **Version 6.9 (2010):** Added support for typed variables and subroutines.

**Cross-Platform Expansion and the B4X Identity**  
  
As Windows Mobile declined, the ecosystem pivoted. In 2010, **Basic4android (B4A)** was released, allowing developers to write "Basic-like" code and compile it for Android devices. Following the success of B4A, the ecosystem expanded dramatically. In 2014, the suite was officially rebranded as **B4X** ("B for x"), which today includes tools for multiple platforms: **B4A** (Android), **B4i** (iOS), **B4J** (Desktop/Server/Raspberry Pi with Java), and **B4R** (Arduino).  
  
**The Evolution of Object-Oriented Programming (OOP) in B4X**  
  
Perhaps the most significant milestone in the language's evolution was the release of **B4A v2.00 in June 2012**, which introduced **class modules**. Prior to this, developers were limited to procedural code. Classes allowed B4X developers to utilize OOP characteristics, making it significantly easier to build reusable components and maintain large projects.  
  
The implementation of OOP in B4X included:  

- **Encapsulation:** Achieved through Private and Public access modifiers.
- **Polymorphism:** Implemented via "Duck Typing" using the CallSub and SubExist keywords, allowing developers to check if an object has a specific method (like Save) before calling it.

However, **B4X intentionally does not support native inheritance**. Erel Uziel has repeatedly advocated for using **composition** (adding the base class as an instance inside the new class) instead of inheritance, arguing that it results in better software design. To share UI elements across activities, he recommends simulating inheritance by loading the same layout file on different activities.  
  
Despite this, the community has continued to experiment with OOP structures. Around 2026, an experimental preprocessor/transpiler called **B4X++** emerged as a proof-of-concept. Working much like TypeScript does for JavaScript, B4X++ allows developers to write code with explicit inheritance, overrides, and specialized classes, which the transpiler then flattens into standard, IDE-compatible B4X .bas files.  
  
**Language Identity and the "Basic" Stigma**  
  
Throughout its history, the ecosystem has faced a perception challenge due to its "Basic" syntax. In the development community, the term "Basic" is sometimes stigmatized as a "toy language" or viewed as a relic of the past, prompting some users to suggest that B4X would be more famous if it adopted a C#-like syntax or rebranded entirely to shed the Basic legacy.  
  
Conversely, Erel and many veteran users firmly defend the language's current structure. They view B4X as a **Rapid Application Development (RAD)** tool directly inspired by the simplicity and speed of VB6. They argue that the power of B4X lies in its ability to abstract away the complexities of languages like Java or C#, allowing developers to build advanced, cross-platform applications in a fraction of the time. Erel has cemented this philosophy, stating clearly that the B4X syntax will intentionally remain close to BASIC and will not be changed.  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
  
With that said, B4X++ is a vscode extension. Below is the first video to jump into this rabbit hole.  
  
In case you are wondering. The release of this video overview is done with prior permission.  
  
GitHub repository:  
<https://github.com/soinalastudio/B4XPP>