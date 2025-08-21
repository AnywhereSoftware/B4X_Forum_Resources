### [BANanoVueMaterial] Creating Expenses.Show - a CRUD expense tracker with MySQL backend: Part 2 by Mashiane
### 05/19/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/114047/)

Ola  
  
**UPDATE 2020-05-19:** [**Please use this library instead**](https://www.b4x.com/android/forum/threads/bananoconnect-bananosql-sqlite-mysql-mssql-library.117956/)  
  
[Download](https://github.com/Mashiane/BANanoVueMaterial)  
  
You can get [Part 1](https://www.b4x.com/android/forum/threads/bananovuematerial-creating-expenses-show-a-crud-expense-tracker-with-mysql-backend-part-1.114028) here.  
  
In Part 1 of this tutorial we looked at how we could create, read, update and delete MySQL table records for our expenses, expense categories and expense types.  
  
Part 2 will look at the first part of reporting: **The Dashboad.  
  
![](https://www.b4x.com/android/forum/attachments/88808)**  
  
The Dashboard here provides one with a quick outline to see your expenditure performance and also functionality to add an expense.  
  
  
  
We have the following chart information:  

1. Budget (current month) - the total budget per category & expenses per category for the current month. This uses the current computer date to get the current year and current month.
2. Budget by Categories (Current Month) - this is an explosion of budget chart however now looking at each category differently.
3. Expenditure by Month (Current Year) - this is a sum of expenditure per month for the current year.
4. Expenditure by Categories (Current Year) - this explodes the expenditure for the year per category.

NB: As soon as you add a new expense in this screen, the charts are automatically updated using a v-model approach of the KickChart control.