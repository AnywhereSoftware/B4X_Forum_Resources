### Random number between X and Y by tchart
### 08/27/2020
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/121634/)

There are many code snippets on the forum for random numbers. This example is for a project Im doing that needs to randomly select 1 of 4 LED's. Im not too worried that its pseduo random but this code will get you a random number between 1 and 4 (but makes sure you dont get the same number twice in a row).  
  
NOTE the upper limit is exclusive so for random numbers beween 1 and 4 we use 1 & 5. If you wanted a number between 2 and 6 you'd use 2 & 7.  
  
[ICODE]  
Dim rNumber As Byte = 0  
RunNative("getRandomNoDuplicate", Null)  
Log("rNumber = ", rNumber)  
[/ICODE]  
  
[ICODE]  
#if C  
int prevValue = -1;  
int lower = 1;  
int upper = 5;   
  
void getRandomNoDuplicate(B4R::Object\* o)  
{  
 static int offset = 0;  
 int randNumber = random(lower, upper);  
 if (prevValue == randNumber)  
 {  
 offset++;  
 if (offset >= upper - lower) offset = 1;  
 randNumber += offset;  
 if (randNumber >= upper) randNumber = lower + randNumber - upper;  
 }  
 prevValue = randNumber;  
 b4r\_main::\_rnumber = randNumber;  
}  
#End If  
[/ICODE]