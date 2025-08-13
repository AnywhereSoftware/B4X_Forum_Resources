### [BANano] SDcomponent by Star-Dust
### 04/09/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/164329/)

I created some custom components for BANano so that I can have better graphics without having to import heavy framework components that slow down the compilation. The result is acceptable at the moment and can be improved in the future. (Further information can be found [**here**](https://www.b4x.com/android/forum/threads/banano-one-step-ahead.164173/))  
[SIZE=3]*PS. This library required several weeks of work and many tests, if you want you can make a donation this is the fuel to keep going*[/SIZE]  
  
  
**Current Element list (31)**  
[TABLE]  
[TR]  
[TD]01 BananoSDorderMap  
02 SDbutton  
03 SDcalendar  
04 SDcol  
05 SDcombo  
06 SDcontainer  
07 SDdatepicker  
08 SDfunc  
09 SDgoogleMap  
10 SDgrid[/TD]  
[TD]11 SDicon  
12 SDimage  
13 SDinput  
14 SDlabel  
15 SDlist  
16 SDmenuHoriz  
17 SDpanel  
18 SDplanning  
19 SDplate  
20 SDrangebar[/TD]  
[TD]21 SDrow  
22 SDscrollHoriz  
23 SDseekbar  
24 SDselect  
25 SDsidebar  
26 SDstat  
27 SDstepper  
28 SDswitch  
29 SDthree  
30 SDtimepicker  
31 SDwordeditor  
32 SDcarousel  
33 SDClock[/TD]  
[/TR]  
[/TABLE]  
  

---

  
  
**BANanoSDcomponent  
  
Author:** Star-Dust  
**Version:** 1.02  
  
[SPOILER="CLASS AND METHOD"]  
  
  

- **BananoSDorderMap**

- **Functions:**

- **Clear**
*Clears the map.*- **ContainsKey** (Key As Object) As Boolean
*Tests whether the map contains the key.*- **Get** (Key As Object) As Object
*Gets the value mapped to the key.*- **GetDataForSerializator** As Object
*Returns an object that can be serialized with B4XSerializator.*- **GetDefault** (Key As Object, DefaultValue As Object) As Object
*Gets the value mapped to the key. Returns the passed DefaultValue is no such key exists.*- **GetKeyAt** (idx As Int) As Object
- **GetValueAt** (idx As Int) As Object
- **Initialize**
- **Put** (Key As Object, Value As Object)
*Puts a key / value pair to the map. If the key already exists the new value replaces the previous one (and the order doesn't change).*- **Remove** (Key As Object)
*Removes a pair from the map. This is an O(n) operation.*- **SetDataFromSerializator** (Data As Object)
*Sets the map data from a deserialized object.*
- **Properties:**

- **First** As Object [read only]
- **Keys** As List [read only]
*Returns the keys as a list. You can sort this list to change the order.*- **Last** As Object [read only]
- **Nth** As Object
- **Size** As Int [read only]
*Returns the map size.*- **Values** As List [read only]
*Returns a (copied) list of the collection values.*
- **SDbutton**

- **Events:**

- **Click** (event As BANanoEvent)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **backgroundColor** (Color As String)
- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **TextColor** (Color As String)
- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Text** As Object
- **Visible** As Boolean
*get/set if the component is visible*
- **SDcalendar**

- **Events:**

- **ChangeCalendar** (Year As Int, Month As Int)
- **DayClick** (Day As Int)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **ResetDay** (nDay As Int)
- **SetDay** (nDay As Int, TextColor As String, color As String)
*Cal.SetDay(10,"#4CAF50")*- **SetSelectDay** (nDay As Int, TextColor As String, color As String)
- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDcarousel**

- **Functions:**

- **AddImage** (imgUrl As String)
- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **Clearimage**
- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDcol**

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **backgroundColor** As String [write only]
- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDcombo**

- **Events:**

- **Selected** (Text As String)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **SetSuggestions** (Sugg As String)
- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDcontainer**

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDdatepicker**

- **Events:**

- **Click** (event As BANanoEvent)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **GetDate** As String
- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **SetDate** (Day As Int, Month As Int, Year As Int)
*tp.time="18:00"*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDfunc**

- **Functions:**

- **BANano\_namespace** As String
- **ConfigBody** (body As BANanoElement)
*Inside Banano\_Ready after body.Initialize*- **Initialize** (mBANano As BANano)
*Before Build - SDFunf.Initialize(Banano)*- **InitializeGmap** (key As String)
- **InitializeThreeD**
- **InitializeTS**
- **LoadingIndicator** (Show As Boolean)
- **MainLayout** As BANanoElement
- **NavigateTo** (MainPageElement As BANanoElement, LayoutName As String)
- **prompt** (Message As String, Default As String) As String
- **ResetMainLayout**
- **SDRegEx** (Pattern As String, str As String) As String()
- **SetBodyImage** (urlimage As String)
- **SetMainLayout** (B As BANanoElement)
- **ShowModal** (CallBack As Object, EventName As String, Title As String, Text As String, btnCancel As String, btnConfirm As String, btnOther As String)
*Event: EventName\_ModalClick(Success As Boolean)  
 <code>Private Sub EventName\_ModalClick(Success As Boolean)  
 'Your Code  
 End Sub</code>*- **ShowModalTimed** (Title As String, Text As String, DurationMS As Long)
- **ShowToast** (Text As String, Tpe As String, Durate As Int, Cancellable As Boolean)

- **SDgoogleMap**

- **Events:**

- **CenterMapMove** (Lat As Double, Lng As Double)
- **CircleClick** (CircleObject As BANanoObject)
- **CircleDblClick** (CircleObject As BANanoObject)
- **Click** (Lat As Double, Lng As Double)
- **DblClick** (Lat As Double, Lng As Double)
- **InfoWindowCloseClick** (InfoWindow As BANanoObject)
- **MarkerClick** (Title As String, MarkerObject As BANanoObject)
- **MarkerDblClick** (Title As String, MarkerObject As BANanoObject)
- **MouseMove** (Lat As Double, Lng As Double)
- **PolygonClick** (PolygonObject As BANanoObject)
- **PolygonDblClick** (PolygonObject As BANanoObject)
- **PolylineClick** (PolylineObject As BANanoObject)
- **PolylineDblClick** (PolylineObject As BANanoObject)
- **Ready** (Success As Boolean)
- **ZoomChanged** (Zoom As Int)

- **Functions:**

- **AddCircle** (Lat As Double, Lng As Double, Radius As Int, CornerColor As String, FillColor As String) As BANanoObject
- **AddInfoWindow** (Text As String, Lat As Double, Lng As Double) As BANanoObject
*AddInfoWindow("Hallo",Lat,Lng)*- **AddMarker** (Title As String, Lat As Double, Lng As Double, iconUrl As String) As BANanoObject
*gm.AddMarker("Home", Lar, Lng,"") ' standard icon  
gm.AddMarker("Home", Lar, Lng,"<http://maps.google.com/mapfiles/ms/icons/blue-dot.png>") ' custom icon*- **AddPolygon** (CornerColor As String, FillColor As String, ListCoordinate As List) As BANanoObject
*ListCoordinate.Add(CreateMap("lat":41.9028,"lng":12.4964))  
 AddPolygon("#000000","#FFFF00",ListCoordinate)*- **AddPolyline** (CornerColor As String, ListCoordinate As List) As BANanoObject
*ListCoordinate.Add((CreateMap("lat":41.9028,"lng":12.4964))  
 AddPolyline("#FF0000",ListCoordinate)*- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **GetCirclePosition** (Circle As BANanoObject) As Map
- **GetCircleRadius** (Circle As BANanoObject) As Int
- **GetInfoWindowText** (InfoWindow As BANanoObject) As String
- **GetMarkerPosition** (Marker As BANanoObject) As Map
- **GetObjDaggable** (GMobject As BANanoObject) As Boolean
- **GetPolyPath** (Poly As BANanoObject) As Map()
*GM.GetPolyPath(Polygon) -> array As Map {lat: , lng: }  
 <code>For Each M As Map In SDgoogleMap1.GetPolyPath(PolyObject)  
 Dim Lat As Double = M.Get("lat")  
 Dim Lng As Double = M.Get("lng")  
 BANano.Console.Log("Lat: " & Lat)  
 BANano.Console.Log("Lng: " & Lng)  
 Next  
 </code>*- **gmap\_r** (redy As Boolean, mmap As Object)
- **GoToAddress** (address As String)
- **GoToLL** (Lat As Double, Lng As Double)
- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **IsReady** As Boolean
- **Remove**
*removes the component from the parent tag*- **SetInfoWindowsPosition** (InfoWindow As BANanoObject, Lat As Double, Lng As Double)
- **SetInfoWindowsText** (InfoWindow As BANanoObject, text As String)
- **SetObjDaggable** (GMobject As BANanoObject, Draggable As Boolean)
- **SetObjVisible** (GMobject As BANanoObject, Vis As Boolean)
- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDgrid**

- **Events:**

- **Click** (Row As Int, Col As Int)
- **HeadClick** (Col As Int)

- **Functions:**

- **AddRow** (Column As String)
- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **Clear**
- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **refresh**
- **Remove**
*removes the component from the parent tag*- **SetGridBackgroundColor** (Color As String)
- **SetGridTextColor** (Color As String)
- **SetHeaderRowBackgroundColor** (Color As String)
- **SetHeaderRowTextColor** (Color As String)
- **SetRowBackgroundColor** (Color As String, Row As Int)
- **SetRowTextColor** (Color As String, Row As Int)
- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **BoldText** As Int [write only]
- **CellBackgroundColor** As Int [write only]
- **CellTextColor** As Int [write only]
- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **NormalText** As Int [write only]
- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Text** As Int [write only]
- **Visible** As Boolean
*get/set if the component is visible*
- **SDicon**

- **Events:**

- **Click** (event As BANanoEvent)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **backgroundColor** (Color As String)
- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **TextColor** (Color As String)
- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Text** As Object
- **Visible** As Boolean
*get/set if the component is visible*
- **SDimage**

- **Events:**

- **Click** (event As BANanoEvent)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDinput**

- **Events:**

- **Change** (event As BANanoEvent)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **GetChecked** As Boolean
- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **SetChecked** (value As Boolean)
- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Value** As String
- **Visible** As Boolean
*get/set if the component is visible*
- **SDlabel**

- **Events:**

- **Click** (event As BANanoEvent)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **label** As BANanoElement
- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **BackgroundColor** As String
- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Text** As String
- **TextColor** As String [write only]
- **TextgroundColor** As String [read only]
- **Visible** As Boolean
*get/set if the component is visible*
- **SDlist**

- **Events:**

- **Click** (Item As String, ID As String)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **Changeitem** (Items As String, idItems As String)
- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **BackgroundColor** As String [write only]
- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **TextColor** As String [write only]
- **Visible** As Boolean
*get/set if the component is visible*
- **SDmenuHoriz**

- **Events:**

- **Click** (Pos As Int, Item As String)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDpanel**

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDplanning**

- **Functions:**

- **AddElement** (posDay As Int, ID As String, time As Long, durationMinutes As Int) As BANanoElement
*the items will Be sorted by ID. We suggest entering the ID As the day-time  
 Example: 09:30 am -> ID = 5\_0930  
 AddElement(5,"5-0800",DateTime.TimeParse("08:00"),60)*- **AddItem** (posDay As Int, ID As String, time As Long, durationMinutes As Int, Text As String) As BANanoElement
*the items will Be sorted by ID. We suggest entering the ID As the day-time  
 Example: 09:30 am -> ID = 5\_0930  
 AddItem(0,"05-08:00",DateTime.TimeParse("08:00"),60, "Text 1")  
 AddItem(1,"06-08:00",DateTime.TimeParse("08:00"),60, "Text 1")*- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **Clear**
*Clear all*- **ClearDay** (posDay As Int)
*posDay = 0..6*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **ItemStateDay** (posDay As Int, Open As Boolean)
- **ItemStateID** (ID As String, Open As Boolean)
- **Remove**
*removes the component from the parent tag*- **SetHeader** (Title As String)
*SetHeader(Array As String("Title1","Title2","Title3","Title4","Title5","Title6","Title7"))*- **SetHeaderStyle** (BackgroundColor As String, TextColor As String)
*SetHeaderStyle("black","white")*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **ItemFromID** As BANanoElement
- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDplate**

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **PlateCar** As String
- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDrangebar**

- **Events:**

- **Change** (PercentStart As Double, PercentEnd As Double)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **ValueEnd** As Double
*0..100*- **ValueStart** As Double
*0..100*- **Visible** As Boolean
*get/set if the component is visible*
- **SDrow**

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **backgroundColor** As String [write only]
- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDscrollHoriz**

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **backgroundColor** As String [write only]
- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDseekbar**

- **Events:**

- **Change** (Percent As Double)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Value** As Double
*0..100*- **Visible** As Boolean
*get/set if the component is visible*
- **SDselect**

- **Events:**

- **Select** (ID As String, Item As String)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **ChangeOption** (Option As String, idOption As String)
- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **SetOptions** (EnumerationOption As String, EnumerationID As String)
*SetOptions("Opt1;Opt2;","ID1;ID2;")*- **SetSelectID** (IDoption As String)
- **SetSelectOption** (NameOption As String)
- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **SelectedID** As String [read only]
- **Selectedoption** As String [read only]
- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDsidebar**

- **Events:**

- **Click** (Pos As Int, Item As String)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **Opened** As Boolean
- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDstat**

- **Functions:**

- **AddPoint** (Name As String, Value As Double) As SDstat
*AddPinti(Name,Value) Value -> (0..100)*- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **Clear**
- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Draw**
- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **SetPaddingCart** (Pad As Int)
*SetPaddingCart(15)*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDstepper**

- **Events:**

- **Click** (event As BANanoEvent)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **BackgroundColor** As String
- **btnBackgroundColor** As String
- **btnTextColor** As String [write only]
- **btnTextgroundColor** As String [read only]
- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **TextColor** As String [write only]
- **TextgroundColor** As String [read only]
- **Value** As String
- **Visible** As Boolean
*get/set if the component is visible*
- **SDswitch**

- **Events:**

- **Click** (event As BANanoEvent)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **ActiveBackgroundColor** As String
- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **InactiveBackgroundColor** As String
- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Value** As Boolean
- **Visible** As Boolean
*get/set if the component is visible*
- **SDthree**

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **GetPositionX** As Double
- **GetPositionY** As Double
- **GetPositionZ** As Double
- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **SetPosition** (X As Double, Y As Double, Z As Double)
*set rotate degree*- **SetRotate** (X As Int, Y As Int, Z As Int)
*set rotate degree*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDtimepicker**

- **Events:**

- **Click** (event As BANanoEvent)

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **GetTime** As String
- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **SetTime** (Hours As Int, Minutes As Int)
*tp.time="18:00"*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
- **SDwordEditor**

- **Events:**

- **Open**
- **Save**

- **Functions:**

- **AddToParent** (targetID As String)
*add the component to a parent tag*- **BuildExStyle** As String
*internal method to build the style*- **content** As String
- **DesignerCreateView** (Target As BANanoElement, Props As Map)
*this is the place where you create the view in html and run initialize javascript*- **Initialize** (CallBack As Object, Name As String, EventName As String)
*initializes the component*- **Remove**
*removes the component from the parent tag*- **Trigger** (event As String, params As String)
*trigger an event*
- **Properties:**

- **Classes** As String
*set css classes to the main tag*- **Element** As BANanoElement [read only]
*returns the BANanoElement*- **Enabled** As Boolean
*get/set if the component is enabled*- **ID** As String [read only]
*returns the tag id*- **MarginBottom** As String
*get/set the margin bottom of the main tag*- **MarginLeft** As String
*get/set the margin left of the main tag*- **MarginRight** As String
*get/set the margin right of the main tag*- **MarginTop** As String
*get/set the margin top of the main tag*- **PaddingBottom** As String
*get/set the Padding bottom of the main tag*- **PaddingLeft** As String
*get/set the Padding left of the main tag*- **PaddingRight** As String
*get/set the Padding right of the main tag*- **PaddingTop** As String
*get/set the Padding top of the main tag*- **Style** As String
*get/set the style of the main tag*- **Tag** As Object
*get/set attach any object to the component*- **Visible** As Boolean
*get/set if the component is visible*
[/SPOILER]  

---

  

- Rel. 1.0
- Rel, 1.01
- Rel. 1.02 - Added **SDClock**

---

  
The **SDfunc** module contains some **important** methods:  
[INDENT]**InitializeGmap**: to be added in AppStart if using the google map[/INDENT]  
[INDENT]**InitializeThreeD**: Add to AppStart if using SDthree for 3D[/INDENT]  
[INDENT]**ConfigBody**: Always use after Body.Initialize[/INDENT]  
[INDENT]**SetBodyImage**: To create a fixed image background[/INDENT]  
[INDENT]**LoadingIndicator**: Usaer for waiting for an event[/INDENT]  
[INDENT]**SetMainLayout**: To set a panel as a routing page[/INDENT]  
[INDENT]**ShowToast**: For ToastMessages[/INDENT]  
[INDENT]**ShowModal**: Corresponds to MessageBox[/INDENT]  
[INDENT]**Prompt**: JS native MessageBox[/INDENT]  
[INDENT]**NavigateTo**: To change page, routing method[/INDENT]  

---

  
[SIZE=4]***PS. This library required several weeks of work and many tests, if you want you can make a donation this is the fuel to keep going***[/SIZE]