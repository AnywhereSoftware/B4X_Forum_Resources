###  Localizator - Localize your B4X applications by Erel
### 06/23/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/68751/)

Localizator is a cross platform solution for strings localization.  
  
The strings are defined in an Excel workbook.  
  
![](https://www.b4x.com/basic4android/images/SS-2016-07-07_17.00.16.png)  
  
They are then converted to a SQLite database file with a B4J program:  
  
![](https://www.b4x.com/basic4android/images/SS-2016-07-07_17.21.20.png)  
  
The database file should be added to the Files tab of your application.  
  
Localizator is a class. You need to add it to your B4A, B4i or B4J program. It loads the set of strings based on the device locale or based on the forced locale (Localizator.ForceLocale).  
Each string is identified by a key. The key matching is case insensitive. If there is no match then the key itself is returned (the value passed to Localize method).  
  
There are some helper methods to automate the tasks. The main one is LocalizeLayout. It will go over all the views and will replace the matched keys.  
  
Values can include parameters. For example "Hello {1}!". LocalizeParams deals with such values:  

```B4X
lblHello.Text = loc.LocalizeParams("Hello {1}!", Array(edtName.Text))
```

  
{1} will be replaced with the first parameter from the array.  
  
**Notes**  
  
- In B4A it is recommended to declare and initialize the Localizator from the starter service.  
- The three examples attached are a bit more complicated as they allow the user to change the language.  
In its simplest form you just need to initialize the localizator and call loc.LocalizeLayout.  
- Languages two letters codes: <https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes>  
  
![](https://www.b4x.com/android/forum/attachments/45858) ![](https://www.b4x.com/android/forum/attachments/45859)![](https://www.b4x.com/android/forum/attachments/45867)  
  
The compiled executable jar of the B4J converter can be downloaded from: [www.b4x.com/b4j/files/B4XLocalizator.jar](https://www.b4x.com/b4j/files/B4XLocalizator.jar)  
The source code is attached (depends on XLUtils).  
  
B4A, B4i and B4J examples are also attached.  
  
Localizator v1.01 is attached.  
  
**Automating the localizator:** <https://www.b4x.com/android/forum/threads/b4x-localizator-localize-your-b4x-applications.68751/page-3#post-548169>  
  
**B4XPages example: <https://www.b4x.com/android/forum/threads/localization-example-in-b4xpages-how.148649/post-942204>**