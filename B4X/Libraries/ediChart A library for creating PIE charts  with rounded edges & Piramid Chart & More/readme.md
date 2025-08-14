###  ediChart A library for creating PIE charts  with rounded edges & Piramid Chart & More by valerioup
### 07/26/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/167882/)

This library allows you to create bar charts simply by adding a list of values. Examples are included in b4a and b4j.  
You can now create 3 types of charts: animated pie charts with rounded edges, vertical bar charts with depth effects, and pyramid charts.  
  
The library is provided as b4xlib, but I do not authorize its decompilation.  
  
All code is pure b4x.  
  
**EdiChart  
Autor: Valerio Dossetto  
Versione: 1.03**  
  
  
![](https://www.b4x.com/android/forum/attachments/165536)![](https://www.b4x.com/android/forum/attachments/165538)![](https://www.b4x.com/android/forum/attachments/165590)  
![](https://www.b4x.com/android/forum/attachments/165602)![](https://www.b4x.com/android/forum/attachments/165603)  
  

```B4X
Private Sub Button2_Click  
  
    Dim lista As List  
    lista.Initialize  
    Dim num1 As Int  
    num1=(Rnd(3,13))  
    For i = 1 To num1  
        Dim e As Elemento  
        e.Initialize  
        e.Nome = "Item " & i  
        e.Valore = Rnd(10, 200)  
        lista.Add(e)  
    Next  
    'not sorted  
    ediPiramidChart1.Grafico(lista,False)  
    ediBarRound3d1.Grafico(lista,False)  
    EdiPieChart21.GraficoAnimato(lista,False)  
End Sub  
  
  
Private Sub Button1_Click  
    Dim lista As List  
    lista.Initialize  
    Dim num1 As Int  
    num1=(Rnd(3,13))  
    For i = 1 To num1  
        Dim e As Elemento  
        e.Initialize  
        e.Nome = "Item " & i  
        e.Valore = Rnd(10, 200)  
        lista.Add(e)  
    Next  
    'sorted  
    ediPiramidChart1.Grafico(lista,True)  
    ediBarRound3d1.Grafico(lista,True)  
    EdiPieChart21.GraficoAnimato(lista,True)  
  
End Sub
```

  
  
  
  
**Change log**  

- **1.00**

- Initial release

- **1.01**

- Add ediPiramidChart
Add ediBarRound3d
Changed the order of the colors
- **1.02**

- Add animation
- Clear variables and definitions
- Update demo
- Add ediBar3d (dark & Light)

- **1.03**

- Add ediBar
- Add ediPiramidGlass

  
  
I spend a lot of time creating components like this, and creating a library takes a lot of time. If you'd like to support me and add more libraries, you can do so here via PayPal or with a coffee. :)  
  
[![](https://www.b4x.com/android/forum/attachments/165505)](https://paypal.me/DossettoValerio)