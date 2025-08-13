###  JSONQuery -  a JMESPath-like Query Processor for B4X by Blueforcer
### 12/19/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/164680/)

**JSONQuery** is a powerful library that allows you to query JSON data using a [JMESPath](https://jmespath.org/)-like syntax in B4X applications. This library makes it easy to extract, filter, and manipulate JSON data with simple query expressions.  
  
**What is JSONQuery and why should you use it?**  
JSONQuery helps you work with JSON data in your B4X applications. Instead of writing complex code to navigate through JSON structures, you can use simple query expressions. Think of it like SQL for your JSON data - you can easily select, filter, and transform your data with simple commands.  
  
**JSONQuery** is written entirely in B4X! Even if a wrapper etc would be easier, this project was my personal challenge. It has given me a lot of fun, joy, tears and outbursts of anger.  
  
⚠️ IMPORTANT NOTE: Due to the high complexity of JSONQuery and the numerous possible combinations of query expressions, nested structures, and various data types, not all possible combinations and nesting scenarios have been extensively tested. While the core functionality has been verified, users may encounter edge cases or specific combinations that behave unexpectedly.  
  
🙏 Many, Many hours of development, testing, and refinement have gone into creating this JSONQuery library. If you find this library useful in your projects and If you want to support me, then you can do it with [Paypal](https://paypal.me/blueforcer)  
  
  
[SIZE=6]**Simple Property Access**[/SIZE]  
The most basic way to use JSONQuery is to access simple properties from your JSON data. Think of it like accessing fields in a database table.  
  
**What is a property?**  
In JSON, a property is a name-value pair. For example, in {"name": "John"}, "name" is the property name and "John" is its value.  
  
**How to access properties:**  
- Use dot notation (like object.property)  
- Property names are case-sensitive  
- You can access any type of value (text, numbers, arrays, etc.)  
  

```B4X
Sub Example_SimpleAccess  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' This is our JSON data - it's a simple object with two properties  
    Dim json As String = $"{"name": "John", "age": 30}"$  
   
    ' Get name property - use the property name directly after the dot  
    Dim name As String = jq.Query(json, "name")  
   
    ' Get age property - same syntax works for numbers  
    Dim age As Int = jq.Query(json, "age")  
   
    Log("Name: " & name) 'Output: Name: John  
    Log("Age: " & age)   'Output: Age: 30  
End Sub
```

  
  
==================================================================  
  
[SIZE=6]**Nested Property Access**[/SIZE]  
Real JSON data often has objects inside objects (nested structures). JSONQuery makes it easy to access these nested values using dot notation.  
  
**What are nested properties?**  
Nested properties are when one JSON object contains another object. For example: {"user": {"name": "John"}} has "name" nested inside "user".  
  
**How to access nested properties:**  
- Use multiple dots to go deeper into the structure  
- Each dot represents moving into the next level  
- The path shows exactly where to find the data  
  

```B4X
Sub Example_NestedAccess  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' This JSON has nested objects: user contains address, which contains city  
    Dim json As String = $"{"user": {"name": "John", "address": {"city": "New York"}}}"$  
   
    ' Get nested city property by following the path: user → address → city  
    Dim city As String = jq.Query(json, "user.address.city")  
   
    Log("City: " & city) 'Output: City: New York  
End Sub
```

  
  
**Understanding the code:**  
1. Our JSON has three levels of nesting  
2. The query "user.address.city" means:  
 - Start at "user"  
 - Look inside it for "address"  
 - Look inside address for "city"  
3. You can chain as many levels as you need with dots  
  
==================================================================  
  
[SIZE=6]**Array Access**[/SIZE]  
JSON often contains arrays (lists of values). JSONQuery provides several ways to work with arrays.  
  
**What are arrays in JSON?**  
Arrays are ordered lists of values in JSON, written with square brackets []. For example: {"users": ["John", "Jane", "Bob"]} has an array of names.  
  
**How to access arrays:**  
- Use [index] to get a specific item (counting starts at 0)  
- Use [\*]to get all items  
- Use negative numbers to count from the end  
- Combine with property access for arrays of objects  
  

```B4X
Sub Example_ArrayAccess  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' This JSON has an array of user names  
    Dim json As String = $"{"users": ["John", "Jane", "Bob"]}"$  
   
    ' Get first user - arrays start counting at 0  
    Dim firstUser As String = jq.Query(json, $"users[0]"$)  
   
    ' Get all users using wildcard [*]  
    Dim allUsers As List = jq.Query(json, $"users[*]"$)  
   
    Log("First User: " & firstUser) 'Output: First User: John  
    Log("All Users: " & allUsers)   'Output: All Users: [John, Jane, Bob]  
End Sub
```

  
  
**Understanding the code:**  
1. The array is accessed using the property name "users"  
2. users[0] gets the first item (John)  
3. users[\*]gets all items as a list  
4. The result type depends on what you're accessing:  
 - Single item: returns that item's type  
 - [\*]: returns a List  
  
==================================================================  
  
[SIZE=6]**Array Slicing**[/SIZE]  
Array slicing lets you get a portion of an array using start and end positions.  
  
**What is array slicing?**  
Slicing means selecting a range of items from an array. It's like cutting a slice from a loaf of bread - you specify where to start and end the cut.  
  
**Slice syntax: [start:end:step]**  
- start: where to begin (inclusive)  
- end: where to stop (exclusive)  
- step: how many items to skip  
- All parts are optional  
- Negative numbers count from end  
  

```B4X
Sub Example_ArraySlice  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' An array of numbers 0 through 9  
    Dim json As String = $"{"numbers": [0,1,2,3,4,5,6,7,8,9]}"$  
   
    ' Get first three numbers [0:3] means "start at 0, stop before 3"  
    Dim firstThree As List = jq.Query(json, $"numbers[0:3]"$)  
   
    ' Get every second number [::2] means "from start to end, step by 2"  
    Dim everySecond As List = jq.Query(json, $"numbers[::2]"$)  
   
    ' Get last three numbers [-3:] means "start 3 from end, go to end"  
    Dim lastThree As List = jq.Query(json, $"numbers[-3:]"$)  
   
    Log("First Three: " & firstThree)   'Output: First Three: [0,1,2]  
    Log("Every Second: " & everySecond) 'Output: Every Second: [0,2,4,6,8]  
    Log("Last Three: " & lastThree)     'Output: Last Three: [7,8,9]  
End Sub
```

  
  
**Understanding slice notation:**  
1. [0:3] - From index 0 to (but not including) 3  
2. [::2] - From start to end, taking every second item  
3. [-3:] - From third-to-last to the end  
4. [:3] - From start to (but not including) 3  
5. [3:] - From 3 to the end  
6. [-3:-1] - From third-to-last to (but not including) last  
  
==================================================================  
  
[SIZE=6]**Filtering Arrays**[/SIZE]  
Filtering lets you select items from an array that match certain conditions.  
  
**What is filtering?**  
Filtering means selecting only the items that match certain criteria, like "users older than 28" or "orders with status 'pending'".  
  
**How to write filters:**  
- Use [?expression] syntax  
- @ represents the current item  
- Use comparison operators (==, >, <, etc.)  
- Combine conditions with && (and) and || (or)  
  

```B4X
Sub Example_Filtering  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' JSON with an array of user objects  
    Dim json As String = $"{  
        "users": [  
            {"name": "John", "age": 30},  
            {"name": "Jane", "age": 25},  
            {"name": "Bob", "age": 35}  
        ]  
    }"$  
   
    ' Filter users older than 28  
    ' @.age means "age property of current item"  
    Dim olderUsers As List = jq.Query(json, $"users[?@.age > 28]"$)  
   
    ' Filter users named John  
    ' @.name == 'John' means "where name equals John"  
    Dim johnsOnly As List = jq.Query(json, $"users[?@.name == 'John']"$)  
   
    Log("Older Users: " & olderUsers) 'Output: Users older than 28  
    Log("Johns: " & johnsOnly)        'Output: Users named John  
End Sub
```

  
  
**Understanding filter syntax:**  
1. users[?@.age > 28]  
 - users: the array to filter  
 - [?…]: indicates a filter operation  
 - @: represents each item in the array  
 - .age: access the age property  
 - > 28: the condition to check  
  
2. Common filter patterns:  
 - [?@.property == value] - Exact match  
 - [?@.number > value] - Numeric comparison  
 - [?@.property1 == value && @.property2 == value] - Multiple conditions  
  
==================================================================  
  
[SIZE=6]**Built-in Functions**[/SIZE]  
JSONQuery provides several built-in functions to help you work with your data.  
  
[SIZE=5]**length()**[/SIZE]  
The length() function tells you how many items are in something.  
  
**What length() returns:**  
- For strings: number of characters  
- For arrays: number of items  
- For objects: number of properties  
  

```B4X
Sub Example_Length  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' JSON with different types of values  
    Dim json As String = $"{"text": "Hello", "array": [1,2,3], "obj": {"a":1,"b":2}}"$  
   
    ' Get lengths of different types  
    Dim textLength As Int = jq.Query(json, "length(text)")      ' String length  
    Dim arrayLength As Int = jq.Query(json, "length(array)")    ' Array length  
    Dim objLength As Int = jq.Query(json, "length(obj)")        ' Object property count  
   
    Log("Text Length: " & textLength)   'Output: 5  
    Log("Array Length: " & arrayLength) 'Output: 3  
    Log("Object Length: " & objLength)  'Output: 2  
End Sub
```

  
  
**Understanding length():**  
1. length(text) - Counts "Hello" = 5 characters  
2. length(array) - Counts [1,2,3] = 3 items  
3. length(obj) - Counts {"a":1,"b":2} = 2 properties  
  
**[SIZE=5]type()[/SIZE]**  
The type() function tells you what kind of data you're working with.  
  
**What type() returns:**  
- "string" for text  
- "number" for numbers  
- "array" for arrays  
- "object" for JSON objects  
- "null" for null values  
- "boolean" for true/false values  
  

```B4X
Sub Example_Type  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' JSON with different types of values  
    Dim json As String = $"{"str": "Hello", "num": 42, "arr": [], "obj": {}}"$  
   
    ' Get types of different values  
    Dim strType As String = jq.Query(json, "type(str)")  
    Dim numType As String = jq.Query(json, "type(num)")  
    Dim arrType As String = jq.Query(json, "type(arr)")  
    Dim objType As String = jq.Query(json, "type(obj)")  
   
    Log("String Type: " & strType) 'Output: string  
    Log("Number Type: " & numType) 'Output: number  
    Log("Array Type: " & arrType)  'Output: array  
    Log("Object Type: " & objType) 'Output: object  
End Sub
```

  
  
**When to use type():**  
- Checking data before processing  
- Handling different types differently  
- Debugging unexpected values  
  
**[SIZE=5]contains()[/SIZE]**  
The contains() function checks if one thing contains another.  
  
**What contains() checks:**  
- For strings: if one string contains another  
- For arrays: if an item exists in the array  
- Returns true or false  
  

```B4X
Sub Example_Contains  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' JSON with string and array to check  
    Dim json As String = $"{  
        "text": "Hello World",  
        "array": ["apple", "banana", "orange"]  
    }"$  
   
    ' Check if string contains "World"  
    Dim hasWorld As Boolean = jq.Query(json, "contains(text, 'World')")  
   
    ' Check if array contains "banana"  
    Dim hasBanana As Boolean = jq.Query(json, "contains(array, 'banana')")  
   
    Log("Has World: " & hasWorld)   'Output: True  
    Log("Has Banana: " & hasBanana) 'Output: True  
End Sub
```

  
  
**Understanding contains():**  
1. contains(text, 'World') checks if "Hello World" contains "World"  
2. contains(array, 'banana') checks if ["apple", "banana", "orange"] contains "banana"  
3. The search is case-sensitive  
  
**[SIZE=5]join()[/SIZE]**  
The join() function combines array items into a single string.  
  
**How join() works:**  
- First argument: separator string  
- Second argument: array to join  
- Returns: single string with items separated by separator  
  

```B4X
Sub Example_Join  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' JSON with an array of fruits  
    Dim json As String = $"{"fruits": ["apple", "banana", "orange"]}"$  
   
    ' Join array elements with comma separator  
    Dim joined As String = jq.Query(json,"join(',', fruits)")  
   
    Log("Joined Fruits: " & joined) 'Output: apple,banana,orange  
End Sub
```

  
  
**Understanding join():**  
1. First parameter (',') is what goes between items  
2. Second parameter (fruits) is the array to join  
3. You can use any separator: join(', ', fruits) gives "apple, banana, orange"  
4. Useful for creating comma-separated lists or custom formatting  
  
**[SIZE=5]split()[/SIZE]**  
The split() function breaks a string into an array of parts.  
  
**How split() works:**  
- First argument: separator to split on  
- Second argument: string to split  
- Returns: array of parts  
  

```B4X
Sub Example_Split  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' JSON with a comma-separated string  
    Dim json As String = $"{"text": "apple,banana,orange"}"$  
   
    ' Split string into array at commas  
    Dim split As List = jq.Query(json, "split(',', text)")  
   
    Log("Split Text: " & split) 'Output: [apple, banana, orange]  
End Sub
```

  
  
**Understanding split():**  
1. split(',', text) divides text wherever it finds a comma  
2. Useful for parsing comma-separated values (CSV)  
3. Can split on any character or string  
4. Common uses:  
 - Breaking up formatted data  
 - Converting strings to arrays  
 - Parsing structured text  
  
**[SIZE=5]reverse()[/SIZE]**  
The reverse() function flips the order of things.  
  
**What reverse() does:**  
- For strings: reverses the characters  
- For arrays: reverses the order of items  
- Returns: reversed version of input  
  

```B4X
Sub Example_Reverse  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' JSON with string and array to reverse  
    Dim json As String = $"{  
        "text": "Hello",  
        "array": [1, 2, 3]  
    }"$  
   
    ' Reverse string and array  
    Dim reversedText As String = jq.Query(json, "reverse(text)")  
    Dim reversedArray As List = jq.Query(json, "reverse(array)")  
   
    Log("Reversed Text: " & reversedText)   'Output: olleH  
    Log("Reversed Array: " & reversedArray) 'Output: [3, 2, 1]  
End Sub
```

  
  
**Understanding reverse():**  
1. For text: "Hello" becomes "olleH"  
2. For arrays: [1, 2, 3] becomes [3, 2, 1]  
3. Useful for:  
 - Displaying data in reverse order  
 - Text manipulation  
 - Changing array order  
  
==================================================================  
  
[SIZE=6]**Conditions**[/SIZE]  
Conditions let you filter and select data based on specific criteria.  
  
**Available Comparison Operators:**  
- == : Equal to (exact match)  
- != : Not equal to  
- > : Greater than  
- < : Less than  
- >= : Greater than or equal to  
- <= : Less than or equal to  
  
**How to Use Conditions:**  
1. In filters [?expression]  
2. With multiple conditions using && (AND) and || (OR)  
3. With different data types (numbers, strings, etc.)  
  

```B4X
Sub Example_Comparisons  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' JSON with order data  
    Dim json As String = $"{  
        "orders": [  
            {"id": 1, "value": 100, "status": "pending"},  
            {"id": 2, "value": 250, "status": "completed"},  
            {"id": 3, "value": 50, "status": "pending"},  
            {"id": 4, "value": 500, "status": "completed"}  
        ]  
    }"$  
   
    ' Find pending orders with value between 50 and 200  
    ' This combines multiple conditions:  
    ' 1. status must be 'pending'  
    ' 2. value must be >= 50  
    ' 3. value must be <= 200  
    Dim query As String = $"orders[?@.status == 'pending' && @.value >= 50 && @.value <= 200]"$  
    Dim result As List = jq.Query(json, query)  
   
    Log("Result: " & result)  
    'Output: [{"id": 1, "value": 100, "status": "pending"}]  
End Sub
```

  
  
**Understanding complex conditions:**  
1. && means AND (both conditions must be true)  
2. || means OR (either condition can be true)  
3. You can combine multiple conditions  
4. Use parentheses for complex grouping  
5. Examples:  
 - [?@.age > 25 && @.status == 'active']  
 - [?@.type == 'urgent' || @.priority > 5]  
 - [?(@.price > 100 && @.stock > 0) || @.preorder == true]  
  
==================================================================  
  
[SIZE=6]**Complex Examples**[/SIZE]  
  
**Combining Multiple Features**  
Real-world queries often combine multiple features to get exactly the data you need.  
  

```B4X
Sub Example_Complex  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' Complex JSON structure with nested data  
    Dim json As String = $"{  
        "users": [  
            {"name": "John", "age": 30, "hobbies": ["reading", "gaming"]},  
            {"name": "Jane", "age": 25, "hobbies": ["painting", "music"]},  
            {"name": "Bob", "age": 35, "hobbies": ["sports", "cooking"]}  
        ]  
    }"$  
   
    ' Complex query combining multiple features:  
    ' 1. Filter users over 28  
    ' 2. Create new structure with specific fields  
    ' 3. Access array elements  
    Dim query As String = $"users[?@.age > 28].{name: name, firstHobby: hobbies[0]}"$  
    Dim result As List = jq.Query(json, query)  
   
    Log("Result: " & result)  
    'Output: [  
    '  {"name": "John", "firstHobby": "reading"},  
    '  {"name": "Bob", "firstHobby": "sports"}  
    ']  
End Sub
```

  
  
**Understanding complex queries:**  
1. users[?@.age > 28] - Filters the users array  
2. .{name: name, …} - Creates new object structure  
3. hobbies[0] - Gets first hobby from array  
4. Multiple operations are chained with dots  
  
**Working with Multi-Select**  
Multi-select lets you reshape your data by creating new object structures.  
  

```B4X
Sub Example_MultiSelect  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' JSON with nested user data  
    Dim json As String = $"{  
        "user": {  
            "name": "John Doe",  
            "email": "john@example.com",  
            "address": {  
                "street": "123 Main St",  
                "city": "New York",  
                "country": "USA"  
            }  
        }  
    }"$  
   
    ' Create new structure with selected fields  
    ' Format: {newName: originalPath}  
    Dim query As String = $"user.{fullName: name, contact: email, location: address.city}"$  
    Dim result As Map = jq.Query(json, query)  
   
    Log("Result: " & result)  
    'Output: {  
    '  "fullName": "John Doe",  
    '  "contact": "john@example.com",  
    '  "location": "New York"  
    '}  
End Sub
```

  
  
**Understanding multi-select:**  
1. Use {newName: path} syntax  
2. newName becomes the property name in result  
3. path is where to get the value  
4. Useful for:  
 - Renaming properties  
 - Restructuring data  
 - Creating custom output formats  
  
==================================================================  
  
[SIZE=6]**Error Handling**[/SIZE]  
Proper error handling is crucial for robust applications. JSONQuery provides tools to help you handle errors gracefully.  
  

```B4X
Sub Example_ErrorHandling  
    Dim jq As JSONQuery  
    jq.Initialize  
   
    ' Enable debug mode for detailed logging  
    jq.setDebugmode(True)  
   
    ' Try to query some JSON data  
    Dim json As String = $"{"name": "John"}"$  
   
    ' Try to access non-existent property  
    Dim result As Object = jq.Query(json, "age")  
   
    ' Check for errors  
    If result = Null Then  
        Log("Error: " & jq.GetLastError)  
    End If  
End Sub
```

  
  
==================================================================  
  
[SIZE=6]**Debug Mode**[/SIZE]  
Debug mode is your best friend when developing complex queries.  
  
**What debug mode shows:**  
1. Step-by-step query processing  
2. Values being evaluated  
3. Function calls and arguments  
4. Filter conditions and results  
5. Error conditions and causes  
  
**When to use debug mode:**  
- During development  
- When troubleshooting issues  
- Learning how queries work  
- Understanding complex operations  
  

```B4X
Sub Example_DebugModeOutput  
    Dim jq As JSONQuery  
    jq.Initialize  
    jq.setDebugmode(True)  
   
    ' Sample JSON data  
    Dim json As String = $"{  
        "users": [  
            {"name": "John", "age": 30},  
            {"name": "Jane", "age": 25}  
        ]  
    }"$  
   
    ' Execute query with debug mode on  
    Dim result As Object = jq.Query(json, $"users[?@.age > 28].name"$)  
   
    ' Debug output explains each step:  
    ' 1. Parsing expression  
    ' 2. Evaluating parts  
    ' 3. Applying filters  
    ' 4. Checking conditions  
    ' 5. Building results  
End Sub
```

  
  
  
  
[SIZE=5]**Changelog**[/SIZE]  
**v1.0.1 (18.12.2024)**  
- Fixed multi-select mapping when working with nested arrays, ensuring proper flattening of array elements in expressions like `array[\*].nestedArray  
[\*].{key: value}`  
- Improved handling of single values in multi-select results to prevent unnecessary array wrapping