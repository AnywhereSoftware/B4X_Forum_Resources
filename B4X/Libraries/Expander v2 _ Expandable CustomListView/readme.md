###  Expander v2 : Expandable CustomListView by epiCode
### 12/24/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/145015/)

Expander : Expandable CustomListView based on Erel's Expandable List View, xCustomListView and XUI  
  
I needed to modify Expandable List View to customize it to my need and hence this Library.  
  
Features:  
~ Easy to Configure. No layouts. No Images.  
~ Does not use layout. So it is slightly faster with long lists.  
~ Accepts CharSequence for Title and Body.  
~ Designed for Text items. Add items by defining Title and Body as either Text/Charsequence. Custom Panels can also be added.  
~ Auto Resizing based on text. [Put 0 as Collapsed or Expanded Height for auto Resize]  
~ Easy to modify Arrow Symbol [ No Image needed (uses FontAwesome) & you can change size and color ]  
  
[SPOILER="Library XML Details"]  
**Expander  
Version:** 2  
**Author:** epiCode  

**Methods:**- **Initialize As void**
*Initializes the fields to their default value.*
**Expander  
Fields:**  

- **designerTitle As B4XView** Use this to modify Title properties
- **designerBody As B4XView** Use this to modify Body properties
- **openSingleItem As boolean** Will collapse last panel before expanding a new one
- **padding As int** Padding around body text
- **titleShadow As int** Title Shadow
- **titleEdgeGap As int** Title Edge Gap
- **titleRoundness As int** Rounded Corners
- **arrowSymbol As char** Arrow Symbol from fontawesome as Char
- **arrowColor As int** Arrow Color
- **arrowSize As int** Arrow Size

**Methods:**  

- **IsInitialized As boolean** *Tests whether the object has been initialized.*
- **\_additem** (iTitle As Object, iBody As Object, Collapsed As int, Expanded As int) **As String**
 *Add item to selected CLV  
 Collapsed and Expanded are height. Set heights to 0 for auto resize  
 Modify DesignerTitle or DesignerBody to change attributes of Title and Body  
 Please note there is default padding of 4dip in both Title and Body.*
**Properties:**  

- **showSingle As boolean** Expand single item only. [Closes last one]

[/SPOILER]  
   
**Depends on these Libraries:**  
 [LineUtils v1.2](https://www.b4x.com/android/forum/threads/b4x-lineutils-v1-2-get-required-height-for-multiline-textview-label-with-variable-line-spacing.138786/)   
 XUI  
  
PM for Source (Payware)