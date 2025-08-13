### [Web] Automatic SQLite PHP REST API - Retrieving Database Schema and other things by Mashiane
### 01/06/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/164968/)

Hi Fam  
  
There are a couple of threads here that we looked at the PHP REST API for CRUD operations in your Database. The nice thing about this [REST API](https://github.com/mevdschee/php-crud-api) is that you can use it for  
  

- MySQL - [we have explored this in detail](https://www.b4x.com/android/forum/pages/results/?query=mysql+rest+api)
- MSSQL
- PostGres
- SQLite - we are exploring this today.

  
From a single php.api file, you can just plug it in your project and within no time, you are sorted. What I wanted to do was also be able to view the schema of the database as I need this in something else Im working on.  
  
We will update the api.php file to use SQLite.  
  

```B4X
$config = new Config([  
        'driver' => 'sqlite',  
        'address' => 'bibleshow.db',  
        'port' => '',  
        'username' => '',  
        'password' => '',  
        'database' => '',  
        'debug' => false,  
        'tables' => 'all',  
        'controllers' => 'records,columns,tables,openapi,status',  
        'middlewares' => 'sslRedirect,apiKeyAuth,sanitation',  
        'apiKeyAuth.keys' => 'oQNg79KwzBEBo9l74CfYjrx1yh3xCNg3033ujGlZPgfPmzMcv0zlbk38!-ndn6730UFn/Ziu',  
        'apiKeyAuth.header' => 'X-API-Key',  
    ]);
```

  
  
We are using middlewares for apiKeyAuth, sanitation and sslRedirect here. Our database as well as the api.php files are in our **assets** folder of our website.  
  
Two things are important here  
  
1. driver and  
2. address (path to sqlite database)  
  
To ensure that this works, we can test with PostNet. We ensure that the **X-API-Key** is specified for our connection, else we will get an authentication error message  
  
![](https://www.b4x.com/android/forum/attachments/160471)  
  
  
We have activated some controllers, these being records (access actual records in the database, by default this is on), columns (access the schema of our database)  
  
We will fire this GET with  
  

```B4X
https://localhost/sdtools/assets/api.php/columns
```

  
  
This will access our database and extract our schema and display it like this..  
  

```B4X
{  
    "tables": [  
        {  
            "name": "Analysis",  
            "type": "table",  
            "columns": [  
                {  
                    "name": "id",  
                    "type": "integer",  
                    "pk": true  
                },  
                {  
                    "name": "analysis",  
                    "type": "varchar",  
                    "length": 254,  
                    "nullable": true  
                },  
                {  
                    "name": "title",  
                    "type": "varchar",  
                    "length": 254,  
                    "nullable": true  
                },  
                {  
                    "name": "scripture",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "verses",  
                    "type": "clob",  
                    "nullable": true  
                }  
            ]  
        },  
        {  
            "name": "Bible",  
            "type": "table",  
            "columns": [  
                {  
                    "name": "Book",  
                    "type": "integer",  
                    "nullable": true  
                },  
                {  
                    "name": "Chapter",  
                    "type": "integer",  
                    "nullable": true  
                },  
                {  
                    "name": "Verse",  
                    "type": "integer",  
                    "nullable": true  
                },  
                {  
                    "name": "Scripture",  
                    "type": "clob",  
                    "nullable": true  
                }  
            ]  
        },  
        {  
            "name": "Books",  
            "type": "table",  
            "columns": [  
                {  
                    "name": "BookID",  
                    "type": "clob",  
                    "pk": true  
                },  
                {  
                    "name": "BookName",  
                    "type": "varchar",  
                    "length": 2147483647,  
                    "nullable": true  
                },  
                {  
                    "name": "Chapters",  
                    "type": "clob",  
                    "nullable": true  
                }  
            ]  
        },  
        {  
            "name": "Chapters",  
            "type": "table",  
            "columns": [  
                {  
                    "name": "Book",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "Chapter",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "Verse",  
                    "type": "clob",  
                    "nullable": true  
                }  
            ]  
        },  
        {  
            "name": "GreatChapters",  
            "type": "table",  
            "columns": [  
                {  
                    "name": "id",  
                    "type": "integer",  
                    "pk": true  
                },  
                {  
                    "name": "Title",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "Scriptures",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "Verses",  
                    "type": "clob",  
                    "nullable": true  
                }  
            ]  
        },  
        {  
            "name": "GreatStories",  
            "type": "table",  
            "columns": [  
                {  
                    "name": "id",  
                    "type": "integer",  
                    "pk": true  
                },  
                {  
                    "name": "Title",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "Scriptures",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "Verses",  
                    "type": "clob",  
                    "nullable": true  
                }  
            ]  
        },  
        {  
            "name": "GreatVerses",  
            "type": "table",  
            "columns": [  
                {  
                    "name": "id",  
                    "type": "integer",  
                    "pk": true  
                },  
                {  
                    "name": "Title",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "Scriptures",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "Verses",  
                    "type": "clob",  
                    "nullable": true  
                }  
            ]  
        },  
        {  
            "name": "Intro",  
            "type": "table",  
            "columns": [  
                {  
                    "name": "id",  
                    "type": "integer",  
                    "pk": true  
                },  
                {  
                    "name": "title",  
                    "type": "varchar",  
                    "length": 254,  
                    "nullable": true  
                },  
                {  
                    "name": "image",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "subtitle",  
                    "type": "varchar",  
                    "length": 254,  
                    "nullable": true  
                }  
            ]  
        },  
        {  
            "name": "Lessons",  
            "type": "table",  
            "columns": [  
                {  
                    "name": "id",  
                    "type": "integer",  
                    "pk": true  
                },  
                {  
                    "name": "LessonTitle",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "LessonScriptures",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "Verses",  
                    "type": "clob",  
                    "nullable": true  
                }  
            ]  
        },  
        {  
            "name": "Life",  
            "type": "table",  
            "columns": [  
                {  
                    "name": "id",  
                    "type": "integer",  
                    "pk": true  
                },  
                {  
                    "name": "LessonTitle",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "LessonScriptures",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "Verses",  
                    "type": "clob",  
                    "nullable": true  
                }  
            ]  
        },  
        {  
            "name": "Miracles",  
            "type": "table",  
            "columns": [  
                {  
                    "name": "id",  
                    "type": "integer",  
                    "pk": true  
                },  
                {  
                    "name": "LessonTitle",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "LessonScriptures",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "Verses",  
                    "type": "clob",  
                    "nullable": true  
                }  
            ]  
        },  
        {  
            "name": "Parables",  
            "type": "table",  
            "columns": [  
                {  
                    "name": "id",  
                    "type": "integer",  
                    "pk": true  
                },  
                {  
                    "name": "LessonTitle",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "LessonScriptures",  
                    "type": "clob",  
                    "nullable": true  
                },  
                {  
                    "name": "Verses",  
                    "type": "clob",  
                    "nullable": true  
                }  
            ]  
        },  
        {  
            "name": "Pictures",  
            "type": "table",  
            "columns": [  
                {  
                    "name": "Key",  
                    "type": "varchar",  
                    "length": 5,  
                    "pk": true  
                },  
                {  
                    "name": "Text",  
                    "type": "varchar",  
                    "length": 255,  
                    "nullable": true  
                },  
                {  
                    "name": "Tag",  
                    "type": "clob",  
                    "nullable": true  
                }  
            ]  
        }  
    ]  
}
```