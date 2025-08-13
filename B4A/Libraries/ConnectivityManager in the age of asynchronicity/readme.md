### ConnectivityManager in the age of asynchronicity by drgottjr
### 06/16/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/161677/)

this is a network connection snapshot library for recent android models. it replaces classes and  
methods relating to network connectivity that were deprecated starting with sdk 28. you may be  
interested in what google does while you're looking at really important things like wobble menus.  
  
until the latest classes, the only way to know if you were connected to a network was to poll the system.  
for google, this was an issue. how often to poll? when is a network connection going to be lost?  
how often is is going to be lost? with the latest classes, the system monitors network  
connectivity and changes in network behavior beyond the simple fact of being connected to some network.  
it raises an event for you to consume.  
   
a fortuitous minor feature of the new classes relates to internet access. in the old days, the only way to  
know if you had internet access was to ping or head a known server. if it responded, you were on line.  
the new classes apparently take care of this for you. among the numerous "capabilities" returned by the  
monitor is the result of a test made by the system to connect to the internet. but keep in mind that this is  
a capability manifested by an already connected network. it is not a proof of a network connection; you  
could still be connected to your local network but not be able to access the internet. the monitor tells  
you if it has been able to establish an internet connection. if that changes, it notifies you of the change  
(along with dozens of other changes).  
  
a less fortuitous feature of the new classes relates to data which are supposed to be returned regarding  
so-called "transport" information. at present, only wifi transport information is returned. cellular information  
is to be returned by the cellular carrier (whether or not google has informed them of this is unclear).  
i have 2 cellular providers, and neither provides the data expected. as to ethernet connections, google has not  
implemented a way to access those data. i only have wifi, cellular and ethernet connections. there are other  
types; if data from those connections are available, i cannot say.  
  
so, for what it's worth, install the amconn library in your additional libraries folder, and link to it in your project  
in the usual way. basically, you need only initialize the library, provide a sub to consume the event raised by the  
library and provide a view to show network status (or just log what it reports). the library loads the listener and  
that's it. the rest happens when it happens. you can still poll (i left a public method for that), but it makes no sense  
to do that because the system will tell you before you can ask it to tell you.  
  
this is pretty much all you need:  
  

```B4X
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Dim connection As Amconn  
    Dim edittext As EditText  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    edittext.Initialize("")  
    Activity.AddView(edittext,0%x,0%y,100%x,100%y)  
    edittext.SingleLine = False  
    edittext.Gravity = Gravity.TOP  
      
    connection.Initialize("amconn")  
  
End Sub  
  
Sub amconn_hascapabilities( capabilities As String )  
    edittext.Text = capabilities     
End Sub
```

  
  
  
attached is a sample of what you get. i've tested with android 12 and 14.  
just to be clear, much of the information shown was available before, but  
you had to ask for it (constantly). with the latest classes, the system  
constantly tells you of any changes.  
  
————————————————————————————  
UPDATE: now that my head has cleared, i've made a few modifications. the latest version  
of the library appears below. i've privatized some methods which only confused matters by  
being labeled as public. in addition, i've changed the initialization and event characteristics  
to be more in line with our conventions: 1) initialization takes an event name, and   
2) the event itself takes the eventname + "\_". these changes appear in the code snippet  
which appears above.