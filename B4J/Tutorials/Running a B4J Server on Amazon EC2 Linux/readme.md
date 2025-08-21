### Running a B4J Server on Amazon EC2 Linux by Alessandro71
### 11/24/2019
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/111656/)

This procedure starts from a freshly installed AWS EC2 Linux instance and installs a B4J server, named B4J.jar, configured as a daemon.  
This tutorial assumes a basic knowledge of a Linux environment, expecially the vi editor.  
  
**Prerequisites**  

- SSH access with ec2-user
- Device /dev/xvdh is available for data storage

  
**System setup**  
Login via SSH with ec2-user  
Update the system  

```B4X
$ sudo yum -y update
```

  
  
Set timezone  

```B4X
$ sudo vi /etc/sysconfig/clock
```

  
  
Change accordingly to your location  

```B4X
ZONE="Europe/Rome"  
UTC=true
```

  
  

```B4X
$ sudo ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime  
$ sudo reboot
```

  
  
**Storage setup**  
Create a single primary partition using fdisk  

```B4X
$ sudo fdisk /dev/xvdh
```

  
  
Format data partition  

```B4X
$ sudo mke2fs -t ext4 -L B4J /dev/xvdh1  
$ mkdir /home/ec2-user/B4J  
$ sudo vi /etc/fstab
```

  
  
Append this line  

```B4X
LABEL=B4J       /home/ec2-user/B4J      ext4    defaults,noatime        1       1
```

  
  
Mount data partition  

```B4X
$ sudo mount -a  
$ chown ec2-user:ec2-user B4J
```

  
  
  
**Java setup**  
Install Java  

```B4X
$ wget –no-check-certificate –no-cookies –header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.rpm  
$ sudo yum install -y jdk-8u141-linux-x64.rpm
```

  
  
  
**B4J setup**  
Upload B4J.jar to /home/ec2-user/B4J via sftp  
Create service control script  

```B4X
$ sudo vi /etc/init.d/B4J
```

  
  

```B4X
#!/bin/bash  
### BEGIN INIT INFO  
# Provides:          B4J Server module  
# Required-Start:    $local_fs $remote_fs $network $syslog  
# Required-Stop:     $local_fs $remote_fs $network $syslog  
# Default-Start:     2 3 4 5  
# Default-Stop:      0 1 6  
# Short-Description: Start/Stop B4J Server module  
### END INIT INFO  
# chkconfig: 35 92 1  
  
#customizable options:  
#module name  
JAR_NAME=B4J.jar  
#installation directory  
JAR_DIR=/home/ec2-user/B4J  
  
#no need to customize anything below this line  
RUNAS_USER=ec2-user  
B4J_START="cd ${JAR_DIR} ; nohup java -jar ${JAR_NAME} >nohup.out 2>&1 &"  
RUN_USER=$(whoami)  
  
b4j_pid() {  
  echo $(ps -f -C java | grep ${JAR_NAME}$ | grep -v grep | awk '{ print $2 }')  
}  
  
start() {  
  pid=$(b4j_pid)  
  if [ -n "$pid" ]; then  
    echo "Already running with pid: $pid"  
  else  
    echo "Starting…"  
    if [ "$RUN_USER" == "$RUNAS_USER" ]; then  
      echo "Running with current user"  
      bash -c "$B4J_START"  
    else  
      echo "Running with switch user"  
      su - $RUNAS_USER -c "$B4J_START"  
    fi  
    status  
  fi  
}  
  
stop() {  
  pid=$(b4j_pid)  
  
  if [ -n "$pid" ]; then  
    echo "Stopping…"  
    kill $pid  
  else  
    echo "Server not running"  
  fi  
}  
  
status() {  
  pid=$(b4j_pid)  
  if [ -n "$pid" ]; then  
    echo "Running with pid: $pid"  
  else  
    echo "Not running"  
  fi  
}  
  
  
case "$1" in  
  start)  
    start  
    ;;  
  
  stop)  
    stop  
    ;;  
  
  status)  
    status  
    ;;  
  
  restart)  
    stop  
    start  
    ;;  
  
  *)  
    echo "Usage: $0 {start|stop|restart|status}"  
    exit 1  
  
esac  
  
exit 0
```

  
  
Add to system services  

```B4X
$ sudo chmod +x /etc/init.d/B4J  
$ sudo chkconfig –add B4J
```

  
  
Server instance can be controlled with  

```B4X
$ service B4J start  
$ service B4J stop
```

  
  
It will also auto-start at system reboot.