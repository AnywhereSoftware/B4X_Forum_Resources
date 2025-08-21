### How to connect to SQL Server using jtds-1.3.1.jar by MrKim
### 11/17/2019
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/111446/)

This subject keeps coming up so I thought I would do a tutorial and sample programs. One is B4A, the other is B4J. If you want code examples download the programs.  
  
The B4J I created for testing as it should have fewer problems connection to an SQL DB from a Windows machine connected with a wire than a wireless tablet trying to connect. Or, if possible, run the Java program on the computer containing the instance of SQL. For example on my laptop I am able to connect without a problem using the Java program to connect to an SQL database on my laptop. The B4A REQUIRES an INBOUND RULE allowing the PORT I am using through the firewall.  
  
I AM ABLE TO SUCCESSFULLY CONNECT TO AN SQL SERVER DATABASE USING THESE PROGRAMS FROM BOTH WINDOWS (B4J) AND ANDROID (B4A). **THIS IS ALL I KNOW ON THE SUBJECT.** IF YOU CANNOT GET IT TO WORK THEN MORE THAN LIKELY YOUR ISSUE IS FIREWALL/DOMAIN/SQL SERVER CONFIGURATION/SECURITY. I AM **NOT** AN EXPERT IN THESE AREAS. We have a number of customers using our program using this type of connection wirelessly on Android tablets. WHEN IT DOESN'T WORK I TELL OUR CUSTOMERS "CALL YOUR MIS/NETWORKING PEOPLE." They do and THEY have always fixed the problem. I have connected to SQL server versions 2008 - 2014 successfully. IF you want to connect to any other DB other than MS SQL Server then I cannot help you. If your SQL Server is on anything other than a Standard Windows/Windows server I cannot help you.  
  
Things to know:  
Android 7 and above required. 6 fails. I don't know why.  
I have had this working on multiple tablets AND phones. Cheap ones and good ones.  
  
You can download the driver file by Searching the net for jtds-1.3.1.jar or I found it  
[HERE](https://sourceforge.net/projects/jtds/files/jtds/1.3.1/).  
Put the file in: C:\Program Files (x86)\Anywhere Software\Basic4android\Libraries  
or wherever your libs are if it is different. I was warned NEVER put it here but it is working.  
  
You MUST SELECT 'SQL Server and Windows Authentication Mode'. I HAVE NEVER TRIED WINDOWS AUTHENTICATION! You must have SQL Server Authentication. If anyone ever gets it to work with Windows Authentication please let me know.  
Open SSMS  
Right-Click the Server  
Select Properties  
Select security page.  
SELECT 'SQL Server and Windows Authentication Mode'  
![](https://www.b4x.com/android/forum/attachments/85600)  
  
What you need:  
The IP Address of the computer containing the instance of SQL Server.  
The PORT address that SQL Server is listening on.  
The NAME of a database on that SQL Server.  
A VALID USER NAME/PASSWORD to connect to the DATABASE you have chosen.  
  
IP Address:  
Open the Windows menu ON THE SQL SERVER COMPUTER and type 'COMMAND' and hit enter.  
This will open a command prompt.  
Type 'ipconfig' this will get you a screen similar to this:  
![](https://www.b4x.com/android/forum/attachments/85584)  
  
The IPV4 Address is what you are after. My laptop is currently wireless so that is what I have. More than likely your connection will be an Ethernet Adapter. IF YOU HAVE MORE THAN ONE CONNECTION I CAN'T HELP YOU. Try them all?  
  
  
PORT Address:  
Open SQL Server Management Studio.  
Under Object Explorer Open 'Management'.  
Expand 'SQL Server Logs'  
Open 'Current'  
Search for 'Any'  
![](https://www.b4x.com/android/forum/attachments/85593)  
  
You are looking for the following line:  
![](https://www.b4x.com/android/forum/attachments/85587)  
in this case the PORT we are after is **65218**  
  
**IF YOU DO NOT FIND THIS ENTRY:**  
YOU MUST SET IT UP! THIS IS THE ONLY WAY I HAVE EVER GOTTEN THIS TO WORK!  
DON'T FORGET YOU MUST RESTART THE SQL SERVER AFTER MAKING THESE CHANGES!  
  
Open SQL Server Configuration Manager (or Computer Management and select Server Configuration Manager) .  
Make sure TCP/IP is enabled FOR YOUR INSTANCE OF SQL. There may be more than on instance.  
  
![](https://www.b4x.com/android/forum/attachments/85591)  
After enabling double click to open properties, select the IP Addresses Tab, and scroll down to IPAll (This is the LAST Entry)  
and enter the PORT Number for TCP Dynamic Ports.  
  
![](https://www.b4x.com/android/forum/attachments/85589)  
  
Normally this is 1433. I have more than one instance of SQL server so in this case I have a different Port.  
RESTART THE SQL SERVER INSTANCE AFTER MAKING THESE CHANGES!  
  
Once all of this is done the attached programs should work. If they do not then, as mentioned above it is more than likely some sort of network/security issue.  
  
Tip:  
Open the SQL server error log and look at what is failing. If you do not see a failed login then you aren't even getting to the server.  
  
Hope this helps someone.  
  
Kim