### intent for beginner - messages between apps by Hamied Abou Hulaikah
### 10/20/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/123680/)

**Part 1**  
1- Intent is exactly a Specific Message between Android Apps.  
Building this message is simple in B4A:  

```B4X
dim intent1 as intent
```

  
  
2- Any message (ie: intent) has a specific purpose to tell target app to do it, like SEND, CALL etc…  
So you initialize the intent with thats purposes ACTION  

```B4X
intent1.initialize(intent1.ACTION_*,"")
```

  
Actions are string parameters, You can set action parameter with intent object action property, or if you want more actions: In your Android SDK directory, under /platforms/android-x/data (x being the API level), you will get many text files, just explore them.  
  
3- Now you have the option to specify the target app you want to talk with it by intent setPackage method, or you can omit it if you want the client to pick up which app  

```B4X
intent1.setpackage("com.example.app") 'target app package name
```

  
  
  
4- As we said intent is a message, so you should determine the message mime type as the following:  

```B4X
intent1.setType("*/*") 'mime types ex: text/plain
```

  
[see](https://www.freeformatter.com/mime-types-list.html) the common mime types list  
  
5- Allmost of messages has content, you want to deliver it to target app, so use intent putextra method, you should determine the content data type (different than message type as above).  

```B4X
intent1.PutExtra("android.intent.extra.*","your message content data")
```

  
For common list of message content data types (called intent extra) [read this](https://developer.android.com/reference/android/content/Intent#standard-extra-data).  
  
6- Finally: Run & send the message:  

```B4X
StartActivity(intent1)
```

  
  
see you in Part 2 …  
  
Bye