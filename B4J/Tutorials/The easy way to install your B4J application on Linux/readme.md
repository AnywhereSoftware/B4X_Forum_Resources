### The easy way to install your B4J application on Linux by MarcoRome
### 12/31/2019
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/112629/)

This is meant to be a tutorial for you to easily distribute your applications developed in linux.  
Through B4JPackager11 and B4JPackager v1.50 the excellent tool developed by Erel gives us the possibility of obtaining a convenient installation file using install Inno Setup. This is for the Windows world.  
Unfortunately, there is not much for Linux as installers.  
By sending two files to the customer, even the person who has no experience with Linux will be able to install your program easily and without any problems.  
  
1. Create the package through B4JPackager11 (<https://www.b4x.com/android/forum/threads/b4jpackager11-the-simplest-way-to-distribute-ui-apps.99835/>).  
You will get a directory (build) with all the necessary files.  
  
![](https://www.b4x.com/android/forum/attachments/86957)  
  
2. Preparation of the nameprogram.desktop file  
The script will contain the following lines:  

```B4X
[Desktop Entry]  
Version=1.0  
Name=TRADING  
Comment=TRADING  
Exec=/usr/TESTLINUX2/build/run.command  
Icon=/usr/TESTLINUX2/build/devil-icon.ico  
Terminal=false  
Type=Application
```

  
where the Exec and Icon line contain the path of where you are going to install the program.  
  
3. Preparation of the install\_trading.sh file  

```B4X
#Install  
echo "To install, enter the password."  
sudo mkdir /usr/TESTLINUX2  
sudo unzip -o app_devil_trading.zip -d /usr/TESTLINUX2  
unzip -o app_devil_trading.zip "nameprogram.desktop" -d $HOME/Scrivania nameprogram.desktop  
clear  
#Delete install files  
echo "Installation Complete !!"  
echo "1. Select the testlinux_trading.desktop file and click the right mouse button"  
echo "2. Select 'Allow execution'"  
echo "Good job"  
echo "We remain at your disposal"  
echo "Email: info@devil-app.com"  
echo "Press enter to exit …"  
read text  
cd ..  
rm -r Software_DevilApp
```

  
  
this will be one of the files that will be distributed, the client running this file will install your system on linux  
  
4. Preparing the prepare\_install.sh file  
The script will contain the following lines:  

```B4X
#Devil-App  
#File autoinstall Format zip  
#Zip Folder build  
cd /home/devil/Scrivania/B4JPackager11/Objects/temp  
zip -r /home/devil/Scrivania/B4JPackager11/Objects/app_devil_trading.zip build/  
cd ..  
zip app_devil_trading.zip nameprogram.desktop  
cp app_devil_trading.zip Software_DevilApp  
cp install_trading.sh Software_DevilApp  
#End compress
```

  
  
The file zips the Build directory and adds the nameprogram.desktop file to the zip file.  
Once this is done, copy the 2 files that you are going to distribute (app\_devil\_trading.zip + install\_trading.sh) into the "Software\_DevilApp" folder.  
So what you are going to distribute is contained in the "Software\_DevilApp" folder.  
After sending the folder with the content, the customer will simply have to click on the install\_trading.sh file and it will be installed automatically by creating an icon on the linux desktopo and deleting the superfluous files at the end of the installation, as in the following video:  
  
[MEDIA=youtube]2X2PnK8OvAM[/MEDIA]  
  
  
Thats all.  
Have a nice new year 2020 ???  
\*\* The system has been tested on Ubuntu and Mint \*\*  
Bye  
Marco