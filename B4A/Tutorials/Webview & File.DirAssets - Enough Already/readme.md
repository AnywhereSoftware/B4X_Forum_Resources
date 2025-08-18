### Webview & File.DirAssets - Enough Already by drgottjr
### 01/23/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/137803/)

**[SIZE=5]UPDATE: AFTER READING THIS POST, PLEASE REFER TO POST#5 FOR A BETTER SOLUTION (AT LEAST, IN MY OPINION).[/SIZE]**   
a code module provided by member Ivica Golubovic allows you to continue using your current code by simply adding the module to your app(s). in the event you use some unusual coding syntax which causes the module to break, i would think it would be much easier to modify the module to suit, rather than having to change your coding.  
——————————————————————————————————————————————————————————————————–  
  
there are some misunderstandings about webview and file.dirassets. i am not here to judge.  
  
from android documentation (<https://developer.android.com/reference/android/webkit/WebSettings#setAllowFileAccess(boolean)>)  
relating to the setAllowFileAccess setting: "Enables or disables file access within WebView. Note that this enables or disables file  
system access only. **Assets and resources are still accessible using file:///android\_asset** and file:///android\_res."  
  
clear enough? the webview setting to disable this is not necessary, as the setting itself does not relate to files in dirassets.  
from android's viewpoint, dir.assets is not part of a file system. android resources are identified by an id number. if you have resources  
to include in your app and which you want to access by name, you have to put them in dirassets and use the asset manager to deal with  
them on your behalf. this is handled for us as part of b4a's core.  
  
google would prefer:  
1) that the file:// scheme not be used.  
2) that the so-called webviewassetloader api be used instead.  
  
whether google will eventually outlaw the first entirely and require the second is unclear. google feels (or may have discovered) that the  
file:// scheme used to load files permits someone to cause your webview to load files without your (or your user's) knowledge. in addition,  
the webviewassetloader api address CORS issues and presents a uniform addressing scheme compatible with google's https:// loading  
preference. how the api works is beyond the scope of this post. you can search for webviewassetloader in the little box in the upper  
righthand corner of this page.  
  
while it is possible (although discouraged) to use the file:// scheme to load a webview with resources in dirassets, there is a problem relating  
to files kept in subfolders in dirassets. this is due to google's introduction of the aab bundle format and software used to prepare the bundle.  
erel has alluded to this, and i have read the documentation regarding aapt2 (the software which packages our projects), but i did not see a  
direct reference to the dirassets subfolder issue. nevertheless, as people who having been using subfolders have discovered, there is  
definitely a problem. so let's deal with it.  
  
for those who do not want to or cannot give up subfolders in dirassets, there are 2 solutions:  
1) include the XUI library and load your files thus: webview.LoadUrl(xui.FileURI(File.DirAssets, "subfolder\cat1\filename.html"))  
note the backslash separator!  
or  
2) use the familiar file:// scheme, but with the urlencoded (%5C) separator: webview.LoadUrl("file:///android\_asset/subfolder%5Ccat1%5Cfilename.html")  
  
unfortunately, for files kept in subfolders to be loaded from within the webview itself, the solution will require you to edit those html files which load  
resources kept in subfolders in dirassets. use this, eg: <img src='file:///android\_asset/subfolder%5Ccat1%5Csomeimage.jpg'>  
  
below please find a working example of what you need to do. i have tested it with b4a 11.20, android28/sdk28 and android30/sdk30 on a device running  
android 12 and on a tablet running android 9. both versions work on both devices, so there seems to be no need build separate code to deal with device  
build. normally, i might find that a little odd, given that "something" happened with sdk30 that causes apps which worked before to break. the usual thing  
to do would be to test for device build and then code for older versions and code for newer sdk's, but for whatever reason, the example works fine on  
my devices.  
  
as to recommendations that subfolders be copied from dirassets to some other location, i believe you will find they are no longer accessible from  
within a webview. at least i was not able to get it to work. i suspect this might be a big problem. the subfolder tree structure is fine for loading from  
within the app; i'm talking about loading from within the webview. it appears that only the dirassets subfolder tree is still available, and urlencoding a  
backslash separator is a small price to pay, since it may be the only option.  
  
flattening all the subfolders is a simple solution, but it doesn't take into account how many files and subfolders we're talking about and how your app  
searches for them. but, mainly, unless you flatten them and put them in dirassets (proper) or dirinternal, they're not going to be accessible from the webview. and  
copying them from dirassets to dirinternal means you just carry twice the load. and for no reason since dirassets and subfolders still works.