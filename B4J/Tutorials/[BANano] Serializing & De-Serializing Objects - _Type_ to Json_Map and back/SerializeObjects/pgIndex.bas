B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.5
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private BANano As BANano
	Type Order(ProductKey As String, Amount As Double, Comment As String)
End Sub

Sub Init
	Dim myorder As Order
	myorder.Initialize 
	myorder.Amount = 10.00
	myorder.Comment = "This is a test..."
	myorder.ProductKey = "123456"
	'
	Dim toJSON As String = BANano.ToJson(myorder)
	Log("Type to JSON")
	Log(toJSON)
	
	
	Dim fromJSON As Order = BANano.FromJson(toJSON)
	Log("JSON to Type")
	Log(fromJSON.Amount)
	Log(fromJSON.Comment)
	Log(fromJSON.ProductKey)
	Log(fromJSON)
	   
	Dim orderMap As Map = BANano.FromJson(toJSON)
	Log("Type to Map")
	Log(orderMap)
	orderMap.put("_amount", 1000.00)
	
	'
	Dim m2j As String = BANano.ToJson(orderMap)
	Dim ut As Order = BANano.FromJson(m2j)
	Log("Map to Type")
	Log(ut)
	Log(ut.Amount)
End Sub
