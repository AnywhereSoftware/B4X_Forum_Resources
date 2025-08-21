### [B4x] Exchange Data via OkHttpUtils and php (or other platforms) via lists, maps, arrays, etc. by KMatle
### 03/08/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/109794/)

I made **7** examples how to exchange data between B4x apps and php. I use the POSTSTRING method as it is simple, secure (get-methods will be logged with the data autmatically on the server, post-methods not), strings can be formatted very easy (JSON) and en-/decrypted (not included but see my other examples or the php documentation).  
  
You can use these basics for other "platforms", too like asp.net or even any other sw to use a "standard" exchange format which uses "one simple string" which is JSON formatted.  
  
What you need:  
  
B4J :cool:  
XAMPP (as a good test system which comes whith apache, php, MySQL and other components). You can use any other, too. The examples just use apache and php. I use it since years because it comes with a "one click install" and has all important modules (like OpenSSL for encryption).  
  
<https://www.apachefriends.org/de/index.html>  
  
1. Install it (c:/xampp ist the standard folder which I use)  
2. Copy the 5 php scripts (you find them inside the B4J project under files) to xamp/htdocs/phpexamples (create 'phpexamples' first)  
3. Start the apache service via XAMPP control center  
  
Run it with administrator rights. Apache listens to ports 80 and 443. If some other app uses these ports, just close it. Check your firewall if you run into problems  
  
![](https://www.b4x.com/android/forum/attachments/84114)  
  
 4. In the B4J app edit these lines to fit your environment. Hint: For every app your create which uses php create an own folder under /htdocs  
  

```B4X
'the ip address of the machine where apache runs (can be the same as where B4J runs)  
    Public Servername As String = "http://192.168.178.23"  
    'the path where the php files are (example 1-5) under htdocs  
    Public ScriptFolder As String = "/phpexamples/"
```

  
  
5. Run the B4J app. It executes all the 5 examples:  
  
#1: Call the first php script with no input. It returns just a simple string  
#2: Same as #1 but it returns an simple array (list/array in B4x or other platforms)  
#3: returns a associative array which is a map in B4x with key -> value pairs  
#4: returns a list with arrays = list with maps  
#5: send a map to the script and it returns the map's contents  
  
**NEW  
  
#6: Send a file to php, create an folder (if it does not exist) store it on the server and retrieve it back (including Base64 converting). NOTE: It doesn't check the size. You can set the max size in the server's configuration or use "multipart" for uploading big files.  
#7: AES-256 encryption: Encrypt in B4x, decrypt/decrypt in PHP**   
  
6. The B4J app checks what the scripts return and logs e.g. if it is a map, a list, a list with maps or just a string for learning purposes  
  
7. All lists/maps/arrays are JSON encoded/decode to/from a string which is VERY easy to use.  
  
NOTE: If you use this code on production servers, PLEASE add security options like user login, etc.  
  
Needed libs:  
  
![](https://www.b4x.com/android/forum/attachments/89650)