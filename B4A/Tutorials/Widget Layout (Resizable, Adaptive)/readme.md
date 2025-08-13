### Widget Layout (Resizable, Adaptive) by Sagenut
### 05/28/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/115638/)

Not sure if this can be considered a Tutorial, my first attempt.  
Lately I started to play with Widgets, mostly for curiosity.  
The main problem I encountered was how to design the Layout to make it resizable and make the content to adapt automatically to size changes.  
Unluckily designing a widget layout with B4A Designer does not offer all the possibilities that we have while developing an App Layout.  
But this is due to how Android Widget works.  
I had some report from other users that they was fighting with the same issue.  
After some work it looks that I am finding the light at the end of the tunnel. ? ?  
So I decided to post here my work/result hoping that it can help other developers with their widgets.  
And also to receive help from the other developers to improve it yet.  
The trick is to overwrite the info.xml and the layout.xml of the widget, hand crafting the new files with CreateResource in the Manifest.  
So take a look at the Manifest to make comparison with the default files that you obtain by the first B4A compiling.  
[SPOILER="Explanation"]  
In the info.xml I added the string to enable Resize (only Horizontal Resize in this case)  

```B4X
android:resizeMode="horizontal"
```

  
and to add the preview image of the widget aspect  

```B4X
android:previewImage="@drawable/preview"
```

  
By default the preview would be same as the app icon.  
You will need to add a preview.png file in drawable and make it READ ONLY not to lose it during compilation.  
These lines  

```B4X
android:minWidth="350dp"  
android:minHeight="60dp"
```

  
allowed me to obtain the 4x1 initial size widget even working on different display sizes.  
Other values was resulting in 4x1 on large displays and 4x2 on smaller displays. Feel free to experiment more.  
These values does not take care of the size of the panel of the layout widget. I made it larger, as you can check with Designer.  
The widget and its content will be correctly displayed on every display (hopefully, I don't own so many devices) later with the layout file created in the Manifest.  
This line  

```B4X
android:minResizeWidth="140dp"
```

  
set the minimum size to which the widget can be resized. In this example it make possible to arrive to a 2x1 widget.  
It's instead possible to make it larger (on my device I can correctly fulfill up to 5x1 that its the full screen), this is why you should make the layout bigger in the Designer.  
The layout.xml must be checked carefully.  
It's composed of 3 LinearLayout. Be aware that this could not be the solution to everything.  
The first LinearLayout define how the entire widget space must be used. I set the orientation to Vertical  

```B4X
android:orientation="vertical"
```

  
From this point we can start to add view groups that will be added in column.  
Using these lines  

```B4X
android:layout_width="match_parent"  
android:layout_height="match_parent"
```

  
we define that we want to use the entire space available in both width and height to the maximum available.  
My widget contain 5 Labels.  
To position and dimension them I used 2 nested LinearLayout inside the first one.  
One row with 3 Labels of the same dimension (so 1/3 of the width) and another row with 2 Labels (half of the width).  
[SPOILER="Explanation of the 2 Nested LinearLayout"]  
These 2 nested LinearLayout are set to Horizontal to make 2 rows of views.  

```B4X
android:orientation="horizontal"
```

  
I wanted to have both rows to be equal and to use half the space in Height  

```B4X
android:layout_width="match_parent"  
android:layout_height="0dp"  
android:layout_weight="0.50"
```

  
Width is set to fulfill the entire widget, Height is set to "0dp" so it can be handled by the next line (WEIGHT) that works as a percentual.  
In this way the first row will use ALL the WIDTH and HALF of the HEIGHT of the entire widget.  
This define the space where I can put the first 3 Labels (in my example).  
Label1  

```B4X
android:layout_width="0dp"  
android:layout_height="match_parent"  
android:layout_alignParentLeft="true"  
android:layout_weight="0.3333"
```

  
Width is set to "0dp" because I want to manage it with the WEIGHT attribute.  
Height is set to fulfill the available space (remember that now our space is already set to HALF of the height of the entire widget so here it will fulfill only this HALF).  
AlignParentLeft is self-explanatory: let the view start from the left of the Parent that is the widget.  
Weight set the size to 1/3 of the available space and refer to the WIDTH because we set it to "0dp" to manage it.  
Label2  

```B4X
android:layout_width="0dp"  
android:layout_height="match_parent"  
android:layout_toRightOf="@+id/widget_4x1_label1"  
android:layout_weight="0.3333"
```

  
Width, Height and Weight follow the same explanation as in Label1.  
The position is set by "toRightOf" referred to Label1 to be next to it.  
Label3  

```B4X
android:layout_width="0dp"  
android:layout_height="match_parent"  
android:layout_toRightOf="@+id/widget_4x1_label2"  
android:layout_weight="0.3333"
```

  
Here we have an exact copy of Label2, just changing the "toRightOf" to be related to Label2.  
After this a new LinearLayout set how to manage the remaining space in the widget.  
The format it's exactly as the previous LinearLayout because in this case I left to manage the second half of the widget.  
So it will manage exactly the remaining 50% of Height of the entire widget.  
Again its set to Horizontal to make a row of view, and this new Frame will be put under the first one thanks to the initial setting in Vertical of the entire widget.  
I will not write again the code for Label4 and Label5 because they are exactly the same as Label1 and Label2.  
The only difference is the WEIGHT set to "0.50" because with only 2 views it was needed to divide equally the available Width.  
[/SPOILER]  
[/SPOILER]  
All of this information just explain my experience and my actual objective.  
It could contain wrong or unnecessary informations, excuse me in the case.  
It's a collage of all the info that I found, mainly from [Android Developer](https://developer.android.com/).  
Search for LinearLayout and RelativeLayout, even on the web.  
My widget attached in example just write in letters the first number of the current time (considering it as 0-23).  
It was a simple task to check if it was updating correctly every 30 minutes.  
Clicking on the yellow label will force to update it.  
Let me know if my explanation was clear enough or not. o\_O  
And let me know if this info helped you a bit in designing your widget.  
**NOTE: the example must be Compiled in Release Mode to work correctly.  
  
  
\*\*\* Update 28/05/2024 \*\*\***  
Added a third widget that implement a background image and use Relative Layout instead of nested Linear Layout.  
It's a Non Resizable widget because it was not working as desired.  
  
**\*\*\* Update 04/03/2024 \*\*\***  
The attached example has been modified to use the Receiver.  
The 4x1 Widget is Resizable (only horizontally) and the only function is to write in letter the hours of current time.  
The 1x1 Widget is Non Resizable and when clicked the image will rotate by 90 degrees.  
  
**\*\*\* Update 26/07/2021 \*\*\***  
The attached example has been modified and now include a second widget with a 1x1 Non Resizable Image.  
This can be useful to see how to implement more than 1 widget.  
Take a look at the Manifest.