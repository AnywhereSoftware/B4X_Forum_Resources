B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
Sub Class_Globals
End Sub

Public Sub Initialize
End Sub

'Sorts the list using the given comparator. The comparator should be a class instance with a sub with the following signature:
'<code>'Return a positive number if o1 greater than o2 (=o1 comes after o2), 0 if o1 equals to o2 and a negative number if o1 smaller than o2.
'Public Sub Compare (o1 As Object, o2 As Object) As Int
'	
'End Sub</code>
Public Sub Sort (Data As List, Comparator As Object)
	#if Not(B4i) or DEBUG
	QuickSort(Data, 0, Data.Size, Comparator)
	#else
	Me.As(NativeObject).RunMethod("_sort2::", Array(Data, Comparator))
	#end if
End Sub

#if Not(B4i) or DEBUG
Private Sub QuickSort (Data As List, StartIndex As Int, Length As Int, Comparator As Object)
	If Length > 1 Then
		Dim PivotIndex As Int = Rnd(0, Length)
		Dim r As Int = Partition(Data, StartIndex, Length, PivotIndex, Comparator)
		QuickSort(Data, StartIndex, r, Comparator)
		QuickSort(Data, StartIndex + r + 1, Length - r - 1, Comparator)
	End If
End Sub

Private Sub Partition(Data As List, StartIndex As Int, Length As Int, PivotIndex As Int, Comparator As Object) As Int
	Dim PivotValue As Object = Data.Get(StartIndex + PivotIndex)
	Swap(Data, StartIndex, PivotIndex, Length - 1)
	Dim L As Int = 0
	For i = 0 To Length - 2
		If CallSub3(Comparator, "Compare", Data.Get(StartIndex + i), PivotValue).As(Int) < 0 Then 'ignore
			L = L + 1
			Swap(Data, StartIndex, L - 1, i)
		End If
	Next
	Swap(Data, StartIndex, Length - 1, L)
	Return L
End Sub

Private Sub Swap (Data As List, StartIndex As Int, i1 As Int, i2 As Int)
	Dim o As Object = Data.Get(StartIndex + i1)
	Data.Set(StartIndex + i1, Data.Get(StartIndex + i2))
	Data.Set(StartIndex + i2, o)
End Sub
#Else
#if OBJC
- (NSString*)  _sort2:(NSArray*) _d :(NSObject*) _comparator{
B4IList* _data = [B4IList new];
_data.object = _d;
[self _quicksort:_data :(int) (0) :[_data Size] :_comparator];
return @"";
}
- (NSString*)  _quicksort:(B4IList*) _data :(int) _startindex :(int) _length :(NSObject*) _comparator{
int _pivotindex = 0;
int _r = 0;
if (_length>1) { 
_pivotindex = [self->___c Rnd:(int) (0) :_length];
_r = [self _partition:_data :_startindex :_length :_pivotindex :_comparator];
[self _quicksort:_data :_startindex :_r :_comparator];
[self _quicksort:_data :(int) (_startindex+_r+1) :(int) (_length-_r-1) :_comparator];
 };
return @"";
}

- (int)  _partition:(B4IList*) _data :(int) _startindex :(int) _length :(int) _pivotindex :(NSObject*) _comparator{
	NSObject* _pivotvalue =[_data Get:(int) (_startindex+_pivotindex)];
	int _l = 0;
	int _i = 0;
	[_data.object exchangeObjectAtIndex:_startindex + _pivotindex  withObjectAtIndex:_startindex + _length - 1];
	{
		const int limit4 = (int) (_length-2);
		_i = (int) (0) ;
		for (;_i <= limit4 ;_i = _i + 1 ) {
			NSObject* o1 = [_data Get:(int) (_startindex+_i)];
			if ([self compare:o1 :_pivotvalue :_comparator] < 0) {
				_l = _l+1;
				[_data.object exchangeObjectAtIndex:_startindex + _l-1  withObjectAtIndex:_startindex + _i];
		 	};
		 }
	};
	[_data.object exchangeObjectAtIndex:_startindex + _length-1  withObjectAtIndex:_startindex +_l];
	return _l;
}

- (int) compare:(NSObject*) o1 :(NSObject*) o2 :(id) comparator {
	return [comparator _compare:o1 :o2];
}
- (int) _compare:(NSObject*) o1 :(NSObject*) o2 {
return 0;
}
#End If
#End If