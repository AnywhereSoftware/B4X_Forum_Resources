### [Web][SithasoDaisy] Mastering the Team Grid Component by Mashiane
### 04/25/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/160714/)

Hi Fam  
  
Let's look at the Team Grid component that's coming to SithasoDaisy 2.24+  
  
A team grid can be used as an alternative to the table listing or a complement to the table listing.  
  
![](https://www.b4x.com/android/forum/attachments/153008)  
  
![](https://www.b4x.com/android/forum/attachments/153011)  
  
  
Just like the table, the team grid has functionality to do the following"  
  
0. Search - one can type in a search string to activate a search of profiles and then list profiles meeting that criteria. The search starts from 3 characters onwards.  
1. New - add new team member (you need to design the modal/page for such functionality)  
2. Pagination - you call SetItemsPaginate to paginate the grid listing of your team. This example shows 5 team members per page  
3. Delete All - you can click delete all to delete all your team members as a click event has been added to this  
4. Upload - an upload file functionality has been added, one can import data from excel, csv file etc.  
5. Refresh - refresh the list of available profiles.  
6. Back - navigate to another screen.  
7. Alpha Chooser - the alpha chooser allows one to filter the profiles based on the "fullname" of a profile. For example, if we click D, only profiles starting with D will be listed.  
  
For each profile we have the following:  
  
1. Edit - click to edit the active profile, an event is linked to this (will have to design the modal to show)  
2. Clone - click to clone the active profile  
3. Delete - click to delete the active profile.  
  
![](https://www.b4x.com/android/forum/attachments/153010)  
  
One can also refer to an image, fullname, title and bio and then various platforms one can add. One can also add additional platforms beyong the listed. If there is no platform, its icon will not show on the profile in question.  
  
A fully functional example will be available on the Demo WebApp. Let's look at how this works in real life. We toggle our clients between a grid view & a table.  
  
![](https://www.b4x.com/android/forum/attachments/153106)  
  
Enjoy!