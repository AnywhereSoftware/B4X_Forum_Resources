### [ABMaterial] MaterialTool - Creating a window with JSON by MichalK73
### 10/01/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/143262/)

Hello.  
  
This was created as a result of the need to create data entry forms in the current project he is writing. The project contains a large number of data entry forms. The data is often dynamically changed, tailored to a particular client. It was impossible to enter all the forms in a simple way, which translates into the size of the code and design time. The big plus of this method that you do not need to restart, recompile the server. Everything works on a working web server. From here the window files can be edited from another editor on the network, locally, etc. They can be sent via API, downloaded from a database, etc.  
Therefore, I first created a library that creates forms in ABContainer from text files. I used the JSON type because it is the most useful for this, understandable to other systems, to be sent via API or simply stored in a database.  
To create a container you need to create 2 .json files, one responsible for the structure of the window, the other for the objects placed in it.  
The structure can consist of multiple rows, but we can use a maximum of 4 columns. More at my place I did not notice the need for more cells per row. The sum of the cells can not exceed 12. A larger number will result in a bad display of elements.  
For example, for the creation of a row and occupy the entire width for 1 component will have :  

```B4X
    {  
        "row1": [  
            12  
        ]  
    }
```

  
  
"row1" and this is the descriptive name of the row, such as "login,username", "street,number\_house". This way we can describe to ourselves what variables will be here.  
One value of 12 means that there will be one component and uses the entire width of the row.  
  
Another example:  

```B4X
    {  
        "zipcode,city": [  
            3,  
            6  
        ]  
    }
```

  
  
Here we see that we have 2 component spaces, the first one uses 3/12 width, the second one uses 6/12. So in total they use 9 fields of width of the row. A full use of 12 fields of width can have, for example, [3,3,3,3,3], [6,6], [2,4,3,3], etc.  
  
The second file is a JSON file of the component schema in the window. The components available are: ABMLabel, ABMInput, ABMCombo, ABMCheckbox, ACHSwitch, ABMRange,ABMRadiogroup, ABMButton.  
There are parameters common to all components. (\*) - required in a component  
- "id" (\*) : paramter id of the component  
- "position" (\*) : [row,cell] - to specify where it is to be inserted in the structure of the window.Incorrect placement of the component may result in not displaying the component.  
- "margin" : [left,top,right,down] - not a required parameter, specifying the margin of the component in pixels. Counted from the left clockwise. "margin": [0,20,0,20] - add a margin of 20 each at the top and bottom.  
- "visible": "true/false" - not a required parameter, hiding the component on the page, so that, for example, later you can easily control it in the rest of our code.  
- "theme": - not required, we can set the theme of the component.  
  
Parameters for individual components.(\*) - required in the component.  
  
**Label:**  
- "size" (\*) : size of the caption, can be a, p, h1, h2, h3, h4, h5, h6  
- "html" : "code html" - instead of text insert ready html code. Useful when we want to insert for example colors description, simple table and other things according to html.  
- "clicked": "true/false" - not required, we can set the reaction to clicking on Label  
  
**Input:**  
- "title": "Write name" - the title of the component  
- "input\_type" - if there is no this parameter go it means that it applies to text input. Can be set to: number, email, password, time, date, datetime, url, phone, search  
- "textbox" : "true/false" - whether the field for multi-line typing  
- "autocomplete" : ["Poland", "USA", "France"] - appearance of this parameter sets the input prompts according to the dictionary given  
- "max" - define the size of the entered text  
- "tooltip" : "Your name" - tooltip balloon  
- "placeholder" : "Miki" - hint in input field  
- "default" : "1" - default setting of the text that will appear  
- "mask" : "'mask: '99-999'" - setting the input mask  
  
**Combo:**  
- "height" : 60 - if there is it sets the height of the dropdown list according to the formula height\*count\_combo, if there is not it is set to 60\*conunt\_combo  
- "title" - description of what the element on the page is about  
- "value" : ["One", "Two", "Five"] - combo selection elements  
- "tooltip" - tooltip balloon  
  
**Checkbox:**  
- "title" - as above , applies to the description on the page  
- "state" (\*) : "true/false" - required, determines initial state of selection  
- "tooltip" - tooltip balloon  
  
**Switch:**  
- "ontext" (\*) - description when switched on  
- "offtext" (\*) - description when switched off  
- "tooltip" - tooltip balloon  
  
**Radio:**  
- "value": ["one" , "two[BR]" , "three", "four"] - values of each field. Tag [BR] means that the radio component goes to the next line of listing  
- "active" : 1 - determines which one should be selected  
- "tooltip" - tooltip balloon  
  
**Range:**  
 - "start": 8 - start location  
- "stop": 18 - stop location  
- "min" : 0 - minimum size  
- "max": 23 - maximum size  
- "step": 1 - move step on the bar  
All parameters are required (\*)  
  
  
**Button:**  
  
- "size": "normal/small/large" - determines the size of the button  
- "icon" - icon name, according to ABMaterial  
- "fullcell" : "true/false" - whether to use the full width of the cell  
- "text" - text on the button  
  
Reading and writing data to the window.  
I've added 2 functions that make reading data and writing data to window components as simple as possible.  
  
ReadValueWindow(Container as ABMContainer) - reads all data entered into the window. Only supports components from AutoConatiner. The result is 'map', key is the component id, value is the data entered.  
  
WriteValueWindow(Container As ABMContainer, value As Map) - writing data to the window. You need to indicate the container and the data set of type 'map'. Key - is the ID of the component, value - is the data to be written. The function recognizes the type of component and enters accordingly. If there is no data to any component then it will not be entered.  
  
**Use:**  
Add a variable to your page.  

```B4X
Sub Class_Globals  
      
    …  
    …  
    ' your own variables     
    Private AC As AutoContainer  
  
    Private mycoice As String  
End Sub
```

  
  
In BuildPage we do the initialization of the variable.  

```B4X
AC.Initialize(page, Me)
```

  
  
Creating a window with JSON.  

```B4X
    Dim ob As String = File.ReadString(File.DirApp&"/scheme", "menu.json") 'object in container  
    Dim st As String = File.ReadString(File.DirApp & "/structure", "s_menu.json") 'structure container  
    Dim con As ABMContainer = AC.BuildWindow("menu", st,ob)  
    page.Cell(1,1).AddComponent(con)
```

  
  
Reading data from the window  

```B4X
    Dim c As ABMContainer  
    c= page.Component("ex1")  
    Dim m As Map = AC.ReadValueWindow© 'get value from container
```

  
  
Writing to the window  

```B4X
Dim window As ABMContainer  
window = page.Component("login")  
AC.WriteValueWindow(windows, CreateMap("username":"Pawel","password":"dupa01"))
```

  
  
  
For the sake of example, I insert a video of how it works and a Demo of the use of the library. The library will be developed as new necessary functions appear in my project. Comments and suggestions welcome.  
  
[Link to DEMO](https://drive.proton.me/urls/ND3KRD2A2G#HztyLB2K4rTW)  
  
[MEDIA=youtube]GzBQrk\_ueD4[/MEDIA]