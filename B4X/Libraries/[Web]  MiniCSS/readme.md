### [Web]  MiniCSS by aeric
### 07/30/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170299/)

Version 0.40  
GitHub: <https://github.com/pyhoon/MiniCSS-B4X>  
  
A lightweight CSS generator library for B4X (B4A, B4i, B4J) that allows you to programmatically generate CSS stylesheets from B4X code.  
  
[HEADING=1]Features[/HEADING]  

- **Fluent Builder API** - Chainable, fluent syntax for creating CSS rules
- **CSS Variables** - Define and use CSS custom properties
- **Media Queries** - Responsive design with media query support
- **Keyframes Animations** - Create CSS animations with keyframes
- **CSS Presets** - Ready-to-use styles (Flexbox center, Cards, Buttons, Grid, Responsive text)
- **Raw CSS Parsing** - Parse raw CSS strings into rules
- **Minification** - Export minified CSS for production
- **File Export** - Save generated CSS to files
- **Cross-platform** - Works with B4A, B4i, and B4J

---

  
[HEADING=1]Installation[/HEADING]  

1. Download the MiniCSS.b4xlib library from prerelease folder to your Additional Libraries folder
2. In B4X IDE Libraries Manager tab, check the MiniCSS library

[HEADING=1]Quick Start[/HEADING]  

```B4X
Sub Process_Globals  
    Private css As MiniCss  
    Private cbd As MiniCssBuilder  
    Private cps As MiniCssPresets  
End Sub  
  
Sub AppStart (Args() As String)  
    css.Initialize(Me)  
    cbd.Initialize(css)  
    cps.Initialize(css)  
   
    ' Define CSS variables  
    css.AddVariable("–primary-color", "#007bff")  
    css.AddVariable("–font-family", "'Arial', sans-serif")  
   
    ' Use fluent builder for clean syntax  
    cbd.Rule(".container") _  
    .Width("100%") _  
    .MaxWidth("1200px") _  
    .Margin("0 auto") _  
    .Padding("20px")  
   
    cbd.Rule(".header") _  
    .BackgroundColor("var(–primary-color)") _  
    .Color("white") _  
    .Padding("20px") _  
    .FontSize("24px")  
   
    ' Use presets for common patterns  
    cps.AddButtonStyle(".btn-primary", True)   ' Primary button  
    cps.AddButtonStyle(".btn-secondary", False) ' Secondary button  
    cps.AddCardStyle(".card")  
    cps.AddFlexCenter(".center-content")  
    cps.AddGridLayout(".grid", 3, "20px")  
   
    ' Generate CSS  
    Dim cssOutput As String = css.GenerateCSS  
    Log(cssOutput)  
   
    ' Save to file (minified for production)  
    css.ExportToFile("styles.min.css", True)  
End Sub
```

  
  
[HEADING=1]API Reference[/HEADING]  
[HEADING=2]MiniCss (Core)[/HEADING]  
[TABLE]  
[TR]  
[TH]Method[/TH]  
[TH]Description[/TH]  
[/TR]  
[TR]  
[TD]Initialize(Module)[/TD]  
[TD]Initialize the CSS generator[/TD]  
[/TR]  
[TR]  
[TD]AddRule(selector)[/TD]  
[TD]Start a new CSS rule[/TD]  
[/TR]  
[TR]  
[TD]AddProperty(name, value)[/TD]  
[TD]Add property to current rule[/TD]  
[/TR]  
[TR]  
[TD]AddProperties(map)[/TD]  
[TD]Add multiple properties at once[/TD]  
[/TR]  
[TR]  
[TD]AddVariable(name, value)[/TD]  
[TD]Define a CSS variable[/TD]  
[/TR]  
[TR]  
[TD]AddMediaQuery(condition)[/TD]  
[TD]Start a media query[/TD]  
[/TR]  
[TR]  
[TD]AddRuleToMedia(selector, properties)[/TD]  
[TD]Add rule to last media query[/TD]  
[/TR]  
[TR]  
[TD]AddKeyframe(name)[/TD]  
[TD]Start keyframe animation[/TD]  
[/TR]  
[TR]  
[TD]AddKeyframeSelector(selector)[/TD]  
[TD]Add keyframe selector (0%, 50%, 100%)[/TD]  
[/TR]  
[TR]  
[TD]AddKeyframeProperty(name, value)[/TD]  
[TD]Add property to current keyframe[/TD]  
[/TR]  
[TR]  
[TD]GenerateCSS[/TD]  
[TD]Generate CSS string[/TD]  
[/TR]  
[TR]  
[TD]ExportToFile(filename, minify)[/TD]  
[TD]Export CSS to file[/TD]  
[/TR]  
[/TABLE]  
  
[HEADING=2]MiniCssBuilder (Fluent API)[/HEADING]  
[TABLE]  
[TR]  
[TH]Method[/TH]  
[TH]Description[/TH]  
[/TR]  
[TR]  
[TD]Rule(selector)[/TD]  
[TD]Start a new rule[/TD]  
[/TR]  
[TR]  
[TD]Property(name, value)[/TD]  
[TD]Add property[/TD]  
[/TR]  
[TR]  
[TD]Properties(map)[/TD]  
[TD]Add multiple properties[/TD]  
[/TR]  
[TR]  
[TD]Width/Height/Color/BackgroundColor/etc.[/TD]  
[TD]Shorthand property methods[/TD]  
[/TR]  
[TR]  
[TD]ParseRaw(cssString)[/TD]  
[TD]Parse raw CSS string[/TD]  
[/TR]  
[TR]  
[TD]ParseRawWithRules(selector, cssString)[/TD]  
[TD]Parse CSS with nested rules[/TD]  
[/TR]  
[TR]  
[TD]Keyframe(name)[/TD]  
[TD]Start keyframe[/TD]  
[/TR]  
[TR]  
[TD]At(selector)[/TD]  
[TD]Add keyframe selector[/TD]  
[/TR]  
[TR]  
[TD]Set(prop, value)[/TD]  
[TD]Set keyframe property[/TD]  
[/TR]  
[TR]  
[TD]SetAll(map)[/TD]  
[TD]Set multiple keyframe properties[/TD]  
[/TR]  
[/TABLE]  
  
[HEADING=3]Shorthand Properties[/HEADING]  
Width, Height, MinWidth, MaxWidth, MinHeight, MaxHeight, Margin, Padding, Border, BorderRadius, Color, BackgroundColor, FontSize, FontWeight, FontFamily, Display, Position, Top, Right, Bottom, Left, ZIndex, Opacity, Overflow, TextAlign, LineHeight, LetterSpacing, TextTransform, Cursor, Transition, Transform, BoxShadow, FlexDirection, JustifyContent, AlignItems, Gap, GridTemplateColumns, GridTemplateRows, GridGap, Float, Clear, Visibility, WhiteSpace, WordWrap, WordBreak, OverflowWrap, Resize, UserSelect, PointerEvents  
  
[HEADING=2]MiniCssPresets (Ready-made Styles)[/HEADING]  
[TABLE]  
[TR]  
[TH]Method[/TH]  
[TH]Description[/TH]  
[/TR]  
[TR]  
[TD]AddFlexCenter(selector)[/TD]  
[TD]Flexbox center alignment[/TD]  
[/TR]  
[TR]  
[TD]AddCardStyle(selector)[/TD]  
[TD]Card component style[/TD]  
[/TR]  
[TR]  
[TD]AddButtonStyle(selector, primary)[/TD]  
[TD]Button style (primary/secondary)[/TD]  
[/TR]  
[TR]  
[TD]AddGridLayout(selector, columns, gap)[/TD]  
[TD]CSS Grid layout[/TD]  
[/TR]  
[TR]  
[TD]AddResponsiveText(selector)[/TD]  
[TD]Responsive typography with clamp()[/TD]  
[/TR]  
[/TABLE]  
  
[HEADING=1]Media Queries Example[/HEADING]  

```B4X
' Mobile-first responsive design  
css.AddMediaQuery("(max-width: 768px)")  
Dim mobileProps As Map  
mobileProps.Initialize  
mobileProps.Put("flex-direction", "column")  
mobileProps.Put("padding", "10px")  
css.AddRuleToMedia(".container", mobileProps)  
  
css.AddMediaQuery("(min-width: 769px) and (max-width: 1024px)")  
Dim tabletProps As Map  
tabletProps.Initialize  
tabletProps.Put("padding", "20px")  
css.AddRuleToMedia(".container", tabletProps)
```

  
  
[HEADING=1]Keyframes Animation Example[/HEADING]  

```B4X
' Using fluent builder  
cbd.Keyframe("fadeIn") _  
    .At("0%") _  
    .Set("opacity", "0") _  
    .Set("transform", "translateY(-20px)") _  
    .At("100%") _  
    .Set("opacity", "1") _  
    .Set("transform", "translateY(0)")  
  
' Or using core API  
css.AddKeyframe("slideIn")  
css.AddKeyframeSelector("from")  
css.AddKeyframeProperty("transform", "translateX(-100%)")  
css.AddKeyframeSelector("to")  
css.AddKeyframeProperty("transform", "translateX(0)")
```

  
  
[HEADING=1]Raw CSS Parsing[/HEADING]  

```B4X
' Parse raw CSS string  
cbd.Rule(".custom-class").ParseRaw("color: red; font-size: 14px; margin: 10px;")  
  
' Parse with nested pseudo-classes  
cbd.ParseRawWithRules(".button", "background: blue; &:hover { background: darkblue; }")
```

  
  
[HEADING=1]Export Options[/HEADING]  

```B4X
' Generate CSS string  
Dim cssString As String = css.GenerateCSS  
  
' Export formatted CSS (development)  
css.ExportToFile("styles.css", False)  
  
' Export minified CSS (production)  
css.ExportToFile("styles.min.css", True)
```

  
  
[HEADING=1]Output Example[/HEADING]  

```B4X
:root {  
  –primary-color: #007bff;  
  –font-family: 'Arial', sans-serif;  
}  
  
.container {  
  width: 100%;  
  max-width: 1200px;  
  margin: 0 auto;  
  padding: 20px;  
}  
  
.header {  
  background-color: var(–primary-color);  
  color: white;  
  padding: 20px;  
  font-size: 24px;  
}  
  
.btn-primary {  
  background-color: #007bff;  
  color: white;  
  border: none;  
  padding: 10px 20px;  
  border-radius: 4px;  
  cursor: pointer;  
  font-size: 14px;  
  transition: background-color 0.3s;  
}  
  
.btn-primary:hover {  
  background-color: #0056b3;  
}  
  
@media (max-width: 768px) {  
  .container {  
    flex-direction: column;  
    padding: 10px;  
  }  
}  
  
@keyframes fadeIn {  
  0% {  
    opacity: 0;  
    transform: translateY(-20px);  
  }  
  100% {  
    opacity: 1;  
    transform: translateY(0);  
  }  
}
```

  
  
  
Test project: <https://www.b4x.com/android/forum/threads/b4x-minicss.170288/>