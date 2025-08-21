### Allow user to select custom notification sound and have complete control over playing it by JohnC
### 03/11/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/114842/)

You can use the Ringtone Manager to allow the user to select a notification sound in your app. But the typical way of using the RTM to play it has many restrictions…  
  
1) After the user selects the sound, you can only "Play" and "Stop" using RTM.  
2) You can not easily control the volume without temporarily messing with the devices global volume setting.  
3) You can not easily play the file in a loop because you can not determine how long the file is or when it is done playing to know when to start a new play action.  
  
The below method allows you to use the MediaPlayer, so you can do all of the above things plus other methods like pause, etc that the mediaplayer provides.  
  
The URI that is typically returned by the Ringtonemanager is:  
  
**content://media/external/audio/media/32599**  
  
Which doesn't provide the "Sound Name" that the user chose or an filename/extension to know the audio format of the file. *UPDATE: Luckily another member (Wes58) posted some cool Inline Java to get the sound name from the URI, which I updated the below code to use. Which will come in handy to display it's name in the settings of your app to the user.*  
  
Even without a full filename, it appears the MediaPlayer will figure out how to play an audio file - probably by reading the file's header.  
  
Hope this codes helps you :)  
  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
  
    Dim AlarmURI As String  
  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
  
    Dim Rm As RingtoneManager  
    Dim MP As MediaPlayer  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    'Activity.LoadLayout("Layout1")  
  
    MP.Initialize2("mp")  
  
End Sub  
  
Sub cmdReminderPick_Click  
    'allow user to select from among alarm and nototification type sounds  
    '(and if AlarmURI has a value, preselect the same sound in the list)  
    Rm.ShowRingtonePicker("rm", Bit.Or(Rm.TYPE_ALARM,Rm.TYPE_NOTIFICATION), True, AlarmURI)  
End Sub  
  
Sub rm_PickerResult (Success As Boolean, Uri As String)  
  
    If Success Then  
        Log(Uri)  
        AlarmURI = Uri    'save for when calling showringtonepicker again so will pre-select same sound in the list  
  
        If Uri = "" Then  
            ToastMessageShow("Silent was chosen", True)  
  
        Else  
  
            'File.Copy("ContentDir",Uri,File.DirInternal,"sound.m4a")   'not needed  
            'MP.Load(File.DirInternal,"sound.m4a")    'not needed  
  
             Log("SoundName = " & GetURISoundName(URI))    'allows you to display/store name of sound to user (thanks to Wes58)  
  
             MP.Load("ContentDir", URI)        'load it into media player  
  
             Log("Length(msec):" & MP.Duration)  
  
             MP.Play                    'play it  
             Sleep(3000)                'but only for a preview amount of time  
             MP.Stop  
        End If  
  
    Else  
        'this branch will also happen if the user selects the same alarmuri as the previous  
        'nothing needs to be done because AlarmURI already contains the alarm the user wants  
        ToastMessageShow("Error loading ringtone.", True)  
    End If  
  
End Sub  
  
Sub mp_Complete  
    Log("done playing sound")  
End Sub  
  
Sub GetURISoundName (SoundURI As String) As String  
    'remember to include the below JAVA code from post #2  
    Private Jo As JavaObject  
    Jo.InitializeContext  
    Return Jo.RunMethod("getRingtoneTitle", Array As String(SoundURI))  
End Sub
```