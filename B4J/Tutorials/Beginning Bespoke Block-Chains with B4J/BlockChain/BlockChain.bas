B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'A blockchain Is literally a chain of blocks linked To one another through the linked list structure. One thing 'To note however, Is that instead of holding a traditional pointer To refer To the previous block, it uses the 'hash of the previous block To refer To it.

Sub Class_Globals
	Private chain As List
	Type Block(index As Long, timestamp As Long, data As Map, previousHash As String, hash As String, nonce As Int)
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	chain.Initialize
	'genesis block
	createGenesis
End Sub

Private Sub createGenesis()
	Dim b As Block = NewBlock
	b.data.Put("description", "Genesis Block")
	b.hash = calculateHash(b)
	chain.Add(b)
End Sub

'Private Sub createNewBlock(nonce As Int, previousHash As String, hash As String) As Block
'	Dim b As Block = NewBlock
'	b.index = chain.Size + 1
'	b.timestamp = DateTime.Now
'	b.transactions = pendingTransactions
'	b.nonce = nonce
'	b.hash = hash
'	b.previousHash = previousHash
'	pendingTransactions.Initialize
'	chain.add(b)
'	Return b
'End Sub

Sub SetField(b As Block, k As String, v As String)
	b.data.Put(k, v)
End Sub

'new block definition
Sub NewBlock As Block
	Dim b As Block
	b.Initialize
	b.index = chain.Size + 1
	b.timestamp = DateTime.Now
	b.nonce = 0
	b.hash = ""
	b.data.Initialize
	b.previousHash = ""
	b.hash = ""
	Return b
End Sub

Private Sub calculateHash(b As Block) As String
	Dim dataAsString As String = CStr(b.index) & b.previousHash & CStr(b.timestamp) & Map2Json(b.data) & CStr(b.nonce)
	Dim thash As String = SHA256(dataAsString)
	Return thash
End Sub

Sub proofOfWork(b As Block) As Int
	Dim nonce As Int = 0
	Dim hash As String = hashBlock(b, nonce)
	Do While (hash.substring2(0, 4) <> "0000")
		nonce = nonce + 1
		hash = hashBlock(b, nonce)
	Loop
	Return nonce
End Sub

Sub hashBlock(b As Block, nonce As Int) As String
	Dim dataAsString As String = b.previousHash & CStr(nonce) & Map2Json(b.data)
	Dim thash As String = SHA256(dataAsString)
	Return thash
End Sub


'add a block to the chain
Sub addBlock(b As Block)
	b.previousHash = lastBlock.hash
    b.hash = calculateHash(b)
    chain.add(b)
End Sub

Private Sub Map2Json (M As Map) As String
	Return M.As(JSON).ToString
End Sub
'
'Private Sub List2Json (L As List) As String
'	Return L.As(JSON).ToString
'End Sub

Private Sub mineBlock(difficulty As Int)
	
End Sub

Private Sub CStr(obj As Object) As String
	Dim s As String = obj
	If obj = Null Then                                    'will be converted to the string "null" which is not what you want
		Return ""
	Else If s.startsWith("java.lang.Object@") Then        'unassigned    - probably an error but could possibly be handled
		Return ""
	Else if s.EqualsIgnoreCase("null") Then                'B4X Null String test
		Return ""
	Else
		Return s
	End If
End Sub

Private Sub lastBlock As Block
	Dim cSize As Int = chain.Size - 1
    Dim b As Block = chain.Get(cSize)
	Return b
End Sub
'
'get a block at index of the chain
Sub GetBlock(index As Int) As Block
	Dim b As Block = chain.Get(index)
	Return b
End Sub


'Sub createNewTransaction(amount As Object, theSender As String, theRecipient As String) As Int
'	Dim newTransaction As Map = CreateMap()
'	newTransaction.Put("amount", amount)
'	newTransaction.Put("sender", theSender)
'	newTransaction.Put("recipient", theRecipient)
'	newTransaction.Put("timestamp", DateTime.Now)
'    '
'	pendingTransactions.Add(newTransaction)
'	'
'	Dim tranPos As Int = getLastBlock.Get("index")
'	tranPos = tranPos + 1
'	Return  tranPos
'End Sub

'Sub hashBlock(previousBlockHash As String, currentBlockData As List, nonce As Int) As String
'	Dim bd As String = List2Json(currentBlockData)
'    Dim dataAsString As String = previousBlockHash & nonce & bd
'	Dim hash As String = SHA256(dataAsString)
'    Return hash
'End Sub

'Public Sub Map2Json (M As Map) As String
'	Return M.As(JSON).ToString
'End Sub



Private Sub SHA256 (str As String) As String
	Dim data() As Byte
	Dim MD As MessageDigest
	Dim BC As ByteConverter
'
	data = BC.StringToBytes(str, "UTF8")
	data = MD.GetMessageDigest(data, "SHA-256")
	Return BC.HexFromBytes(data).ToLowerCase
End Sub

'check validity of the complete block-chain
Sub CheckValidity As Boolean
    Dim bTot As Int = chain.Size
	Dim bCnt As Int = 0
	For bCnt = 1 To bTot - 1
        Dim currentBlock As Block = chain.Get(bCnt)
        Dim previousBlock As Block = chain.get(bCnt - 1)
		'
        If currentBlock.hash <> calculateHash(currentBlock) Then Return False
        If currentBlock.previousHash <> previousBlock.hash Then Return False
    Next
    Return True
End Sub