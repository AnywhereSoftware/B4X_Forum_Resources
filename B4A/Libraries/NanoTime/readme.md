### NanoTime by stevel05
### 12/31/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/50104/)

Here is the first of two support libraries for my MidiSystem Library. This is a simple NanoTime wrapper.  
  
From the Android Docs:  
  
> Returns the current timestamp of the most precise timer available on the local system, in nanoseconds. Equivalent to Linux's CLOCK\_MONOTONIC.  
>   
> This timestamp should only be used to measure a duration by comparing it against another timestamp on the same device. Values returned by this method do not have a defined correspondence to wall clock times; the zero value is typically whenever the device last booted. Use [currentTimeMillis()](http://developer.android.com/reference/java/lang/System.html#currentTimeMillis()) if you want to know what time it is.

  
Download and unzip the file and copy the .jar and .xml files to your additional libraries folder.  
  
Edit (Erel): I've removed Utils.java from the jar file.