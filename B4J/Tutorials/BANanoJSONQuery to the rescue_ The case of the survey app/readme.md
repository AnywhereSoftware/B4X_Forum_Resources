### BANanoJSONQuery to the rescue: The case of the survey app. by Mashiane
### 09/23/2019
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/109839/)

Ola  
  
I have about 125 questions and each question has 1 possible answer from 4 responses.  
  
Let me depict everything like this…  
  
1. Responses ( a user should only select one using a radio box)  
  

```B4X
function getResponses(){  
    let responses = [{"id":"0", "value":"Not at All"}, {"id":"1", "value":"Little"},{"id":"2", "value":"Some"},{"id":"3", "value":"Much"}];  
    return responses;  
}
```

  
  
2. Questions (each question should be answered.)  
  

```B4X
function getQuestions(){  
let questions = [  
    {"id":1,"title":"1. I have a desire to speak direct messages from God that edify or exhort or comfort others.","gift":"a","response":"-1"},  
    {"id":2,"title":"2. I have enjoyed relating to a certain group of people over a long period of time, sharing personally in their successes and failures.","gift":"b","response":"-1"},  
    {"id":3,"title":"3. People have told me that I have helped them learn some biblical truth in a meaningful way.","gift":"c","response":"-1"},  
    {"id":4,"title":"4. I have applied spiritual truth effectively to situations in my own life.","gift":"d","response":"-1"},
```

  
  
As noted above, each question has an id, a response (from 1) and a gift. \*\*\* IMPORTANT  
  
3. Gifts (each question answered feeds to the gifts file) Each gift has "given" answers.  
  

```B4X
function getGifts(){  
let gifts = [  
    {"id":"a","title":"Prophecy","responses":{"1":"0","26":"0","51":"0","76":"0","101":"0"},"score":"0","description":"","scriptures":[]},  
    {"id":"b","title":"Pastor","responses":{"2":"0","27":"0","52":"0","77":"0","102":"0"},"score":"0","description":"","scriptures":[]},
```

  
  
For example, for gift a, the questions that feed into it are 1,26,51,76 and 101. All gifts have 5 questions. The score is the total of all responses for the questions.  
  
Let's look at how all of this translates..  
  
![](https://www.b4x.com/android/forum/attachments/84150)   
  
Problem Statement  
  
1. We need to select all questions with responses and update the gifts and then the score.  
  
When a person answers a question between 0 Not al all and 3 Much, we need to find all questions with responses. As this is saved as a mapped list, using JSONQuery did that easily..  
  
Solution:  
1. When a question is answered we save the state of the questions and their responses. We need to read this and then get the answer, the question id and the response. On init all question responses are -1.  
  

```B4X
questions = Vue.GetState("questions")  
    'get questions that have responses only  
    Dim jsonQ As BANanoJSONQuery  
    jsonQ.Initialize(questions)  
    Dim ansQ As BANanoJSONQuery = jsonQ.Where($"{'response.$ne':'-1'}"$).SelectFields(Array("id", "gift", "response")).toJQ  
    Dim ansL As List = ansQ.All  
    Dim answers As Int = ansL.Size  
    'update the latest progress  
    Vue.SetState(CreateMap("progress":answers))  
    BANano.setlocalstorage("progress", answers)  
    'group responses by gift  
    Dim ansG As Map = ansQ.GroupBy("gift").All
```

  
  
2. We need then to get all gifts from the questions and update the gifts state. To do this, we use the GroupBy JSONQuery clause of BANano. Whala.  
  
3. The next step is to use the grouped records and update the 'responses' matrix of the 'gifts'.  
  
Rather a quick exercise than running a loop jah!!  
  
Ta!