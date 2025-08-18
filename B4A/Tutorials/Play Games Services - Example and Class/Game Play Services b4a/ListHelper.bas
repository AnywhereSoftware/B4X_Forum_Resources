B4J=true
Group=Default Group\Code Modules
ModulesStructureVersion=1
Type=StaticCode
Version=8
@EndOfDesignText@
'Static code module
Sub Process_Globals
#if b4j
'	Private fx As JFX
#end if

End Sub

'removes all items in denomenator from numerator
Public Sub ListSubtract(numerator As List, denomenator As List) As List
	Dim ThisNumerator As List = ByRefListCopy(numerator)
	Try
		If denomenator.Size=0 Then Return
	Catch
		Return ThisNumerator
	End Try
	For x=0 To denomenator.Size-1
		Dim ind=ThisNumerator.IndexOf(denomenator.Get(x))
		If ind>-1 Then ThisNumerator.RemoveAt(ind)
	Next
	Return ThisNumerator
End Sub

'get a list of sequential numbers
Public Sub GetSequentialNumberList(StartingNumber As Int, EndingNumber As Int) As List
	Dim RetList As List
	RetList.Initialize
	For x = StartingNumber To EndingNumber
		RetList.Add(x)
	Next
	Return RetList
End Sub

'gets nItems random items and Remove them from the original list if Remove is true
Public Sub GetNRandomItems(TheList As List, nItems As Int) As List
	Dim ReturnList As List
	ReturnList.Initialize
	Dim WorkingList As List = ByRefListCopy(TheList)
	If TheList.IsInitialized Then
		If TheList.Size>0 Then
			For x = 0 To nItems-1
				Dim CurrentItemNum As Int = Rnd(0, WorkingList.Size)
				ReturnList.Add(WorkingList.Get(CurrentItemNum))
				WorkingList.RemoveAt(CurrentItemNum)
			Next
		End If
	End If
	Return ReturnList
End Sub

'return a count of the number of unique items in the list
Public Sub GetUniqueItemCount(ListToExamine As List) As Int
	Dim UniqueItems As List
	UniqueItems.Initialize
	For Each item In ListToExamine
		If UniqueItems.IndexOf(item)=-1	Then UniqueItems.Add(item)
	Next
	Return UniqueItems.Size
End Sub

'makes a copy of the list
Public Sub ByRefListCopy(ListToCopy As List) As List
	Dim ReturnList As List
	ReturnList.Initialize
	For Each s As Object In ListToCopy
		ReturnList.Add(s)
	Next
	Return ReturnList
End Sub

'makes a copy of a map list
'for some reason these don't iterate with for each loops
Public Sub ByRefListCopyFromMapList(ListToCopy As List) As List
	Dim ReturnList As List
	ReturnList.Initialize
	For x = 0 To ListToCopy.Size-1
		ReturnList.Add(ListToCopy.Get(x))
	Next
	Return ReturnList
End Sub


'returns a list with values between the indexes
Public Sub GetSubset(ListToSubset As List, StartIndex As Int, EndIndex As Int) As List
'	Log($"GetSubset StartIndex=${StartIndex}, EndIndex=${EndIndex}"$)
	Dim RetList As List
	RetList.Initialize
	For x = StartIndex To EndIndex
		RetList.Add(ListToSubset.Get(x))
	Next
	Return RetList
End Sub

'separates list values by comma and returns a string that contains all the values
Sub ListToCSV(l As List) As String
	Dim Retval As String = ""
	If l.IsInitialized Then
		If l.Size>0 Then
			For x=0 To l.Size-1
				If x<l.Size-1 Then
					Retval=Retval&l.Get(x)&","
				Else
					Retval=Retval&l.Get(x)
				End If
			Next
		End If
	End If
	Return Retval
End Sub

'separates list values by custom string and returns a string that contains all the values
Sub ListToCustomCSV(l As List, separator As String) As String
	Dim Retval As String = ""
	If l.IsInitialized Then
		If l.Size>0 Then
			For x=0 To l.Size-1
				If x<l.Size-1 Then
					Retval=Retval&l.Get(x)&separator
				Else
					Retval=Retval&l.Get(x)
				End If
			Next
		End If
	End If
	Return Retval
End Sub

'treat a 1D list as 2d
Sub ListToXY(l As List, x As Int, y As Int, TotalColumns As Int, TotalRows As Int, HorizStacked As Boolean) As Object
	''Log("ListToXY")
	If HorizStacked Then
		Return l.Get(x+y*TotalColumns)
	Else
		Return l.Get(y+x*TotalRows)
	End If
End Sub



'Sub ListIndexToXY(Index As Int, TotalColumns As Int, TotalRows As Int, HorizStacked As Boolean) As indices
'	Dim i As indices
'	i.Initialize
'	i.y=Floor(Index/TotalColumns)
'	i.x=Index-(i.y*TotalColumns+1)
'	Return i
'End Sub

'checks the given parameters to see if ListToXY would succeed
Sub ListToXYTest(l As List, x As Int, y As Int, TotalColumns As Int, TotalRows As Int, HorizStacked As Boolean) As Boolean
	Dim RetVal As Boolean
	If HorizStacked Then
		RetVal = x+y*TotalColumns < l.Size
	Else
		RetVal = y+x*TotalRows < l.Size
	End If
	If x<0 Or y<0 Then RetVal=False
	Return RetVal
End Sub

'removes items containing numbers between a starting and ending value
'these items take the form of 1,2 for example
Sub RemoveNumberItemsContaining(l As List, NumberStart As Int, NumberEnd As Int) As List
	Log("Remove Items Starting with "&NumberStart&" and "&NumberEnd)
	Dim RemoveList As List
	RemoveList.Initialize
	For x = 0 To l.Size-1
		Dim item As String = l.Get(x)
		For c = NumberStart To NumberEnd
			Dim item1 As String = Regex.Split(",", item)(0)
			Dim item2 As String = Regex.Split(",", item)(1)
			If item1=c Or item2=c Then
				RemoveList.Add(item)
			End If
		Next
	Next
	l = ListSubtract(l, RemoveList)
	Return l
End Sub

Sub RemoveByValue(l As List, value As Object) As List
	If l.IndexOf(value)>-1 Then l.RemoveAt(l.IndexOf(value))
	Return l
End Sub

Sub RemoveDuplicates(l As List) As List
	Dim CleanList As List
	CleanList.Initialize
	For Each item As Object In l
		If CleanList.IndexOf(item)=-1 Then CleanList.Add(item)
	Next
	Return CleanList
End Sub

#Region List Of List Functions
Public Sub ConvertListOfCSVStringsToListOfLists(ListOfCSVStrings As List) As List
	Dim RetList As List
	RetList.Initialize
	For Each Line As String In ListOfCSVStrings
		Dim CurrentList As List = Regex.Split(",", Line)
		RetList.Add(CurrentList)
	Next
	Return RetList
End Sub

Public Sub ListValuesToFloat(ListToConvert As List) As List
	Dim RetList As List
	RetList.Initialize
	For Each fl As Float In ListToConvert
		RetList.Add(fl)
	Next
	Return RetList
End Sub

Public Sub ConvertListOfCSVStringsToListOfListsFloatValues(ListOfCSVStrings As List) As List
	Dim RetList As List
	RetList.Initialize
	For Each Line As String In ListOfCSVStrings
		Dim CurrentList As List = Regex.Split(",", Line)
		
		RetList.Add(CurrentList)
	Next
	Return RetList
End Sub

'sums up the columns of a list of lists and returns the values in a rotated list
Public Sub Calc_SumListOfListColumns(ListOfLists As List) As List
	Dim RetList As List
	Dim ColumnCount As Int = ListOfLists.Get(0).As(List).Size
	RetList.Initialize
	For x = 0 To ListOfLists.Size-1
		Dim CurrentList As List = ListOfLists.Get(x)
		For y = 0 To ColumnCount-1
			If x=0 Then
				RetList.Add(CurrentList.Get(y))
			Else
				RetList.Set(y, RetList.Get(y).As(Float)+CurrentList.Get(y))
			End If
		Next
	Next
	Return RetList
End Sub

'get a column from a list of lists
Public Sub GetColumnFromListOfLists(ListOfLists As List, ColumnNumber As Int) As List
	Dim RetList As List
	RetList.Initialize
	For Each l As List In ListOfLists
		RetList.Add(l.Get(ColumnNumber))
	Next
	Return RetList
End Sub


'get a column from a list of lists
Public Sub DropColumnFromListOfLists(ListOfLists As List, ColumnNumber As Int) As List
	Dim RetList As List
	RetList.Initialize
	For Each l As List In ListOfLists
		Dim l2 As List
		l2.Initialize
		l2.AddAll(l)
		l2.RemoveAt(ColumnNumber)
		RetList.Add(l2)
	Next
	Return RetList
End Sub

Public Sub AddColumnToListOfLists(ListOfLists As List, ColumnValues As List) As List
	Dim RetList As List
	RetList.Initialize
	For x = 0 To ListOfLists.Size-1
		Dim CurrentRowList As List
		CurrentRowList.Initialize
		CurrentRowList.AddAll(ListOfLists.Get(x))
		CurrentRowList.Add(ColumnValues.Get(x))
		RetList.Add(CurrentRowList)
	Next
	Return RetList
End Sub
#End Region

#Region List Calculations

'add, subtract, multiply, divide a list by a float value and return the result
Public Sub Calc_PerformMathOperationSingleValue(ListToOperateOn As List, Value As Float, Operation As String) As List
	Dim RetList As List
	RetList.Initialize
	For x = 0 To ListToOperateOn.Size-1
		Dim CurrentValue As Float = ListToOperateOn.Get(x)
		Select Operation
			Case "*"
				CurrentValue=CurrentValue*Value
			Case "/"
				CurrentValue=CurrentValue/Value
			Case "+"
				CurrentValue=CurrentValue+Value
			Case "-"
				CurrentValue=CurrentValue-Value
		End Select
		RetList.Add(CurrentValue)
	Next
	Return RetList
End Sub

'abandoned as there is better code using matrices available
''perform a multiple linear regression and return the characteristics of the regression line in a map
''xList is a list of the predictors in CSV
'Public Sub Calc_MultipleRegressionLine(xList As List, yList As List) As Map
'	Log("-=====>Calc_MultipleRegressionLine")
'	'convert XList to List of Lists
'	xList=ConvertListOfCSVStringsToListOfLists(xList)
'	Dim SumOfPredictors, SumOfSquaresPredictors, SumOfPredictorsProducts, SumOfProducts, PredictorsSquared, SquaredSumOfPredictorsDivN, SSPredictorsMinusSSPredictorsDivN, SPredictorsYProductMinusProductOfSumsDivN As List
'	SumOfPredictors=Calc_SumListOfListColumns(xList)
'	Log("SumOfPredictors "&SumOfPredictors)
'	PredictorsSquared=Calc_Multiply_ListOfLists(xList, xList)
'	SumOfSquaresPredictors=Calc_SumListOfListColumns(PredictorsSquared)
'	Log("SumOfSquaresPredictors "&SumOfSquaresPredictors)
'	
'	SumOfPredictorsProducts=Calc_SumOfCrossProducts(RotateListOfLists(xList), True)
'	Log("SumOfPredictorsProducts "&SumOfPredictorsProducts)
'	
'	
'	SumOfProducts=Calc_SumListOfListColumns(Calc_Multiply_ListOfLists_BySingleDimensionalList(xList, yList))
'	Log("SumOfProducts "&SumOfProducts)
'	SquaredSumOfPredictorsDivN=Calc_PerformMathOperationSingleValue(Calc_Multiply(SumOfPredictors, SumOfPredictors), xList.size, "/")
'	Log("SquaredSumOfPredictorsDivN "&SquaredSumOfPredictorsDivN)
'	SSPredictorsMinusSSPredictorsDivN=Calc_Subtract(SumOfSquaresPredictors, SquaredSumOfPredictorsDivN)
'	Log("SSPredictorsMinusSSPredictorsDivN "&SSPredictorsMinusSSPredictorsDivN)
'
'	Dim sum_y, sum_yy As Float
'	sum_y=Calc_Sum(yList, 0, yList.Size-1)
'	sum_yy=Calc_Sum(Calc_Multiply(yList, yList), 0, yList.Size-1)
'	
'	SPredictorsYProductMinusProductOfSumsDivN=Calc_Subtract(SumOfProducts, Calc_PerformMathOperationSingleValue(Calc_PerformMathOperationSingleValue(SumOfPredictors, sum_y, "*"), xList.Size, "/"))
'	
'	'b1=(RSX2X2*RSX1Y-RSX1X2*RSX2Y)/(RSX1X1*RSX2X2-RSX1X2*RSX1X2)
'
'
'	Dim RetMap As Map
'	RetMap.Initialize
'	Dim InterceptValue As Float=sum_y
'	For x = 0 To SumOfPredictors.Size-1
'		Dim CurrentProductXYSum As Float = SumOfProducts.Get(x)
'		Dim CurrentSquareOfPredictor As Float = SumOfSquaresPredictors.Get(x)
'		Dim CurrentSumOfPredictor = SumOfPredictors.Get(x)
'		Dim n As Int = xList.Size
'		Dim CurrentSlope As Float = (n*CurrentProductXYSum-CurrentSumOfPredictor*sum_y)/(n*CurrentSquareOfPredictor-CurrentSumOfPredictor*CurrentSumOfPredictor)
'		RetMap.Put("slope"&x, CurrentSlope)
'		InterceptValue = InterceptValue-CurrentSlope*CurrentSumOfPredictor
'	Next
'	InterceptValue = InterceptValue/n
''	var a = (n * x1_y_sum - x1_sum * y_sum) / (n * x1_sq_sum - x1_sum * x1_sum);
''	var b = (n * x2_y_sum - x2_sum * y_sum) / (n * x2_sq_sum - x2_sum * x2_sum);
''	var c = (y_sum - a * x1_sum - b * x2_sum) / n;
'	RetMap.Put("intercept", InterceptValue)
'	Return RetMap
'	
''add r2 at some point
''/* print r2 */
''var sumYSquared = 0;
''var sumYPredictedSquared = 0;
''var sumYMeanSquared = 0;
''For (var i = 0; i < n; i++) {
''  sumYSquared += y[i] * y[i];
''  var yPredicted = a * x1[i] + b * x2[i] + c;
''  sumYPredictedSquared += yPredicted * yPredicted;
''  sumYMeanSquared += (y[i] - sumY / n) * (y[i] - sumY / n);
''}
''var r2 = (sumYSquared - sumYPredictedSquared) / (sumYSquared - sumYMeanSquared);
''console.log('r2 = ' + r2);
'
'
'	'generated by OpenAI Codex for Javascript
'	'/* calculate multiple linear regression For the following points (x1=1, x2=3, y=10), (x1=2, x2=4, y=8), (x1=4, x2=5, y=9) */
'	'var x1 = [1, 2, 4];
'	'var x2 = [3, 4, 5];
'	'var y = [10, 8, 9];
'	'var n = x1.length;
'	'var x1_sum = 0;
'	'var x2_sum = 0;
'	'var y_sum = 0;
'	'var x1_sq_sum = 0;
'	'var x2_sq_sum = 0;
'	'var x1_y_sum = 0;
'	'var x2_y_sum = 0;
'	'For (var i = 0; i < n; i++) {
'	'  x1_sum += x1[i];
'	'  x2_sum += x2[i];
'	'  y_sum += y[i];
'	'  x1_sq_sum += x1[i] * x1[i];
'	'  x2_sq_sum += x2[i] * x2[i];
'	'  x1_y_sum += x1[i] * y[i];
'	'  x2_y_sum += x2[i] * y[i];
'	'}
'	'var a = (n * x1_y_sum - x1_sum * y_sum) / (n * x1_sq_sum - x1_sum * x1_sum);
'	'var b = (n * x2_y_sum - x2_sum * y_sum) / (n * x2_sq_sum - x2_sum * x2_sum);
'	'var c = (y_sum - a * x1_sum - b * x2_sum) / n;
'	'console.log('a = ' + a);
'	'console.log('b = ' + b);
'	'console.log('c = ' + c);
'End Sub

'multiply each list in the list by every other list
'exclude squaring will prevent multiplying the list by itself
Public Sub Calc_SumOfCrossProducts(ListOfLists As List, ExcludeSquaring As Boolean) As List
	Dim RetList As List
	RetList.Initialize
	For y = 0 To ListOfLists.Size-1
		For x = y To ListOfLists.Size-1
			Dim l1 As List = ListOfLists.Get(y)
			Dim l2 As List = ListOfLists.Get(x)
			If (ExcludeSquaring And Not(l1=l2)) Or Not(ExcludeSquaring) Then
				RetList.Add(Calc_Sum(Calc_Multiply(l1, l2), 0, l1.Size-1))
			End If
		Next
	Next
	
'	For Each l As List In ListOfLists
'		For Each l2 As List In ListOfLists
'			If (ExcludeSquaring And Not(l=l2)) Or Not(ExcludeSquaring) Then
'				RetList.Add(Calc_Multiply(l, l2))
'			End If
'		Next
'	Next
	Return RetList
End Sub

'perform a linear regression and return the characteristics of the regression line in a map
Public Sub Calc_RegressionLine(xList As List, yList As List) As Map
	Dim sum_x, sum_y, sum_xy, sum_xx, sum_yy As Int
	For i = 0 To xList.Size-1
		sum_x=sum_x+xList.Get(i)
		sum_y=sum_y+yList.Get(i)
		sum_xy=sum_xy+yList.Get(i)*xList.Get(i)
		sum_xx=sum_xx+xList.Get(i)*xList.Get(i)
		sum_yy=sum_yy+yList.Get(i)*yList.Get(i)
	Next
	Dim RetMap As Map
	RetMap.Initialize
	'	lr['slope'] = (n * sum_xy - sum_x * sum_y) / (n*sum_xx - sum_x * sum_x);
	Dim n As Int = xList.Size
	RetMap.Put("slope", (n *sum_xy - sum_x * sum_y) / (n*sum_xx - sum_x * sum_x))
'	lr['intercept'] = (sum_y - lr.slope * sum_x)/n;
	RetMap.Put("intercept", (sum_y - RetMap.Get("slope") * sum_x)/n)
	'r squared
'	lr['r2'] = Math.pow((n*sum_xy - sum_x*sum_y)/Math.sqrt((n*sum_xx-sum_x*sum_x)*(n*sum_yy-sum_y*sum_y)),2);
	RetMap.Put("r2", Power((n*sum_xy - sum_x*sum_y)/Sqrt((n*sum_xx-sum_x*sum_x)*(n*sum_yy-sum_y*sum_y)),2))
	Return RetMap
'generated by OpenAI Codex for Javascript	
'/* calculate linear regression For the following points (x=1, y=10), (x=2, y=8), (x=4, y=9) */
'	var x = [1, 2, 4];
'	var y = [10, 8, 9];
'	var lr = {};
'	var n = y.length;
'	var sum_x = 0;
'	var sum_y = 0;
'	var sum_xy = 0;
'	var sum_xx = 0;
'	var sum_yy = 0;
'	For (var i = 0; i < y.length; i++) {
'	sum_x += x[i];
'	sum_y += y[i];
'	sum_xy += (x[i]*y[i]);
'	sum_xx += (x[i]*x[i]);
'	sum_yy += (y[i]*y[i]);
'}
'	lr['slope'] = (n * sum_xy - sum_x * sum_y) / (n*sum_xx - sum_x * sum_x);
'	lr['intercept'] = (sum_y - lr.slope * sum_x)/n;
'	lr['r2'] = Math.pow((n*sum_xy - sum_x*sum_y)/Math.sqrt((n*sum_xx-sum_x*sum_x)*(n*sum_yy-sum_y*sum_y)),2);
'	console.log(lr);
End Sub


Public Sub Calc_RegressionLineSingleVector(DataList As List) As Map
	Dim sum_x, sum_y, sum_xy, sum_xx, sum_yy As Int
	For i = 0 To DataList.Size-1
		sum_x=sum_x+i
		sum_y=sum_y+DataList.Get(i)
		sum_xy=sum_xy+DataList.Get(i)*i
		sum_xx=sum_xx+i*i
		sum_yy=sum_yy+DataList.Get(i)*DataList.Get(i)
	Next
	Dim RetMap As Map
	RetMap.Initialize
	'	lr['slope'] = (n * sum_xy - sum_x * sum_y) / (n*sum_xx - sum_x * sum_x);
	Dim n As Int = DataList.Size
	RetMap.Put("slope", (n *sum_xy - sum_x * sum_y) / (n*sum_xx - sum_x * sum_x))
'	lr['intercept'] = (sum_y - lr.slope * sum_x)/n;
	RetMap.Put("intercept", (sum_y - RetMap.Get("slope") * sum_x)/n)
	'r squared
'	lr['r2'] = Math.pow((n*sum_xy - sum_x*sum_y)/Math.sqrt((n*sum_xx-sum_x*sum_x)*(n*sum_yy-sum_y*sum_y)),2);
	RetMap.Put("r2", Power((n*sum_xy - sum_x*sum_y)/Sqrt((n*sum_xx-sum_x*sum_x)*(n*sum_yy-sum_y*sum_y)),2))
	RetMap.Put("equation", $"y=${RetMap.Get("slope")}x + ${RetMap.Get("intercept")}"$)
	Return RetMap

'generated by OpenAI Codex for Javascript
'/* calculate the equation of the trendline For the following data points [100, 89, 110, 85, 72, 92, 60] */
'var data = [100, 89, 110, 85, 72, 92, 60];
'var sumX = 0;
'var sumY = 0;
'var sumXY = 0;
'var sumX2 = 0;
'For (var i = 0; i < data.length; i++) {
'  sumX += i;
'  sumY += data[i];
'  sumXY += i * data[i];
'  sumX2 += i * i;
'}
'var m = (data.length * sumXY - sumX * sumY) / (data.length * sumX2 - sumX * sumX);
'var b = (sumY - m * sumX) / data.length;
'console.log('y = ' + m + 'x + ' + b);	
End Sub

'multiply the values of one list times the values in the other
Public Sub Calc_Multiply(NumeratorList As List, DenominatorList As List) As List
	Dim ResultList As List
	ResultList.Initialize
	For x = 0 To NumeratorList.Size-1
		ResultList.Add(NumeratorList.Get(x)*DenominatorList.Get(x))
	Next
	Return ResultList
End Sub

'multiply the values of one list times the values in the other - each list contains a list of lists of the same dimensions
Public Sub Calc_Multiply_ListOfLists(NumeratorList As List, DenominatorList As List) As List
	Dim RetList As List
	Dim ColumnCount As Int = NumeratorList.Get(0).As(List).Size
	RetList.Initialize
	For x = 0 To NumeratorList.Size-1
		Dim CurrentList1 As List = NumeratorList.Get(x)
		Dim CurrentList2 As List = DenominatorList.Get(x)
'		For y = 0 To ColumnCount-1
			RetList.Add(Calc_Multiply(CurrentList1, CurrentList2))
'		Next
	Next
	Return RetList
End Sub

'multiply the values of one list times the values in the other - each list contains a list of lists of the same dimensions
Public Sub Calc_Multiply_ListOfLists_BySingleDimensionalList(ListOfLists As List, MultiplyBySingleDimensionList As List) As List
	Dim RetList As List
	Dim ColumnCount As Int = ListOfLists.Get(0).As(List).Size
	RetList.Initialize
	For x = 0 To ListOfLists.Size-1
		Dim CurrentList1 As List = ListOfLists.Get(x)
		Dim CurrentMultiplyValue As Float = MultiplyBySingleDimensionList.Get(x)
		Dim CurrentRowList As List
		CurrentRowList.Initialize
		For y = 0 To ColumnCount-1
			CurrentRowList.Add(CurrentList1.Get(y)*CurrentMultiplyValue)
		Next
		RetList.Add(CurrentRowList)
	Next
	Return RetList
End Sub

'subtract the values in the denominator list from the numerator list
Public Sub Calc_Subtract(NumeratorList As List, DenominatorList As List) As List
	Dim ResultList As List
	ResultList.Initialize
	For x = 0 To NumeratorList.Size-1
		ResultList.Add(NumeratorList.Get(x)-DenominatorList.Get(x))
	Next
	Return ResultList
End Sub

Public Sub GetMaxNum(l As List) As Int
	Dim retval As Int
	For Each n As Int In l
		If n>retval Then retval=n
	Next
	Return retval
End Sub

Public Sub Calc_Mean(l As List) As Float
	Dim retval As Float
	For Each n As Float In l
		retval=retval+n
	Next
	Return retval/l.Size
End Sub

Public Sub Calc_Variance(l As List) As Float
	Dim RunningTotal As Float
	Dim Mean As Float = Calc_Mean(l)
	For Each n As Float In l
		RunningTotal=RunningTotal+(Mean-n)*(Mean-n)
	Next
	Return RunningTotal/l.Size
End Sub

Public Sub Calc_SD(l As List) As Float
	Return Sqrt(Calc_Variance(l))
End Sub

Public Sub Calc_Z_Scores(l As List) As List
	Dim RetList As List
	RetList.Initialize
	Dim sd As Float = Calc_SD(l)
	Dim mean As Float = Calc_Mean(l)
	For Each n As Float In l
		Dim ThisZ As Float = (n - mean) / sd
		RetList.Add(ThisZ)
	Next
	Return RetList
End Sub

Public Sub Calc_Sum(l As List, StartIndex As Int, EndIndex As Int) As Float
	Dim RetVal As Float
	For x = StartIndex To EndIndex
		RetVal=RetVal+l.Get(x)
	Next
	Return RetVal
End Sub

Public Sub Calc_Accuracy_Float(PredictionsList As List, ActualList As List) As Float
	If Calc_Sum(PredictionsList, 0, ActualList.Size-1)=0 Then
		Log("calc accuracy - infinity")
	End If
	Return Calc_Sum(ActualList, 0, ActualList.Size-1) / Calc_Sum(PredictionsList, 0, ActualList.Size-1)
End Sub

'calculate the mean squared error between two lists
Public Sub Calc_MSE(PredictionsList As List, ActualList As List) As Float
	Dim ErrorList As List = Calc_Subtract(PredictionsList, ActualList)
'	Log("ErrorList.Size = "&ErrorList.Size)
	Return Power(Calc_Sum(ErrorList, 0, ActualList.Size-1), 2)/ActualList.Size
End Sub

Public Sub Calc_Error(PredictionsList As List, ActualList As List) As Float
	Dim ErrorList As List = Calc_Subtract(PredictionsList, ActualList)
'	Log("ErrorList.Size = "&ErrorList.Size)
	Return Calc_Sum(ErrorList, 0, ErrorList.Size-1)
End Sub

#End Region

Sub GetLastItem(l As List) As Object
	Return l.Get(l.Size-1)
End Sub

Sub StringToStringLength(ListOfStrings As List) As List
	Dim RetList As List
	If ListOfStrings.IsInitialized And ListOfStrings.Size>0 Then
		RetList.Initialize
		For Each str As String In ListOfStrings
			RetList.Add(str.Length)
		Next
	End If
	Return RetList
End Sub

'convert to list of lists and rotate rows and columns
Public Sub RotateListOfLists(DataList As List) As List
	Dim RetList As List
	RetList.Initialize
	
	For x = 0 To DataList.Get(0).As(List).Size-1
		For y = 0 To DataList.Size -1 
			If y=0 Then
				Dim Row As List
				Row.Initialize
				Row.Add(DataList.Get(y).As(List).Get(x))
				RetList.Add(Row)
			Else
				Dim Row As List
				Row=RetList.Get(x).As(List)
				Row.Add(DataList.Get(y).As(List).Get(x))
				RetList.Set(x, Row)
			End If
		Next
	Next
	Log("before rotation:")
	Log(DataList)
	Log("after")
	Log(RetList)
	Return RetList
End Sub
