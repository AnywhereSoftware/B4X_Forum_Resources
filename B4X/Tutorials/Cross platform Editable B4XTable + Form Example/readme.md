###  Cross platform Editable B4XTable + Form Example by Erel
### 01/02/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/104766/)

![](https://www.b4x.com/basic4android/images/SS-2019-04-11_15.50.04.png)  
  
This example demonstrates several things:  

- Cross platform code and files, similar to the way XUI2D games are organized:

- All the logic is implemented in a class named EditableTable. The module is located in the projects parent folder.
- The two asset files (list of animals - [source](https://gist.github.com/atduskgreg/3cf8ef48cb0d29cf151bedad81553a54); and the preferences dialog template) are stored in the Shared Files folder and are copied when needed with a #CustomBuildAction command. You can see it in the EditableTable class. Note that if you want to update those files then you need to update the files in the Shared Files folder. The project specific files will be updated automatically.

- Using B4XTable and B4XPreferencesDialog to create an editable table. Table features:

- Add new items.
- Edit existing items.
- Delete existing items.
- Duplicate existing items.
- Data is saved when the app closes to a CSV file.
- Saved data is loaded when the app starts.

Dependencies:  
  
- B4XPreferencesDialog v1.30+: <https://www.b4x.com/android/forum/threads/103842/#content>  
  
The B4A, B4i and B4J projects are attached.  
  
B4J example of a table with inline editing: <https://www.b4x.com/android/forum/threads/b4xtable-with-inline-editing.112686/#post-702660>