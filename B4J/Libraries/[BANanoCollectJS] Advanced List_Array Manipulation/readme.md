### [BANanoCollectJS] Advanced List/Array Manipulation by Mashiane
### 10/23/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/135385/)

Ola  
  
I've been using this for some List / Array management functions I needed. This is a wrap for BANano of this awesome js library, <https://collect.js.org/>  
  
Of course I'm not using everything here, thus for your explorations, check the link above on how everything works. You can pass it a JSON string / List. What I liked was the ease of use. If you have questions, post on the github of the author.  
  
#SharingTheGoodness  
  
**BANanoCollectJS**  

- **Initialize** (lst As List) **As BANanoCollectJS**
initialize with a list of objects- **InitializeJSON** (jsonString As String) **As BANanoCollectJS**
initialize with a JSON string- **sortBy** (fld As String) **As BANanoCollectJS**
sort an array of objects by- **skip** (num As Int) **As BANanoCollectJS**
skip- **skipUntil** (num As Int) **As BANanoCollectJS**
skipUntil- **skipWhile** (num As Int) **As BANanoCollectJS**
skipWhile- **slice** (num As Int) **As BANanoCollectJS**
slice- **slice1** (num As Int, endAt As Int) **As BANanoCollectJS**
slice1- **splice** (num As Int) **As BANanoCollectJS**
splice- **take** (num As Int) **As BANanoCollectJS**
take- **takeUntil** (num As Int) **As BANanoCollectJS**
takeUntil- **split** (num As Int) **As BANanoCollectJS**
split into groups- **splice1** (num As Int, endAt As Int) **As BANanoCollectJS**
splice1- **sortByDesc** (fld As String) **As BANanoCollectJS**
sortByDesc- **unique As List**
unique- **last As Object**
last- **unique1** (fld As String) **As List**
unique by field- **sum** (fld As String) **As Int**
sum- **toArray As List**
toArray from values- **toJson As String**
toJson- **sortKeys As BANanoCollectJS**
sortKeys- **sortDesc As BANanoCollectJS**
sortDesc- **sortKeysDesc As BANanoCollectJS**
sortKeysDesc- **all As List**
return all items- **where1** (fld As String, operator As String, value As String) **As BANanoCollectJS**
where- **where** (fld As String, value As String) **As BANanoCollectJS**
where- **forPage** (page As Int, offSet As Int) **As List**
forPage- **whereBetween** (fld As String, range As List) **As BANanoCollectJS**
whereBetween- **whereIn** (fld As String, range As List) **As BANanoCollectJS**
whereIn- **whereNotBetween** (fld As String, range As List) **As BANanoCollectJS**
whereNotBetween- **whereNotIn** (fld As String, range As List) **As BANanoCollectJS**
whereNotIn- **whereNotNull** (fld As String) **As BANanoCollectJS**
whereNotNull- **whereNull** (fld As String) **As BANanoCollectJS**
whereNull- **firstWhere** (fld As String, value As String) **As Map**
firstWhere- **exists** (fld As String, value As String) **As Boolean**
exists- **items As List**
items as list- **avg** (fld As String) **As Int**
the average of property in the array- **collapse As BANanoCollectJS**
merge arrays into 1- **chunk** (num As Int) **As BANanoCollectJS**
chunk break into smaller parts- **crossJoin** (objects As List) **As BANanoCollectJS**
crossJoin and return all possible permutations from the join- **concat** (objects As List) **As BANanoCollectJS**
concat- **contains1** (fld As String) **As Boolean**
contains a property or value- **flatten() As BANanoCollectJS**
flatten multi dimention array- **flip() As BANanoCollectJS**
flip values keys- **flatten1** (depth As Int) **As BANanoCollectJS**
flatten multi dimention array with deptth- **contains2** (fld As String, value As String) **As Boolean**
contains a property with value- **count As Int**
count- **eachItem** (module As Object, methodName As String, params As List) **As BANanoCollectJS**
each against callback- **reduceItem** (module As Object, methodName As String, params As List) **As BANanoCollectJS**
reduce against callback- **transform** (module As Object, methodName As String, params As List) **As BANanoCollectJS**
transform against callback- **takeWhile** (module As Object, methodName As String, params As List) **As BANanoCollectJS**
takeWhile against callback- **tap** (module As Object, methodName As String, params As List) **As BANanoCollectJS**
tap against callback- **rejectItem** (module As Object, methodName As String, params As List) **As BANanoCollectJS**
reject against callback- **mapItem** (module As Object, methodName As String, params As List) **As BANanoCollectJS**
map against callback- **filter** (module As Object, methodName As String, params As List) **As BANanoCollectJS**
filter against callback- **eachSpread** (module As Object, methodName As String, params As List) **As BANanoCollectJS**
eachSpread against callback- **every** (module As Object, methodName As String, params As List) **As BANanoCollectJS**
every against callback- **pipe** (module As Object, methodName As String, params As List) **As Object**
pipe against callback- **first As Map**
first- **forget** (prop As String) **As BANanoCollectJS**
forget - remove a key from the collection- **getValueAt** (pos As Int) **As Object**
get value at- **get** (prop As String) **As Map**
get item with key- **replaceItem** (item As Map) **As BANanoCollectJS**
replace item with key- **replaceRecursive** (item As Map) **As BANanoCollectJS**
replaceRecursive item with key- **groupBy** (fld As String) **As BANanoCollectJS**
groupBy- **has** (fld As String) **As Boolean**
has as key- **search** (value As Object) **As Object**
search for a value as return its key- **searchStrict** (value As Object) **As Object**
searchStrict for a value as return its key- **implode** (fld As String, delim As String) **As String**
implode join specific keys- **pad** (num As Int, value As String) **As String**
pad- **keys As BANanoCollectJS**
keys- **values As BANanoCollectJS**
values- **maxOfKey** (fld As String) **As Long**
max of a given key- **modeOfKey** (fld As String) **As List**
mode of a given key- **medianOfKey** (fld As String) **As Double**
medium of a given key- **merge** (lst As List) **As BANanoCollectJS**
merge- **only** (lst As List) **As BANanoCollectJS**
only- **nth** (inth As Int) **As BANanoCollectJS**
nth- **mergeRecursive** (lst As List) **As BANanoCollectJS**
mergeRecursive- **minOfKey** (fld As String) **As Int**
min of key- **isEmpty As Boolean**
isEmpty- **isNotEmpty As Boolean**
isNotEmpty- **selectFields** (flds As List) **As List**
only return these fields- **pluck** (fld As String) **As BANanoCollectJS**
pluck- **pop As BANanoCollectJS**
pop- **random As BANanoCollectJS**
random- **random1** (num As Int) **As BANanoCollectJS**
random number of items- **sort As BANanoCollectJS**
sort- **reverse As BANanoCollectJS**
reverse- **shift As BANanoCollectJS**
shift- **shuffle As BANanoCollectJS**
shuffle- **prepend** (xitems As List) **As BANanoCollectJS**
prepend- **push** (xitems As List) **As BANanoCollectJS**
push- **put** (xitems As List) **As BANanoCollectJS**
put- **pull** (prop As String) **As BANanoCollectJS**
pull- **diff** (flds As List) **As BANanoCollectJS**
diff- **diff** (flds As List) **As soc**
diffAssoc- **diffKeys** (flds As List) **As BANanoCollectJS**
diffKeys- **duplicates() As BANanoCollectJS**
duplicates- **except** (flds As List) **As BANanoCollectJS**
except - remove these keys on objects- **intersect** (flds As List) **As BANanoCollectJS**
intersect - remove these keys on objects- **join** (flds As List) **As BANanoCollectJS**
join- **keyBy** (skeyBy As String) **As BANanoCollectJS**
keyBy- **intersectByKeys** (flds As List) **As BANanoCollectJS**
intersectByKeys- **union** (flds As List) **As BANanoCollectJS**
union- **unwrap** (flds As List) **As BANanoCollectJS**
unwrap- **wrap** (flds As List) **As BANanoCollectJS**
wrap- **zip** (flds As List) **As BANanoCollectJS**
zip
  
PS: Get the js file from the website above, attached is the class.