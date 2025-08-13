### [SithasoDaisy5] Creating your first MySQL CRUD WebApp using REST API With API-Key (Php) by Mashiane
### 04/27/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/166269/)

Hi Fam  
  
Before you start this tutorial, please ensure that your dev environment is setup by following this tutorial.  
  
<https://www.b4x.com/android/forum/threads/web-beginning-webapp-website-development-with-sithasodaisy5.166741/>  
  
*Created with pleasure using*  
[PHP CRUD API](https://github.com/mevdschee/php-crud-api)  
[BANano](https://www.b4x.com/android/forum/threads/web-banano-website-app-pwa-library-with-abstract-designer-support.99740/#content)  
[Laragon 6](https://laragon.org/download/)  
[B4j](https://www.b4x.com/b4j.html)  
[SithasoDaisy5](https://github.com/Mashiane/SithasoDaisy5)  
[MySQL](https://www.mysql.com/)  
[DaisyUI](https://daisyui.com/)  
  
In this tutorial we will create our first MySQL CRUD WebApp using REST API. SithasoDaisy5 is still in BETA and this is just one of those test examples.  
  

1. We will create and save categories to a MySQL Database.
2. We will use a SDUI5Table and SDUIPreferences for listing and add edit functionality.
3. The REST API for security purposes will use an API Key

  
By the end of this tutorial you will have created something like this.  
  
![](https://www.b4x.com/android/forum/attachments/162862)  
  
Steps:  
  
**Preparing MySQL Back-End**  
  
1. Get a unique API key from [this](https://generate-random.org/api-key-generator) website  
2. Update the env.json file with your API key. This is the key you will use with MySQL.  
3. Update the env.json file with the API URL. This is the exact path in your server the REST API will access records from. In our case its, <http://localhost/stock>. When deploying on public server, use the actual URL of your server where you deployed your WebApp.  
  

```B4X
{  
    "api-key": "jNOEqK8xvAqWWRf7B4jlw2ppOCeBoHunex4ViA1txPrG7V9DW1dG737HhseS4E5Ca3xVaUtUwbDRIOrkwEZv7SEvUQP6jClRpDESkRUnshgyngNDd2epbJWjF48xAzKp",  
    "api-url": "http://localhost/stock"  
}
```

  
  
  
4. Let's create a database called stock, in here we will create a table named categories. We set the auto-increment column id, a name field and a color field. For now we wont optimize the sizes of the columns, as this is a demonstration.  
  
![](https://www.b4x.com/android/forum/attachments/162854)  
For more details see the **Main.BANano\_Ready** subroutine of how this information is read for use.  
5. In our project, we update the categories.php file. This is the rest api file the app will use.  
From line 12765, update the stock.php file to use the credentials to connect to your database. You will also use the api key here. This way when your app passes the api key, the rest api scripts will validate it against the one specified in the php file. You can use any file name you want for the REST API scripts. We have called ours *stock.php.*  
  

```B4X
$config = new Config([  
        'driver' => 'mysql',  
        'address' => 'localhost',  
        'port' => '3306',  
        'username' => 'root',  
        'password' => '',  
        'database' => 'stock',  
        'debug' => false,  
        'tables' => 'all',  
        'middlewares' => 'sslRedirect,apiKeyAuth,sanitation',  
        'apiKeyAuth.keys' => 'jNOEqK8xvAqWWRf7B4jlw2ppOCeBoHunex4ViA1txPrG7V9DW1dG737HhseS4E5Ca3xVaUtUwbDRIOrkwEZv7SEvUQP6jClRpDESkRUnshgyngNDd2epbJWjF48xAzKp',  
        'apiKeyAuth.header' => 'X-API-Key',  
    ]);
```

  
  
You can also specify the username and password for the connection.  
  
**Preparing the UI**  
  
When our app starts, BANAno\_Ready will be executed.  
  

```B4X
Sub BANano_Ready  
    'get the env.json content  
    Dim env As Map = BANano.Await(BANano.GetFileAsJSON("./assets/env.json?" & DateTime.Now, Null))  
    'get the api key  
    APIKey = env.Get("api-key")  
    'get the path to the URL  
    ServerURL = env.Get("api-url")  
    pgIndex.Initialize  
End Sub
```

  
  
This will read the env.json file and then execute **pgIndex.Initialize**, which is where our app will be built.  
  
When pgIndex.Initialize starts, it initializes the app, load a base layout. This base layout is made up of the drawer, navbar, pageview and drawermenu. In most cases, there is no need to change anything in the base layout. This layout is **COMPULSORY** for all SithasoDaisy5 WebApps.  
  
![](https://www.b4x.com/android/forum/attachments/162855)  
  
We have used Generate Members, to generate the components in code  
  

```B4X
Private appdrawer As SDUI5Drawer        'ignore  
    Private appnavbar As SDUI5NavBar        'ignore  
    Private pageView As SDUI5Container        'ignore  
    Private drawermenu As SDUI5Menu        'ignore
```

  
  
**The Drawer**  
  
In the drawer menu, we will create our items to access the various pages of our application. This looks like this and is accessible when clicking the hamburger menu icon in the navbar.  
  
![](https://www.b4x.com/android/forum/attachments/162856)  
  
This is built from this code, which also creates parent child relationships.  
  

```B4X
Sub CreateDrawerMenu  
    drawermenu.AddMenuItemIconText("pg-categories", "", "Categories", False)  
   
    drawermenu.AddItemParent("", "settings", "", "Settings")  
    drawermenu.AddItemChild("settings", "pg-users", "", "Users")  
    drawermenu.AddItemChild("settings", "pg-permissions", "", "Permissions")  
   
End Sub
```

  
  
We have prefixed each link with **pg-** so that we can differentiate between the pages. Each time we click an item in the drawer, we receive the item key  
  

```B4X
Private Sub drawermenu_ItemClick (item As String)  
    'close the drawer on menu item click  
    appdrawer.OpenDrawer(False)  
    'close the swap button  
    appnavbar.Hamburger.Active = False  
    'to force the drawer to close you can execute  
    'appdrawer.ForceClose  
  
    Dim sprefix As String = App.UI.MvField(item, 1, "-")  
    Dim ssuffix As String = App.UI.MvField(item, 2, "-")  
    Select Case sprefix  
    Case "pg"  
        'only mark this item as active  
        BANano.Await(drawermenu.SetItemActive(item))  
        Select Case ssuffix  
        Case "categories"  
            pgCategories.Show(App)  
        Case "users"  
            'pgInfoBox.Show(App)  
        Case "permissions"  
'                pgGroupSelect.Show(App)  
        End Select  
    End Select  
End Sub
```

  
  
When each item is clicked, we get its prefix and suffix, if its pg, we show the respective page.  
  
One of the scripts you will notice in pgIndex.Initialize is this code  
  

```B4X
App.AddDataModel("categories", "id", True)  
    App.AddDataModelStrings("categories", Array("name", "color"))
```

  
  
What we are doing here is to tell the app the database table and schema we will use. If for example we were to use the categories table on many pages in the app, we dont have to define the schema to \*expect\* each time, we will just make a call to read it.  
  
**The NavBar  
  
![](https://www.b4x.com/android/forum/attachments/162857)  
  
Our navbar, shows the hamburger, our logo and a title.  
  
To change the logo, add a file via the Files tab. This will be stored in the assets folder of your app. In the property bag, change the Logo Image to point to the image you are using.  
  
![](https://www.b4x.com/android/forum/attachments/162858)  
  
The title of the current navbar is showing Dashboard. This is because we navigated to the Dashboard page and changed the title.  
  
You can change the navbar title in the property bag  
  
![](https://www.b4x.com/android/forum/attachments/162859)  
  
Running the App for the first time  
  
![](https://www.b4x.com/android/forum/attachments/162860)  
  
You will note that when you run the app for the first time, it shows the dashboard page. This is by design as you can have a welcome page to your app to suit your needs.  
  
Showing another page in the app is easily made with  
  

```B4X
pgDashboard.Show(App)
```

  
  
PS: All pages in the app should be created a CODE modules**