### SQLite Full Text Search on a Large Database and Display on an xClv by Mahares
### 08/17/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/133517/)

The primary objective of this cross-platform B4XPages SQLite FTS example is to show the syntax used for Full Text Search queries in SQLite. The database consists of close to 400000 records. It is created from scratch in the project via the imported text file Words.txt. The first time the project is run it will take a few seconds to create and convert the text file to the database, but subsequent runs become a smooth sailing.  
The project demonstrates how fast data can be searched from an FTS4 table. Please note that I only tested in mostly B4A and also B4J. I do not use B4i.  
The B4XPages project features are:  

1. Import data from a text file using StringUtils
2. Syntax to create the database and table
3. Syntax to select the data by typing a search string in a B4XFloatTextField and display of time duration for each search.
4. Display the found records on an xClv with lazy loading.
5. I also show some commented samples of select queries used in FTS4
6. Although it uses Word.txt text file for the data, it can easily be changed to a different text file. Download of words.txt can be done from post #12 of this thread and the file needs to be added to assets folder. I left it out because of its large size: <https://www.b4x.com/android/forum/threads/dictionary-application-where-is-a-good-start.133326/>