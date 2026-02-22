### ✨ Magic API: Build a Powerful Server-Side REST API with MySQL, MSSQL, SQLite, PostgreSQL, Oracle, and Firebird and File Management in 5 Minutes! 🚀 by fernando1987
### 02/21/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/148322/)

**⚡️ Unleash the API Power: Magic API for Seamless B4X Integration**  
  
  
  
? Greetings, B4X enthusiasts! Today, I'm thrilled to unveil the magic behind our latest creation—the Magic API. Elevate your B4X applications with streamlined API integration, simplifying CRUD operations effortlessly. From uploading api.php to securing your connection data, this library is your key to seamless integration. Explore its advantages and fortify your data integrity with advanced security measures. Let's dive into the API revolution!  
  
  
  
? Advantages of Magic API:  
  
 **Unlock the Magic: Seamlessly integrate API functionality into your B4X applications.**  
  
 **Effortless CRUD Operations: Create, Read, Update, and Delete with ease, optimizing data management.**  
  
? Advanced Security Measures: API key authentication, HTTPS encryption, and input validation ensure data confidentiality and integrity.  
  
? Base URL: <http://example.com/api.php>  
  
? User-Friendly Initialization: Just upload, edit the header with your connection data, and you're ready to communicate!  
  
  
  
  
  
**?Usage Instructions:**  
  
  
  
1. Upload the api.php file to your server.  
  
2. Edit the header with your connection data.  
  
3. You're ready to communicate your app with your mobile and desktop applications.  
  
  
  
Note: The API works fine without the library, but the library will help you communicate more easily.  
  
  
  
? Explore API Documentation:  
  
**API Documentation  
  
Security**  
  
The API employs several security measures to ensure the integrity and confidentiality of your data:  
  
  
  

- **Authentication:** All API requests require an API key to be included as a query parameter. This key uniquely identifies the client making the request and provides access control to the API endpoints.
- **HTTPS:** Communication with the API is always encrypted over HTTPS, ensuring that data transmitted between the client and the server remains confidential.
- **Input validation:** The API performs input validation and sanitization to prevent common security vulnerabilities such as SQL injection or cross-site scripting (XSS) attacks.

**Base URL**  
  
<http://example.com/api.php>  
  
**Authentication**  
  
The API uses an API key for authentication. The API key must be included as a parameter in all requests.  
  
  
  
**Authentication Parameters**  
  

- api\_key (required): The API key to authenticate the request.

**Available Resources  
  
  
  
🌟 Ultimate Guide: Manage Any MySQL Database with DatabaseAPI and api.php in B4X**  
  
  
  
Welcome, developers! This guide shows you how to use the B4X DatabaseAPI class with the api.php script to interact with **any MySQL database** in a simple, secure, and efficient way. We provide practical examples for each method, both in B4X and direct API calls using cURL, along with instructions for configuring connection variables, security measures, and the advantages of using this API. 🚀  
  
  
  
  
  
**🛠️ Initial Setup  
  
  
  
Server and api.php Configuration**  
  
  
  
Before uploading api.php to your server, edit the connection variables to match your MySQL environment:  
  
  
  
  
  
php  
  
  
  
// Database connection parameters  
  
$servername = "localhost"; // Change to your MySQL server address (e.g., "mysql.yourserver.com")  
  
$username = "root"; // Change to your database user  
  
$password = ""; // Change to the user’s password  
  
$dbname = "inventory\_system"; // Default database  
  
$apiKey = '1234'; // Change to a secure, unique API key  
  
  
  
  
  
  
  
**Steps to upload to the server**:  
  
  
  
  
  

1. Open api.php in a text editor.
2. Update $servername, $username, $password, and $apiKey to match your setup.
3. Optionally, set a default database in $dbname if you don’t plan to use the dbname parameter in requests.
4. Upload api.php to your web server’s root directory (e.g., /public\_html/api.php or C:\xampp\htdocs\api.php for a local server).
5. Ensure your server has PHP and MySQL enabled.

  
  
**API Security**  
  
  
  
The API implements several security measures to protect your data:  
  
  
  
  
  

- **API Key Authentication**: All requests require an api\_key parameter (e.g., 1234). Change $apiKey in api.php to a unique, secure value and store it safely.
- **SQL Injection Prevention**: Uses prepared statements (mysqli::prepare) and data escaping (real\_escape\_string) to prevent SQL injections.
- **Query Restriction**: Custom queries (custom\_query) are restricted to SELECT statements to prevent unauthorized modifications.
- **CORS Configuration**: Allows requests from any origin (Access-Control-Allow-Origin: \*), but you can restrict it to specific domains for enhanced security (e.g., Access-Control-Allow-Origin: <https://yourdomain.com>).
- **UTF-8 Encoding**: Ensures compatibility with special characters and avoids encoding issues.
- **No Caching**: Headers like Cache-Control and Expires prevent responses from being cached, reducing risks of accessing outdated data.

  
  
**Security Recommendations**:  
  
  
  
  
  

- Use a strong, unique API key (e.g., a generated hash).
- Enable HTTPS on your server to encrypt communications.
- Restrict MySQL user permissions to the minimum required (e.g., read/write only for the specific database).
- Consider adding a firewall or .htaccess rules to limit access to api.php.

  
  
**Advantages of Using the API**  
  
  
  

- **Cross-Platform Compatibility**: As a RESTful API, api.php can be used from any platform or language (B4X, JavaScript, Python, etc.) via HTTP requests, making it ideal for mobile, web, or desktop applications.
- **Database Flexibility**: Connect to any MySQL database by specifying the dbname parameter in the URL, without modifying server code.
- **Scalability**: Supports complex operations like batch inserts, table joins, and custom queries, suitable for large-scale projects.
- **Easy Integration**: The DatabaseAPI class simplifies interactions in B4X, while standard HTTP calls allow integration with other technologies.
- **Robust Security**: Includes authentication, SQL injection prevention, and HTTPS support for secure operations.
- **Simple Maintenance**: The modular design of api.php and DatabaseAPI makes updates and customizations straightforward.

  
  
**Sample Database**  
  
  
  
For the examples, we use a test database called inventory\_system. Create the tables with this SQL (in phpMyAdmin or MySQL console):  
  
  
  
  
  

```B4X
CREATE DATABASE inventory_system;  
  
USE inventory_system;  
  
  
  
CREATE TABLE products (  
  
id INT AUTO_INCREMENT PRIMARY KEY,  
  
name VARCHAR(255),  
  
price DECIMAL(10,2),  
  
stock INT,  
  
category_id INT  
  
);  
  
  
  
CREATE TABLE categories (  
  
id INT AUTO_INCREMENT PRIMARY KEY,  
  
category_name VARCHAR(255)  
  
);  
  
  
  
– Sample data  
  
INSERT INTO products (name, price, stock, category_id) VALUES  
  
('Laptop', 999.99, 10, 1),  
  
('Mouse', 29.99, 50, 2),  
  
('Keyboard', 59.99, 20, 2);  
  
  
  
INSERT INTO categories (category_name) VALUES  
  
('Electronics'),  
  
('Accessories');
```

  
  
  
  
**Note**: You can use any database by specifying dbname in requests (e.g., ?dbname=my\_database).  
  
  
  
**B4X Configuration**  
  
  
  
Initialize the DatabaseAPI class with your database name in the URL:  
  
  
  
  
  

```B4X
Sub Process_Globals  
  
Private db As DatabaseAPI  
  
End Sub  
  
  
  
Sub AppStart  
  
db.Initialize(Me, "DB", "http://localhost/api.php?dbname=inventory_system", "YOUR APIKEY")  
  
End Sub
```

  
  
  
  
  
  
**Requirements**  
  
  
  

- **Server**: Ensure api.php is in the server’s root directory (e.g., C:\xampp\htdocs\api.php for XAMPP).
- **API Key**: Use 1234 or the key defined in api.php.
- **Testing**: Use Postman, cURL, or a terminal to test direct API calls.

  
  

---

  
  
  
**📋 Usage Examples  
  
  
  
Direct API Calls (cURL)**  
  
[HEADING=1]🌐 API CRUD – Full cURL Examples[/HEADING]  
  
[HEADING=2]🔹 Insert Data[/HEADING]  
  

```B4X
 POST "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products"  
H "Content-Type: application/json"  
d "{"name":"Monitor","price":199.99,"stock":15,"category_id":1}"
```

  
  
  

```B4X
POST "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products"  
H "Content-Type: application/json"  
d "{"name":"Headphones","price":79.99,"stock":30,"category_id":2}"  
  
  
POST "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products"  
H "Content-Type: application/json"  
d "{"name":"Webcam","price":49.99,"stock":25,"category_id":2}"
```

  
  
  

```B4X
POST "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&action=batch_insert"  
H "Content-Type: application/json"  
d "[{"name":"Tablet","price":299.99,"stock":8,"category_id":1},  
{"name":"Speaker","price":89.99,"stock":12,"category_id":2}]"
```

  
  
  

```B4X
' First check  
GET "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&column=name&value=Mouse"  
  
  
'Then insert or update  
PUT "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&column=name&value=Mouse"  
H "Content-Type: application/json"  
d "{"name":"Mouse","price":34.99,"stock":60,"category_id":2}"
```

  
  
  

---

  
  
[HEADING=2]🔹 Delete Data[/HEADING]  
  

```B4X
DELETE "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&id=1"
```

  
  
  

```B4X
DELETE "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&column=name&value=Mouse"
```

  
  
  

```B4X
DELETE "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&column=price&value=100&comparison=>"
```

  
  
  

```B4X
DELETE "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&action=clear_table"
```

  
  
  

```B4X
DELETE "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=new_table&action=drop_table"
```

  
  
  

```B4X
DELETE "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&action=drop_column&column=status"
```

  
  
  

---

  
  
[HEADING=2]🔹 Update Data[/HEADING]  
  

```B4X
PUT "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&id=2"  
H "Content-Type: application/json"  
d "{"name":"Mouse","price":39.99,"stock":45,"category_id":2}"
```

  
  
  

```B4X
PUT "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&column=name&value=Keyboard"  
H "Content-Type: application/json"  
d "{"stock":25}"
```

  
  
  

```B4X
PUT "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&column=price&value=50&comparison=>"  
H "Content-Type: application/json"  
d "{"stock":30}"
```

  
  
  

```B4X
PUT "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&action=update_multiple&column=category_id&value=2"  
H "Content-Type: application/json"  
d "{"stock":100}"
```

  
  
  

```B4X
PUT "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&table2=categories&join_column1=category_id&join_column2=id&condition_column=category_id&condition_value=2&comparison=="  
H "Content-Type: application/json"  
d "{"table1":{"stock":50},"table2":{"category_name":"Updated Accessories"}}"
```

  
  
  

---

  
  
[HEADING=2]🔹 Search / Select Data[/HEADING]  
  

```B4X
GET "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&id=2"
```

  
  
  

```B4X
GET "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products"
```

  
  
  

```B4X
GET "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&column=category_id&value=1"
```

  
  
  

```B4X
GET "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&column=price&value=100&comparison=>"
```

  
  
  

```B4X
GET "http://localhost/api.php?api_key=1234&dbname=inventory_system&action=custom_query&query=SELECT%20*%20FROM%20products%20INNER%20JOIN%20categories%20ON%20products.category_id%20=%20categories.id"
```

  
  
  

```B4X
GET "http://localhost/api.php?api_key=1234&dbname=inventory_system&action=custom_query&query=SELECT%20*%20FROM%20products%20INNER%20JOIN%20categories%20ON%20products.category_id%20=%20categories.id%20WHERE%20products.price%20%3E%20100"
```

  
  
  

```B4X
GET "http://localhost/api.php?api_key=1234&dbname=inventory_system&action=custom_query&query=SELECT%20name%2C%20price%20FROM%20products%20WHERE%20price%20%3E%20100"
```

  
  
  

---

  
  
[HEADING=2]🔹 Table and Column Operations[/HEADING]  
  

```B4X
POST "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=new_table&action=create_table"  
H "Content-Type: application/json"  
d "{"name":"VARCHAR(255)","price":"DECIMAL(10,2)","stock":"INT","category_id":"INT"}"
```

  
  
  

```B4X
PATCH "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&column=status&type=VARCHAR(50)"
```

  
  
  

```B4X
GET "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&action=schema"
```

  
  
  

```B4X
GET "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&action=exists_table"
```

  
  
  

---

  
  
[HEADING=2]🔹 Statistics and Aggregations[/HEADING]  
  

```B4X
GET "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&action=sum&column=price"
```

  
  
  

```B4X
GET "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&action=count"
```

  
  
  

```B4X
GET "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&action=count_value&column=category_id&value=2"
```

  
  
  

```B4X
GET "http://localhost/api.php?api_key=1234&dbname=inventory_system&table=products&action=percentage&column=category_id&value=2"
```

  
  
  
**B4X Code: Complete Examples**  
  
  
  

```B4X
' In Main module or another module  
  
Sub Process_Globals  
  
Private db As DatabaseAPI  
  
End Sub  
  
  
  
Sub AppStart  
  
' Initialize with your database name  
  
db.Initialize(Me, "DB", "http://localhost/api.php?dbname=inventory_system", "1234")  
  
  
  
' Insertmaps: Insert a single product  
  
Dim data As Map  
  
data.Initialize  
  
data.Put("name", "Monitor")  
  
data.Put("price", 199.99)  
  
data.Put("stock", 15)  
  
data.Put("category_id", 1)  
  
db.Insertmaps(data, "products")  
  
  
  
' InsertMultipleMaps: Insert multiple products individually  
  
Dim ListOfMaps As List  
  
ListOfMaps.Initialize  
  
Dim m1, m2 As Map  
  
m1.Initialize  
  
m1.Put("name", "Headphones")  
  
m1.Put("price", 79.99)  
  
m1.Put("stock", 30)  
  
m1.Put("category_id", 2)  
  
m2.Initialize  
  
m2.Put("name", "Webcam")  
  
m2.Put("price", 49.99)  
  
m2.Put("stock", 25)  
  
m2.Put("category_id", 2)  
  
ListOfMaps.Add(m1)  
  
ListOfMaps.Add(m2)  
  
db.InsertMultipleMaps(ListOfMaps, "products")  
  
  
  
' BatchInsert: Insert multiple products in one call  
  
db.BatchInsert(ListOfMaps, "products")  
  
  
  
' InsertOrUpdateMapForColumnValue: Insert or update based on name  
  
Dim updateData As Map  
  
updateData.Initialize  
  
updateData.Put("name", "Mouse")  
  
updateData.Put("price", 34.99)  
  
updateData.Put("stock", 60)  
  
updateData.Put("category_id", 2)  
  
db.InsertOrUpdateMapForColumnValue("products", "name", "Mouse", updateData)  
  
  
  
' Delete: Delete a product by ID  
  
db.Delete("products", "1")  
  
  
  
' DeleteByColumn: Delete products by name  
  
db.DeleteByColumn("products", "name", "Mouse")  
  
  
  
' DeleteByColumn_comparison: Delete products with price > 100  
  
db.DeleteByColumn_comparison("products", "price", "100", ">")  
  
  
  
' Update: Update a product by ID  
  
Dim updateMap As Map  
  
updateMap.Initialize  
  
updateMap.Put("name", "Mouse")  
  
updateMap.Put("price", 39.99)  
  
updateMap.Put("stock", 45)  
  
updateMap.Put("category_id", 2)  
  
db.Update("products", "2", updateMap)  
  
  
  
' UpdateByColumn: Update stock by name  
  
Dim updateByColumnMap As Map  
  
updateByColumnMap.Initialize  
  
updateByColumnMap.Put("stock", 25)  
  
db.UpdateByColumn("products", "name", "Keyboard", updateByColumnMap)  
  
  
  
' UpdateByColumn_comparison: Update stock for expensive products  
  
Dim updateByColumnCompMap As Map  
  
updateByColumnCompMap.Initialize  
  
updateByColumnCompMap.Put("stock", 30)  
  
db.UpdateByColumn_comparison("products", "price", "50", ">", updateByColumnCompMap)  
  
  
  
' UpdateMultipleRows: Update stock for category  
  
Dim updateMultiMap As Map  
  
updateMultiMap.Initialize  
  
updateMultiMap.Put("stock", 100)  
  
db.UpdateMultipleRows("products", "category_id", "2", "=", updateMultiMap)  
  
  
  
' UpdateTwoTables: Update products and categories  
  
Dim updateTwoTablesMap As Map  
  
updateTwoTablesMap.Initialize  
  
updateTwoTablesMap.Put("table1", CreateMap("stock": 50))  
  
updateTwoTablesMap.Put("table2", CreateMap("category_name": "Updated Accessories"))  
  
db.UpdateTwoTables("products", "categories", "category_id", "id", "category_id", "2", "=", updateTwoTablesMap)  
  
  
  
' SearchforId: Find product by ID  
  
db.SearchforId("products", "2")  
  
  
  
' GetTable: Retrieve all products  
  
db.GetTable("products")  
  
  
  
' Search: Find products by category  
  
db.Search("products", "category_id", "1")  
  
  
  
' Search_comparison: Find expensive products  
  
db.Search_comparison("products", "price", "100", ">")  
  
  
  
' ClearTable: Clear all products  
  
db.ClearTable("products")  
  
  
  
' SumColumn: Sum product prices  
  
db.SumColumn("products", "price")  
  
  
  
' CountRows: Count all products  
  
db.CountRows("products")  
  
  
  
' CountValue: Count products in category  
  
db.CountValue("products", "category_id", "2")  
  
  
  
' CreateTable: Create a new table  
  
Dim columns As Map  
  
columns.Initialize  
  
columns.Put("name", "VARCHAR(255)")  
  
columns.Put("price", "DECIMAL(10,2)")  
  
columns.Put("stock", "INT")  
  
columns.Put("category_id", "INT")  
  
db.CreateTable("new_table", columns)  
  
  
  
' CreateColumn: Add a status column  
  
db.CreateColumn("products", "status", "VARCHAR(50)")  
  
  
  
' DeleteColumn: Remove status column  
  
db.DeleteColumn("products", "status")  
  
  
  
' CustomQuery: Custom SELECT query  
  
db.CustomQuery("SELECT name, price FROM products WHERE price > 100")  
  
  
  
' DeleteTable: Drop a table  
  
db.DeleteTable("new_table")  
  
  
  
' JoinTables: Join products and categories  
  
db.JoinTables("products", "categories", "INNER", "category_id", "id")  
  
  
  
' FilterJoinTables: Join with filter  
  
db.FilterJoinTables("products", "categories", "INNER", "category_id", "id", "products.price", "100", ">")  
  
  
  
' GetTableSchema: Get product table schema  
  
db.GetTableSchema("products")  
  
  
  
' ExistsTable: Check if table exists  
  
db.ExistsTable("products")  
  
  
  
' GetPercentage: Get percentage of products in category  
  
db.GetPercentage("products", "category_id", "2", "=")  
  
End Sub  
  
  
  
' Callbacks for handling responses  
  
Private Sub DB_Insertmaps(Result As Map, Success As Boolean)  
  
If Success Then Log($"Inserted: ${Result}"$) Else Log("Insert failed")  
  
End Sub  
  
  
  
Private Sub DB_BatchInsert(InsertedIds As List, Success As Boolean)  
  
If Success Then Log($"Batch inserted IDs: ${InsertedIds}"$) Else Log("Batch insert failed")  
  
End Sub  
  
  
  
Private Sub DB_InsertOrUpdateMapForColumnValue(Action As String, Success As Boolean)  
  
If Success Then Log($"Action: ${Action}"$) Else Log("Insert/Update failed")  
  
End Sub  
  
  
  
Private Sub DB_Delete(TableName As String, Success As Boolean)  
  
If Success Then Log($"Deleted from: ${TableName}"$) Else Log("Delete failed")  
  
End Sub  
  
  
  
Private Sub DB_DeleteByColumn(TableName As String, Success As Boolean)  
  
If Success Then Log($"Deleted by column from: ${TableName}"$) Else Log("Delete by column failed")  
  
End Sub  
  
  
  
Private Sub DB_Update(TableName As String, Success As Boolean)  
  
If Success Then Log($"Updated: ${TableName}"$) Else Log("Update failed")  
  
End Sub  
  
  
  
Private Sub DB_UpdateByColumn(TableName As String, Success As Boolean)  
  
If Success Then Log($"Updated by column: ${TableName}"$) Else Log("Update by column failed")  
  
End Sub  
  
  
  
Private Sub DB_UpdateMultipleRows(TableName As String, Success As Boolean)  
  
If Success Then Log($"Multiple rows updated: ${TableName}"$) Else Log("Update multiple rows failed")  
  
End Sub  
  
  
  
Private Sub DB_UpdateTwoTables(Result As Map, Success As Boolean)  
  
If Success Then Log($"Two tables updated: ${Result}"$) Else Log("Update two tables failed")  
  
End Sub  
  
  
  
Private Sub DB_SearchforId(Result As Map, Success As Boolean)  
  
If Success Then Log($"Found: ${Result}"$) Else Log("Search by ID failed")  
  
End Sub  
  
  
  
Private Sub DB_GetTable(Result As List, Success As Boolean)  
  
If Success Then  
  
For Each row As Map In Result  
  
Log($"Row: ${row}"$)  
  
Next  
  
Else  
  
Log("Get table failed")  
  
End If  
  
End Sub  
  
  
  
Private Sub DB_Search(Result As List, Success As Boolean)  
  
If Success Then  
  
For Each row As Map In Result  
  
Log($"Search result: ${row}"$)  
  
Next  
  
Else  
  
Log("Search failed")  
  
End If  
  
End Sub  
  
  
  
Private Sub DB_ClearTable(TableName As String, Success As Boolean)  
  
If Success Then Log($"Table cleared: ${TableName}"$) Else Log("Clear table failed")  
  
End Sub  
  
  
  
Private Sub DB_SumColumn(Total As Double, Success As Boolean)  
  
If Success Then Log($"Total: ${Total}"$) Else Log("Sum column failed")  
  
End Sub  
  
  
  
Private Sub DB_CountRows(Count As Int, Success As Boolean)  
  
If Success Then Log($"Row count: ${Count}"$) Else Log("Count rows failed")  
  
End Sub  
  
  
  
Private Sub DB_CountValue(Count As Int, Success As Boolean)  
  
If Success Then Log($"Value count: ${Count}"$) Else Log("Count value failed")  
  
End Sub  
  
  
  
Private Sub DB_CreateTable(TableName As String, Success As Boolean)  
  
If Success Then Log($"Table created: ${TableName}"$) Else Log("Create table failed")  
  
End Sub  
  
  
  
Private Sub DB_CreateColumn(TableName As String, Success As Boolean)  
  
If Success Then Log($"Column added to: ${TableName}"$) Else Log("Create column failed")  
  
End Sub  
  
  
  
Private Sub DB_DeleteColumn(TableName As String, Success As Boolean)  
  
If Success Then Log($"Column deleted from: ${TableName}"$) Else Log("Delete column failed")  
  
End Sub  
  
  
  
Private Sub DB_CustomQuery(Result As List, Success As Boolean)  
  
If Success Then  
  
For Each row As Map In Result  
  
Log($"Query result: ${row}"$)  
  
Next  
  
Else  
  
Log("Custom query failed")  
  
End If  
  
End Sub  
  
  
  
Private Sub DB_DeleteTable(TableName As String, Success As Boolean)  
  
If Success Then Log($"Table dropped: ${TableName}"$) Else Log("Delete table failed")  
  
End Sub  
  
  
  
Private Sub DB_JoinTables(Result As List, Success As Boolean)  
  
If Success Then  
  
For Each row As Map In Result  
  
Log($"Join result: ${row}"$)  
  
Next  
  
Else  
  
Log("Join tables failed")  
  
End If  
  
End Sub  
  
  
  
Private Sub DB_FilterJoinTables(Result As List, Success As Boolean)  
  
If Success Then  
  
For Each row As Map In Result  
  
Log($"Filtered join result: ${row}"$)  
  
Next  
  
Else  
  
Log("Filter join tables failed")  
  
End If  
  
End Sub  
  
  
  
Private Sub DB_GetTableSchema(Result As List, Success As Boolean)  
  
If Success Then  
  
For Each col As Map In Result  
  
Log($"Column: ${col}"$)  
  
Next  
  
Else  
  
Log("Get table schema failed")  
  
End If  
  
End Sub  
  
  
  
Private Sub DB_ExistsTable(Exists As Boolean, Success As Boolean)  
  
If Success Then Log($"Table exists: ${Exists}"$) Else Log("Exists table failed")  
  
End Sub  
  
  
  
Private Sub DB_GetPercentage(Percentage As Double, Success As Boolean)  
  
If Success Then Log($"Percentage: ${Percentage}"$) Else Log("Get percentage failed")  
  
End Sub
```

  
  
  
  
  
  

---

  
  
  
**🎉 Implementation Tips**  
  
  
  

- **Flexibility**: Use the dbname parameter in the URL to connect to any database (e.g., <http://localhost/api.php?dbname=my_database>).
- **Testing**: Test cURL calls with Postman or a terminal. In B4X, include DatabaseAPI.bas in your project.
- **Errors**: Ensure XAMPP is running, api.php is in htdocs, and the database exists.
- **Security**: Use a strong API key, enable HTTPS, and restrict MySQL permissions for enhanced protection.
- **Customization**: Adjust the URL and API key to match your environment.

  
  
  
  
## Methods  
  
  
  
Insertmaps(maps As Map, tablename As String)  
  
  
  
Performs an insertion operation on the specified table of the API.  
  

```B4X
Dim data As Map  
  
data.Initialize  
  
data.Put("Column1", "Value1")  
  
data.Put("Column2", "Value2")  
  
MagicApi.Insertmaps(data, "table")
```

  
  
  
  
Delete(tablename As String, id As String)  
Deletes a record from the specified table of the API using the ID.  
  

```B4X
MagicApi.Delete("table", "12")
```

  
  
  
  
DeleteByColumn(tablename As String, column As String, value As String)  
Deletes records from the specified table of the API using a column and a value.  
  

```B4X
MagicApi.DeleteByColumn("table", "column", "value")
```

  
  
  
  
DeleteByColumn\_comparison(tablename As String, column As String, value As String,comparison As String)  
Deletes records from the specified table of the API using a column and a value and comparison <,>,<=,>=.  
  

```B4X
MagicApi.DeleteByColumn_comparison("table", "age", "20",">")
```

  
  
  
  
Update(tablename As String, id As String, data As Map)  
Updates a record in the specified table of the API using the ID and the provided data.  
  

```B4X
Dim data As Map  
  
data.Initialize  
  
data.Put("Column1", "NewValue1")  
  
data.Put("Column2", "NewValue2")  
  
MagicApi.Update("table", "12", data)
```

  
  
  
  
UpdateByColumn(tablename As String, column As String, value As String, data As Map)  
Updates records in the specified table of the API using a column, a value, and the provided data.  
  

```B4X
Dim data As Map  
  
data.Initialize  
  
data.Put("Column1", "NewValue1")  
  
data.Put("Column2", "NewValue2")  
  
MagicApi.UpdateByColumn("table", "column", "value", data)
```

  
  
  
  
UpdateByColumn\_comparison(tablename As String, column As String, value As String,comparison As String, data As Map)  
Updates records in the specified table of the API using a column, a value, and the provided data and comparison <,>,>=,<=.  
  

```B4X
Dim data As Map  
  
data.Initialize  
  
data.Put("Column1", "NewValue1")  
  
data.Put("Column2", "NewValue2")  
  
MagicApi.UpdateByColumn_comparison("table", "age", "15",">=", data)
```

  
  
  
  
SearchforId(tablename As String, id As String)  
Searches for a record in the specified table of the API using the ID.  
  

```B4X
'  
  
MagicApi.SearchforId("table", "123")  
  
wait for eventname_SearchforId(m As Map, success As Boolean)  
  
if success = true then  
  
m.get("Column 1")  
  
m.get("Column 2")  
  
else  
  
  
  
end if
```

  
  
  
  
GetTable(tablename As String)  
Gets all records from the specified table of the API.  
  

```B4X
MagicApi.GetTable("table")  
  
Wait For eventname_GetTable(x As List, success As Boolean)  
  
    For Each col As Map In x  
  
        col.Get("Column name1")  
  
        col.Get("Column name 2")  
  
    Next
```

  
  
  
  
Search(tablename As String, column As String, value As String)  
Performs a search in the specified table of the API using a column and a value.  
  

```B4X
MagicApi.Search("table", "column", "value")  
  
wait for EventName_Search(x as list, success as Boolean)  
  
if success = true then  
  
 For Each col As Map In x  
  
col.Get("Column name1")  
  
col.Get("Column name 2")  
  
next  
  
else  
  
  
  
end if  
  
  
  
sub
```

  
  
  
  
  
  
Search\_comparison(tablename As String, column As String, value As String,comparison As String)  
Performs a search in the specified table of the API using a column and a value and comparison.  
  

```B4X
MagicApi.Search_comparison("table", "age", "35","<=")  
  
wait for EventName_Search(x as list, success as Boolean)  
  
if success = true then  
  
 For Each col As Map In x  
  
col.Get("Column name1")  
  
col.Get("Column name 2")  
  
next  
  
else  
  
  
  
end if  
  
  
  
sub
```

  
  
  
  
  
  
Complete Example  
  
  

```B4X
Sub Process_Globals  
  
    Private magicApi As MagicApi  
  
End Sub  
  
  
  
Sub Globals  
  
    ' …  
  
End Sub  
  
  
  
Sub Activity_Create(FirstTime As Boolean)  
  
    ' …  
  
    magicApi.Initialize(Me, "MyEventName", "http://example.com")  
  
End Sub  
  
  
  
' Implement the events generated by the library  
  
Sub MyEventName_Insertmaps(m As Map, success As Boolean)  
  
    ' …  
  
End Sub  
  
  
  
Sub MyEventName_Delete(tablename As String, success As Boolean)  
  
    ' …  
  
End Sub  
  
  
  
' Implement other generated events…  
  
  
  
Sub SomeSub  
  
    ' Examples of using the library methods  
  
    Dim data As Map  
  
    data.Initialize  
  
    data.Put("Column1", "Value1")  
  
    data.Put("Column2", "Value2")  
  
    magicApi.Insertmaps(data, "table")  
  
  
  
    magicApi.Delete("table", "123")  
  
  
  
    magicApi.DeleteByColumn("table", "column", "value")  
  
  
  
    Dim updateData As Map  
  
    updateData.Initialize  
  
    updateData.Put("Column1", "NewValue1")  
  
    updateData.Put("Column2", "NewValue2")  
  
    magicApi.Update("table", "123", updateData)  
  
  
  
    magicApi.UpdateByColumn("table", "column", "value", updateData)  
  
  
  
    magicApi.SearchforId("table", "123")  
  
  
  
    magicApi.GetTable("table")  
  
  
  
    magicApi.Search("table", "column", "value")  
  
End Sub
```

  
  
  
  
  
  
MagicAPI Module - New Routines  
1. InsertOrUpdateMapForColumnValue  
Description:  
  
This routine checks whether a record exists in the specified table by searching for a column value. If the record exists, it updates the record; if not, it inserts a new record.  
  
  
  
Parameters:  
  
  
  
tablename (String): The name of the table where the operation will take place.  
searchColumn (String): The column used for the search.  
searchValue (String): The value to look for in the searchColumn.  
data (Map): The data to insert or update.  
Event Triggered:  
  
<EventName>\_InsertOrUpdateMapForColumnValue(message As String, success As Boolean)  
  
  
  
message can be "Insert", "Update", or "Error".  
success indicates if the operation was successful.  
Example 1: Insert or Update a User Record  
  
  
  

```B4X
Dim userData As Map  
  
userData.Initialize  
  
userData.Put("name", "John Doe")  
  
userData.Put("email", "john.doe@example.com")  
  
userData.Put("age", 30)  
  
  
  
MagicAPI.InsertOrUpdateMapForColumnValue("users", "email", "john.doe@example.com", userData)  
  
  
  
Wait For MagicAPI_InsertOrUpdateMapForColumnValue(message As String, success As Boolean)  
  
  
  
If success Then  
  
Select Case message  
  
Case "Insert" Log("A new user record was inserted.")  
  
Case "Update" Log("The existing user record was updated.")  
  
End Select  
  
Else Log("Error: Unable to perform the operation.")  
  
End If
```

  
  
  
  
Example 2: Insert or Update a Product Record  
  
  
  

```B4X
Dim productData As Map  
  
productData.Initialize  
  
productData.Put("name", "Wireless Mouse")  
  
productData.Put("price", 29.99)  
  
productData.Put("stock", 100)  
  
  
  
MagicAPI.InsertOrUpdateMapForColumnValue("products", "name", "Wireless Mouse", productData)  
  
  
  
Wait For MagicAPI_InsertOrUpdateMapForColumnValue(message As String, success As Boolean)  
  
  
  
If success Then  
  
Select Case message  
  
Case "Insert"  
  
Log("A new product record was inserted.")  
  
Case "Update"  
  
Log("The existing product record was updated.")  
  
End Select  
  
Else Log("Error: Unable to perform the operation.")  
  
End If
```

  
  
  
  
2. InsertMultipleMaps  
Description:  
  
This routine inserts multiple records into the specified table using a list of maps, where each map represents a record.  
  
  
  
Parameters:  
  
  
  
ListOfMaps (List): A list of maps containing the data to insert. Each map represents one record.  
TableName (String): The name of the table where the records will be inserted.  
Event Triggered:  
  
<EventName>\_Insertmaps(m As Map, success As Boolean)  
  
  
  
m: The map representing the data that was inserted.  
success: Indicates if the operation was successful.  
Example 1: Insert Multiple User Records  
  
  
  

```B4X
Dim userRecords As List  
  
userRecords.Initialize  
  
  
  
Dim user1 As Map  
  
user1.Initialize  
  
user1.Put("name", "Alice")  
  
user1.Put("email", "alice@example.com")  
  
user1.Put("age", 25)  
  
  
  
Dim user2 As Map  
  
user2.Initialize  
  
user2.Put("name", "Bob")  
  
user2.Put("email", "bob@example.com")  
  
user2.Put("age", 28)  
  
  
  
userRecords.AddAll(Array(user1, user2))  
  
  
  
MagicAPI.InsertMultipleMaps(userRecords, "users")  
  
  
  
Wait For MagicAPI_Insertmaps(m As Map, success As Boolean)  
  
  
  
If success Then  
  
Log($"Record inserted: ${m}"$)  
  
Else Log("Error inserting record.")  
  
End If
```

  
  
  
  
Example 2: Insert Multiple Product Records  
  
  
  

```B4X
Dim productRecords As List  
  
productRecords.Initialize  
  
  
  
Dim product1 As Map  
  
product1.Initialize  
  
product1.Put("name", "Keyboard")  
  
product1.Put("price", 49.99)  
  
product1.Put("stock", 50)  
  
  
  
Dim product2 As Map  
  
product2.Initialize  
  
product2.Put("name", "Monitor")  
  
product2.Put("price", 199.99)  
  
product2.Put("stock", 20)  
  
  
  
productRecords.AddAll(Array(product1, product2))  
  
  
  
MagicAPI.InsertMultipleMaps(productRecords, "products")  
  
  
  
Wait For MagicAPI_Insertmaps(m As Map, success As Boolean)  
  
  
  
If success Then  
  
Log($"Record inserted: ${m}"$)  
  
Else  
  
Log("Error inserting record.")  
  
End If
```

  
  
  
  
Notes  
Both routines provide asynchronous operations, and results are returned via their respective events.  
Error handling is embedded, and failed operations trigger the appropriate event with a success = False.  
Ensure the data maps are properly initialized and contain valid column names and values for the target table.  
  
  
**[SIZE=6]MagicApi library[/SIZE]**  
# B4X Library Documentation  
  
**## Description**  
This library provides methods for performing CRUD (Create, Read, Update, Delete) operations on an API. It is designed to interact with an API that uses JSON as the data exchange format.  
  
**## Installation**  
1. Download the **MagicApi.b4xlib** library file.  
2. Copy the **MagicApi.b4xlib** file to the additional libraries folder in your B4X development environment.  
  
**## Initialization**  
Before using the library methods, you need to initialize it by calling the `Initialize` method and providing the following parameters:  
- `CallbackModule` (Object): the name of the callback module where the events handling API responses are located.  
- `cEventname` (String): the base name for the response events.  
- `urlbase` (String): the base URL of the API.  
- `api\_key` (String): The api key defined in the php file.  
  
**## Events**  
The library generates response events for each CRUD operation. These events should be implemented in the specified callback module during initialization.  
  
**### Generated Events**  
- `EventName\_Insertmaps(m As Map, success As Boolean)`  
- `EventName\_Delete(tablename As String, success As Boolean)`  
- `EventName\_DeleteByColumn(tablename As String, success As Boolean)`  
- `EventName\_Update(tablename As String, success As Boolean)`  
- `EventName\_UpdateByColumn(tablename As String, success As Boolean)`  
- `EventName\_SearchforId(m As Map, success As Boolean)`  
- `EventName\_GetTable(x As List, success As Boolean)`  
- `EventName\_Search(x As List, success As Boolean)`  
  
**## Methods  
  
[SIZE=5]Insertmaps(maps As Map, tablename As String)[/SIZE]**  
  
Performs an insertion operation on the specified table of the API.  

```B4X
Dim data As Map  
data.Initialize  
data.Put("Column1", "Value1")  
data.Put("Column2", "Value2")  
MagicApi.Insertmaps(data, "table")
```

  
  
[HEADING=2]Delete(tablename As String, id As String)[/HEADING]  
Deletes a record from the specified table of the API using the ID.  

```B4X
MagicApi.Delete("table", "12")
```

  
  
[HEADING=2]DeleteByColumn(tablename As String, column As String, value As String)[/HEADING]  
Deletes records from the specified table of the API using a column and a value.  

```B4X
MagicApi.DeleteByColumn("table", "column", "value")
```

  
  
[HEADING=2]DeleteByColumn\_comparison(tablename As String, column As String, value As String,comparison As String)[/HEADING]  
Deletes records from the specified table of the API using a column and a value and comparison <,>,<=,>=.  

```B4X
MagicApi.DeleteByColumn_comparison("table", "age", "20",">")
```

  
  
[HEADING=2]Update(tablename As String, id As String, data As Map)[/HEADING]  
Updates a record in the specified table of the API using the ID and the provided data.  

```B4X
Dim data As Map  
data.Initialize  
data.Put("Column1", "NewValue1")  
data.Put("Column2", "NewValue2")  
MagicApi.Update("table", "12", data)
```

  
  
[HEADING=2]UpdateByColumn(tablename As String, column As String, value As String, data As Map)[/HEADING]  
Updates records in the specified table of the API using a column, a value, and the provided data.  

```B4X
Dim data As Map  
data.Initialize  
data.Put("Column1", "NewValue1")  
data.Put("Column2", "NewValue2")  
MagicApi.UpdateByColumn("table", "column", "value", data)
```

  
  
[HEADING=2]UpdateByColumn\_comparison(tablename As String, column As String, value As String,comparison As String, data As Map)[/HEADING]  
Updates records in the specified table of the API using a column, a value, and the provided data and comparison <,>,>=,<=.  

```B4X
Dim data As Map  
data.Initialize  
data.Put("Column1", "NewValue1")  
data.Put("Column2", "NewValue2")  
MagicApi.UpdateByColumn_comparison("table", "age", "15",">=", data)
```

  
  
[HEADING=2]SearchforId(tablename As String, id As String)[/HEADING]  
Searches for a record in the specified table of the API using the ID.  

```B4X
'  
MagicApi.SearchforId("table", "123")  
wait for eventname_SearchforId(m As Map, success As Boolean)  
if success = true then  
m.get("Column 1")  
m.get("Column 2")  
else  
  
end if
```

  
  
[HEADING=2]GetTable(tablename As String)[/HEADING]  
Gets all records from the specified table of the API.  

```B4X
MagicApi.GetTable("table")  
Wait For eventname_GetTable(x As List, success As Boolean)  
    For Each col As Map In x  
        col.Get("Column name1")  
        col.Get("Column name 2")  
    Next
```

  
  
[HEADING=2]Search(tablename As String, column As String, value As String)[/HEADING]  
Performs a search in the specified table of the API using a column and a value.  

```B4X
MagicApi.Search("table", "column", "value")  
wait for EventName_Search(x as list, success as Boolean)  
if success = true then  
 For Each col As Map In x  
col.Get("Column name1")  
col.Get("Column name 2")  
next  
else  
  
end if  
  
sub
```

  
  
  
[HEADING=2]Search\_comparison(tablename As String, column As String, value As String,comparison As String)[/HEADING]  
Performs a search in the specified table of the API using a column and a value and comparison.  

```B4X
MagicApi.Search_comparison("table", "age", "35","<=")  
wait for EventName_Search(x as list, success as Boolean)  
if success = true then  
 For Each col As Map In x  
col.Get("Column name1")  
col.Get("Column name 2")  
next  
else  
  
end if  
  
sub
```

  
  
  
[HEADING=1]Complete Example[/HEADING]  
  

```B4X
Sub Process_Globals  
    Private magicApi As MagicApi  
End Sub  
  
Sub Globals  
    ' …  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    ' …  
    magicApi.Initialize(Me, "MyEventName", "http://example.com")  
End Sub  
  
' Implement the events generated by the library  
Sub MyEventName_Insertmaps(m As Map, success As Boolean)  
    ' …  
End Sub  
  
Sub MyEventName_Delete(tablename As String, success As Boolean)  
    ' …  
End Sub  
  
' Implement other generated events…  
  
Sub SomeSub  
    ' Examples of using the library methods  
    Dim data As Map  
    data.Initialize  
    data.Put("Column1", "Value1")  
    data.Put("Column2", "Value2")  
    magicApi.Insertmaps(data, "table")  
  
    magicApi.Delete("table", "123")  
  
    magicApi.DeleteByColumn("table", "column", "value")  
  
    Dim updateData As Map  
    updateData.Initialize  
    updateData.Put("Column1", "NewValue1")  
    updateData.Put("Column2", "NewValue2")  
    magicApi.Update("table", "123", updateData)  
  
    magicApi.UpdateByColumn("table", "column", "value", updateData)  
  
    magicApi.SearchforId("table", "123")  
  
    magicApi.GetTable("table")  
  
    magicApi.Search("table", "column", "value")  
End Sub
```

  
  
  
[HEADING=1]**MagicAPI Module - New Routines**[/HEADING]  
[HEADING=2]**1. InsertOrUpdateMapForColumnValue**[/HEADING]  
**Description**:  
This routine checks whether a record exists in the specified table by searching for a column value. If the record exists, it updates the record; if not, it inserts a new record.  
  
**Parameters**:  
  

- tablename (String): The name of the table where the operation will take place.
- searchColumn (String): The column used for the search.
- searchValue (String): The value to look for in the searchColumn.
- data (Map): The data to insert or update.

**Event Triggered**:  
<EventName>\_InsertOrUpdateMapForColumnValue(message As String, success As Boolean)  
  

- message can be "Insert", "Update", or "Error".
- success indicates if the operation was successful.

---

  
**Example 1: Insert or Update a User Record**  
  

```B4X
Dim userData As Map  
userData.Initialize  
userData.Put("name", "John Doe")  
userData.Put("email", "john.doe@example.com")  
userData.Put("age", 30)  
  
MagicAPI.InsertOrUpdateMapForColumnValue("users", "email", "john.doe@example.com", userData)  
  
Wait For MagicAPI_InsertOrUpdateMapForColumnValue(message As String, success As Boolean)  
  
If success Then  
Select Case message  
Case "Insert" Log("A new user record was inserted.")  
Case "Update" Log("The existing user record was updated.")  
End Select  
Else Log("Error: Unable to perform the operation.")  
End If
```

  
  

---

  
**Example 2: Insert or Update a Product Record**  
  

```B4X
Dim productData As Map  
productData.Initialize  
productData.Put("name", "Wireless Mouse")  
productData.Put("price", 29.99)  
productData.Put("stock", 100)  
  
MagicAPI.InsertOrUpdateMapForColumnValue("products", "name", "Wireless Mouse", productData)  
  
Wait For MagicAPI_InsertOrUpdateMapForColumnValue(message As String, success As Boolean)  
  
If success Then  
Select Case message  
Case "Insert"  
Log("A new product record was inserted.")  
Case "Update"  
Log("The existing product record was updated.")  
End Select  
Else Log("Error: Unable to perform the operation.")  
End If
```

  
  

---

  
[HEADING=2]**2. InsertMultipleMaps**[/HEADING]  
**Description**:  
This routine inserts multiple records into the specified table using a list of maps, where each map represents a record.  
  
**Parameters**:  
  

- ListOfMaps (List): A list of maps containing the data to insert. Each map represents one record.
- TableName (String): The name of the table where the records will be inserted.

**Event Triggered**:  
<EventName>\_Insertmaps(m As Map, success As Boolean)  
  

- m: The map representing the data that was inserted.
- success: Indicates if the operation was successful.

---

  
**Example 1: Insert Multiple User Records**  
  

```B4X
Dim userRecords As List  
userRecords.Initialize  
  
Dim user1 As Map  
user1.Initialize  
user1.Put("name", "Alice")  
user1.Put("email", "alice@example.com")  
user1.Put("age", 25)  
  
Dim user2 As Map  
user2.Initialize  
user2.Put("name", "Bob")  
user2.Put("email", "bob@example.com")  
user2.Put("age", 28)  
  
userRecords.AddAll(Array(user1, user2))  
  
MagicAPI.InsertMultipleMaps(userRecords, "users")  
  
Wait For MagicAPI_Insertmaps(m As Map, success As Boolean)  
  
If success Then  
Log($"Record inserted: ${m}"$)  
Else Log("Error inserting record.")  
End If
```

  
  

---

  
**Example 2: Insert Multiple Product Records**  
  

```B4X
Dim productRecords As List  
productRecords.Initialize  
  
Dim product1 As Map  
product1.Initialize  
product1.Put("name", "Keyboard")  
product1.Put("price", 49.99)  
product1.Put("stock", 50)  
  
Dim product2 As Map  
product2.Initialize  
product2.Put("name", "Monitor")  
product2.Put("price", 199.99)  
product2.Put("stock", 20)  
  
productRecords.AddAll(Array(product1, product2))  
  
MagicAPI.InsertMultipleMaps(productRecords, "products")  
  
Wait For MagicAPI_Insertmaps(m As Map, success As Boolean)  
  
If success Then  
Log($"Record inserted: ${m}"$)  
Else  
Log("Error inserting record.")  
End If
```

  
  

---

  
[HEADING=2]**Notes**[/HEADING]  

- Both routines provide asynchronous operations, and results are returned via their respective events.
- Error handling is embedded, and failed operations trigger the appropriate event with a success = False.
- Ensure the data maps are properly initialized and contain valid column names and values for the target table.

  
  
[HEADING=1]**MagicFiles Module Documentation**[/HEADING]  
The MagicFiles module is part of the **Magic API** library, designed to facilitate file and folder operations on a server via REST API. It supports functionalities such as uploading, downloading, listing, and deleting files or folders, and is compatible with file selection using ContentChooser in B4A.  
  

---

  
[HEADING=2]**Initialization**[/HEADING]  
[HEADING=3]**1. Initialize**[/HEADING]  
Initializes the MagicFiles module with the necessary parameters to interact with the server.  
  
**Parameters**:  
  

- Callback (Object): The object handling the event callbacks.
- EventName (String): The name of the event that will be triggered upon completion.
- urlbase (String): The base URL of the file server.

```B4X
Dim magicFiles As MagicFiles  
magicFiles.Initialize(Me, "MagicFiles", "https://example.com/api")
```

  
  

---

  
[HEADING=2]**File Operations**[/HEADING]  
[HEADING=3]**2. UploadFile**[/HEADING]  
Uploads a file to the server.  
  
**Parameters**:  
  

- filedir (String): Directory of the file.
- filename (String): Name of the file to upload.

**Event**: <EventName>\_UploadResult(Success As Boolean, FileName As String)  
  

```B4X
magicFiles.UploadFile(File.DirRootExternal, "test.txt")  
  
Sub MagicFiles_UploadResult(Success As Boolean, FileName As String)  
If Success Then  
Log($"File ${FileName} uploaded successfully"$)  
Else  
Log("Error uploading file")  
End If  
End Sub
```

  
  

---

  
[HEADING=3]**3. UploadFileToFolder**[/HEADING]  
Uploads a file to a specific folder on the server.  
  
**Parameters**:  
  

- filedir (String): Directory of the file.
- filename (String): Name of the file to upload.
- targetFolder (String): Destination folder on the server.
- newFileName (String): New name for the file on the server.

**Event**: <EventName>\_UploadToFolderResult(Success As Boolean, FileName As String)  
  

```B4X
magicFiles.UploadFileToFolder(File.DirRootExternal, "test.txt", "myFolder", "renamed.txt")  
  
Sub MagicFiles_UploadToFolderResult(Success As Boolean, FileName As String)  
If Success Then  
Log($"File ${FileName} uploaded to folder successfully"$)  
Else  
Log("Error uploading file to folder")  
End If  
End Sub
```

  
  

---

  
[HEADING=3]**4. UploadFileUri (B4A)**[/HEADING]  
Uploads a file selected using ContentChooser to the server with a custom name.  
  
**Parameters**:  
  

- uri (String): URI of the selected file.
- newFileName (String): Name to save the file as on the server.

**Event**: <EventName>\_UploadResultUri(Success As Boolean, FileName As String)  
  

```B4X
Private Sub Button1_Click  
If chooser.IsInitialized = False Then  
chooser.Initialize("chooser")  
End If  
chooser.Show("image/*", "Choose Image")  
End Sub  
  
Sub chooser_Result(Success As Boolean, Dir As String, FileName As String)  
If Success Then  
magicFiles.UploadFileUri(FileName, "uploaded_image.jpg")  
Else Log("No file selected")  
End If  
End Sub  
  
Sub MagicFiles_UploadResultUri(Success As Boolean, FileName As String)  
If Success Then  
Log($"File ${FileName} uploaded successfully"$)  
Else  
Log("Error uploading file")  
End If  
End Sub
```

  
  

---

  
[HEADING=3]**5. UploadFileUri2 (B4A)**[/HEADING]  
Uploads a file selected using ContentChooser by directly using its full path.  
  
**Parameters**:  
  

- uri (String): URI of the selected file.

**Event**: <EventName>\_UploadResultUri2(Success As Boolean, FileName As String)  
  

```B4X
Private Sub Button1_Click  
If chooser.IsInitialized = False Then  
chooser.Initialize("chooser")  
End If  
chooser.Show("/", "Choose File")  
End Sub  
  
Sub chooser_Result(Success As Boolean, Dir As String, FileName As String)  
If Success Then  
magicFiles.UploadFileUri2(FileName)  
Else  
Log("No file selected")  
End If  
End Sub  
  
Sub MagicFiles_UploadResultUri2(Success As Boolean, FileName As String)  
If Success Then  
Log($"File ${FileName} uploaded successfully with UploadFileUri2"$)  
Else  
Log("Error uploading file with UploadFileUri2")  
End If  
End Sub
```

  
  

---

  
[HEADING=3]**6. ListFiles**[/HEADING]  
Lists all files available on the server.  
  
**Event**: <EventName>\_ListSuccess(Success As Boolean, ListFiles As List)  
  

```B4X
magicFiles.ListFiles  
  
Sub MagicFiles_ListSuccess(Success As Boolean, ListFiles As List)  
If Success Then  
For Each fileName As String In ListFiles  
Log($"File: ${fileName}"$)  
Next  
Else Log("Error listing files")  
End If  
End Sub
```

  
  

---

  
[HEADING=3]**7. DeleteFile**[/HEADING]  
Deletes a file from the server.  
  
**Parameters**:  
  

- fileName (String): Name of the file to delete.

**Event**: <EventName>\_DeleteFileSuccess(Success As Boolean, FileName As String)  
  

```B4X
magicFiles.DeleteFile("test.txt")  
  
Sub MagicFiles_DeleteFileSuccess(Success As Boolean, FileName As String)  
If Success Then  
Log($"File ${FileName} deleted successfully"$)  
Else  
Log("Error deleting file")  
End If  
End Sub
```

  
  

---

  
[HEADING=3]**8. DeleteAllFiles**[/HEADING]  
Deletes all files from the server.  
  
**Event**: <EventName>\_DeleteAllSuccess(Success As Boolean)  
  

```B4X
magicFiles.DeleteAllFiles  
  
Sub MagicFiles_DeleteAllSuccess(Success As Boolean)  
If Success Then  
Log("All files deleted successfully")  
Else  
Log("Error deleting all files")  
End If  
End Sub
```

  
  

---

  
[HEADING=2]**Folder Operations**[/HEADING]  
[HEADING=3]**9. CreateFolder**[/HEADING]  
Creates a new folder on the server.  
  
**Parameters**:  
  

- FolderName (String): Name of the folder to create.

**Event**: <EventName>\_CreateFolderSuccess(Success As Boolean, FolderName As String)  
  

```B4X
magicFiles.CreateFolder("newFolder")  
  
Sub MagicFiles_CreateFolderSuccess(Success As Boolean, FolderName As String)  
If Success Then  
Log($"Folder ${FolderName} created successfully"$)  
Else  
Log("Error creating folder")  
End If  
End Sub
```

  
  

---

  
[HEADING=3]**10. MoveFileToFolder**[/HEADING]  
Moves a file to another folder on the server.  
  
**Parameters**:  
  

- FileName (String): Name of the file to move.
- TargetFolder (String): Destination folder.

**Event**: <EventName>\_MoveFileSuccess(Success As Boolean, TargetFolder As String)  
  

```B4X
magicFiles.MoveFileToFolder("test.txt", "destinationFolder")  
  
Sub MagicFiles_MoveFileSuccess(Success As Boolean, TargetFolder As String)  
If Success Then  
Log($"File moved to folder ${TargetFolder} successfully"$)  
Else  
Log("Error moving file")  
End If  
End Sub
```

  
  
[HEADING=2]11. DownloadFile[/HEADING]  
Downloads a file from a server folder to a local directory.  
  
**Parameters:**  
  

- **TargetFolder (String):** Folder on the server where the file is located.
- **FileName (String):** Name of the file to download.
- **SaveDir (String):** Local directory where the file will be saved.
- **SaveFileName (String):** Name to save the file as locally.

**Event:** <EventName>\_DownloadResult(Success As Boolean, FileName As String)  
  

```B4X
magicFiles.DownloadFile("ServerFolder", "example.txt", File.DirRootExternal, "downloaded_example.txt")  
  
Sub MagicFiles_DownloadResult(Success As Boolean, FileName As String)  
If Success Then  
Log($"File ${FileName} downloaded successfully."$)  
Else  
Log($"Error downloading the file: ${FileName}"$)  
End If  
End Sub
```

  
  

---

  
[HEADING=2]12. DownloadFile2[/HEADING]  
Downloads a file from the server with range and progress tracking support.  
  
**Parameters:**  
  

- **Dir (String):** Folder on the server where the file is located.
- **FileName (String):** Name of the file to download.
- **SaveDir (String):** Local directory where the file will be saved.
- **SaveFileName (String):** Name to save the file as locally.

**Events:**  
  

- <EventName>\_DownloadProgress(CurrentLength As Long, TotalLength As Long)
- <EventName>\_DownloadResult(Success As Boolean, FileName As String)

```B4X
magicFiles.DownloadFile2("ServerFolder", "largefile.zip", File.DirRootExternal, "largefile_local.zip")  
  
Sub MagicFiles_DownloadProgress(CurrentLength As Long, TotalLength As Long)  
Dim Progress As Float = (CurrentLength / TotalLength) * 100  
Log($"Progress: ${Progress}%"$)  
End Sub  
  
Sub MagicFiles_DownloadResult(Success As Boolean, FileName As String)  
If Success Then  
Log($"File ${FileName} downloaded successfully."$)  
Else  
Log($"Error downloading the file: ${FileName}"$)  
End If  
End Sub
```

  
  

---

  
  
  
[HEADING=2]📂 **Important Update for Magic API File Management** 🚀[/HEADING]  
We’re introducing an **enhanced file and folder management system** with the latest version of Magic API! Here's how it works:  
  

---

  
[HEADING=2]**File and Folder Operations in Magic API**[/HEADING]  
1️⃣ **Default Folder: upload**  
  

- All files and folders you create or interact with will be managed inside a new folder named **upload**.
- This folder will be **automatically created** the first time you upload a file.

📍 **Location**: The upload folder will be created in the same directory as the files.php script on your server.  
  

---

  
2️⃣ **Automatic Folder Creation**  
  

- When you add a file to a specific folder, Magic API will **automatically create the folder** if it doesn’t already exist.
- This ensures seamless operations, eliminating the need for manual folder setup.

---

  
[HEADING=2]**Examples**[/HEADING]  
[HEADING=3]**Uploading a File to the Default Folder**[/HEADING]  
When uploading a file without specifying a folder, it will be stored directly in the **upload** folder.  
  

```B4X
MagicFiles.UploadFile(File.DirRootExternal, "example.txt")  
  
Wait For MagicFiles_UploadResult(Success As Boolean, FileName As String)  
  
If Success Then  
Log($"File ${FileName} uploaded successfully to the 'upload' folder."$)  
Else  
Log("Error uploading the file.")  
End If
```

  
  

---

  
[HEADING=3]**Uploading a File to a Specific Folder**[/HEADING]  
If you specify a folder, Magic API will automatically create it if it doesn’t exist.  
  

```B4X
MagicFiles.UploadFileToFolder(File.DirRootExternal, "document.pdf", "tasks", "report.pdf")  
  
Wait For MagicFiles_UploadToFolderResult(Success As Boolean, FileName As String)  
  
If Success Then  
Log($"File ${FileName} uploaded successfully to the 'tasks' folder."$)  
Else  
Log("Error uploading the file.")  
End If
```

  
  

---

  
[HEADING=2]**Why This Update?**[/HEADING]  
✅ **Automated Management**: No need to manually create folders. Magic API does it for you!  
✅ **Simplified Operations**: Focus on your app logic while the API handles the backend file structure.  
✅ **Consistency**: All file operations are neatly organized within the upload folder.  
  

---

  
[HEADING=2]**Note**[/HEADING]  

- All file and folder operations (e.g., uploading, deleting, listing) will now occur inside the **upload** folder for better organization and security.
- If you interact with a folder that doesn’t exist, it will be created automatically.

  
  
? [Download Magic API Now](https://b4xapp.com/item/magic-api-)  
  
Thank you for your enthusiasm and support. Let the Magic API transform your B4X applications into powerful, connected experiences! ?✨