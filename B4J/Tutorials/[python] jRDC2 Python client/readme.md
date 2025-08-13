### [python] jRDC2 Python client by Erel
### 01/15/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/165111/)

Start here: <https://www.b4x.com/android/forum/threads/python-b4xserializator-implementation-in-python.165109/>  
  
Depends on: pip install requests  
  
Example:  

```B4X
from db_request_manager import DBRequestManager, DBCommand  
  
  
if __name__ == '__main__':  
 req = DBRequestManager(connector_link="http://127.0.0.1:17178/rdc")  
 req.execute_batch([DBCommand("create_table", ())])  
 print("table created successfully")  
 commands = []  
 with open(r"C:\Users\H\Downloads\1.jpg", "rb") as f:  
        image_dat = f.read()  
 for i in range(100):  
     commands.append(DBCommand("insert_animal", (f"animal #{i + 1}", image_dat)))  
 req.execute_batch(commands)  
 res = req.execute_query(DBCommand("select_animal", (10,)))  
 req.print_table(res)
```

  
  
Note that unlike the B4X clients, this client is synchronous. This is suitable for console based solutions.