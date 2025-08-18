### Android JSON tutorial by Erel
### 02/07/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/6923/)

JSON format is a a format similar to XML but usually it is shorter and easier to parse.  
Many web services now work with JSON. JSON official site: [JSON](http://www.json.org/)  
  
Using the new JSON library, you can parse and generate JSON strings easily.  
  
As an example we will parse a the following JSON string:  

```B4X
{"menu": {  
  "id": "file",  
  "value": "File",  
  "popup": {  
    "menuitem": [  
      {"value": "New", "onclick": "CreateNewDoc()"},  
      {"value": "Open", "onclick": "OpenDoc()"},  
      {"value": "Close", "onclick": "CloseDoc()"}  
    ]  
  }  
}}
```

This example was taken from [json.org/examples](http://json.org/examples).  
Curl brackets represent an object and square brackets represent an array.  
Objects hold key/value pairs and arrays hold list of elements. Commas separate between elements.  
  
In this example, the top level value is an object. This object contains a single object with the key "menu".  
The value of this object is another object that holds several elements.  
We will get the "menuitem" element, which holds an array of objects, and print the values of the "value" element.  
  
After parsing the string, JSON objects are converted to Maps and JSON arrays are converted to Lists.  
We will read this string from a file added by the files manager (Files tab).  

```B4X
    Dim JSON As JSONParser  
    Dim Map1 As Map  
    JSON.Initialize(File.ReadString(File.DirAssets, "example.json"))  
    Map1 = JSON.NextObject  
    Dim m As Map 'helper map for navigating  
    Dim MenuItems As List  
    m = Map1.Get("menu")  
    m = m.Get("popup")  
    MenuItems = m.Get("menuitem")  
    For i = 0 To MenuItems.Size - 1  
        m = MenuItems.Get(i)  
        Log(m.Get("value"))  
    Next
```

JSON.NextObject parses the string and returns a Map with the parsed data. This method should be called when the top level value is an object (which is usually the case).  
Now we will work with Map1 to get the required values.  
We declare an additional Map with the name 'm'.  

```B4X
m = Map1.Get("menu")
```

The object that maps to "menu" is assigned to m.  

```B4X
m = m.Get("popup")
```

The object that maps to "popup" is now assigned to m.  

```B4X
MenuItems = m.Get("menuitem")
```

The array assigned to "menuitem" is assigned to the MenuItems list.  
We will iterate over the items (which are maps in this case) and print the values stored in the elements with "value" key.  

```B4X
    For i = 0 To MenuItems.Size - 1  
        m = MenuItems.Get(i)  
        Log(m.Get("value"))  
    Next
```

The output in the LogCat is:  
New  
Open  
Close  
  
Generating JSON strings is done in a similar way. We create a Map or a List that holds the values and then using JSONGenerator we convert it to a JSON string:  

```B4X
    Dim Data As List  
    Data.Initialize  
    Data.Add(1)  
    Data.Add(2)  
    Data.Add(3)  
    Data.Add(Map1) 'add the previous map loaded from the file.  
    Dim JSONGenerator As JSONGenerator  
    JSONGenerator.Initialize2(Data)  
    Msgbox(JSONGenerator.ToPrettyString(2), "")
```

JSONGenerator can be initialized with a map or a list.  
Converting the data to a JSON string is done by calling ToString or ToPrettyString. ToPrettyString adds indentation and is easier to read and debug.  
  
![](http://www.b4x.com/basic4android/images/json_1.png)  
  
**A tool to help you with working with JSON strings: <https://b4x.com:51041/json/index.html>**