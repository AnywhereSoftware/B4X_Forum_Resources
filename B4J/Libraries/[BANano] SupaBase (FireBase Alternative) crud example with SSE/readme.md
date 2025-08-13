### [BANano] SupaBase (FireBase Alternative) crud example with SSE by Mashiane
### 05/13/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/144817/)

Hi  
  
Supabase is an open source Firebase alternative. It provides all the backend services you need to build a product. Supabase uses Postgres database with real-time capabilities. Basically, supabase provides an interface to manage postgres database that you can use to create table and insert, edit and delete data in the table.  
  
We can use REST API or client libraries from supabase to access the data in the postgres database. Supabase is not just about accessing the database. it also provides some solutions out of the box such as Authentication, File Storage and Real-time capabilities.  
  
For this example we will use the javascript sdk. I am using this for the SithasoDaisy framework.  
  
First things first  
  
1. Sign Up  
  
<https://supabase.com/>  
  
2. [Get the JavaScript SDK and include in your project.](https://supabase.com/docs/reference/javascript/installing)  
  
You will use the CDN version in this section  
  
![](https://www.b4x.com/android/forum/attachments/153668)  
  
Add this to your BANano project, in the Main code module using  
  

```B4X
BANano.Header.AddJavascriptFile("SUPABASE SDK URL LINK")/
```

  
  
3. Create a project.  
  
4. Create a table with columns.  
  
5. Get your keys…  
  
![](https://www.b4x.com/android/forum/attachments/136988)  
  
We have a table called books with a few fields. You can create any schema you want.  
  
![](https://www.b4x.com/android/forum/attachments/136989)  
  
  
We initialize the class:  
  

```B4X
'SELECT_ALL  
    Dim supabase As SDUISupaBase  
    supabase.Initialize(Me, "supabase", my_url, my_key)  
    supabase.TableName = "books"
```

  
  
**Related Content**  
  
Supabase Crash Course  
  
[MEDIA=youtube]list=PL4cUxeGkcC9hUb6sHthUEwG7r9VDPBMKO[/MEDIA]