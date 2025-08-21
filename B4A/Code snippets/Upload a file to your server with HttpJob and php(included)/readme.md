### Upload a file to your server with HttpJob and php(included) by scottie
### 04/26/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/116852/)

4-25-2020  
Pick a SINGLE File from Dialog box, Then upload it To a server on LAN Or Internet  
I wrote this B4A To be very small, simple, & easy to understand on a beginners level  
In Files Is the PHP script To handle single File upload And save As original filename  
php creates And appends a logfile: b4a.fileupload.log (I found this php on the internet somewhere)  
Yes, I know about DirDefaultExternal :)  
The LAN / Remote stuff, I had To Do For MY setup  
Copy upit.php To your server  
Then make a folder called uploads (make sure this folder writable)  
  
My php.ini File settings: I like To upload very large files  
Note: If you can't SAVE changes, set security To Everyone And allow everything  
file\_uploads = On (default anyways)  
upload\_max\_filesize = 6000000M  
post\_max\_size = 5000000M  
max\_execution\_time = 6000  
max\_input\_time = 6000  
  
Hope this helps  
-Scott McKay