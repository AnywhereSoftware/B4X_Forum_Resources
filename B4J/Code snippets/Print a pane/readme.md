### Print a pane by Ali Dashtaki
### 10/22/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/123701/)

Hello  
I wanted to print a pane to a specific size like A4.  
I searched but I didn't find any library or code snippet. So I wrote it myself. Hope this is useful for others.  
  

```B4X
Public Sub PrintPane(pn As Pane, Paper As Paper)  
    Dim PJ As PrinterJob = PrinterJob_Static.CreatePrinterJob  
    If PJ.ShowPrintDialog(Null) Then  
        Dim Printer As Printer = PJ.GetPrinter  
        Dim PP As Paper  
        Dim PL As PageLayout  
     
        PP.Initialize  
        PP=Paper  
     
        PL=Printer.CreatePageLayout2(PP,PageOrientation_Static.LANDSCAPE,"HARDWARE_MINIMUM")  
     
        Dim hei As Double = Paper.GetWidth/pn.Height - 0.03  
        Dim wid As Double = Paper.GetHeight/pn.Width - 0.02  
     
        Dim pnl As Pane  
        pnl.Initialize("")  
        pnl.PrefHeight =  Paper.GetWidth  
        pnl.PrefWidth =  Paper.GetHeight  
        Dim l As List  
        l.Initialize  
     
        For Each n As Node In pn.GetAllViewsRecursive  
            If n Is Label Then  
                Dim lbl As Label = n  
                lbl.TextSize = lbl.TextSize*wid  
                l.add(lbl.Text)  
                pnl.AddNode(lbl,lbl.Left*wid,lbl.Top*hei,lbl.PrefWidth*wid,lbl.PrefHeight*hei)  
            Else If n Is Button Then  
                Dim btn As Button = n  
                btn.TextSize = btn.TextSize*wid  
                l.Add(btn.Text)  
                pnl.AddNode(btn,btn.Left*wid,btn.Top*hei,btn.PrefWidth*wid,btn.PrefHeight*hei)  
            Else  
                Dim n2 As Node = n  
                pnl.AddNode(n2,n2.Left*wid,n2.Top*hei,n2.PrefWidth*wid,n2.PrefHeight*hei)  
            End If  
        Next  
        Dim j As Int = 0  
        For Each n As Node In pnl.GetAllViewsRecursive  
            If n Is Label Then  
                Dim lbl As Label = n  
                lbl.Text = ""  
                lbl.Text = l.Get(j)  
                j = j+1  
            Else If n Is Button Then  
                Dim btn As Button = n  
                btn.Text = ""  
                btn.Text = l.Get(j)  
                j = j+1  
            End If  
        Next  
        Dim PJ As PrinterJob = PrinterJob_Static.CreatePrinterJob2(Printer)  
     
        PJ.PrintPage2(PL,pnl)  
        PJ.EndJob  
     
        For Each n As Node In pnl.GetAllViewsRecursive  
            If n Is Label Then  
                Dim lbl As Label = n  
                lbl.TextSize = lbl.TextSize/wid  
                pn.AddNode(lbl,lbl.Left/wid,lbl.Top/hei,lbl.PrefWidth/wid,lbl.PrefHeight/hei)  
            Else If n Is Button Then  
                Dim btn As Button = n  
                btn.TextSize = btn.TextSize/wid  
                pn.AddNode(btn,btn.Left/wid,btn.Top/hei,btn.PrefWidth/wid,btn.PrefHeight/hei)  
            Else  
                Dim n2 As Node = n  
                pn.AddNode(n2,n2.Left/wid,n2.Top/hei,n2.PrefWidth/wid,n2.PrefHeight/hei)  
            End If  
        Next  
     
        j = 0  
        For Each n As Node In pn.GetAllViewsRecursive  
            If n Is Label Then  
                Dim lbl As Label = n  
                lbl.Text = ""  
                lbl.Text = l.Get(j)  
                j = j+1  
            Else If n Is Button Then  
                Dim btn As Button = n  
                btn.Text = ""  
                btn.Text = l.Get(j)  
                j = j+1  
            End If  
        Next  
    End If  
End Sub
```

  
  
For example : PrintPane(Pane1,Paper\_static.A4)  
  
P.S : I used jFX8Print library. I attach it below.