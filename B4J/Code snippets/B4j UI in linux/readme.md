### B4j UI in linux by derez
### 10/12/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/169005/)

In continuation to this <https://www.b4x.com/android/forum/threads/run-b4j-java-and-javafx-ui-applications-on-linux-arm32-arm64-intel-amd-computers-and-vpss.159928/post-1012091> :  
  
I succesfully use this kind of file to lauch a ui app :  
> #!/bin/bash  
> cd /home/[my user]/[all apps folder]/[app folder]  
> java –module-path /usr/share/openjfx/lib –add-modules javafx.controls,javafx.fxml,javafx.web -jar /home/[my user]/[all apps folder]/[app folder]/myapp.jar

It works for all my apps exect those with custolistview… I had to change for listview.  
Important note : file.dirapp is not like in windows, it depends on where the app is actually launched from, that is the reason for the cd line in the file.  
To launch the file I use a desktop shortcut that points to the above file wherever it is.