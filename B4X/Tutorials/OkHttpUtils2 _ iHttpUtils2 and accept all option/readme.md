###  OkHttpUtils2 / iHttpUtils2 and accept all option by Erel
### 09/05/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/110673/)

Note that OkHttpUtils2, jOkHttpUtils2 and iHttpUtils2 are actually the exact same b4x library.  
jOkHttpUtils2\_NONUI was required as a special version for non-ui B4J apps. It is no longer required and shouldn't be used.  
  
Starting from v2.90 it is very simple to initialize the internal http client with the 'accept all' option.  
The accept all option means that certificates will not be validated.  
It is done by adding the following conditional symbol (Ctrl + B):  
HU2\_ACCEPTALL  
  
There is another configurable conditional symbol:  
HU2\_PUBLIC - makes the http client variable (hc) a public variable. This can be used in cases where you want to customize the internal behavior. It is more relevant to B4J and B4A.  
Example: <https://www.b4x.com/android/forum/threads/ntlm-again.110485/#post-690641>  
  
Note that in B4i you need to disable ATS for this to work:  

```B4X
'in main module  
#ATSEnabled: False
```