### [ABMaterial] Template by MichalK73
### 11/09/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/134670/)

Hello.  
  
Some time ago I prepared for myself a ready-made Template for a project for ABMaterial. It makes it easier to create new projects.  
Changes:  
  
1. DBM 4 different connection to databases:  
- Mysql/mariadb  
- SQLite  
- Hikari (very fast mysql/mariadb)  
- H2  
Depending on which database we are going to support we need to unblock the jar biblite loading in the Main module.  
' #AdditionalJar: sqlite-jdbc-3.7.2.jar  
' #AdditionalJar: HikariCP-3.4.5.jar  
' #AdditionalJar: mariadb-java-client-2.6.0.jar  
' #AdditionalJar: h2-1.4.200.jar  
Additionally gives link to jar conector database libraries so you don't have to search the net.  
[**Link for odbc jar**](https://drive.google.com/file/d/16HtHSAashWwxo67ndwvz2UsGaOAdCa_0/view?usp=sharing)  
  
2. Added ready Settings module for settings in project. I always use it in my projects. It makes my work very easy. The homepage has an example of using settings from settings.  
More about it here: [**About page settings**](https://www.b4x.com/android/forum/threads/abmaterial-universal-page-for-application-settings.131563/)  
  
3. Added hashpass module. There is password generator (code from B4X forum) , support for encryption with library Decrypter by [USER=42649]@DonManfred[/USER].  
[**Library Decrypter**](https://www.b4x.com/android/forum/threads/decrypter-de-encrypt-string-to-base64-including-compatible-php-code-to-de-encrypt.52582/)  
At first you need to initialize InitDe(value As String) value is your arbitrary password string. After that, you can already use to : EncryptHash(value As String) As String and DecryptHash(value As String) As String .  
3a. Additional simple but effective function Hash Password: Hash128(email As String, password As String) good for creating password stored in database of given user.  
3b. Added 2 functions to replace national characters with acceptable ones in encryption and decryption functions.  
 - replacePL(value As String) As String  
 - dereplacePL(value As String) As String  
 They are for polish language, everyone can replace them with own national characters.  
  
4. In ABMpplication module in line 22 if we have our own DonatorKey we enter it to use additional options for Donator.  
  
5. In ABMShared added function to send Email from SMTP. SMTP account data is set in settings.  
 SendEmail(odbiorca As String, tytul As String, body As String, html As Boolean) ; odbiorca - recipient's email address, tytul - title email  
  
6. You don't have to enter the full path to the project in the browser. The domain itself is enough, e.g. <http://localhost> and you will be immediately redirected to the initial page.  
  
Copy ABMaterial.b4xtemplate file to root folder of B4J library.  
  
################################################################  
Update:2021-11-09  
 - Improved connection to databases  
 - Added complete b4x and connector jar libraries (up **Link for odbc jar**)  
 - Added LetsCrypt SSL support based on ABKeystoreSSL [USER=974]@alwaysbusy[/USER]  
 - Added some new parameters in 'config.prop' configuration file regarding SSL.  
 - Enabling SSL will force https connection  
  
![](https://www.b4x.com/android/forum/attachments/119698)