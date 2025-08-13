### [Web][SithasoDaisy] Deciding on Shared Hosting vs VPS Hosting - The Vehicle Expense Tracker WebApp Use Case (PocketBase & MySQL) by Mashiane
### 05/01/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/160865/)

Hi Fam.  
  
[Demo](https://drive.google.com/file/d/10UBNMgsalJT6M9kf69W_cxpoVA14_f5_/view?usp=sharing)  
  
It is with pleasure to release an updated **Vehicle Expense Tracking WebApp (PocketBase)** and also a new version using [Secure Api Key MySQL REST API.](https://www.b4x.com/android/forum/threads/web-sithasodaisy-revolutionize-your-ride-the-ultimate-vehicle-expense-tracker-app-using-api-key-secure-mysql-rest-api-on-top-of-https.160862/#)  
  
When developing webapps, one is faced with an option to use shared hosting / vps hosting. To make this process to be a smooth transition, we have released the same application, the Vehicle Expense Tracker WebApp.  
  
Amongst other things:  

- This webapp helps you learn how to store images on the database as base64 strings.
- This webapp helps you learn how to use PocketBase, a SQLite Webserver that you can deploy on a VPS hosting
- This webapp helps you learn how to use MySQL REST API using a secure Api Key, this you can deploy shared hosting on top of HTTPS.
- This webapp also helps you learn how to view, load, relational data across your database and load this into select/combo boxes.

One of the amazing things about both these applications is that they share 99.99% code. Really? Yes.  
  
*Let me explain*  
  
1. In the MySQL REST API example, one uses the **SDUIMySQLREST** class for back-end access vs the PocketBase version one uses the **SDUIPocketBase** class. There is no other code change necessary except changing the class names.  
2. In the MySQL REST API example, the connection string is **<https://localhost/sdvetmysqlapi>** vs the PocketBase being **<http://127.0.0.1:8096>**  
3. One last thing is that the back-end on PocketBase and also on MySQL should match (database name, table names, schema)  
  
This means that whenever one decides to move from VPS to shared hosting or vice versa, the transition will be smooth. In both cases, the back-end databases should just match in terms of the schema. For this example, the id fields on each table are NOT using auto-increment and the id values are generated in a unique fashion.  
  
As you will note in this PocketBase demo, the functionality as demonstrated in the UI and screens is a 100% match.  
  
![](https://www.b4x.com/android/forum/attachments/153326)  
  
  
***How to run the Demo?***  
  
1. Download an unzip the SDVETPB.zip file.  
2. Ensure that your firewall has port 8096 opened and that your extract to folder is not read only.  
3. Double click the run\_server\_8096.bat file  
  
If all goes well, your browser will be activated and a new tab will be opened, showing a Sign In prompt. Click Sign In.  
  
**How to get the Source Code?**  
  
  
You can get the source code for the PocketBase & also the Secure API Key MySQL REST API with a minimum certificate of appreciation.  
  

- Vehicle Expense Tracker PocketBase - $5
- Vehicle Expense Tracker Secure API Key MySQL REST API - $5

<https://paypal.me/anelembanga?country.x=ZA&locale.x=en_US>  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/web-sithasodaisy-revolutionize-your-ride-the-ultimate-vehicle-expense-tracker-app-using-api-key-secure-mysql-rest-api-on-top-of-https.160862/>