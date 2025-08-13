### Introducing liteCsvParse: A Lightweight Library for Efficient CSV Processing by carlos7000
### 07/22/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/161707/)

Hello everyone,  
  
I’d like to share with you a tool I’ve developed called **liteCsvParse**. It’s a lightweight library I created to make working with CSV files easier, especially on older devices or those with limited resources.  
  
The library consists of two main functions:  
  

- **CsvToList**: This function takes a CSV file and converts it into a list of arrays, allowing for easy manipulation of the contained data.
- **ListToCsv**: Conversely, this function takes an array of arrays and exports it to a CSV file.

I was motivated to develop this library because when processing large CSV files on devices with low memory, existing tools like CvsParser couldn’t complete the task. Even on more modern devices, if the files are very large, similar issues arise.  
  
![](https://www.b4x.com/android/forum/attachments/154724)  
  
To my surprise, **liteCsvParse** worked much better than expected. Not only does it handle files efficiently on devices with limited resources, but it’s also remarkably fast. In my tests, I found that the processing time is comparable to LoadCsv and up to ten times faster than csvParser.  
  
![](https://www.b4x.com/android/forum/attachments/154725)  
  
While it doesn’t have all the advanced features of Csvparser, **liteCsvParse** requires significantly less memory and offers greater speed. So far, I’ve tested it with dozens of files and files up to 1 million rows with satisfactory results.  
  
Additionally, I am attaching the project files with which I conducted the tests of CsvParser vs LoadCsv vs liteCsvParse, as well as the library itself. This is so you can conduct your own tests if you wish and also see how the library is used.  
  
I hope this library will be as useful to you as it has been for me.  
  
Notes: The library version is 1.07, a couple of bugs were fixed  
  
If you liked the library and wish to support my work, you can do so through my PayPal account: [paypal.me/Carlos7000](https://www.paypal.me/Carlos7000)