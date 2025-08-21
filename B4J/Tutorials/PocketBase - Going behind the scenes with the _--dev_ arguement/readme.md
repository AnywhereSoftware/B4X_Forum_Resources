### PocketBase - Going behind the scenes with the "--dev" arguement by Mashiane
### 08/16/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/168258/)

Hi Fam  
  
In pocketbase there is an arguement that you can pass to your command to start PocketBase that goes behind the scenes and displays each and every command that pocketbase executes internally when your web server application is running. This as a result helped me understand what I needed to do differently in my deployment.  
  
*Compatibility: v22.35 (I am not using the latest version of PocketBase)*  
  
![](https://www.b4x.com/android/forum/attachments/166069)  
  
**Some interesting findings…**  
  
> These **do** a SELECT \* unless you override:  
>
> - getList(), getFullList() (REST/SDK) → ✔ full record payloads.
>
> - DAO find helpers (FindRecordById, FindFirstRecordByData, FindFirstRecordByFilter, FindRecordsByFilter, FindRecordsByIds, FindRecordsByExpr) → ✔ full columns.
> - RecordQuery(…).All/One with no .Select(…) → ✔ full columns.

  
When specified, the \*fields\* option is used to **hide** other columns and show only the ones you specify (after a select is done)  
  
**Proposed Solution(s)**  
  
Whilst still limited in functionality e.g. we dont have **expand as yet.** One will be able to ***execute own SQL command which will return the \*fields\* they specify*** and not use SELECT \*.  
The route can be called with REST using fetch / httputils etc.  
  
This is available and can be used.  
  
<https://www.b4x.com/android/forum/threads/pocketbase-rawselect-a-route-handler-to-execute-select-sql-commands.168257/>