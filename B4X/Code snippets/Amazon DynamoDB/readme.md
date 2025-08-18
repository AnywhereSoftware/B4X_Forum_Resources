###  Amazon DynamoDB by roumei
### 01/11/2022
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/137543/)

Amazon DynamoDB is a NoSQL database service: [AWS DynamoDB](https://aws.amazon.com/dynamodb/?nc1=h_ls)  
  
The attached project (B4J, B4A and B4I) shows how to access Amazon DynamoDB. The relevant code module is 'AWSDynamoDB'. You should first initialize the class with your credentials (put your keys in Main.Process\_Globals in order to obfuscate them):  

```B4X
Private DDB As AWSDynamoDB  
DDB.Initialize(DynamoDBAccessKey, DynamoDBSecretAccessKey, DynamoDBRegion)
```

  
  
This is an example of how to perform a GetItem request:  

```B4X
Wait For(DDB.GetItem(tbTable.Text, tbPartitionKey.Text, tbValue1.Text, tbSortKey.Text, tbValue2.Text)) Complete (Result As String)
```

  
  
Not all operations are implemented but it should be easy to add them based on the examples.  
  
![](https://www.b4x.com/android/forum/attachments/124092)