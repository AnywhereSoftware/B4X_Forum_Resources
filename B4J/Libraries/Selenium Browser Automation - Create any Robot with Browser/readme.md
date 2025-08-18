### Selenium Browser Automation - Create any Robot with Browser by Alberto Iglesias
### 06/12/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/104344/)

![](https://2.bp.blogspot.com/-idwhrEvGRcM/WAhO0w9TwnI/AAAAAAAAAGU/xThZWzPBrfIiz_RbcIk4CTwrpZiVJayFgCLcB/s1600/Selenium.jpg)  
  
[SIZE=4]**[Selenium WebDriver](https://selenium-vinod.blogspot.com/2016/04/selenium-webdriver.html) - [Mastering Test Automation](https://selenium-vinod.blogspot.com/) with Selenium**[/SIZE]  
  
**What is Selenium?**  
Selenium is an open source automated testing suite for web applications across different browsers and platforms. It is quite similar to HP Quick Test Professional (QTP) only that Selenium focuses on automating web-based applications.  
  
Selenium is not just a single tool but a suite of software's, each catering to different testing needs of an organization.  
  
Based on Selenium WebDrivers, this new Library for B4J can automate browsers and create any robot and get any information from websites.  
  
And you can use with or Without UI  
  
  
  
**[SIZE=5]Step 1:[/SIZE]**  
Download the library and dependencies and put in your B4J Library Folder  
  
<https://visualnet.ddns.me/vncorp/store>  
  
  
  
  
**[SIZE=5]Step 2:[/SIZE]**  
Download the ChromeDriver for your platform.  
Can be used on Windows/Linux/MacOSX, just download correct driver for your platform on:  
  
<http://chromedriver.chromium.org/downloads>  
  
TIP: Inside the samples you already have ChromeDriver.exe for windows  
  
  
**[SIZE=5]Step 3:[/SIZE]**  
Try the samples  
  
  
Sample 1: ([SampleNasdaq.zip](http://visualnet.ddns.me/visualnet/downloads/selenium/SampleNasdaq.zip)) Open Nasdaq.com website and get the top stocks on market  
  
Sample 2: ([SampleOyster.zip](http://visualnet.ddns.me/visualnet/downloads/selenium/SampleOyster.zip)) Open UK TLF website for retrieve Oysters card and balance from each one  
  
Check with a few lines of code you can retrieve a table from nasdaq website  

```B4X
Dim objSelenium As Selenium  
objSelenium.DebugMode = True  
objSelenium.Initialize("chromedriver.exe","objSelenium")  
objSelenium.Navigate("https://www.nasdaq.com/")  
Dim lstElements As List = objSelenium.findElementList("indexTable")  
For Each k As String In lstElements  
      Log(k)  
Next
```

  
  
[MEDIA=youtube]G0SIoTDpSVs[/MEDIA]  
  
Check others libraries on:  
  
<https://visualnet.ddns.me/vncorp/store>