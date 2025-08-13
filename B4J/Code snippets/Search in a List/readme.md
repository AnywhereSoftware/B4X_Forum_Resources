### Search in a List by Brian Michael
### 06/13/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/161564/)

Hello, here I come to you with a simple way to search for a word in a list of words. It is a very simple but very useful function.  
  
It is declared as ResumableSub so you can use Wait For and wait for it to finish searching to get the results.  
  
  
Example:  
  

```B4X
Dim Fruits as List = Array as String("Apple","Blueberry","Lime","Orange","Pear","Pineapple","Lemon","Bananna","Peach")  
  
Wait For(searchInList("P", Fruits)) Complete(result As List) 'Searching for "P" matches  
'Result = Array("Pineapple", "Peach")  
  
Wait For(searchInList("B", Fruits)) Complete(result As List) 'Searching for "B" matches  
'Result = Array("Blueberry", "Bananna")  
  
  
Dim Names as List = Array as String("Alejandro", "Ana", "Antonio", "Alicia", "Andres", "Beatriz", "Bruno", "Blanca", "Benjamin", "Barbara", "Carlos", "Carmen", "Claudia", "Cristina", "Cesar", "Diego", "Daniela", "David", "Diana", "Dolores", "Elena", "Eduardo", "Emilia", "Esteban", "Elisa", "Fernando", "Felipe", "Florencia", "Francisco", "Fatima", "Gabriel", "Gloria", "Guillermo", "Gustavo", "Gabriela", "Hector", "Helena", "Hugo", "Hilda", "Horacio")  
  
Wait For(searchInList("An", Names)) Complete(result As List) 'Searching for "An" matches  
'Result = Array("Ana", "Antonio", "Andres")
```

  
  
  

```B4X
Public Sub searchInList(Text As String, Lst As List) As ResumableSub  
    Dim temp_result As List : temp_result.initialize  
    For Each str As String In Lst  
     Dim lowercase as String = str.toLowerCase  
        If lowercase.Contains(Text.toLowerCase) Then  
            temp_result.Add(str)  
        End If  
    Next  
    Return temp_result  
End Sub
```