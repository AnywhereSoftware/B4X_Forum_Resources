### Creating libraries for B4R by Erel
### 03/23/2020
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/65718/)

Libraries are written in C++.  
Libraries are made of a single h file and one or more cpp files. Libraries can also include other h files which will not be exposed.  
  
All the files should be in the same folder.  
The attached h2xml jar reads the h file and creates the xml file that is used by the IDE.  
It is a command line program.  
  
You can run it with:  

```B4X
java -jar B4Rh2xml.jar <path to h file> <output file>
```

  
  
As the IDE libraries source code is available, this is the best way to learn how to build libraries.  
  
Start with a simple library such as rEEPROM.  
  
Personally I'm using Notepad++ to write the libraries.  
The IDE doesn't cache the libraries source (unlike in B4A). So you can save the file and run the project to test it.  
If the signature was changed then you need to run the h2xml tool and then right click on the libraries tab and choose Refresh.  
  
Metadata attributes (attribute case is not important):  
  
//~Version - The library version.  
//~DependsOn - Can appear multiple times. Adds a dependency on an external h file.  
//~ShortName - Each exposed class should have this attribute. This is the name that will appear in the IDE.  
//~Event - Can appear multiple times. Used by the IDE to autocomplete event subs.  
//~Author - Library author  
  
**Rules, tips and notes**  
  
Libraries should avoid using the heap (malloc or new should not be used).  
  
- Most libraries wrap another object. There are cases where you need to call the object constructor and you can only do it when the user calls the Initialize method.  
This is the case for example in rLiquidCrystal library.  
The solution is to create an array of bytes (named backend in this example) and then use placement new instead of new. This way we can generate a new object in the already allocated buffer.  
  
- Polling. If you need to call a method every loop iteration then you can add it to the PollerList.  
See Pin::AddListener for an example. Note that you can only add static methods. Pass a pointer to the class instance as the tag value.  
It is possible to remove the "polling". It is a bit more complicated. You can see it in rMQTT implementation.  
  
- Using the stack buffer.  
  
How can your method return a new object if it cannot use the heap?  
How can Common::NumberFormat return a string?  
  
In many cases the solution is to let the user pass an array to your method and then your method will use the array. However this is not always convenient. This is why B4R maintains another stack.  
You can use this stack for allocations. It will be popped when the calling sub ends.  
  
Simple example: ByteConverter::convertBytesToArray. It is simple because it only creates the Array object on the B4R stack.  
  
More complicated example: ByteConverter::HexToBytes. In this case the array with its data are created on the B4R stack.  
  
- Interrupts - The B4R code should not be called from an interrupt. Instead you should call pollers.setInterrupt. See rWire library (WriteSlave::receiveEvent).  
  
- Raising events - Any parameter with a type that starts with Sub will be treated as a "sub name". Practically the compiler will remove the quotes and lower case the string value. Your code will receive a function pointer.  
You can use the types declared with typedef in rCore.h or use your own types.  
  
- Pointers and objects - Only pointers to objects should be exposed to B4R.  
  
Please use the libraries developers questions for any question: <https://www.b4x.com/android/forum/forums/libraries-developers-questions.77/>