### Tiles_JE by Jerryk
### 08/03/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/167614/)

I created a new custom view where the user continues to run the application based on the information displayed in the tiles. There are three types of information that can be displayed:  

- label
- image
- layout

The tiles are scrollable. The width of the tiles can be fixed or flexible. Each tile is assigned a unique tag, which is passed in the Click event when clicked. Examine the example.  
  
  
![](https://www.b4x.com/android/forum/attachments/165051)  
  
**Tiles\_JE  
Author: Jerryk  
Version: 1.3  
  
Methods:**  

- **Selected Item** As String

Sets or gets the selected tile. The tag name is used.  
  
**Events:**  

- **Click (tag** As String)

Raised when tile is cliked.  
  
**Properties:**  

- **Tiles Type** As String

**FilledWidth** - **TileWidth** is ignored, width is calculated based on **Tiles Per Row  
FixedWidth** -**Tiles per row** is ignored, actual width is used  

- **Tile Height** As Int

Tile height  

- **Tile Width** As Int

Tile width  

- **Corner Radius** As Int

Tile radius  

- **Gap Between Tiles** As Int

Gap distance  

- **Tiles Per Row** As Int

Number of tiles per row  

- **Background Color** As Int

Background Color for tiles  

- **Show Selected** As String

"border" - if the tile is selected, border is drawn in color SelectedColor  
"tile" - if the tile is selected, background is drawn in color SelectedColor  
"off" - the tile is not redrawn  

- **Selected Color** As Int

Borded Color  

- **Selected Border Width** As Int

Borded width  
  
**Functions:**  

- **AddLabel** (pTag As String, pText As String, pSize As Int, pBackgroundColor As Int) As Label

Add tile with label  

- **AddImage** (pTag As String, pBitmap As String, pBackgroundColor As Int) As ImageView

Add tile with image as-is  

- **AddImageResize** (pTag As String, pBitmap As String, pBackgroundColor As Int, pWidth As Int, pHeight As Int) As ImageView

Add tile with image nad resize  

- **AddLayout** (pTag As String, pLayout As String, pBackgroundColor As Int) As Panel

Add tile with layout  

- **FindTile** (search As String) As Panel

Find a tile with a specific tag  

- **DefaultColor** (pTag As String, pCol As Int)

Change default tile color for tile with a specific tag