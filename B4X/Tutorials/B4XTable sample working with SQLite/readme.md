###  B4XTable sample working with SQLite by aeric
### 08/22/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/168336/)

[HEADING=2][B4X] B4XTableSample[/HEADING]  
A sample project to demonstrate loading SQLite data into B4XTable  
GitHub: <https://github.com/pyhoon/B4XTableSample-B4X>  
[HEADING=2]Features[/HEADING]  

- Use OkHttpUtils to download json file from a URL
- Parse the JSON as List and extract each item as Map
- Store the data into SQLite database
- Perform CRUD functions like add, retrieve, edit, delete rows
- Use B4XPreferencesDialog to show the panel for input
- Jump to a row in B4XTable

[HEADING=2]Why I created this sample project[/HEADING]  
B4X developers often confuse or don't understand how to load and save data between an SQL database and use B4XTable to display the data. B4XTable uses a in-memory database for it's internal operation. It has a single table name "data" with columns start with c0, c1, c2 and so on. Developers should not mix the internal db with their actual database. This sample shows how we can interact and work with B4XTable by connecting it to a SQLite database. In fact, B4XTable is so powerful that it actually can work with CSV files or non SQL database.  
  
[HEADING=2]Screenshots[/HEADING]  
![](https://github.com/pyhoon/B4XTableSample-B4X/blob/main/preview/B4A.png?raw=true)  
![](https://github.com/pyhoon/B4XTableSample-B4X/blob/main/preview/B4J.png?raw=true)