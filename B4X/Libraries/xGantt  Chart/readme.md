###  xGantt  Chart by klaus
### 09/22/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/145355/)

I have written a cross-platform xGantt chart Class.  
  
There does also exist an [xGanttLite library](https://www.b4x.com/android/forum/threads/b4x-xganttlite-b4xlib.163211/#content).  
The differences are that the xGantt treats durations and dependencies but the xGanttLite uses only begin and end times.  
The xGantt scale is days only, the xGanttLite has three scales: hour, day large and day small.  
  
**History.**  
After having read [this thread](https://www.b4x.com/android/forum/threads/gantt-calendar.129542/#content), i begun to think about it and wrote a first demostrator version.  
Then, seeing that there was some interest in [this thread](https://www.b4x.com/android/forum/threads/looking-for-b4x-ganttchart.136633/), I posted this first version.  
And continued to improve it, as a kind of challenge, to see what can be done and left it, because i do not use it.  
These days an interest raised again in [this thread](https://www.b4x.com/android/forum/threads/gantt-diagram-for-pm.145324/#post-921344) and i posted my latest version.  
Further improvements would mean to write a full project management program, and this is not in my to do list.  
As there is some interest, i publish the current version as it is.  
It is open source, any member can use, reuse, improve it in any way.  
  
Attached the demo program with the xGantt.bas module.  
I have not (yet) made a b4xlib library.  
Depending on the interest i can / will give more details in the future.  
  
**Missing features.**  
1. Official holidays or free days are not taken into account, only Saturdays an Sundays.  
2. Optimistic and pessimistic time estimations with the corresponding chart display.  
3. Critical path.  
4. Hour time line, only days are supported.  
etc.  
  
**The class:**  
  
There exist two types of display.  
The chart:  
  
 ![](https://www.b4x.com/android/forum/attachments/1673180649943-png.137855/)  
  
  
The table.  
  
 ![](https://www.b4x.com/android/forum/attachments/1673180736971-png.137856/)  
  
  
  
**Data structure:**  
  
A xGantt chart is a composed of rows.  
Each row has these properties:  
1. The ID of the objcet  
2. One of the three object types.  
2.1. Task  
2.2. Group  
2.3. Milestone  
  
Objects:  
**2.1. Task**  
  
![](https://www.b4x.com/android/forum/attachments/137991)  
![](https://www.b4x.com/android/forum/attachments/137992)  
  
This is the main object with different properties:  
1. ID - a string that identifies the task.  
2. Row - the row number in the chart.  
3. Name - a string with the name of the task.  
4. Color - only for the display.  
5. Responsible - the name of the person in charge of the task  
6. BeginDate - the begin date of the task.  
This date could be calculated in function of the dependency on other tasks.  
7. Duration - the duration in days.  
8. Dependency - dependency on other tasks.  
Five dependencies do exist:  
- None - no dependency, this is always the case for the first task.  
The EndDate is calculated with the Duration.  
- FS - Finish to Start. The task starts when its predecessor task is finished with a lag or lead. Example Task 1.2  
The BeginDate is calculated with the predecessors EndDate and the lag or lead and the EndDate is calculated with the duration.  
- FF - Finish to Finish. The task must finish at the same time as its predecessor with a lag or lead. Example Task 2.5  
The EndDate is calculated with the predecessors EndDate and the lag or lead and the BeginDate is calculated with the duration.  
- SS - Start to Start. The task must start at the dame time as its predecessor with a lag or lead. Example Task 1.4  
The BeginDate is calculated with the predecessors BeginDate and the lag or lead and the EndDate is calculated with the duration.  
- SF - Start to Finish. The task must be finished when its predecessor starts with a lag or lead. Example Task 1.5  
The EndDate is calculated with the predecessors BeginDate and the lag or lead and the BeginDate is calculated with the duration.  
9. Completion - percentage of completion of the task.  
10. PredecessorID - ID of the predecessor task in the dependency hierarchy.  
11 SuccessorIDs - List of the IDs of the successor tasks in the dependency hierarchy. These values are calculated.  
12. LagLead - the number of days before or after the begin or end of a task in the hierarchy, when there is a dependency.  
13. EndDate - the end date of the task. This value is calculated.  
  
  
**2.2 Group**  
  
![](https://www.b4x.com/android/forum/attachments/137993)  
  
1. ID - a string that identifies the group.  
2. Row - the row number in the chart.  
3. Name - a string with the name of the group.  
4. Color - only for the display.  
5. Begin Task ID - the ID of the first task.  
6. End Task ID - the ID of the last task.  
  
**2.3 Milestone**  
  
![](https://www.b4x.com/android/forum/attachments/137994)  
  
1. ID - a string that identifies the milestone.  
2. Row - the row number in the chart.  
3. Name - a string with the name of the milestone.  
4. Color - only for the display.  
5. Dependency - dependency on tasks.  
- None - no dependency.  
- TB Task Begin - begin of the task.  
- TE Task End - end of the task.  
6.1 Date of the milestone when there is no dependency.  
6.2 Task ID - the ID of the task, if there is a dependency, and the date is calculated.