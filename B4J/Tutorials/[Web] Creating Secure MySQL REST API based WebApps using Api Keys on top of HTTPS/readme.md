### [Web] Creating Secure MySQL REST API based WebApps using Api Keys on top of HTTPS by Mashiane
### 05/01/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/160849/)

Hi Fam.  
  
This tutorial is based on the [api.php](https://github.com/mevdschee/php-crud-api) project, originally posted in the forum on September 9, 2022. See the Related Content section below.  
  
This time around we are looking at how we can use Api Keys for Authenticating our MySQL WebApps to make them secure when using REST API functionality. One should note the following for this to work.  
  
1. PDO extensions should be installed on your webserver.  
2. WebServer should be running HTTPS.  
3. You need to generate API keys for your app for authentication and add them in the api.php file.  
4. An example project that you can deploy on your test webserver is attached. See the browser and PostMan examples in the eBook here. Unzip the **sdmysqlapi-deploy.zip** file and deploy the contents in your https based webserver. You can also use Laragon for that and activate HTTPS.  
5. The eBook explains how to play around with this functionality.  
  
Get stuff [here](https://drive.google.com/drive/folders/1-IbsiIbkiPfU-tiARLcqSImu_KK0o82V?usp=sharing)  
  
**What do we mean by secure? By using an API Key for the MySQL REST API, one needs to feed a "header" key with a key to execute any call to the backend MySQL database when using the API. This should be deployed on HTTPS.  
  
![](https://www.b4x.com/android/forum/attachments/153322)**  
  
If you find my posts helpful, please consider a certificate of appreciation. [You can send it here](https://paypal.me/anelembanga?country.x=ZA&locale.x=en_US).  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/sithasodaisy-plug-n-play-php-crud-rest-api-mysql-sqlite-msserver-postgresql-for-banano.148907/#content>  
  
<https://www.b4x.com/android/forum/threads/bananovuetifyad3-vflexdialog-mysql-crud-rest-api-php-using-axios.142814/>