### b4j max upload file size with nginx by juventino883
### 09/27/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/122807/)

Hi, today I have lost some time testing a B4j server app in a VPS, my app was supposed to help upload big files to the server. Locally, everything was working as expected, but when I have installed it in my VPS, I couldn't upload files bigger than 1MB, so, after loosing some time doing tests and searching for errors I got the solution, if you are using NGINX, it usually limits uploads to 1MB, so you have to edit nginx.conf file ( /etc/nginx/nginx.conf ) and insert this line: client\_max\_body\_size 100M; (this will enable a max file size of 100MB).  
  
if you are using UBUNTU:  
  
-Open nginx.conf file  
  
vim /etc/nginx/nginx.conf  
  
-press "i" to enable insertion  
  
-under http sub write client\_max\_body\_size **100M**;  
  

```B4X
http {  
  
    …  
  
    client_max_body_size 100M;  
  
}
```

  
  
-press "Esc"  
  
-write :w to write the file  
-write :q to exit  
  
-test config file to make sure everything is ok:  
  

```B4X
service nginx configtest
```

  
  
-Restart the service:  
  

```B4X
service nginx restart
```

  
  
and that's it, hope this small tutorial is helpful for someone.  
  
regards.