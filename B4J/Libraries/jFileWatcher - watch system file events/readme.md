### jFileWatcher - watch system file events by Roycefer
### 04/24/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/56613/)

This library wraps many capabilities from the java.nio.file package and a few from the java.io.File package. It allows you to set certain directories to be watched, raising events when files or folders within those directories are created, deleted or modified. Additionally, this library enables you to get and set last access time, last modified time, creation time, read-only state and hiddenness of files. Beware, some operating systems won't support all of those attributes.  
  
On Windows, this library performs quite well, using the system's native file events and consuming only a minuscule amount of system resources. The latency was also extremely low. On systems that don't have native file events, the library will poll the file system for changes, periodically. This might introduce a latency in receiving file change events and might consume more resources, though I haven't tested it on any such systems.  
  
The watching is performed off the main thread however events are raised on the main thread.  
  
Example code:  

```B4X
Sub Process_Globals  
    Dim fw As FileWatcher  
    Dim t as Timer  
End Sub  
  
Sub AppStart(Args() as String)  
     t.Initialize("t", 60*1000)   'Stop file watching in 1 minute  
     fw.Initialize("fw")     'Initialize with the event name  
     fw.SetWatchList(Array as String(File.DirApp))   'Set the current dir to be watched  
     fw.StartWatching       'Start Watching  
     t.Enabled = true        'Start the timer  
  
     Log("creation time: " & fw.GetCreationTime("C:\Test\test.txt"))   'Log creation time of a file  
     fw.SetCreationTime("C:\Test\test.txt", DateTime.Now)    'Set the creation time to now  
     Log("creation time: " & fw.GetCreationTime("C:\Test\test.txt"))   'Log the new creation time of file  
     StartMessageLoop  
End Sub  
  
Sub fw_CreationDetected(FileName As String)  
    Log("CreationDetected: " & FileName)    'Logs the creation of a new file or folder  
End Sub  
  
Sub fw_DeletionDetected(FileName As String)  
    Log("DeletionDetected: " & FileName)   'Logs the deletion of a file or folder  
End Sub  
  
Sub fw_ModificationDetected(FileName As String)  
    Log("ModificationDetected: " & FileName)   'Logs the modification of a file or folder  
End Sub  
  
Sub fw_WatchingTerminated   'Logs the termination of the FileWatcher  
    Log("WatchingTerminated")   'The FileWatcher can still be used, it just has to be started again.  
    StopMessageLoop     'With the main message loop ended and the FileWatcher  
                               'watcher thread ended, this application will close now.  
End Sub  
  
Sub t_Tick  
     fw.StopWatching  
     Log("Timer Ticked, watching stopped")  
End Sub
```

  
  
This library was compiled against jdk 8.  
  
EDIT(26JUL2015): Updated to version 1.1. See post #3 for details.  
EDIT(2AUG2015): Updated to version 1.2. See post #8 for details.  
EDIT(06MAR2018): Updated to version 1.3. See post #21 for details.  
EDIT(23APR2020): Updated to version 1.4. See post #28 for details.