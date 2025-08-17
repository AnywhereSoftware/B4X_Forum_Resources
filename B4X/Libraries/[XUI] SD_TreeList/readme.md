###  [XUI] SD_TreeList by Star-Dust
### 04/02/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/110994/)

**SD\_TreeList  
  
Author:** Star-Dust  
**Version:** 0.27  

- **B4XTree**

- **Events:**

- **Click** (IDLeaf As String, LeafName As String)
- **ClickBranch** (ID As String, Expanded As Boolean)
- **LongRightClick** (IDLeaf As String, LeafName As String)
- **LongRightClickBranch** (ID As String, BranchName As String)

- **Fields:**

- **BadgeBackgroundColor** As Int
- **BadgeDept** As Int
- **BadgeTextColor** As Int
- **BadgeTextSize** As Int

- **Functions:**

- **Add** (Name As String, IDBranch As String, FontAwesoneSymbol As String, Color As Int, ListLeaf As String()) As String
 *Add Branch with Symbol(FontAwesone) and Leaf (list)*- **Add2** (Name As String, IDBranch As String, Symbol As String, FontSymbol As B4XFont, Color As Int, ListLeaf As String()) As String
 *Add Branch with Symbol(FontAwesone) and Leaf (list)*- **AddBranch** (Name As String, IDBranch As String, IDParent As String, FontAwesoneSymbol As String, Color As Int) As String
 *Add Branch*- **AddBranch2** (Name As String, IDBranch As String, IDParent As String, Symbol As String, FontSymbol As B4XFont, Color As Int) As String
 *Add Branch with Symbol*- **AddBranchDoubleSymbol** (Name As String, IDBranch As String, IDParent As String, OpenSymbol As String, CloseSymbol As String, FontSymbol As B4XFont, Color As Int) As String
 *Add Branch with double symbol*- **AddDoubleSymbol** (Name As String, IDBranch As String, OpenSymbol As String, CloseSymbol As String, FontSymbol As B4XFont, Color As Int, ListLeaf As String()) As String
 *Add Branch with double Symbol and Leaf (list)*- **AddLeaf** (Name As String, Info As String, IDBLeaf As String, IDParent As String) As String
 *Add Leaf to branch*- **AddLeaf2** (Name As String, Info As String, Note As String, IDBLeaf As String, IDParent As String) As String
 *Add Leaf to branch*- **AddLeaf3** (Name As String, Info As String, Note As String, FontNote As B4XFont, ColorNote As Int, IDBLeaf As String, IDParent As String, FontAwesoneSymbol As String, FontSymbol As B4XFont) As String
 *Add Leaf with info, note andSymbol to branch*- **AddLeaf3OnTop** (Name As String, Info As String, Note As String, FontNote As B4XFont, ColorNote As Int, IDBLeaf As String, IDBranch As String, FontAwesoneSymbol As String, FontSymbol As B4XFont) As String
 *Add Leaf with info,note and Symbol to branch on top*- **AddLeafOnTop** (Name As String, Info As String, IDLeaf As String, IDBranch As String) As String
 *Add Leaf on top to Branch*- **AddLeafwithSymbol** (Name As String, Info As String, IDBLeaf As String, IDParent As String, FontAwesoneSymbol As String, FontSymbol As B4XFont) As String
 *Add Leaf with Symbol to branch*- **AddLeafwithSymbolOnTop** (Name As String, Info As String, IDBLeaf As String, IDBranch As String, FontAwesoneSymbol As String, FontSymbol As B4XFont) As String
 *Add Leaf with Symbol to branch on top*- **Class\_Globals** As String
- **Clear** As String
- **CollapsesAllBranch** As String
- **CollapsesBranch** (IDBranch As String) As String
- **CollapsesBranchAndSOn** (IDBranch As String) As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **ExpandAllBranch** As String
- **ExpandBranch** (IDBranch As String) As String
- **ExpandBranchAndSon** (IDBranch As String) As String
- **GetBranchName** (IDBranch As String) As String
- **GetBranchOfLeaf** (IDLeaf As String) As String
- **GetLeafBadgeActive** (IDLeaf As String) As Boolean
- **GetLeafBadgeText** (IDLeaf As String) As String
- **GetLeafInfo** (IDLeaf As String) As String
- **GetLeafName** (IDLeaf As String) As String
- **Initialize** (Callback As Object, EventName As String) As String
- **Invalidate**
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **ListOfIDBraches** (IDBranche As String) As List
*Returns a list of strings  
 This list contains the IDs of the sub-branches attached To a branch*- **ListOfIDLeafs** (IDBranche As String) As List
*Returns a list of strings  
 This list contains the IDs of the leaves attached To a branch*- **MoveLeaf** (IDLeaf As String, NewIDBranch As String) As String
- **RemoveBranch** (IDBranch As String) As String
- **RemoveLeaf** (IDLeaf As String) As String
- **SetBranch** (IDBranch As String, NewName As String) As String
- **SetLayout** (Left As Int, Top As Int, Widh As Int, Height As Int) As String
- **SetLeaf** (IDLeaf As String, NewName As String, NewInfo As String) As String
- **SetLeafBadge** (IDLeaf As String, BadgeActive As Boolean, BadgeText As String) As String
- **Sort** (Ascending As Boolean) As String
- **TreeToJson** As String

- **Properties:**

- **Base** As B4XView [read only]
- **BranchTextColor** As Int
- **Height** As Int
- **InfoTextSize** As Int
- **ItemHeight** As Int
 *Min = 40dip, Max= 100dip*- **LeafTextColor** As Int
- **Left** As Int
- **OnlyCornerColor** As Boolean
- **OpenOnlyOneBranch** As Boolean
- **TextSize** As Int
- **TimeAnimation** As Int
- **Top** As Int
- **Width** As Int

  
  
**[SIZE=5][FONT=trebuchet ms]Log version[/FONT][/SIZE]**  

- **0.21**
Added AddLeafwithSymbol method. Now you can insert a Symbolo with FontAwesone or FontMaterial in the branch- **0.22** - Improved tree JSON production (method **TreeToJson** )
- **0.23** - Added event **LongRightClickBranch** (IDLeaf As String, LeafName As String)
- **0.24** - Added meethod **AddLeafwithSymbolOnTop**
- **0.25** - Added **InfotextSize** field; Added **Note** (to the right of the info); Added **AddLeaf3** and **AddLeaf3OnTop** methods
- **0.26** - Increased height of elements, Highlighting of the clicked element
- **0.27** - Added AddLeaf2

  
  
  
**![](https://www.b4x.com/android/forum/attachments/85955) ![](https://www.b4x.com/android/forum/attachments/114987)**