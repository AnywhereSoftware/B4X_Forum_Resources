### SD: BindingNavigator (Sqlite GUI Navigator) by Star-Dust
### 03/02/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/91041/)

This is a first version of the BindingNavigator Library, which wants to somehow reproduce the corresponding BindingNavigator of VB.NET  
  
What is needed? I want to get something similar to the tools available on VB.NET to link the views to the DB. As in the pictures.  
I am now working on a B4J App that creates a Layout (.bal and baj) from a database that can be loaded into your B4X project, based on [Erel's bal converter](https://www.b4x.com/android/forum/threads/b4x-balconverter-convert-the-layouts-files-to-json-and-vice-versa.41623/#content). (hoping to succeed)  
  
![](https://www.b4x.com/android/forum/attachments/65886)![](https://www.b4x.com/android/forum/attachments/65887)  
  
A **DataSet** Class is available that allows to associate some views (EditText, Label, ImageView, ToggleButton, CheckBox) with specific fields of a Sqlite DataBase.  
  
By scrolling the position of the DataSet the fields will be updated and if the fields in some way undergo a variation by the user, raising the UpdateChange event will in turn be modified in the DataBase.  
This very Agevolent construction of GUI related to the DB.  
  
In addition you have a Second ViewCalss **NavigatorBar** that adds a new Seek view to the design that is linked to the DataSet. Scrolling through the Seek will change all the views linked to the DataSet. And if the UpdateChange eventio is updated, the DB will be updated based on changes in the views linked to the fields.  
  
**VERY IMPORTANT:**   

1. The sql database must always have a **Primarykey** field, of type int with auto-increment, in the example i call it ID, but it could be called as you want.
The name of the field that will be the **Primarykey** must be communicated to the DataSet when call query method.2. It is always necessary to add in the code - #**AdditionalJar**: sqlite-jdbc-3.7.2

  
**jSD\_BindingNavigator  
  
Author:** Star-Dust  
**Version:** 0.11  

- **ControlView**

- **Fields:**

- **Field** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **V** As Object

- **Functions:**

- **Initialize**
*Inizializza i campi al loro valore predefinito.*
- **DataSet**

- **Functions:**

- **AddLinkView** (View As Object, Field As String) As String
*View Label, TextField, TextArea, CheckBox, ImageView*- **AddRecord** As String
- **Class\_Globals** As String
- **ClearLinkView** As String
- **Close** As String
Close connection DB- **DeleteRecord** As String
- **getBlob** (Field As String) As Byte()
- **getCurrentTable** As String
- **getDouble** (Field As String) As Double
- **getImage** (Field As String) As Image
- **getInt** (Field As String) As Int
- **getLong** (Field As String) As Long
- **getPosition** As Int
 *Return -3 : Not Initialized  
Return -2 : Is empty  
 Return -1 : Not positoned*- **getSize** As Int
 *Return -1 id Query non execute*- **getSQL** As SQL
- **getString** (Field As String) As String
- **Initialize** (Path As String, FileName As String, CreateIfNecessary As Boolean) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **NextRecord** As String
- **PreviousRecord** As String
- **Query** (StringQuery As String, PrimaryKeyName As String) As String
- **Query2** (StringQuery As String, StringArg As String(), PrimaryKeyName As String) As String
- **RefreshField** As String
- **setPosition** (Index As Int) As Boolean
*Return false if Query not execute, index out of range or other error*- **UpdateChange** As String

- **Properties:**

- **CurrentTable** As String [read only]
- **Position** As Int
 *Return -3 : Not Initialized  
Return -2 : Is empty  
 Return -1 : Not positoned*- **Size** As Int [read only]
 *Return -1 id Query non execute*- **SQL** As SQL [read only]

  
![](https://www.b4x.com/android/forum/attachments/65866)