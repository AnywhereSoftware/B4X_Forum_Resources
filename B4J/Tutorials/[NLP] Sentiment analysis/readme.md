### [NLP] Sentiment analysis by Erel
### 09/01/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/133922/)

![](https://www.b4x.com/android/forum/attachments/118580)  
  
The "sentiment" feature in the example project, uses NLP document categorizer feature to find whether the text is negative or positive.  
The dataset for the model contains movie reviews. This means that the domain for this specific categorizer is movie reviews.  
  
Training a model is done with opennlp command line tools.  
Important documentation: <https://opennlp.apache.org/docs/1.9.3/manual/opennlp.html#tools.doccat.training>  
We need to prepare a text file with the expected format.  
  
This is done with this simple program:  

```B4X
Sub Process_Globals  
    Private all As List  
End Sub  
  
Sub AppStart (Args() As String)  
    Dim TrainOrTest As String = "test"  
    all.Initialize  
    FillList($"C:\Users\H\Downloads\projects\aclImdb\${TrainOrTest}\neg"$, "negative")  
    FillList($"C:\Users\H\Downloads\projects\aclImdb\${TrainOrTest}\pos"$, "positive")  
    File.WriteList(File.DirApp, $"${TrainOrTest}.txt"$, all)  
    Log("complete: " & TrainOrTest)  
End Sub  
  
Private Sub FillList(Folder As String, Category As String)  
    For Each f As String In File.ListFiles(Folder)  
        all.Add(Category & " " & File.ReadString(Folder, f)) 'the text is already single line.  
    Next  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/118581)  
  
We create two files: train.txt and test.txt.  
  
Now we can build the model:  

```B4X
'apache-opennlp-1.9.3\bin  
opennlp DoccatTrainer -lang en -params props.txt -model en-movies.bin -data C:\Users\H\Downloads\projects\Movies\Objects\train.txt
```

  
props.txt:  

```B4X
Iterations=2000  
Cutoff=5
```

  
You can play with these two settings.  
  
The next step is to evaluate the model using the test data:  

```B4X
 opennlp DoccatEvaluator -model en-movies.bin -data C:\Users\H\Downloads\projects\Movies\Objects\test.txt -misclassified true -reportOutputFile 1.txt
```

  
The output file contents:  

```B4X
=== Evaluation summary ===  
  Number of sentences:  25000  
    Min sentence size:      4  
    Max sentence size:   2278  
Average sentence size: 228.52  
           Tags count:      2  
             Accuracy: 87.69%  
  
  
=== Detailed Accuracy By Tag ===  
  
————————————————————————-  
|      Tag | Errors |  Count |   % Err | Precision | Recall | F-Measure |  
————————————————————————-  
| positive |   1638 |  12500 | 0.131   | 0.883     | 0.869  | 0.876     |  
| negative |   1439 |  12500 | 0.115   | 0.871     | 0.885  | 0.878     |  
————————————————————————-
```

  
  
Precision - 88% of the items that were categorized as positive were actually positive documents.  
Recall - 86.9% of the positive documents were marked as positive.  
F-Measure - a combined score based on precision and recall.  
  
Overall accuracy is based on the scores of all tags.  
  
Whether it is good enough accuracy or not depends on the use case. It can be improved by increasing the trained dataset size, increasing the number of iterations, cleaning the dataset and in other ways.  
  
I find it to be an impressive result.  
  
The last step is to use the model in our program.  
You can see the code in the OpenNLP Example project.  
1. Load the model.  
2. Tokenize the text. The trainer uses a whitespace tokenizer. It is probably best to use it as well.  
2. Call nlp.Categorize  
3. Get the results from Paragraph.Categories. The highest scored category will be in Paragraph.BestCategory.