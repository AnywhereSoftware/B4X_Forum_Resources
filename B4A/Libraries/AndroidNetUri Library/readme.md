### AndroidNetUri Library by Ivica Golubovic
### 12/05/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/136402/)

[SIZE=7]**DEPRECATED LIBRARY!!! Use [**AndroidNetUri2**](https://www.b4x.com/android/forum/threads/androidneturi2-uri-wrapper.157807/) instead.**[/SIZE]  
  
  
This library contains the AndroidNetUri class with all the features, methods and properties like android.net.Uri for Java. It also contains the AndroidNetUriBuilder class which is a subclass of the android.net.uri class (android.net.Uri.Builder). This library is adapted for work in BA.  
  
As one of my developer friends says, "Today it's all Uri and Uri is everything.". That is why BA deserves to have this class with all its possibilities.  
  
**AndroidNetUri  
  
Author:** Ivica Golubovic  
**Version:** 1  

- **AndroidNetURI**

- **Functions:**

- **BuildUpon** As AndroidNetURIBuilder
*Constructs a new builder, copying the attributes from this Uri.*- **CompareTo** (Other As AndroidNetURI) As Int
*Compares the string representation of this Uri with that of another.*- **Decode** (S As String) As String
*Decodes '%'-escaped octets in the given string using the UTF-8 scheme. Replaces invalid octets with the unicode replacement character ("\\uFFFD").  
 S As String: encoded string to decode  
 Return: the given string with escaped octets decoded, or null if s is null*- **Encode** (S As String) As String
*Encodes characters in the given string as '%'-escaped octets using the UTF-8 scheme. Leaves letters ("A-Z", "a-z"), numbers ("0-9"), and unreserved characters ("\_-!.~'()\*") intact. Encodes all other characters.  
 S As String: string to encode  
 Return: an encoded version of s suitable for use as a URI component, or null if s is null*- **Encode2** (S As String, Allow As String) As String
*Encodes characters in the given string as '%'-escaped octets using the UTF-8 scheme. Leaves letters ("A-Z", "a-z"), numbers ("0-9"), and unreserved characters ("\_-!.~'()\*") intact. Encodes all other characters with the exception of those specified in the allow argument.  
 S As String: string to encode  
 Allow As String: set of additional characters to allow in the encoded form, null if no characters should be skipped  
 Return: an encoded version of s suitable for use as a URI component, or null if s is null*- **Equals** (O As Object) As Boolean
*Compares this Uri to another object for equality. Returns true if the encoded string representations of this Uri and the given Uri are equal. Case counts. Paths are not normalized. If one Uri specifies a default port explicitly and the other leaves it implicit, they will not be considered equal.  
 O As Object: This value may be null.  
 Return: true if this object is the same as the obj argument; false otherwise.*- **FromFile** (FilePath As String, FileName As String) As String
*Creates a Uri from a file. The URI has the form "file://". Encodes path characters with the exception of '/'.  
 Example: "file:///tmp/android.txt"  
 FilePath As String: path to file  
 FileName As String: filename with extension*- **FromParts** (Scheme As String, Ssp As String, Fragment As String) As String
*Creates an opaque Uri from the given components. Encodes the ssp which means this method cannot be used to create hierarchical URIs.  
 Scheme As String: of the URI  
 Ssp As String: scheme-specific-part, everything between the scheme separator (':') and the fragment separator ('#'), which will get encoded  
 Fragment As String: fragment, everything after the '#', null if undefined, will get encoded*- **GetBooleanQueryParameter** (Key As String, DefaultValue As Boolean) As Boolean
*Searches the query string for the first value with the given key and interprets it as a boolean value. "false" and "0" are interpreted as false, everything else is interpreted as true.  
 Key As String: string which will be decoded  
 DefaultValue As Boolean:  
 Return: the default value to return if there is no query parameter for key*- **GetQueryParameter** (Key As String) As String
*Searches the query string for the first value with the given key.  
 Warning: Prior to Jelly Bean, this decoded the '+' character as '+' rather than ' '.  
 Key As String: string which will be encoded  
 Return: the decoded value or null if no parameter is found*- **GetQueryParameters** (Key As String) As List
*Searches the query string for parameter values with the given key.  
 Key As String: string which will be encoded  
 Return: a list of decoded values*- **HashCode** As Int
*Hashes the encoded string represention of this Uri consistently with equals(Object).  
 Return: a hash code value for this object.*- **Initialize** (ObjectFromJava As Object) As String
*Initializes the object. ObjectFromJava to Null for a new instance.*- **IsAbsolute** As Boolean
*Returns true if this URI is absolute, i.e. if it contains an explicit scheme.  
 Return: true if this URI is absolute, false if it's relative*- **IsHierarchical** As Boolean
*Returns true if this URI is hierarchical like "<http://google.com>". Absolute URIs are hierarchical if the scheme-specific part starts with a '/'. Relative URIs are always hierarchical.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **IsOpaque** As Boolean
*Returns true if this URI is opaque like "mailto:[EMAIL]nobody@google.com[/EMAIL]". The scheme-specific part of an opaque URI cannot start with a '/'.*- **IsRelative** As Boolean
*Returns true if this URI is relative, i.e. if it doesn't contain an explicit scheme.*- **NormalizeScheme** As String
*Return an equivalent URI with a lowercase scheme component. This aligns the Uri with Android best practices for intent filtering.  
For example, "<HTTP://www.android.com>" becomes "<http://www.android.com>"  
 All URIs received from outside Android (such As user input, Or external sources like Bluetooth, NFC, Or the Internet) should be normalized before they are used To create an Intent.  
 Result: normalized Uri (never null)*- **Parse** (UriString As String) As String
*Creates a Uri which parses the given encoded URI string.  
 UriString As String: an RFC 2396-compliant, encoded URI  
 Return: Uri for this given uri string*- **ToObject** As Object
*Creates object from AndroidNetUri which can be used as android.net.Uri in java.*- **ToString** As String
*Returns the encoded string representation of this URI. Example: "<http://google.com/>"*- **WithAppendedPath** (BaseUri As AndroidNetURI, PathSegment As String) As String
*Creates a new Uri by appending an already-encoded path segment to a base Uri.  
 BaseUri As AndroidNetURI: Uri to append path segment to  
 PathSegment As String: encoded path segment to append*- **WithAppendedPath2** (BaseUri As Object, PathSegment As String) As String
*Creates a new Uri by appending an already-encoded path segment to a base Uri.  
 BaseUri As Object: Uri to append path segment to as android.net.Uri  
 PathSegment As String: encoded path segment to append*
- **Properties:**

- **Authority** As String [read only]
*Gets the decoded authority part of this URI. For server addresses, the authority is structured as follows: [ userinfo '@' ] host [ ':' port ]  
Examples: "google.com", "[EMAIL]bob@google.com[/EMAIL]:80"  
 Return: the authority for this URI or null if not present*- **EncodedAuthority** As String [read only]
*Gets the encoded authority part of this URI. For server addresses, the authority is structured as follows: [ userinfo '@' ] host [ ':' port ]  
Examples: "google.com", "[EMAIL]bob@google.com[/EMAIL]:80"  
 Return: the authority for this URI or null if not present*- **EncodedFragment** As String [read only]
*Gets the encoded fragment part of this URI, everything after the '#'.  
 Return: the encoded fragment or null if there isn't one*- **EncodedPath** As String [read only]
*Gets the encoded path.  
Return: the encoded path, or null if this is not a hierarchical URI (like "mailto:[EMAIL]nobody@google.com[/EMAIL]") or the URI is invalid*- **EncodedQuery** As String [read only]
*Gets the encoded query component from this URI. The query comes after the query separator ('?') and before the fragment separator ('#'). This method would return "q=android" for "<http://www.google.com/search?q=android>".  
 Return: the encoded query or null if there isn't one*- **EncodedSchemeSpecificPart** As String [read only]
*Gets the scheme-specific part of this URI, i.e. everything between the scheme separator ':' and the fragment separator '#'. If this is a relative URI, this method returns the entire URI. Leaves escaped octets intact.  
 Example: "//[www.google.com/search?q=android](http://www.google.com/search?q=android)"  
 Return: the encoded scheme-specific-part*- **EncodedUserInfo** As String [read only]
*Gets the encoded user information from the authority. For example, if the authority is "[EMAIL]nobody@google.com[/EMAIL]", this method will return "nobody".  
 Return: the user info for this URI or null if not present*- **Fragment** As String [read only]
*Gets the decoded fragment part of this URI, everything after the '#'.  
 Return: the decoded fragment or null if there isn't one*- **Host** As String [read only]
*Gets the encoded host from the authority for this URI. For example, if the authority is "[EMAIL]bob@google.com[/EMAIL]", this method will return "google.com".  
 Return: the host for this URI or null if not present*- **LastPathSegment** As String [read only]
*Gets the decoded last segment in the path.  
 Return: the decoded last segment or null if the path is empty*- **Path** As String [read only]
*Gets the decoded path.  
Return: the decoded path, or null if this is not a hierarchical URI (like "mailto:[EMAIL]nobody@google.com[/EMAIL]") or the URI is invalid*- **PathSegments** As List [read only]
*Gets the decoded path segments.  
 Return: decoded path segments, each without a leading or trailing '/'*- **Port** As Int [read only]
*Gets the port from the authority for this URI. For example, if the authority is "google.com:80", this method will return 80.  
 Result: the port for this URI or -1 if invalid or not present*- **Query** As String [read only]
*Gets the decoded query component from this URI. The query comes after the query separator ('?') and before the fragment separator ('#'). This method would return "q=android" for "<http://www.google.com/search?q=android>".  
 Return: the decoded query or null if there isn't one*- **Scheme** As String [read only]
*Gets the scheme of this URI. Example: "http"  
 Return: the scheme or null if this is a relative URI*- **SchemeSpecificPart** As String [read only]
*Gets the scheme-specific part of this URI, i.e. everything between the scheme separator ':' and the fragment separator '#'. If this is a relative URI, this method returns the entire URI. Decodes escaped octets.  
 Example: "//[www.google.com/search?q=android](http://www.google.com/search?q=android)"  
 Return: the decoded scheme-specific-part*- **UserInfo** As String [read only]
*Gets the decoded user information from the authority. For example, if the authority is "[EMAIL]nobody@google.com[/EMAIL]", this method will return "nobody".  
 Return: the user info for this URI or null if not present*
- **AndroidNetURIBuilder**

- **Functions:**

- **AppendEncodedPath** (NewSegment As String) As String
*Appends the given segment to the path.*- **AppendPath** (NewSegment As String) As String
*Encodes the given segment and appends it to the path.*- **AppendQueryParameter** (Key As String, Value As String) As String
*Encodes the key and value and then appends the parameter to the query string.*- **Authority** (Authority1 As String) As String
*Encodes and sets the authority.*- **Build** As AndroidNetURI
*Constructs a Uri with the current attributes.*- **ClearQuery** As String
*Clears the the previously set query.*- **EncodedAuthority** (Authority1 As String) As String
*Sets the previously encoded authority.*- **EncodedFragment** (Fragment1 As String) As String
*Sets the previously encoded fragment.*- **EncodedOpaquePart** (OpaquePart1 As String) As String
*Sets the previously encoded opaque scheme-specific-part.*- **EncodedPath** (Path1 As String) As String
*Sets the previously encoded path.  
 If the path is not null and doesn't start with a '/', and if you specify a scheme and/or authority, the builder will prepend the given path with a '/'.*- **EncodedQuery** (Query1 As String) As String
*Sets the previously encoded query.*- **Fragment** (Fragment1 As String) As String
*Encodes and sets the fragment.*- **Initialize** (ObjectFromJava As Object) As String
*Initializes the object. ObjectFromJava to Null for a new instance.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **OpaquePart** (OpaquePart1 As String) As String
*Encodes and sets the given opaque scheme-specific-part.*- **Path** (Path1 As String) As String
*Sets the path. Leaves '/' characters intact but encodes others as necessary.  
 If the path is not null and doesn't start with a '/', and if you specify a scheme and/or authority, the builder will prepend the given path with a '/'.*- **Query** (Query1 As String) As String
*Encodes and sets the query.*- **Scheme** (Scheme1 As String) As String
*Sets the scheme.*- **ToObject** As Object
*Creates object from AndroidNetUriBuilder which can be used as android.net.Uri.Builder in java.*- **ToString** As String
*Returns a string representation of the object. In general, the toString method returns a string that "textually represents" this object. The result should be a concise but informative representation that is easy for a person to read. It is recommended that all subclasses override this method.  
 The ToString method for class Object returns a string consisting of the name of the class of which the object is an instance, the at-sign character `@', and the unsigned hexadecimal representation of the hash code of the object*
<https://www.paypal.com/donate/?hosted_button_id=HX7GS8H4XS54Q>