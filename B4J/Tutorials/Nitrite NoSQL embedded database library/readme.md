### Nitrite NoSQL embedded database library by stevel05
### 08/19/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/126998/)

I was interested to try Erel's MongoDB example in a few projects but really didn't want to use a server implementation so I looked for an alternative and found the Nitrite library.  
  
This is a partial wrap of this github project [Nitrite-java](https://github.com/nitrite/nitrite-java)  
  
The documentation is pretty good and is available here: [Nitrite documentation](https://www.dizitart.org/nitrite-database/). There is no support for the POJO repository.  
  
Think of it as a KeyValueStore on steroids. You can search and sort records with filters. You can add fields to a record without having to change a schema.  
  
Documents can be created directly from a Map, so if you use Maps to hold records internally you are already 80% of the way there.  
  
The example application includes filtering and sorting the data which was imported from <https://github.com/samayo/country-json>.  
  

![](https://www.b4x.com/android/forum/attachments/107006)

  
  
Example applications depends on:  

- [Archiver](https://www.b4x.com/android/forum/threads/lib-archiver.21688/post-125497)

Example 2 depends on  

- [Archiver](https://www.b4x.com/android/forum/threads/lib-archiver.21688/post-125497)
- NitriteNoSQLDB-b4xlib v 1.10 (please download latest version)

Usage:  

- Download the b4xlib below and copy it to your AdditionalLibs B4x folder.
- Download additional jars from my dropbox [here](https://www.dropbox.com/s/rex2laxqiza7b05/nitrite.zip?dl=0). Unzip the file into your B4j additional libraries folder and leave them in the created nitrite folder.
- Download a NitriteExample project.

  
NitriteNoSQLDB.xml contains the library documentation that you can view with one of the available library documentation viewers (Search the forum).  
  
Update V1.10  

- Added CreateDocument3 to NitriteDocument\_Static - Create an empty document
- Added example 2 with Full CRUD example - Data imported from <https://www.briandunning.com/sample-data/>.
- Updated documentation XML

Update V 1.15  

- Bug fix on Collection.UpdateMap4, only the b4xlib has been updated.

  
Let me know how you get on with it.