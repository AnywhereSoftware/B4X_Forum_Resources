### AudioTrack by stevel05
### 01/03/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/14007/)

This is a wrapper library for the AudioTrack Object, simlar to the AudioRecord object, it's more complex to use than the MediaPlayer but has some functionality that is useful for audio processing.  
  
I haven't had time to test this one thoroughly, I thought you may like to play with it as well. Let me know if you find anything that doesn't work.  
  
The attachment is quite big as it has an example wav file that is loaded via a random access file and played via Audiotrack, just to give an idea.  
  
Edit: V1.01 fixed a typo and Separate file for libs only  
17/1/12 Added swt.zip, quick and dirty sine wave generator as an example.  
 Added swt1-1.zip a few more refinements.  
 Added swt1-2.zip better tuning  
 Updated lib files to 1.2 - needed for swt1-2  
13/2/12 Added and reformatted Constants - audiotrack1.3  
19/3/12 Updated SWT to reach 19khz and added input fields (touch the display labels)  
  
15/1/21  

- Added attest2
- Updated example with a Stream Static and looping example.
- Replaced threading with Wait For and Sleep in the streaming example. For heavy usage, it may still be necessary to use threading, so I'll leave the original example here as well.