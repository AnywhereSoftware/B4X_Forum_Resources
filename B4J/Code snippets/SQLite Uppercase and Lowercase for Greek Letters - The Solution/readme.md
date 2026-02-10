###  SQLite Uppercase and Lowercase for Greek Letters - The Solution by Magma
### 02/06/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/170225/)

Yeap, that's right - just found solution how you will manage the Greek Letters with SQLITE !  
  
The solution is to **turn** them all in latin! But how will search the database ?  
  
Here we are…  
  
First of all you are goind to initialize the database…  
  
  
 **sql.InitializeSQLite(File.DirApp, "datadb.db", False)  
 sql.ExecNonQuery("PRAGMA case\_sensitive\_like = ON;") ' ASCII case sensitive**  
 **CreateGreekLatinLower(sql)**  
  
  
  

```B4X
Public Sub CreateGreekLatinLower (SQLObj As SQL)  
    Try  
        Dim sqljo As JavaObject = SQLObj  
        Dim conn As JavaObject = sqljo.GetField("connection")  
       
        ' We extract the hidden 'ba' field from 'Me' dynamically  
        Dim joMe As JavaObject = Me  
        Dim actualBA As Object = joMe.GetField("ba")  
        ' —————-  
       
        ' Now pass the actual object, not the string  
        Me.As(JavaObject).RunMethod("registerGreekFunction", Array(conn, actualBA, "greeklower_cb"))  
       
        Log("SQLite Function GREEKLATINLOWER registered successfully.")  
    Catch  
        Log("Error registering function: " & LastException.Message)  
    End Try  
End Sub  
  
' Callback method - Called by the Java bridge  
' IMPORTANT: This must be Public so the Java bridge can see it  
Public Sub greeklower_cb (Input As String) As String  
    If Input = "" Then Return ""  
   
    ' Assuming 'b' is your object that handles Greek transformation  
    ' Replace with your actual logic  
    Return GreekToLatin(Input).ToLowerCase  
End Sub  
  
  
Public Sub GreekToLatin(greekText As String) As String  
    Dim result As String = greekText  
  
  
    result = result.Replace("Εί", "I")  
    result = result.Replace("Οί", "I")  
    result = result.Replace("Αί", "E")  
  
    result = result.Replace("Ει", "I")  
    result = result.Replace("Οι", "I")  
    result = result.Replace("Αι", "E")  
   
    result = result.Replace("ΕΙ", "I")  
    result = result.Replace("ΟΙ", "I")  
    result = result.Replace("ΑΙ", "E")  
  
    result = result.Replace("ει", "i")  
    result = result.Replace("οι", "i")  
    result = result.Replace("αι", "e")  
   
   
    ' ===== UPPERCASE WITH ACCENTS =====  
    result = result.Replace("Ά", "A")  
    result = result.Replace("Έ", "E")  
    result = result.Replace("Ή", "I")  
    result = result.Replace("Ί", "I")  
    result = result.Replace("Ϊ", "I")  
    result = result.Replace("Ϋ", "Y")  
    result = result.Replace("Ό", "O")  
    result = result.Replace("Ύ", "Y")  
    result = result.Replace("Ώ", "O")  
   
    ' ===== LOWERCASE WITH ACCENTS =====  
    result = result.Replace("ά", "a")  
    result = result.Replace("έ", "e")  
    result = result.Replace("ή", "i")  
    result = result.Replace("ί", "i")  
    result = result.Replace("ϊ", "i")  
    result = result.Replace("ϋ", "y")  
    result = result.Replace("ό", "o")  
    result = result.Replace("ύ", "y")  
    result = result.Replace("ώ", "o")  
   
    ' ===== UPPERCASE WITHOUT ACCENTS =====  
    result = result.Replace("Α", "A")  
    result = result.Replace("Β", "B")  
    result = result.Replace("Γ", "G")  
    result = result.Replace("Δ", "D")  
    result = result.Replace("Ε", "E")  
    result = result.Replace("Ζ", "Z")  
    result = result.Replace("Η", "I")  
    result = result.Replace("Θ", "TH")  
    result = result.Replace("Ι", "I")  
    result = result.Replace("Κ", "K")  
    result = result.Replace("Λ", "L")  
    result = result.Replace("Μ", "M")  
    result = result.Replace("Ν", "N")  
    result = result.Replace("Ξ", "KS")  
    result = result.Replace("Ο", "O")  
    result = result.Replace("Π", "P")  
    result = result.Replace("Ρ", "R")  
    result = result.Replace("Σ", "S")  
    result = result.Replace("Τ", "T")  
    result = result.Replace("Υ", "Y")  
    result = result.Replace("Φ", "F")  
    result = result.Replace("Χ", "CH")  
    result = result.Replace("Ψ", "PS")  
    result = result.Replace("Ω", "O")  
   
    ' ===== LOWERCASE WITHOUT ACCENTS =====  
    result = result.Replace("α", "a")  
    result = result.Replace("β", "b")  
    result = result.Replace("γ", "g")  
    result = result.Replace("δ", "d")  
    result = result.Replace("ε", "e")  
    result = result.Replace("ζ", "z")  
    result = result.Replace("η", "i")  
    result = result.Replace("θ", "th")  
    result = result.Replace("ι", "i")  
    result = result.Replace("κ", "k")  
    result = result.Replace("λ", "l")  
    result = result.Replace("μ", "m")  
    result = result.Replace("ν", "n")  
    result = result.Replace("ξ", "ks")  
    result = result.Replace("ο", "o")  
    result = result.Replace("π", "p")  
    result = result.Replace("ρ", "r")  
    result = result.Replace("σ", "s")  
    result = result.Replace("ς", "s")  ' Final sigma  
    result = result.Replace("τ", "t")  
    result = result.Replace("υ", "y")  
    result = result.Replace("φ", "f")  
    result = result.Replace("χ", "ch")  
    result = result.Replace("ψ", "ps")  
    result = result.Replace("ω", "o")  
   
    Return result  
end sub  
  
#If JAVA  
import java.sql.*;  
import org.sqlite.Function;  
  
public static void registerGreekFunction(Connection conn, final anywheresoftware.b4a.BA ba, final String subName) throws SQLException {  
    Function.create(conn, "GREEKLATINLOWER", new Function() {  
        @Override  
        protected void xFunc() throws SQLException {  
            try {  
                // value_text(0) gets the first argument passed to the function  
                String input = value_text(0);  
               
                // Call the B4J Sub  
                Object result = ba.raiseEvent(this, subName, new Object[] { input });  
               
                // FIX: The method name is result(), not result_text()  
                result(result == null ? "" : result.toString());  
            } catch (Exception e) {  
                // Fallback result on error  
                result("");  
                e.printStackTrace();  
            }  
        }  
    });  
}  
#End If
```

  
  
what actually do GREEKLATINLOWER: let's say we have the Greek word: "Θεραπεία" - will turn at: "therapeia"  
So… what's next - **how will use it ? - now the fun part:**  
  

```B4X
dim sqlquery as string="SELECT * FROM MyTable WHERE GREEKLATINLOWER(myfield) LIKE ? ORDER BY myfield2;"  
dim mysearch as string="%θεραπει%"  
Dim cursor As ResultSet = Main.sql.ExecQuery2(sqlquery, mysearch)  
Do While cursor.NextRow  
….
```

  
\* You can even mix greek-latin - perhaps αΣuS - > asus  
  
If you are happy with my solution do not forget me!