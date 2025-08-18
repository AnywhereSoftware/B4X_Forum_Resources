### il_AudioPlayer by ilan
### 07/26/2021
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/120180/)

***il\_AudioPlayer - View***  
  
I would like to share with you CustonView i have created for my new B4i App. It is an AudioPlayer with a nice UI and lot of functions  
like playing Songs in background, Playlist, FileDialog and much more. It is still in the testing phase but i think it is already ready for use in real applications.  
The player is also very customizable since you have all layouts and icons included and you can enter them and edit them if you  
like (dont remove any views or add new views just edit colors if you want).  
  
  
**Installation instructions:**  
  
- Copy the \*.a and \*.h files into the folder "Libs" in your MAC or in your MAC HOSTED by AnywhereSoftware, normally in "B4i-MacServer\Libs" folder  
  
- Copy the il\_AudioPlayer.xml to your custom libraries folder in B4i  
  
- Unzip Files.zip and copy all files to your ../Files Folder (it includes icons, layouts, etc…). The Example.zip includes already all necessary files.  
  
- Select lib in Libraries Manager  
  
  
![](https://www.b4x.com/android/forum/attachments/97138)  
  
  
  
[SIZE=5]**il\_AudioPlayer**[/SIZE]  
  
**Author:** Ilan Tetruashvili  
**Version:** 0.03  
  
  
[SIZE=5]**Methods:**[/SIZE]  
  

- **IsInitialized As BOOL**
*Tests whether the object has been initialized.*- **\_ap\_changethememode:** (mode As int) **As NSString\***
*Change the Thememode (0 = lightmode, 1 = darkmode)* - **\_ap\_createsong::::::::** (trackId As int, dir As NSString\*, filename As NSString\*, title As NSString\*, favorite As BOOL, trackimgHD As B4IBitmap\*, trackimgSD As B4IBitmap\*, videoUrl As NSString\*) **As \_song\***
*trackid (A uniqe id [int]) dir (Track directory path) filename (Track filename) title (Set the Title that will be shown in Player) favorite (Set if favorite Boolean) trackimgHD (Set bitmap that will show in Player HD) trackimgSD (Set bitmap that will show in Song list for this track SD) videoUrl (Set the video URL to open it on button click. If is emptry, Youtube will be opened with Title string and search for the track video)* - **\_ap\_pause As NSString\***
*Pause the Player* - **\_ap\_playlistpath:** (path As NSString\*) **As NSString\***
*Set the Playlistpath where all playlists will be saved and loaded from* - **\_ap\_playnexttrack As NSString\***
*Play next Track* - **\_ap\_playprevioustrack As NSString\***
*Play previous Track* - **\_ap\_playtrack:** (pos As int) **As NSString\***
*Play Track with selected index* - **\_ap\_returnbasepanel As B4IPanelWrapper\***
*Return Base Panel as Panel* - **\_ap\_returncurrenttrackindex As int**
*Return current Track index that is playing* - **\_ap\_returnspecialbuttonspanel As B4IPanelWrapper\***
*Return Special controls Panel as Panel* - **\_ap\_returntitlelabel As B4ILabelWrapper\***
*Return Title Label as Label* - **\_ap\_setloopplay:** (value As BOOL) **As NSString\***
*If true the list will continue playing when finished* - **\_ap\_setskipseconds:** (value As int) **As NSString\***
*Set the skip seconds. clicking the skip buttons will forward or backward the track for x seconds* - **\_ap\_show As NSString\***
*Show Player with animation from bottom to top* - **\_ap\_showspecialbuttons:** (value As BOOL) **As NSString\***
*Show/hide special controls on bottom of the screen* - **\_ap\_songlist As B4IList\***
*Return full songlist (holds type objects)* - **\_ap\_recreatetracklist:**
*Recreates the Tracklist again if it is missing*- **\_ap\_recreatePlaylist:**
*Recreates the Playlist again if it is missing*- **\_*****ap\_songpath:** (path As NSString\*) **As NSString\********
*S**et the Songpath that will be the startpath in the FileDialog*** - **\_*****ap\_songpathlongclick:** (path As NSString\*) **As NSString\********
**Set a second Songpath that will be the startpath in the FileDialog (will be raised on longclick)** - *****\_class\_globals As NSString\******
- *****\_initialize::::::::** (ba As B4I\*, myApp As B4IApplicationWrapper\*, CallBack As NSObject\*, CallPanel As B4IPanelWrapper\*, Event As NSString\*, ThemeMode As int, BackgroundPlay As BOOL, ShowScreenControls As BOOL) **As NSString\******
*myApp (App As Application) CallBack (Sender page) CallPanel (Panel that will hold the player like Page.Rootpanel) Event (Object Event to handle CallSub() Method) ThemeMode (0 = Lightmode, 1 = Darkmode) BackgroundPlay (Allow player to play in background) ShowScreenControls (Show extra controls on bottom)* 
  
  
[SIZE=5]**Song (Type Object)**[/SIZE]  

- **[SIZE=4]Fields[/SIZE]:**

- **IsInitialized As BOOL**
*Tests whether the object has been initialized.*- **trackId As int**
- **dir As NSString\***
- **filename As NSString\***
- **title As NSString\***
- **favorite As BOOL**
- **trackimgHD As B4IBitmap\***
- **trackimgSD As B4IBitmap\***
- **videoUrl As NSString\***

  

- **Methods:**

- **Initialize As void**
*Initializes the fields to their default value.*
  
  
  
[SIZE=5]**Fileatt (Type Object)**[/SIZE]  

- [SIZE=5][SIZE=4]**Fields**[/SIZE][SIZE=5]**:**[/SIZE][/SIZE]

- **IsInitialized As BOOL**
*Tests whether the object has been initialized.*- **path As NSString\***
- **filename As NSString\***
- **isdir As BOOL**
- **isselected As BOOL**

  

- **[SIZE=4]**Methods**[/SIZE][SIZE=5]**:**[/SIZE]**

- **Initialize As void**
*Initializes the fields to their default value.*
  
  
  
(Live preview on my new App FileCube)  
  
[MEDIA=youtube]Oa4a4ReEifo[/MEDIA]  
  
  
\*\* License: You can use this lib in any of your Projects. You may not sell or publish the lib files in any other forum  
without my permission. If you like the lib please consider a [**donation**](https://www.paypal.com/donate?hosted_button_id=5STJ2LSAHK9LW)since it took me a lot of time to create it :)