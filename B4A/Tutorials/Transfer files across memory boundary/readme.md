### Transfer files across memory boundary by Roger Daley
### 10/05/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/134832/)

Hi all,  
  
This is a simple example of moving files across the internal/external memory boundary.  
EG Transferring a CSV file from an external location to an internal folder to load a database in the App.  
  
XFER started as B4X TextEditor [and a chainsaw]. I have deliberately minimized it as much as I could, not even friendly Toast Messages.   
This was fairly easy as most of the work is done in the FileHandler class.  
  
The App itself is quite rough but I envisage the code used in an App where import/export of files is required.