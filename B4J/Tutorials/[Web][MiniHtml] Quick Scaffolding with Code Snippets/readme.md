### [Web][MiniHtml] Quick Scaffolding with Code Snippets by aeric
### 02/03/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/169064/)

[TABLE]  
[TR]  
[TD]This tutorial is obsolete for latest version of MiniHtml[/TD]  
[/TR]  
[/TABLE]  
  
**MiniHtml** v0.20 has a big update!  
  
With embedded **Code Snippets**, this is a new beginning of using reusable templates to **create webpage**.  
Let's take a look on 2 ready-to-use "components" for creating **category.html** for **Pakai Server** project template.  
  
[HEADING=1]Installation[/HEADING]  

1. Download the **MiniHtml.b4xlib** and save it inside **Additional Libraries** folder under **B4X** or **B4J**.

[HEADING=1]How to use[/HEADING]  

1. Create a new project using **Pakai Server v5** template, let's give the project name **Warehouse**.
2. Add a reference to **MiniHtml** library from **Libraries Manager** tab.
![](https://www.b4x.com/android/forum/attachments/167887)3. Remove **HelpHandler** class and comment the usage.
![](https://www.b4x.com/android/forum/attachments/167894)4. If you insist to use it, then you need to fix the conflict of variables name "html" and "body". Check the last section of this tutorial.
5. Create a new Standard Class and name it **CategoryView**. You can rename the group as **Views**.
![](https://www.b4x.com/android/forum/attachments/167885)6. Start typing the keyword "**compo**" and select the Code Snippet "**Component [plain]@content[/plain]**".
![](https://www.b4x.com/android/forum/attachments/167899)7. A template code is added. You can change the **highlighted keywords** or accept the suggested defaults.
![](https://www.b4x.com/android/forum/attachments/167895)8. Let's set the sub name as **TableCategories** and some values for the text. **Press Tab** to shift to another keyword. **Press Enter** to confirm.
![](https://www.b4x.com/android/forum/attachments/167896)9. Add a new sub calls **ReturnView** and write the following code inside.

```B4X
Public Sub ReturnView As String  
    Dim doc As Document  
    doc.Initialize  
    doc.Append2(TableCategories.build3(3, False))  
    Return doc.ToString  
End Sub
```

10. Now, we can call this class from **CategoriesWebHandler** class.
11. Let's comment the code to load category.html from assets (Files) folder.
![](https://www.b4x.com/android/forum/attachments/167898)12. Write the following code to call the ReturnView sub from CategoryView class.

```B4X
Dim view1 As CategoryView  
view1.Initialize  
Dim strView As String = view1.ReturnView
```

13. Next, proceed to add the modal components for **New**, **Edit** and **Delete** dialog.

[HEADING=1]Adding a modal component[/HEADING]  

1. The steps are very similar. Start typing "**compo**" in **CategoryView** class but this time we choose the Code Snippet "**Component [plain]@modal[/plain]**".
2. Edit the **highlighted keywords** as showed in the following screenshot. **Press Enter** to confirm.
![](https://www.b4x.com/android/forum/attachments/167897)3. Update the code in ReturnView sub.

```B4X
Public Sub ReturnView As String  
    Dim doc As Document  
    doc.Initialize  
    doc.Append2(TableCategories.build3(3, False))  
    doc.Append2(ModalCategoryAdd.build3(3, True))  
    Return doc.ToString  
End Sub
```

4. Run the project and navigate to "**Show Category**" from the index page to see if it works.
5. Proceed to create the modal dialogs for Edit and Delete.
6. Make sure to use **unique ids** for the **modals**, **buttons** and **text inputs** for each modal.

[HEADING=1]Resolving conflict in HelpHandler[/HEADING]  

1. Press Ctrl+F or Search for the word **html** in the IDE.
2. Highlight the code inside **GenerateHtml** sub and replace the word to "**SB**" using the "**In Selection**" button.
![](https://www.b4x.com/android/forum/attachments/167891)3. Change the **Body** variable to **Payload**. You can replace "Dim Body As String" with "Dim Payload As String" and click on "**Current Module"** button.
![](https://www.b4x.com/android/forum/attachments/167892)
Then replace "Method.Put("Body", Body)" with "Method.Put("Body", Payload)" and click on "**Current Module"** button.  
  

---

  
More ready-to-use **component** Code Snippets will be added to MiniHtml library in the future.  
You can also **create your own** Code Snippets and place them to the Snippets folder in Additional libraries folder.  
Hope this helps.