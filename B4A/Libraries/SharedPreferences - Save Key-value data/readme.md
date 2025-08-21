### SharedPreferences - Save Key-value data by ProgrammedComputer
### 03/11/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/114840/)

Hello  
When i used B4A for the first time, I felt something is missing. it was hard to save values using File.WriteString or even harder: File.WriteMap  
each time i had to Create a map and write it to a file if i wanted to save changes. i was waiting for anyone to write a library to make this easier.  
But i couldn't wait anymore.  
Today i learned to create library for B4A and I've written my first library. I'm happy to share it with B4X community :)  
SharedPreferences is the default and standard method for saving your app data.  
  
Example:  

```B4X
Sub Activity_Create  
EditText.Text = SharedPrefs.GetString("EditTextValue","You haven't saved anything.")  
Dim SharedPrefs As SharedPreferences  
SharedPrefs.Initialize("MyPrefs")  
  
'//Saving a string  
SharedPrefs.SaveString("myGreatString", "I'm saved now :)")  
  
'//Getting that saved string  
LogColor(SharedPrefs.GetString("myGreatString","I will show up if myGreatString key isn't found"),Colors.Cyan)  
  
'//Saving a boolean  
SharedPrefs.SaveString("darkMode", True)  
  
'//an example of usage of save and get boolean  
If SharedPrefs.GetBoolean("darkMode",True) Then Activity.Color = Colors.Black Else Activity.Color = Colors.White  
  
  
End Sub  
  
Sub EditText_TextChanged (Old As String, New As String)  
'//Saving edittext value (Get method is used in app start)  
SharedPrefs.SaveString("EditTextValue",EditText.Text)  
End Sub
```