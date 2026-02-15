### [Web] PHP-CRUD-API Plug-Ins (Queries, Forms, Authentication, Email, SSE and more) by Mashiane
### 02/09/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/169739/)

Hi Fam  
  
This thread is about middleware and controllers added and useful with the PHP-API-CRUD.  
  
![](https://www.b4x.com/android/forum/attachments/169682)  
  
  
<https://www.b4x.com/android/forum/threads/the-giant-api-engine-ebook-source-code-is-out.170209/>  
  
**Available Plug-Ins  
  
SecureQueryController** - execute sql commands via REST API  
**FormDataController** - handling FormData when files are uploaded to the DB  
**StoredProcedureController** - CRUD features for stored procedures - create, update, read, delete them  
**AuthJwtMiddleware** - admins and user management functionality. Add Plug n Play user authentication to database. This uses various tokens.  
**MailController** - send emails e.g. reset password, verify account, confirm password and other emails  
**EmailTestController** - test email functionality as part of setup for your back-end, uses PhpMailer.  
**AuthController** - admins and user management functionality. Add Plug n Play user authentication to database. This uses various tokens,  
**SSEController & SSEServer**- adding SSE to your back-end for pub/sub functionality.  
  
**Background**  
  
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