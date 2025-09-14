###  BalConverter - Convert the layouts files to JSON (and vice versa) by Erel
### 09/11/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/41623/)

Automation tool: <https://www.b4x.com/android/forum/threads/b4x-jsonlayouts-synchronize-json-and-binary-layouts.167398/#content>  
  
BalConverter is a B4J app (desktop app) that converts between the designer layout files and JSON format.  
  
This allows you to edit the layout with a text editor. Note that the format is not so simple as the layout files were not designed to be edited this way.  
  
The converter app is simple. You choose a folder and it will convert all layout files from one format to another. **The original files are not deleted.**  
It filters the files based on the extension (bal or bal.json).  
  
![](http://www.b4x.com/basic4android/images/SS-2014-06-01_17.03.59.png)  
  
The JSON format is made of three main elements:  
  
![](http://www.b4x.com/basic4android/images/SS-2014-06-01_17.08.40.png)  
  
The **Data** element is a tree of views. All the views properties are stored here.  
  
The first view is the Activity view. The other views are stored under the :kids node (recursively). Note that the fields order is not important and is not consistent.  
  
![](http://www.b4x.com/basic4android/images/SS-2014-06-01_17.11.10.png)  
  
The **Variants** element is a list of the variants. You will probably won't need to edit this section.  
  
The **LayoutHeader** element holds other information about the layout file. Note that all the views names are stored in this section under ControlsHeaders. This means that if you change the name of a view then you need to change it here and in the Data element.  
  
The b4j project is attached.  
  
It is recommended to backup your layout files before working with this tool.  
  
**Updates**  
  
v2.30 - Designer script is now decoded and encoded. This means that it can be modified in the json file.  
- Layout recreated with the internal designer.  
- FontAwesome / Material Icons usage is preserved.