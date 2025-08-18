### ✅  [XUI] [B4XPages] B4J PreoptimizedCLV lazy loading from SQLite and CSV - Newer developers by Peter Simpson
### 02/23/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/127940/)

Hello to you all,  
Welcome to Sheldon Coopers and Amy Farrah Fowlers fun with flags ;)  
  
Here is a simple example on using B4XPages with both an SQLite database and also a CSV file with multiple PreoptimizedCLV to retrieve country population data and flag images. Using a PreoptimizedCLV to display rows of data, card, images etc is extremely efficient and fast, even on older or slower devices.  
  
When it comes to the CSV file, yes I could have imported the file list of ISO 3166 country codes and names into the SQLite database into a new table, but this post is about showing new to B4X developers how to manipulate files and insert the data into multiple PreoptimizedCLV. The CSV file has 249 rows (2 columns) and the SQLite database table has 280,932 rows of data, the population data ranges from 1950 (fact) to 2100 (estimated), there are also 252 flag images. The code in B4XMainPage is relatively simple to follow and works with B4A, B4i and also B4J, I've added comments where feasible to do so.  
  
The population data comes directly from the UN, link below.  
<https://www.un.org/development/desa/pd/>  
  
**B4A and B4i posts**  
<https://www.b4x.com/android/forum/threads/%F0%9F%92%A1-b4x-xui-b4xpages-b4a-preoptimizedclv-lazy-loading-from-sqlite-and-csv-newer-developers.127938/>  
<https://www.b4x.com/android/forum/threads/%F0%9F%92%A1-b4x-xui-b4xpages-b4i-preoptimizedclv-lazy-loading-from-sqlite-and-csv-newer-developers.127939/>  
  
**>>> [**CLICK HERE**](https://www.dropbox.com/s/miy8lu2jtd20zce/worldpopultion1.zip?dl=0) <<< to download the B4XPages source code.  
  
Libraries needed:**  
![](https://www.b4x.com/android/forum/attachments/108577)  
  
**Desktop screenshots below:  
  
Main screen**  
![](https://www.b4x.com/android/forum/attachments/108578)  
  
**Combobox date list**  
![](https://www.b4x.com/android/forum/attachments/108579)  
  
**Filtered searches use a PreoptimizedCLV**  
![](https://www.b4x.com/android/forum/attachments/108580)  
  
**Flags are displayed in a PreoptimizedCLV**  
![](https://www.b4x.com/android/forum/attachments/108581)  
  
  
**Enjoy…**