Module Module1
    Public Function Leftx(ByVal [string] As String, ByVal length As Integer) As String
        If length <= 0 Then
            length = Len([string])
            Return ""
        End If
        If length > [string].Length Then length = [string].Length
        Return [string].Substring(0, length)
    End Function
    Public Function Rightx(ByVal [string] As String, ByVal length As Integer) As String
        If IsNothing([string]) Then Return ""
        If length > [string].Length Then length = [string].Length
        Return [string].Substring([string].Length - length, length)
    End Function
    Public Function ConvSmsCaster2(testo As String) As String
        testo = testo.Replace("""", "%22")
        testo = testo.Replace(Chr(10), "%0A")
        testo = testo.Replace(Chr(13), "%0D")
        Return testo
    End Function
    Public Function ConvSmsCaster(testo As String)
        testo = Replace(testo, """", "%22")
        testo = Replace(testo, vbLf, "%0A")
        testo = Replace(testo, vbCr, "%0D")
        Return testo
    End Function

    Public Function ConvASCII(testo As String)
        testo = Replace(testo, "è", "e'")
        testo = Replace(testo, "é", "e'")
        testo = Replace(testo, "à", "a'")
        testo = Replace(testo, "ù", "u'")
        testo = Replace(testo, "ò", "o'")
        testo = Replace(testo, "ì", "i'")
        Return testo
    End Function
End Module
