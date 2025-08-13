###  "Code Smells" - common mistakes and other tips by Erel
### 09/06/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/116651/)

"Code smells" are common patterns that can indicate that there is a problem in the code. A problem doesn't mean that the code doesn't work, it might be that it will be difficult to maintain it or that there are more elegant ways to implement the same thing.  
Remember that not everything is clear cut and there are exceptions for any rule.  
  
I will update this list whenever I encounter such smell :)  
  

1. Initializing an object and then assigning a different object to the same variable:

```B4X
'bad  
Dim List1 As List  
List1.Initialize '<– a new list was created here  
List1 = SomeOtherList '<— previous list was replaced  
  
'good  
Dim List1 As List = SomeOtherList
```

2. Deprecated methods - DoEvents, Msgbox: <https://www.b4x.com/android/forum/threads/doevents-deprecated-and-async-dialogs-msgbox.79578/#content>
3. Deprecated methods - Map.GetKeyAt / GetValueAt - these methods were added before the For Each loop was available. They are not cross platform and are not the correct way to work with maps.

```B4X
'bad  
For i = 0 To Map1.Size - 1  
Dim key As String = Map1.GetKeyAt(i)  
Dim value As String = Map1.GetValueAt(i)  
Next  
  
'good  
For Each key As String In Map1.Keys  
Dim value As String = Map1.Get(key)  
Next
```

4. File.DirDefaultExternal - This is always a mistake. In most cases the correct folder should be XUI.DefaultFolder (=File.DirInternal). If you do need to use the external storage then use RuntimePermissions.GetSafeDirDefaultExternal.
File.DirRootExternal - It will soon become inaccessible directly. If really needed then use ContentChooser or ExternalStorage.5. Not using parameterized queries:

```B4X
'very bad  
SQL.ExecNonQuery("INSERT INTO table1 VALUES ('" & EditText1.Text & "'") 'ugly, will break if there is an apostrophe in the text and vulnerable to SQL injections.  
  
'very good  
SQL.ExecNonQuery2("INSERT INTO table1 VALUES (?)", Array(EditText1.Text))
```

6. Using Cursor instead of ResultSet - Cursor is a B4A only object. ResultSet is a bit simpler to use and is cross platform.

```B4X
'good  
Dim rs As ResultSet = SQL.ExecQuery2(…)  
Do While rs.NextRow  
…  
Loop  
rs.Close
```

7. Building the complete layout programmatically. This is especially a mistake in B4J and B4i because of the resize event and also if you want to build a cross platform solution. Layouts can be ported very easily.
8. Repeating the code. There are many patterns to this one and all of them are bad.

```B4X
'bad  
If b = False Then  
Button1.Text = "disabled"  
Button2.Text = "disabled"  
Button3.Text = "disabled"  
Button1.Enabled = False  
Button2.Enabled = False  
Button3.Enabled = False  
Else  
Button1.Text = "enabled"  
Button2.Text = "enabled"  
Button3.Text = "enabled"  
Button1.Enabled = True  
Button2.Enabled = True  
Button3.Enabled = True  
End If
```

```B4X
'good  
For Each btn As Button In Array(Button1, Button2, Button3)  
btn.Enabled = b  
If b Then btn.Text = "enabled" Else btn.Text = "disable"  
Next
```

9. Long strings without using smart strings:

```B4X
'bad  
Dim s As String = "This is the " & QUOTE & "first" & QUOTE & "line" & CRLF & _  
"and this is the second one. The time is " & DateTime.Time(DateTime.Now) & "."  
  
'good  
Dim s As String = $"This is the "first" line  
and this is the second one. The time is $Time{DateTime.Now}."$
```

More information: <https://www.b4x.com/android/forum/threads/50135/#content>10. Using global variables when not needed:

```B4X
'bad  
Job.Initialize(Me, "") 'global variable  
…  
  
'good  
Dim job As HttpJob  
job.Initialize(Me, "")
```

11. Not using Wait For when possible. JobDone is a good example: [[B4X] OkHttpUtils2 with Wait For](https://www.b4x.com/android/forum/threads/79345/#content)
12. Using code modules instead of classes. Code modules are very limited in B4A. In most cases you should use classes instead of code modules. A code module is a single instance of a class.
13. Understanding booleans.

```B4X
'not elegant  
Dim result As Boolean = DoingSomethingThatReturnTrueOrFalse  
If result = True Then  
Return True  
Else  
Return False  
End If  
  
' elegant  
Return DoingSomethingThatReturnTrueOrFalse
```

14. Converting "random" bytes to strings. The only valid raw bytes that should be converted to a string, with BytesToString, are bytes that represent text. In all other cases it is a mistake to convert to string. Even if it seems to work it will later fail in other cases.
If you think that it is more complicated to work with raw bytes then you are not familiar with the useful B4XBytesBuilder object: <https://www.b4x.com/android/forum/threads/b4x-b4xcollections-more-collections.101071/#content>15. Generating or parsing XML / JSON by hand. These formats are far from being trivial and with all kinds of edge cases that no one remembers.

```B4X
'bad  
Dim s As String = "{""version"":""" & Version & """,""colors"":[""red"",""green"",""blue""]}"  
  
'good  
Dim jg As JSONGenerator  
jg.Initialize(CreateMap("colors": Array("red", "green", "blue"), "version": Version))  
Log(jg.ToPrettyString(4))
```

16. Assuming that Maps preserve order. (Hash)Maps, unlike Lists or arrays, in the general case do not preserve order. It is inherent to the way hash maps work and true in all programming languages. There are some exceptions in B4X which are:
- B4A and B4J regular maps do preserve order.
- B4XOrderedMap from B4XCollections is built as a List + Map and it preserves order. It actually allows sorting the keys, which can be useful in some cases.
A common case of confusion is JSON object(=Map) parsing and generation. The JSON specs specifically "does not assign any significance to the ordering of name/value pairs".
Related thread: <https://www.b4x.com/android/forum/threads/b4x-features-that-erel-recommends-to-avoid.133280/>  
That's it for now.