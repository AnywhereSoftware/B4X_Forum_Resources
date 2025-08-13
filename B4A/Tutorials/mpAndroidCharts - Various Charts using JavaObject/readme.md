### mpAndroidCharts - Various Charts using JavaObject by Johan Schoeman
### 06/15/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/161663/)

Have never done a B4A "wrapper" before making use of JavaObject only and thought I would see if I could get the PieChart of [**mpAndroidCharts**](https://github.com/PhilJay/MPAndroidChart) implemented by using B4A's JavaObject only. Here it is:  
  
![](https://www.b4x.com/android/forum/attachments/154627)  
  
Copy the attached Jar to your B4A additional library folder  
Sample project attached  
  
Try the various animation:  
  

```B4X
    'Linear, EaseInQuad, EaseOutQuad, EaseInOutQuad, EaseInCubic, EaseOutCubic, EaseInOutCubic, EaseInQuart, EaseOutQuart, EaseInOutQuart, EaseInSine, EaseOutSine, EaseInOutSine, EaseInExpo, EaseOutExpo, EaseInOutExpo, EaseInCirc, EaseOutCirc, EaseInOutCirc, EaseInElastic, EaseOutElastic, EaseInOutElastic, EaseInBack, EaseOutBack, EaseInOutBack, EaseInBounce, EaseOutBounce, EaseInOutBounce  
    Dim EasingOption As JavaObject  
    EasingOption.InitializeStatic("com.github.mikephil.charting.animation.Easing.EasingOption")  
    pieChart.RunMethod("animateY", Array(2000, EasingOption.GetField("EaseInCubic")))
```

  
  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: mpAndroidPieChart  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: portrait  
    #CanInstallToExternalStorage: False  
#End Region  
  
#AdditionalJar: mpChartLib  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private xui As XUI  
   
    Dim ctx As JavaObject  
    Dim pieChart As JavaObject  
    Dim Entry As JavaObject  
    Dim pieDataSet As JavaObject  
    Dim pieData As JavaObject  
    Dim Legend As JavaObject  
   
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
   
    ctx.InitializeContext  
    pieChart.InitializeNewInstance("com.github.mikephil.charting.charts.PieChart", Array(ctx))  
   
    'create the entries for the pie chart  
    Dim entryList As List  
    entryList.Initialize  
    For i = 0 To 4  
        entryList.Add(Entry.InitializeNewInstance("com.github.mikephil.charting.data.Entry", Array(Rnd(0, 100).As(Float), i)))  
    Next  
   
    Dim legendTitle As String = "Hello B4A"  
    pieDataSet.InitializeNewInstance("com.github.mikephil.charting.data.PieDataSet", Array(entryList, legendTitle))  
   
    'set the colors for the pie slices  
    Dim pieColors() As Int = Array As Int(Colors.Green, Colors.Yellow, Colors.Magenta, Colors.Cyan, Colors.Blue)  
    pieDataSet.RunMethod("setColors", Array(pieColors))  
    pieDataSet.RunMethod("setSliceSpace", Array(3.0f))  
  
    Legend.InitializeNewInstance("com.github.mikephil.charting.components.Legend", Null)  
    Legend = pieChart.RunMethod("getLegend", Null)  
  
    Dim Legendposition As JavaObject  
    Legendposition.InitializeStatic("com.github.mikephil.charting.components.Legend.LegendPosition")  
  
    'RIGHT_OF_CHART, RIGHT_OF_CHART_CENTER, RIGHT_OF_CHART_INSIDE, LEFT_OF_CHART, LEFT_OF_CHART_CENTER, LEFT_OF_CHART_INSIDE, BELOW_CHART_LEFT, BELOW_CHART_RIGHT, BELOW_CHART_CENTER, PIECHART_CENTER  
    Legend.RunMethod("setPosition", Array(Legendposition.GetField("BELOW_CHART_CENTER")))  
    Legend.RunMethod("setXEntrySpace", Array(7.0f))  
   
    Dim Legendform As JavaObject  
    'SQUARE, CIRCLE, LINE  
    Legendform.InitializeStatic("com.github.mikephil.charting.components.Legend.LegendForm")  
   
    Legend.RunMethod("setForm", Array(Legendform.GetField("SQUARE")))  
   
    'LEFT_TO_RIGHT, RIGHT_TO_LEFT  
    Dim Legenddirection As JavaObject  
    Legenddirection.InitializeStatic("com.github.mikephil.charting.components.Legend.LegendDirection")  
    Legend.RunMethod("setDirection", Array(Legenddirection.GetField("LEFT_TO_RIGHT")))  
    Legend.RunMethod("setTextSize", Array(14.0f))  
    Legend.RunMethod("setTextColor", Array(Colors.Black))  
   
    Dim legendText As List  
    legendText.Initialize  
    legendText.AddAll(Array As String("A", "B", "C", "D", "E"))  
   
    'Linear, EaseInQuad, EaseOutQuad, EaseInOutQuad, EaseInCubic, EaseOutCubic, EaseInOutCubic, EaseInQuart, EaseOutQuart, EaseInOutQuart, EaseInSine, EaseOutSine, EaseInOutSine, EaseInExpo, EaseOutExpo, EaseInOutExpo, EaseInCirc, EaseOutCirc, EaseInOutCirc, EaseInElastic, EaseOutElastic, EaseInOutElastic, EaseInBack, EaseOutBack, EaseInOutBack, EaseInBounce, EaseOutBounce, EaseInOutBounce  
    Dim EasingOption As JavaObject  
    EasingOption.InitializeStatic("com.github.mikephil.charting.animation.Easing.EasingOption")  
    pieChart.RunMethod("animateY", Array(2000, EasingOption.GetField("EaseInCubic")))  
   
    pieChart.RunMethod("setHoleColor", Array(Colors.Black))  
    pieChart.RunMethod("setHoleColorTransparent", Array(False))  
    pieChart.RunMethod("setDrawHoleEnabled", Array(True))  
    pieChart.RunMethod("setHoleRadius", Array(50.0f))  
    pieChart.RunMethod("setCenterText", Array("By Johan"))  
    pieChart.RunMethod("setDrawCenterText", Array(True))  
    pieChart.RunMethod("setDescription", Array("Done with JavaObject"))  
    pieChart.RunMethod("setCenterTextColor", Array(Colors.White))  
    pieChart.RunMethod("setCenterTextSize", Array(15.0f))  
    pieChart.RunMethod("setTransparentCircleColor", Array(Colors.Blue))  
    pieChart.RunMethod("setTransparentCircleRadius", Array(55.0f))  
    pieChart.RunMethod("setTransparentCircleAlpha", Array(100))  
    pieChart.RunMethod("setDrawSliceText", Array(True))  
    pieChart.RunMethod("setUsePercentValues", Array(True))  
    pieChart.RunMethod("setRotationAngle", Array(0.0f))  
    pieChart.RunMethod("setRotationEnabled", Array(True))  
    pieChart.RunMethod("setDescriptionTextSize", Array(9.0f))  
    pieChart.RunMethod("setDescriptionColor", Array(Colors.Magenta))  
  
    pieData.InitializeNewInstance("com.github.mikephil.charting.data.PieData", Array(legendText, pieDataSet))  
    pieData.RunMethod("notifyDataChanged", Null)  
    pieData.RunMethod("setValueTextSize", Array(12.5f))  
    pieData.RunMethod("setValueTextColor", Array(Colors.Black))  
  
    Dim tf As JavaObject  
    tf.InitializeStatic("android.graphics.Typeface")  
    pieData.RunMethod("setValueTypeface", Array(tf.GetField("SERIF")))  
  
    pieChart.RunMethod("notifyDataSetChanged", Null)  
    pieChart.RunMethod("setData", Array(pieData))  
   
    Activity.AddView(pieChart, 0, 0, 100%x, 80%y)  
     
    Activity.Invalidate  
  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub
```

  
  
The original project is here (wrapped it to a B4A library)  
<https://www.b4x.com/android/forum/threads/mpandroidcharts-various-type-of-graphs-charts-latest-library-v1-22-in-post-1.58017/>