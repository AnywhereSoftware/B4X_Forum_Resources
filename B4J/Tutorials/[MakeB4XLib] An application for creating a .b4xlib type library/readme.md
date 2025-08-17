### [MakeB4XLib] An application for creating a .b4xlib type library. by T201016
### 04/28/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/147665/)

Hello,  
Seminar on the **MakeB4XLib** **application version 1.7**,  
which is a tool for creating libraries of the "B4X Library (.b4xlib)" type.  
  
In this seminar I will use an example directory structure, namely:  
  
**B4A platform structure:**  
> [SIZE=3]F:\SDK\_AndroidsLibraries\Anywhere Software\B4A  
> F:\SDK\_AndroidsLibraries\Anywhere Software\B4A\Libraries  
> F:\SDK\_AndroidsLibraries\Anywhere Software\B4A\Source  
> F:\SDK\_AndroidsLibraries\Anywhere Software\B4A\Source\Manifests[/SIZE]

*Explanation:*  
**Libraries** - is the configuration path for additional B4A Anywhere Software libraries.  
**Source** - is the configuration path for your new libraries (.b4xlib).  
 It will usually contain the folders of the next libraries you create  
 and configuration files (DeployData) created by the program.  
**Manifests** - is the configuration path for the global set of Manifests.  
 Usually it will contain a single text file - manifest.txt  
  
**B4J platform structure:**  
> [SIZE=3]F:\SDK\_AndroidsLibraries\Anywhere Software\B4J  
> F:\SDK\_AndroidsLibraries\Anywhere Software\B4J\Libraries  
> F:\SDK\_AndroidsLibraries\Anywhere Software\B4J\Source  
> F:\SDK\_AndroidsLibraries\Anywhere Software\B4J\Source\Manifests[/SIZE]

*Explanation:*  
**Libraries** - is the configuration path for additional B4A Anywhere Software libraries.  
**Source** - is the configuration path for your new libraries (.b4xlib).  
 It will usually contain the folders of the next libraries you create  
 and configuration files (DeployData) created by the program.  
 For this seminar we will use a prepared folder called "B4XPasswordGen v.1.01",  
 in the path: *F:\SDK\_AndroidsLibraries\Anywhere Software\B4J\Source*.  
  
 Decompress the file (B4XPasswordGen v.1.01.ZIP) to the indicated path beforehand,  
 i.e. to *F:\SDK\_AndroidsLibraries\Anywhere Software\B4J\Source*.  
  
![](https://www.b4x.com/android/forum/attachments/141565)  
  
**Manifests** - is the configuration path for the global set of Manifests.  
 Usually it will contain a single text file - manifest.txt  
  
Now let's move on to configuring the **MakeB4XLib version 1.7 application**.  
  
1. Launch MakeB4XLib v1.7:  
  
![](https://www.b4x.com/android/forum/attachments/141566)  
  
Open the "*Options*" Menu and select the "*File Locations*" item or use the **CTRL+L** keys.  
Another window will be displayed, and in it you will find the fields that you must fill in one by one and confirm with the **DONE** button.  
It contains available paths to EXISTING ZIP compressors on your hard drive. In our example, JDK has been selected as the available compression method for newly created libraries like "B4X Library (.b4xlib)".  
  
![](https://www.b4x.com/android/forum/attachments/141567)  
  
Then specify the configuration path for additional B4J Anywhere Software libraries.  
You will find it in the B4J Menu under *Tools/Track Configuration*.  
**You will do it in STEP 1** (see picture).  
  
Then add to the list "*Source files projects folders:*" prepared folder "B4XPasswordGen v.1.01",  
in the path *F:\SDK\_AndroidsLibraries\Anywhere Software\B4J\Source.*  
**You will do it in STEP 2** (see picture).  
  
Note that the following boxes will be filled automatically: *MODULES | FILES | APPS*  
Of course, in this prepared example only the *MODULES* box will be filled,  
for the B4J platform.  
  
With another move, you can fill in/change the required fields:  
- Library Name,  
- Library Target,  
- Library Athor,  
- Version.  
  
After completing the fields above, you can save all changes by selecting "*File/Save DeployData*" from the Menu or use the **CRTL+S** keys.  
  
The file "B4XPasswordGen v.1.01.dat" will then be created in the path: *F:\SDK\_AndroidsLibraries\Anywhere Software\B4J\Source.*  
It will be used to open this project in subsequent sessions.  
You need to know that the application after the next resume (launch)  
opens the last used project. This makes it easier to work on multiple library projects.  
  
With the next move, you can edit the Manifest.txt file, to make any changes.  
You can do this by selecting "*Edit Manifest*" from the Menu.  
  
![](https://www.b4x.com/android/forum/attachments/141568)  
  
Finally, you can proceed to create the "B4XPasswordGen v.1.01" library.  
You do this by selecting "*Make B4XLib*" from the Menu. The library file will stay  
saved in path: *F:\SDK\_AndroidsLibraries\Anywhere Software\B4J\Libraries.*  
  
I only provide the compiled full version of this (**DriveGoogle**: [application](https://drive.google.com/file/d/1SFllEMarKO8kQwyLiEN0io_ZkdNWlqWg/view?usp=sharing)).  
However, any donation to further develop this project is welcome.  
Regards.  
  
If any of my posts were helpful, please consider a donation of any amount  
[![](https://www.b4x.com/android/forum/attachments/btn_donate-png.133028/)](https://www.paypal.me/T201016).. or clicking the Like button would be appreciated too.