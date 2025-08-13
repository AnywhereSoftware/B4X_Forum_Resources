###  Interactive Expandable Multi B4XPages Drawer Menu (tested in B4J and B4A) by MicroDrie
### 01/10/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/165016/)

In the five years that I have been using my single B4XPage expandable Drawer menu in B4J and B4A, both the IDEs and the B4X components have evolved. The time is ripe to create a new version called M3Menu.  
For those who want to delve a bit deeper into the operation, here and there is some explanation and I have also used more or less explanatory routine and variable names. The routines are arbitrarily divided into regions. During the development I have used the knowledge in all kinds of given examples and solutions that are on this forum to arrive at the result below that meets my requirements.  
  
![](https://www.b4x.com/android/forum/attachments/160619)  
  
FAQs  
  
  

1. There are a lot of menus on this site. Why should I use M3Menu?
M3Menu only shows a few horizontal lines (the "hamburger") on the screen with which a menu can be opened. The opened menu slides from the side over the user screen. This minimizes the space occupied on your program screen.2. What does the name M3Memu stand for?
The "M3" in m3Menu refers to the interchangeable Google terms: "Material 3", "Material design 3", "Material you" and the Compose Material 3 for the color combinations to use in this menu.3. Why can I set the "hamburger" icon to a different color than the font color of the menu options?
This can solve a poorly visible "hamburger" icon with an acceptable M3Menu foreground and background color combination.4. Why is the "hamburger" icon not displayed on a certain B4XPage in B4J, but it is in B4A?
Possibly the "hamburger" icon is "covered" by another component. By moving that component from the "hamburger" icon location it becomes visible again.5. How can I use the M3Menu?
The M3Menu has been redesigned with Erel's advice to use IDE B4J to easily develop and test in a B4XPages environment in the B4J IDE using B4X components. Then in another IDE you can test via the option "Add Existing Modules" and as "Link - relative path" in the other IDE. I did that for the B4A IDE. By using as many B4X components as possible there are very few differences that are or should be solved via the #IF B4A and #IF B4J options.6. Do I need to develop programs with M3Menu in the B4J IDE?
No, but developing and testing in B4J is easier. In my Proof-Of-Concept program the program models are stored in the project folder. In the B4A IDE these program modules are linked via the option: 'Link - relative path'.
This setup method ensures that saved adjustments (by hand or at the start of the run command) in one IDE are also automatically implemented in the other IDE. For each IDE you have to manually set the libraries to be used. The Drawer Manager of M3Menu provides the necessary differences between B4J and B4A such as the difference between pane and panel.7. How can I display my menu options?
You can place 1, 2, 3 or more menu options in a menu group. The different menu groups are placed in a vertical scroll list. When you click or touch a menu group, it is expanded and another expanded menu group is collapsed.8. How can I customize the menu to my wishes?![](https://www.b4x.com/android/forum/attachments/160642)The first configurable **InitMenuMap** contains the menu groups and the menu items for each group, the second configurable **mainMenu** defines what the do for each group item (the group name is used to open and close the drop-down list for a menu group), and the third configurable **CreateMenuSettings** defines the values of the define menu settings Type for consistent implementation of the desired setting across all B4XPage files.
9. Can I also use M3Menu in the B4XMainPage?
M3Menu is designed with the "Develop it once, reuse it as much as possible unchanged" principle in mind. This principle facilitates troubleshooting and implementing improvements in programs and the application and reuse of menu groups that are related to a specific reusable B4XPage.10. How do I get the character codes for the menu options used?
The 719 icon character codes come from materialdesignicons-webfont.ttf in the asset directory. Use the tool below
' [https://www.b4x.com/android/forum/threads/b4x-materialicons-web-font-chooser.103985/](http://1. There are a lot of menus on this site. Why should I use M3Menu? M3Menu only shows a few horizontal lines (the %22hamburger%22) on the screen with which a menu can be opened. The opened menu slides from the side over the user screen. This minimizes the space occupied on your program screen.      2. What does the name M3Memu stand for? The %22M3%22 in m3Menu refers to the interchangeable Google terms: %22Material 3%22, %22Material design 3%22, %22Material you%22 and the Compose Material 3 for the color combinations to use in this menu.      3. Why can I set the %22hamburger%22 icon to a different color than the font color of the menu options?  This can solve a poorly visible %22hamburger%22 icon with an acceptable M3Menu foreground and background color combination.       4. Why is the %22hamburger%22 icon not displayed on a certain B4XPage in B4J, but it is in B4A? Possibly the %22hamburger%22 icon is %22covered%22 by another component. By moving that component from the %22hamburger%22 icon location it becomes visible again.      5. How can I use the M3Menu? The M3Menu has been redesigned with Erel%27s advice to use IDE B4J to easily develop and test in a B4XPages environment in the B4J IDE using B4X components. Then in another IDE you can test via the option %22Add Existing Modules%22 and as %22Link - relative path%22 in the other IDE. I did that for the B4A IDE. By using as many B4X components as possible there are very few differences that are or should be solved via the #IF B4A and #IF B4J options.      6. Do I need to develop programs with M3Menu in the B4J IDE? No, but developing and testing in B4J is easier. In my Proof-Of-Concept program the program models are stored in the project folder. In the B4A IDE these program modules are linked via the option: %27Link - relative path%27.  This setup method ensures that saved adjustments (by hand or at the start of the run command) in one IDE are also automatically implemented in the other IDE. For each IDE you have to manually set the libraries to be used. The Drawer Manager of M3Menu provides the necessary differences between B4J and B4A such as the difference between pane and panel.       7. How can I display my menu options? You can place 1, 2, 3 or more menu options in a menu group. The different menu groups are placed in a vertical scroll list. When you click or touch a menu group, it is expanded and another expanded menu group is collapsed.       8. How can I customize the menu to my wishes? The first configurable InitMenuMap contains the menu groups and the menu items for each group, the second configurable mainMenu defines what the do for each group item (the group name is used to open and close the drop-down list for a menu group), and the third configurable CreateMenuSettings defines the values of the define menu settings Type for consistent implementation of the desired setting across all B4XPage files.       9. Can I also use M3Menu in the B4XMainPage? M3Menu is designed with the %22Develop it once, reuse it as much as possible unchanged%22 principle in mind. This principle facilitates troubleshooting and implementing improvements in programs and the application and reuse of menu groups that are related to a specific reusable B4XPage.      10. How do I get the character codes for the menu options used? The 719 icon character codes come from materialdesignicons-webfont.ttf in the asset directory. Use the tool below %27 https://www.b4x.com/android/forum/threads/b4x-materialicons-web-font-chooser.103985/ to search through these 719 icons and copy the corresponding character code to the menu option.      11. Why can%27t I use a graphic image for a menu option icon? The choice for a limited size TTF font makes it easy to adjust the color for a displayed menu line to meet the Material Design 3 requirements.      12. What makes M3Menu interactive?  The initial menu configuration is stored in and built from a B4XOrderedMap menuMap in the B4XMainPage. An active menu option has the status %22True%22 in this. By setting this status to %22False%22 the menu option is disabled and displayed with a different chosen background color. In the Proof-Of-Concept B4XPageMenuTest page present test routine are examples of how the display and use of the M3Menu are possible.      13. How can logging be switched on and off? DrawerManger has three relevant routines: A global routine logPrt that is switched on with tms.logStatus = True and switched off with the command tms.logStatus =False in the CreateMenuSettings routine. In addition, you can interactively switch logging on with the routine drManager.LogPrintOn and switch logging off again with the routine drManager.LogPrintOff.) to search through these 719 icons and copy the corresponding character code to the menu option.11. Why can't I use a graphic image for a menu option icon?
The choice for a limited size TTF font makes it easy to adjust the color for a displayed menu line to meet the Material Design 3 requirements.12. What makes M3Menu interactive?
The initial menu configuration is stored in and built from a B4XOrderedMap menuMap in the B4XMainPage. An active menu option has the status "True" in this. By setting this status to "False" the menu option is disabled and displayed with a different chosen background color.
In the Proof-Of-Concept B4XPageMenuTest page present test routine are examples of how the display and use of the M3Menu are possible.13. How can logging be switched on and off?
DrawerManger has three relevant routines: A global routine **logPrt** that is switched on with **tms.logStatus = True** and switched off with the command **tms.logStatus =False** in the **CreateMenuSettings** routine. In addition, you can interactively switch logging on with the routine **drManager.LogPrintOn** and switch logging off again with the routine **drManager.LogPrintOff**.
Update 10-01-2024:  

1. Principle of interactive B4X m3Menu unnecessary second 'Send update m3Menu setting' text removed
2. Here are some inspirational examples of how you can use interactivity between your and the M3Menu program:

```B4X
'    — Reset m3Menu to config created by InitMenuMap  
drManager.ResetMenu
```

  
  

```B4X
'    — Return all menu groups in a list  
drManager.LogPrt($"Show all menugroups: ${drManager.ReturnMenuGroupList}"$)
```

  
  

```B4X
'    — Return True if exist, false if unknow menu group name  
drManager.LogPrt($"banana menugroup exist: ${drManager.TestMenuGroupNameExist("banana")}"$)
```

  
  

```B4X
'    — Return menu status for given menu group or item. Returns True if exist else returns False  
  
'    — Return the menu group status  
drManager.LogPrt($"File menugroup "File" exist: ${drManager.ReturnStatusGivenMenuItem("File", "File")}"$)  
  
'    — Return the menu item status  
drManager.LogPrt($"File menugroup Item "file 3" exist: ${drManager.ReturnStatusGivenMenuItem("File", "file 3")}"$)
```

  
  

```B4X
'    — Change the menu group status to the given status true or false. returns logical true if succesfully.  
drManager.LogPrt($"File menugroup Item "Small" set status enable: ${drManager.ChangeMenuGroupItemStatus("Small", "Small", "true")}"$)  
  
'    — Change the menu item status to the given status true or false. returns logical true if succesfully.  
        drManager.LogPrt($"File menugroup Item "file 3" set status: ${drManager.ChangeMenuGroupItemStatus("File", "file 3", "true")}"$)
```

  
  

```B4X
'    — Return menu status for given menu group. Returns: True if exist else returns False  
drManager.LogPrt($"File menugroup Item "File" exist: ${drManager.ReturnStatusGivenMenuItem("File", "File")}"$)  
  
'    — Return menu status for given menu item True if exist else returns False  
drManager.LogPrt($"File menugroup Item "file 3" exist: ${drManager.ReturnStatusGivenMenuItem("File", "file 3")}"$)
```

  
  

```B4X
'    — Return all menu items for the given menu group in a list  
    Dim lst As List = drManager.ReturnMenuGroupItemsList("File")  
    drManager.LogPrt($"Show all group items:"$)  
    For Each line As menuType In lst  
        drManager.LogPrt($"${line.menuIcon} ${line.menuItem} ${line.menuStatus}"$)  
    Next
```