### Large & Searchable List with SearchView + B4XSerializator by Erel
### 08/12/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/61872/)

**Better to use: <https://www.b4x.com/android/forum/threads/b4x-sqlsearchview-sqlite-based-search-view.133379/>**  
  
Two very important methods were added to B4XSerializator in [RandomAccessFile v2.20](https://www.b4x.com/android/forum/threads/updates-to-internal-libraries.59340/#post-389929):  
ConvertObjectToBytesAsync and ConvertBytesToObjectAsync.  
  
With these methods you can asynchronously convert objects to bytes and vice versa. This allows doing things that previously were not possible.  
RDC2 for example is based on these methods: <https://www.b4x.com/android/forum/threads/61801/#content>  
  
[SearchView](https://www.b4x.com/android/forum/threads/19379/#content) was introduced in 2012. SearchView shows a list with an EditText that acts as a filter.  
It uses an in-memory index to find the matching items. SearchView is very useful, however it was limited to about 500 items as it takes time to build the index and the UI is frozen until the index is ready (the main thread is busy building the index).  
  
Now with B4XSerializator and a small B4J program we can easily load 10,000 items or more to SearchView.  
The B4J program will create the index and save it into two files. The first file holds the items list and the prefix based index  
The second file holds the secondary index (full text index) which is much larger.  
  
In the B4A program we will first load the smaller index and then the larger index (they were added to the Files tab). Both are loaded asynchronously so the UI is not affected.  
Until the second index is loaded the user will only be able to search for items based on the prefix. It is highly unlikely that the user will notice this at all.  
  
![](https://www.b4x.com/android/forum/attachments/40145)  
  
  
**Why are the new async methods so important here?**  
  
On a Nexus 5 it takes 1.5 seconds until the first index is ready and another 5-6 seconds for the second index.  
As everything is done in the background, the UI is fully responsive while the data is loaded.  
If we were using the non-async methods then the UI would have been frozen for 7.5+ seconds. This is a very bad UI and is also likely to be killed by the OS.  
  
Notes  
  
- This solution is also compatible with B4i as B4XSerializator is cross platform (with some changes to work with iTableView).  
- The SearchView class is a modified version.  
- The data in this example is Alexa's top 10,000 sites.  
  
  
I'm sure that going forward we will see more and more usages for B4XSerializator.