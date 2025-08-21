### Ubuntu 18.04 OpenJDK 11 & OpenJFX 11 B4J UI Sample by rwblinn
### 12/09/2019
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/110175/)

Sharing my *first* experience on how to develop a B4J UI application using the B4J-Bridge, in a window on Ubuntu 18.04.3 LTS (Codename bionic) running on an ACER Aspire.  
My aim is to develop some client B4J UI applications running in a window under Linux (and not full screen like for example on a Raspberry Pi) to interact with connected microcontrollers or SBC's.  
  
![](https://www.b4x.com/android/forum/attachments/84397)  
  
The steps below outline the installation of the OpenJDK/JFX, B4J-Bridge and run a simple B4J UI Application using the B4J-Bridge.  
*NOTES*  
1) Username used: rwbl. 2) Next step is to test the B4JPackager11 on Ubuntu.  
  
**1. Download OpenJDK 11 + OpenJFX 11 Archive**  
Read [this](https://www.b4x.com/android/forum/threads/b4jpackager11-the-simplest-way-to-distribute-ui-apps.99835/) post and download from the Linux archive listed under the **Plattforms** section.  
The archive is stored in the Downloads folder   

```B4X
/home/rwbl/Downloads.
```

  
  
**2. Create JDK Folder**  
Created a sub-folder java/jdk11 in the Home folder.  

```B4X
mkdir /home/rwbl/java/jdk11
```

  
  
**3. Extract Archive**  
Extracted the archive, using the Ubuntu file manager, to the JDK11 folder /home/rwbl/java/jdk11.  
  
**4. Create Environment Variable**  
Created the environment variables pointing to Java Runtime:  

```B4X
export JAVAB4J_HOME=/home/rwbl/java/jdk11/bin
```

  
Check if the environment variable is correct:  

```B4X
$JAVAB4J_HOME  
-bash: /home/rwbl/java/jdk11/bin: Is a directory
```

  
*NOTES*  
Using the $JAVAB4J\_HOME environment variable, because had also installed other Java versions, like the latest OpenJDK 11 and higher versions.  
It is not required to create another environment variable pointing to the JavaFX folder,  
because the B4J-Bridge searches for the JavaFX sub-folder under $JAVAB4J\_HOME.  
To make the environment variables permanent, create a sh file.  

```B4X
sudo nano /etc/profile.d/rwblenvvars.sh
```

  
with content  

```B4X
export JAVAB4J_HOME=/home/rwbl/java/jdk11/bin
```

  
  
Use unset VARIABLE to remove.  
  
Read more about Ubuntu Environment vars here: <https://help.ubuntu.com/community/EnvironmentVariables#System-wide_environment_variables>  
  
**5. Create the B4J-Bridge Folder**  
Created a sub-folder b4j in the Home folder  

```B4X
mkdir /home/rwbl/b4j
```

  
  
**6. Download the B4J-Bridge**  

```B4X
wget www.b4x.com/b4j/files/b4j-bridge.jar
```

  
  

```B4X
–2019-10-04 10:04:29–  https://www.b4x.com/b4j/files/b4j-bridge.jar  
Resolving www.b4x.com (www.b4x.com)… 67.227.218.133  
Connecting to www.b4x.com (www.b4x.com)|67.227.218.133|:80… connected.  
HTTP request sent, awaiting response… 301 Moved Permanently  
Location: https://www.b4x.com/b4j/files/b4j-bridge.jar [following]  
–2019-10-04 10:04:30–  https://www.b4x.com/b4j/files/b4j-bridge.jar  
Connecting to www.b4x.com (www.b4x.com)|67.227.218.133|:443… connected.  
HTTP request sent, awaiting response… 200 OK  
Length: 240461 (235K) [application/java-archive]  
Saving to: ‘b4j-bridge.jar’  
b4j-bridge.jar                100%[=================================================>] 234,83K   141KB/s    in 1,7s  
2019-10-04 10:04:32 (141 KB/s) - ‘b4j-bridge.jar’ saved [240461/240461]
```

  
  
**7. Start the B4J-Bridge**  

```B4X
sudo $JAVAB4J_HOME/java -jar b4j-bridge.jar
```

  
  

```B4X
B4J-Bridge v1.43  
Running on Java 11+  
JavaFX modules: javafx.swing,javafx.media,javafx.base,javafx.swt,javafx.fxml,javafx.web,javafx.graphics,javafx.controls  
External JavaFX path: /home/rwbl/java/jdk11/javafx/lib  
Waiting for connections (port=6790)…  
My IP address is: 192.168.1.29  
FTP Server started: ftp://192.168.1.29:6781  
Start B4J-Bridge with -disableftp to disable.  
Connected!  
Streams_terminated  
Waiting for connections (port=6790)…  
My IP address is: 192.168.1.29
```

  
*NOTES*  
Check out that the JavaFX modules have been found and the external JavaFX path is found.  
Note the "My IP address".  
  
**8. Create B4J UI Sample Application**  
On the development device, create using the B4J IDE a simple test application.  
The layout file Main.bjl contains a pane, label and button.  

```B4X
#Region  Project Attributes  
 #MainFormWidth: 400  
 #MainFormHeight: 300  
#End Region  
Sub Process_Globals  
 Private fx As JFX  
 Private MainForm As Form  
 Private Button_Close As Button  
End Sub  
Sub AppStart (Form1 As Form, Args() As String)  
 MainForm = Form1  
 'Load the layout file stored in the files folder (DirAssets)  
 MainForm.RootPane.LoadLayout("Main")  
 MainForm.Title = "B4J HowTo Hello World JDK11"  
 MainForm.Show  
End Sub  
Sub Button_Close_Click  
 MainForm.Close  
End Sub
```

  
  
**9. Run the B4J UI Sample Application**  
In the B4J IDE, connect to the B4J Bridge running on the Ubuntu PC (=check out the IP address under "My IP address is").  
Check the terminal for connected.  

```B4X
B4J-Bridge v1.43  
Running on Java 11+  
JavaFX modules: javafx.swing,javafx.media,javafx.base,javafx.swt,javafx.fxml,javafx.web,javafx.graphics,javafx.controls  
External JavaFX path: /home/rwbl/java/jdk11/javafx/lib  
Waiting for connections (port=6790)…  
My IP address is: 192.168.1.29  
FTP Server started: ftp://192.168.1.29:6781  
Start B4J-Bridge with -disableftp to disable.  
Connected!  
Streams_terminated  
Waiting for connections (port=6790)…  
My IP address is: 192.168.1.29  
Connected!
```

  
  
**Compile and run.**  
The B4J sample application window shows up on the Ubunto Desktop.  
The terminal logs:  

```B4X
Starting program
```

  
  
**Exit the application by clicking on button Close.**  
The terminal logs:  

```B4X
ProcessCompleted
```

  
  
*Hints*  
To make a screenshot of the B4J Application, press the print screen button.  
The screenshot image png file is stored in folder /home/rwbl/pictures.  
  
**10. Run B4J Application from Ubuntu Command Line**  
The B4J sample application "helloworld.jar" is created on the development PC in the Objects folder of the B4J Project.  
Example steps to run the application from the Ubuntu Command Line.  
These steps would be required for every B4R application developed.  
  
**a. Create folder "helloworld" on the Ubuntu device**  

```B4X
mkdir /home/rwbl/b4j/helloworld
```

  
  
**b. Transfer "helloworld.jar" from development PC to Ubuntu folder "helloworld".**  
Used WinSCP to transfer the file, but FTP is also an option.  
*Hint*  
Instead of transferring the jar, use the B4J-Bridge created file.  
If the application has been tested with the B4J-Bridge as outlined earlier, the folder /home/rwbl/b4j/tempjars contains a file AyncInputN (N=number)  
Copy this file (and other files required to run) to /home/rwbl/b4j/helloworld and rename to helloworld.jar.  
  
**c. Test running the application from a Terminal Command Line.**  
This requires two environment variables JAVAB4J\_HOME (created earlier) and JAVAFXB4J\_HOME.  

```B4X
export JAVAB4J_HOME=/home/rwbl/java/jdk11/bin  
export JAVAFXB4J_HOME=/home/rwbl/java/jdk11/javafx/lib
```

  
  
Run the application with command:  

```B4X
$JAVAB4J_HOME/java –module-path $JAVAFXB4J_HOME –add-modules ALL-MODULE-PATH -jar helloworld.jar
```

  
  
The B4J application started - all fine :).  
  
**d. Bash Script**  
To close out, this solution can be put in an executable bash script, i.e. run.sh in folder /home/rwbl/b4j/helloworld  

```B4X
#!/bin/bash  
export JAVAB4J_HOME=/home/rwbl/java/jdk11/bin  
export JAVAFXB4J_HOME=/home/rwbl/java/jdk11/javafx/lib  
$JAVAB4J_HOME/java –module-path $JAVAFXB4J_HOME –add-modules ALL-MODULE-PATH -jar helloworld.jar &  
exit 0
```

  
  
Make the script executable:  

```B4X
sudo chmod +x run.sh
```

  
  
Run the script:  

```B4X
./run.sh
```

  
*Hint*  
If both environment variables are permanent, then export commands not needed, i.e. amend the file  

```B4X
/etc/profile.d/rwblenvvars.sh
```

  
so it contains  

```B4X
export JAVAB4J_HOME=/home/rwbl/java/jdk11/bin  
export JAVAFXB4J_HOME=/home/rwbl/java/jdk11/javafx/lib
```