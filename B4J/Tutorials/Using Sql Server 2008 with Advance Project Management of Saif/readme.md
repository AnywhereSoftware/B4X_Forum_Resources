### Using Sql Server 2008 with Advance Project Management of Saif by AnandGupta
### 05/24/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/131026/)

Hi Members.  
  
This is continuation of below post  
<https://www.b4x.com/android/forum/threads/my-struggle-and-win-with-advance-project-management-of-saif.131025/>  
  
Trying to restore the given .bak file of below project, in my Sql Server 2008  
<https://www.b4x.com/android/forum/threads/advance-project-management-jira-alternative-source-code.130674/>  
  
I faced error as below and explanation I found,  
  

```B4X
prob: Specified cast is not valid. (SqlManagerUI)  
  
    solu: The Windows server version is irrelevant.  Your post sounded like you  
    were trying to restore a SQL Server 2012 backup to SQL Server 2008, which  
    won't work. IF you are trying to restore a native SQL Server 2008 backup, it  
    should be okay.
```

  
  
Now without the tables the login screen will not proceed.  
  
Never learnt to stop, I opened the mysql script given and pasted the create table sql in Query of Sql Server 2008. It gave error and I changed the sql till it created the table.  
One by one I copied and pasted each table sql and made changes and created the tables. I have attached the changed sql file here, hoping it may benefit members who have lower version of Sql Server.  
  
All tables are ready but login page does not proceed as the '[email]admin@admin.com[/email]' data is not there.  
  
I searched in .bas files and found the table and minimum columns required and inserted the data as below,  

```B4X
insert into EmployeeInformation (EmpID, EmailAdd, EmpPassword, EmployeeName, EmployeeSalary, IsMale, EmpDeptID, IsAdmin) values (1, 'admin@admin.com', 'admin', 'Admin', 1, 1, 1, 1)
```

  
  
Lo and Behold ! Advance Project Management is up and running like a smooth cake on my database.  
Am I happy ? Oh come on ! My name is Anand which means 'Happy'.  
And I am now confident with Sql Server setting too :D  
  
I like to thanks Erel too here as this gave me chance to learn and use B4J and its database features.  
  
![](https://www.b4x.com/android/forum/attachments/113915) ![](https://www.b4x.com/android/forum/attachments/113916) ![](https://www.b4x.com/android/forum/attachments/113917) ![](https://www.b4x.com/android/forum/attachments/113918) ![](https://www.b4x.com/android/forum/attachments/113919)  
  
Regards,  
  
Anand