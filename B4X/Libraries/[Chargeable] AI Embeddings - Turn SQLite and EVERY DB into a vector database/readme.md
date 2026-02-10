###  [Chargeable] AI Embeddings - Turn SQLite and EVERY DB into a vector database by hatzisn
### 02/02/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170156/)

We are all familiar with AI Embeddings. They are the base in **RAG (Retrieval Augmented Generation) for AI**. This library converts **SQLite** **and every database** into a **vector database**. The embeddings of the chunked text must be saved as text (the json list toCompactString) in SQLite and the other non vector DBs. This means that **you can do RAG without accessing external databases** (or using **in B4J also other non vector databases**) directly in your iOS, Android, Window/Linux/Mac app. It contains all four ways of calculation of embeddings distance because different AI models use different embeddings approach.  
  
The object is AIEmbeddings and when you define the object, then you start writting for example:  
  

```B4X
Dim aiemb As AIEmbeddings  
aiemb.Instructions
```

  
  
and you get a code suggestion that you can copy to start directly.  
  
You will notice that you have to define in the AIQuery method an acceptable distance (MinimumOrMaximumDistance). For two of the distance calculations this is the minimum acceptable similarity and for the other two distance calculations it is the maximum acceptable distance. You will notice that **it is extremely fast** as **it uses approaches used in arithmetical methods** to return the result. The **price is 49.99EUR** and you can **send me a private message** if you want to acquire this b4xlib.  
  
In post#4 there is **a video** showcasing everything.