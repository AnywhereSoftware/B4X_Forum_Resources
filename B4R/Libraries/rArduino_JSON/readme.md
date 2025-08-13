### rArduino_JSON by candide
### 04/30/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/166804/)

it is a wrapper for Arduino\_JSON library from <https://github.com/arduino-libraries/Arduino_JSON>  
  
this library add support for JSON  
each JsonVar variable is created in B4R by a class,  
  
a JsonVar can be bool, Long, ULong, Double or String or NULL to remove all datas.  
JsonVar can be in simple variable JsonVar, but also an Array , an Object structure, and also a mixed structure with Array and Object  
a variable can have max 8 levels of Array/Object in B4R  
in B4R each JsonVar is in this format :  
 var\_name(Array of Object(Nb, a, b, c, d, e, f, g, h)  
 - Nb = number of index levels used 0<8  
 - a, b, c, d, e, f, g, h can be string for Object structure or Int Number for Array  
 - only used levels are needed  
example :  
  
1)simple variable case:  
Private jvar0 As JSONVar 'create a JsonVar  
- jvar1.setBool(Array(0),True) ' set a bool value in a direct variable with Array(0) no Array, no Object  
- Log("jvar1 bool -> ",jvar1.getBool(Array(0))) 'will show bool value  
  
Array variable case :  
 jvar0.setNumberL(Array(1,0),124)  
 jvar0.setString(Array(1,1),"la suite")  
 jvar0.setNumberD(Array(1,2),43.752)  
 jvar0.setString(Array(1,3),"comment ca code")  
 - created jvar0(0), jvar0(1), jivar0(2), jvar0(3)  
  
Object variable case :  
 jvar11.setNumberL(Array(1,"Obj\_1"),12345)  
 jvar11.setNumberL(Array(2,"Obj\_2.1","Obj\_2.2"),320000)  
 - created jvar11("Obj\_1) and jvar11("Obj\_2.1)("Obj2.2")  
  
Mixed variable case  
 jvar11.setNumberL(Array(2,"Obj\_1",0),67890)  
 jvar11.setNumberL(Array(2,"Obj\_1",1),67889)  
 - created jvar11("Obj\_1")(0) and jvar11("Obj\_1")(0)  
   
- function parse can create a JsonVar structure from a String chain,  
  
- function stringify can create a String from a JsonVar structure