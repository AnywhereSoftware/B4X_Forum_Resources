### Embedding native android views or widgets in b4a by jkhazraji
### 09/25/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/172154/)

This is done by inflating xml files that are intended for native Android apps. Since the xml code contains the view, it will be shown (and can be manipulated) in b4a code.  
Let's take the following xml file:  

```B4X
 <?xml version="1.0" encoding="utf-8"?>  
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"  
    android:layout_width="match_parent"  
    android:layout_height="match_parent"  
    android:layout_marginTop="20dp"  
    android:background="#FFFFFF">  
  
    <androidx.swiperefreshlayout.widget.SwipeRefreshLayout  
        android:id="@+id/swipetorefresh"  
        android:layout_width="match_parent"  
        android:layout_height="match_parent">  
  
        <ListView  
            android:id="@+id/RsListView"  
            android:layout_width="match_parent"  
            android:layout_height="match_parent"  
            android:dividerHeight="1dp"  
            android:divider="#D3D3D3"/>  
  
    </androidx.swiperefreshlayout.widget.SwipeRefreshLayout>  
  
</RelativeLayout>
```

  
Which has 'swiperefreshlayout' that is not a native b4a view.  
But stop here! We need to add the relevant Android library from SDK manager.  
In this case we add the line:  

```B4X
#AdditionalJar:androidx.swiperefreshlayout:swiperefreshlayout
```

  
Now we established the **swipetorefreshlayout,** and are ready to show it. A Listview is included inside it as shown above.  
Now, we need a function to inflate the xml file into a view that can be added to the activity or Root.  
Here is the inflator function:  

```B4X
Sub InflateLayout(LayoutName As String, Parent As Panel) As View  
    Dim context As JavaObject  
    context.InitializeContext  
  
    ' Get Resources and LayoutInflater  
    Dim resources As JavaObject  
    resources = context.RunMethod("getResources", Null)  
      
    Dim inflater As JavaObject  
    inflater = context.RunMethod("getSystemService", Array("layout_inflater"))  
  
    ' Get the resource ID (e.g., R.layout.my_layout)  
    Dim resName As String = LayoutName.Replace(".xml", "") ' Remove .xml extension  
    Dim resID As Int = resources.RunMethod("getIdentifier", Array(resName, "layout",Application.PackageName))  
      
    If resID = 0 Then  
        Log("Error: Layout file not found in resources - " & LayoutName)  
        Return Null  
    End If  
  
    ' Inflate using the resource ID  
    Dim view As JavaObject  
    view = inflater.RunMethod("inflate", Array(resID, Parent, False))  
  
  
    Return view  
End Sub
```

  
It produces a view from relevant xml code.  
Let's call the inflated view 'inflatedView' and add it to Root ( in B4XPages)  

```B4X
'Inflate the XML layout  
    Dim inflatedView As View = InflateLayout("main", Root)  
  
    If inflatedView.IsInitialized = False Then  
        Log("ERROR: main.xml could not be inflated")  
        Return  
    End If  
  
    Root.AddView(inflatedView, 0, 0, 100%x, 100%y)
```

  
Of course we should have created the xml file in manifest editor beforehand as follows:  

```B4X
CreateResource(layout, main.xml, <?xml version="1.0" encoding="utf-8"?>  
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"  
    android:layout_width="match_parent"  
    android:layout_height="match_parent"  
    android:layout_marginTop="20dp"  
    android:background="#FFFFFF">  
  
    <androidx.swiperefreshlayout.widget.SwipeRefreshLayout  
        android:id="@+id/swipetorefresh"  
        android:layout_width="match_parent"  
        android:layout_height="match_parent">  
  
        <ListView  
            android:id="@+id/RsListView"  
            android:layout_width="match_parent"  
            android:layout_height="match_parent"  
            android:dividerHeight="1dp"  
            android:divider="#D3D3D3"/>  
  
    </androidx.swiperefreshlayout.widget.SwipeRefreshLayout>  
  
</RelativeLayout>)
```

  
This will create main.xml file in res/layout folder.  
Ready to get the swipeToRefresh view id from the inflatedView. For that, we have the following Sub:  

```B4X
Sub GetResourceId(name As String, resType As String) As Int  
    Dim jo As JavaObject  
    jo.InitializeContext  
    Return jo.RunMethodJO("getResources", Null).RunMethod("getIdentifier", _  
        Array(name, resType, Application.PackageName))  
End Sub
```

  
Then:  

```B4X
'Find SwipeRefreshLayout inside the inflated XML  
    Dim rootJO As JavaObject = inflatedView  
    Dim swipeJO As JavaObject = rootJO.RunMethod("findViewById", Array(swipeId))
```

  
Next step is create event that fires when we refresh the view  

```B4X
'Create listener  
    Dim event As Object = swipeJO.CreateEventFromUI("androidx.swiperefreshlayout.widget.SwipeRefreshLayout.OnRefreshListener","onRefreshing",Null)  
  
    swipeJO.RunMethod("setOnRefreshListener", Array(event))  
  
'  
''  
Private Sub onRefreshing_Event(MethodName As String, Args() As Object)  
    Log($"Refreshing:${MethodName}"$)  
'    lottieAnimationView.RunMethod("playAnimation", Null)  
    Update  
    
End Sub  
Private Sub Update  
    ' When refresh is done:  
    swiperefresh.As(JavaObject).RunMethod("setRefreshing", Array(False))  
    Log("Refresh done")  
      
End Sub
```

  
And we are done!