### Palantech Framework by EnriqueGonzalez
### 10/21/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/143653/)

It's with great pleasure that i am releasing the first ever ORM MVC B4J Framework.   
**[SIZE=5] **What does that mean?** [/SIZE]**  
ORM: Object Relational Mapping, This framework allows you to pull from and push data to a database without writing SQL, this is done using the awesome Type system that we all love in B4x  
MVC: Stands for Model View Controller. you can read about it here: <https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller>  
B4J: The IDE that we all love! (please check footnotes)   
  
Just to give you an idea of what palantech is i took some inspiration to build palantech from giants like Ruby on Rails, Phoenix + Elixir and Django + Python.   
  
[SIZE=5]**What can you do with palantech?** [/SIZE]  
Right now is specialized on webapps but it also has some B4I and B4A intercommunication so you dont have to touch any of SQL or JSON between all the platforms.   
  
[SIZE=5]**How do i use it?** [/SIZE]  
as an MVC framework you need to think in 3 parts:   
  
**The model is based on the type system:**   

```B4X
Type user (id As String, name As String, created_at As Long, updated_at As Long)
```

  

```B4X
private Sub get_user(sql As SQL, id As String) As user  
    Dim qb As query_builder  
    qb.Initialize("user")  
    Return qb.get_one(sql, id)     
End Sub
```

  

```B4X
private Sub interact_with_user(sql As SQL)  
    Dim user As user = get_user(sql, "uuid")  
    user.name = "enrique"  
    DB_ORM.save(user,sql)  
End Sub
```

  
 **The view is a wrap of the Freemarker Library (<https://freemarker.apache.org/>)**  
This library allows to work seemlesly from HTML with data we already processed in B4J (types, maps, list, primitives)  
![](https://www.b4x.com/android/forum/attachments/135060)  
We are setting (in HTML) the value of the user.name notice the "${}"  
When the user submits this input (wrapped in a form tag) to B4J the ORM will convert it to a type  

```B4X
Dim params As Map = utils_web.get_parameters(req)  
Dim obj As user = HTTP_ORM.build_from_req("user", params)
```

  
   
**And the Controller**  
You already use them on Jserver  
  
I hope that so far you like the concept!   
  
[SIZE=5]**How can i get it?** [/SIZE]  
i am first releasing it in a closed beta with the idea of getting feedback. If you have ever done business with me, donated to me or i have donated to you, you are eligible to enter! send me a PM.   
  
(**PLEASE NOTE:** don't donate to get a copy, the idea of the closed beta is so i can focus on each user to receive feedback and improve the product, if you believe that you can contribute to the product send me a PM too)  
  
You will receive the library and an example of its usage.  
  
**Caveats and Limits**  
Currently works with SQL Server and MySQL  
The DB ORM requires that your database adheres to a standard, some examples:  

- All tables must have an ID, all foreign keys must end as \_id
- All numeric values (except for int) will be converted to Double
- Each db datatype must have a counterpart on B4x so sometimes an obscure datatype may be not available
- And some others

I have some limited time  
  
**Libraries**  
Currently the only non official library you need is Hikari: <https://www.b4x.com/android/forum/threads/hikaricp-5-x.138846/>  
And external jar files, download this one: <https://freemarker.apache.org/freemarkerdownload.html>  
  
**Special Thanks**  
to [USER=74499]@aeric[/USER] that helped me in creating the MySQL interface and contributing to the framework with code and ideas.   
  
Hope you like it!