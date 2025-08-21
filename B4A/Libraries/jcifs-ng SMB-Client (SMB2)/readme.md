### jcifs-ng SMB-Client (SMB2) by DonManfred
### 03/15/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/104560/)

Foreword:  
I do have nearly zero knowledge about SMB-Protocol. I know Windowsshares and how to access them. But my knowledge about the Different Protocolversions is really low.  
About two weeks ago someone contacted me and asked me to write a wrapper for a SMB Library because the available SMB Library only support Protocolversion 1. Due to the securityguidelines he need SMB2 at minimum version.  
I started doing a wrap for [SMBJ](https://github.com/hierynomus/smbj). But when i tried to build an Example i found out that B4A will not compile it. Based on Erels answer the lib is using Android features which are only available starting from Android 8.  
A future B4A maybe will have the possibility to set the right flag for the Dexer tool to be able to compile a app using SMBJ. For now it does not work.  
Ok, too bad.  
  
I then had a look at [jcif-ng](https://github.com/AgNO3/jcifs-ng) I started doing a wrap for this. Only the needed methods to find out if it works at all ;-)I got it working for me. I am using Windows 10 and definetively not have SMB1 support enabled.  
I was not able to connect using SMB Library which is expected.  
  
It took me the hole last weekend (12+h/day) to figure it out to build a first libary version which was able to connect to my Windows 10 Shares.  
Ok, the lib was "born". It is alive :D  
I then finished all what i think what should be wrapped.  
  
Ok, here we go :)  
  
This is the B4A Version. [A B4J Version is also available](https://www.b4x.com/android/forum/threads/jcifs-ng-smb-client-smb2.104561/).  
——————————————————————————————–  
This is a wrap for this [Github-Project](https://github.com/AgNO3/jcifs-ng).  
  
[SIZE=4]jcifs-ng is a cleaned-up and improved version of the jCIFS library[/SIZE]  
  
jcifs-ng is based on [JCIFS](https://www.jcifs.org/)  
JCIFS is an Open Source client library that implements the CIFS/SMB networking protocol in 100% Java. CIFS is the standard file sharing protocol on the Microsoft Windows platform (e.g. Map Network Drive …). This client is used extensively in production on large Intranets.  
  
  
**jcifs-ng  
  
Author:** DonManfred  
**Version:** 0.29  

- **SMBClient**

- **Events:**

- **Children** (success As Boolean, children As List)
- **CopyProgress** (totalBytes As Int, path As String, filename As String)
- **CopyResult** (success As Boolean, path As String, filename As String)
- **CopyTo** (success As Boolean, smbResource As SMBResource, smbfile As SMBFile)
- **Delete** (success As Boolean, toDelete As SmbFile)
- **FileAvailable** (smbfile As SMBFile)
- **ListFiles** (filelist As List)
- **Resource** (success As Boolean, smbResource As SMBResource, smbfile As SMBFile, info As String)
- **ResourceAvailable** (smbResource As SMBResource)

- **Functions:**

- **Copy** (inputFile As jcifs.smb.SmbFile, destPath As String, destFilename As String)
- **Copy2** (srcPath As String, srcFilename As String, destPath As jcifs.smb.SmbFile, destFilename As String)
- **CopyTo** (src As jcifs.smb.SmbFile, dest As jcifs.smb.SmbFile)
- **CreateSmbFile** (parent As jcifs.smb.SmbFile, fileorfolder As String) As jcifs.smb.SmbFile
- **delete** (todelete As jcifs.smb.SmbFile)
- **GetChildren** (res As jcifs.SmbResource)
- **GetChildren2** (res As jcifs.SmbResource, filter As String)
- **GetResourcefromUrl** (url As String)
*Get a SmbResource AND a SmbFile from the given URL  
 Raises the Event SMBClient\_Resource(smbobjres As Object,smbobj As Object)*- **GetResourcefromUrl2** (url As String)
*Get a SmbResource AND a SmbFile from the given URL  
 Raises the Event SMBClient\_Resource(smbobjres As Object,smbobj As Object)*- **GetSmbFilefromUrl** (url As String)
- **Initialize** (EventName As String, domain As String, userName As String, password As String, url As String)
- **listFiles** (inputFile As jcifs.smb.SmbFile)
*List the contents of this SMB resource as an array of  
<code>SmbResource</code> objects. This method is much more efficient than  
the regular <code>list</code> method when querying attributes of each  
file in the result set.  
<p>  
The list of <code>SmbResource</code>s returned by this method will be;  
<ul>  
<li>files and directories contained within this resource if the  
resource is a normal disk file directory,  
<li>all available NetBIOS workgroups or domains if this resource is  
the top level URL <code>smb://</code>,  
<li>all servers registered as members of a NetBIOS workgroup if this  
resource refers to a workgroup in a <code>smb://workgroup/</code> URL,  
<li>all browseable shares of a server including printers, IPC  
services, or disk volumes if this resource is a server URL in the form  
<code>smb://server/</code>,  
<li>or <code>null</code> if the resource cannot be resolved.  
</ul>  
If strict resource lifecycle is used, make sure you close the individual files after use.  
Return type: @return:An array of <code>SmbResource</code> objects representing file  
 and directories, workgroups, servers, or shares depending on the context  
 of the resource URL*- **listFiles2** (inputFile As jcifs.smb.SmbFile, wildcard As String)
*The CIFS protocol provides for DOS "wildcards" to be used as  
a performance enhancement. The client does not have to filter  
the names and the server does not have to return all directory  
entries.  
<p>  
The wildcard expression may consist of two special meta  
characters in addition to the normal filename characters. The '\*'  
character matches any number of characters in part of a name. If  
the expression begins with one or more '?'s then exactly that  
many characters will be matched whereas if it ends with '?'s  
it will match that many characters <i>or less</i>.  
<p>  
Wildcard expressions will not filter workgroup names or server names.  
<blockquote>  
<pre>  
winnt&gt; ls c?o\*  
clock.avi -rw– 82944 Mon Oct 14 1996 1:38 AM  
Cookies drw– 0 Fri Nov 13 1998 9:42 PM  
2 items in 5ms  
</pre>  
</blockquote>  
If strict resource lifecycle is used, make sure you close the individual files after use.  
wildcard: a wildcard expression  
Return type: @return:An array of <code>SmbResource</code> objects representing file  
 and directories, workgroups, servers, or shares depending on the context  
 of the resource URL*- **xxx**

- **SMBFile**

- **Functions:**

- **addRequestProperty** (arg0 As String, arg1 As String)
- **close**
- **connect**
- **createNewFile**
- **exists** As Boolean
- **fileIndex** As Long
- **Initialize** (url As String, ctx As jcifs.CIFSContext)
- **IsInitialized** As Boolean
- **listByFilter** (filter As jcifs.smb.SmbFilenameFilter) As String()
*List the contents of this SMB resource. The list returned will be  
identical to the list returned by the parameterless <code>list()</code>  
method minus filenames filtered by the specified filter.  
filter: a filename filter to exclude filenames from the results  
Return type: @return:<code>String[]</code> array of matching files and directories,  
 workgroups, servers, or shares depending on the context of the  
 resource URL*
- **Properties:**

- **AllowUserInteraction** As Boolean [read only]
- **Attributes** As Int [read only]
- **CanonicalPath** As String [read only]
*Returns the full URL of this SMB resource with '.' and '..' components  
factored out. An <code>SmbFile</code> constructed with the result of  
this method will result in an <code>SmbFile</code> that is equal to  
 the original.*- **CanonicalUncPath** As String [read only]
*Returns the Windows UNC style path with backslashes instead of forward slashes.*- **ConnectTimeout** As Int [read only]
- **Content** As Object [read only]
- **ContentEncoding** As String [read only]
- **ContentLengthLong** As Long [read only]
- **ContentType** As String [read only]
- **Context** As jcifs.CIFSContext [read only]
- **createTime** As Long [read only]
- **Date** As Long [read only]
- **DefaultUseCaches** As Boolean [read only]
- **DfsPath** As String [read only]
*If the path of this <code>SmbFile</code> falls within a DFS volume,  
this method will return the referral path to which it maps. Otherwise  
 <code>null</code> is returned.*- **DiskFreeSpace** As Long [read only]
- **isDirectory** As Boolean [read only]
- **isFile** As Boolean [read only]
- **isHidden** As Boolean [read only]
- **lastAccess** As Long [read only]
- **lastModified** As Long [read only]
- **length** As Long [read only]
- **Name** As String [read only]
- **Parent** As String [read only]
*Everything but the last component of the URL representing this SMB  
resource is effectively it's parent. The root URL <code>smb://</code>  
 does not have a parent. In this case <code>smb://</code> is returned.*- **Path** As String [read only]
*Returns the full uncanonicalized URL of this SMB resource. An  
<code>SmbFile</code> constructed with the result of this method will  
 result in an <code>SmbFile</code> that is equal to the original.*- **Server** As String [read only]
*Retrieve the hostname of the server for this SMB resource. If this  
<code>SmbFile</code> references a workgroup, the name of the workgroup  
is returned. If this <code>SmbFile</code> refers to the root of this  
 SMB network hierarchy, <code>null</code> is returned.*- **ServerWithDfs** As String [read only]
*Retrieve the hostname of the server for this SMB resource. If the resources has been resolved by DFS this will  
 return the target name.*- **Share** As String [read only]
*Retrieves the share associated with this SMB resource. In  
the case of <code>smb://</code>, <code>smb://workgroup/</code>,  
and <code>smb://server/</code> URLs which do not specify a share,  
 <code>null</code> will be returned.*- **TreeHandle** As jcifs.SmbTreeHandle [read only]
- **UncPath** As String [read only]

- **SMBResource**

- **Functions:**

- **canRead** As Boolean
*Tests to see if the file this <code>SmbResource</code> represents can be  
read. Because any file, directory, or other resource can be read if it  
exists, this method simply calls the <code>exists</code> method.  
 Return type: @return:<code>true</code> if the file is read-only*- **canWrite** As Boolean
*Tests to see if the file this <code>SmbResource</code> represents  
exists and is not marked read-only. By default, resources are  
considered to be read-only and therefore for <code>smb://</code>,  
<code>smb://workgroup/</code>, and <code>smb://server/</code> resources  
will be read-only.  
Return type: @return:<code>true</code> if the resource exists is not marked  
 read-only*- **children** As jcifs.CloseableIterator
*Fetch all children  
 Return type: @return:an iterator over the child resources*- **children2** (wildcard As String) As jcifs.CloseableIterator
*Fetch children matching pattern, server-side filtering  
<p>  
The wildcard expression may consist of two special meta  
characters in addition to the normal filename characters. The '\*'  
character matches any number of characters in part of a name. If  
the expression begins with one or more '?'s then exactly that  
many characters will be matched whereas if it ends with '?'s  
it will match that many characters <i>or less</i>.  
<p>  
Wildcard expressions will not filter workgroup names or server names.  
wildcard:  
 Return type: @return:an iterator over the child resources*- **children3** (filter As String) As jcifs.CloseableIterator
- **children4** (filter As jcifs.ResourceFilter) As jcifs.CloseableIterator
 *filter: filter acting on SmbResource instances  
 Return type: @return:an iterator over the child resources*- **close**
*Close/release the file  
 This releases all resources that this file holds. If not using strict mode this is currently a no-op.*- **copyTo** (dest As jcifs.SmbResource)
*This method will copy the file or directory represented by this  
<tt>SmbResource</tt> and it's sub-contents to the location specified by the  
<tt>dest</tt> parameter. This file and the destination file do not  
need to be on the same host. This operation does not copy extended  
file attributes such as ACLs but it does copy regular attributes as  
well as create and last write times. This method is almost twice as  
efficient as manually copying as it employs an additional write  
thread to read and write data concurrently.  
<br>  
It is not possible (nor meaningful) to copy entire workgroups or  
servers.  
 dest: the destination file or directory*- **createNewFile**
*Create a new file but fail if it already exists. The check for  
existence of the file and it's creation are an atomic operation with  
 respect to other filesystem activities.*- **createTime** As Long
*Retrieve the time this <code>SmbResource</code> was created. The value  
returned is suitable for constructing a {@link java.util.Date} object  
(i.e. seconds since Epoch 1970). Times should be the same as those  
reported using the properties dialog of the Windows Explorer program.  
For Win95/98/Me this is actually the last write time. It is currently  
not possible to retrieve the create time from files on these systems.  
Return type: @return:The number of milliseconds since the 00:00:00 GMT, January 1,  
 1970 as a <code>long</code> value*- **delete**
*This method will delete the file or directory specified by this  
<code>SmbResource</code>. If the target is a directory, the contents of  
the directory will be deleted as well. If a file within the directory or  
it's sub-directories is marked read-only, the read-only status will  
be removed and the file will be deleted.  
 If the file has been opened before, it will be closed.*- **exists** As Boolean
*Tests to see if the SMB resource exists. If the resource refers  
only to a server, this method determines if the server exists on the  
network and is advertising SMB services. If this resource refers to  
a workgroup, this method determines if the workgroup name is valid on  
the local SMB network. If this <code>SmbResource</code> refers to the root  
<code>smb://</code> resource <code>true</code> is always returned. If  
this <code>SmbResource</code> is a traditional file or directory, it will  
be queried for on the specified server as expected.  
Return type: @return:<code>true</code> if the resource exists or is alive or  
 <code>false</code> otherwise*- **fileIndex** As Long
*Get the file index  
 Return type: @return:server side file index, 0 if unavailable*- **getOwnerGroup2** (resolve As Boolean) As jcifs.SID
*Return the owner group SID for this file or directory  
resolve: whether to resolve the group name  
 Return type: @return:the owner group SID, <code>null</code> if not present*- **getOwnerUser2** (resolve As Boolean) As jcifs.SID
*Return the owner user SID for this file or directory  
resolve: whether to resolve the user name  
 Return type: @return:the owner user SID, <code>null</code> if not present*- **getSecurity2** (resolveSids As Boolean) As jcifs.ACE()
*Return an array of Access Control Entry (ACE) objects representing  
the security descriptor associated with this file or directory.  
If no DACL is present, null is returned. If the DACL is empty, an array with 0 elements is returned.  
resolveSids: Attempt to resolve the SIDs within each ACE form  
 their numeric representation to their corresponding account names.  
 Return type: @return:array of ACEs*- **getShareSecurity** (resolveSids As Boolean) As jcifs.ACE()
*Return an array of Access Control Entry (ACE) objects representing  
the share permissions on the share exporting this file or directory.  
If no DACL is present, null is returned. If the DACL is empty, an array with 0 elements is returned.  
<p>  
Note that this is different from calling <tt>getSecurity</tt> on a  
share. There are actually two different ACLs for shares - the ACL on  
the share and the ACL on the folder being shared.  
Go to <i>Computer Management</i>  
&gt; <i>System Tools</i> &gt; <i>Shared Folders</i> &gt; <i>Shares</i> and  
look at the <i>Properties</i> for a share. You will see two tabs - one  
for "Share Permissions" and another for "Security". These correspond to  
the ACLs returned by <tt>getShareSecurity</tt> and <tt>getSecurity</tt>  
respectively.  
resolveSids: Attempt to resolve the SIDs within each ACE form  
 their numeric representation to their corresponding account names.  
 Return type: @return:array of ACEs*- **Initialize** (ctx As jcifs.SmbResource)
- **isDirectory** As Boolean
*Tests to see if the file this <code>SmbResource</code> represents is a directory.  
 Return type: @return:<code>true</code> if this <code>SmbResource</code> is a directory*- **isFile** As Boolean
*Tests to see if the file this <code>SmbResource</code> represents is not a directory.  
 Return type: @return:<code>true</code> if this <code>SmbResource</code> is not a directory*- **isHidden** As Boolean
*Tests to see if the file this SmbResource represents is marked as  
hidden. This method will also return true for shares with names that  
end with '$' such as <code>IPC$</code> or <code>C$</code>.  
 Return type: @return:<code>true</code> if the <code>SmbResource</code> is marked as being hidden*- **IsInitialized** As Boolean
- **length** As Long
*Returns the length of this <tt>SmbResource</tt> in bytes. If this object  
is a <tt>TYPE\_SHARE</tt> the total capacity of the disk shared in  
bytes is returned. If this object is a directory or a type other than  
<tt>TYPE\_SHARE</tt>, 0L is returned.  
Return type: @return:The length of the file in bytes or 0 if this  
 <code>SmbResource</code> is not a file.*- **mkdir**
*Creates a directory with the path specified by this  
<code>SmbResource</code>. For this method to be successful, the target  
must not already exist. This method will fail when  
used with <code>smb://</code>, <code>smb://workgroup/</code>,  
<code>smb://server/</code>, or <code>smb://server/share/</code> URLs  
because workgroups, servers, and shares cannot be dynamically created  
 (although in the future it may be possible to create shares).*- **mkdirs**
*Creates a directory with the path specified by this <tt>SmbResource</tt>  
and any parent directories that do not exist. This method will fail  
when used with <code>smb://</code>, <code>smb://workgroup/</code>,  
<code>smb://server/</code>, or <code>smb://server/share/</code> URLs  
because workgroups, servers, and shares cannot be dynamically created  
 (although in the future it may be possible to create shares).*- **openInputStream** As java.io.InputStream
*Opens an input stream reading the file (read only, sharable)  
 Return type: @return:input stream, needs to be closed when finished*- **openInputStream2** (sharing As Int) As java.io.InputStream
*Opens an input stream reading the file (read only)  
sharing: flags indicating for which operations others may open the file (FILE\_SHARING\_\*)  
 Return type: @return:input stream, needs to be closed when finished*- **openInputStream3** (flags As Int, access As Int, sharing As Int) As java.io.InputStream
*Opens an input stream reading the file (read only)  
flags: open flags  
access: desired access flags  
sharing: flags indicating for which operations others may open the file (FILE\_SHARING\_\*)  
 Return type: @return:input stream, needs to be closed when finished*- **openOutputStream** (append As Boolean) As java.io\_OutputStream
*Opens an output stream writing to the file (write only, read sharable)  
append: whether to append to or truncate the input  
Return type: @return:eek:utput stream, needs to be closed when finished*- **openOutputStream0** As java.io\_OutputStream
*Opens an output stream writing to the file (truncating, write only, sharable)  
Return type: @return:eek:utput stream, needs to be closed when finished*- **openOutputStream2** (append As Boolean, sharing As Int) As java.io\_OutputStream
*Opens an output stream writing to the file (write only, exclusive write access)  
append: whether to append to or truncate the input  
sharing: flags indicating for which operations others may open the file (FILE\_SHARING\_\*)  
Return type: @return:eek:utput stream, needs to be closed when finished*- **openOutputStream4** (append As Boolean, openFlags As Int, access As Int, sharing As Int) As java.io\_OutputStream
*Opens an output stream writing to the file (write only, exclusive write access)  
append: whether to append to or truncate the input  
openFlags: flags for open operation  
access: desired file access flags  
sharing: flags indicating for which operations others may open the file  
Return type: @return:eek:utput stream, needs to be closed when finished*- **openRandomAccess** (mode As String) As jcifs.SmbRandomAccess
*Opens the file for random access  
mode: access mode (r|rw)  
 Return type: @return:random access file, needs to be closed when finished*- **openRandomAccess2** (mode As String, sharing As Int) As jcifs.SmbRandomAccess
*Opens the file for random access  
mode: access mode (r|rw)  
sharing: flags indicating for which operations others may concurrently open the file  
 Return type: @return:random access file, needs to be closed when finished*- **renameTo** (dest As jcifs.SmbResource)
*Changes the name of the file this <code>SmbResource</code> represents to the name  
designated by the <code>SmbResource</code> argument.  
<br>  
<i>Remember: <code>SmbResource</code>s are immutable and therefore  
the path associated with this <code>SmbResource</code> object will not  
change). To access the renamed file it is necessary to construct a  
new <tt>SmbResource</tt></i>.  
 dest: An <code>SmbResource</code> that represents the new pathname*- **renameTo2** (dest As jcifs.SmbResource, replace As Boolean)
*Changes the name of the file this <code>SmbResource</code> represents to the name  
designated by the <code>SmbResource</code> argument.  
<br>  
<i>Remember: <code>SmbResource</code>s are immutable and therefore  
the path associated with this <code>SmbResource</code> object will not  
change). To access the renamed file it is necessary to construct a  
new <tt>SmbResource</tt></i>.  
dest: An <code>SmbResource</code> that represents the new pathname  
 replace: Whether an existing destination file should be replaced (only supported with SMB2)*- **resolve** (name As String) As jcifs.SmbResource
*Fetch a child resource  
name:  
 Return type: @return:the child resource*- **setReadOnly**
*Make this file read-only. This is shorthand for <tt>setAttributes(  
 getAttributes() | ATTR\_READ\_ONLY )</tt>.*- **setReadWrite**
*Turn off the read-only attribute of this file. This is shorthand for  
 <tt>setAttributes( getAttributes() &amp; ~ATTR\_READONLY )</tt>.*- **watch** (filter As Int, recursive As Boolean) As jcifs.SmbWatchHandle
- **watch2** (filter As Int, recursive As Boolean) As jcifs.SmbWatchHandle
*Creates a directory watch  
The server will notify the client when there are changes to the directories contents  
filter: see constants in {@link FileNotifyInformation}  
recursive: whether to also watch subdirectories  
 Return type: @return:watch context, needs to be closed when finished*
- **Properties:**

- **Attributes** As Int
*Return the attributes of this file. Attributes are represented as a  
bitset that must be masked with <tt>ATTR\_\*</tt> constants to determine  
if they are set or unset. The value returned is suitable for use with  
 the <tt>setAttributes()</tt> method.*- **Context** As jcifs.CIFSContext [read only]
*The context this file was opened with*- **DiskFreeSpace** As Long [read only]
*This method returns the free disk space in bytes of the drive this share  
represents or the drive on which the directory or file resides. Objects  
other than <tt>TYPE\_SHARE</tt> or <tt>TYPE\_FILESYSTEM</tt> will result  
 in 0L being returned.*- **LastAccess** As Long [write only]
*Set the last access time of the file. The time is specified as milliseconds  
from Jan 1, 1970 which is the same as that which is returned by the  
<tt>lastModified()</tt>, <tt>getLastModified()</tt>, and <tt>getDate()</tt> methods.  
<br>  
 This method does not apply to workgroups, servers, or shares.*- **LastModified** As Long [write only]
*Set the last modified time of the file. The time is specified as milliseconds  
from Jan 1, 1970 which is the same as that which is returned by the  
<tt>lastModified()</tt>, <tt>getLastModified()</tt>, and <tt>getDate()</tt> methods.  
<br>  
 This method does not apply to workgroups, servers, or shares.*- **Locator** As jcifs.SmbResourceLocator [read only]
*Gets the file locator for this file  
 The file locator provides details about*- **Name** As String [read only]
*Returns the last component of the target URL. This will  
effectively be the name of the file or directory represented by this  
<code>SmbResource</code> or in the case of URLs that only specify a server  
or workgroup, the server or workgroup will be returned. The name of  
the root URL <code>smb://</code> is also <code>smb://</code>. If this  
<tt>SmbResource</tt> refers to a workgroup, server, share, or directory,  
the name will include a trailing slash '/' so that composing new  
 <tt>SmbResource</tt>s will maintain the trailing slash requirement.*- **OwnerGroup** As jcifs.SID [read only]
*Return the resolved owner group SID for this file or directory*- **OwnerUser** As jcifs.SID [read only]
*Return the resolved owner user SID for this file or directory*- **Security** As jcifs.ACE() [read only]
*Return an array of Access Control Entry (ACE) objects representing  
the security descriptor associated with this file or directory.  
<p>  
Initially, the SIDs within each ACE will not be resolved however when  
<tt>getType()</tt>, <tt>getDomainName()</tt>, <tt>getAccountName()</tt>,  
or <tt>toString()</tt> is called, the names will attempt to be  
resolved. If the names cannot be resolved (e.g. due to temporary  
network failure), the said methods will return default values (usually  
<tt>S-X-Y-Z</tt> strings of fragments of).  
<p>  
Alternatively <tt>getSecurity(true)</tt> may be used to resolve all  
 SIDs together and detect network failures.*- **Type** As Int [read only]
*Returns type of of object this <tt>SmbResource</tt> represents.*
- **SMBSID**

- **Functions:**

- **Initialize** (ctx As jcifs.SID)
- **IsInitialized** As Boolean
- **toDisplayString** As String
*Return a String representing this SID ideal for display to  
users. This method should return the same text that the ACL  
editor in Windows would display.  
<p>  
Specifically, if the SID has  
been resolved and it is not a domain SID or builtin account,  
the full DOMAIN\name form of the account will be  
returned (e.g. MYDOM\alice or MYDOM\Domain Users).  
If the SID has been resolved but it is is a domain SID,  
only the domain name will be returned (e.g. MYDOM).  
If the SID has been resolved but it is a builtin account,  
only the name component will be returned (e.g. SYSTEM).  
If the sid cannot be resolved the numeric representation from  
toString() is returned.  
 Return type: @return:display format, potentially with resolved names*
- **Properties:**

- **AccountName** As String [read only]
*Return the sAMAccountName of this SID unless it could not  
be resolved in which case the numeric RID is returned. If this  
 SID is a domain SID, this method will return an empty String.*- **DomainName** As String [read only]
*Return the domain name of this SID unless it could not be  
 resolved in which case the numeric representation is returned.*- **DomainSid** As jcifs.SID [read only]
- **Rid** As Int [read only]
*Get the RID  
 This is the last subauthority identifier*- **Type** As Int [read only]
*Returns the type of this SID indicating the state or type of account.  
<p>  
SID types are described in the following table.  
<table summary="Type codes">  
<tr>  
<th>Type</th>  
<th>Name</th>  
</tr>  
<tr>  
<td>SID\_TYPE\_USE\_NONE</td>  
<td>0</td>  
</tr>  
<tr>  
<td>SID\_TYPE\_USER</td>  
<td>User</td>  
</tr>  
<tr>  
<td>SID\_TYPE\_DOM\_GRP</td>  
<td>Domain group</td>  
</tr>  
<tr>  
<td>SID\_TYPE\_DOMAIN</td>  
<td>Domain</td>  
</tr>  
<tr>  
<td>SID\_TYPE\_ALIAS</td>  
<td>Local group</td>  
</tr>  
<tr>  
<td>SID\_TYPE\_WKN\_GRP</td>  
<td>Builtin group</td>  
</tr>  
<tr>  
<td>SID\_TYPE\_DELETED</td>  
<td>Deleted</td>  
</tr>  
<tr>  
<td>SID\_TYPE\_INVALID</td>  
<td>Invalid</td>  
</tr>  
<tr>  
<td>SID\_TYPE\_UNKNOWN</td>  
<td>Unknown</td>  
</tr>  
 </table>*- **TypeText** As String [read only]
*Return text representing the SID type suitable for display to  
 users. Text includes 'User', 'Domain group', 'Local group', etc.*
Setup:  
- [Download Additional needed JARs here](https://www.dropbox.com/s/qkl31jbvgz9gz1a/jcifs-addionaljars.zip?dl=0). Put them into your Additional-Library folder.  
- Download the library attached and put then there too.  
  
App-Setup:  
Add these lines to your Main module.  

```B4X
#AdditionalJar: slf4j-api-1.7.25.jar  
#AdditionalJar: bctls-jdk15on-1.58.0.0.jar  
#AdditionalJar: bcprov-jdk15on-1.59.jar
```

  
  
Even that i do create the wrapper for a customer the customer allowed me to publish the lib here to make it available to all of you. So i´m pleased to publish the version i do have right now (still in development).  
  
[SIZE=6]Sponsored by [APS-Delta](https://aps-delta.de)[/SIZE]  
  
[SIZE=4]For any Question/Issue you have: Please create a new thread in the Questionsforum.[/SIZE]