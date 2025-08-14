### [Web] Dynamic Database Connectivity with Automatic CRUD REST API - API.PHP by Mashiane
### 08/04/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/168084/)

Hi Fam  
  
[Original Project](https://github.com/mevdschee/php-crud-api)  
  
I've been looking at ways to get the api.php file for CRUD REST to work in a dynamic fashion so that I can get it connect to any back-end database.  
  
I found a way to do this by passing headers to the api.php file so that it can access any db. The GIF here is using the same api.php file but accesses a SQLite DB and also a MySQL file dynamically.  
  
![](https://www.b4x.com/android/forum/attachments/165798)  
  

```B4X
// — Dynamic DB Configuration via Headers —  
    $headers = getallheaders();  
    $host = $headers['X-Host'] ?? '';  
    $user = $headers['X-User'] ?? '';  
    $password = $headers['X-Password'] ?? '';  
    $dbname = $headers['X-DBName'] ?? '';  
    $driver = $headers['X-Driver'] ?? 'mysql';  
    $port = $headers['X-Port'] ?? '';
```

  
  
So in your app, you add the needed headers  
  

```B4X
Dim fetch As SDUIFetch  
    fetch.Initialize(baseURL)  
    fetch.SetContentTypeApplicationJSON  
    If UseApiKey Then fetch.AddHeader("X-API-Key", sApiKey)  
    fetch.AddHeader("X-Host", sHost)  
    fetch.AddHeader("X-User", sUser)  
    fetch.AddHeader("X-Password", sPassword)  
    fetch.AddHeader("X-DBName", sDbName)  
    fetch.AddHeader("X-Driver", sDriver)  
    fetch.AddHeader("X-Port", sPort)
```

  
  
These will be passed to the api.php library so that its dynamic and able to connect to any database back-end.  
  
Enjoy!