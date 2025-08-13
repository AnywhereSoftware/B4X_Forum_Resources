### solar calendar by gohargazi
### 08/03/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/162384/)

Project Description  
  
This project is designed to convert dates into the Persian calendar. The operation of the project is as follows:  
  
1. Overall Functionality:  
 - The project starts from a reference date (11th of Dey, 1348 in the Persian calendar) and calculates the Persian date by considering the sequence of 31-day and 30-day months and leap year rules.  
 - Due to starting from this reference date, the calculations may consume more resources.   
  
2. Resource Optimization:  
 - To reduce resource consumption, you can adjust the reference date in the code to a closer or more suitable date range for your specific needs. This will limit the calculation range and optimize resource usage.  
  
3. Leap Year Calculation Validity:  
 - The leap year calculation method used in this project is valid up to the year 1472. For years beyond this, it may be necessary to review and update the calculation algorithms.  
  
4. Output:  
 - The project returns the date as a string, which includes the calculated Persian date.  
  
Using this project, you will be able to convert dates into the Persian calendar and use them in your applications. If needed, you can make adjustments to the reference date and modify the calculation algorithms to suit your specific requirements.