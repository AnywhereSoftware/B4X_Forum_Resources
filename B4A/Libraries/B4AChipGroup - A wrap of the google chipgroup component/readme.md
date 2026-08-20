### B4AChipGroup - A wrap of the google chipgroup component by Mashiane
### 08/18/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171841/)

Hi there…  
  
[Github](https://github.com/Mashiane/B4AChipGroup)  
  
Let me tick off a bucket list item… Wrapping a native google widget to B4A.  
  
Well.. thanks to AI. Complete java source code included.  
  
  
I decided to comment this as much as possible so that I get to understand its internals as much as possible. So this is what it does…  
  
![](https://www.b4x.com/android/forum/attachments/172999)  
  
**[SIZE=6]B4AChipGroup[/SIZE]  
Version:** 1.00  
**Author:** Sithaso Native Components  
  
**[SIZE=5]Dependencies & Manifest Requirement[/SIZE]**  

- **DependsOn:** [FONT=Courier New]com.google.android.material:material[/FONT]
- **DependsOn:** [FONT=Courier New]androidx.appcompat:appcompat[/FONT]
- **DependsOn:** [FONT=Courier New]androidx.emoji2:emoji2-views-helper[/FONT]
- **DependsOn:** [FONT=Courier New]androidx.emoji2:emoji2[/FONT]
- **DependsOn:** [FONT=Courier New]androidx.core:core[/FONT]

  
**Manifest Code:**  

```B4X
SetApplicationAttribute(android:theme, "@style/Theme.MaterialComponents.Light.NoActionBar")
```

  
  

---

  
**[SIZE=5]B4AChipGroup[/SIZE]  
Class Name:** [FONT=Courier New]com.sithaso.b4a.components.B4AChipGroup[/FONT]  
**Wrapped Native View:** [FONT=Courier New]com.google.android.material.chip.ChipGroup[/FONT]  
  
Google Native Material ChipGroup container with String Key-Value pairs and eye-friendly theme presets.  
Supports multi-selection, single-choice filter chips, closeable action tags, leading icons, dynamic multi-row flow wrapping, and custom Object tags.  
  
**Example Setup:**  

```B4X
Sub Globals  
    Private B4AChipGroup1 As B4AChipGroup  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    B4AChipGroup1.Clear  
    B4AChipGroup1.Theme = "Emerald" ' Options: Primary, Emerald, Amber, Rose, Purple, Teal, Dark, Custom  
    B4AChipGroup1.AddChip("all", "All Categories")  
    B4AChipGroup1.AddChip2("tech", "Technology", True, True, True)  
    B4AChipGroup1.AddChip2("science", "Science", True, True, False)  
    B4AChipGroup1.AddChip2("ai_ml", "AI & ML", True, True, False)  
    B4AChipGroup1.AddChip2("mobile", "Mobile Dev", True, False, False)  
End Sub  
  
Sub B4AChipGroup1_SelectionChanged (CheckedKeys As List)  
    For Each key As String In CheckedKeys  
        Log("Selected Key: " & key & " -> " & B4AChipGroup1.GetChipText(key))  
    Next  
End Sub  
  
Sub B4AChipGroup1_ChipClose (Key As String)  
    Log("Closed tag: " & Key)  
    B4AChipGroup1.RemoveChip(Key)  
End Sub
```

  
  
**[SIZE=4]Events:[/SIZE]**  

- **B4AChipGroup\_ChipSelected (Key As String)**
- **B4AChipGroup\_ChipCheckedChange (Key As String, Checked As Boolean)**
- **B4AChipGroup\_SelectionChanged (CheckedKeys As List)**
- **B4AChipGroup\_ChipClick (Key As String)**
- **B4AChipGroup\_ChipClose (Key As String)**

  
**[SIZE=4]Designer Properties:[/SIZE]**  

- [FONT=Courier New]Theme: Primary|Emerald|Amber|Rose|Purple|Teal|Dark|Custom[/FONT]
- [FONT=Courier New]SingleSelection: Boolean (Default: False)[/FONT]
- [FONT=Courier New]SelectionRequired: Boolean (Default: False)[/FONT]
- [FONT=Courier New]SingleLine: Boolean (Default: False)[/FONT]
- [FONT=Courier New]AutoFitHeight: Boolean (Default: True)[/FONT]
- [FONT=Courier New]ChipSpacingHorizontal: Int (Default: 8dip)[/FONT]
- [FONT=Courier New]ChipSpacingVertical: Int (Default: 8dip)[/FONT]
- [FONT=Courier New]ChipCornerRadius: Int (Default: 16dip)[/FONT]
- [FONT=Courier New]ChipStrokeWidth: Int (Default: 1dip)[/FONT]
- [FONT=Courier New]Custom Colors: ChipStrokeColor, ChipBackgroundColor, ChipCheckedBackgroundColor, ChipTextColor, ChipCheckedTextColor[/FONT]
- [FONT=Courier New]SampleChips: String (Default: android|Android;kotlin|Kotlin;b4a|B4A;google|Google)[/FONT]

  
**[SIZE=4]Key Methods:[/SIZE]**  

- **AddChip** (key As String, text As String)
[INDENT]Adds a simple checkable filter chip with unique String key and display label.[/INDENT]- **AddChip2** (key As String, text As String, isCheckable As Boolean, isCloseable As Boolean, isChecked As Boolean)
[INDENT]Adds a configurable chip specifying checkable, closeable, and checked states.[/INDENT]- **AddChip3** (key As String, text As String, isCheckable As Boolean, isCloseable As Boolean, isChecked As Boolean, iconBmp As Bitmap, closeIconBmp As Bitmap)
[INDENT]Adds a fully customized chip with leading icons and custom close icon drawables.[/INDENT]- **AddChipWithTag** (key As String, text As String, value As Object, isCheckable As Boolean, isCloseable As Boolean, isChecked As Boolean)
[INDENT]Adds a chip with an attached custom Object tag payload (Map, custom Type, etc.).[/INDENT]- **ApplyTheme** (themeName As String)
[INDENT]Applies a curated theme preset ("Primary", "Emerald", "Amber", "Rose", "Purple", "Teal", "Dark").[/INDENT]- **FitHeight** ()
[INDENT]Dynamically measures and resizes container height to fit all wrapped chip rows.[/INDENT]- **RemoveChip** (key As String) / **Clear** ()
[INDENT]Removes individual chips or resets the entire group.[/INDENT]- **Check** (key As String) / **Uncheck** (key As String) / **ClearCheck** ()
[INDENT]Programmatic selection management.[/INDENT]- **IsChecked** (key As String) As Boolean / **GetChipText** (key As String) As String / **GetChipTag** (key As String) As Object
[INDENT]State and metadata queries.[/INDENT]
  
**[SIZE=4]Properties:[/SIZE]**  

- **Theme** As String (Get / Set active theme preset)
- **SingleSelection** As Boolean (Get / Set single selection mode)
- **SelectionRequired** As Boolean (Get / Set mandatory selection)
- **SingleLine** As Boolean (Get / Set horizontal scroll vs multi-line wrapping)
- **AutoFitHeight** As Boolean (Get / Set automatic height expansion)
- **CheckedKey** As String (Returns single selected key)
- **CheckedKeys** As List (Returns list of all selected String keys)
- **NumberOfChips** As Int (Total chip count)