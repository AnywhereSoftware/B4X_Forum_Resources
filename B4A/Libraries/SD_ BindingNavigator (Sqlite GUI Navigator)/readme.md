### SD: BindingNavigator (Sqlite GUI Navigator) by Star-Dust
### 11/20/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/90916/)

This is a first version of the BindingNavigator Library, which wants to somehow reproduce the corresponding BindingNavigator of VB.NET.  
What is needed? I want to get something similar to the tools available on VB.NET to link the views to the DB. As in the pictures.  
  
![](https://www.b4x.com/android/forum/attachments/65884)![](https://www.b4x.com/android/forum/attachments/65885)  
  
A **DataSet** Class is available that allows to associate some views (EditText, Label, ImageView, ToggleButton, CheckBox) with specific fields of a Sqlite DataBase.  
  
By scrolling the position of the DataSet the fields will be updated and if the fields in some way undergo a variation by the user, raising the UpdateChange event will in turn be modified in the DataBase.  
This very Agevolent construction of GUI related to the DB.  
  
In addition you have a Second ViewCalss **NavigatorBar** that adds a new Seek view to the design that is linked to the DataSet. Scrolling through the Seek will change all the views linked to the DataSet. And if the UpdateChange eventio is updated, the DB will be updated based on changes in the views linked to the fields.  
  
**[SIZE=4]VERY IMPORTANT: [/SIZE]**  

1. The sql database must always have a **Primarykey** field, of type int with auto-increment, in the example i call it ID, but it could be called as you want.
The name of the field that will be the **Primarykey** must be communicated to the DataSet when call query method.2. If you use NavigatorBar, in your code you must load **FontAwesone**, as in the example at post#2, or in the Wish you can have a view set with FontAwesone

  
  
**SD\_BindingNavigator  
  
Author:** Star-Dust  
**Version:** 0.50  

- **DataSet**

- **Functions:**

- **AddGroupView** (Panel As Panel) As String
- **AddLinkView** (V As View, Field As String) As String
- **AddRecord** As String
- **Class\_Globals** As String
- **ClearLinkView** As String
- **DeleteRecord** As String
- **getBitmap** (Field As String) As Bitmap
- **getBlob** (Field As String) As Byte()
- **getCurrentTable** As String
- **getDouble** (Field As String) As Double
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

- **NavigatorBar**

- **Events:**

- **ValueChanged** (Value As Int)

- **Fields:**

- **Coefficent** As Float
- **FontAW** As Typeface

- **Functions:**

- **AddGroupView** (Panel As Panel) As String
- **AddLinkView** (V As View, Field As String) As String
- **Class\_Globals** As String
- **ConnectDB** (Path As String, FileName As String, CreateIfNecessary As Boolean) As String
- **DesignerCreateView** (Base As Panel, Lbl As Label, Props As Map) As String
- **GetBase** As Panel
- **getDataSet** As DataSet
- **getPosition** As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **Query** (StringQuery As String, PrimaryKeyName As String) As String
- **Query2** (StringQuery As String, StringArg As String(), PrimaryKeyName As String) As String
- **RefreshField** As String
- **setDataSet** (Dset As DataSet) As String
- **setPosition** (pos As Int) As String
- **UpdateChange** As String

- **Properties:**

- **DataSet** As DataSet
- **Position** As Int

- **WizardMask**

- **Events:**

- **ValueChanged** (Value As Int)

- **Fields:**

- **Coefficent** As Float
- **FontAW** As Typeface

- **Functions:**

- **AddAllField** As String
- **AddField** (FieldName As String, Hint As String) As String
- **Class\_Globals** As String
- **ClearField** As String
- **ConnectDB** (Path As String, FileName As String, CreateIfNecessary As Boolean) As String
- **CreateMask** As String
- **DesignerCreateView** (Base As Panel, Lbl As Label, Props As Map) As String
- **GetBase** As Panel
- **getDataSet** As DataSet
- **getPosition** As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **Query** (StringQuery As String, PrimaryKeyName As String) As String
- **Query2** (StringQuery As String, StringArg As String(), PrimaryKeyName As String) As String
- **RefreshField** As String
- **setDataSet** (Dset As DataSet) As String
- **setPosition** (pos As Int) As String
- **UpdateChange** As String

- **Properties:**

- **DataSet** As DataSet
- **Position** As Int

  
  
[SIZE=4]It is still undergoing improvements, if there are any suggestions or bugs, report them[/SIZE]  
  
  
![](https://www.b4x.com/android/forum/attachments/65758) ![](https://www.b4x.com/android/forum/attachments/65762)  
  
![](https://www.b4x.com/android/forum/attachments/65778) ![](https://www.b4x.com/android/forum/attachments/65761)