### [Class]  [SQLite] wmSQLiteSelectBuilder - a more or less graphical builder for SQLite SELECT statements by walt61
### 06/23/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/145988/)

As I don't use SQLite (or any other SQL) all the time and am no database expert, it's always a bit of a challenge to get the SELECT syntax right, specifically when relationships between tables (JOINs) come into play. There's that, and the fact that it was fun to develop (and I wanted to have the functionality in another project I've been working on): this class helps to build SELECT statements. I don't think it will be helpful for real end users who have never touched a database, but for developers it could be useful.  
  
**Credits**  
A big thank you to [USER=78857]@William Lancee[/USER] whose brilliant [Arrows](https://www.b4x.com/android/forum/threads/b4x-a-class-to-draw-on-canvas-many-types-of-arrows-at-any-angle.142539/) and [WiLNetChart](https://www.b4x.com/android/forum/threads/b4x-a-cross-platform-b4xpages-class-to-display-a-network-of-nodes-connected-by-arrows.143069/) classes I used for the chart. I customised the WiLNetChart class and saved it as wmWiLNetChart, which is used in this project.  
  
**Dependencies**  
- Core libraries to add: BCTextEngine, DesignerUtils, jControlsFX9, jSQL, XUI Views  
- Non-core libraries: sqlite-jdbc-3.39.2.0 (or newer)  
- Modules from the project's root folder: Arrows.bas, wmSQLiteSelectBuilder.bas, wmWiLNetChart.bas  
- Files from the project's Files folder: BBCV.bjl, wmSQLiteSelectBuilder.bjl  
  
**Example project**  
Is attached to this post. The screenshots were created working with the Chinook database (<https://www.sqlitetutorial.net/sqlite-sample-database>), and the attached file 'saved\_example.sqlite' (which can be loaded using the 'Open' button).  
  
**Usage**  
- Pass an already initialised SQL object to the class, or the directory and filename of the database with which to work  
- Localise strings by updating map 'localisationMap' which is a public variable  
- Select the tables to include in the query  
- Define table name aliases if necessary  
- Define column name aliases if necessary  
- For each table, select the columns to include in the result, filters to apply, sorting specifications, and relationships with 'child' tables (to involve a table in multiple relationships, use aliases)  
- Right-click a node in the chart to see all of the node's relationships (JOIN types, table names, column names)  
- Build the SELECT statement  
- Test the SELECT statement and inspect its result (it uses the SELECT statement that is shown at the bottom; it can be edited if desired)  
- When clicking OK, the SELECT statement is returned to the caller  
- Save the specifications (to an SQLite file) for later reuse  
- Open a saved specifications file  
  
**Updates**  
- 2025-06-23: bug fix in the Arrows class  
- 2023-08-19: bug fix in handling of filter columns and sort columns (see "This next line added 2023-08-19" in the class for the changes)  
  
Enjoy!  
  
![](https://www.b4x.com/android/forum/attachments/139012) ![](https://www.b4x.com/android/forum/attachments/139013)  
  
![](https://www.b4x.com/android/forum/attachments/139014) ![](https://www.b4x.com/android/forum/attachments/139015)  
  
![](https://www.b4x.com/android/forum/attachments/139016) ![](https://www.b4x.com/android/forum/attachments/139017)  
  
![](https://www.b4x.com/android/forum/attachments/139018) ![](https://www.b4x.com/android/forum/attachments/139019)  
  
![](https://www.b4x.com/android/forum/attachments/139020) ![](https://www.b4x.com/android/forum/attachments/139021)  
  
![](https://www.b4x.com/android/forum/attachments/139022) ![](https://www.b4x.com/android/forum/attachments/139023)