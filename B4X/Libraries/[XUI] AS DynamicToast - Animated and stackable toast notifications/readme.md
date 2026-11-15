###  [XUI] AS DynamicToast - Animated and stackable toast notifications by Alexander Stolte
### 11/12/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/172541/)

This view makes it easy to add animated toast notifications to your app. It handles stacking, positioning and automatic dismissal with just a few lines of code.  
  
![](https://www.b4x.com/android/forum/attachments/174802) ![](https://www.b4x.com/android/forum/attachments/174803) ![](https://www.b4x.com/android/forum/attachments/174804)  
  
![](https://www.b4x.com/android/forum/attachments/174805) ![](https://www.b4x.com/android/forum/attachments/174806) ![](https://www.b4x.com/android/forum/attachments/174807)  
  
**Features**  

- Written in B4X for B4A, B4i and B4J
- Default, Success, Error, Info, Warning and Loading toasts
- Animated stacking with tap to expand or collapse
- Swipe to dismiss with spring-back animation
- Top and bottom positioning, globally or per toast
- Title, description, custom icons and custom content
- Action, Cancel and optional Close buttons
- Automatic dismissal with configurable duration and pause during interaction
- Update existing toasts using the same ID
- Custom colors, fonts, spacing and corner radius
- Dismissal events, active toasts and history

  
**Example**  

```B4X
Sub Class_Globals  
    Private Toast As AS_DynamicToast  
End Sub  
  
Public Sub Initialize  
End Sub  
  
Private Sub B4XPage_Created(Root1 As B4XView)  
    Toast.Initialize(Me, "Toast")  
    Toast.CreateViewPerCode(Root1, 0, 0, Root1.Width, Root1.Height)  
    Toast.CloseButton = True  
  
    Toast.Success("Saved", CreateMap("description": "Your changes have been saved."))  
End Sub  
  
Private Sub B4XPage_Resize(Width As Int, Height As Int)  
    Toast.Resize(Width, Height)  
End Sub
```

  
  
**Update a loading toast**  

```B4X
Dim ToastId As Object = Toast.Loading("Uploading…", CreateMap())  
  
'After your operation has finished:  
Toast.Success("Upload complete", CreateMap("id": ToastId, "duration": 4000))
```

  
  
**Note**  
B4i and B4J have not yet been verified. The default Loading toast stays visible until updated or dismissed and has no spinner.  
Callback Sub names passed through Maps must contain an underscore, for example Toast\_CustomBody, when using Release obfuscation.  
  
[SPOILER="Properties, Functions, Events, etc."]  
**AS\_DynamicToast  
  
Author:** Alexander Stolte  
**Version:** 1.00  

- **AS\_DynamicToast**

- **Events:**

- **Action** (Id As Object)
- **AutoClose** (Toast As Map)
- **Cancel** (Id As Object)
- **Dismiss** (Toast As Map)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **ClearHistory** As String
- **Configure** (Options As Map) As String
*Provider options: position, duration, gap, visibleToasts, expand, offset, closeButton, swipeToDismiss.*- **CreateToast** (Title As Object, ToastType As String, Options As Map) As Object
*Existing IDs merge options and retain stack order. Reusing a dismissed ID shows it again.*- **CreateViewPerCode** (Parent As B4XView, Left As Float, Top As Float, Width As Float, Height As Float) As String
*Attach once to a page/root. The empty viewport does not intercept input.*- **Custom** (Body As Object, Options As Map) As Object
*Body: native view/B4XView or factory Sub EventName(Id As Object, Body As B4XView).  
 The factory sets Body.Height if a different height is needed.  
 Use callback Sub names with an underscore, e.g. Toast\_CustomBody, for Release builds.*- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **Dismiss** (Id As Object) As String
- **DismissAll** As String
- **Dispose** As String
- **Error** (Title As Object, Options As Map) As Object
- **GetActive** As List
*Active/pending toasts, newest first. Returned maps are defensive copies.*- **GetHistory** As List
- **Info** (Title As Object, Options As Map) As Object
- **Initialize** (Callback As Object, EventName As String) As String
- **Loading** (Title As Object, Options As Map) As Object
- **Message** (Title As Object, Options As Map) As Object
- **Pause** As String
- **Promise** (Work As ResumableSub, Options As Map) As ResumableSub
*B4X equivalent of the source emitter Promise helper. Work returns  
 Map("success": Boolean, "data": Object). Renderer callbacks receive data.*- **Refresh** As String
- **Resize** (Width As Double, Height As Double) As String
- **Resume** As String
- **SetSafeAreaInsets** (Top As Float, Bottom As Float) As String
*Use a safe-area page root or supply explicit insets for a full-window root.*- **Show** (Title As Object, Options As Map) As Object
*Options: id, description, icon, duration (-1 = infinite), dismissible, position,  
 action/cancel ({label, Callback, EventName}), onDismiss/onAutoClose ({Callback, EventName}).  
 Content: String, native view/B4XView, or {Callback, EventName} factory returning content.*- **Success** (Title As Object, Options As Map) As Object
- **ToggleExpand** As String
- **Warning** (Title As Object, Options As Map) As Object

- **Properties:**

- **CloseButton** As Boolean
*Default: False*- **DescriptionStyle** As Map
- **Duration** As Long
*Default: 4000 milliseconds*- **Expand** As Boolean
*Default: False*- **Expanded** As Boolean
- **Gap** As Float
*Default: 14dip*- **Icons** As Map
- **Offset** As Float
*Default: 16dip*- **Position** As String
*Default: bottom*- **Style** As Map
- **SwipeToDismiss** As Boolean
*Default: True*- **TitleStyle** As Map
- **ToastStyle** As Map
- **VisibleToasts** As Int
*Default: 3*
[/SPOILER]  
  
**Changelog**  

- **1.00**

- Release

  
Have fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)