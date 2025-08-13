### [PyBridge] Linear regression with scikit learn by Erel
### 02/17/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/165664/)

This example is based on: <https://scikit-learn.org/stable/auto_examples/linear_model/plot_ols.html>  
The steps are:  
  
1. Read the CSV file with StringUtils.  
2. Take the BMI and target columns.  
3. Split the data to train and test sets.  
4. Train the model with a call to LinearRegression.fit.  
5. Evaluate the model using the test data set.  
6. Plot it using MatplotLib.  
  
I also added a step where the plot is fetched back to B4J and displayed with a B4XImageView. You can instead call plot.run("show") to show the standard plot window (which has advantages over a static image).  
  
![](https://www.b4x.com/android/forum/attachments/161807)  
Note that the regression will work better with all inputs, instead of just the BMI. You can test it by adding all fields to "BMI":  

```B4X
For Each row() As String In data  
    Dim x As List  
    x.Initialize  
    For i = 0 To row.Length - 2 'the last column is the target  
        x.Add(row(i).As(Double))  
    Next  
    bmi.Add(x) 'the X input is expected to be a list of arrays.  
    target.Add(row(10).As(Double))  
Next
```

  
And skip the plotting code.  
  
Don't miss the dependencies line at the top.