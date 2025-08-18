### jJasperReports Library by Juan Marrero
### 07/09/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/97475/)

Hi. I want to share this jJasperReports library with the community.  
It needs several libraries to work. I provided a link: download  
—More libraries needed (missing from the first link): download  
You also need to download databases jdbc drivers: sql jdts, mysql and oracle  
New Link (All jar files are included in this link): [Download](https://www.dropbox.com/s/e7u0grn8u62y7nw/jr_additional_libs.zip?dl=0)  
All jars need to be placed in Additional Libraries folder.  
In the B4J project you need to add a jar file: #AdditionalJar: itext-2.1.7.js1  
Library files and a small example is provided.  
Please feel free to test the library.  
Note: for some reason when using SubReports, the compiled (.jasper) files need to be in the same level as the app jar file. XML Reports (.jrxml) can be in any other folder different from the app jar file. (e.g. if report.jrxml is in File.DirApp & "/reports" then all compiled (.jasper) subreports need to be in File.DirApp. In the example provided .jrxml and .jasper are in the same level as jaspertest.jar.  
  
v1.00 - Release  
v1.10 - SQLite support added. MySQL useSSL variable added.  
v1.12 - Changed the way the JasperViewer works. Now you can set the form to full screen, use the default size and location or set a specific size and location.  
v1.13 - Added method PrintDirectlyToPrinter.  
v1.20 - Access support added via uCanAccess jdbc driver. Note: When creating reports in Jaspersoft Studio you need to add all jar files that ucanaccess needs. The metadata won't work but you can create a query and it will work.  
v1.22 - Added functions to export report to XLS and XLSX. Note: need 2 more jar files: [download.](https://drive.google.com/file/d/1QJgSi_CzytLcYNXf7s2Hoy3q_7G8_xEn/view?usp=sharing) Copy them into Additional Libraries folder.  
v1.24 - Added function Print3 to be able to show reports without a Data Source.  
  
——————————————  
  
**[SIZE=5]NEW VERSION 2.00[/SIZE]**  
Special thanks to Num3 for testing this library and helping me getting it done.  
  
Instructions:  
1. Libraries needed: [Donwload](https://www.dropbox.com/s/e7u0grn8u62y7nw/jr_additional_libs.zip?dl=0)  
2. Place all jars in Additional Libraries folder  
3. Specify in B4J project with #AdditionalJar: the database that is going to be used. (e.g. #AdditionalJar: mysql-connector-java-5.1.49-bin)  
 a. If using ucanaccess-5.1.0 database please add these in addition to #AdditionalJar: ucanaccess-5.0.1:  
 - #AdditionalJar: commons-lang3-3.8.1  
 - #AdditionalJar: commons-logging-1.2  
 - #AdditionalJar: hsqldb-2.5.0  
 - #AdditionalJar: jackcess-3.0.1  
  
v2.00 - Same functionality as v1.24 but based on jasperreports-6.17.0. Previous v1.24 was based on jasperreports-6.7.1.