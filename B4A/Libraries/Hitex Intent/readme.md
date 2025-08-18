### Hitex Intent by sadeq.hitex
### 10/27/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/123918/)

Hitex Intent is a almost complete intent  
  
 **Methods:**  

- **Initialize**
- **Initialize2 (Obj As Object)**
*obj can be :  
String  
Action and …  
B4A Activity  
Class<?>  
Intent  
 \_\_\_\_\_\_\_\_\_\_\_\_\_*
Example 1 :

```B4X
StartActivity(Intent.Initialize2(Main2).PutExtra("number","123456789"))
```

In Main 2 :

```B4X
Dim Intetnt As Hitex_Intent = Activity.GetStartingIntent  
Msgbox(Intetnt.GetExtra("number"),"TITLE")
```

*\_\_\_\_\_\_\_\_\_\_\_\_\_*
Example 2 :

```B4X
StartActivity(Intent.Initialize2("android.settings.WIFI_SETTINGS"))
```

*\_\_\_\_\_\_\_\_\_\_\_\_\_*
Example 3 :

```B4X
Intent.Initialize2(Intent.Actions.ACTION_GET_CONTENT)  
Intent.PutExtra("crop", "true")Intent.PutExtra("noFaceDetection", False)  
Intent.SetType("image/*")  
Intent.PutExtra("aspectX", 1).PutExtra("aspectY", 1)  
StartActivity(Intent)
```

*\_\_\_\_\_\_\_\_\_\_\_\_\_*
Example 4 :

```B4X
Intent.Initialize2(Intent.ACTION_SEND)Intent.PutExtra(Intent.Extras.EXTRA_EMAIL, Array As String("sadeq.hitex@gmail.com"))  
Intent.PutExtra(Intent.Extras.EXTRA_SUBJECT, "Hello, this is the subject line")  
Intent.PutExtra(Intent.Extras.EXTRA_TEXT, "Your Text")  
Intent.PutExtra(Intent.Extras.EXTRA_STREAM, Intent.Uri_FromFile(File.Combine(File.DirRootExternal,"1.jpg")))  
Intent.SetType("image/*")  
StartActivity(Intent.CreateChooser2(Intent,"Share via …"))
```

- **Initialize3 (Action As String, Uri As Object)**
Example :

```B4X
Dim Intent As Hitex_Intent  
StartActivity(Intent.Initialize3(Intent.ACTION_DIAL,"tel:0123456789"))
```

- **Initialize4 (Uri As String, Flags As Int)**
Example :

```B4X
intent.Initialize4("uri…", intent.Flags.FLAG_ACTIVITY_CLEAR_TOP)
```

- **SetClass (Class As Class<?>)**
- **SetClassName (ClassName As String)**
- **SetClassName2 (PackageName As String, ClassName As String)**
- **SetFlag (Flag As Int)**
Example :

```B4X
Intent.SetFlag(Intent.Flags.FLAG_ACTIVITY_NEW_TASK)
```

- **SetData (Uri As Object)**
- **SetAction (Action As String)**
Example 1 :

```B4X
Intent.SetAction(Intent.ACTION_VIEW)
```

Example 2 :

```B4X
Intent.SetAction(Intent.Actions.ACTION_BATTERY_LOW)
```

Example :

```B4X
Intent.setType("image/*")
```

- **SetComponent (Component As String)**
- **SetClipData (clip As ClipData)**
- **SetDataAndType (Data As Uri, Type As String)**
- **SetDataAndNormalize (Data As Uri)**
- **SetSelector (Intent As Intent)**
- **SetSourceBounds (Rect As Rect)**
- **SetPackage (Package As String)**
- **SetTypeAndNormalize (Type As String)**
- **ParseUri (Uri As String, Flags As Int)**
- **ParseIntent (Res As Resources, Parser As XmlPullParser, Attrs As AttributeSet)**
- **CreateChooser (Title As CharSequence)**
- **CreateChooser2 (Target As Intent, Title As CharSequence)**
- **CreateChooser3 (Target As Intent, Title As CharSequence, Sender As IntentSender)**
- **GetIntentOld (Uri As String) As Intent**
- **PutExtra (Name As String, Value As Object)**
Examples :

```B4X
Intent.putExtra("yourName", "yourContent")
```

```B4X
Intent.putExtra(Intent.Extras.EXTRA_EMAIL, Array As String("sadeq.hitex@gmail.com"))
```

```B4X
Intent.putExtra(Intent.Extras.EXTRA_SUBJECT, "Hello, this is the subject line")
```

```B4X
Intent.putExtra(Intent.Extras.EXTRA_TEXT, "Your Text")
```

```B4X
Intent.putExtra(Intent.Extras.EXTRA_STREAM, Intent.Uri_FromFile(File.Combine(File.DirRootExternal,"1.jpg")))
```

- **GetExtra (Name As String) As Object**
- **HasExtra (Name As String) As Boolean**
- **AddCategory (Category As String)**
Example :

```B4X
Intent.AddCategory(Intent.Categories.CATEGORY_APP_GALLERY)
```

- **Flag As Int**
- **GetDataString As String**
- **GetData As Uri**
- **Action As String**
- **Uri\_Parse (UriString As String) As Uri**
- **Uri\_FromFile (Path As String) As Uri**
Example :

```B4X
Intent.putExtra(Intent.Extras.EXTRA_STREAM, Intent.Uri_FromFile(File.Combine(File.DirRootExternal,"1.jpg")))
```

- **DescribeContents As Int**
- **FilterHashCode As Int**
- **FilterEquals (Intent As Intent) As Boolean**
- **Scheme As String**
- **ReplaceExtras (Intent As Intent)**
- **ReplaceExtras2 (Extras As Bundle)**
- **ResolveType As String**
- **RemoveExtra (Name As String)**
- **RemoveCategory (Category As String)**
- **CloneFilter**
- **Clone**
- **ReadFromParcel (In As Parcel)**
- **WriteToParcel (Out As Parcel, Flags As int)**
- **ToUri (Flags As Int) As String**
- **ExtrasToString As String**
- **ToString As String**
- **Would you like this library ? [**so donate it** ?.](https://www.paypal.com/paypalme/amirRecyclerView/5)**