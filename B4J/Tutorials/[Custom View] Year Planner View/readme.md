### [Custom View] Year Planner View by Chris2
### 06/04/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/145619/)

This Year Planner View is my first effort at a custom view!  
![](https://www.b4x.com/android/forum/attachments/138374)  
It depends on jXUI, XUI Views, & B4XCollections.  
  
It displays every day in the selected year and returns the clicked day(s).  
A bunch of [Designer Script Extensions](https://www.b4x.com/android/forum/threads/b4x-dse-designer-script-extensions.141312/) are used to keep everything neat as the form is resized (credit to [USER=1]@Erel[/USER] for the examples in the DDD class on which they're all based :)).  
  
Each day is made of a label with its tag set to a custom type:  

```B4X
'date in yyyy-MM-dd. dayInYear is the day of the year, 1 to 366. dayNum with Sunday=1, row is equivalent to month number.  
    Type DayLabelData (label As B4XView, date As String, dayInYear As Int, dayNum As Int, row As Int, column As Int)
```

  
  
The class maintains two important objects:  
**YearPlannerView.VisibleDayLabels** is a map that holds every date in the selected year as the keys, with the corresponding DayLabelData as the values.  
**YearPlannerView.SelectedDays** is a B4XSet of every date that has been selected in yyyy-MM-dd.  
There are two methods allowing removal of items from the SelectedDays B4XSet:  

```B4X
'clear the selected days B4XSet  
Public Sub ClearSelectedDays  
    setSelectedDays.Clear  
End Sub  
  
'Remove the specified date from the selected days set  
'date supplied must be in yyyy-MM-dd format  
'Returns False if date is in an incorrect format or does not exist in the Selected Days set.  
Public Sub RemoveFromSelectedDays (date As String) As Boolean  
   
    If Not(IsValidDate(date)) Then Return False  
    If Not(setSelectedDays.Contains(date)) Then Return False  
   
    setSelectedDays.Remove(date)  
    Return True  
  
End Sub
```

  
  
Clicking one of the Days Header labels:  
![](https://www.b4x.com/android/forum/attachments/138375)  
 adds all instances of that day (i.e. days with the same day number) in the selected year to the SelectedDays set.  
Clicking one of the months adds all days in that month to the SelectedDays set.  
  
**Events**  
DayLabelClick (EventData As MouseEvent, ClickedDate as string)  
DaysHeaderLabelClick (EventData As MouseEvent, DayNumber as Int)  
MonthLabelClick (EventData As MouseEvent, MonthNumber as Int)  
YearChanged (year as int)  
  
The b4xlib and example are attached.  
  
All comments, criticisms, complaints, & congratulations will be gratefully received!  
  
**Updates:  
V1.01 - 2023-06-04**  
- Removed border from year selection B4XComboBox  
- Added property subs getUseHoverColor and setDayLabelColor  
- Added get/set property subs for HeaderTextColor, DayLabelTextColor, HoverColor, and MonthLabelTextColor  
- Moved pnlDays.RemoveAllViews from cmbYear\_SelectedIndexChanged to LoadDayLabels  
- Added ID (pane.id) to pnlMain ("ypv\_pnlMain"), pnlDays ("ypv\_pnlDays"), pnlMonths ("ypv\_pnlMonths"), pnlDaysHeader ("ypv\_pnlDaysHeader"),  
and pnlHeader ("ypv\_pnlHeader") for easier referencing in CSS Style files.  
- Added Public global Int DayLabelOriginalColour which holds the colour of lblDay when MouseEntered, so that we can revert to it on MouseExited…  
- Made DayLabelOriginalColour Public so that user can set it if they change the label colour in a click event for example.  
- Fixed error in setting of mDaysHoverColor in DesignerCreateView. Had it as Props.GetDefault("mDaysHoverColor"…, corrected to …("DaysHoverColor"…  
- Removed 'If Not(setSelectedDays.Contains(dld.date))' condition in the Day Label MouseEntered/Exited subs  
- Added lblSelAll to layout. This is a transparent label containing an arrowed cross that allows selection of all days on view with a single click.  
- Added SelectAllClick event which is raised when lblSelAll is clicked.  
  
**v1.00 - first release**