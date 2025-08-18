### Customizing New B4XPages Backup and Module Naming by Elby dev
### 10/22/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/123735/)

I thought to share this info snippet with you all.  
1: B4XPages now has a magic Backup feature shown as 'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip  
For the Newby's you can customize this even further by editing the destination like I have a SD card as Drive F with a folder B4XPages\_Backups  
My Project Name is MyCreation. In order to save Direct to this location I modified this Backup Line to:  
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=**F:\B4XPages\_Backups\MyCreation.zip** Simple and Fast, Saves Renaming and copying  
**All Credits to Erel for Creating this Feature in B4XPages.**  
  
2: For Naming the Pages and not getting lost with many pages and show page commands in the Program, I Name a new page abc as abcPage (is the Class Name)  
Then Create a Variable Named abcObj as in object, Then Initialize this Object as abcObj.initialize and when adding this page I use abcID. Like B4XPages.AddPage("abcID",abcObj)  
So the 3 item endings Page, Obj and ID will remind you when to use the 'Page' (class) or 'ID' when doing your stuff inside the various Class modules.  
Happy Programming :)