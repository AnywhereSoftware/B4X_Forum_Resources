### jBluetooth under Linux: also works by peacemaker
### 02/26/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/165807/)

But if to make lots of preparations:  
0. Do not forget to include into the B4J library folder file: [www.b4x.com/b4j/files/bluecove-2.1.1-SNAPSHOT.jar](https://www.b4x.com/b4j/files/bluecove-2.1.1-SNAPSHOT.jar)  
  
1. Install Linux Bluetooth Bluecove stack ([the library](https://www.b4x.com/android/forum/threads/jbluetooth-library.60184/) we have, thanks, [USER=1]@Erel[/USER]):  
> sudo apt-get install bluez libbluetooth-dev

2. Include the user into "bluetooth" group:  
> sudo usermod -a -G bluetooth ${SUDO\_USER:-$USER}

4. Setup driver settings:  
> sudo cp /lib/systemd/system/bluetooth.service /etc/systemd/system/bluetooth.service **#copy the default BT settings file to edit**  
>   
> sudo sed -i 's|ExecStart=/usr/lib/bluetooth/bluetoothd|ExecStart=/usr/lib/bluetooth/bluetoothd -C|g' /etc/systemd/system/bluetooth.service **#add "-C" key to the starting line of the BT deamon (start in the "compatibility" mode)**  
>   
> sudo systemctl daemon-reload **#reload the BT deamon**  
> sudo systemctl restart bluetooth **#restart BT service**

  
5. Give rights for SDP (Service Discovery Protocol):  
> sudo chmod 0777 /var/run/sdp

  
…And do not forget to switch the BT module on at the "icon-tray"…. and anyway some non-stability of work :cool:  
![](https://www.b4x.com/android/forum/attachments/162046)  
  
  
[SPOILER=""]and if to try to make this all in the scripts of a .deb-package - to kill himself is much simpler. But i'm alive :cool: [/SPOILER]