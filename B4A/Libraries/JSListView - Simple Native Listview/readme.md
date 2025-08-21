### JSListView - Simple Native Listview by SNOUHyhQs2
### 08/23/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/73722/)

[SIZE=5]**UPDATE:**[/SIZE] Library and Samples are uploaded to [GitHub](https://github.com/salvadorjhai/B4A-JSListView)  
  
**JSListView** ~ requires list for DataAdapter  
**JSListView2** (Latest) ~ requires JSDataAdapter library (also available in [github](https://github.com/salvadorjhai/B4A-JSDataAdapter))  
  
There are also sample file which you can download on github.  
I also added an example where list item (viewcontainer) contains plus and minus button/  
  
*Im a bit busy so i cant respond to all question so just check the provided sample.*  
  
**Features:**  
~ Load custom layout for your items, use designer to build your item  
~ Uses List and Cursor for your Datasource  
~ Uses Adapter Which is set once you set your Datasource  
~ Minimum Android: API 11  
  
![](https://www.b4x.com/android/forum/attachments/50580) ![](https://www.b4x.com/android/forum/attachments/50581) ![](https://www.b4x.com/android/forum/attachments/50582) ![](https://www.b4x.com/android/forum/attachments/50583) ![](https://www.b4x.com/android/forum/attachments/50584) ![](https://www.b4x.com/android/forum/attachments/50585)  
  
[SPOILER="Module Reference"]  
**JSListView  
Author:** salvadorjhai  
**Version:** 0.8  

- **ItemViewLayout**
Methods:

- **findViewById** (id As Int) **As View**
*Find view by id.  
id: the id  
Return type: @return:the view*- **findViewWithTag** (tag As Object) **As View**
*Find view with tag.  
tag: the tag  
Return type: @return:the view*- **setViewId** (v As View, id As Int)
*Set id to view  
v: View  
id:* 
**Properties:**

- **Container As ViewGroup**
*Gets the container.*- **Height As Int**
*Gets the height.*- **Width As Int**
*Gets the width.*
- **JSListView**
Events:

- **OnGetView** (position As Int, itemLayout As ItemViewLayout, forViewUpdate As Boolean)
- **OnItemClick** (view As ItemViewLayout, position As Int)
- **OnItemLongClick** (view As ItemViewLayout, position As Int)

**Fields:**

- **OVER\_SCROLL\_ALWAYS As Int**
- **OVER\_SCROLL\_IF\_CONTENT\_SCROLLS As Int**
- **OVER\_SCROLL\_NEVER As Int**

**Methods:**

- **BringToFront**
- **DesignerCreateView** (paramPanelWrapper As PanelWrapper, paramLabelWrapper As LabelWrapper, paramMap As Map)
- **Initialize** (eventName As String)
- **Invalidate**
- **Invalidate2** (arg0 As Rect)
- **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **IsFastScrollAlwaysVisible As Boolean**
*Returns true if the fast scroller is set to always show on this view.  
Return type: @return:true if the fast scroller will always show*- **IsFastScrollEnabled As Boolean**
*Returns true if the fast scroller is enabled.  
Return type: @return:true if fast scroll is enabled, false otherwise*- **IsInitialized As Boolean**
- **ItemAdd** (data As Object)
*Item add.  
data: the data*- **ItemAddAt** (Index As Int, data As Object)
*Add item at specific position  
Index: position  
data: data*- **ItemClearAll**
*Clear all item on the listview*- **ItemRemoveAt** (position As Int)
*Item remove at.  
position: the position*- **ItemUpdateAt** (position As Int, data As Object)
*Item update at.  
position: the position  
data: the new data*- **RemoveView**
- **RequestFocus As Boolean**
- **SendToBack**
- **SetBackgroundImage** (arg0 As Bitmap)
- **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
- **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
- **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)
- **addFooterView** (v As View, data As Object, isSelectable As Boolean)
*Add a fixed view to appear at the bottom of the list. If addFooterView is  
called more than once, the views will appear in the order they were  
added. Views added using this call can take focus if they want.  
NOTE: Call this before calling setAdapter. This is so ListView can wrap  
the supplied cursor with one that will also account for header and footer  
views.  
v: The view to add.  
data: Data to associate with this view  
isSelectable: true if the footer view can be selected*- **addHeaderView** (v As View, data As Object, isSelectable As Boolean)
*Add a fixed view to appear at the top of the list. If addHeaderView is  
called more than once, the views will appear in the order they were  
added. Views added using this call can take focus if they want.  
NOTE: Call this before calling setAdapter. This is so ListView can wrap  
the supplied cursor with one that will also account for header and footer  
views.  
v: The view to add.  
data: Data to associate with this view  
isSelectable: whether the item is selectable*- **smoothScrollByOffset** (offset As Int)
*Smooth scroll by offset.  
offset: the offset*- **smoothScrollToPosition** (position As Int)
*Smooth scroll to position.  
position: the position*
**Properties:**

- **Background As Drawable**
- **CacheColorHint As Int** *[write only]*
When set to a non-zero value, the cache color hint indicates that this list is always drawn on top of a solid, single-color, opaque background. Zero means that what's behind this object is translucent (non solid) or is not made of a single color.- **Color As Int** *[write only]*
- **DataSource As List**
*Get data source.*- **Divider As Drawable**
*Gets the divider.*- **DividerHeight As Int**
*Gets the divider height.*- **EmptyView As View**
*When the current adapter is empty, the AdapterView can display a special view  
call the empty view. The empty view is used to provide feedback to the user  
that no data is available in this AdapterView.*- **Enabled As Boolean**
- **FastScrollAlwaysVisible As Boolean** *[write only]*
Set whether or not the fast scroller should always be shown in place of the standard scroll bars.- **FastScrollEnabled As Boolean** *[write only]*
Specifies whether fast scrolling is enabled or disabled.- **FooterDividersEnabled As Boolean** *[write only]*
Sets the footer dividers enabled.- **HeaderDividersEnabled As Boolean** *[write only]*
Sets the header dividers enabled.- **Height As Int**
- **ItemsCanFocus As Boolean** *[read only]*
Gets the items can focus.- **Left As Int**
- **OverScrollMode As Int**
*Returns the over-scroll mode for this view. The result will be one of OVER\_SCROLL\_ALWAYS (default), OVER\_SCROLL\_IF\_CONTENT\_SCROLLS (allow over-scrolling only if the view content is larger than the container), or OVER\_SCROLL\_NEVER.*- **OverscrollFooter As Drawable**
*Gets the overscroll footer.*- **OverscrollHeader As Drawable**
*Gets the overscroll header.*- **Parent As Object** *[read only]*
- **Selection As Int** *[write only]*
Sets the selection.- **Selector As Drawable**
*Gets the selector.*- **Tag As Object**
- **Top As Int**
- **Visible As Boolean**
- **Width As Int**

  
[/SPOILER]  
  
[SPOILER="Example Code"]  

```B4X
    ' Process_Globals  
    Dim recipes as List  
  
    ' Global  
    ' Views from your layout file  
    Private JSListView1 As JSListView  
    Private ImageView1 As ImageView  
    Private Label1 As Label  
    Private Label2 As Label  
  
    ' Activity Create  
    ' Load your list, im using JSON file for this example  
    Dim js As JSONParser  
    js.Initialize(File.ReadString(File.DirAssets, "recipes.json"))  
    Dim m As Map = js.NextObject  
    recipes = m.Get("recipes")  
  
    ' Set your data source  
    JSListView1.DataSource = recipes  
  
' Use OnGetView to handle item layout  
Sub JSListView1_OnGetView(position As Int, itemLayout As ItemViewLayout, forViewUpdate As Boolean)  
    Dim iv As ItemViewLayout = itemLayout  
  
    If forViewUpdate = False Then  
        ' Load layout to panel (REQUIRED)  
        Dim p As Panel  
        p.Initialize("")  
        p.LoadLayout("TwoLineAndBitmap")  
   
        ' assign this panel to ItemViewLayout (REQUIRED)  
        iv.Container = p  
   
        ' since B4A doesn't use setID, will use tag instead  
        ' tag is needed so set it (REQUIRED)  
        Label1.Tag = 1  
        Label2.Tag = 2  
        ImageView1.Tag = 3  
   
        ' Custom adjustment on our layout  
        Label1.Width = 100%x - Label1.Left - 10dip  
        Label2.Width = 100%x - Label2.Left - 10dip  
   
        '  
        Label1.Typeface = Typeface.LoadFromAssets("JosefinSans-Bold.ttf")  
        Label2.Typeface = Typeface.LoadFromAssets("JosefinSans-SemiBoldItalic.ttf")  
        Label1.Gravity = Gravity.TOP  
        Label2.Gravity = Gravity.TOP  
      
        ' Set the Width and Height of your item layout (ItemViewLayout) (REQUIRED)  
        iv.Height = ImageView1.Top + ImageView1.Height + 10dip  
        iv.Width = 100%x  
   
        ' some more adjustment to our item  
        Label1.Height = 15dip  
        Label2.Top = Label1.Top + Label1.Height  
        Label2.Height = iv.Height - Label2.Top - 10dip  
    End If  
  
    ' im using json  
    ' get fields from recipes (json)  
    Dim mapper As Map = recipes.Get(position)  
  
    ' get views (REQUIRED), else android will get confuse which view it is.  
    Label1 = iv.findViewWithTag(1)  
    Label2 = iv.findViewWithTag(2)  
    ImageView1 = iv.findViewWithTag(3)  
  
    ' set data  
    Label1.Text = mapper.Get("title")  
    Label2.Text = mapper.Get("description")  
  
    ' load image from web  
    Dim picaso As Picasso  
    picaso.Initialize  
    picaso.LoadUrl(mapper.Get("image")).Resize(ImageView1.Width,ImageView1.Height).CenterCrop.IntoImageView(ImageView1)  
  
End Sub
```

  
[/SPOILER]  
  
**Attached is the Library which you will extract on your Additional Library Folder  
  
Sample project is also attached.**   
*You will need the following to run this example:*   
1. [Picasso Library](https://www.b4x.com/android/forum/threads/picasso-image-downloading-and-caching-library.31495/#content)  
2. [AppCompat](https://www.b4x.com/android/forum/threads/appcompat-make-material-design-apps-compatible-with-older-android-versions.48423/#content)  
3. JSON - i think this is built in library