### Text similarity with SIMHASH by Quandalle
### 01/28/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/126975/)

To find similarities between documents (search for plagiarism, duplicate similar documents, …) one of the algorithms widely used for large collections of documents is SIMHASH.  
  
A SIMHASH hash is a single sequence of bits (usually 64 bits) generated from a set of features in such a way that changing a small fraction of those features will cause the resulting hash to change only a small fraction of its bits; (unlike cryptographic hash functions like md5, sha256…where a small change produces a very different hash result)  
  
To compare the similarity of two documents it is enough to calculate the SIMHASH hash and then to calculate the Hamming difference (very fast) between the two SIMHASH obtained.  
If the Hamming difference is 0 and up to a maximum of 3 (to be defined) we can consider that the documents are similiar and according to the requirement analyze them in more detail with algorithms looking for differences but much more expensive in time.  
  
in large document databases SIMHASH is calculated and stored in the database when the document is added. For the search for similarity it is then sufficient to calculate only the Hamming differences between all the SIMSHASH of the other documents. Even if the search by Hamming distance is very fast, complementary techniques exist for databases containing millions of documents.  
  
Google has patented SIMHASH , but leaves it free as far as I know, and a lot of software uses it.  
  
The code module contains the implementation of SIMHASH (64-bit hash returned as long type).  
The text is decomposed into tokens and an internal hash on each of the tokens is performed with the hash function based on the Murmur algorithm. The module is provided as source and you can change if necessary the token splitting, remove some non-significant tokens, or use another internal hash function.  
  

```B4X
Sub AppStart (Args() As String)  
  
    Dim s1 As String = "Temporis suscipitur nomen certamina canities tribus per nomen et securitas et canities"  
    Dim hash1 As Long = SimHash.SimHash64(s1)  
    Log("hash s1 : " & SimHash.LongTo01String(hash1))  
  
    Dim s2 As String = "emporis suscipitur nomen certamina canities tribus per nomen et securitas et canities"  
    Dim hash2 As Long = SimHash.SimHash64(s2)  
    Log("hash s2 : " & SimHash.LongTo01String(hash2))  
  
    Dim s3 As String = "canities tribus"  
    Dim hash3 As Long = SimHash.SimHash64(s3)  
    Log("hash s3 : " & SimHash.LongTo01String(hash3))  
   
    Log("distance results")  
    Log("Distance beetween s1 and s2 : "  & SimHash.HammingDistance(hash1,hash2))  
    Log("Distance beetween s1 and s3 : "  & SimHash.HammingDistance(hash1,hash3))  
    Log("Distance beetween s2 and s3 : "  & SimHash.HammingDistance(hash2,hash3))  
   
End Sub
```

  
  
the **SimHash64** function calculates the Hash of a string and returns a long  
the functions **LongTo01String** and **LongToHexString** allow to display a hash (long) as either a binary string (64 characters) or a hexdecimal string (16 characters)  
the **HammingDistance** function allows to calculate the Hamming distance between two hashs (long) and returns an integer giving the number of different bits  

```B4X
hash s1 : 1000111111100001101000100100010110110001010010000011110111010100  
hash s2 : 1000111111100001101000100100010110110001010010000011100111010100  
hash s3 : 0000001001000001111000000110010100010000010000000010000010000000  
distance reuslts  
Distance beetween s1 and s2 : 1  
Distance beetween s1 and s3 : 20  
Distance beetween s2 and s3 : 19
```

  
**Important**: even if the example provided contains only strings of a few words, the algorithm is designed to work with large documents and not with small sentences.  
  
The code module is for B4J (not verified) but it can if necessary be adapted to B4A by changing the initialization of the variable "inline" with inline.InitializeStatic(Application.PackageName & ".SimHash") and also check the results (the shift operations used in the code could introduce side effects). But finally there is little chance that an Android will be used to manage large sets of documents. To compare for similarity some strings other algorithms exist like Levensthein