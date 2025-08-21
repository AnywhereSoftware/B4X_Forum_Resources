### ✅ JDBCSQL Connector/J - Connect directly to MySQL, MSSQL, PostgreSQL, MariaDB and Oracle databases by Peter Simpson
### 03/13/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/107545/)

Hello fellow B4X'ers,  
Here is some example code for connecting your B4J projects to 5 different types of database engines, this tutorial is for learning purposes only and nothing else.  
  
**Disclaimer:**  
This code with some minor changes may also work in B4A. MySQL and MSSQL connectors definitely do work in B4A but I'm not sure about the PostgreSQL, MariaDB and Oracle connectors. Please check on the corresponding connector/J developers website for more information about using and distributing their connector/J drivers.  
  
**Directions:**  
First download and copy the 5 JDBC Cconnector/J files into your additional libraries folder, then open the attached B4J project and set the DBLocation, DBUsername and DBPassword for your particular databases, that's all you have to do.  
  
**Download link for all 5 JDBC Connector/J drivers:**  
<https://www.dropbox.com/sh/q2h7qmiwrparzru/AACmjXllUKcYF1XhNOrYkGh3a?dl=0>  
  
In my attached example the MariaDB Connector/J is deliberately connecting to a MySQL database, this is because the MariaDB Connector/J can connect to both MySQL and MariaDB database engines with ease. Both database formats were founded by Michael Widenius.  
  
**Update file:** **I've added Oracle Connector/J**  
I decided to add Oracle Connector/J to the attached file named [Database**5**ConnectionTypes.zip](https://www.b4x.com/android/forum/attachments/database4connectiontypes-zip.82050/), so download that file instead.  
  
[SPOILER="Logs showing all 5 JDBC connectors retrieving data from my test databases"]  
Picked up \_JAVA\_OPTIONS: -Xmx1024m -Xms1024m -XX:-UseGCOverheadLimit  
Waiting for debugger to connect…  
Program started.  
———- Northwind Database (MySQL) ———-  
categories  
customercustomerdemo  
customerdemographics  
customers  
employees  
employeeterritories  
order details  
orders  
products  
region  
shippers  
suppliers  
territories  
———- Northwind Database (MSSQL) ———-  
CustomerDemographics  
Region  
Employees  
Categories  
Customers  
Shippers  
Suppliers  
Orders  
Products  
Order Details  
CustomerCustomerDemo  
Territories  
EmployeeTerritories  
———- Northwind Database (PostgreSQL) ———-  
us\_states  
customers  
orders  
employees  
shippers  
products  
order\_details  
categories  
suppliers  
region  
territories  
employee\_territories  
customer\_demographics  
customer\_customer\_demo  
———- Northwind Database (MariaDB) ———-  
categories  
customercustomerdemo  
customerdemographics  
customers  
employees  
employeeterritories  
order details  
orders  
products  
region  
shippers  
suppliers  
territories  
———- XE Database (Oracle) ———-  
LOGMNRGGC\_GTLO  
LOGMNRGGC\_GTCS  
LOGMNR\_PARAMETER$  
LOGMNR\_SESSION$  
ROLLING$CONNECTIONS  
ROLLING$DATABASES  
ROLLING$DIRECTIVES  
ROLLING$EVENTS  
ROLLING$PARAMETERS  
ROLLING$PLAN  
ROLLING$STATISTICS  
ROLLING$STATUS  
MVIEW$\_ADV\_WORKLOAD  
MVIEW$\_ADV\_BASETABLE  
MVIEW$\_ADV\_SQLDEPEND  
MVIEW$\_ADV\_PRETTY  
MVIEW$\_ADV\_TEMP  
MVIEW$\_ADV\_FILTER  
MVIEW$\_ADV\_LOG  
MVIEW$\_ADV\_FILTERINSTANCE  
MVIEW$\_ADV\_LEVEL  
MVIEW$\_ADV\_ROLLUP  
MVIEW$\_ADV\_AJG  
MVIEW$\_ADV\_FJG  
MVIEW$\_ADV\_GC  
MVIEW$\_ADV\_CLIQUE  
MVIEW$\_ADV\_ELIGIBLE  
MVIEW$\_ADV\_OUTPUT  
MVIEW$\_ADV\_EXCEPTIONS  
MVIEW$\_ADV\_PARAMETERS  
MVIEW$\_ADV\_INFO  
MVIEW$\_ADV\_JOURNAL  
MVIEW$\_ADV\_PLAN  
AQ$\_QUEUE\_TABLES  
AQ$\_QUEUES  
AQ$\_SCHEDULES  
AQ$\_INTERNET\_AGENTS  
AQ$\_INTERNET\_AGENT\_PRIVS  
SCHEDULER\_PROGRAM\_ARGS\_TBL  
SCHEDULER\_JOB\_ARGS\_TBL  
LOGSTDBY$PARAMETERS  
HELP  
SQLPLUS\_PRODUCT\_PROFILE  
LOGMNR\_GT\_TAB\_INCLUDE$  
LOGMNR\_GT\_USER\_INCLUDE$  
LOGMNR\_GT\_XID\_INCLUDE$  
LOGMNRT\_MDDL$  
OL$  
OL$HINTS  
OL$NODES  
LOGMNR\_DICTSTATE$  
LOGMNRC\_GTLO  
LOGMNRC\_GTCS  
LOGMNRC\_SEQ\_GG  
LOGMNRC\_CON\_GG  
LOGMNRC\_CONCOL\_GG  
LOGMNRC\_IND\_GG  
LOGMNRC\_INDCOL\_GG  
LOGMNRC\_SHARD\_TS  
LOGMNRC\_TSPART  
LOGMNRC\_TS  
LOGMNRC\_GSII  
LOGMNRC\_GSBA  
LOGMNR\_SEED$  
LOGMNR\_DICTIONARY$  
LOGMNR\_OBJ$  
LOGMNR\_TAB$  
LOGMNR\_COL$  
LOGMNR\_ATTRCOL$  
LOGMNR\_TS$  
LOGMNR\_IND$  
LOGMNR\_USER$  
LOGMNR\_TABPART$  
LOGMNR\_TABSUBPART$  
LOGMNR\_TABCOMPART$  
LOGMNR\_TYPE$  
LOGMNR\_COLTYPE$  
LOGMNR\_ATTRIBUTE$  
LOGMNR\_LOB$  
LOGMNR\_CON$  
LOGMNR\_CONTAINER$  
LOGMNR\_CDEF$  
LOGMNR\_CCOL$  
LOGMNR\_ICOL$  
LOGMNR\_LOBFRAG$  
LOGMNR\_INDPART$  
LOGMNR\_INDSUBPART$  
LOGMNR\_INDCOMPART$  
LOGMNR\_LOGMNR\_BUILDLOG  
LOGMNR\_NTAB$  
LOGMNR\_OPQTYPE$  
LOGMNR\_SUBCOLTYPE$  
LOGMNR\_KOPM$  
LOGMNR\_PROPS$  
LOGMNR\_ENC$  
LOGMNR\_REFCON$  
LOGMNR\_IDNSEQ$  
LOGMNR\_PARTOBJ$  
LOGMNRP\_CTAS\_PART\_MAP  
LOGMNR\_SHARD\_TS  
LOGSTDBY$APPLY\_PROGRESS  
LOGMNR\_SESSION\_EVOLVE$  
LOGMNR\_GLOBAL$  
LOGMNR\_PDB\_INFO$  
LOGMNR\_DID$  
LOGMNR\_UID$  
LOGMNRC\_DBNAME\_UID\_MAP  
LOGMNR\_LOG$  
LOGMNR\_PROCESSED\_LOG$  
LOGMNR\_SPILL$  
LOGMNR\_AGE\_SPILL$  
LOGMNR\_RESTART\_CKPT\_TXINFO$  
LOGMNR\_ERROR$  
LOGMNR\_RESTART\_CKPT$  
LOGMNR\_FILTER$  
LOGMNR\_SESSION\_ACTIONS$  
REDO\_DB  
REDO\_LOG  
LOGSTDBY$EVENTS  
LOGSTDBY$APPLY\_MILESTONE  
LOGSTDBY$SCN  
LOGSTDBY$FLASHBACK\_SCN  
LOGSTDBY$PLSQL  
LOGSTDBY$SKIP\_TRANSACTION  
LOGSTDBY$SKIP  
LOGSTDBY$SKIP\_SUPPORT  
LOGSTDBY$HISTORY  
LOGSTDBY$EDS\_TABLES  
[/SPOILER]  
  
**Enjoy…**