### TabStrip by Erel
### 11/26/2020
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/80277/)

iTabStrip library implements a controller similar to B4A TabStripViewPager.  
It is based on XLPagerTabStrip: <https://github.com/xmartlabs/XLPagerTabStrip> (MIT license).  
  
![](https://www.b4x.com/android/forum/attachments/56317)  
  
Setup instructions:  
  
1. Add TabStrip with the designer.  
2. Create the tab pages layouts. Make sure to use anchors to allow the layouts to fill the available space.  
3. Set the pages by calling TabStrip.SetPages.  
4. **You need to put the ButtonCell.xip file under Files\Special.** You can find the file in the example project.  
  
The title used is the Page's title or the attributed text of a label that is set as the page's TitleView.  
  
Workaround to issue with devices with notch (all new devices): <https://www.b4x.com/android/forum/threads/white-bar-on-iphone-xs.107514/#post-672963>