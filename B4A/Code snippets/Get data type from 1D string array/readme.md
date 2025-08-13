### Get data type from 1D string array by RB Smissaert
### 12/20/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/144903/)

This is mainly needed for if the data needs to be sorted eg in a flexible table.  
Lightly tested and seems to work fine, and is quite fast as well.  
Will be interested if there are improvements.  
  

```B4X
Sub GetColumnDataType(arrString() As String) As String  
      
    Dim i As Int  
    Dim r As Int  
    Dim strOld As String  
    Dim arrBytes() As Byte  
    Dim bHasNumber As Boolean  
    Dim iDotPos As Int  
    Dim iCommaPos As Int  
    Dim strDataType As String  
      
    bHasNumber = False  
    iDotPos = -1  
    iCommaPos = -1  
      
    For r = 0 To arrString.Length - 1  
              
        Try  
                  
            If arrString(r) <> Null Then  
                If arrString(r).Length > 0 Then  
                    'this can make this about twice as fast if there is a sorted  
                    'column and if the rows to be tested are not taken randomly  
                    '———————————————————–  
                    If arrString(r) <> strOld Then   
                        strOld = arrString(r)  
                        arrBytes = strOld.GetBytes("ASCII")  
                          
                        For i = 0 To arrBytes.Length - 1  
                            If arrBytes(i) > 57 Then  
                                'Log("> 57: |" & arrString(i) & "|")  
                                Return "T"  
                            Else 'If arrBytes(i) > 57  
                                If arrBytes(i) < 48 Then  
                                    Select Case arrBytes(i)  
                                        Case 45 '-  
                                            'Log(" = minus")  
                                            If i > 0 Then  
                                                Return "T" 'as number can't have minus at position past zero  
                                            Else  
                                                strDataType = "T" 'provisional value  
                                            End If  
                                        Case 46 '.  
                                            If iCommaPos > -1 Then  
                                                'Log("dot and comma")  
                                                Return "T" 'number can't have both dot and comma  
                                            Else  
                                                If i - iDotPos = 1 Then 'number can't have 2 consecutive dots  
                                                    'Log("consecutive dots: |" & str & "|, " & i & " - " & iDotPos)  
                                                    Return "T"  
                                                Else  
                                                    iDotPos = i  
                                                End If  
                                            End If  
                                        Case 44 ',  
                                            If iDotPos > -1 Then  
                                                'Log("comma and dot")  
                                                Return "T" 'number can't have both dot and comma  
                                            Else  
                                                If i - iCommaPos = 1 Then  
                                                    'Log("consecutive commas")  
                                                    Return "T" 'number can't have 2 consecutive commas  
                                                Else  
                                                    iCommaPos = i  
                                                End If  
                                            End If  
                                    End Select  
                                Else 'If arrBytes(i) < 48  
                                    bHasNumber = True  
                                End If 'If arrBytes(i) < 48  
                            End If 'If arrBytes(i) > 57  
                        Next  
                          
                    End If 'If str <> strOld  
                End If 'If str.Length > 0  
            End If 'If str <> Null  
  
        Catch  
                  
            'this won't happen with a string array, but will work if a ResultSet is passed in a similar routine  
            Return "B"  
                  
        End Try  
              
    Next  
          
    If bHasNumber Then  
        If iDotPos = -1 Then  
            If iCommaPos = -1 Then  
                Return "I" 'number and no dot or comma  
            Else  
                Return "R" 'number and has a comma  
            End If  
        Else  
            Return "R" 'number and has a dot  
        End If  
    Else   'If bHasNumber  
        If strDataType = "T" Then  
            Return "T"  
        Else  
            Return "N"  
        End If  
    End If 'If bHasNumber  
          
End Sub  
[\CODE]  
  
RBS
```