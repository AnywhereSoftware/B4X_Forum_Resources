### Tiles_JE by Jerryk
### 01/12/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/167614/)

I created a new custom view where the user continues to run the application based on the information displayed in the tiles. There are three types of information that can be displayed:  

- label
- image
- layout

The tiles are scrollable. The width of the tiles can be fixed or flexible. Each tile is assigned a unique tag, which is passed in the Click event when clicked. Examine the example.  
  
  
![](https://www.b4x.com/android/forum/attachments/165051)  
  
**Tiles\_JE  
Author: Jerryk  
Version: 1.62  
  
[SIZE=5]Methods:[/SIZE]**  

- **SelectedItem** As String

Sets or gets the selected tile. The tag name is used.  
  
**[SIZE=5]Events:[/SIZE]**  

- **Click** (pId As String, pTag As Object)

Raised when tile is cliked.  
  
**[SIZE=5]Properties:[/SIZE]**  

- **TilesType** As String

**FilledWidth** - **TileWidth** is ignored, width is calculated based on **Tiles Per Row  
FixedWidth** -**Tiles per row** is ignored, actual width is used  

- **TileHeight** As Int

Tile height  

- **TileWidth** As Int

Tile width  

- **CornerRadius** As Int

Tile radius  

- **Gap Between Tiles** As Int

Gap distance  

- **TilesPerRow** As Int

Number of tiles per row  

- **BackgroundColor** As Int

Background Color for tiles  

- **ShowSelected** As String

"border" - if the tile is selected, border is drawn in color SelectedColor  
"tile" - if the tile is selected, background is drawn in color SelectedColor  
"off" - the tile is not redrawn  

- **SelectedColor** As Int

Borded Color  

- **SelectedBorderWidth** As Int

Borded width  

- **ShowDefaultBorder** As Boolean

Draw default border for tiles  

- **BorderColor** As Int

Color for default border for tiles  

- **BorderWidth** As Int

Width of default border  
  
  
**[SIZE=5]Functions:[/SIZE]**  

- **AddLabel** (pId As String, pText As String, pSize As Int, pBackgroundColor As Int, pTag As Object) As Label

Add tile with label  

- **AddImage** (pId As String, pBitmap As String, pBackgroundColor As Int, pTag As Object) As ImageView

Add tile with image as-is  

- **AddImageResize** (pId As String, pBitmap As String, pBackgroundColor As Int, pWidth As Int, pHeight As Int, pTag As Object) As ImageView

Add tile with image nad resize  

- **AddLayout** (pId As String, pLayout As String, pBackgroundColor As Int, pTag As Object) As Panel

Add tile with layout  

- **FindTile** (search As String) As Panel

Find a tile with a specific tag  

- **DefaultColor** (pTag As String, pCol As Int)

Change default tile color for tile with a specific tag  

- **AddToParent** (Parent As B4XView, Left As Int, Top As Int, Width As Int, Height As Int)

Add class programmatically  

- **GetBase**

Gets Base of the object  

- **RedrawTiles**

redraws tiles after changing a property  

- **DeleteTile** (pTag As String)

delete tile  

- **SetMaxHeight**

sets the view height according to the total height of the tiles  

- **CenterHorizontally**

center view horrizontally