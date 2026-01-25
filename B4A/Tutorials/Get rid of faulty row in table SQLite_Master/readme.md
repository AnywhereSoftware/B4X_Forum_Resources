### Get rid of faulty row in table SQLite_Master by RB Smissaert
### 01/20/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/170073/)

After running some faulty code I ended up with a faulty entry in the SQLite SQLite\_Master table.  
This was a table name called NON\_CLINICAL.db.JOURNEYS. This name is faulty and was causing  
all sorts of problems. Note that is not a table name that is accessible with normal SQL.  
Now it is not that easy to get rid of this faulty row in SQLite\_Master, but this simple SQL did the trick:  
  
drop table "NON\_CLINICAL.db.JOURNEYS"  
  
Note the double quotes around the faulty table name.  
This got rid of that faulty entry and solved all the problems.  
  
RBS