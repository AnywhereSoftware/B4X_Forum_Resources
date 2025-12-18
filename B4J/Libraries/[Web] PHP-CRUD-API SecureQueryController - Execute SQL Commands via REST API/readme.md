### [Web] PHP-CRUD-API SecureQueryController - Execute SQL Commands via REST API by Mashiane
### 12/16/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/169739/)

Hi Fam  
  
The PHP-CRUD-API is a Single file PHP script that adds a REST API to a SQL database. I first discovered this some time in 2022 when I featured it here. <https://www.b4x.com/android/forum/threads/bananovuetifyad3-vflexdialog-mysql-crud-rest-api-php-using-axios.142814/>  
  
Fast forward, I've used this to create an Address Book with a Dashboard which needed some extra functionality of getting some database data and then using that to draw the dashboard content. So how did I achieve this? I created a custom controller (with the help of AI) and added it to be used with api.php. The purpose of this was to be able to execute sql commands of my choice against the database.  
  
Example  
  

```B4X
"select gender, count(*) as records from contacts group by gender"
```

  
  
Called like  
  

```B4X
api.php/query?query="select…"
```

  
  
This means the body of the REST API call should be {query:xxxx}  
  
To make this work with the php-crud-api, we update the php code to recognize the custom controller and also be able to execute it.  
  
The config section is updated with the 'customControllers' key which we created.  
  
Here are some examples…  
  
![](https://www.b4x.com/android/forum/attachments/168885)  
  
#SharingTheGoodness