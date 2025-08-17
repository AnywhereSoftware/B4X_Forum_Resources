### [SithasoDaisy5] Creating your 2nd MySQL CRUD WebApp using REST API With API-Key (Php) - FamilyTree by Mashiane
### 04/23/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/166593/)

Hi Fam  
  
  
[Download](https://github.com/Mashiane/SithasoDaisy5) (Source code is in the tutorials folder)  

**READ THIS FIRST**

  
  
In our first example, we introduced you to MySQL CRUD WebApps using SithasoDaisy5. It was a basic example to get you going building your first CRUD App. It also helps you setup your dev environment and the tools needed to get this going. You need to understand that first.  
  
<https://www.b4x.com/android/forum/threads/sithasodaisy5-creating-your-first-mysql-crud-webapp-using-rest-api-with-api-key-php.166269/>  
  
Let's go continue into this beautiful app. This is becoming beautiful…  
  
![](https://www.b4x.com/android/forum/attachments/163405)  
  
This has been inspired by Vertigos Family.Show Project  
  
![](https://www.b4x.com/android/forum/attachments/163370)  
  
  
  
This example is a little advanced as it looks at other input components like selects, images, file selectors (dropdown), selects etc.  
  

1. You will learn how to select an image file and then update an image from the file you selected.
2. You will learn how to add options to a dropdown from a database. Whilst this will be from the same database table, using the same approach you can use another database table.
3. You will learn the concept of self-referencing database schemas

We will use the same approach as before. And our final screen would look like this.  
  
**Creating the people table.**  
  
As we are continuing with an existing project, we will use the old stock mysql database.  
  
We create the people table to store our family members with this command. Open MySQL and execute this command. Please note this table schema is not really optimised.  
  

```B4X
CREATE TABLE If Not EXISTS `people` (`id` VARCHAR(255) PRIMARY KEY, `profiledisplay` LONGTEXT, `gender` VARCHAR(255), `firstname` VARCHAR(255), `middlename` VARCHAR(255), `lastname` VARCHAR(255), `suffix` VARCHAR(255), `dateofbirth` VARCHAR(255), `isliving` BOOL, `placeofbirth` VARCHAR(255), `dateofdeath` VARCHAR(255), `placeofdeath` VARCHAR(255), `father` VARCHAR(255), `mother` VARCHAR(255), `parentsstatus` VARCHAR(255), `clannames` LONGTEXT)
```

  
  
**Table & Preference Dialog Entry (we use a table and preference dialog to enter information about the family members)**  
  
![](https://www.b4x.com/android/forum/attachments/163385)