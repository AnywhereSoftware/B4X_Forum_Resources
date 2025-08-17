### [BANano][CLASS] JSONPath: create, read and modify JSON files using a path syntax by alwaysbusy
### 09/16/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/163077/)

I always loved the function [USER=74323]@wonder[/USER] had written to read JSON files using a path structure: <https://www.b4x.com/android/forum/threads/json-getobjfrompath.85539/#content>  
It truly is navigating JSON trees **like a boss** and we use his method extensively in almost all our projects.  
  
But I always wondered if there couldn't be a similar system to also **create** and **modify** JSON with a similar syntax…  
  
Hence the **JSONPath** class  
  
**Note: this class is also BANano compatible but requires BANano 9.03+ because of a bug in the Split function.**  
  
The Json we want to create (a game with two teams, each with two players and one of them is the captain):  

```B4X
{  
     "game": "2024\/09\/11",  
     "teams": [  
          {  
               "players": [  
                    {  
                         "surName": "Bailleul",  
                         "name": "Alain"  
                    },  
                    {  
                         "surName": "Brion",  
                         "name": "Catherine",  
                         "isCaptain": true  
                    }  
               ],  
               "name": "De Caddie Clan"  
          },  
          {  
               "players": [  
                    {  
                         "surName": "Pattyn",  
                         "name": "Filip"  
                    },  
                    {  
                         "surName": "Wittouck",  
                         "name": "Kristof",  
                         "isCaptain": true  
                    }  
               ],  
               "name": "De Golfers"  
          }  
     ]  
}
```

  
  
Code to make this json (explanation see further):  

```B4X
Dim Path As JSONPath  
Path.Initialize($"{"game": "2024/09/11"}"$)  
Path.set("teams/@/players/@", CreateMap("name": "Alain", "surName": "Bailleul"))  
Path.set("teams/#/players/@", CreateMap("name": "Catherine", "surName": "Brion"))  
Path.set("teams/#/players/#/isCaptain", True)  
Path.set("teams/#/name", "De Caddie Clan")  
Path.set("teams/@/players/@", CreateMap("name": "Filip", "surName": "Pattyn"))  
Path.set("teams/#/players/@", CreateMap("name": "Kristof", "surName": "Wittouck"))  
Path.set("teams/#/players/#/isCaptain", True)  
Path.set("teams/#/name", "De Golfers")  
Log(Path.ToPrettyString(5))
```

  
  
With a simple path syntax we create and modify branches of the Json. Adding the same referee to both teams is as simple as:  

```B4X
Path.set("teams/*/players/@", CreateMap("name": "3th", "surName": "Person", "isReferee": True))
```

  
  
Result:  

```B4X
{  
     "game": "2024\/09\/11",  
     "teams": [  
          {  
               "players": [  
                    {  
                         "surName": "Bailleul",  
                         "name": "Alain"  
                    },  
                    {  
                         "surName": "Brion",  
                         "name": "Catherine",  
                         "isCaptain": true  
                    },  
                    {  
                         "surName": "Person",  
                         "name": "3th",  
                         "isReferee": true  
                    }  
               ],  
               "name": "De Caddie Clan"  
          },  
          {  
               "players": [  
                    {  
                         "surName": "Pattyn",  
                         "name": "Filip"  
                    },  
                    {  
                         "surName": "Wittouck",  
                         "name": "Kristof",  
                         "isCaptain": true  
                    },  
                    {  
                         "surName": "Person",  
                         "name": "3th",  
                         "isReferee": true  
                    }  
               ],  
               "name": "De Golfers"  
          }  
     ]  
}
```

  
  
How about changing the referees name in all teams?  

```B4X
Path.set("teams/*/players/#/name", "Paul")  
Path.set("teams/*/players/#/surName", "Cardoen")
```

  
  
Or let's get all the captains:  

```B4X
Dim captains As Map = Path.Filter("teams/*/players", CreateMap("isCaptain": True))  
For Each key As String In captains.Keys  
        Dim play As Map = captains.Get(key)  
        Log("The captain is: " & play.Get("name") & " " & play.Get("surName"))  
Next
```

  
  
Moving a player from one team to another other:  

```B4X
Dim play As Map = Path.Move("teams/1/players/0", "teams/0/players/@")
```

  
  
I think you may get the idea. ;)  
  
**Some explanation about the paths:**  
  
First, you may have noticed the symbols in the paths. They have to do with functionalities of array objects:  
  
\* = All items in the array  
# = the last item in the array  
@ = add a new object in the array  
Number: a specific index in the array  
{"prop": "value"} = object in the array where the property = value  
  
So the line:  

```B4X
Path.set("teams/*/players/@", CreateMap("name": "3th", "surName": "Person", "isReferee": True))
```

  
  
would read as: in all teams **(\*)** add **(@)** this person to the players array  
  
And:  

```B4X
Path.set("teams/*/players/#/name", "Paul")
```

  
  
would read as: in all teams **(\*)** for the last item in the players array **(#)** set his name to Paul.  
  
And:  

```B4X
Dim GamePlayers As Map = DB.Filter($"games/{"id": 1}/teams/{"teamId": 1}/scores"$, CreateMap("playerId": PlayerID))
```

  
Or:  

```B4X
Dim GamePlayers As Map = DB.Filter($"games/{"id": 1}/teams/{"teamId": 1}/scores/{"playerId": ${PlayerID}}"$, Null)
```

  
  
would read as: in games with id = 1 and teams as id = 1 get the scores of player with playerId = PlayerID  
  
**Functionalities:  
  
.Initialize(jsonOrObject as Object)**  
Initializes a JSONPath.  
  
if jsonOrObject is an empty string, the JSONPath type will be TYPE\_UNDEFINED until the first item is added.  
jsonOrObject can be a json string, a map, a list or another JSONPath.  
  
*Note:* if it is another JSONPath, it is added by reference!  
  
Because in the example our first .Set call starts with a "property" (teams), the root of the JSONPath becomes a Map. It we would be a List if we would start it like this:  

```B4X
Dim Path As JSONPath  
Path.Initialize("")  
Path.set("@/players/@", CreateMap("name": "Alain", "surName": "Bailleul"))
```

  
  
which would result in this Json:  

```B4X
[  
     {  
          "players": [  
               {  
                    "surName": "Bailleul",  
                    "name": "Alain"  
               }  
          ]  
     }  
]
```

  
  
*Note:* both example versions are in the demo project.  
  
**.ToString() As String**  
Creates a JSON string from the initialized object.  
The string does not include any extra white space.  
  
**.ToPrettyString(indent As Int) As String**  
Creates a JSON string from the initialized object.  
The string will be indented and easier for reading.  
Note that the string created is a valid JSON string.  
Indent - number of spaces to add to each level.  
  
**.getRootType() As Int**  
returns the type of the root: TYPE\_MAP, TYPE\_ARRAY, TYPE\_UNDEFINED  
  
**.Get(path As String) As Object**  
 Gets the object given its full path.  
 path - the full path to the object, each branch separated by a /  
 for an array use the index (starting from 0),  
 path can have wildcard:  
 - use # to refer to the last item in an array  
  
Example:  

```B4X
Log("The name of player 1 in team 1 is " & Path.Get("teams/1/players/1/name"))
```

  
  
**.GetDefault(path As String, default As Object) As Object**  
 Gets the object given its full path.  
 path - the full path to the object, each branch separated by a /  
 for an array use the index (starting from 0),  
 path can have wildcard:  
 - use # to refer to the last item in an array  
 default - a default value if the path was not found  
  
**.GetClone(path As String) As Object**  
 Returns a clone of the object given its full path.  
 path - the full path to the object, each branch separated by a /  
 for an array use the index (starting from 0)  
 path can have wildcard:  
 - use # to refer to the last item in an array  
*Note:* This is a seperate clone and making changes to it will not change the original one.  
  
**.Set(path As String, value As Object)**  
 Sets an object at the given full path.  
 path - the full path to the object, each branch separated by a /  
 for an array use the index (starting from 0)  
 path can have wildcards:  
 - use @ to add it to the end of an array  
 - use # to refer to the last item in an array  
 - use \* to refer to all items in the array  
 value - the value of the object at the path (can be another JSONPath)  
  
**.Remove(path As String) As Object**  
 Remove an object given its full path.  
 path can not have wildcards (@, #, \*, {})  
 Returns the removed object  
  
**.Copy(fromPath As String, toPath As String) As Object**  
 copies an object from path to path  
 paths can not have wildcards (@, #, \*, {})  
 returns the copied object  
  
Example:  

```B4X
' copy player 0 from team 0 and add him at the end of the players in team 1  
Dim play As Map = Path.Copy("teams/0/players/0", "teams/1/players/@")
```

  
  
**.Move(fromPath As String, toPath As String) As Object**  
 move an object from path to path  
 paths can not have wildcards (@, #, \*, {})  
 returns the moved object  
  
Example:  

```B4X
' move player 0 from team 1 and add him at the end of the players in team 0  
Dim play As Map = Path.Move("teams/1/players/0", "teams/0/players/@")
```

  
  
**.Filter(path As String, filterMap As Map) As Map**  
 Finds objects given the full path and some fields.  
  
 The value can be a map of fields. Pass null for no filter.  
 path - for an array use the index (starting from 0)  
 path can have wildcards:  
 - use # to refer to the last item in an array  
 - use \* to refer to all items in the array  
 - use a json String to inner filter objects within an array  
 Returns a Map of objects found, the key is the full path to the object  
  
Example:  

```B4X
' get all the players with the name "3th"  
Dim players As Map = Path.Filter("teams/*/players", CreateMap("name": "3th"))  
For Each key As String In players.Keys  
        Dim play As Map = players.Get(key)  
        Log("Player " & play.Get("name") & " full path = " & key)  
Next
```

  
  
Or:  
  

```B4X
Dim play as Map = Path.Filter($"teams/{"name": "De Caddie Clan"}/players/"$, CreateMap("name": "Catherine"))
```

  
  
**.GetArraySize(Path As String) As Long**  
 Returns the size of the array, given the full path to the array.  
 Returns -1 if not found  
  
**.PathToKeys(path As String) As String()**  
 Helper method: returns an array of all the keys in the path  
  
Example:  

```B4X
' we want to get all the captains and then use their key to build a new path to his team to get its name  
Dim captains As Map = Path.Filter("teams/*/players", CreateMap("isCaptain": True))  
For Each key As String In captains.Keys  
        Dim play As Map = captains.Get(key)  
        Log("The captain is: " & play.Get("name") & " " & play.Get("surName"))  
        ' use the key to lookup the team  
        Dim Keys() As String = Path.PathToKeys(key)  
        Dim TeamPath As Map = Path.Get(Keys(0) & "/" & Keys(1))  
        Log("From the team: " & TeamPath.Get("name"))  
Next
```

  
  
**.KeysToPath(keys() As String) As String**  
 Helper method: makes a path from an array of keys  
  
Alwaysbusy