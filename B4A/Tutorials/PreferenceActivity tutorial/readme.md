### PreferenceActivity tutorial by Erel
### 05/10/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/10608/)

This tutorial explains how to use the new PreferenceActivity library. This library allows you to create the "standard" settings screen.  
  
The settings screen is hosted in its own activity. As this is an external activity its declaration should be manually added to the manifest file.  
I will take this opportunity to give some tips about manual modification of the manifest file which is sometimes required.  
  
**Editing AndroidManifest.xml (general overview)**  
As of Basic4android v1.8 it is no longer required to manually maintain the manifest file. Instead the manifest editor allows you to add extra elements as needed.  
See this link for more information: <http://www.b4x.com/forum/showthread.php?p=78136>  
For PreferenceActivity you should add the following code to the manifest editor:  

```B4X
AddApplicationText(<activity android:name="anywheresoftware.b4a.objects.preferenceactivity"/>)
```

  
**Back to PreferenceActivity**  
  
![](http://www.b4x.com/basic4android/images/preference_1.png)  
  
\* This image was taken on a Samsung Galaxy Tab device. On other devices the screen will look a bit different based on their default style.  
  
PreferenceActivity library includes two main objects: PreferenceScreen and PreferenceManager.  
PreferenceScreen is responsible for building the settings UI. PreferenceManager allows you to read the settings and also modify them by code.  
Both these objects should usually be declared in Sub Process\_Globals.  
The settings are saved in a file in the internal files folder. File handling is done automatically. Note that when you reinstall an application (without uninstalling it) the files are kept so the settings will also be kept.  
  
Each preference entry is stored as a key/value pair. The key is a string (case sensitive) and the value can be either a string or a boolean value.  
Each entry must have a unique key.  
  
**Building the UI**  
In order to build the UI we start with a PreferenceScreen object and add entries to this object directly or to PreferenceCategory which can hold other entries.  
In the above screenshot you can see a PreferenceScreen with two categories holding other entries.  
Note that a PreferenceScreen can also hold secondary PreferenceScreens. In this case when the user presses on the secondary entry a new screen will appear with its entries.  
There are three types of preference entries:  
- Checkbox  
- EditText - Opens an input dialog when the user presses on it.  
- List - Open a list dialog when the user presses on it, allowing the user to select a single item.  
The code that creates the above UI is:  

```B4X
Sub CreatePreferenceScreen  
    screen.Initialize("Settings", "")  
    'create two categories  
    Dim cat1, cat2 As PreferenceCategory  
    cat1.Initialize("Category 1")  
    cat1.AddCheckBox("check1", "Checkbox1", "This is Checkbox1", True)  
    cat1.AddCheckBox("check2", "Checkbox2", "This is Checkbox2", False)  
    cat1.AddEditText("edit1", "EditText1", "This is EditText1", "Hello!")  
   
    cat2.Initialize("Category 2")  
    cat2.AddList("list1", "List1", "This is List1", "Black", _  
        Array As String("Black", "Red", "Green", "Blue"))  
       
    'add the categories to the main screen  
    screen.AddPreferenceCategory(cat1)  
    screen.AddPreferenceCategory(cat2)  
End Sub
```

The first string in the Add methods is the entry key followed by the title, summary and default value.  
The default value is used if the key does not yet exist.  
  
To show the preferences we use this code:  

```B4X
Sub btn_Click  
    StartActivity(screen.CreateIntent)  
End Sub
```

**Reading the settings**  
Reading the settings is done with PreferenceManager.  
To retrieve the value of a specific key you should use Manager.GetString or Manager.GetBoolean with this key.  
You can get a Map with all the stored keys and values by calling Manager.GetAll  
If you want to only handle updated settings then you can call Manager.GetUpdatedKeys. This will return a List with the keys that were updated since the last call to this method.  
Usually you will want to handle settings updated in Activity\_Resume. Activity\_Resume will be called right after Activity\_Create when you start your program and also when the user closes the preferences screen.  
Whether you want to handle all keys or just the updated keys depends on your application.  
  
Tip:  
The default values set in the PreferenceScreen.Add calls have no effect till the user actually sees the screen. It is recommended to explicitly set the default values if they do not already exist.  
A simple way to do it is with code similar to:  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
    If FirstTime Then  
        CreatePreferenceScreen  
        If manager.GetAll.Size = 0 Then SetDefaults  
    End If  
End Sub  
  
Sub SetDefaults  
    'defaults are only set on the first run.  
    manager.SetBoolean("check1", True)  
    manager.SetBoolean("check2", False)  
    manager.SetString("edit1", "Hello!")  
    manager.SetString("list1", "Black")  
End Sub
```

This way our code in Activity\_Resume will work correctly whether it is the first time the program runs or after the user has closed the settings page.  
  
The program is attached.