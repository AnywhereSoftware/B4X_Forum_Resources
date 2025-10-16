### User Login Demo - how-to features by Mark Stuart
### 10/15/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/169039/)

Hi y'all,  
I've been working on a demonstration app that would show a bunch of how-to's.  
  
Specifically, how to use an "admin" user and a regular user (non-admin) for login data admin (CRUD).  
All data is stored in a simple local SQLite database.  
Database fields are: id (PK Auto), username, password, email, is\_admin, reset\_code, reset\_time  
The last 2 fields are to allow the user to reset their password if they forgot their login credentials.  
  
On the login screen is the "Forgot Password?" link. Used with the users email address and a reset code, that is emailed to the email address of the user. So make sure you use a valid email address when testing this feature.  
  
I've defined the app to use the Dark Theme, with compatible secondary colors.  
This is an Activity based app, not a B4XPages app. I'm sure if you want it as a B4XPages app, you can rebuild it accordingly.  
  
Find the app zipped with screen shots, attached to this post.  
  
**Libraries used:**  
Core, IME, JavaObject, Phone, StdActionBar, xCustomListView, XUI  
  
**Modules used:**  
Activities = 6  
Code module: 2 (DBCalls, Utils)  
Service: Starter (calls DBCalls to initialize the SQLite database)  
  
**App Features:**  
Use of a copyright and version text on the Login layout. Shows use of the IME\_HeightChanged(New,Old) function to position this Label view at the bottom of the layout and when the keyboard is opened.  
  
Activity AddMenu3 used to add menu items, using the FontToBitmap Utils function. A modified function to support either FontAwesome or MaterialIcon images/icons.  
  
EditText and Panel Styling - used on the EditText views and Panel views. Rounded corners with border. See the Utils code module to see how that is applied.  
  
Clickable Label View - shows how to apply color and underlining of the Label text for the Login "Forgot Password?" option.  
  
EditText InputTypes - 3 types are used in this demo app: CAP\_WORDS, EMAIL\_ADDRESS, PASSWORD. See how that is applied in the Utils code module.  
  
Admin and Regular User Login - the admin user is allowed to add, edit, and delete users. A regular user is taken to a Welcome page. This is the difference in the app behavior between the user types (admin vs non-admin)  
  
CustomListView - consistent sizing and positioning of the panel rows. Look at the UsersList Activity module to see the code applied to bring consistent loading of the panel row. This code is now used all the time by me when using the CustomListView, because I saw the uneven loading and spacing of the panel row for 2 different devices: cell phone and tablet. Hope that helps you. (See functions: LoadUsers and CreateUserRow. Specifically the CreateUserRow how it creates a temporary panel (pTemp), sizes it and then loads the layout. Then the actual panel (p) is used to load the CustomListView layout.  
  
Passing values from the List to the Edit Activity - shows how to pass a Map (person) to the UserEdit Activity, then allowing that activity to see if it is initialized. If it is initialized then the code knows it is in Edit mode and not Add mode. This method can be used in the B4XPages type app.  
  
ResetPassword Activity - Reset Code feature. Interesting ChatGPT code used in this feature.  
Notice in the Activity\_Create code how ChatGPT defined the code to access all the txtDigit EditFields and then sets the properties for each EditText view in a For loop. Very quick and efficient code method.  
Single entry of the Reset Code feature - Again, ChatGPT code to handle the typing in of the code and the Back key handling to clear each typed in reset code. Then there is the code to "swipe" each of the txtDigit input fields - ClearAllDigits function is where this happens. I went thru a few ChatGPT code iterations before it was acceptable to use. I played around with the Sleep() numbers so that the "swipe" happened in a decent time for the user.  
  
Notes and Observation - I've been using **ChatGPT** for about a month now, and find it likes to continue to let you know there is something it can add to what was originally asked of it. Some of these additional offers are quite interesting. It suggested the "swipe" effect on the Reset Code (txtDigit EditText views) feature. I liked it, so added it.  
ChatGPT is quite clever in building the code in its response. I think I would have taken a long time building the code it gives, or I would never have thought of writing the code that way.  
  
B4A Default vs B4XPages - I have been using B4A and B4J since 2011. I've gotten used to it and know exactly how I'm to layout the app with its Activities and Code Modules. It has become second nature. I recently "converted" an Activity app to B4XPages. I ran in to lots of issues that are normal to do in an Activity app. I'm not convinced yet of going to the B4XPages method.  
Getting the **IME\_HeightChanged** to work, failed. I looked up how to apply it from the sample code from Erel. That's where I stopped and went back to the Activity module method. And don't get me started on how managing the pages definition and ShowPage methods. I have to create 4 code lines to access another page! I'll stay in my lane on this.  
  
Going Forward  
I've built this demonstration as an example of how it will be applied to another app I'm building. I like to build demos for concept proofing ideas. If it works, then it is mostly a copy and paste to the main project I'm building.  
  
So I hope this can help someone in some way. I learnt a lot doing this demo, with the help of ChatGPT.  
  
EDIT: would love to hear from anyone how this demo benefits you and what you think can be modified to make it even better.  
  
Regards,  
Mark Stuart