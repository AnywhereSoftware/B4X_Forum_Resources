### [Web] Trying Microsoft Azure MySQL Flexible Server by Mashiane
### 07/23/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/149155/)

Ola  
  
Curious, so Im testing if I can deploy an app that will use Microsoft Azure MySQL.  
  
Things to remember:…  
  
1. Download Cert Perm file. This is on the Networking Tab (available after you create an instance of the MySQL Flex Server. This is used for secure connections and can be used for your PHP/Java/Go etc connection parameters  
  
![](https://www.b4x.com/android/forum/attachments/143931)  
  
2. Firewall rules - on same network tab. This for specifying the IP addresses with access to the stuff. You can also specify VPN connectivity.  
  
So I created a free account on Azure and will test this with PHP.  
  
So I notice that one can use either  
  

```B4X
$conn = mysqli_init();  
mysqli_ssl_set($conn,NULL,NULL, "/var/www/html/DigiCertGlobalRootCA.crt.pem", NULL, NULL);  
mysqli_real_connect($conn, 'mydemoserver.mysql.database.azure.com', 'myadmin', 'yourpassword', 'quickstartdb', 3306, MYSQLI_CLIENT_SSL);  
if (mysqli_connect_errno()) {  
die('Failed to connect to MySQL: '.mysqli_connect_error());  
}
```

  
  
or  
  

```B4X
$options = array(  
    PDO::MYSQL_ATTR_SSL_CA => '/var/www/html/DigiCertGlobalRootCA.crt.pem'  
);  
$db = new PDO('mysql:host=mydemoserver.mysql.database.azure.com;port=3306;dbname=databasename', 'myadmin', 'yourpassword', $options);
```

  
  
This should be interesting. For java and possibly b4j, I guess one has to set up the connection parameters to accept SSL, they give this guide.  
  

```B4X
String url="jdbc:mysql://mydemoserver.mysql.database.azure.com:3306/{your_database}?useSSL=true";myDbConn=DriverManager.getConnection(url, "myadmin", "{your_password}");
```

  
  
If you happen to have an idea of how we can connect via b4j using the jSQL library, please impress us. ;)  
  
So far MySQL wokbench has been able to access this back-end. Will continue testing and keep you posted. Hopefully I can have my app performing some crud soon enough.  
  
![](https://www.b4x.com/android/forum/attachments/143932)  
  
Enjoy…