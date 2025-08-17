###  xGanttLite  b4xlib by klaus
### 01/14/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/163211/)

**Current version 1.1**  
  
The xGanttLite library allows to draw Gantt charts.  
  
It was initiated in [this post](https://www.b4x.com/android/forum/threads/xgantt-class-duration-of-tasks-by-ours-instead-of-days.162702/).  
  
There does also exist an [xGantt](https://www.b4x.com/android/forum/threads/b4x-xgantt-chart.145355/#content), library which is more complete.  
The differences are that the xGantt treats durations and dependencies but the xGanttLite uses only begin and end times.  
The xGantt scale is days only, the xGanttLite has three scales: hour, day large and day small.  
  
The xGanttLite custom view is a B4X library.  
It works on all three platforms: B4A, B4i and B4J, not yet tested with B4i.  
The xGanttLite.b4xlib and the xGanttLite.xml files are attached.  
You need to copy the xGanttLite.b4xlib file to the AdditionlLibraries\B4X folder!  
The recommended AdditionlLibraries folder structure is explained [HERE](https://www.b4x.com/guides/B4XGettingStarted.html#pfa).  
  
Do not copy the xGanttLite.xml file to the AdditionalLibraries folder, copy it in another folder for all b4xlib xml files.  
Example: AdditionlLibraries\B4XlibXMLFiles  
The xGanttLite.xml file is for help purposes only and is useful with the B4X [Help Viewer](https://www.b4x.com/android/forum/threads/b4x-help-viewer.46969/) or the [B4XObjectBrowser](https://www.b4x.com/android/forum/threads/b4a-b4i-b4j-and-b4r-api-documentation-b4x-object-browser.25682/#content).  
The xGanttLite.xml file was generated with this tool: [b4xlib - XML generation](https://www.b4x.com/android/forum/threads/tool-b4xlib-xml-generation.101450/)  
  
Demo projects for all three platforms as a B4XPages project.  
Tested on PC, Android Samsung S10, Samsung Tab S2. Not yet tested with B4i.  
**xGanttLiteDemo.zip  
**xGanttLite.b4xlib  
**xGanttLite.xml******  
  
![](https://www.b4x.com/android/forum/attachments/157156)  
  
**Data structure:**  
  
A xGanttLite chart is a composed of rows.  
Each row has these properties:  
1. The ID of the objcet  
2. One of the three object types.  
2.1. Task  
2.2. Group  
2.3. Empty, just an empty row  
  
**2.1 Task**  
This is the main object with different properties:  
1. ID - a string that identifies the task.  
2. Row - the row number in the chart.  
3. Name - a string with the name of the task.  
4. Responsible - the name of the person in charge of the task.  
5. GroupID - the ID of the Group the Task belongs to or an empty string.  
6. BeginTime - the begin date and time of the task.  
7. EndTime - the end date and time of the task.  
8. Color - only for the display.  
9. Comment - a comment for the task  
  
**2.2 Group**  
1. ID - a string that identifies the group.  
2. Row - the row number in the chart.  
3. Name - a string with the name of the group.  
4. Color - only for the display.  
5. Comment - a comment for the group.  
  
What you can do:  
1. Scroll if needed, horizontally on the time scale and vertically the rows.  
2. Jump to the beginning or the end with the scrollbar.  
3. Show the line data in the upper left corner; clicking on a row and moving the mouse over the rows.  
![](https://www.b4x.com/android/forum/attachments/157157)  
4. Display with three different scales, you can select the scale with the small buttons in the lower left corner: ![](https://www.b4x.com/android/forum/attachments/157167)  
4.1 HOUR:  
![](https://www.b4x.com/android/forum/attachments/157168)  
4.2 DAY\_LARGE  
![](https://www.b4x.com/android/forum/attachments/157169)  
4.3 DAY\_SMALL  
![](https://www.b4x.com/android/forum/attachments/157170)  
  
5 Edit the time in the chart.  
5.1 Double click on a task.  
![](https://www.b4x.com/android/forum/attachments/157174)  
![](https://www.b4x.com/android/forum/attachments/157162)  
  
5.2 Move one of the three lines: left move the beginning, middle move the task and right move the end time.  
![](https://www.b4x.com/android/forum/attachments/157163)  
After releasing the mouse you will be asked if you want to keep the new position, continue editing or cancel.  
![](https://www.b4x.com/android/forum/attachments/157164)  
And the result:  
![](https://www.b4x.com/android/forum/attachments/157166)  
  
You can set the Language with the LanguageCode property:  
Three files are included in the Assets folder:  
texts\_en.txt for English  
texts\_fr.txt for Français  
texts\_de.txt for Deutsch.  
If you want to adapt it to your language you can translate one of the text files and save it as texts\_xx.txt in the SharedFiles folder of the project.  
Where xx is your two character language code.  
  
  
**xGanttLite  
  
Author:** Klaus CHRISTL (klaus)  
**Version:** 1.1  

- **Events:**

- **SelectedRow** (RowIndex As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddEmpty**
*Adds an empty row*- **AddGroup** (ID As String, Name As String, Color As Int, Comment As String)
*Adds a Group  
 ID = identification of the group.  
 Name = description of the group.  
 Color = color of the bar in the chart  
 Comment = a comment for the group*- **AddTaskDates** (ID As String, Name As String, Responsible As String, GroupID As String, BeginTime As String, EndTime As String, Color As Int, Comment As String)
*Adds a Task, the times are Strings  
 ID = identification of the task.  
 Name = description of the task.  
 Responsible = person un charge of the task  
 GroupID = ID of the group the Task belongs to, empty string if the task does not belong to a group.  
 BeginTime = time of the start of the task; DateFormat yyyy-MM-dd HH.mm.ss  
 EndTime = time of the end of the task; DateFormat yyyy-MM-dd HH.mm.ss  
 Color = color of the bar in the chart  
 Comment = a comment for the task*- **AddTaskTicks** (ID As String, Name As String, Responsible As String, GroupID As String, BeginTimeTicks As Long, EndTimeTicks As Long, Color As Int, Comment As String)
*Adds a Task, the times are Ticks  
 ID = identification of the task.  
 Name = description of the task.  
 Responsible = person un charge of the task  
 GroupID = ID of the group the Task belongs to, empty string if the task does not belong to a group.  
 BeginTimeTicks = time of the start of the task in Ticks  
 EndTimeTicks = time of the end of the task in Ticks  
 Color = color of the bar in the chart  
 Comment = a comment for the task*- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **DrawGantt**
*Draws the Gantt chart*- **GetDate** (Ticks As Long, DateFormat As String) As String
*Returns the date string for the given date ticks with the given DateFormat*- **GetDateTicks** (Date As String) As Long
*Returns Ticks for a date with the yyyy-MM-dd format*- **GetGroup** (GroupID As String) As GanttLiteGroupData
*Returns the Group data for the given Group ID*- **GetTask** (TaskID As String) As GanttLiteTaskData
*Returns the Task data for the given Task ID*- **Initialize** (Callback As Object, EventName As String)
- **JumpToBegin**
*Jumps to the beginning of the chart*- **JumpToDate** (Ticks As Long)
*Jumps to the given date in Ticks*- **JumpToDate2** (Date As String)
*Jumps to the given date in the current DateFormat  
 default date format "yyyy-MM-dd HH:mm:ss"*- **JumpToEnd**
*Jumps to the end of the chart*- **JumpToNow**
*Jumps to the current time, the current time is in the middle of the screen*
- **Properties:**

- **BackgroundColor** As Int
*Sets or gets the BackgroundColor property  
 It must be a xui color  
 Example: xGanttLite1.BackgroundColor = xui.Color\_White*- **BeginDate** As String [write only]
*Sets or gets the BeginDate property  
 Begin day of the chart  
 Default value "" empty string  
 This means that the begin date is the first day of all tasks.*- **DateFormat** As String
*Sets or gets the DateFormat property  
 Default value = "yyyyMMdd"*- **DisplayResponsibleColumn** As Boolean
*Sets or gets the DisplayResponsibleColumn property  
 When True, the Responsible column is displayed*- **DisplayRowData** As Boolean
*Sets or gets the DisplayRowData property  
 When True, the row data is displayed in the upper left corner when the user presses and moves the mouse on a row*- **DisplayRowIndexColumn** As Boolean
*Sets or gets the DisplayRowIndexColumn property  
 When True, the RowIndex column is displayed*- **EndDate** As String [write only]
*Sets or gets the EndDate property  
 End day of the chart  
 Default value "" empty string  
 This means that the end date is the last day of all tasks.*- **GridColor** As Int
*Sets or gets the GridColor property  
 It must be a xui color  
 Example: xGanttLite1.GridColor = xui.Color\_Gray*- **GridFrameColor** As Int
*Sets or gets the GridFrameColor property  
 It must be a xui color  
 Example: xGanttLite1.GridFrameColor = xui.Color\_Black*- **LanguageCode** As String
*Sets or gets the language code.  
 en English  
 fr Français  
 de Deutsch*- **Snapshot** As B4XBitmap [read only]
*Returns a B4XBitmap object of the chart (read only).*- **TextColor** As Int
*Sets or gets the TextColor property  
 It must be an xui color  
 Example: xGanttLite1.TextColor = xui.Color\_Blue*- **TextSize** As Float
*Sets or gets the TextSize property  
 The row height depends on the text size, it is automatically adjusted*- **TimeDisplayMode** As String
*Sets or gets the TimeDisplayMode property  
 Possible values:  
 "HOUR" = displays 24 hours a day  
 "DAY\_LARGE" = diplays days with a large column  
 "DAY\_SMALL" = diplays days with a samll column*