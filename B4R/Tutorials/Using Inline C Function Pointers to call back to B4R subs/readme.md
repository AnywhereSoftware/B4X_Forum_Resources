### Using Inline C Function Pointers to call back to B4R subs by miker2069
### 05/02/2020
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/117158/)

I use inline C in my B4R projects quite a bit in my projects. Mostly I have some C/C++ code I want to call from B4R subs - that's well documented on the forum (the Inline C intro [here](https://www.b4x.com/android/forum/threads/inline-c-c.65714/#content)). From time to time though I need to call a B4R sub from C/C++ - this [post](https://www.b4x.com/android/forum/threads/correct-this-misconseption-call-b4r-subs-from-inline-c-code-see-post-2.110022/#post-686935) does a decent job of explaining how to do that. What I wanted to do is expand on the second concept and take it a step further and use function pointers to create a **call back mechanicism** from your C/C++ code into B4R.  
  
Why would you want a call back mechanism? Well there may be instances that you have a great C/C++ library or code that works great as is - why go through the effort of re-writing in B4R. Or there are times when it's just not possible to re-write something in B4R. For example, I had a scenario where I needed an array of char strings - for example:  
  

```B4X
char    nodename[MAX_SENSORS][STR_BUFFER_SIZE]; //friendly name of the node
```

  
  
Simple enough in C/C++ and it's just easier to work with this in C/C++. I have a C/C++ class that has this and do all the "work" on my string array there. I then however have a need to ***notify*** B4R (call a sub) to then do something else with one of the elements of the string array - like write to the log, send to MQTT, save to spiffs, etc. You can do this very elegantly with C function pointers. The very nice thing is that your C/C++ class/library/code doesn't need to know anything about B4R or adding any of the B4R headers, or working with the B4R types (unless you want to).  
  
Here's a simple example of using a function pointer as a "New Data for MQTT event in B4R". I'll start with B4R. I have the following sub in my main module:  
  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    
    Private ret_string_buffer(64) As Byte 'populated by calling C/C++ code  
End Sub  
  
  
private Sub PublishStringtoMQTT()  
    'This sub is called from C/C++ code whenever there's a string to publish  
    'or do whatever you want to do with.  
    'the char string data will be set in ret_string_buffer by C/C++ before this is called  
  
    Log(ret_string_buffer) 'log it, then  
    MQTT.Publish("notify/newstring",ret_string_buffer) 'publish to mqtt which was setup elsewhere  
    
End Sub
```

  
  
The above is pretty straight forward, whenever there's a new char string to publish to MQTT this event (sub) will be called. So let's setup how this will be called from C/C++, first a really quick overview of function pointers (note the following description is paraphrased from this [page](https://www.geeksforgeeks.org/function-pointer-in-c/))  
  
In C, like normal data pointers (int \*, char \*, etc), we can have pointers to functions. Unlike normal pointers, a function pointer points to code, not data. Typically a function pointer stores the start of executable code. Unlike normal pointers, we do not allocate de-allocate memory using function pointers. A function’s name can also be used to get functions’ address. For example:  
  
  

```B4X
#include <stdio.h>  
// A normal function with an int parameter  
// and void return type  
void fun(int a)  
{  
    printf("Value of a is %d\n", a);  
}  
  
int main()  
{  
    void (*fun_ptr)(int) = fun;  
  
    fun_ptr(10);  
  
    return 0;  
}
```

  
  
A pointer to function is declared with the \* ,the general statement of its declaration is:  
  

```B4X
return_type (*function_name)(arguments)
```

  
  
In the above example, the return\_type is **void**, the function\_name is **fun\_ptr** and the arguments is just a single argument of type int. Note, the return type can be anything, in this simple example we just set it to void (no return). After the declaration you can assign fun\_ptr to a function matching the same function signature (arguments and return type).  
  

```B4X
void (*fun_ptr)(int) = fun;
```

  
  
So now **fun\_ptr**  points to the function **fun.**  We can then call the function using the function pointer like so:  
  

```B4X
 fun_ptr(10);
```

  
  
The same thing as calling the original function:  
  

```B4X
 fun(10);
```

  
  
You might pick up this is a pretty powerful feature of the C language (and many other languages including B4X implements this). Now that you have the basic concept of function pointers, let's see how to now call our B4R sub **PublishStringtoMQTT()** using this. I'm sure there are a few ways of doing this, here's how I've chosen to implement it which IMO is fairly straight forward.  
  
Back in our B4R main module, you need some an inline C for this task. I'll show the inline C and document it in the code, then explain it:  
  

```B4X
#if c  
#ifndef b4r_main_h  
#define b4r_main_h  
  
class b4r_radiomodule {  
public:  
  
//our b4r sub - remember all subs and process globals are lower case in C  
static void    _publishstringmqtt(void);  
  
};  
  
#endif  
  
//now define an extern to our function pointer. the function pointer variable is located  
//in some other .cpp module.  In the other .cpp module, we'll be able to call publish_string  
//passing in a pointer to a char array which is our string to publish to mqtt  
extern void     (*publish_string)(char *);  
  
//declare helpful functions  
void init(B4R::Object* o); //used to perform various initialization  
void publish(char *str); //helper function that will be the "pointed to" function  
  
//this is an init function that's called from b4r, typically in AppStart to setup  
//inline c related variables, etc.  Here we'll also setup our function pointer  
void init(B4R::Object* o) {  
    //so now we just set publish_string to point to our publish function  
    publish_string = publish;  
}  
  
  
void publish(char *str) {  
    //this is the "pointed to function". this is the function that will be called  
    //when publish_string is called.  It takes one argument a char array pointer  
    
    //don't be lazy - check for null  
    if (str == NULL) return; //do nothing  
    
    //now we get the data to B4R, using our process global variable  
    //just define a simple buffer ptr variable to make reading the code easier;  
    char *buffer = (char *) b4r_main::_ret_string_buffer->data;  
    int buffer_len = b4r_main::_ret_string_buffer->length;  
    
    //let's clear out the current buffer with 0s  
    memset(buffer, '\0', buffer_len);   
    
    //now let's copy the char array passed in to buffer (which is really b4r_main::_ret_string_buffer)  
    //now of course you'll need to ensure the length of str won't exceed buffer's length,  
    //just trying to keep things simple  
    strcpy(buffer,str);  
    
    //now the magic - call our B4R sub!  
    //what ever is in PublishStringMQTT() sub will get executed. It will use the  
    //data in the Process Globals variable ret_string_buffer  
  
    b4r_main::_publishstringmqtt();  
    
    //that's it all done!  
    return;  
    
}
```

  
  
The first part of the inline C defines a reference to the B4R SUB we will call - this is necessary so we can call our B4R sub from C by simplying using **b4r\_main::\_publishstringmqtt();**  
  

```B4X
class b4r_radiomodule {  
public:  
  
//our b4r sub - remember all subs and process globals are lower case in C  
static void    _publishstringmqtt(void);  
};
```

  
  
The next part (which is obviously really important) is to define the external function pointer variable. This will be defined in your custom .cpp file. Using extern, the custom .cpp file/code doesn't need to know anything about B4R other than the function pointer and the pointed to function have the same arguments and return types. I've chosen **publish\_string** as the name of my function pointer variable.  
  

```B4X
//now define an extern to our function pointer. the function pointer variable is located  
//in some other .cpp module.  In the other .cpp module, we'll be able to call publish_string  
//passing in a pointer to a char array which is our string to publish to mqtt  
extern void     (*publish_string)(char *);
```

  
  
The next part of interest is the **init** function. We use this as a convenient way to perform initialization in our inline c.  
  

```B4X
//this is an init function that's called from b4r, typically in AppStart to setup  
//inline c related variables, etc.  Here we'll also setup our function pointer  
  
void init(B4R::Object* o) {  
    //so now we just set publish_string to point to our publish function  
    publish_string = publish;  
}
```

  
  
Generally you want to call into this init routine from the B4R AppStart sub like so:  
  

```B4X
RunNative("init", Null)
```

  
  
Once **init** is called the function pointer is setup from that point on. Next is the helper function **void publish(char \*str):**  
  

```B4X
void publish(char *str)
```

  
  
I've documented this function so you should be able to follow it. However this is where the magic happens. This function is the **pointed to function .** In other words **publish\_string** is mapped to **publish.** From there the function copies the passed in string array to our B4R Process Globals string and then calls the B4R sub:  
  

```B4X
b4r_main::_publishstringmqtt();
```

  
  
Now our B4R sub PublishStringMQTT() takes over and uses ret\_string\_buffer. And that's it :)  
  
It might seem like a lot but it's not to bad once you get the hang of function pointers. It's worth mentioning that instead of using:  

```B4X
extern void     (*publish_string)(char *);
```

  
  
It may be more useful to define a C++ class in your custom .cpp file that has a member variable called publish\_string. You define the member variable like so:  
  

```B4X
class MyCode  
{  
    public:  
    void     (*publish_string)(char *);  
}
```

  
  
Then in the inline C, you can define an instance of your MyCode class, say **mc** and then set your function pointer like so:  
  

```B4X
mc.publish_string = publish;
```

  
  
Other class methods can call it as necessary.  
  
I hope this post was informative and helpful ;)