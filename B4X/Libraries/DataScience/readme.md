###  DataScience by Hamied Abou Hulaikah
### 08/14/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/142319/)

This is a library contains Linear Regression class that predicts Y value for any given data contains X, Y row data.  
easy of use:  

```B4X
    Dim lr As LinearRegression  
    lr.Initialize(File.DirAssets,"dm.csv",",",2,5,False)   
    xui.MsgboxAsync(lr.predict(100), lr.Score)
```

  
X: is independent variable (feature variable)  
Y: is dependent variable (target variable)  
  
I'll add later the rest of data science classes that will be the key of pure ML in B4X.