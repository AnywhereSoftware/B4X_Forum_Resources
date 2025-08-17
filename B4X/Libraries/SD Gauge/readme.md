###  SD Gauge by Star-Dust
### 10/11/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/143435/)

![](https://www.b4x.com/android/forum/attachments/134633)  
  
**aSD\_Gauge  
  
Author:** Star-Dust  
**Version:** 1.02  

- **SDGaugeView**

- **Fields:**

- **BorderBallDepth** As Int
- **ColorBorderBall** As Int
- **mBase** As B4XView
- **MinimumFractions** As Int
- **Stroke** As Float
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **Initialize** (Callback As Object, EventName As String) As String
- **Invalidate** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **Properties:**

- **TextFont**
- **Value** As Float
- **ValueMax** As Float
- **ValueMin** As Float

  

---

  
The iOS version will arrive in the future. The colors of the arches are selectable from Design  
  
Rel.  

- 1.02

- Improved animation: When a new value is set, the dot scrolls until it reaches the new position
- Added **MinimimFractions** field. Determine how many decimal places the minimum must enter. Standar is zero

- NEXT