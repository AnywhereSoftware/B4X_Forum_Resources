### Random Numbers from 0 to 255 (byte) by Johan Schoeman
### 11/24/2019
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/111650/)

The attached project is based on these postings:  
<https://gist.github.com/bloc97/b55f684d17edd8f50df8e918cbc00f94>  
<https://gist.githubusercontent.com/bloc97/b5831977ccfeae3aa71976686c9c8afa/raw/20a7b33ef983274e4171094c1e7e8c5d4f30894d/Method1.ino>  
  
It creates random numbers (byte) from 0 to 255. Have added it via inline C code. Below table is a summary of the number of times (right column) that 0 to 255 (left column) were generated out of 1605 randomly generated numbers. Only numbers **9** and **44** never appeared (from 0 to 255) in the 1605 long random number list.  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 300  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public Serial1 As Serial  
      
    Dim myRandomNumber As Byte  
    Dim t As Timer  
      
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    Delay(1000)  
    t.Initialize("t_tick", 50)  
    t.Enabled = True  
      
End Sub  
  
Sub t_tick  
      
    RunNative("getTrueRotateRandomByte", Null)  
    Log("myRandomNumber = ", myRandomNumber)  
  
End Sub  
  
#if C  
  
    const int waitTime = 16;  
    byte rotate(byte b, int r);  
    void pushLeftStack(byte bitToPush);  
    void pushRightStackRight(byte bitToPush);  
  
    byte lastByte = 0;  
  
    byte leftStack = 0;  
    byte rightStack = 0;  
  
    byte rotate(byte b, int r) {  
      return (b << r) | (b >> (8-r));  
    }  
  
    void pushLeftStack(byte bitToPush) {  
      leftStack = (leftStack << 1) ^ bitToPush ^ leftStack;  
    }  
    void pushRightStackRight(byte bitToPush) {  
      rightStack = (rightStack >> 1) ^ (bitToPush << 7) ^ rightStack;  
    }  
  
    void getTrueRotateRandomByte(B4R::Object* o) {  
      byte finalByte = 0;  
        
      byte lastStack = leftStack ^ rightStack;  
        
      for (int i=0; i<4; i++) {  
        delayMicroseconds(waitTime);  
        int leftBits = analogRead(1);  
          
        delayMicroseconds(waitTime);  
        int rightBits = analogRead(1);  
          
        finalByte ^= rotate(leftBits, i);  
        finalByte ^= rotate(rightBits, 7-i);  
          
        for (int j=0; j<8; j++) {  
          byte leftBit = (leftBits >> j) & 1;  
          byte rightBit = (rightBits >> j) & 1;  
        
          if (leftBit != rightBit) {  
            if (lastStack % 2 == 0) {  
              pushLeftStack(leftBit);  
            } else {  
              pushRightStackRight(leftBit);  
            }  
          }  
        }  
          
      }  
      lastByte ^= (lastByte >> 3) ^ (lastByte << 5) ^ (lastByte >> 4);  
      lastByte ^= finalByte;  
      lastByte = lastByte ^ leftStack ^ rightStack;  
      b4r_main::_myrandomnumber = lastByte;  
    //  return lastByte;  
    }  
  
  
  
  
#End If
```

  
  
  
**Raw data:**  

```B4X
myRandomNumber = 169  
myRandomNumber = 236  
myRandomNumber = 126  
myRandomNumber = 120  
myRandomNumber = 251  
myRandomNumber = 173  
myRandomNumber = 105  
myRandomNumber = 209  
myRandomNumber = 91  
myRandomNumber = 188  
myRandomNumber = 127  
myRandomNumber = 244  
myRandomNumber = 116  
myRandomNumber = 199  
myRandomNumber = 79  
myRandomNumber = 29  
myRandomNumber = 37  
myRandomNumber = 43  
myRandomNumber = 7  
myRandomNumber = 75  
myRandomNumber = 125  
myRandomNumber = 155  
myRandomNumber = 176  
myRandomNumber = 213  
myRandomNumber = 187  
myRandomNumber = 6  
myRandomNumber = 195  
myRandomNumber = 242  
myRandomNumber = 215  
myRandomNumber = 19  
myRandomNumber = 100  
myRandomNumber = 129  
myRandomNumber = 246  
myRandomNumber = 141  
myRandomNumber = 97  
myRandomNumber = 248  
myRandomNumber = 49  
myRandomNumber = 67  
myRandomNumber = 93  
myRandomNumber = 45  
myRandomNumber = 143  
myRandomNumber = 96  
myRandomNumber = 74  
myRandomNumber = 93  
myRandomNumber = 143  
myRandomNumber = 148  
myRandomNumber = 54  
myRandomNumber = 113  
myRandomNumber = 99  
myRandomNumber = 76  
myRandomNumber = 197  
myRandomNumber = 55  
myRandomNumber = 139  
myRandomNumber = 202  
myRandomNumber = 132  
myRandomNumber = 167  
myRandomNumber = 119  
myRandomNumber = 206  
myRandomNumber = 250  
myRandomNumber = 158  
myRandomNumber = 185  
myRandomNumber = 168  
myRandomNumber = 45  
myRandomNumber = 57  
myRandomNumber = 188  
myRandomNumber = 244  
myRandomNumber = 52  
myRandomNumber = 36  
myRandomNumber = 63  
myRandomNumber = 187  
myRandomNumber = 211  
myRandomNumber = 7  
myRandomNumber = 157  
myRandomNumber = 12  
myRandomNumber = 68  
myRandomNumber = 34  
myRandomNumber = 217  
myRandomNumber = 95  
myRandomNumber = 126  
myRandomNumber = 49  
myRandomNumber = 74  
myRandomNumber = 125  
myRandomNumber = 111  
myRandomNumber = 205  
myRandomNumber = 157  
myRandomNumber = 205  
myRandomNumber = 199  
myRandomNumber = 239  
myRandomNumber = 173  
myRandomNumber = 223  
myRandomNumber = 152  
myRandomNumber = 149  
myRandomNumber = 227  
myRandomNumber = 110  
myRandomNumber = 252  
myRandomNumber = 83  
myRandomNumber = 245  
myRandomNumber = 242  
myRandomNumber = 13  
myRandomNumber = 172  
myRandomNumber = 25  
myRandomNumber = 222  
myRandomNumber = 73  
myRandomNumber = 226  
myRandomNumber = 116  
myRandomNumber = 241  
myRandomNumber = 237  
myRandomNumber = 141  
myRandomNumber = 157  
myRandomNumber = 177  
myRandomNumber = 29  
myRandomNumber = 169  
myRandomNumber = 146  
myRandomNumber = 227  
myRandomNumber = 188  
myRandomNumber = 19  
myRandomNumber = 6  
myRandomNumber = 120  
myRandomNumber = 128  
myRandomNumber = 93  
myRandomNumber = 50  
myRandomNumber = 240  
myRandomNumber = 21  
myRandomNumber = 239  
myRandomNumber = 220  
myRandomNumber = 103  
myRandomNumber = 65  
myRandomNumber = 135  
myRandomNumber = 84  
myRandomNumber = 83  
myRandomNumber = 171  
myRandomNumber = 140  
myRandomNumber = 175  
myRandomNumber = 74  
myRandomNumber = 128  
myRandomNumber = 104  
myRandomNumber = 143  
myRandomNumber = 49  
myRandomNumber = 76  
myRandomNumber = 71  
myRandomNumber = 148  
myRandomNumber = 65  
myRandomNumber = 103  
myRandomNumber = 137  
myRandomNumber = 78  
myRandomNumber = 168  
myRandomNumber = 144  
myRandomNumber = 80  
myRandomNumber = 247  
myRandomNumber = 130  
myRandomNumber = 195  
myRandomNumber = 34  
myRandomNumber = 106  
myRandomNumber = 181  
myRandomNumber = 157  
myRandomNumber = 50  
myRandomNumber = 152  
myRandomNumber = 59  
myRandomNumber = 173  
myRandomNumber = 35  
myRandomNumber = 90  
myRandomNumber = 26  
myRandomNumber = 225  
myRandomNumber = 104  
myRandomNumber = 232  
myRandomNumber = 155  
myRandomNumber = 27  
myRandomNumber = 169  
myRandomNumber = 6  
myRandomNumber = 103  
myRandomNumber = 23  
myRandomNumber = 10  
myRandomNumber = 254  
myRandomNumber = 70  
myRandomNumber = 2  
myRandomNumber = 172  
myRandomNumber = 65  
myRandomNumber = 250  
myRandomNumber = 218  
myRandomNumber = 251  
myRandomNumber = 73  
myRandomNumber = 39  
myRandomNumber = 0  
myRandomNumber = 94  
myRandomNumber = 108  
myRandomNumber = 57  
myRandomNumber = 41  
myRandomNumber = 142  
myRandomNumber = 153  
myRandomNumber = 70  
myRandomNumber = 58  
myRandomNumber = 35  
myRandomNumber = 42  
myRandomNumber = 53  
myRandomNumber = 141  
myRandomNumber = 112  
myRandomNumber = 228  
myRandomNumber = 255  
myRandomNumber = 33  
myRandomNumber = 100  
myRandomNumber = 36  
myRandomNumber = 151  
myRandomNumber = 41  
myRandomNumber = 89  
myRandomNumber = 79  
myRandomNumber = 96  
myRandomNumber = 56  
myRandomNumber = 16  
myRandomNumber = 21  
myRandomNumber = 86  
myRandomNumber = 200  
myRandomNumber = 120  
myRandomNumber = 121  
myRandomNumber = 13  
myRandomNumber = 204  
myRandomNumber = 239  
myRandomNumber = 10  
myRandomNumber = 58  
myRandomNumber = 168  
myRandomNumber = 0  
myRandomNumber = 165  
myRandomNumber = 155  
myRandomNumber = 121  
myRandomNumber = 196  
myRandomNumber = 117  
myRandomNumber = 216  
myRandomNumber = 60  
myRandomNumber = 247  
myRandomNumber = 251  
myRandomNumber = 217  
myRandomNumber = 194  
myRandomNumber = 211  
myRandomNumber = 105  
myRandomNumber = 104  
myRandomNumber = 3  
myRandomNumber = 220  
myRandomNumber = 152  
myRandomNumber = 21  
myRandomNumber = 56  
myRandomNumber = 193  
myRandomNumber = 162  
myRandomNumber = 65  
myRandomNumber = 89  
myRandomNumber = 105  
myRandomNumber = 85  
myRandomNumber = 172  
myRandomNumber = 143  
myRandomNumber = 216  
myRandomNumber = 238  
myRandomNumber = 239  
myRandomNumber = 59  
myRandomNumber = 122  
myRandomNumber = 102  
myRandomNumber = 125  
myRandomNumber = 173  
myRandomNumber = 13  
myRandomNumber = 187  
myRandomNumber = 120  
myRandomNumber = 179  
myRandomNumber = 117  
myRandomNumber = 172  
myRandomNumber = 174  
myRandomNumber = 241  
myRandomNumber = 53  
myRandomNumber = 176  
myRandomNumber = 33  
myRandomNumber = 127  
myRandomNumber = 73  
myRandomNumber = 158  
myRandomNumber = 48  
myRandomNumber = 113  
myRandomNumber = 88  
myRandomNumber = 221  
myRandomNumber = 164  
myRandomNumber = 251  
myRandomNumber = 249  
myRandomNumber = 83  
myRandomNumber = 219  
myRandomNumber = 167  
myRandomNumber = 152  
myRandomNumber = 78  
myRandomNumber = 176  
myRandomNumber = 57  
myRandomNumber = 45  
myRandomNumber = 125  
myRandomNumber = 136  
myRandomNumber = 220  
myRandomNumber = 5  
myRandomNumber = 6  
myRandomNumber = 175  
myRandomNumber = 56  
myRandomNumber = 118  
myRandomNumber = 32  
myRandomNumber = 115  
myRandomNumber = 226  
myRandomNumber = 76  
myRandomNumber = 249  
myRandomNumber = 163  
myRandomNumber = 101  
myRandomNumber = 253  
myRandomNumber = 140  
myRandomNumber = 17  
myRandomNumber = 200  
myRandomNumber = 11  
myRandomNumber = 66  
myRandomNumber = 77  
myRandomNumber = 249  
myRandomNumber = 35  
myRandomNumber = 116  
myRandomNumber = 146  
myRandomNumber = 17  
myRandomNumber = 238  
myRandomNumber = 18  
myRandomNumber = 142  
myRandomNumber = 19  
myRandomNumber = 209  
myRandomNumber = 17  
myRandomNumber = 61  
myRandomNumber = 46  
myRandomNumber = 146  
myRandomNumber = 155  
myRandomNumber = 163  
myRandomNumber = 95  
myRandomNumber = 18  
myRandomNumber = 119  
myRandomNumber = 207  
myRandomNumber = 235  
myRandomNumber = 21  
myRandomNumber = 62  
myRandomNumber = 254  
myRandomNumber = 137  
myRandomNumber = 80  
myRandomNumber = 45  
myRandomNumber = 114  
myRandomNumber = 68  
myRandomNumber = 244  
myRandomNumber = 76  
myRandomNumber = 226  
myRandomNumber = 184  
myRandomNumber = 233  
myRandomNumber = 219  
myRandomNumber = 252  
myRandomNumber = 85  
myRandomNumber = 232  
myRandomNumber = 115  
myRandomNumber = 144  
myRandomNumber = 148  
myRandomNumber = 137  
myRandomNumber = 62  
myRandomNumber = 177  
myRandomNumber = 201  
myRandomNumber = 81  
myRandomNumber = 212  
myRandomNumber = 126  
myRandomNumber = 111  
myRandomNumber = 50  
myRandomNumber = 111  
myRandomNumber = 80  
myRandomNumber = 61  
myRandomNumber = 30  
myRandomNumber = 234  
myRandomNumber = 162  
myRandomNumber = 56  
myRandomNumber = 115  
myRandomNumber = 205  
myRandomNumber = 194  
myRandomNumber = 237  
myRandomNumber = 196  
myRandomNumber = 15  
myRandomNumber = 191  
myRandomNumber = 212  
myRandomNumber = 163  
myRandomNumber = 103  
myRandomNumber = 67  
myRandomNumber = 193  
myRandomNumber = 80  
myRandomNumber = 249  
myRandomNumber = 149  
myRandomNumber = 149  
myRandomNumber = 254  
myRandomNumber = 7  
myRandomNumber = 0  
myRandomNumber = 113  
myRandomNumber = 54  
myRandomNumber = 91  
myRandomNumber = 165  
myRandomNumber = 245  
myRandomNumber = 74  
myRandomNumber = 20  
myRandomNumber = 7  
myRandomNumber = 52  
myRandomNumber = 254  
myRandomNumber = 92  
myRandomNumber = 51  
myRandomNumber = 234  
myRandomNumber = 146  
myRandomNumber = 155  
myRandomNumber = 201  
myRandomNumber = 131  
myRandomNumber = 20  
myRandomNumber = 42  
myRandomNumber = 179  
myRandomNumber = 48  
myRandomNumber = 134  
myRandomNumber = 93  
myRandomNumber = 116  
myRandomNumber = 182  
myRandomNumber = 93  
myRandomNumber = 201  
myRandomNumber = 128  
myRandomNumber = 19  
myRandomNumber = 120  
myRandomNumber = 166  
myRandomNumber = 253  
myRandomNumber = 236  
myRandomNumber = 129  
myRandomNumber = 26  
myRandomNumber = 254  
myRandomNumber = 179  
myRandomNumber = 189  
myRandomNumber = 79  
myRandomNumber = 158  
myRandomNumber = 18  
myRandomNumber = 109  
myRandomNumber = 93  
myRandomNumber = 81  
myRandomNumber = 231  
myRandomNumber = 249  
myRandomNumber = 189  
myRandomNumber = 31  
myRandomNumber = 208  
myRandomNumber = 85  
myRandomNumber = 209  
myRandomNumber = 12  
myRandomNumber = 252  
myRandomNumber = 49  
myRandomNumber = 28  
myRandomNumber = 52  
myRandomNumber = 239  
myRandomNumber = 25  
myRandomNumber = 180  
myRandomNumber = 209  
myRandomNumber = 235  
myRandomNumber = 157  
myRandomNumber = 91  
myRandomNumber = 76  
myRandomNumber = 99  
myRandomNumber = 236  
myRandomNumber = 255  
myRandomNumber = 195  
myRandomNumber = 156  
myRandomNumber = 81  
myRandomNumber = 76  
myRandomNumber = 121  
myRandomNumber = 192  
myRandomNumber = 38  
myRandomNumber = 98  
myRandomNumber = 244  
myRandomNumber = 56  
myRandomNumber = 169  
myRandomNumber = 213  
myRandomNumber = 185  
myRandomNumber = 169  
myRandomNumber = 16  
myRandomNumber = 109  
myRandomNumber = 167  
myRandomNumber = 244  
myRandomNumber = 49  
myRandomNumber = 96  
myRandomNumber = 130  
myRandomNumber = 51  
myRandomNumber = 181  
myRandomNumber = 255  
myRandomNumber = 110  
myRandomNumber = 224  
myRandomNumber = 134  
myRandomNumber = 180  
myRandomNumber = 122  
myRandomNumber = 115  
myRandomNumber = 209  
myRandomNumber = 26  
myRandomNumber = 192  
myRandomNumber = 154  
myRandomNumber = 145  
myRandomNumber = 47  
myRandomNumber = 194  
myRandomNumber = 144  
myRandomNumber = 30  
myRandomNumber = 7  
myRandomNumber = 171  
myRandomNumber = 29  
myRandomNumber = 20  
myRandomNumber = 19  
myRandomNumber = 213  
myRandomNumber = 184  
myRandomNumber = 204  
myRandomNumber = 225  
myRandomNumber = 153  
myRandomNumber = 45  
myRandomNumber = 131  
myRandomNumber = 2  
myRandomNumber = 124  
myRandomNumber = 231  
myRandomNumber = 72  
myRandomNumber = 174  
myRandomNumber = 13  
myRandomNumber = 209  
myRandomNumber = 14  
myRandomNumber = 22  
myRandomNumber = 151  
myRandomNumber = 5  
myRandomNumber = 169  
myRandomNumber = 80  
myRandomNumber = 83  
myRandomNumber = 123  
myRandomNumber = 23  
myRandomNumber = 195  
myRandomNumber = 174  
myRandomNumber = 56  
myRandomNumber = 17  
myRandomNumber = 29  
myRandomNumber = 114  
myRandomNumber = 0  
myRandomNumber = 177  
myRandomNumber = 247  
myRandomNumber = 105  
myRandomNumber = 91  
myRandomNumber = 94  
myRandomNumber = 199  
myRandomNumber = 43  
myRandomNumber = 65  
myRandomNumber = 109  
myRandomNumber = 221  
myRandomNumber = 51  
myRandomNumber = 26  
myRandomNumber = 19  
myRandomNumber = 72  
myRandomNumber = 88  
myRandomNumber = 108  
myRandomNumber = 125  
myRandomNumber = 249  
myRandomNumber = 37  
myRandomNumber = 225  
myRandomNumber = 254  
myRandomNumber = 59  
myRandomNumber = 230  
myRandomNumber = 178  
myRandomNumber = 36  
myRandomNumber = 216  
myRandomNumber = 27  
myRandomNumber = 226  
myRandomNumber = 133  
myRandomNumber = 240  
myRandomNumber = 12  
myRandomNumber = 206  
myRandomNumber = 78  
myRandomNumber = 149  
myRandomNumber = 137  
myRandomNumber = 99  
myRandomNumber = 138  
myRandomNumber = 36  
myRandomNumber = 220  
myRandomNumber = 151  
myRandomNumber = 68  
myRandomNumber = 215  
myRandomNumber = 24  
myRandomNumber = 138  
myRandomNumber = 249  
myRandomNumber = 146  
myRandomNumber = 67  
myRandomNumber = 140  
myRandomNumber = 34  
myRandomNumber = 29  
myRandomNumber = 148  
myRandomNumber = 124  
myRandomNumber = 55  
myRandomNumber = 233  
myRandomNumber = 231  
myRandomNumber = 190  
myRandomNumber = 222  
myRandomNumber = 47  
myRandomNumber = 121  
myRandomNumber = 213  
myRandomNumber = 79  
myRandomNumber = 66  
myRandomNumber = 204  
myRandomNumber = 126  
myRandomNumber = 32  
myRandomNumber = 108  
myRandomNumber = 147  
myRandomNumber = 58  
myRandomNumber = 105  
myRandomNumber = 99  
myRandomNumber = 135  
myRandomNumber = 208  
myRandomNumber = 146  
myRandomNumber = 55  
myRandomNumber = 205  
myRandomNumber = 14  
myRandomNumber = 118  
myRandomNumber = 241  
myRandomNumber = 251  
myRandomNumber = 91  
myRandomNumber = 102  
myRandomNumber = 108  
myRandomNumber = 207  
myRandomNumber = 36  
myRandomNumber = 159  
myRandomNumber = 168  
myRandomNumber = 146  
myRandomNumber = 185  
myRandomNumber = 177  
myRandomNumber = 84  
myRandomNumber = 70  
myRandomNumber = 10  
myRandomNumber = 38  
myRandomNumber = 177  
myRandomNumber = 47  
myRandomNumber = 143  
myRandomNumber = 18  
myRandomNumber = 127  
myRandomNumber = 252  
myRandomNumber = 27  
myRandomNumber = 71  
myRandomNumber = 200  
myRandomNumber = 156  
myRandomNumber = 234  
myRandomNumber = 64  
myRandomNumber = 99  
myRandomNumber = 68  
myRandomNumber = 65  
myRandomNumber = 176  
myRandomNumber = 157  
myRandomNumber = 42  
myRandomNumber = 14  
myRandomNumber = 8  
myRandomNumber = 121  
myRandomNumber = 185  
myRandomNumber = 17  
myRandomNumber = 31  
myRandomNumber = 133  
myRandomNumber = 211  
myRandomNumber = 14  
myRandomNumber = 196  
myRandomNumber = 19  
myRandomNumber = 216  
myRandomNumber = 172  
myRandomNumber = 110  
myRandomNumber = 120  
myRandomNumber = 240  
myRandomNumber = 177  
myRandomNumber = 20  
myRandomNumber = 17  
myRandomNumber = 69  
myRandomNumber = 137  
myRandomNumber = 252  
myRandomNumber = 42  
myRandomNumber = 149  
myRandomNumber = 19  
myRandomNumber = 158  
myRandomNumber = 151  
myRandomNumber = 99  
myRandomNumber = 59  
myRandomNumber = 173  
myRandomNumber = 155  
myRandomNumber = 185  
myRandomNumber = 156  
myRandomNumber = 129  
myRandomNumber = 3  
myRandomNumber = 192  
myRandomNumber = 68  
myRandomNumber = 107  
myRandomNumber = 110  
myRandomNumber = 49  
myRandomNumber = 133  
myRandomNumber = 60  
myRandomNumber = 110  
myRandomNumber = 14  
myRandomNumber = 35  
myRandomNumber = 68  
myRandomNumber = 191  
myRandomNumber = 195  
myRandomNumber = 113  
myRandomNumber = 173  
myRandomNumber = 127  
myRandomNumber = 172  
myRandomNumber = 248  
myRandomNumber = 72  
myRandomNumber = 77  
myRandomNumber = 193  
myRandomNumber = 39  
myRandomNumber = 153  
myRandomNumber = 116  
myRandomNumber = 199  
myRandomNumber = 22  
myRandomNumber = 4  
myRandomNumber = 235  
myRandomNumber = 215  
myRandomNumber = 6  
myRandomNumber = 112  
myRandomNumber = 220  
myRandomNumber = 51  
myRandomNumber = 217  
myRandomNumber = 178  
myRandomNumber = 87  
myRandomNumber = 166  
myRandomNumber = 250  
myRandomNumber = 19  
myRandomNumber = 134  
myRandomNumber = 11  
myRandomNumber = 43  
myRandomNumber = 128  
myRandomNumber = 120  
myRandomNumber = 133  
myRandomNumber = 221  
myRandomNumber = 78  
myRandomNumber = 208  
myRandomNumber = 129  
myRandomNumber = 7  
myRandomNumber = 189  
myRandomNumber = 251  
myRandomNumber = 244  
myRandomNumber = 82  
myRandomNumber = 204  
myRandomNumber = 202  
myRandomNumber = 252  
myRandomNumber = 3  
myRandomNumber = 111  
myRandomNumber = 136  
myRandomNumber = 163  
myRandomNumber = 126  
myRandomNumber = 35  
myRandomNumber = 52  
myRandomNumber = 251  
myRandomNumber = 183  
myRandomNumber = 174  
myRandomNumber = 95  
myRandomNumber = 37  
myRandomNumber = 232  
myRandomNumber = 132  
myRandomNumber = 4  
myRandomNumber = 154  
myRandomNumber = 131  
myRandomNumber = 121  
myRandomNumber = 84  
myRandomNumber = 163  
myRandomNumber = 144  
myRandomNumber = 245  
myRandomNumber = 189  
myRandomNumber = 88  
myRandomNumber = 21  
myRandomNumber = 148  
myRandomNumber = 218  
myRandomNumber = 185  
myRandomNumber = 33  
myRandomNumber = 247  
myRandomNumber = 210  
myRandomNumber = 102  
myRandomNumber = 153  
myRandomNumber = 160  
myRandomNumber = 130  
myRandomNumber = 1  
myRandomNumber = 118  
myRandomNumber = 156  
myRandomNumber = 138  
myRandomNumber = 18  
myRandomNumber = 43  
myRandomNumber = 229  
myRandomNumber = 99  
myRandomNumber = 58  
myRandomNumber = 25  
myRandomNumber = 251  
myRandomNumber = 59  
myRandomNumber = 112  
myRandomNumber = 113  
myRandomNumber = 80  
myRandomNumber = 53  
myRandomNumber = 251  
myRandomNumber = 64  
myRandomNumber = 137  
myRandomNumber = 65  
myRandomNumber = 195  
myRandomNumber = 131  
myRandomNumber = 206  
myRandomNumber = 171  
myRandomNumber = 120  
myRandomNumber = 5  
myRandomNumber = 159  
myRandomNumber = 254  
myRandomNumber = 198  
myRandomNumber = 105  
myRandomNumber = 158  
myRandomNumber = 111  
myRandomNumber = 174  
myRandomNumber = 195  
myRandomNumber = 174  
myRandomNumber = 186  
myRandomNumber = 214  
myRandomNumber = 228  
myRandomNumber = 229  
myRandomNumber = 202  
myRandomNumber = 149  
myRandomNumber = 231  
myRandomNumber = 229  
myRandomNumber = 150  
myRandomNumber = 172  
myRandomNumber = 223  
myRandomNumber = 129  
myRandomNumber = 224  
myRandomNumber = 230  
myRandomNumber = 47  
myRandomNumber = 237  
myRandomNumber = 89  
myRandomNumber = 42  
myRandomNumber = 218  
myRandomNumber = 55  
myRandomNumber = 223  
myRandomNumber = 45  
myRandomNumber = 131  
myRandomNumber = 176  
myRandomNumber = 131  
myRandomNumber = 249  
myRandomNumber = 229  
myRandomNumber = 13  
myRandomNumber = 200  
myRandomNumber = 82  
myRandomNumber = 221  
myRandomNumber = 34  
myRandomNumber = 102  
myRandomNumber = 62  
myRandomNumber = 243  
myRandomNumber = 33  
myRandomNumber = 105  
myRandomNumber = 128  
myRandomNumber = 222  
myRandomNumber = 43  
myRandomNumber = 78  
myRandomNumber = 229  
myRandomNumber = 197  
myRandomNumber = 231  
myRandomNumber = 95  
myRandomNumber = 102  
myRandomNumber = 45  
myRandomNumber = 226  
myRandomNumber = 243  
myRandomNumber = 205  
myRandomNumber = 89  
myRandomNumber = 13  
myRandomNumber = 67  
myRandomNumber = 47  
myRandomNumber = 159  
myRandomNumber = 139  
myRandomNumber = 63  
myRandomNumber = 198  
myRandomNumber = 18  
myRandomNumber = 177  
myRandomNumber = 203  
myRandomNumber = 144  
myRandomNumber = 115  
myRandomNumber = 105  
myRandomNumber = 93  
myRandomNumber = 52  
myRandomNumber = 145  
myRandomNumber = 237  
myRandomNumber = 190  
myRandomNumber = 234  
myRandomNumber = 220  
myRandomNumber = 107  
myRandomNumber = 96  
myRandomNumber = 63  
myRandomNumber = 196  
myRandomNumber = 61  
myRandomNumber = 199  
myRandomNumber = 217  
myRandomNumber = 73  
myRandomNumber = 179  
myRandomNumber = 125  
myRandomNumber = 2  
myRandomNumber = 135  
myRandomNumber = 191  
myRandomNumber = 72  
myRandomNumber = 62  
myRandomNumber = 167  
myRandomNumber = 135  
myRandomNumber = 194  
myRandomNumber = 20  
myRandomNumber = 240  
myRandomNumber = 40  
myRandomNumber = 87  
myRandomNumber = 228  
myRandomNumber = 144  
myRandomNumber = 237  
myRandomNumber = 142  
myRandomNumber = 246  
myRandomNumber = 7  
myRandomNumber = 181  
myRandomNumber = 42  
myRandomNumber = 40  
myRandomNumber = 118  
myRandomNumber = 40  
myRandomNumber = 214  
myRandomNumber = 179  
myRandomNumber = 243  
myRandomNumber = 255  
myRandomNumber = 61  
myRandomNumber = 166  
myRandomNumber = 39  
myRandomNumber = 5  
myRandomNumber = 108  
myRandomNumber = 227  
myRandomNumber = 230  
myRandomNumber = 238  
myRandomNumber = 248  
myRandomNumber = 30  
myRandomNumber = 253  
myRandomNumber = 254  
myRandomNumber = 183  
myRandomNumber = 60  
myRandomNumber = 156  
myRandomNumber = 157  
myRandomNumber = 48  
myRandomNumber = 135  
myRandomNumber = 181  
myRandomNumber = 235  
myRandomNumber = 71  
myRandomNumber = 185  
myRandomNumber = 233  
myRandomNumber = 153  
myRandomNumber = 198  
myRandomNumber = 96  
myRandomNumber = 162  
myRandomNumber = 90  
myRandomNumber = 220  
myRandomNumber = 124  
myRandomNumber = 190  
myRandomNumber = 151  
myRandomNumber = 28  
myRandomNumber = 213  
myRandomNumber = 153  
myRandomNumber = 193  
myRandomNumber = 187  
myRandomNumber = 107  
myRandomNumber = 133  
myRandomNumber = 105  
myRandomNumber = 115  
myRandomNumber = 55  
myRandomNumber = 30  
myRandomNumber = 77  
myRandomNumber = 93  
myRandomNumber = 90  
myRandomNumber = 102  
myRandomNumber = 36  
myRandomNumber = 62  
myRandomNumber = 56  
myRandomNumber = 62  
myRandomNumber = 103  
myRandomNumber = 24  
myRandomNumber = 179  
myRandomNumber = 142  
myRandomNumber = 56  
myRandomNumber = 133  
myRandomNumber = 174  
myRandomNumber = 102  
myRandomNumber = 121  
myRandomNumber = 209  
myRandomNumber = 186  
myRandomNumber = 166  
myRandomNumber = 112  
myRandomNumber = 253  
myRandomNumber = 219  
myRandomNumber = 86  
myRandomNumber = 94  
myRandomNumber = 76  
myRandomNumber = 218  
myRandomNumber = 56  
myRandomNumber = 219  
myRandomNumber = 163  
myRandomNumber = 159  
myRandomNumber = 32  
myRandomNumber = 81  
myRandomNumber = 136  
myRandomNumber = 46  
myRandomNumber = 78  
myRandomNumber = 109  
myRandomNumber = 14  
myRandomNumber = 109  
myRandomNumber = 101  
myRandomNumber = 192  
myRandomNumber = 15  
myRandomNumber = 141  
myRandomNumber = 127  
myRandomNumber = 226  
myRandomNumber = 153  
myRandomNumber = 25  
myRandomNumber = 234  
myRandomNumber = 7  
myRandomNumber = 104  
myRandomNumber = 180  
myRandomNumber = 191  
myRandomNumber = 42  
myRandomNumber = 224  
myRandomNumber = 126  
myRandomNumber = 242  
myRandomNumber = 113  
myRandomNumber = 83  
myRandomNumber = 114  
myRandomNumber = 141  
myRandomNumber = 18  
myRandomNumber = 34  
myRandomNumber = 93  
myRandomNumber = 66  
myRandomNumber = 180  
myRandomNumber = 22  
myRandomNumber = 8  
myRandomNumber = 70  
myRandomNumber = 175  
myRandomNumber = 88  
myRandomNumber = 165  
myRandomNumber = 179  
myRandomNumber = 6  
myRandomNumber = 192  
myRandomNumber = 54  
myRandomNumber = 37  
myRandomNumber = 77  
myRandomNumber = 220  
myRandomNumber = 208  
myRandomNumber = 73  
myRandomNumber = 87  
myRandomNumber = 52  
myRandomNumber = 49  
myRandomNumber = 111  
myRandomNumber = 176  
myRandomNumber = 2  
myRandomNumber = 186  
myRandomNumber = 197  
myRandomNumber = 143  
myRandomNumber = 25  
myRandomNumber = 121  
myRandomNumber = 37  
myRandomNumber = 2  
myRandomNumber = 207  
myRandomNumber = 228  
myRandomNumber = 183  
myRandomNumber = 212  
myRandomNumber = 7  
myRandomNumber = 200  
myRandomNumber = 54  
myRandomNumber = 146  
myRandomNumber = 2  
myRandomNumber = 241  
myRandomNumber = 188  
myRandomNumber = 8  
myRandomNumber = 22  
myRandomNumber = 123  
myRandomNumber = 174  
myRandomNumber = 165  
myRandomNumber = 200  
myRandomNumber = 145  
myRandomNumber = 228  
myRandomNumber = 43  
myRandomNumber = 1  
myRandomNumber = 134  
myRandomNumber = 94  
myRandomNumber = 254  
myRandomNumber = 253  
myRandomNumber = 185  
myRandomNumber = 128  
myRandomNumber = 18  
myRandomNumber = 85  
myRandomNumber = 250  
myRandomNumber = 159  
myRandomNumber = 42  
myRandomNumber = 128  
myRandomNumber = 33  
myRandomNumber = 146  
myRandomNumber = 214  
myRandomNumber = 179  
myRandomNumber = 45  
myRandomNumber = 54  
myRandomNumber = 141  
myRandomNumber = 66  
myRandomNumber = 172  
myRandomNumber = 97  
myRandomNumber = 47  
myRandomNumber = 64  
myRandomNumber = 181  
myRandomNumber = 121  
myRandomNumber = 72  
myRandomNumber = 81  
myRandomNumber = 5  
myRandomNumber = 220  
myRandomNumber = 195  
myRandomNumber = 133  
myRandomNumber = 236  
myRandomNumber = 249  
myRandomNumber = 244  
myRandomNumber = 118  
myRandomNumber = 130  
myRandomNumber = 28  
myRandomNumber = 5  
myRandomNumber = 174  
myRandomNumber = 128  
myRandomNumber = 215  
myRandomNumber = 71  
myRandomNumber = 136  
myRandomNumber = 70  
myRandomNumber = 122  
myRandomNumber = 164  
myRandomNumber = 86  
myRandomNumber = 209  
myRandomNumber = 143  
myRandomNumber = 170  
myRandomNumber = 163  
myRandomNumber = 242  
myRandomNumber = 139  
myRandomNumber = 8  
myRandomNumber = 126  
myRandomNumber = 63  
myRandomNumber = 80  
myRandomNumber = 149  
myRandomNumber = 134  
myRandomNumber = 179  
myRandomNumber = 134  
myRandomNumber = 55  
myRandomNumber = 187  
myRandomNumber = 47  
myRandomNumber = 227  
myRandomNumber = 92  
myRandomNumber = 69  
myRandomNumber = 84  
myRandomNumber = 48  
myRandomNumber = 151  
myRandomNumber = 189  
myRandomNumber = 192  
myRandomNumber = 86  
myRandomNumber = 47  
myRandomNumber = 253  
myRandomNumber = 217  
myRandomNumber = 250  
myRandomNumber = 218  
myRandomNumber = 94  
myRandomNumber = 105  
myRandomNumber = 203  
myRandomNumber = 117  
myRandomNumber = 81  
myRandomNumber = 130  
myRandomNumber = 101  
myRandomNumber = 37  
myRandomNumber = 118  
myRandomNumber = 128  
myRandomNumber = 165  
myRandomNumber = 220  
myRandomNumber = 54  
myRandomNumber = 98  
myRandomNumber = 248  
myRandomNumber = 124  
myRandomNumber = 192  
myRandomNumber = 252  
myRandomNumber = 120  
myRandomNumber = 171  
myRandomNumber = 176  
myRandomNumber = 23  
myRandomNumber = 100  
myRandomNumber = 241  
myRandomNumber = 95  
myRandomNumber = 60  
myRandomNumber = 58  
myRandomNumber = 52  
myRandomNumber = 109  
myRandomNumber = 32  
myRandomNumber = 73  
myRandomNumber = 233  
myRandomNumber = 183  
myRandomNumber = 242  
myRandomNumber = 37  
myRandomNumber = 34  
myRandomNumber = 188  
myRandomNumber = 126  
myRandomNumber = 56  
myRandomNumber = 235  
myRandomNumber = 234  
myRandomNumber = 144  
myRandomNumber = 206  
myRandomNumber = 16  
myRandomNumber = 176  
myRandomNumber = 76  
myRandomNumber = 175  
myRandomNumber = 187  
myRandomNumber = 109  
myRandomNumber = 205  
myRandomNumber = 83  
myRandomNumber = 92  
myRandomNumber = 126  
myRandomNumber = 11  
myRandomNumber = 198  
myRandomNumber = 205  
myRandomNumber = 126  
myRandomNumber = 99  
myRandomNumber = 234  
myRandomNumber = 131  
myRandomNumber = 143  
myRandomNumber = 13  
myRandomNumber = 213  
myRandomNumber = 95  
myRandomNumber = 227  
myRandomNumber = 201  
myRandomNumber = 232  
myRandomNumber = 142  
myRandomNumber = 87  
myRandomNumber = 237  
myRandomNumber = 100  
myRandomNumber = 210  
myRandomNumber = 178  
myRandomNumber = 15  
myRandomNumber = 249  
myRandomNumber = 245  
myRandomNumber = 230  
myRandomNumber = 148  
myRandomNumber = 107  
myRandomNumber = 56  
myRandomNumber = 64  
myRandomNumber = 55  
myRandomNumber = 140  
myRandomNumber = 209  
myRandomNumber = 18  
myRandomNumber = 222  
myRandomNumber = 56  
myRandomNumber = 254  
myRandomNumber = 23  
myRandomNumber = 121  
myRandomNumber = 228  
myRandomNumber = 47  
myRandomNumber = 41  
myRandomNumber = 216  
myRandomNumber = 185  
myRandomNumber = 123  
myRandomNumber = 249  
myRandomNumber = 83  
myRandomNumber = 95  
myRandomNumber = 89  
myRandomNumber = 246  
myRandomNumber = 181  
myRandomNumber = 190  
myRandomNumber = 156  
myRandomNumber = 120  
myRandomNumber = 74  
myRandomNumber = 113  
myRandomNumber = 27  
myRandomNumber = 83  
myRandomNumber = 171  
myRandomNumber = 202  
myRandomNumber = 35  
myRandomNumber = 166  
myRandomNumber = 90  
myRandomNumber = 147  
myRandomNumber = 121  
myRandomNumber = 21  
myRandomNumber = 92  
myRandomNumber = 199  
myRandomNumber = 172  
myRandomNumber = 235  
myRandomNumber = 183  
myRandomNumber = 0  
myRandomNumber = 28  
myRandomNumber = 116  
myRandomNumber = 144  
myRandomNumber = 194  
myRandomNumber = 207  
myRandomNumber = 130  
myRandomNumber = 135  
myRandomNumber = 237  
myRandomNumber = 87  
myRandomNumber = 28  
myRandomNumber = 208  
myRandomNumber = 57  
myRandomNumber = 132  
myRandomNumber = 250  
myRandomNumber = 40  
myRandomNumber = 206  
myRandomNumber = 173  
myRandomNumber = 80  
myRandomNumber = 134  
myRandomNumber = 112  
myRandomNumber = 187  
myRandomNumber = 231  
myRandomNumber = 57  
myRandomNumber = 248  
myRandomNumber = 179  
myRandomNumber = 171  
myRandomNumber = 30  
myRandomNumber = 233  
myRandomNumber = 110  
myRandomNumber = 132  
myRandomNumber = 245  
myRandomNumber = 184  
myRandomNumber = 170  
myRandomNumber = 32  
myRandomNumber = 5  
myRandomNumber = 23  
myRandomNumber = 181  
myRandomNumber = 23  
myRandomNumber = 120  
myRandomNumber = 80  
myRandomNumber = 2  
myRandomNumber = 96  
myRandomNumber = 138  
myRandomNumber = 101  
myRandomNumber = 241  
myRandomNumber = 219  
myRandomNumber = 83  
myRandomNumber = 217  
myRandomNumber = 99  
myRandomNumber = 106  
myRandomNumber = 119  
myRandomNumber = 118  
myRandomNumber = 8  
myRandomNumber = 149  
myRandomNumber = 135  
myRandomNumber = 183  
myRandomNumber = 249  
myRandomNumber = 99  
myRandomNumber = 175  
myRandomNumber = 105  
myRandomNumber = 173  
myRandomNumber = 173  
myRandomNumber = 142  
myRandomNumber = 136  
myRandomNumber = 66  
myRandomNumber = 223  
myRandomNumber = 55  
myRandomNumber = 225  
myRandomNumber = 232  
myRandomNumber = 5  
myRandomNumber = 182  
myRandomNumber = 26  
myRandomNumber = 169  
myRandomNumber = 21  
myRandomNumber = 138  
myRandomNumber = 171  
myRandomNumber = 32  
myRandomNumber = 192  
myRandomNumber = 156  
myRandomNumber = 134  
myRandomNumber = 13  
myRandomNumber = 46  
myRandomNumber = 239  
myRandomNumber = 76  
myRandomNumber = 243  
myRandomNumber = 158  
myRandomNumber = 90  
myRandomNumber = 64  
myRandomNumber = 25  
myRandomNumber = 68  
myRandomNumber = 224  
myRandomNumber = 173  
myRandomNumber = 3  
myRandomNumber = 206  
myRandomNumber = 250  
myRandomNumber = 244  
myRandomNumber = 134  
myRandomNumber = 80  
myRandomNumber = 198  
myRandomNumber = 227  
myRandomNumber = 197  
myRandomNumber = 152  
myRandomNumber = 109  
myRandomNumber = 43  
myRandomNumber = 4  
myRandomNumber = 61  
myRandomNumber = 141  
myRandomNumber = 129  
myRandomNumber = 131  
myRandomNumber = 150  
myRandomNumber = 90  
myRandomNumber = 62  
myRandomNumber = 231  
myRandomNumber = 65  
myRandomNumber = 36  
myRandomNumber = 78  
myRandomNumber = 92  
myRandomNumber = 155  
myRandomNumber = 203  
myRandomNumber = 242  
myRandomNumber = 122  
myRandomNumber = 182  
myRandomNumber = 192  
myRandomNumber = 161  
myRandomNumber = 2  
myRandomNumber = 29  
myRandomNumber = 99  
myRandomNumber = 206  
myRandomNumber = 60  
myRandomNumber = 183  
myRandomNumber = 242  
myRandomNumber = 101  
myRandomNumber = 25  
myRandomNumber = 22  
myRandomNumber = 167  
myRandomNumber = 67  
myRandomNumber = 33  
myRandomNumber = 79  
myRandomNumber = 196  
myRandomNumber = 8  
myRandomNumber = 90  
myRandomNumber = 83  
myRandomNumber = 4  
myRandomNumber = 67  
myRandomNumber = 208  
myRandomNumber = 125  
myRandomNumber = 48  
myRandomNumber = 236  
myRandomNumber = 12  
myRandomNumber = 108  
myRandomNumber = 231  
myRandomNumber = 216  
myRandomNumber = 219  
myRandomNumber = 96  
myRandomNumber = 67  
myRandomNumber = 190  
myRandomNumber = 111  
myRandomNumber = 14  
myRandomNumber = 136  
myRandomNumber = 6  
myRandomNumber = 160  
myRandomNumber = 18  
myRandomNumber = 78  
myRandomNumber = 39  
myRandomNumber = 66  
myRandomNumber = 141  
myRandomNumber = 190  
myRandomNumber = 208  
myRandomNumber = 156  
myRandomNumber = 8  
myRandomNumber = 102  
myRandomNumber = 13  
myRandomNumber = 128  
myRandomNumber = 166  
myRandomNumber = 139  
myRandomNumber = 123  
myRandomNumber = 161  
myRandomNumber = 21  
myRandomNumber = 165  
myRandomNumber = 133  
myRandomNumber = 220  
myRandomNumber = 150  
myRandomNumber = 38  
myRandomNumber = 103  
myRandomNumber = 110  
myRandomNumber = 254  
myRandomNumber = 70  
myRandomNumber = 144  
myRandomNumber = 167  
myRandomNumber = 53  
myRandomNumber = 248  
myRandomNumber = 89  
myRandomNumber = 89  
myRandomNumber = 222  
myRandomNumber = 82  
myRandomNumber = 30  
myRandomNumber = 234  
myRandomNumber = 73  
myRandomNumber = 36  
myRandomNumber = 72  
myRandomNumber = 183  
myRandomNumber = 100  
myRandomNumber = 3  
myRandomNumber = 98  
myRandomNumber = 236  
myRandomNumber = 81  
myRandomNumber = 228  
myRandomNumber = 120  
myRandomNumber = 43  
myRandomNumber = 186  
myRandomNumber = 212  
myRandomNumber = 111  
myRandomNumber = 113  
myRandomNumber = 220  
myRandomNumber = 43  
myRandomNumber = 79  
myRandomNumber = 187  
myRandomNumber = 14  
myRandomNumber = 137  
myRandomNumber = 235  
myRandomNumber = 137  
myRandomNumber = 90  
myRandomNumber = 7  
myRandomNumber = 229  
myRandomNumber = 103  
myRandomNumber = 20  
myRandomNumber = 129  
myRandomNumber = 127  
myRandomNumber = 149  
myRandomNumber = 24  
myRandomNumber = 187  
myRandomNumber = 179  
myRandomNumber = 210  
myRandomNumber = 216  
myRandomNumber = 153  
myRandomNumber = 202  
myRandomNumber = 127  
myRandomNumber = 234  
myRandomNumber = 119  
myRandomNumber = 151  
myRandomNumber = 212  
myRandomNumber = 177  
myRandomNumber = 103  
myRandomNumber = 203  
myRandomNumber = 114  
myRandomNumber = 219  
myRandomNumber = 108  
myRandomNumber = 186  
myRandomNumber = 80  
myRandomNumber = 57  
myRandomNumber = 137  
myRandomNumber = 197  
myRandomNumber = 177  
myRandomNumber = 173  
myRandomNumber = 180  
myRandomNumber = 222  
myRandomNumber = 156  
myRandomNumber = 248  
myRandomNumber = 65  
myRandomNumber = 168  
myRandomNumber = 97  
myRandomNumber = 132  
myRandomNumber = 203  
myRandomNumber = 67  
myRandomNumber = 214  
myRandomNumber = 22  
myRandomNumber = 120  
myRandomNumber = 250  
myRandomNumber = 177  
myRandomNumber = 127  
myRandomNumber = 29  
myRandomNumber = 45  
myRandomNumber = 62  
myRandomNumber = 82  
myRandomNumber = 34  
myRandomNumber = 13  
myRandomNumber = 226  
myRandomNumber = 103  
myRandomNumber = 142  
myRandomNumber = 190  
myRandomNumber = 22  
myRandomNumber = 19  
myRandomNumber = 211  
myRandomNumber = 47  
myRandomNumber = 75  
myRandomNumber = 81  
myRandomNumber = 195  
myRandomNumber = 71  
myRandomNumber = 183  
myRandomNumber = 243  
myRandomNumber = 252  
myRandomNumber = 174  
myRandomNumber = 209  
myRandomNumber = 92  
myRandomNumber = 34  
myRandomNumber = 165  
myRandomNumber = 22  
myRandomNumber = 178  
myRandomNumber = 136  
myRandomNumber = 136  
myRandomNumber = 72  
myRandomNumber = 132  
myRandomNumber = 162  
myRandomNumber = 37  
myRandomNumber = 45  
myRandomNumber = 186  
myRandomNumber = 66  
myRandomNumber = 237  
myRandomNumber = 26  
myRandomNumber = 133  
myRandomNumber = 30  
myRandomNumber = 126  
myRandomNumber = 90  
myRandomNumber = 177  
myRandomNumber = 95  
myRandomNumber = 26  
myRandomNumber = 14  
myRandomNumber = 130  
myRandomNumber = 234  
myRandomNumber = 36  
myRandomNumber = 49  
myRandomNumber = 212  
myRandomNumber = 193  
myRandomNumber = 85  
myRandomNumber = 100  
myRandomNumber = 245  
myRandomNumber = 92  
myRandomNumber = 220  
myRandomNumber = 74  
myRandomNumber = 177  
myRandomNumber = 11  
myRandomNumber = 208  
myRandomNumber = 113  
myRandomNumber = 101  
myRandomNumber = 175  
myRandomNumber = 238  
myRandomNumber = 150  
myRandomNumber = 21  
myRandomNumber = 184  
myRandomNumber = 210  
myRandomNumber = 111  
myRandomNumber = 221
```

  
  
  
**Summary of raw data:**  

```B4X
Number    Number of apperances     
0    5     
1    2     
2    8     
3    5     
4    4     
5    8     
6    7     
7    10     
8    7     
9    0    ZERO  
10    3     
11    4     
12    4     
13    10     
14    9     
15    3     
16    3     
17    6     
18    10     
19    10     
20    6     
21    9     
22    8     
23    6     
24    3     
25    7     
26    7     
27    4     
28    5     
29    7     
30    7     
31    2     
32    6     
33    6     
34    8     
35    6     
36    9     
37    8     
38    3     
39    4     
40    4     
41    3     
42    8     
43    9     
44    0    ZERO  
45    10     
46    3     
47    10     
48    5     
49    8     
50    3     
51    4     
52    7     
53    4     
54    6     
55    8     
56    12     
57    6     
58    5     
59    5     
60    5     
61    5     
62    8     
63    4     
64    5     
65    9     
66    7     
67    8     
68    7     
69    2     
70    6     
71    5     
72    7     
73    7     
74    6     
75    2     
76    9     
77    4     
78    8     
79    6     
80    11     
81    8     
82    4     
83    10     
84    4     
85    5     
86    4     
87    5     
88    4     
89    7     
90    9     
91    5     
92    7     
93    9     
94    5     
95    8     
96    7     
97    3     
98    3     
99    11     
100    6     
101    6     
102    8     
103    9     
104    4     
105    11     
106    2     
107    4     
108    7     
109    8     
110    7     
111    9     
112    5     
113    9     
114    4     
115    6     
116    6     
117    3     
118    7     
119    4     
120    13     
121    11     
122    4     
123    4     
124    4     
125    7     
126    11     
127    8     
128    10     
129    7     
130    7     
131    8     
132    6     
133    9     
134    9     
135    7     
136    8     
137    9     
138    5     
139    4     
140    4     
141    8     
142    7     
143    8     
144    9     
145    3     
146    9     
147    2     
148    6     
149    9     
150    4     
151    7     
152    5     
153    8     
154    2     
155    7     
156    9     
157    7     
158    6     
159    5     
160    2     
161    2     
162    4     
163    7     
164    2     
165    7     
166    6     
167    6     
168    5     
169    7     
170    2     
171    7     
172    9     
173    11     
174    10     
175    6     
176    8     
177    12     
178    4     
179    11     
180    5     
181    7     
182    3     
183    9     
184    4     
185    9     
186    6     
187    9     
188    5     
189    5     
190    7     
191    4     
192    9     
193    5     
194    5     
195    9     
196    5     
197    5     
198    5     
199    6     
200    6     
201    4     
202    5     
203    5     
204    4     
205    7     
206    7     
207    4     
208    8     
209    10     
210    4     
211    4     
212    6     
213    6     
214    4     
215    4     
216    7     
217    6     
218    5     
219    7     
220    13     
221    5     
222    6     
223    4     
224    4     
225    4     
226    7     
227    6     
228    7     
229    6     
230    4     
231    8     
232    5     
233    5     
234    10     
235    7     
236    6     
237    8     
238    4     
239    6     
240    4     
241    6     
242    7     
243    5     
244    8     
245    6     
246    3     
247    4     
248    7     
249    12     
250    8     
251    9     
252    8     
253    6     
254    11     
255    4
```