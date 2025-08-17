### Beginning Bespoke Block-Chains with B4J. by Mashiane
### 06/23/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/148655/)

Hi  
  
I have been curious about this, so here is my entepretation so far…  
  

```B4X
bitcoin.Initialize  
    '  
    Dim b1 As Block = bitcoin.NewBlock  
    bitcoin.SetField(b1, "amount", 5)  
    bitcoin.SetField(b1, "sender", "ALEX6FGSDDYFGSJJN")  
    bitcoin.SetField(b1, "recipient", "233TRESHHGAJJSH")  
    bitcoin.addBlock(b1)  
    '  
    Dim b2 As Block = bitcoin.NewBlock  
    bitcoin.SetField(b2, "amount", 10)  
    bitcoin.SetField(b2, "sender", "ALEX6FGSDDYFGSJJN")  
    bitcoin.SetField(b2, "recipient", "233TRESHHGAJJSH")  
    bitcoin.addBlock(b2)  
    'Log(b1)  
    Log(bitcoin)  
      
    Log(bitcoin.CheckValidity)  
    Log(bitcoin.proofOfWork(b1))  
    Log(bitcoin.proofOfWork(b2))
```

  
  
output  
  

```B4X
[chain=(ArrayList) [[IsInitialized=true, index=1, timestamp=1687472100011  
, data=(MyMap) {description=Genesis Block}, previousHash=, hash=1902380da1176a579721ea913b42e0e1e268e4c9ed2065200ba08c4ab7277af8  
, nonce=0], [IsInitialized=true, index=2, timestamp=1687472100047  
, data=(MyMap) {amount=5, sender=ALEX6FGSDDYFGSJJN, recipient=233TRESHHGAJJSH}, previousHash=1902380da1176a579721ea913b42e0e1e268e4c9ed2065200ba08c4ab7277af8, hash=7c56e6152935d8205dfc782b0ff2829ff4dc270b81a768feea924093406f3db8  
, nonce=0], [IsInitialized=true, index=3, timestamp=1687472100048  
, data=(MyMap) {amount=10, sender=ALEX6FGSDDYFGSJJN, recipient=233TRESHHGAJJSH}, previousHash=7c56e6152935d8205dfc782b0ff2829ff4dc270b81a768feea924093406f3db8, hash=40cedc9404abb6b2406092c810e07a1967e2af50af8de283c9e194ac830b7c85  
, nonce=0]], main=null]  
true  
57461  
87433
```

  
  
Still exploring further…