jRDC2ASService-Create.bat and jRDC2ASService-Remove.bat
These files use nssm.exe (everything you need to know is found here: https://nssm.cc/) to create a windows service.
This will start with windows, not requiring any log in.

Things you need to know:
GET THE SERVER WORKING FIRST USING StartServer-Debug.bat

jRDC2ASService-Create.bat RIGHT-CLICK RUN THIS AS ADMINISTRATOR OR IT WILL FAIL.
GET and learn about nssm.exe - https://nssm.cc/

jRDC2ASService-Remove.bat DO NOT Right-Click run as administrator OR IT WILL FAIL. When prompted to run nssm.exe as administrator just say yes.

HOW TO EDIT jRDC2ASService-Create.bat 

You need to EDIT jRDC2ASService-Create.bat file to make all paths match as shown below, and set your SQL DEPENDENCY.
This means edit the following lines:

CD C:\ProgramData\jRDC2\jRDC2
nssm install jRDC2  C:\ProgramData\jRDC2\jRDC2\bin\javaw.exe
nssm set jRDC2 Application C:\ProgramData\jRDC2\jRDC2\bin\javaw.exe
nssm set jRDC2 AppDirectory C:\ProgramData\jRDC2\jRDC2
nssm set jRDC2 AppParameters -jar jRDC2.jar
nssm set jRDC2 DisplayName jRDC2
nssm set jRDC2 <Your description Here>
nssm set jRDC2 DependOnService <Your SQL Instance Here>

To EDIT DependOnService:
OPEN Services (Windows Key - Type "Services")
Find your SQL Instance
Right Click - Properies
COPY The text under "Service Name" and replace <Your SQL Instance Here> with this

Your service will show up under services with the name in nssm set jRDC2 DisplayName.

nssm.exe is actually managing the service. THIS MEANS THAT IN THE WINDOWS EVENT VIEWER LOGS our service WILL ACTUALLY SHOW UP AS nssm
Changing the name of nssm.exe will work but will not change the name in the event logs.

