### GiLoWordsGamesUtils by LordZenzo
### 05/18/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/83394/)

GiLoWordsGamesUtils **updated to version 1.8**  
  
Library useful to create word game apps, for any languages. Actually only English and Italian but I will add VERY SOON a method to import simple CSV file for any language  
  

- **Initialize**(CallBack As Object,EventName As String, logs As Boolean)
- **SetLanguage**(asLang As String)
if you want to create multiple languages you can use this property before loading the corresponding csv with the LoadCSVVocabulary command- **GetRandomWord**(WordLength As Int) As String
Returns a WordLenght long random word pass -1 for any long- **WordExists**(WordToSearch As String) As Boolean
Checks if a word exists (in the db, of course)- **FindAnagrams**(Word As String) As List
Returns a list of anagrams of the given Word- **GetWordsFromLetters**(Letters As String) As List
Returns a list of words containig the given Letters- **GetFilteredWords**(filtro As String) As List
Returns a list of words using the given Filter.
Filter should include SQLite wildcards:
% represents zero, one, or multiple numbers or characters;
\_ (underscore) represents a single character.- **GetFilteredWords2**(filtro As List, notfiltro As List) As List
Returns a list of words using the specified filter. and excluding the words corresponding to the second filter
Filter should include SQLite wildcards:
% represents zero, one, or multiple numbers or characters;
\_ (underscore) represents a single character.- **GetFilteredWordFromList**(filtro As String,Parole As List) As List
Returns a list of words using the given Filter, the filter is applied to the list
Filter should include SQLite wildcards:
% represents zero, one, or multiple numbers or characters;
\_ (underscore) represents a single character.- **CountWords**(FirstLetter As String) As Long
Returns a count of words starting with FirstLetter
Pass empty string for all words (size of dictionary)- **AddingWordsFromList**(wordlist As List)
To adding words in current DB from a List, one word for row- **LoadCSVVocabulary**(dir As String,fil As String,ForceNew As Boolean)
To fill the vocabulary from a csv file, one word for row, if ForceNew is True the previous dictionary words Will be deleted
this is the first command to use, possibly after assigning a name to the vocabulary, ForceNew = False prevents the vocabulary from being created at each start, losing any changes made to the vocabulary itself- **DeleteWords**(FilterType As String, FilterValue As String) As Int
Delete Words WHIT SQL Filter
Filter Type as "=", "LENGHT", "LIKE"
Filter Value as numeric or letteral example
type value
DeleteWords(**"**=","example") delete 1 word
DeleteWords("LENGHT", ">10") delete any words whit lenght >10 letters
DeleteWords("LENGHT","<9") delete any words whit lenght <9 letters
DeleteWords("LENGHT", "=7") delete any words whit lenght =7 letters
DeleteWords("LIKE", "a%") delete any words start whit a
return number of delete words- **DeleteWordsFromList**(ListWord As List) As Int
Deletes the words in the list
example of list: ('example','word','amb%')
eliminates the words example, word, and all words that begin with amb from the dictionary- **SetTimeOut**(t As Long)
the GetWordsFromLetters function can be very demanding and long if many letters are passed, with this property we avoid excessive waiting but obtain partial results- **Levenshtein\_distance**(x As String, y As String) As Int
return Levenshtein distance, for more information see [Wikipedia](https://en.wikipedia.org/wiki/Levenshtein_distance)- **SuggestsCorrection**(word As String) As List
for a mistaken word suggests a list of possible corrections
llink for 3 csv files corresponding to Italian, English, and Spanish  
  
[https://drive.google.com/file/d/10laSFgzSak\_XkjUEqkrwHNH0frSIxM-Q/view?usp=drive\_link](http://3 CSV)  
donate at least 15€ and I will send you this library  
 [![](https://www.paypalobjects.com/it_IT/IT/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WSBA89DQA2VVQ)