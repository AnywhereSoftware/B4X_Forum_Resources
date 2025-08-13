### Pause execution in Console app by aeric
### 09/29/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143205/)

[MEDIA=youtube]xAtZtEFXmG8[/MEDIA]  
  

```B4X
Sub AppStart (Args() As String)  
    sys.InitializeStatic("java.lang.System")  
    Dim user_input As String  
    Log("Press <q> to exit..")  
    Do Until user_input.ToLowerCase = "q"  
        user_input = Input("> ")  
         
        If user_input.EqualsIgnoreCase("hack") Then  
            Log("root@kali$ Hacking your B4X forum password. Please wait…")  
            Pause(2000)  
  
            Log("root@kali$ Processing… (10%)")  
            Pause(1000)  
            Log("root@kali$ Processing… (20%)")  
            Pause(2000)  
            Log("root@kali$ Processing… (50%)")  
            Pause(500)  
            Log("root@kali$ Processing… (80%)")  
            Pause(500)  
            Log("root@kali$ Processing… (90%)")  
            Pause(500)  
             
            Log("root@kali$ Completed. Your password is (just kidding)")  
            Pause(1000)  
        Else  
            Log($"You entered '${user_input}'"$)  
        End If  
    Loop  
    Log("Goodbye")  
    Delay(500)  
    StartMessageLoop  
End Sub
```

  
  

```B4X
Sub Pause (Milliseconds As Long)  
    Private jo As JavaObject  
    jo.InitializeStatic("java.lang.Thread")  
    jo.RunMethod("sleep", Array As Object(Milliseconds))  
End Sub
```

  
  
GitHub: <https://github.com/pyhoon/console-read-input-b4j>