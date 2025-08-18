### math evaluation by lolo32
### 01/19/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/126699/)

Hello,  
excuse my english (google translate)  
  
here is a module to evaluate a math expression  
  
use:  
(name of module).calc (string to evaluate) result string  
  
example:  
string to evaluate:  
"-5 (-8 ^ 5 \* ln (cos (5 + 8)) - (- 45-9) 56 / (- 8 + 4 \* 8)) sin-4 \* -78"  
  
return:  
"976495.8664282738"  
  
automatic setting of "\*" (multiplication) if not present  
  
thank you to the moderators to move to the right section if necessary …  
  
laurent.  
  

```B4X
Sub Process_Globals  
    Public chaine As List  
    Public y As Int  
  
End Sub  
  
Sub calc(ch As String) As String  
  
    Dim test As String  
    Dim retour As String  
    Dim x As Int  
      
    chaine.Initialize  
      
    'renvoi "0" si la chaine est nul  
    If ch = "" Then  
        Return "0"  
    End If  
  
    'remplacement des "," par "."  
    test=ch.Replace(",",".")  
  
    'remplacement des espaces par rien  
    test=test.Replace(" ","")  
  
    'test si toutes les parenteses sont presentes  
    If parenteses(test) = False Then  
        Return "erreur de parenteses"  
    End If  
  
    'verification s'il n'y a pas de caracteres superieurs a 128  
    For x = 0 To test.Length-1  
        If Asc(test.SubString2(x,x+1))>128 Then  
            Return "erreur"  
        End If  
    Next  
  
    'simplification  
    test=test.Replace("++","+")  
    test=test.Replace("+-","-")  
    test=test.Replace("-+","-")  
    test=test.Replace("–","+")  
  
    'conversion des fonctions mathematiques en caracteres superieurs a 128  
    test = test.Replace("harccotan", Chr(228))  
    'test = test.Replace("arccotan", Chr(216))  
    test = test.Replace("harctan", Chr(225))  
    test = test.Replace("hcotan", Chr(222))  
    test = test.Replace("cotan", Chr(211))  
    test = test.Replace("htan", Chr(219))  
    test = test.Replace("tan", Chr(207))  
    test = test.Replace("atn", Chr(200))  
  
    'test = test.Replace("harccosec", Chr(227))  
    'test = test.Replace("arccosec", Chr(215))  
    test = test.Replace("harccos", Chr(224))  
    test = test.Replace("hcosec", Chr(221))  
    test = test.Replace("arccos", Chr(213))  
    test = test.Replace("cosec", Chr(210))  
    test = test.Replace("hcos", Chr(217))  
    test = test.Replace("cos", Chr(201))  
  
    test = test.Replace("harcsec", Chr(226))  
    'test = test.Replace("arcsec", Chr(214))  
    test = test.Replace("hsec", Chr(220))  
    test = test.Replace("sec", Chr(209))  
    test = test.Replace("ln", Chr(208))  
  
    test = test.Replace("exp", Chr(202))  
    test = test.Replace("sqr", Chr(203))  
    test = test.Replace("log", Chr(204))  
    test = test.Replace("int", Chr(229))  
    test = test.Replace("abs", Chr(230))  
    test = test.Replace("mod", Chr(250))  
  
    test = test.Replace("harcsin", Chr(223))  
    test = test.Replace("arcsin", Chr(212))  
    test = test.Replace("hsin", Chr(218))  
    test = test.Replace("sin", Chr(205))  
    test = test.Replace("PI", "P")  
  
    'mise en majuscules  
    test=test.ToUpperCase  
      
    'mise en tableau de l'equation  
    retour = tableau(test)  
    If retour <> "ok" Then  
        Return retour  
    End If  
  
    'calcul de l'equation dans le tableau  
  
    Return calc_eq  
  
End Sub  
  
Sub parenteses(string_to_test As String) As Boolean                                                'ok  
  
    'test s'il y a le meme nombre de parenteses ouvertes que fermes  
    'et test si elles sont dans le bon sens  
  
    Dim x As Int  
    Dim y As Int  
  
    y = 0  
  
    For x = 0 To string_to_test.Length-1  
        If string_to_test.SubString2(x,x+1)="(" Then y=y+1  
        If string_to_test.SubString2(x,x+1)=")" Then y=y-1  
        If y < 0 Then Return False  
    Next  
  
    If y = 0 Then  
        Return True  
    Else  
        Return False  
    End If  
  
End Sub  
  
Sub pare() As Int  
    'recherche la premiere fermeture de parenteses  
  
    Dim x As Int  
  
    For  x=0 To chaine.Size-1  
        If chaine.Get(x)=")" Then  
            Return x-1  
        End If  
    Next  
  
    Return -1        'il n'y a plus de parentheses  
  
End Sub  
  
Sub tableau(test As String) As String  
  
    'mise en tableau de l'equation  
    'et test si l'equation est ok  
  
    Dim car As String  
    Dim x As Int  
    Dim car_avant As String  
    Dim fin As Boolean  
    Dim avant As Boolean  
  
    fin = False  
  
    car_avant = " "         'pour ne pas gener la procedure  
  
    y = -1  
  
    For x = 0 To test.Length-1  
        avant = False  
      
        'car = Mid$(test, x, 1)  
        car=test.SubString2(x,x+1)  
      
        If x = test.Length Then fin = True  
  
        Select Case car  
            Case Chr(200), Chr(201), Chr(202), Chr(203), Chr(204), Chr(205), Chr(206), Chr(207), Chr(208), Chr(209), Chr(210), Chr(211), Chr(212), Chr(213), Chr(217), Chr(218), Chr(219), Chr(220), Chr(221), Chr(222), Chr(223), Chr(224), Chr(225), Chr(226), Chr(228), Chr(229), Chr(230)  
                If macro_test(car, car_avant, fin) <> "ok" Then  
                    Return "erreur d'ecriture au caracteres n°" & x  
                End If  
            Case "+", "*", "/", "^", Chr(250)  
                If fin = True Then  
                    Return "erreur d'ecriture au caracteres n°" & x  
                End If  
              
                If car_avant = ")" Or (Asc(car_avant) > 47 And Asc(car_avant) < 58) Then  
                    nouveau(car)  
                Else  
                    Return "erreur d'ecriture au caracteres n°" & x  
                End If  
            Case "-"  
                If fin = True Then  
                    Return "erreur d'ecriture au caracteres n°" & x  
                End If  
              
                If car_avant = ")" Or (Asc(car_avant) > 47 And Asc(car_avant) < 58) Then  
                    nouveau(car)  
                Else  
                    If car_avant = " " Or Asc(car_avant) > 199 Or car_avant = "*" Or car_avant = "/" Or car_avant = "^" Or car_avant = "(" Then  
                        'c'est peut etre un signe  
                        nouveau(car)  
                        car = " " & car  
                    Else  
                        Return "erreur d'ecriture au caracteres n°" & x  
                    End If  
                End If  
            Case "("  
                If fin = True Then  
                    Return "erreur d'ecriture au caracteres n°" & x  
                End If  
              
                If car_avant = "+" Or car_avant = "-" Or car_avant = "*" Or car_avant = "/" Or car_avant = "^" Or car_avant = "(" Or car_avant = " " Or Asc(car_avant) > 199 Then  
                    nouveau(car)  
                Else  
                    If car_avant = ")" Or (Asc(car_avant) > 47 And Asc(car_avant) < 58) Then  
                        nouveau("*")  
                        nouveau(car)  
                    Else  
                        If car_avant = " -" Then  
                            chaine.Add(" " & car)  
                            'c(y) = " " + car  
                        Else  
                            Return "erreur d'ecriture au caracteres n°" & x  
                        End If  
                    End If  
                End If  
            Case ")"  
                If car_avant = ")" Or (Asc(car_avant) > 47 And Asc(car_avant) < 58) Then  
                    nouveau(car)  
                Else  
                    Return "erreur d'ecriture au caracteres n°" & x  
                End If  
            Case "."  
                If fin = True Then  
                    Return "erreur d'ecriture au caracteres n°" & x  
                End If  
              
                If car_avant = "+" Or car_avant = "-" Or car_avant = "*" Or car_avant = "/" Or car_avant = "^" Or car_avant = "(" Or car_avant = " " Or Asc(car_avant) > 199 Then  
                    nouveau("0" + car)  
                Else  
                    If car_avant = ")" Then  
                        nouveau("*")  
                        nouveau("0" + car)  
                    Else  
                        Dim qs As String=chaine.Get(y)  
                          
                        If (Asc(chaine.Get(car_avant))>47 And Asc(chaine.Get(car_avant))<58)  And Not(qs.Contains(".")) Then  
                            'If ((Asc(car_avant) > 47 And Asc(car_avant) < 58) And InStr(1, c(y), ".") = 0) Then  
                            chaine.Set(y,chaine.Get(y) & car)  
                            'c(y) = c(y) + car  
                        Else  
                            If car_avant = " -" Then  
                                chaine.Add("-0" & car)  
                                'c(y) = "-0" + car  
                            Else  
                                Return "erreur d'ecriture au caracteres n°" & x  
                            End If  
                        End If  
                    End If  
                End If  
          
            Case "Z", "P", "E"  
                If car_avant = "+" Or car_avant = "-" Or car_avant = "*" Or car_avant = "/" Or car_avant = "^" Or car_avant = "(" Or car_avant = " " Or Asc(car_avant) > 199 Then  
                    nouveau(car)  
                Else  
                    If (Asc(car_avant) > 47 And Asc(car_avant) < 58) Or car_avant = ")" Then  
                        nouveau("*")  
                        nouveau(car)  
                    Else  
                        Return "erreur d'ecriture au caracteres n°" & x  
                    End If  
                End If  
              
                avant = True  
                car_avant = ")"  
              
            Case Else  
                If Asc(car) > 47 And Asc(car) < 58 Then  
                    If car_avant = "+" Or car_avant = "-" Or car_avant = "*" Or car_avant = "/" Or car_avant = "^" Or car_avant = "(" Or Asc(car_avant) > 199 Or car_avant = " " Then  
                        nouveau(car)  
                    Else  
                        If car_avant = "." Or Asc(car_avant) > 47 And Asc(car_avant) < 58 Or car_avant = " -" Then  
                            chaine.Set(y,chaine.Get(y) & car)  
                            'c(y) = c(y) + car  
                        Else  
                            If car_avant = ")" Then  
                                nouveau("*")  
                                nouveau(car)  
                            Else  
                                If chaine.Get(y)=" -" Then  
                                    'If c(y) = " -" Then  
                                    chaine.Add(" " & car)  
                                    'c(y) = "-" + car  
                                Else  
                                    Return "erreur d'ecriture au caracteres n°" & x  
                                End If  
                            End If  
                        End If  
                    End If  
                Else  
                    Return "erreur d'ecriture au caracteres n°" & x  
                End If  
        End Select  
      
        If avant = False Then  
            car_avant = car  
        End If  
  
    Next  
  
    Return "ok"  
  
End Sub  
  
  
Sub nouveau(car As String)  
  
    'additionne une case avec le nouveau caractere dans le tableau  
  
    y = y + 1  
  
    Select Case car  
        Case "E"  
            chaine.Add("2.71828182845905")  
        Case "P"  
            chaine.Add("3.14159265358979")  
        Case Else  
            chaine.Add(car)  
    End Select  
  
End Sub  
  
Sub macro_test(car As String, car_avant As String, fin As Boolean) As String  
  
    Dim retour As String="ok"  
    'macro_test = "ok"  
  
    If fin = True Then  
        Return "erreur d'ecriture au caracteres n°"  
    End If  
  
    If car_avant = "+" Or car_avant = "-" Or car_avant = "*" Or car_avant = "/" Or car_avant = "^" Or car_avant = "(" Or car_avant = " " Or Asc(car_avant) > 199 Then  
        nouveau(car)  
    Else  
        If (Asc(car_avant) > 47 And Asc(car_avant) < 58) Or car_avant = ")" Then  
            nouveau("*")  
            nouveau(car)  
        Else  
            If car_avant = " -" Then  
                chaine.Add(" " & car)  
                'c(y) = " " + car  
            Else  
                Return "erreur d'ecriture au caracteres n°"  
            End If  
        End If  
    End If  
  
    Return retour  
  
End Sub  
  
  
Sub calc_eq() As String  
  
    'calcul de l'equation dans le tableau  
      
    Dim retour As String  
    Dim x As Int  
    Dim debut As Int  
    Dim fin As Int  
  
    'tant qu'il ne reste pas une seule case dans le tableau, calcul l'equation  
    Do Until y = 0  
  
        'recherche s 'il y a encore des parenteses  
        fin = pare  
  
        If fin > -1 Then  
            'il y a encore des parentheses  
            For x = fin To 0 Step -1  
                If chaine.Get(x)="(" Or chaine.Get(x)=" (" Then  
                    'If c(x) = "(" Or c(x) = " (" Then  
                    debut = x + 1  
                    x=-1  
                    'Exit for  
                End If  
            Next  
        Else  
            'il n 'y a plus de parentheses  
            fin = y  
            debut = 0  
        End If  
  
        retour = calc_simple(debut, fin)  
  
        If retour <> "ok" Then  
            Return retour  
        End If  
  
    Loop  
  
    Return chaine.Get(0)  
  
End Sub  
  
Sub calcul(operateur As Int) As String  
  
    'calcul selon le type d'operation  
  
    Dim x As Double=chaine.get(operateur+1)  
    Dim inv As Boolean  
  
    'x = Val(c(operateur + 1))  
  
    Dim qs As String=chaine.Get(operateur)  
      
    If qs.Contains(" ") Then  
        'If InStr(c(operateur), " ") > 0 Then  
        chaine.Set(operateur,qs.Replace(" ",""))  
        'c(operateur) = Replace(c(operateur), " ", "")  
        inv = True  
    Else  
        inv = False  
    End If  
  
    Try  
  
        qs=chaine.Get(operateur)  
        Select qs  
            Case "+"  
                Dim res As String=chaine.Get(operateur-1)+x  
                chaine.Set(operateur-1,res)  
                'c(operateur - 1) = Replace(Str(Val(c(operateur - 1)) + x), " ", "")  
            Case "-"  
                Dim res As String=chaine.Get(operateur-1)-x  
                chaine.Set(operateur-1,res)  
                'c(operateur - 1) = Replace(Str(Val(c(operateur - 1)) - x), " ", "")  
            Case "*"  
                Dim res As String=chaine.Get(operateur-1)*x  
                chaine.Set(operateur-1,res)  
                'c(operateur - 1) = Replace(Str(Val(c(operateur - 1)) * x), " ", "")  
            Case "/"  
                Dim res As String=chaine.Get(operateur-1)/x  
                chaine.Set(operateur-1,res)  
                'c(operateur - 1) = Replace(Str(Val(c(operateur - 1)) / x), " ", "")  
            Case "^"  
                Dim res As String=Power(chaine.Get(operateur-1),x)  
                chaine.Set(operateur-1,res)  
                'If Left$(c(operateur - 1), 1) = "-" Then  
                'le nombre est negatif  
                'Dim y As Double=chaine.Get(operateur-1)  
                'y = Val(c(operateur - 1))  
                'y = -y  
                'Dim res As String=chaine.Get(operateur-1)  
                  
                'c(operateur - 1) = Replace(Str(y ^ x), " ", "")  
                'c(operateur - 1) = "-" + c(operateur - 1)  
                'Else  
                'le nombre est positif  
                'Dim res As String=Power(chaine.Get(operateur-1),x)  
                'chaine.Set(operateur-1)=res  
                'c(operateur - 1) = Replace(Str(Val(c(operateur - 1)) ^ x), " ", "")  
                'End If  
  
            Case Chr(200)  
                Dim res As String=ATan(x)  
                chaine.set(operateur,res)  
                'Atn(x)  
                'c(operateur) = Replace(Str(Atn(x)), " ", "")  
            Case Chr(201)  
                Dim res As String=Cos(x)  
                chaine.set(operateur,res)  
                'Cos(x)  
                'c(operateur) = Replace(Str(Cos(x)), " ", "")  
            Case Chr(202)  
                Dim res As String=Power(x,cE)  
                chaine.set(operateur,res)  
                'Exp(x)  
                'c(operateur) = Replace(Str(Exp(x)), " ", "")  
            Case Chr(203)  
                Dim res As String=Sqrt(x)  
                chaine.set(operateur,res)  
                'Sqr(x)  
                'c(operateur) = Replace(Str(Sqr(x)), " ", "")  
            Case Chr(204)  
                Dim res As String=Logarithm(x,10)  
                chaine.set(operateur,res)  
                'Log10(x) = Log(x) / Log(10)  
                'c(operateur) = Replace(Str(Log(x) / Log(10)), " ", "")  
            Case Chr(205)  
                Dim res As String=Sin(x)  
                chaine.set(operateur,res)  
                'Sin(x)  
                'c(operateur) = Replace(Str(Sin(x)), " ", "")  
            Case Chr(207)  
                Dim res As String=Tan(x)  
                chaine.set(operateur,res)  
                'Tan(x)  
                'c(operateur) = Replace(Str(Tan(x)), " ", "")  
            Case Chr(208)  
                Dim res As String=Logarithm(x,cE)  
                chaine.set(operateur,res)  
                'Ln(x)  
                'c(operateur) = Replace(Str(Log(x)), " ", "")  
            Case Chr(209)  
                Dim res As String=1/Cos(x)  
                chaine.set(operateur,res)  
                'Sec(x) = 1 / Cos(x)  
                'c(operateur) = Replace(Str(1 / Cos(x)), " ", "")  
            Case Chr(210)  
                Dim res As String=1/Sin(x)  
                chaine.set(operateur,res)  
                'Cosec(x) = 1 / Sin(x)  
                'c(operateur) = Replace(Str(1 / Sin(x)), " ", "")  
            Case Chr(211)  
                Dim res As String=1/Tan(x)  
                chaine.set(operateur,res)  
                'Cotan(x) = 1 / Tan(x)  
                'c(operateur) = Replace(Str(1 / Tan(x)), " ", "")  
            Case Chr(212)  
                Dim res As String=ATan(x/Sqrt(-x*x+1))  
                chaine.set(operateur,res)  
                'Arcsin(X) = Atn(x / Sqr(-x * x + 1))  
                'c(operateur) = Replace(Str(Atn(x / Sqr(-x * x + 1))), " ", "")  
            Case Chr(213)  
                Dim res As String=ATan(-x/Sqrt(-x*x+1))  
                chaine.set(operateur,res)  
                'Arccos(x) = Atn(-x / Sqr(-x * x + 1)) + 2 * Atn(1)  
                'c(operateur) = Replace(Str(Atn(-x / Sqr(-x * x + 1)) + 2 * Atn(1)), " ", "")  
                'Case Chr(214)  
                'Dim res As String=atn(x/Sqrt(x*x-1))+  
                'chaine.operateur=res  
                'Arcsec(x) = Atn(x / Sqr(x * x – 1)) + Sgn((x) – 1) * (2 * Atn(1))  
                'c(operateur) = Replace(Str(Atn(x / Sqr(x * x - 1)) + Sgn((x) - 1) * (2 * Atn(1))), " ", "")  
                'Case Chr(215)  
                'Arccosec(x) = Atn(x / Sqr(x * x – 1)) + (Sgn(x) – 1) * (2 * Atn(1))  
                'c(operateur) = Replace(Str(Atn(x / Sqr(x * x - 1)) + (Sgn(x) - 1) * (2 * Atn(1))), " ", "")  
                'Case Chr(216)  
                'Arccotan(x) = Atn(x) + 2 * Atn(1)  
                'c(operateur) = Replace(Str(Atn(x) + 2 * Atn(1)), " ", "")  
            Case Chr(217)  
                Dim res As String=Power(x,cE)+Power(-x,cE)/2  
                chaine.set(operateur,res)  
                'HCos(x) = (Exp(x) + Exp(-x)) / 2  
                'c(operateur) = Replace(Str((Exp(x) + Exp(-x)) / 2), " ", "")  
            Case Chr(218)  
                Dim res As String=Power(x,cE)-Power(-x,cE)/2  
                chaine.set(operateur,res)  
                'HSin(x) = (Exp(x) – Exp(-x)) / 2  
                'c(operateur) = Replace(Str((Exp(x) - Exp(-x)) / 2), " ", "")  
            Case Chr(219)  
                Dim res As String=(Power(x,cE)+Power(-x,cE))/(Power(x,cE)+Power(-x,cE))  
                chaine.set(operateur,res)  
                'HTan(x) = (Exp(x) – Exp(-x)) / (Exp(x) + Exp(-x))  
                'c(operateur) = Replace(Str((Exp(x) - Exp(-x)) / (Exp(x) + Exp(-x))), " ", "")  
            Case Chr(220)  
                Dim res As String=2/(Power(x,cE)+Power(-x,cE))  
                chaine.set(operateur,res)  
                'HSec(x) = 2 / (Exp(x) + Exp(-x))  
                'c(operateur) = Replace(Str(2 / (Exp(x) + Exp(-x))), " ", "")  
            Case Chr(221)  
                Dim res As String=2/(Power(x,cE)-Power(-x,cE))  
                chaine.set(operateur,res)  
                'HCosec(x) = 2 / (Exp(x) – Exp(-x))  
                'c(operateur) = Replace(Str(2 / (Exp(x) - Exp(-x))), " ", "")  
            Case Chr(222)  
                Dim res As String=(Power(x,cE)+Power(-x,cE))/(Power(x,cE)-Power(-x,cE))  
                chaine.set(operateur,res)  
                'HCotan(x) = (Exp(x) + Exp(-x)) / (Exp(x) – Exp(-x))  
                'c(operateur) = Replace(Str((Exp(x) + Exp(-x)) / (Exp(x) - Exp(-x))), " ", "")  
            Case Chr(223)  
                Dim res As String=Logarithm(x+Sqrt(x*x+1),cE)  
                chaine.set(operateur,res)  
                'HArcsin(x) = Log(x + Sqr(x * x + 1))  
                'c(operateur) = Replace(Str(Log(x + Sqr(x * x + 1))), " ", "")  
            Case Chr(224)  
                Dim res As String=Logarithm(x+Sqrt(x*x-1),cE)  
                chaine.set(operateur,res)  
                'HArccos(x) = Log(x + Sqr(x * x – 1))  
                'c(operateur) = Replace(Str(Log(x + Sqr(x * x - 1))), " ", "")  
            Case Chr(225)  
                Dim res As String=Logarithm((1+x)/(1-x),cE)/2  
                chaine.set(operateur,res)  
                'HArctan(x) = Log((1 + x) / (1 – x)) / 2  
                'c(operateur) = Replace(Str(Log(x + Sqr(x * x - 1))), " ", "")  
            Case Chr(226)  
                Dim res As String=Logarithm((Sqrt(-x*x+1)+1)/x,cE)  
                chaine.set(operateur,res)  
                'Harcsec(x) = Log((Sqr(-x * x + 1) + 1) / x)  
                'c(operateur) = Replace(Str(Log((Sqr(-x * x + 1) + 1) / x)), " ", "")  
                'Case Chr(227)  
                'Dim res As String=Logarithm((Sqrt(-x*x+1)+1)/x,cE)  
                'chaine.set(operateur)=res  
                'HArccosec(x) = Log((Sgn(x) * Sqr(x * x + 1) + 1) / x)  
                'c(operateur) = Replace(Str(Log((Sgn(x) * Sqr(x * x + 1) + 1) / x)), " ", "")  
            Case Chr(228)  
                Dim res As String=Logarithm((x+1)/(x-1),cE)/2  
                chaine.set(operateur,res)  
                'HArccotan(x) = Log((x + 1) / (x – 1)) / 2  
                'c(operateur) = Replace(Str(Log((x + 1) / (x - 1)) / 2), " ", "")  
            Case Chr(229)  
                Dim res1 As Int=chaine.Get(operateur)  
                Dim res2 As Long=res1  
                chaine.set(operateur,res2)  
                'int  
                'c(operateur) = Replace(Str(Int(x)), " ", "")  
            Case Chr(230)  
                Dim res As String=Abs(chaine.Get(operateur))  
                chaine.set(operateur,res)  
                'abs  
                'c(operateur) = Replace(Str(Abs(x)), " ", "")  
            Case Chr(250)  
                Dim res As String=chaine.Get(operateur-1) Mod x  
                chaine.set(operateur,res)  
                'c(operateur - 1) = Replace(Str(Val(c(operateur - 1)) Mod x), " ", "")  
        End Select  
  
        If inv = True Then  
            chaine.Set(operateur,"-" & chaine.Get(operateur))  
            'c(operateur) = Str(0 - Val(c(operateur)))  
        End If  
  
        Return "ok"  
  
    Catch  
        Return LastException  
      
    End Try  
  
End Sub  
  
Sub calc_simple(debut As Int, fin As Int) As String  
  
    'cherche l'operateur prioritaire entre debut et fin  
    '1er-fonction  
    '2em-exposant  
    '3em-multiplication ou division  
    '4em-addition ou soustraction  
    's'il n'y a pas d'operateur alors simplification  
  
    Dim position As Int  
    Dim retour As String  
  
    'recherche d'une fonction dans les limites (par la fin !)  
  
    For position = fin To debut Step -1  
        'If Len(c(position)) = 1 And Asc(c(position)) > 199 Then  
        Dim qs As String=chaine.Get(position)  
        chaine.Set(position,qs.replace(" ",""))  
          
        If Asc(chaine.Get(position)) > 199 And Asc(chaine.Get(position)) < 250 Then  
            'il y a une fonction !  
            retour = calcul(position)  
            'simplification s'il n'y a pas d'erreur  
            If retour = "ok" Then  
                'simplification  
                reorganisation(position + 1, 1)  
            End If  
            Return retour  
        End If  
    Next  
  
    'recherche d'un exposant dans les limites  
  
    For position = debut To fin  
        'If Len(c(position)) = 1 And c(position) = "^" Then  
        'If c(position) = "^" Then  
        If chaine.Get(position)="^" Then  
            'il y a un exposant !  
            retour = calcul(position)  
            'simplification s'il n'y a pas d'erreur  
            If retour = "ok" Then  
                'simplification  
                reorganisation(position, 2)  
            End If  
            Return retour  
        End If  
    Next  
  
    'recherche d'une multiplication, d'une division ou d'un modulo dans les limites  
  
    For position = debut To fin  
        'If Len(c(position)) = 1 And (c(position) = "*" Or c(position) = "/") Then  
        If chaine.Get(position) = "*" Or chaine.Get(position) = "/" Or chaine.Get(position) = Chr(250) Then  
            'il y a une multiplication ou division !  
            retour = calcul(position)  
            'simplification s'il n'y a pas d'erreur  
            If retour = "ok" Then  
                'simplification  
                reorganisation(position, 2)  
            End If  
            Return retour  
        End If  
    Next  
  
    'recherche d'une addition ou soustraction dans les limites  
  
    For position = debut To fin  
        'If Len(c(position)) = 1 And (c(position) = "+" Or c(position) = "-") Then  
        If chaine.Get(position) = "+" Or chaine.Get(position) = "-" Then  
            'il y a une addition ou soustraction !  
            retour = calcul(position)  
            If retour = "ok" Then  
                'simplification  
                reorganisation(position, 2)  
            End If  
            Return retour  
        End If  
    Next  
  
    'il n'y a pas d'operateur, essai de simplification !  
    'si debut=fin, test s'il y a des parenthese et si oui alors suppression  
    'si non test s'il ne reste pas une seule case dans le tableau  
  
    If debut = fin And debut > 0 And fin < y And (chaine.Get(debut-1) = "(" Or chaine.Get(debut-1) = " (") And chaine.Get(debut+1) = ")" Then  
        If chaine.Get(debut-1)=" (" Then  
            'If c(debut - 1) = " (" Then  
            'inversion du signe  
            Dim q As Int=chaine.Get(debut)  
            Dim r As String=-q  
            chaine.Set(debut,r)  
            'c(debut) = Str(0 - Val(c(debut)))  
        End If  
        reorganisation(debut - 1, 1)  
        reorganisation(fin, 1)  
        Return "ok"  
    Else  
        If y = 1 Then  
            Return "ok"  
        Else  
            Return "erreur"  
        End If  
    End If  
  
End Sub  
  
Sub reorganisation(position As Int, q As Int)  
  
    'suppression d'un certain nomnres de case dans le tableau  
  
    Dim x As Int  
  
    For x = position To position+q-1  
        chaine.RemoveAt(position)  
        'c(x) = c(x + q)  
    Next  
  
    'ReDim Preserve c(y - q)  
    y = y - q  
  
End Sub
```