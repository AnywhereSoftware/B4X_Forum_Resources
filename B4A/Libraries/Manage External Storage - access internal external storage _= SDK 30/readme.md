### Manage External Storage - access internal external storage >= SDK 30 by agraham
### 11/11/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/130411/)

Google seems intent on dumbing down Android to the point of uselessnes to me. I think of my devices as little computers and I want a proper file system on them, not the limited tortuous things that Google offers and that I don't understand, ContentChooser, FileProvider, … o\_O I'm getting old and can't cope with complications like that! :(  
  
So here is a class that lets apps on SDK 30 and higher devices treat the file store as a real file store and not some dumbed down abstracted thing. ?  
  
**It uses a new permission that Google will not allow for most Play Store apps.**  
[Manage all files on a storage device | Android Developers](https://developer.android.com/training/data-storage/manage-all-files)  
As I will never have apps in the Play Store this worries me not one jot :p  
  
  
The class uses code stolen from Erel's ExternalStorage class to provide a similar API - thank you Erel ?  
[ExternalStorage - Access SD cards and USB sticks | B4X Programming Forum](https://www.b4x.com/android/forum/threads/externalstorage-access-sd-cards-and-usb-sticks.90238/)  
  
EDIT: Note the minor convenience code modification to Sub GetPermission in the ManageExternalStorage class suggested in post #3 below.  
 in.Initialize("android.settings.MANAGE\_APP\_ALL\_FILES\_ACCESS\_PERMISSION", "package:" & **Application.PackageName**)  
  
EDIT: If for some reason you need to access folders under Android/data or Android/obb there is a loophole in post #35 here. Note that this is probably not intentional on Googles part and may be may closed in the future. If your File Explorer on your device can access these folders this is how it is doing it.  
FURTHER EDIT: This loophole now seems to be closed in Android14  
<https://www.b4x.com/android/forum/threads/%C2%A350-for-the-first-working-solution-sdk30-android-data-read-write.139016/page-2#post-880297>