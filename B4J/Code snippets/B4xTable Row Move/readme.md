### B4xTable Row Move by rodmcm
### 06/03/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/118577/)

The order of the rows can be changed with the Up and Down buttons from the start to the end of the table rows/records  
  
Obviously saving the B4XTable data after a move secures the changes  
  
At each move I have used a map to gather the selected record information and converted to a list for entry in the row/record above or below the selected record  
There is probably a cleaner way of doing this.  
  
The solution and table creation is generalized for any size database, and as it uses the stored RowIds will work after additions and deletions of the original records  
I store the Row IDs on a cell click.. This always ensures that the rowID list is up to date