### SithasoDaisy by Sivasaravanan
### 02/27/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165857/)

dear Anele, can you help me from Bananomssqle result set can be create columns and setitems in SUDItable please help me  
  
 HelpTbl is sduitable  
 hlprs is resultset  
 fldname is column names of resultset  
   
 If helpQuery.Trim.Length > 0 Then  
 Dim hlprs As BANanoMSSQLE  
 hlprs.Initialize(Main.DataDB, "", "", "")  
 hlprs.SetConnection("localhost", "sa", "a123", "ItcotData")  
 sqlStmt = helpQuery  
 Log(sqlStmt)  
 sqlStmt = "Select orgCode,OrgName from OrganisationMaster"  
 hlprs.Execute(sqlStmt)  
 hlprs.JSON = banano.CallInlinePHPWait(hlprs.MethodName, hlprs.Build)  
 hlprs.FromJSON  
 Dim fldname As List  
 fldname.Initialize  
   
 If hlprs.result.Size > 0 Then  
 Dim getcolumn As Map = hlprs.result.Get(0)  
 For Each key As String In getcolumn.Keys  
 fldname.Add(key)  
 Next  
 End If  
   
   
 For index=0 To fldname.Size-1  
 helpttbl.AddColumnTextBox(fldname.Get(index),fldname.Get(index),False)  
 Next  
   
 Dim kl As Int   
Dim colName As String  
Dim colvalue As String  
 ' Build the list of items dynamically  
 For Each item As Map In helpRs.result  
 Dim newItem As Map  
 newItem.Initialize  
 For kl = 0 To item.Size -1  
 colName = """" & item.GetKeyAt(kl) & """"  
 colvalue = item.GetValueAt(kl)  
 Log(colName)  
 Log(colvalue)  
 newItem.Put(colName,colvalue)  
 Next  
 'Items.Add(CreateMap("hours":4, "on":True, "id":1, "rate":2, "email":"[email]user1@gmail.com[/email]", "link":"<https://tailwindcomponents.com/>", "progress":10, "active":False, "name":"Cy Ganderton", "job":"Quality Control Specialist", "color":"Error", "avatar":"./assets/face1.jpg", "country":"USA", "clicklink":56, "sm": "fa-brands fa-twitter"))  
 Items.Add(newItem)  
 Next  
   
in this Column name in helptbl is success  
data to required format also success   
rows also created when table setitems  
but values not displayed please help  
  
![](https://www.b4x.com/android/forum/attachments/162103)  
  
  
![](https://www.b4x.com/android/forum/attachments/162104)