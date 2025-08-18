### ErrorView Wrapper by jahswant
### 05/10/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/55917/)

Is there an ErrorView in this forum ? I don't know ! This is one.<https://github.com/xiprox/ErrorView>  
**ErrorView  
Version:** 0.5  

- **ErrorView**
Events:

- **onClick**
- **onRetry**

- **Fields:**

- **ba As BA**

- **Methods:**

- **AddToParent** (Parent As ViewGroup, left As Int, top As Int, width As Int, height As Int)
- **BringToFront**
- **DesignerCreateView** (base As PanelWrapper, lw As LabelWrapper, props As Map)
- **Initialize** (EventName As String)
- **Invalidate**
- **Invalidate2** (arg0 As Rect)
- **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **IsInitialized As Boolean**
- **RemoveView**
- **RequestFocus As Boolean**
- **SendToBack**
- **SetBackgroundImage** (arg0 As Bitmap)
- **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
- **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
- **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)
- **isRetryButtonVisible As Boolean**
*Indicates whether the retry button is visible.*- **isSubtitleVisible As Boolean**
*Indicates whether the subtitle is currently visible.*- **isTitleVisible As Boolean**
*Indicates whether the title is currently visible.*- **showRetryButton** (show As Boolean)
*Shows or hides the retry button.*- **showSubtitle** (show As Boolean)
*Shows or hides error subtitle.*- **showTitle** (show As Boolean)
*Shows or hides the error title*
- **Properties:**

- **Background As Drawable**
- **Color As Int** *[write only]*
- **Enabled As Boolean**
- **Error As Int** *[write only]*
Sets error subtitle to the description of the given HTTP status code- **Height As Int**
- **Image As Bitmap** *[write only]*
Sets the error image to a given {@link android.graphics.Bitmap}.- **ImageBitmap As Bitmap** *[write only]*
Sets the error image to a given {@link android.graphics.Bitmap}.- **Left As Int**
- **RetryButtonText As String**
*Returns the current retry button text.*- **RetryButtonTextColor As Int**
*Returns the current retry button text color.*- **Subtitle As String**
*Returns the current subtitle.*- **SubtitleAlignment As Int** *[write only]*
Sets the subtitle's alignment to a given value- **SubtitleColor As Int**
*Returns the current subtitle text color.*- **Tag As Object**
- **Title As String**
*Returns the current title string.*- **TitleColor As Int**
*Returns the current title text color.*- **Top As Int**
- **Visible As Boolean**
- **Width As Int**

  
What are the possible HTTP Codes Supported ?  
  
 (400, "Bad Request");  
 (401, "Unauthorized");  
 (402, "Payment Required");  
 (403, "Forbidden");  
 (404, "Not Found");  
 (405, "Method Not Allowed");  
 (406, "Not Acceptable");  
 (407, "Proxy Authentication Required");  
 (408, "Request Timeout");  
 (409, "Conflict");  
 (410, "Gone");  
 (411, "Length Required");  
 (412, "Precondition Failed");  
 (413, "Request Entity Too Large");  
 (414, "Request-URI Too Long");  
 (415, "Unsupported Media Type");  
 (416, "Requested Range Not Satisfiable");  
 (417, "Expectation Failed");  
  
 (500, "Internal Server Error");  
 (501, "Not Implemented");  
 (502, "Bad Gateway");  
 (503, "Service Unavailable");  
 (504, "Gateway Timeout");  
 (505, "HTTP Version Not Supported");  
 ![](https://www.b4x.com/android/forum/attachments/35654)