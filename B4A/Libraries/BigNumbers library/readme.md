### BigNumbers library by agraham
### 12/28/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/9540/)

If you need to do very accurate claculations using decimal numbers then the normal Java numeric types are not appropriate because, being finite length binary numbers, they cannot accurately represent every possible decimal number. The Java libraries contain a BigDecimal class that is optimised for calculation of arbitrary length decimal numbers.  
  
In fact BigDecimal is based on another class called BigInteger that can represent arbitrary length integers. A BigDecimal is a actually a BigInteger value and an Int decimal scaling value. As well as its use in BigDecimal BigInteger is optimised for use in asymmetric cryptography applications but is not so good for logical operations which although available should be avoided for performance reasons.  
  
Both BigDecimal and BigInteger are implemented in this library. The demo is deliberately trivial as to exhaustively demonstrate every function is impractical, and probably unnecessary. Any anomalies encountered using this library should be posted here.  
  
EDIT :- Version 1.1 posted. See post #10 for details.  
  
EDIT :- Version 1.2 posted. See post #13 for details.  
  
EDIT :- Version 1.2a posted. This time with the xml file! See post #15 for details.  
  
EDIT: Version 1.3 posted. See post #19 for details.