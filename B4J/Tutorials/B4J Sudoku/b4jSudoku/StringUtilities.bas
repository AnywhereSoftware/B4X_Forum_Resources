B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.3
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private nativeMe As JavaObject
End Sub
'Initializes the object.
Public Sub Initialize
	nativeMe = Me
End Sub

'Reverses the order of a String
'Example:
'Dim msu As StringUtilities
'
'Dim mystring As String
'Log(msu.reverseString("Basic4Android is Great!"))
Public Sub reverseString (origString As String) As String
	origString = nativeMe.RunMethod("reverseString", Array (origString))
	Return origString
End Sub

'Converts a String To UPPERCASE
'Example:
'Dim msu As StringUtilities
'
'Dim mystring As String
'mystring = "Basic4Android is Great!"
'Log(msu.StringToUpperCase(mystring))
Public Sub StringToUpperCase (origString As String) As String
	origString = nativeMe.RunMethod("StringToUpperCase", Array (origString))
	Return origString
End Sub

'Converts a String To LOWERCASE
'Example:
'Dim msu As StringUtilities
'
'Dim mystring As String
'mystring = "Basic4Android is Great!"
'Log(msu.StringToLowerCase(mystring))
Public Sub StringToLowerCase (origString As String) As String
	origString = nativeMe.RunMethod("StringToLowerCase", Array (origString))
	Return origString
End Sub

'Get the length of a String
'Example:
'Dim msu As StringUtilities
'
'Dim mystring As String
'mystring = "Basic4Android is Great!"
'Log(msu.stringLength(mystring))
Public Sub stringLength (origString As String) As Int
    Dim strlen As Int
	strlen = nativeMe.RunMethod("stringLength", Array (origString))
	Return strlen
End Sub

'Replace all occurances of a char in a string with a new char
'Example:
'Dim msu As StringUtilities
'
'Dim mystring As String
'mystring = "Basic4Android is Great!"
'Log(msu.replaceChar(mystring, "G", "g"))
Public Sub replaceChar (inputString As String, oldChar As Char, newChar As Char) As String
	inputString = nativeMe.RunMethod("replaceChar", Array (inputString, oldChar, newChar))
	Return inputString
End Sub

'Replaces only the first occurances of a given String with a new one
'Example:
'Dim msu As StringUtilities
'
'Dim mystring As String
'mystring = "Replace Region"
'Log(msu.replaceFirstOccur(mystring, "Re", "Ra"))
Public Sub replaceFirstOccur (inputString As String, oldString As String, newString As String) As String
	inputString = nativeMe.RunMethod("replaceFirstOccur", Array (inputString, oldString, newString))
	Return inputString
End Sub

'Replaces all occurances of a given String with a new one
'Example:
'Dim msu As StringUtilities
'
'Dim mystring As String
'mystring = "Replace Region"
'Log(msu.replaceAllOccur(mystring, "Re", "Ra"))
Public Sub replaceAllOccur (inputString As String, oldString As String, newString As String) As String
	inputString = nativeMe.RunMethod("replaceAllOccur", Array (inputString, oldString, newString))
	Return inputString
End Sub

'This method returns True/False If the input String contains a given substring.
'Example:
'Dim msu As StringUtilities
'
'Dim mystring As String
'mystring = "Replace Region"
'Log(msu.containString(mystring, "place"))
Public Sub containString (inputString As String, subString As String) As Boolean
    Dim contain As Boolean
	contain = nativeMe.RunMethod("containString", Array (inputString, subString))
	Return contain
End Sub

'Removes the leading AND trailing spaces from a String
'Example:
'Dim msu As StringUtilities
'
'Dim mystring As String
'mystring = "    Replace Region    "
'Log(msu.Trim(mystring, "place"))
Public Sub Trim (inputString As String) As String
	inputString = nativeMe.RunMethod("Trim", Array (inputString))
	Return inputString
End Sub

'This method returns true/false when the input string starts with the substring
'Example:
'Dim msu As StringUtilities
'
'Dim mystring As String
'mystring = "Replace Region"
'Log(msu.stringStartsWith(mystring, "Repla"))
Public Sub stringStartsWith (inputString As String, subString As String) As Boolean
    Dim startWith As Boolean
	startWith = nativeMe.RunMethod("stringStartsWith", Array (inputString, subString))
	Return startWith
End Sub

'Sorts an Array of strings in decending order (case sensitive)
'Example:
'Dim msu As StringUtilities
'
'Dim mywords() As String
'mywords = Array As String("Basic", "4", "Android", "is", "great")
'mywords = msu.sortStringCaseSensitive(mywords)
'For i = 0 To mywords.Length-1
'  Log(mywords(i))
'Next
Public Sub sortStringCaseSensitive (strNames() As String) As String()
	strNames = nativeMe.RunMethod("sortStringCaseSensitive", Array (strNames))
	Return strNames
End Sub

'Sorts an Array of strings in decending order (case insensitive)
'Example:
'Dim msu As StringUtilities
'
'Dim mywords() As String
'mywords = Array As String("Today", "Is", "the", "First", "day", "of", "the", "Rest", "of", "my", "life")
'mywords = msu.sortStringCaseInSensitive(mywords)
'For i = 0 To mywords.Length-1
'  Log(mywords(i))
'Next
Public Sub sortStringCaseInSensitive (strNames() As String) As String()
	strNames = nativeMe.RunMethod("sortStringCaseInSensitive", Array (strNames))
	Return strNames
End Sub

'Sorts an Array of strings In decending order (case sensitive)
'Example:
'Dim msu As StringUtilities
'
'Dim mywords() As String
'mywords = Array As String("a", "B", "c", "D", "z")
'mywords = msu.sortStringArrayDecendingCaseSensitive(mywords)
'For i = 0 To mywords.Length-1
'  Log(mywords(i))
'Next
Public Sub sortStringArrayDecendingCaseSensitive (strNames() As String) As String()
	strNames = nativeMe.RunMethod("sortStringArrayDecendingCaseSensitive", Array (strNames))
	Return strNames
End Sub

'Sorts an Array of strings In decending order (case insensitive)
'Example:
'Dim msu As StringUtilities
'
'Dim mywords() As String
'mywords = Array As String("a", "B", "c", "D", "z")
'mywords = msu.sortStringArrayDecendingCaseInSensitive(mywords)
'For i = 0 To mywords.Length-1
'  Log(mywords(i))
'Next
Public Sub sortStringArrayDecendingCaseInSensitive (strNames() As String) As String()
	strNames = nativeMe.RunMethod("sortStringArrayDecendingCaseInSensitive", Array (strNames))
	Return strNames
End Sub

'Returns a substring of the String starting from index
'Example:
'Dim msu As StringUtilities
'
'Dim inputString As String
'Dim startIndex as int = 8
'inputString = "This is a test string"
'inputString = msu.subString1(inputString, startIndex)
'Log(inputString)
'
'startIndex = 0 will be the first character of inputString
Public Sub subString1 (inputString As String, startIndex As Int) As String
	inputString = nativeMe.RunMethod("subString1", Array (inputString, startIndex))
	Return inputString
End Sub

'Returns a substring of inputString starting from fromIndex upto toIndex-1
'Here fromIndex is inclusive while toIndex is exclusive.
'Example:
'Dim inputString As String
'Dim fromIndex As Int = 5
'Dim toIndex As Int = 9
'inputString = "This is a test string"
'Log(msu.subString2(inputString, fromIndex, toIndex))
'
'The index of the first character of inputString = 0
'
Public Sub subString2 (inputString As String, fromIndex As Int, toIndex As Int) As String
	inputString = nativeMe.RunMethod("subString2", Array (inputString, fromIndex, toIndex))
	Return inputString
End Sub

'Returns the rightmost number of characters of inputString equivalent to returnLength 
'Example:
'Dim inputString As String
'Dim returnLength As Int = 11
'inputString = "This is a test string"
'Log(msu.Right(inputString, returnLength))
'
Public Sub Right (inputString As String, returnLength As Int) As String
	inputString = nativeMe.RunMethod("Right", Array (inputString, returnLength))
	Return inputString
End Sub

'Returns the leftmost number of characters of inputString equivalent to returnLength 
'Example:
'Dim inputString As String
'Dim returnLength As Int = 9
'inputString = "This is a test string"
'Log(msu.Left(inputString, returnLength))
'
Public Sub Left (inputString As String, returnLength As Int) As String
	inputString = nativeMe.RunMethod("Left", Array (inputString, returnLength))
	Return inputString
End Sub

'Returns a substring of inputString starting from StartIndex with a length of returnLength
'Example:
'Dim inputString As String
'inputString = "This is a test string"
'Dim startIndex as int = 5
'Dim returnLength As Int = 9
'Log(msu.Mid(inputString, startIndex, returnLength))
'
'The index of the first character of inputString = 0
'
Public Sub Mid (inputString As String, startIndex As Int, returnLength As Int) As String
	inputString = nativeMe.RunMethod("Mid", Array (inputString, startIndex, returnLength))
	Return inputString
End Sub

'Get the substring of InputString that is nested inbetween two instances of the same tag string.
'Example:
'Dim inputString, tagString As String
'inputString = "tagabcdefghijktag"
'tagString = "tag"
'Log(msu.substringBetween1(inputString, tagString))
'
Public Sub substringBetween1 (inputString As String, tagString As String) As String
	inputString = nativeMe.RunMethod("substringBetween1", Array (inputString, tagString))
	Return inputString
End Sub

'Get the substring of InputString that is nested inbetween openString and closeString
'Example:
'Dim inputString, openString, closeString As String
'inputString = "taga{bcdef]ghijktag"
'openString = "{"
'closeString = "]"
'Log(msu.substringBetween2(inputString, openString, closeString))
'
Public Sub substringBetween2 (inputString As String, openString As String, closeString As String) As String
	inputString = nativeMe.RunMethod("substringBetween2", Array (inputString, openString, closeString))
	Return inputString
End Sub

'Test if inputString is empty or null
'Example:
'Dim inputString As String
'inputString = ""
'Dim answer as Boolean
'answer = msu.isEmpty(inputString)
'Log(answer)
'
Public Sub isEmpty (inputString As String) As Boolean
    Dim answer As Boolean
	answer = nativeMe.RunMethod("isEmpty", Array (inputString))
	Return answer
End Sub

'Count the number of instances of a substring within inputString.
'Example:
'Dim inputString, subString As String
'inputString = "one plus two is the same as two plus one"
'subString = "two"
'Dim answer as int
'answer = msu.count(inputString, subString)
'Log(answer)
'
'It is case sensitive
'
Public Sub count (inputString As String, subString As String) As Int
    Dim answer As Int
	answer = nativeMe.RunMethod("count", Array (inputString, subString))
	Return answer
End Sub

'Compare two Strings and return the portion where they differ.
'(More precisely, return the remainder of the second String,
' starting from where it's different from the first.)
'Example:
'Dim str1, str2, dif As String
'str1 = "i am a machine"
'str2 = "i am a robot"
'dif = msu.difference(str1, str2)
'Log(dif)
'
'
Public Sub difference (str1 As String, str2 As String) As String
    Dim dif As String
	dif = nativeMe.RunMethod("difference", Array (str1, str2))
	Return dif
End Sub

'Compare two Strings and returns the index at which the Strings begin to differ.
'The index of the first characters of str1 and str2 = 0
'Example:
'Dim str1, str2 As String
'Dim index as Int
'str1 = "i am a machine"
'str2 = "i am a robot"
'index = msu.indexOfDifference(str1, str2)
'Log(index)
'
Public Sub indexOfDifference (str1 As String, str2 As String) As Int
    Dim index As String
	index = nativeMe.RunMethod("indexOfDifference", Array (str1, str2))
	Return index
End Sub

'Gets the substring after the first occurrence of a separator.
'The separator is not returned.
'Example:
'Dim str1, str2, substr As String
'str1 = "i am a machine"
'str2 = "am "
'substr = msu.substringAfter(str1, str2)
'Log(substr)
'
Public Sub substringAfter (str1 As String, str2 As String) As String
    Dim substr As String
	substr = nativeMe.RunMethod("substringAfter", Array (str1, str2))
	Return substr
End Sub
'Converts a String to an array of characters
'Example:
'Dim inputString As String
'Dim charArray() as Char
'inputString = "i am a machine"
'charArray = msu.stringToCharArray(inputString)
'
Public Sub stringToCharArray (inputString As String) As Char()
    Dim charArray() As Char
	charArray = nativeMe.RunMethod("stringToCharArray", Array (inputString))
	Return charArray
End Sub

'Converts an array of characters to a String
'Example:
'Dim returnString As String
'Dim charArray(5) As Char
'charArray(0) = "H"
'charArray(1) = "e"
'charArray(2) = "l"
'charArray(3) = "l"
'charArray(4) = "o"
'returnString = msu.charArrayToString(charArray)
'Log(returnString)
'
Public Sub charArrayToString (charArray() As Char) As String
    Dim charToString As String
	charToString = nativeMe.RunMethod("charArrayToString", Array (charArray))
	Return charToString
End Sub

'Converts a Double to String
'Example:
'Dim number As Double = 3.14159
'Dim returnString As String
'returnString = msu.doubleToString(number)
'Log(returnString)
'
Public Sub doubleToString (number As Double) As String
    Dim numberToString As String
	numberToString = nativeMe.RunMethod("doubleToString", Array (number))
	Return numberToString
End Sub

'Converts an Integer to String
'Example:
'Dim intNumber As int = 101
'Dim returnString As String
'returnString = msu.intToString(intNumber)
'Log(returnString)
'
Public Sub intToString (number As Int) As String
    Dim numberToString As String
	numberToString = nativeMe.RunMethod("intToString", Array (number))
	Return numberToString
End Sub

'Converts an Integer to a binary String
'Example:
'Dim intNumber As Int = 100
'Dim returnString As String
'returnString = msu.intToBinaryString(intNumber)
'Log(returnString)	
'
Public Sub intToBinaryString (number As Int) As String
    Dim numberToString As String
	numberToString = nativeMe.RunMethod("intToBinaryString", Array (number))
	Return numberToString
End Sub

'Converts a String to an Integer
'Example:
'Dim inputString As String = "1001"
'Dim i As Int
'i = msu.stringToInt(inputString)
'Log(i)	
'
Public Sub stringToInt (inputString As String) As Int
	'Log("INPUTSTRING = " & inputString)
    Dim stringToInteger As Int
	stringToInteger = nativeMe.RunMethod("stringToInt", Array (inputString))
	Return stringToInteger
End Sub

'Converts an Integer to an Octal String
'Example:
'Dim intNumber As Int = 100
'Dim returnString As String
'returnString = msu.intToOctalString(intNumber)
'Log(returnString)	
'
Public Sub intToOctalString (number As Int) As String
    Dim numberToString As String
	numberToString = nativeMe.RunMethod("intToOctalString", Array (number))
	Return numberToString
End Sub

'Converts an Integer to a Hex String
'Example:
'Dim intNumber As Int = 30
'Dim returnString As String
'returnString = msu.intToHexString(intNumber)
'Log(returnString)	
'
Public Sub intToHexString (number As Int) As String
    Dim numberToString As String
	numberToString = nativeMe.RunMethod("intToHexString", Array (number))
	Return numberToString
End Sub

'Remove all occurences of a character from a String
'It is Case Sensitive
'Example:
'Dim inputString As String = "This is a severe test of removing the character s from this String"
'Dim returnString As String
'returnString = msu.removeCharFromString(intNumber)
'Log(returnString)	
'
Public Sub removeCharFromString (inputString As String, removeChar As Char) As String
    Dim returnString As String
	returnString = nativeMe.RunMethod("removeCharFromString", Array (inputString, removeChar))
	Return returnString
End Sub

'Remove all occurences of a character from a String
'The index of the first characters of inputString = 0
'It is Case Sensitive
'Example:
'Dim inputString As String = "This is a test"
'Dim position as Int = 3
'Dim returnString As String
'returnString = msu.removeCharAtPosition(inputString, position)
'Log(returnString)	
'
Public Sub removeCharAtPosition (inputString As String, position As Int) As String
    Dim returnString As String
	returnString = nativeMe.RunMethod("removeCharAtPosition", Array (inputString, position))
	Return returnString
End Sub


'Converts a String to a Hash Code
'Example:
'Dim inputString As String = "Hello"
'Dim hashValue As int
'hashValue = msu.stringToHashCode(inputString)
'Log(hashValue)	
'
Public Sub stringToHashCode (inputString As String) As Int
    Dim hashValue As Int
	hashValue = nativeMe.RunMethod("stringToHashCode", Array (inputString))
	Return hashValue
End Sub




#If Java

import java.text.ParseException;

import java.lang.String;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;


public String reverseString (String stringToReverse) {
  String strOriginal;
  strOriginal = stringToReverse;
  strOriginal = new StringBuffer(strOriginal).reverse().toString();
  return strOriginal;
}


public String StringToUpperCase(String inputString) {
  String outputString = inputString.toUpperCase();
  return outputString;
}


public String StringToLowerCase(String inputString) {
  String outputString = inputString.toLowerCase();
  return outputString;
}


public int stringLength(String inputString) {
  int stringlength = inputString.length();
  return stringlength;
}


/**
* Replace all occurances of a char in a string with a new char
*Example:<code>
*Dim msu As B4AstringUtils
*
*Dim mystring As String
*mystring = "Basic4Android is Great!"
*log(msu.replaceChar(mystring,"A","B")
*</code>
*/
public String replaceChar(String inputString, char oldChar, char newChar) {
  String outputString = inputString.replace(oldChar, newChar);
  return outputString; 

}


/**
*Replaces only the first occurances of a given String with a new one
*Example:<code>
*Dim msu As B4AstringUtils
*
*Dim mystring As String
*mystring = "Replace Region"
*log(msu.replaceFirstOccur(mystring,"Re","Ra")
*</code>
*/
public String replaceFirstOccur(String inputString, String oldString, String newString) {
  String outputString = inputString.replaceFirst(oldString, newString);
  return outputString; 

}


/**
*Replace all occurances of a given String with a new one
*Example:<code>
*Dim msu As B4AstringUtils
*
*Dim mystring As String
*mystring = "Replace Region"
*log(msu.replaceAllOccur(mystring,"Re","Ra")
*</code>
*/
public String replaceAllOccur(String inputString, String oldString, String newString) {
  String outputString = inputString.replaceAll(oldString, newString);
  return outputString; 

}


/**
*This method returns true/false if the input string contains a given substring.
*Example:<code>
*Dim msu As B4AstringUtils
*
*Dim mystring as String
*mystring = "Replace Region"
*log(msu.containString(mystring,"Re")
*</code>
*/
public boolean containString(String inputString, String substring) {
  boolean containstring = inputString.contains(substring);
  return containstring; 

}


/**
*Removes the leading and trailing spaces from a string
*Example:<code>
*Dim msu As B4AstringUtils
*
*Dim mystring as String
*mystring = "    Replace Region    "
*log(msu.Trim(mystring)
*</code>
*/
public String Trim(String inputString) {
  String strTrimmed = inputString.trim();
  return strTrimmed;

}


/**
*This method returns true/false when the input string starts with the substring
*Example:<code>
*Dim msu As B4AstringUtils
*
*Dim mystring as String
*mystring = "Replace Region"
*log(msu.StringStartsWith(mystring,"Replace")
*</code>
*/
public boolean stringStartsWith(String inputString, String substring) {
  boolean startWithString = inputString.startsWith(substring);
  return startWithString; 

}


/**
*Sorts an array of strings in decending order
*It is case SENSITIVE. Therefore A-Z takes preference over a-z
*Example:<code>
*Dim msu As B4AstringUtils
*
*Dim mywords() As String
*mywords = Array As String("My", "name", "is", "Johan", "Schoeman")
*mywords = msu.sortStringCaseSensitive(mywords)
*For i = 0 To mywords.Length-1
*  Log(mywords(i))
*Next
*</code>
*/
public String[] sortStringCaseSensitive(String[] strNames) {
  Arrays.sort(strNames);
  return strNames;

}


/**
*Sorts an array of strings in decending order
*It is case INSENSITIVE. Therefore b will for eg take preference over Z
*Example:<code>
*Dim msu As B4AstringUtils
*
*Dim mywords() As String
*mywords = Array As String("My", "name", "is", "Johan", "Schoeman")
*mywords = msu.sortStringCaseInSensitive(mywords)
*For i = 0 To mywords.Length-1
*  Log(mywords(i))
*Next
*</code>
*/
public String[] sortStringCaseInSensitive(String[] strNames) {
  Arrays.sort(strNames, String.CASE_INSENSITIVE_ORDER);
  return strNames;

}

//Sort String Array in Descending Order
//java.util.Arrays.sort(easyWords,Collections.reverseOrder());


//Sort in Ascending order
//java.util.Arrays.sort(arrayName);

/**
*Sorts an array of strings in decending order
*It is case SENSITIVE
*Example:<code>
*Dim msu As B4AstringUtils
*
*Dim mywords() As String
*mywords = Array As String("a", "B", "c", "D", "z")
*mywords = msu.sortStringArrayDecendingCaseSensitive(mywords)
*For i = 0 To mywords.Length-1
*  Log(mywords(i))
*Next
*</code>
*
*Return array will be (starting from index 0) z, c, a, D, B
*/
public String[] sortStringArrayDecendingCaseSensitive(String[] strNames) {
  Arrays.sort(strNames, Collections.reverseOrder());
  return strNames;

}



/**
*Sorts an array of strings in ascending order
*It is case SENSITIVE
*Example:<code>
*Dim msu As B4AstringUtils
*
*Dim mywords() As String
*mywords = Array As String("a", "B", "c", "D", "z")
*mywords = msu.sortStringArrayDecendingCaseInSensitive(mywords)
*For i = 0 To mywords.Length-1
*  Log(mywords(i))
*Next
*</code>
*
*Return array will be (starting from index 0) z, D, c, B, a
*/
public String[] sortStringArrayDecendingCaseInSensitive(String[] strNames) {
  Arrays.sort(strNames, String.CASE_INSENSITIVE_ORDER);
  String[] newStrNames = new String[strNames.length];
 
  for (int arrayIterator = 0; arrayIterator < strNames.length; arrayIterator++) { 
    newStrNames[arrayIterator] = strNames[strNames.length - 1 - arrayIterator];
  } 

  return newStrNames;

}


/**
*Returns a substring of the string starting from index
*
*Example:<code>
*Dim msu As B4AstringUtils
*
*Dim mystring As String
*Dim myindex as Int = 6
*mystring = "Hello World"
*Log(msu.subString1(mystring,myindex))
*</code>
*Returned substring = World
*/
public String subString1(String myString, int myIndex) {
  myString = myString.substring(myIndex);
  return myString;

}


/**
*Returns a substring of the string starting from fromIndex upto toIndex-1
*Here fromIndex is inclusive while toIndex is exclusive.
*Example:<code>
*Dim msu As B4AstringUtils
*
*Dim mystring As String
*Dim fromIndex as Int = 0
*Dim toIndex as Int = 5
*mystring = "Hello World"
*Log(msu.subString2(mystring, fromIndex, toIndex))
*</code>
*Returned substring = Hello
*/
public String subString2(String myString, int fromIndex, int toIndex) {
  myString = myString.substring(fromIndex,toIndex);
  return myString;

}

  public String Right(String str, int len) {
      if (str == null) {
          return null;
      }
      if (len < 0) {
          return "";
      }
      if (str.length() <= len) {
          return str;
      }
      return str.substring(str.length() - len);
  }
  
  public String Left(String str, int len) {
      if (str == null) {
          return null;
      }
      if (len < 0) {
          return "";
      }
      if (str.length() <= len) {
          return str;
      }
      return str.substring(0, len);
  }  
  
  public String Mid(String str, int pos, int len) {
      if (str == null) {
          return null;
      }
      if (len < 0 || pos > str.length()) {
          return "";
      }
      if (pos < 0) {
          pos = 0;
      }
      if (str.length() <= (pos + len)) {
          return str.substring(pos);
      }
      return str.substring(pos, pos + len);
  }  
  
  
  
  
  // Substring between
  //-----------------------------------------------------------------------
  /**
   * Gets the String that is nested in between two instances of the
   * same String.
   *
   * A <code>null</code> input String returns <code>null</code>.
   * A <code>null</code> tag returns <code>null</code>.
   *
   * <pre>
   * StringUtils.substringBetween(null, *)            = null
   * StringUtils.substringBetween("", "")             = ""
   * StringUtils.substringBetween("", "tag")          = null
   * StringUtils.substringBetween("tagabctag", null)  = null
   * StringUtils.substringBetween("tagabctag", "")    = ""
   * StringUtils.substringBetween("tagabctag", "tag") = "abc"
   * </pre>
   *
   * @param str  the String containing the substring, may be null
   * @param tag  the String before and after the substring, may be null
   * @return the substring, <code>null</code> if no match
   * @since 2.0
   */
  public String substringBetween1(String str, String tag) {
      return substringBetween2(str, tag, tag);
  }

  /**
   * Gets the String that is nested in between two Strings.
   * Only the first match is returned.
   *
   * A <code>null</code> input String returns <code>null</code>.
   * A <code>null</code> open/close returns <code>null</code> (no match).
   * An empty ("") open and close returns an empty string.
   *
   * <pre>
   * StringUtils.substringBetween("wx[b]yz", "[", "]") = "b"
   * StringUtils.substringBetween(null, *, *)          = null
   * StringUtils.substringBetween(*, null, *)          = null
   * StringUtils.substringBetween(*, *, null)          = null
   * StringUtils.substringBetween("", "", "")          = ""
   * StringUtils.substringBetween("", "", "]")         = null
   * StringUtils.substringBetween("", "[", "]")        = null
   * StringUtils.substringBetween("yabcz", "", "")     = ""
   * StringUtils.substringBetween("yabcz", "y", "z")   = "abc"
   * StringUtils.substringBetween("yabczyabcz", "y", "z")   = "abc"
   * </pre>
   *
   * @param str  the String containing the substring, may be null
   * @param open  the String before the substring, may be null
   * @param close  the String after the substring, may be null
   * @return the substring, <code>null</code> if no match
   * @since 2.0
   */
  public String substringBetween2(String str, String open, String close) {
      if (str == null || open == null || close == null) {
          return null;
      }
      int start = str.indexOf(open);
      if (start != -1) {
          int end = str.indexOf(close, start + open.length());
          if (end != -1) {
              return str.substring(start + open.length(), end);
          }
      }
      return null;
  }

  // Empty checks
  //-----------------------------------------------------------------------
  /**
   * Checks if a String is empty ("") or null.
   *
   * <pre>
   * StringUtils.isEmpty(null)      = true
   * StringUtils.isEmpty("")        = true
   * StringUtils.isEmpty(" ")       = false
   * StringUtils.isEmpty("bob")     = false
   * StringUtils.isEmpty("  bob  ") = false
   * </pre>
   *
   * NOTE: This method changed in Lang version 2.0.
   * It no longer trims the String.
   * That functionality is available in isBlank().
   *
   * @param str  the String to check, may be null
   * @return <code>true</code> if the String is empty or null
   */
  public boolean isEmpty(String str) {
	  if (str.equals("null")) { 
	    return true;
	  } else {
	      return str.length() == 0;
      }		
  }
  
  /**
   * Count the number of instances of substring within a string.
   *
   * @param string     String to look for substring in.
   * @param substring  Sub-string to look for.
   * @return           Count of substrings in string.
   */
  public int count(final String string, final String substring)
  {
     int count = 0;
     int idx = 0;

     while ((idx = string.indexOf(substring, idx)) != -1)
     {
        idx++;
        count++;
     }

     return count;
  }

  /**
   * Count the number of instances of character within a string.
   *
   * @param string     String to look for substring in.
   * @param c          Character to look for.
   * @return           Count of substrings in string.
   */
  public int count(final String string, final char c)
  {
     return count(string, String.valueOf(c));
  }
 
 
 
   // Difference
  //-----------------------------------------------------------------------
  /**
   * Compares two Strings, and returns the portion where they differ.
   * (More precisely, return the remainder of the second String,
   * starting from where it's different from the first.)
   *
   * For example,
   * <code>difference("i am a machine", "i am a robot") -> "robot"</code>.
   *
   * <pre>
   * StringUtils.difference(null, null) = null
   * StringUtils.difference("", "") = ""
   * StringUtils.difference("", "abc") = "abc"
   * StringUtils.difference("abc", "") = ""
   * StringUtils.difference("abc", "abc") = ""
   * StringUtils.difference("ab", "abxyz") = "xyz"
   * StringUtils.difference("abcde", "abxyz") = "xyz"
   * StringUtils.difference("abcde", "xyz") = "xyz"
   * </pre>
   *
   * @param str1  the first String, may be null
   * @param str2  the second String, may be null
   * @return the portion of str2 where it differs from str1; returns the
   * empty String if they are equal
   * @since 2.0
   */
  public String difference(String str1, String str2) {
      if (str1 == null) {
          return str2;
      }
      if (str2 == null) {
          return str1;
      }
      int at = indexOfDifference(str1, str2);
      if (at == -1) {
          return "";
      }
      return str2.substring(at);
  }
 

   /**
   * Compares two Strings, and returns the index at which the
   * Strings begin to differ.
   *
   * For example,
   * <code>indexOfDifference("i am a machine", "i am a robot") -> 7</code>
   *
   * <pre>
   * StringUtils.indexOfDifference(null, null) = -1
   * StringUtils.indexOfDifference("", "") = -1
   * StringUtils.indexOfDifference("", "abc") = 0
   * StringUtils.indexOfDifference("abc", "") = 0
   * StringUtils.indexOfDifference("abc", "abc") = -1
   * StringUtils.indexOfDifference("ab", "abxyz") = 2
   * StringUtils.indexOfDifference("abcde", "abxyz") = 2
   * StringUtils.indexOfDifference("abcde", "xyz") = 0
   * </pre>
   *
   * @param str1  the first String, may be null
   * @param str2  the second String, may be null
   * @return the index where str2 and str1 begin to differ; -1 if they are equal
   * @since 2.0
   */
  public int indexOfDifference(String str1, String str2) {
      if (str1 == str2) {
          return -1;
      }
      if (str1 == null || str2 == null) {
          return 0;
      }
      int i;
      for (i = 0; i < str1.length() && i < str2.length(); ++i) {
          if (str1.charAt(i) != str2.charAt(i)) {
              break;
          }
      }
      if (i < str2.length() || i < str1.length()) {
          return i;
      }
      return -1;
  }
 
 

 /**
   * Gets the substring after the first occurrence of a separator.
   * The separator is not returned.
   *
   * A <code>null</code> string input will return <code>null</code>.
   * An empty ("") string input will return the empty string.
   * A <code>null</code> separator will return the empty string if the
   * input string is not <code>null</code>.
   *
   * <pre>
   * StringUtils.substringAfter(null, *)      = null
   * StringUtils.substringAfter("", *)        = ""
   * StringUtils.substringAfter(*, null)      = ""
   * StringUtils.substringAfter("abc", "a")   = "bc"
   * StringUtils.substringAfter("abcba", "b") = "cba"
   * StringUtils.substringAfter("abc", "c")   = ""
   * StringUtils.substringAfter("abc", "d")   = ""
   * StringUtils.substringAfter("abc", "")    = "abc"
   * </pre>
   *
   * @param str  the String to get a substring from, may be null
   * @param separator  the String to search for, may be null
   * @return the substring after the first occurrence of the separator,
   *  <code>null</code> if null String input
   * @since 2.0
   */
  public String substringAfter(String str, String separator) {
      if (isEmpty(str)) {
          return str;
      }
      if (separator == null) {
          return "";
      }
      int pos = str.indexOf(separator);
      if (pos == -1) {
          return "";
      }
      return str.substring(pos + separator.length());
  }
  

  /**
   * Converts a String to an array of characters
   */ 
  public char[] stringToCharArray(String inputString) {
    int len = inputString.length();
    char[] tempCharArray = new char[len];
    char[] charArray = new char[len];

    // put original string in an array of chars
    for (int i = 0; i < len; i++) {
      tempCharArray[i] = inputString.charAt(i);
    }
      return tempCharArray;
  }
  
   /**
   * Converts an array of characters to a String
   */ 
  public String charArrayToString(char[] charArray) {

    String charToString = new String(charArray);
      return charToString;
  } 
  
  public String doubleToString(double number) {
    String returnString = "";
    return String.valueOf(number);   
  }
  
   public String intToString(int number) {
    String returnString = "";
    return String.valueOf(number);   
  } 
  
   public String intToBinaryString(int number) {
    String returnString = "";
    return Integer.toBinaryString(number);
  } 
  
    public int stringToInt (String inputString) {
      int i = Integer.parseInt(inputString);
      return i;
  }
  
   public String intToOctalString(int number) {
    String returnString = "";
    return Integer.toOctalString(number);
  }   
 
   public String intToHexString(int number) {
    String returnString = "";
    return Integer.toHexString(number);
  }     
  
  public String removeCharFromString(String s, char c) {
    String r = "";
    for (int i = 0; i < s.length(); i++) {
      if (s.charAt(i) != c)
        r += s.charAt(i);
    }
    return r;
  }  
  
  public String removeCharAtPosition(String s, int pos) {
    return s.substring(0, pos) + s.substring(pos + 1);
  } 
  
   public int stringToHashCode(String inputString) {
    return inputString.hashCode();
  } 
  
  

#End If