### ListPlus library by Ivica Golubovic
### 12/26/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/145045/)

This is one of my first libraries that I created a few years ago. I used it to work in Android Studio because it gave me faster access to certain methods. Now I decided to wrap it for B4X and share it on this forum because it might be useful to someone. I had to make some changes so that the library could be successfully wrapped for B4X, but basically the functionality of the library remained the same.  
  
ListPlus can be defined as Single type list or Different types list. The first implies a list with the same types of variables or objects. The type is defined by the first adding of the object and all other objects to add must be of the same type. If they are not, the application will throw an exception. The second ListPlus type implies a list with different types of variables and objects. You must define the list type when initializing the ListPlus like in example bellow:  

```B4X
ListPlus1.Initialize(False) 'Single type ListPlus'  
'or'  
ListPlus1.Initialize(True) 'Different types ListPlus'
```

  
  
ListPlus has a large number of additional methods compared to the native B4X List. It is also compatible with the native B4X List, so objects can be added from one to the other and vice versa. You can read all ListPlus methods and properties at the bottom of this thread.  
  
The main advantage of this library is that it allows a more detailed search for objects like Custom types and Custom classes. Namely, it is possible to find objects with defined fields or properties and their values. This principle makes it easier to search for these objects.  
  
For example, if you have a list with Custom type objects defined as Pearson and fields (Name, Surname, Address, Age, Gender etc.), it is possible to search for objects by fields and their values. For example, if you want to find peoples with the name John in the list, you need to write the following line:  

```B4X
Dim TempListPlus As ListPlus = ListPlus1.GetAllWith("Name","John")  
'First element represents Field name'  
'Second element represents Field value'
```

  
The result will be a temporary ListPlus of all persons named John (the size of the list will be zero if there are no such persons).  
  
Also, it is possible to search with several defined fields and their values, for example (Name, Age) as in the example below:  

```B4X
Dim TempListPlus As ListPlus = ListPlus1.GetAllWith2(Array As String("Name","Age"),Array("John",28))  
'First element represents the array of Fields names as String'  
'Second element represents the array of Fields values as Object'
```

  
The result will be a temporary ListPlus of all persons named John and 28 years old (the size of the list will be zero if there are no such persons).  
  
This library also allows working with objects based on B4X custom classes. The principle is the same as with custom types and additionally enables searching by properties of these classes. I don't know if it is possible to use all wrapped java classes, I tested only a few of them and it worked without problems.  
  
This library may be also compatible with B4I, B4J and other B4X products (I did not tested).   
  
This library depends on RandomAccessFile library which is an internal library.  
  
**ListPlus  
Author:** Ivica Golubovic  
**Version:** 1.0  

- **ListPlus**

- **Functions:**

- **Add** (Item As Object)
*Adds an item at the end of the ListPlus.*- **AddAll** (Array As Object)
*Adds all elements in the specified collection to the end of the ListPlus.  
Supported Array formats: List, ListPlus and all kinds of simple Arrays formats (String(),Object(),Int(),…).*- **AddAllAt** (Index As Int, Array As Object)
*Adds all elements in the specified collection starting at the specified index.  
Supported Array formats: List, ListPlus and all kinds of simple Arrays formats (String(),Object(),Int(),…).*- **AddAllFromByteArray** (ListExtraBytes As Byte())
*Add all items from Array of Bytes to this ListPlus. Byte array must be compatible with B4XSerializator.*- **AddAllFromFile** (Dir As String, FileName As String)
*Add all items from File to this ListPlus. File must be saved with ListPlus library first.*- **AddAt** (Index As Int, Item As Object)
*Adds the item at the specified index.*- **Clear**
*Removes all the items from the ListPlus.*- **Contains** (Item As Object) As Boolean
*Checking if the ListPlus already contains the specified Item.*- **ContainsAll** (Array As Object) As Boolean
*Checking if the ListPlus already contains all the specified Items placed in the Array.  
Supported Array formats: List, ListPlus and all kinds of simple Arrays formats (String(),Object(),Int(),…).*- **ContainsAny** (Array As Object) As Boolean
*Checking if the ListPlus already contains any of the specified Items placed in the Array.  
Supported Array formats: List, ListPlus and all kinds of simple Arrays formats (String(),Object(),Int(),…).*- **ContainsWith** (FieldOrPropertyName As String, Value As Object) As Boolean
*This method is reserved for B4X Types and B4X Classes related Items. Allows searching by fields or properties of added Items. It is necessary to enter the name of the field or property and the desired value and the library will extract those that correspond to the given query.  
This method will check if ListPlus already contains Items with specified Field or Property value.*- **ContainsWith2** (FieldsOrPropertiesNames As String(), Values As Object()) As Boolean
*This method is reserved for B4X Types and B4X Classes related Items. Allows searching by fields or properties of added Items. It is necessary to enter the names of the fields or properties and the desired values and the library will extract those that correspond to the given query.  
This method will check if ListPlus already contains Items with specified Fields or Properties values.*- **CopyAllTo** (DestinationList As ListPlus)
*This method will copy all items to other ListPlus.*- **CopyAllTo2** (DestinationList As List)
*This method will copy all items from ListPlus to other List.*- **Get** (Index As Int) As Object
*Gets the item in the specified index.*- **GetAllWith** (FieldOrPropertyName As String, Value As Object) As ListPlus
*This method is reserved for B4X Types and B4X Classes related Items. Allows searching by fields or properties of added Items. It is necessary to enter the name of the field or property and the desired value and the library will extract those that correspond to the given query.  
This method will pick up all the Items with specified Field or Property value and place all of them to another temporary ListPlus.*- **GetAllWith2** (FieldsOrPropertiesNames As String(), Values As Object()) As ListPlus
*This method is reserved for B4X Types and B4X Classes related Items. Allows searching by fields or properties of added Items. It is necessary to enter the names of the fields or properties and the desired values and the library will extract those that correspond to the given query.  
This method will pick up all the Items with specified Fields or Properties values and place all of them to another temporary ListPlus.*- **IndexesOf** (Item As Object) As ListPlus
*Returns the indexes of specified item in ListPlus, or empty temporary ListPlus if there is not specified item.*- **IndexesOfAllWith** (FieldOrPropertyName As String, Value As Object) As ListPlus
*This method is reserved for B4X Types and B4X Classes related Items. Allows searching by fields or properties of added Items. It is necessary to enter the name of the field or property and the desired value and the library will extract those that correspond to the given query.  
This method will pick up all indexes of Items with specified Field or Property value and place all indexes to temporary ListPlus.*- **IndexesOfAllWith2** (FieldsOrPropertiesNames As String(), Values As Object()) As ListPlus
*This method is reserved for B4X Types and B4X Classes related Items. Allows searching by fields or properties of added Items. It is necessary to enter the names of the fields or properties and the desired values and the library will extract those that correspond to the given query.  
This method will pick up all indexes of Items with specified Fields or Properties values and place all indexes to temporary ListPlus.*- **IndexOf** (Item As Object) As Int
*Returns the index of the specified item, or -1 if it was not found.*- **Initialize** (AllowAddingDifferentTypes As Boolean)
*Initialises ListPlus.  
AllowAddingDifferentTypes As Boolean:  
True - Allow to add different types of variables and objects in the same ListPlus.  
False - Only allow's to add the same types of variables or objects. The type of the variables or type of objects will be defined after adding the first object or variable to the ListPlus. For example, if you add a String item first, the following items to add must be of the same type (String).*- **IsInitialized** As Boolean
- **LastIndexOf** (Item As Object) As Int
*Returns the index of the last specified item in ListPlus, or -1 if it was not found.*- **LastIndexOfWith** (FieldOrPropertyName As String, Value As Object) As Int
*This method is reserved for B4X Types and B4X Classes related Items. Allows searching by fields or properties of added Items. It is necessary to enter the name of the field or property and the desired value and the library will extract those that correspond to the given query.  
This method will pick up last index of Item with specified Field or Property value.*- **LastIndexOfWith2** (FieldsOrPropertiesNames As String(), Values As Object()) As Int
*This method is reserved for B4X Types and B4X Classes related Items. Allows searching by fields or properties of added Items. It is necessary to enter the names of the fields or properties and the desired values and the library will extract those that correspond to the given query.  
This method will pick up last index of Item with specified Fields or Properties values.*- **Remove** (Item As Object)
*Removes the specified item.*- **RemoveAll** (Array As Object)
*Removes all the specified items in Array.  
Supported Array formats: List, ListPlus and all kinds of simple Arrays formats (String(),Object(),Int(),…).*- **RemoveAllAt** (ArrayOfIndexes As Object)
*Removes all the item at the specified indexes placed in Array of indexes.  
Supported Array formats: List, ListPlus and array of integers (Int()).*- **RemoveAllWith** (FieldOrPropertyName As String, Value As Object)
*This method is reserved for B4X Types and B4X Classes related Items. Allows searching by fields or properties of added Items. It is necessary to enter the name of the field or property and the desired value and the library will extract those that correspond to the given query.  
This method will remove all the Items with specified Field or Property value.*- **RemoveAllWith2** (FieldsOrPropertiesNames As String(), Values As Object())
*This method is reserved for B4X Types and B4X Classes related Items. Allows searching by fields or properties of added Items. It is necessary to enter the names of the fields or properties and the desired values and the library will extract those that correspond to the given query.  
This method will remove all the Items with specified Fields or Properties values.*- **RemoveAt** (Index As Int)
*Removes the item at the specified index.*- **Reverse**
*This method will sort the Items in the list in reverse order.*- **Set** (Index As Int, Item As Object)
*Replaces the current item in the specified index with the new item.*- **Shuffle**
*This method will sort the Items in the ListPlus randomly.*- **Sort** (Ascending As Boolean)
*Sorts the ListPlus. ListPlus must be initialised as single type ListPlus.  
The items must all be numbers or strings.*- **SortWith** (FieldOrPropertyName As String, Ascending As Boolean, CaseInsensitive As Boolean)
*ListPlus must be initialised as single type ListPlus.  
Sorts a list with items of user defined type or class. The ListPlus is sorted based on the specified field or property name.  
FieldOrPropertyName - The field or property name that will be used for sorting. Field or property must contain numbers or strings.  
Ascending - Whether to sort ascending or descending.  
CaseInsensitive - Whether to ignore the characters case.*- **SubList** (FirstIncludedIndex As Int, LastIncludedIndex As Int) As ListPlus
*This method will create SubList from specified first and last included indexes.*- **Swap** (FirstItemIndex As Int, SecondItemIndex As Int)
*This method will swap two Items at specified indexes.*- **ToArray** As Object()
*Cast ListPlus to array of Objects.*- **ToBytes** As Byte()
*Cast ListPlus to array of Bytes. Items in list must be compatible with B4XSerializator.*- **ToList** As List
*Cast ListPlus to B4X List.*- **WriteToFile** (Dir As String, FileName As String)
*Write items from ListPlus to a file on specified location with specified name.  
Items in ListPlus must be compatible with B4XSerializator.*
- **Properties:**

- **IsEmpty** As Boolean [read only]
*Check if ListPlus is empty.*- **Size** As Int [read only]
*Returns the number of Items in the ListPlus.*
  
If this library makes your work easier and saves time in creating your application, please make a donation.  
<https://www.paypal.com/donate?hosted_button_id=HX7GS8H4XS54Q>