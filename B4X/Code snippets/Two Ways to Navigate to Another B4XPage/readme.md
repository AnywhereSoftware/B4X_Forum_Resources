###  Two Ways to Navigate to Another B4XPage by GeoT
### 08/18/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/171836/)

Although someone has already mentioned this indirectly in a question, I am documenting this function separately so that it can be easily found.  
[HEADING=1][SIZE=5]Prerequisites[/SIZE][/HEADING]  
Before navigating to the page, you need to create its B4XPage module and initialize it.  
  
Declare the page (after creating its B4XPage module):  

```B4X
Private objectPage As NamePage
```

  
  
Initialize it and add it in the B4XPage\_Created subroutine:  

```B4X
objectPage.Initialize  
B4XPages.AddPage("idPage", objectPage)
```

  
  
[HEADING=1][SIZE=5]Method 1: Navigate to the page[/SIZE][/HEADING]  
Once the page has been initialized and added, you can navigate to it simply by using:  

```B4X
B4XPages.ShowPage("idPage")
```

  
  
[HEADING=1][SIZE=5]Method 2: Navigate to the page and pass a value[/SIZE][/HEADING]  
If, in addition to navigating to another page, you want to pass a value to the Start subroutine you defined in the other page, you need to add another line:  
  

```B4X
' 1. We show the page to create it and have its views created  
B4XPages.ShowPage("idPage")  
  
' 2. We pass the value to the page  
B4XPages.MainPage.objectPage.Start(id)
```