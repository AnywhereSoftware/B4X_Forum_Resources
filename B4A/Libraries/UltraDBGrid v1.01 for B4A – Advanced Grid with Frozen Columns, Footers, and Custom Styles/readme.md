### UltraDBGrid v1.01 for B4A – Advanced Grid with Frozen Columns, Footers, and Custom Styles by Asrar Ahmed
### 09/01/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/168485/)

[SIZE=6]**📌 UltraDBGrid v1.01 (B4A)**[/SIZE]  
  
A fully customizable and database-friendly grid component for **B4A**,   
designed to give developers maximum control over rows, columns, styles, and data binding.   
Supports both **manual column definitions** and **auto-detection from SQL queries**.  
  
—  
  
[SIZE=5]**✨ Features**[/SIZE]  

- **Database Integration**
- Bind grid to any SQL query with [ICODE]DataSource[/ICODE].
- Auto-detects columns if not defined manually.- **Custom Columns**
- Add columns manually via [ICODE]AddColumn[/ICODE].
- Supports column widths, headers, and data types.- **Headers & Footers**
- Full control over colors, fonts, alignment, and height.
- Frozen columns with independent headers & footers.- **Row Customization**
- Adjustable row height.
- Alternate row styling.
- Custom cell styles.- **Search & Sorting**
- Built-in search panel with highlight.
- Auto-detects [ICODE]ORDER BY[/ICODE] and shows sort indicators.
- Single-click column sorting.- **Frozen Columns**
- First column can stay fixed while scrolling horizontally.- **Selection Handling**
- Customizable selection color.
- Methods for clearing or refreshing selection.- **Customizable Grid Appearance**
- Grid background color.
- Border visibility.
- Highlight color.
- Theme-friendly.- **Performance**
- Uses **UltimateListView** internally for smooth scrolling.
- Supports large datasets.
  
—  
  
[SIZE=5]**🎬 Demo Apps (10 Examples)**[/SIZE]  
  
1. **Cell Customization**   
![](CellCustomize.gif)  
  
2. **Column & Row Customization**   
![](Row&Col.gif)  
  
3. **Database Binding**   
![](Database.gif)  
  
4. **Footers**   
![](Footers.gif)  
  
5. **Frozen Column**   
![](Frozen.gif)  
  
6. **Headers**   
![](Headers.gif)  
  
7. **Grid Customization (colors, styles, etc.)**   
![](Grid Customize.gif)  
  
8. **Search Queries**   
![](Searching.gif)  
  
9. **Sorting**   
![](Sorting.gif)  
  
10. **Selections**   
![](Selection.gif)  
  
—  
  
[SIZE=5]**📦 Installation**[/SIZE]  
1. Copy **UltraDBGrid.bas** to your project’s *Class Modules*.   
2. Add **UltimateListView** library to your project.   
3. Add **UltraDBGrid** to your layout or create it programmatically.   
  
—  
  
[SIZE=5]**🚀 Quick Example**[/SIZE]  

```B4X
' Initialize grid  
UltraDBGrid1.Initialize(Me, "Grid")  
Activity.AddView(UltraDBGrid1, 0, 0, 100%x, 100%y)  
  
' Add column manually (optional)  
UltraDBGrid1.AddColumns("Name", "name", 120dip, UltraDBGrid1.TypeString)  
  
' Bind to database  
UltraDBGrid1.DataSource(SQL1, "SELECT id, name, salary FROM employees ORDER BY name")
```

  
  
—  
  
[SIZE=5]**📥 Download**[/SIZE]   
👉 ![](https://www.b4x.com/android/forum/attachments/UltraDBGrid_v1.01.zip)   
(Library + 10 Demo Apps + GIFs)  
  
—  
  
[SIZE=5]**💬 Notes**[/SIZE]  
- Tested on **B4A 12+** with **UltimateListView**.   
- Current version: **v1.01 (Initial Release)**.   
- Feedback & feature requests are welcome!