### Grid in a CustomListView for B4A: Icon Selector with Lazy Loading by GeoT
### 04/16/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/170834/)

TECHNIQUE  
- Builds a grid from CustomListView rows using nested panels (outer loop = rows, inner loop = cells)  
- itemHeight scales automatically from itemWidth via aspect ratio  
- Elements centered programmatically (photoLeft, lblHeight)  
  
![](https://www.b4x.com/android/forum/attachments/171167) ![](https://www.b4x.com/android/forum/attachments/171168)  
  
ARCHITECTURE  
- MainPage layout contains the CLV; lyItemGrid is the layout for each cell  
- Fixed view hierarchy:  
 pnlCell (dynamic, CreatePanel)  
 └─[0] pnlBase ← lyItemGrid root  
 ├─[0] ivPhoto  
 └─[1] lblName  
 Dim iv As ImageView = pCell.GetView(0).GetView(0)  
- pnlCell is the dynamic container that receives the click event  
 and the visual selection effect (SetColorAnimated)  
  
DATA & LOADING  
- Monochrome vector icons loaded from AddResources folder via AndroidResources  
- pnlCell.Tag (Map) is the data source: holds the icon name and "loaded" flag  
- Lazy loading via CLV1\_VisibleRangeChanged  
- Memory is not released between views: few images, lightweight vectors  
- For larger images, see post 2  
  
NOTES  
- Built for B4A (icon selector use case)  
- Developed with AI assistance