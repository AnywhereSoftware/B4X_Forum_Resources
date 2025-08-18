### MySQL Negative Dates - Long DateTime (such as Birthdays) problem by Harris
### 01/22/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/137826/)

There's one big problem with MySQL: MySQL cannot convert negative epoch timestamps (long values) (dates before 1-1-1970).  
This creates problems with for example **birthdates**. But there are workarounds.  
  
This is my workaround - and it shows the proper birthdate when that date is less than 1970…  

```B4X
"    date_format((DATE_ADD(FROM_UNIXTIME(0), interval club_member.dob / 1000 second)),'%Y-%m-%d') as BIRTHDAY    "
```

  
  
<https://www.epochconverter.com/programming/mysql#negavtiveEpoch>  
  
" **club\_member.dob** " is my table field with the datetime long value…  
  
Above link attempts to explain the issue…  
I don't really understand it, but it works.  
  
I hope some **smart SQL expert** will break down the statement - and define what each section is doing to create the correct result…  
  
Thanks