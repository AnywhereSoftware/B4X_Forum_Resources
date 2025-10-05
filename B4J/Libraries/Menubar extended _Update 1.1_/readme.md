### Menubar extended *Update 1.1* by Guenter Becker
### 10/03/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/168888/)

Name: GBEMenubar  
Version: 1.1  
Language: B4J  
License: Royalty free  
(C) icons Royalty free from icons8.com  
  
**\*Update Version 1.1\***  
After a long research I found a solution for some open features I like to add. Therefor I publish this update short after release to get the missing features quickly to your hands. Look at the description in the features list with red text.  
  
Thank you for the Basic Ideas of some Forum Members who published the code snippeds of:  
ShortCut (*Daestrum*) and setMenuIcon (*tchart* clickable Title).  
  
**The B4J Menubar with extende features:**  
![](https://www.b4x.com/android/forum/attachments/167502)  
  

- Custom View for Designer
- Customizable MenuBar GUI/Properties.
- Load Menustructure form File and build Menus and MenuItems.
- No need to build Menus/Items via Jason Code of MenuBar-View/Menus Property.
- Easy Add Menus/MenuItems by code manually.
- enable/disable MenuItems by code.
- show/hide MenuItems by code.
- (Title) Menu and Menuitems with Icons.
- MenuItem with Separator Line.
- MenuItem with ShortCut Key (Ctrl+ .. ).
- Custom Event *ItemCLicked* (MenuItem) with reported MenuItem-ID.
- Custom Event MenuClicked (Title) with reported Menu-ID.
- Activate/Deactivate Click-Beep

  
'# Properties #  
 'GBEMenuBar1.hideMenuItem '# show/hide MenuItem  
 'GBEMenuBar1.AddMenu '# Add (Title- ) Menu  
 'GBEMenuBar1.AddMenuItem '# Add (Sub-) MenuItem  
 'GBEMenuBar1.enableMenuItem '# enable/disable MenuItem  
 'GBEMenuBar1.hideMenuItem '# show/hide MenuItem  
 'GBEMenuBar1.LoadMenu '# load and build menu from file  
 'GBEMenuBar1.Menubar '# the MenuBar View  
 'GBEMenuBar1.actBeep '# actvate Beep  
  
The new Menu\_Clicked Event is a good place to control the access (enabled/disabled) of the attached MenuItems.  
  
**See how to install and use by attached B4J Example Projec:.**  

- Example includes the CustomView as Class in clear Code.
- B4J B4Xlib is included in Project ZIP
- **Copy Files** *Menu.txt* (Structure Description) and *MyMenu.css (custom GUI)* from Example Project *File* Folder to your Projects *Files* Folder.
Modify the files for your needs