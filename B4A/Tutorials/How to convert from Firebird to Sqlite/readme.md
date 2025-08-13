### How to convert from Firebird to Sqlite by amorosik
### 02/14/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/146154/)

I had to deal with a database format transformation problem from [Firebird](https://www.firebirdsql.org/) to SqliteDb  
I want to share my experience because I've already seen some users who asked questions about Firebird  
And so I think some visitors to this forum may be interested in the topic  
  
To transfer a complete database or some tables from Firebird to SqliteDb  
I used two tools, both provided free of charge  
To extract data and metadata on a text file I used [IbExpert](https://www.ibexpert.net/ibe/)  
To use the text file and create the Sqlite db I used [Sqlite-Gui](https://github.com/little-brother/sqlite-gui)  
Some manual interventions on the text file are needed to eliminate some commands not 'digested' correctly by Sqlite-Gui  
  
**1- DATA AND METADATA EXTRACTION ON TEXT FILES**   
Using IbExpert, and after connecting to the desired db, it is necessary to use the Tools/Extract MetaData function  
In the upper right position on Extract To: it is necessary to indicate FILE  
In the FILE NAME textbox it is necessary to indicate the position and name of the file that will be generated  
Then in the META OBJECTS tab it is necessary to indicate the tables to be extracted and created  
In the DATA TABLE tab it is necessary to indicate the same tables from which to extract the data  
In the OPTIONS tab remove any check marks on the checkboxes  
At this point, pressing the green arrow at the top starts the creation of the text file containing the instructions necessary for creating tables, indexes, and loading data  
  
**2- MODIFY SQL INSTRUCTION FILE**  
In my case it is necessary to modify the text file because Sqlite-Gui does not 'include' some instructions  
And in particular it is necessary to eliminate all the lines like:  
SET SQL DIALECT 3;  
COMMIT WORK;  
  
**3- USING SQL INSTRUCTION FILE TO CREATE A NEW SQLITE DB**  
After modifying the text file containing the Sql instructions, it is possible to feed it to Sqlite-Gui to create the tables in the new db, create the indexes, and then load the tables with the data as read from the original Firebird db  
Create the Sqlite db using the commands:  
Databases / New-Open  
and indicating the file that will be the new Sqlite database  
Then it is necessary to start the Sql commands on the newly created db as contained in the recently modified text file  
Use commands Tools / Import / Sql  
then the name of the file containing the Sql commands will be requested, and once indicated/selected, execution will take place instantaneously  
After a few seconds, or minutes, depending on the size of the exported Firebird db, the control will be returned to the Sqlite-Gui program and the db will be correctly created and the data will populate the tables as per the original Firebird db  
  
Good luck