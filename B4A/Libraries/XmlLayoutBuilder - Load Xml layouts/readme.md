### XmlLayoutBuilder - Load Xml layouts by Erel
### 02/20/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/33762/)

**Edit: this tutorial was written before CreateResouce keyword was available. Simpler usage example:**   
<https://www.b4x.com/android/forum/threads/make-edittext-cursor-more-visible.114148/>  
  
The standard way to build the UI in Basic4android is with the visual designer / designer script.  
  
You can also create UI elements by code.  
  
This library adds a third option which is to use xml files to define the layout. This is Google's standard method.  
  
This option is especially useful if you want to reuse resources created for an Android Java project.  
  
All three options can be combined together.  
  
This library provides several resources related methods. You can read more about Android resources here: <http://developer.android.com/guide/topics/ui/declaring-layout.html>  
  
Before we start you should remember that the compiler "cleans" the objects folder during compilation. The compiler will delete the extra resource files if they are not read-only.  
  
The simplest solution is to add the following attribute to force all the res files to be read-only:  

```B4X
  #CustomBuildAction: 1, c:\windows\system32\attrib.exe, +r res\*.* /s
```

  
You might need to correct the path.  
  
The example code is:  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
   Dim x As XmlLayoutBuilder  
   'load the layout  
   x.LoadXmlLayout(Activity, "layout1")  
   'load the Animation  
   anim = x.LoadAnimation("wave_scale", "anim")  
   'get a view based on the id  
   button1 = x.GetView("fade_animation")  
   'get a drawable object  
   Activity.Background = x.GetDrawable("smlnpatch160dpi")  
  
   Panel1 = x.GetView("panel1")  
   Panel1.Color = Colors.White  
   Dim spinner1 As Spinner  
   spinner1.Initialize("")  
   spinner1.AddAll(Array As String("1", "2", "3"))  
   Panel1.AddView(spinner1, 0, 0, Panel1.Width, Panel1.Height)  
End Sub
```

  
  
Folder structure:  
  
![](http://www.b4x.com/basic4android/images/SS-2013-10-22_11.11.30.png)  
  
Layout file:  

```B4X
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"  
  android:layout_width="fill_parent"  
  android:layout_height="fill_parent"  
  android:paddingLeft="16dp"  
  android:paddingRight="16dp"  
  android:orientation="vertical" >  
  
  
   <TextView  
  android:layout_width="match_parent" android:layout_height="wrap_content"  
  android:layout_weight="0" android:paddingBottom="4dip"  
  android:textAppearance="?android:attr/textAppearanceMedium"  
  android:text="@string/activity_animation_msg"/>  
  
   <Button android:id="@+id/fade_animation"  
  android:layout_width="wrap_content" android:layout_height="wrap_content"  
  android:text="@string/activity_animation_fade"  
     android:tag="Button1"  
     >  
  <requestFocus />  
  </Button>  
   <Panel  
     android:id="@+id/panel1"  
  android:layout_width="200dp" android:layout_height="80dp">  
   </Panel>  
  
  <CheckBox  
  android:layout_width="wrap_content"  
  android:layout_height="wrap_content"  
     android:tag="chk1" />  
</LinearLayout>
```

  
  
LoadXmlLayout method loads the layout file and adds the views to the activity or panel.  
Once the layout is loaded you can use GetView to get a reference to a view based on the view's id attribute.  
  
If you want to handle the view's events then you need to set the "EventName" in android:tag attribute.  
You can handle events of the following views:  
EditText, Button, CheckBox, RadioButton, Label (TextView), AutoCompleteEditText (AutoCompleteTextView), ToggleButton, ImageView, SeekBar and Panel.  
  
Panel is treated differently as it is not a native view. Panel allows you to add other views (programmatically or with Panel.LoadLayout) to the loaded layout.  
  
LoadAnimation loads an Animation object defined in an xml file. It allows you to create all kinds of animations including a set of animations (not possible with the standard Animations library).  
<http://developer.android.com/guide/topics/graphics/view-animation.html>  
  
The other methods allow you to load drawables and strings from the resource files.  
  
**Notes**  
  
- When using the rapid debugger, you need to right click on the libraries tab and choose Refresh after you update the resources. Otherwise the device app may not be redeployed and the old resources will be used.