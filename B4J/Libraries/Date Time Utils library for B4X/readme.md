### Date Time Utils library for B4X by tummosoft
### 03/22/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/158753/)

There are two untils class on this library:  
- jtime4x: The class method which Until has alot date time functions.  
- jDate (): The class has obligations to convert date time types to string, long,…  
  
getCurrentLocalDateTime(ZoneID as String) as LocalDateTime  
getCurrentLocalTime(ZoneID as String) as LocalTime  
getCurrentLocalDate(ZoneID as String) as LocalDate  
getNDaysAgo(value as int, outputFormat as String) as Date  
getNDaysAgo2(datev as jDate, value as int, outputFormat as String) as Date  
CompareDate1toDate2(day1 as jDate, day2 as jDate) as int  
getTimeZone(localtion as String) as TimeZone  
RandomTime(nums as int) as Date  
StringToInstant(value as String) as Instant  
ConvertFullTimeZone(format as String, date as jDate, zone as String) as String  
ConvertDate(year as int, month as int, day as int ) as jDate  
isValidDateTime(value as String) as boolean  
isValidDate(value as String) as boolean  
NowUTC() as jDate  
NowUTC2(format as String) as String  
StringToLocal(date as String) as LocalDateTime  
ParseIsoToLocal(date as String) as LocalDateTime  
ParseEpochMilliToLocal(date as String) as LocalDateTime  
getAge(birthDay as jDate) as int  
getQuarterOfYear(localDateTime as LocalDateTime) as int  
PlusYears(date as Date, amountToAdd as long) as Date  
plusMonths(Date date, amountToAdd as long) as Date  
timestamp2Date(timestamp as String, newFormat as String) as String  
getCountdownWithDay(start as Date, end as Date, unitNames as String) as String  
getOverlapTime(Date startDate1, Date endDate1, Date startDate2, Date endDate2) as long  
isOverlap(startDate1 as Date, endDate1 as Date, startDate2 as Date, endDate2 as Date) as boolean  
getLastYear(value as Date) as Date  
getLastMonth(value as Date) as Date  
getLastWeek(value as Date) as Date  
getYesterday(value as Date) as Date  
getNextYear(value as Date) as Date  
getNextMonth(value as Date) as Date  
startTimeOfDate(int year, int month, int dayOfMonth) as Date  
compare(date1 as Date, date2 as Date) as int  
isBirthDay(birthDay as Date) as boolean  
nextWeek(value as Date) as Date  
getAverageTime(datelist as List) as LocalTime  
getCountdown(millis as long) as String  
periodBetween(startDateInclusive as LocalDate, endDateExclusive as LocalDate) as int  
lengthOfYear(date as Date) as int  
lengthOfMonth(date as Date) as int  
isWorkDay(date as Date) as boolean  
isLeapYear(year as int) as boolean  
getCountdown(millis as long, unitNames as String) as String  
  
Source code: <https://github.com/tummosoft/jtime4x>  
  
Examples  

```B4X
Dim jtime4x As jtime4x  
    
    Dim jdtt As jDate  
    jdtt.Initialize   
    jdtt.LocalDateTime = jtime4x.getCurrentLocalDateTime("Africa/Accra")   
    Log("getCurrentLocalDateTime: " & jdtt.toString)  
    
    jdtt.LocalDate = jtime4x.getCurrentLocalDate("Asia/Kuala_Lumpur")  
    Log("getCurrentLocalDate: " & jdtt.toString)  
    
    jdtt.LocalTime = jtime4x.getCurrentLocalTime("Asia/Kuala_Lumpur")  
    Log("getCurrentLocalTime: " & jdtt.toString)  
            
    jdtt.JavaDate  = jtime4x.getNDaysAgo(-21, "dd/MM/yyyy")  
    Log("Last 24 day ago: " & jdtt.toString)  
        
    jdtt.JavaDate  = jtime4x.getNDaysAgo(10, "dd/MM/yyyy")  
    Log("Next 10 day: " & jdtt.toString)  
    
    Dim jnow As jtime4x  
    
    jdtt.JavaDate  = jtime4x.plusMonths(jnow.ConvertDate(2023,5,15), 2)  
    Log("Plus 2 month: " & jdtt.toString)  
        ''  
    ' SringToDate auto support many date string type:  
    ' <pre>  
    ' =====================yyyy-MM-dd ====================  
    ' yyyy-MM-dd    2020-05-23 or 2020-5-23  
    ' yyyyMMdd        20200523  
    ' yyyy/MM/dd    2020/05/23 or 2020/5/23  
    ' yyyy.MM.dd    2020.05.23 or 2020.5.23  
    
    
    '  
    '  
    ' =====================yyyy-MM-dd HH:mm:ss =====================  
    ' yyyy-MM-dd HH:mm:ss        2020-05-23 17:06:30  
    ' yyyyMMddHHmmss            20200523170630  
    ' yyyy-MM-dd HH:mm        2020-05-23 17:06  
    ' yyyy/MM/dd HH:mm        2020/05/23 17:06  
    '  
    '  
    ' =====================yyyy-MM-dd HH:mm:ss.SSS =====================  
    ' yyyy-MM-dd HH:mm:ss.SSS        2020-05-23 17:06:30.272  
    ' yyyy-MM-dd HH:mm:ss,SSS        2020-05-23 17:06:30,272  
    ' yyyyMMddHHmmssSSS            20200523170630272  
    '  
    ' =====================Iso=====================  
    ' yyyy-MM-dd'T'HH:mm:ssZ            2020-05-23T17:06:30+0800  
    ' yyyy-MM-dd'T'HH:mm:ss'Z'        2020-05-23T17:06:30Z  
    ' yyyy-MM-dd'T'HH:mm:ssxxx        2020-05-23T17:06:30+08:00  
    ' yyyy-MM-dd'T'HH:mm:ss.SSSZ        2020-05-23T17:06:30.272+0800  
    ' yyyy-MM-dd'T'HH:mm:ss.SSSxxx        2020-05-23T17:06:30.272+08:00  
    ' yyyy-MM-dd'T'HH:mm:ss.SSSXXX        2020-05-23T09:06:30.272Z  
    '  
    ' =====================other=====================  
    '  EEE MMM dd HH:mm:ss zzz yyyy         Sat May 23 17:06:30 CST 2020  
    
    Dim stringDate As String  = "2024-01-20T14:22:22Z"  
    
    jdtt.InstantTime = jtime4x.StringToInstant(stringDate)  
    Log("StringToInstant: " & jdtt.toString)  
    
    
    jdtt.LocalDateTime = jtime4x.getCurrentLocalDateTime("Asia/Kuala_Lumpur")  
    Log("LocalDateTime: " & jdtt.toString)  
    
    jdtt.JavaDate = jtime4x.getNDaysAgo2(jtime4x.NowUTC, 10, "dd/MM/yyyy")  
    Log("LocalDateTime: " & jdtt.toString)  
    
    Dim jdate2 As jDate  
    jdate2.Initialize2("2023/12/02")  
    
    Dim compare As Int = jtime4x.CompareDate1toDate2(jtime4x.NowUTC,jdate2)  
    Log(compare)  
        
    jdtt.JavaDate = jtime4x.NowUTC  
    Log("Date to long: " & jdtt.Time)  
    jdtt.LongTime = jdtt.Time  
    Log("long to Date: " & jdtt.toString)  
    
    Dim jdate1 As jDate  
    jdate1.Initialize2("2023/12/02")  
  
    Dim isTime As Boolean = jtime4x.isValidDate("12/01")  
    Log("12/01 is Time: " & isTime)  
        
    For i=0 To 10  
        Dim jdate2 As jDate  
        jdate2.Initialize3(jtime4x.RandomTime(i + 3))  
        
        Log("RANDOM: " & jdate2.toString & "\n")  
    Next           
          
    Dim jdate2 As jDate  
    jdate2.Initialize2("2000/12/02")  
    
    Dim tzz = jtime4x.getAge(jdate2)  
    Log("Your age is: " & tzz)
```