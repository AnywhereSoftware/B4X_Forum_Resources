### [Web] Plug n Play MySQL Database Authentication via PHP REST API in 5 minutes or less by Mashiane
### 11/17/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/164171/)

Hi Fam  
  
[Download](https://terabox.com/s/1ZFwTvWP7mO7-h4f3qxKT6w)  
  
You will recall that we did a tutorial on MySQL back-ends using a plug n play CRUD REST API (Related Topics below)  
  
This is based on this [GitHub Project](https://github.com/mevdschee/php-crud-api)  
  
In this approach we will use Database Authentication.  
  
1. Create a database called banano with a table named **users**, it must have column **username** and column **password**. You can set the username to be the primary key.  
  
2. In the **api.php** file, update the details to be using your MySQL database connection. What is new here is the **dbAuth** middleware and its settings. With **sslRedirect** we are saying the server uses HTTPS.  
  

```B4X
$config = new Config([  
        'driver' => 'mysql',  
        'address' => '127.0.0.1',  
        'port' => '3306',  
        'username' => 'root',  
        'password' => '',  
        'database' => 'banano',  
        'debug' => true,  
        'tables' => 'all',  
        'middlewares' => 'sslRedirect,sanitation,dbAuth',  
        'dbAuth.usersTable' => 'users',  
        'dbAuth.loginTable' => 'users',  
        'dbAuth.usernameColumn' => 'username',  
        'dbAuth.passwordColumn' => 'password',  
        'dbAuth.registerUser' => '1',  
        'dbAuth.loginAfterRegistration' => '0',  
        'dbAuth.passwordLength' => '12',  
    ]);
```

  
  
What we are saying here is that we will use a database for authorization,  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/web-sithasodaisy-revolutionize-your-ride-the-ultimate-vehicle-expense-tracker-app-using-api-key-secure-mysql-rest-api-on-top-of-https.160862/#content>  
  
<https://www.b4x.com/android/forum/threads/web-sithasodaisy-secure-crud-mysql-rest-api-web-app-using-api-key-on-top-of-https.160854/#content>