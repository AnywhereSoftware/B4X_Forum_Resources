### [Module]  Serial Oscilloscope by hatzisn
### 03/08/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/128394/)

Here is a module that communicates with the serial oscilloscope as seen in this thread:  
  
<https://www.b4x.com/android/forum/threads/serial-oscilloscope.128346/>  
  
As far as my knowledge goes it is not possible to be created as a b4xlib because different boards have different number of Analog Input pins and thus in B4R different pin.Ax are available (x ranging from 0 to 15 in the boards that I have). In order to face this and since it is a nine channels only oscilloscope I created it as a module and in the initialize sub of the module just REM out what you don't need. Also you will have to change the AnalogResolution variable according to the board and the lower limit and upper limit the measured value is mapped to.  
  
In order to use it you will have to add the following code in AppStart:  
  

```B4X
SerialOscilloscope.Initialize(6) 'Change the number to the channels you will need  
AddLooper("osc")
```

  
  
And of course also this sub in Main module:  
  

```B4X
Sub osc  
    SerialOscilloscope.LogChannels  
End osc
```

  
  
Please also note that when you compile and upload the project to the board B4R gets exclusive use of the relative port, so in order to see the values you will have to do the following things:  
1) Close B4R or press disconnect in the logs tab in B4R.  
2) Open Serial oscilloscope  
3) Choose the same baud rate you have selected in the project  
4) In Serial Oscilloscope application select the port (File > [Port])  
5) You will start seeing the values and now you are free to play