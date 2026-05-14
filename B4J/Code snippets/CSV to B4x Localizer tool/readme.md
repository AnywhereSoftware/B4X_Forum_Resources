### CSV to B4x Localizer tool by MbedAndroid
### 05/10/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/170979/)

Hi all,  
  
Since **the tool for converting excel to sql-db**  recently stopped working for me completely. No matter which XLSX file I tried (even old Excel 2007 files, Libre Office), the tool kept crashing due to missing POI classes such as:  
  
Code  
  
ThemeDocument$Factory  
  
After some digging it became clear that the POI version bundled with B4J cannot read modern XLSX files that contain themes or styles. Or creates a empty database  
  
  
[HEADING=1]✔ **Working Solution**[/HEADING]  
The workaround that finally solved it for me:  
  
[HEADING=2]**1. Save your Excel file as** .csv **instead of** .xlsx[/HEADING]  
This gives you a clean, comma‑separated file without themes, styles or XML structures that POI cannot handle.  
  
[HEADING=2]**2. Use a small B4J tool to convert the CSV into SQLite**[/HEADING]  
The SQLite database is generated using the same structure that B4XLocalizator expects.  
  
I’ve attached a ZIP file containing the small B4J converter app.  
  
  
[HEADING=1]⚠ **Important Notes**[/HEADING]  

- Make sure to **enable the jSQL library** in your B4J project.
- Ensure the correct **SQLite JDBC driver** is present in your *Additional Libraries* folder.
- The messages in the tool are written in my native language, but they can easily be translated to English if needed.

  
If this helps anyone who is still using B4XLocalizator or maintaining older projects, feel free to improve or extend the tool.  
Note: this program was created by Gemini bot  
Note2: B4xLocaliser itself works without any problem. <https://www.b4x.com/android/forum/threads/b4x-localizator-localize-your-b4x-applications.68751/>