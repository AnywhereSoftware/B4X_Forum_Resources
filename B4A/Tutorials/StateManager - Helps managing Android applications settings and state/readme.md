### StateManager - Helps managing Android applications settings and state by Erel
### 09/30/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/9777/)

**Edit: StateManager was written in 2011. I don't recommend using it for new projects. Use B4XPages + KVS2 instead.**  
  
StateManager is a code module which takes care of handling the application UI state and settings.  
  
**Settings**  
Settings are the application configurable settings. These settings should be permanently kept.  
  
The methods for handling settings are pretty simple:  
**StateManager.GetSetting (Key As String) As String:** gets the value associated with the given key. An empty string will return if the key is not available. The settings will be loaded from a file if they were not loaded before.  
  
**StateManager.GetSetting2 (Key As String, DefaultValue As String) As String:** similar to GetSetting. The DefaultValue will return if the key was not found.  
  
**StateManager.SetSetting(Key As String, Value As String):** Associates the given value with the gives key. Note that there is no need to call SaveSettings after each call to SetSetting.  
  
**StateManager.SaveSettings:** saves the settings to a file. Usually you will want to call this method in Activity\_Pause.  
  
**UI State**  
The UI state is a bit more interesting. In some cases Android may destroy our activity and then recreate it when needed. This happens for example when the user changes the screen orientation. If the user has entered some text in an EditText view then we want to keep this text. So instead of resetting the UI we are first saving the state and then we will restore it.  
  
Not all the elements are saved. Only elements which the user interacts with (like EditText text, Spinner chosen item, SeekBar value…).  
Using StateManager to handle the state is simple:  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
  
    …  
    'Load the previous state  
    If StateManager.RestoreState(Activity, "Main", 60) = False Then  
        'set the default values  
        EditText1.Text = "Default text"  
        EditText2.Text = "Default text"  
    End If  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
    If UserClosed Then  
        StateManager.ResetState("Main")  
    Else  
        StateManager.SaveState(Activity, "Main")  
    End If  
    StateManager.SaveSettings  
End Sub
```

When the activity is paused we check if the user chose to close the activity (by pressing on the Back key). In that case we reset the state. The string parameter is the ActivityName value. StateManager can manage the state of multiple activities so the name is used to differentiate between the activities.  
If UserClosed=False then we want to save the state.  
The **settings** are saved in both cases.  
  
When the activity is created we call: StateManager.RestoreState. The last parameter is the validity period for this state. The state will not be loaded if more than the specified minutes have passed. Pass 0 for an unlimited period.  
RestoreState returns a boolean value. It returns true if the state was loaded. If the state wasn't loaded it is your responsibility to set the default value. This will be the case when the user runs the application for the first time.  
  
To use StateManager you should choose Project - Add Existing Module and add StateManager.bas which is included in the attached example. You should also add a reference to the RandomAccessFile library and Reflection library.  
  
![](http://www.b4x.com/basic4android/images/statemanager_1.png)  
  
**Version 1.11 is attached. It adds support for saving and restoring TabHost views with their internal views.**