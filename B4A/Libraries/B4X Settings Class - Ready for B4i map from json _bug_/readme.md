### B4X Settings Class - Ready for B4i map from json "bug" by hatzisn
### 03/31/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/108194/)

Hi everyone,  
  
***(31/3/2020)***   
***\* Rechanged the object name to MySettings to avoid conflict with Settings object of B4i.***  
  
***(23/3/2020)***   
***\* Changed the project to B4XLib***  
***\* Added the function ContainsSetting which returns True if the setting is apparent in the Settings***  
  
  
the following is a settings class which makes it absolutely easy to save as many settings as you want in one text field in a SQLite database table. You initialize it with the field name, table name, folder of db and db file name or just with the field name, table name and an SQL and then everything is a piece of cake. Call its methods to Load settings, Save Settings, Set setting field, Get setting field, Set "Saved settings" message, Set "Settings Loaded" message. The class is ready for the B4i map from json "bug" which does not allow you to change values in a map derived from json in B4i.  
  
Edit - The settings table must have one row  
  
  

```B4X
Sub Class_Globals  
    Private sField As String  
    Private sTable As String  
    Private mSets As Map  
    Private connSettings As SQL  
    Private saveSet As String = "The settings were saved."  
    Private loadSet As String = "The settings were loaded."  
    #IF B4i  
        Dim hd As HUD  
    #End If  
  
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize(FieldInDBToLoadAndSaveTheSettings As String, TableInDBToLoadAndSaveTheSettings As String, FolderOfDB As String, DBFileName As String)  
    sField = FieldInDBToLoadAndSaveTheSettings  
    sTable = TableInDBToLoadAndSaveTheSettings  
    mSets.Initialize  
    connSettings.Initialize(FolderOfDB, DBFileName, False)  
End Sub  
  
Public Sub Initialize2(FieldInDBToLoadAndSaveTheSettings As String, TableInDBToLoadAndSaveTheSettings As String, conn As SQL)  
    sField = FieldInDBToLoadAndSaveTheSettings  
    sTable = TableInDBToLoadAndSaveTheSettings  
    mSets.Initialize  
    connSettings = conn  
End Sub  
  
Public Sub LoadSettings  
    Dim cur As ResultSet  
    Dim sSettings As String  
  
    Try  
        cur = connSettings.ExecQuery("SELECT " & EscapeSQLEntity(sField) & " FROM " & EscapeSQLEntity(sTable))  
        Do While cur.NextRow  
            sSettings = cur.GetString(sField)  
          
            Dim jp As JSONParser  
            jp.Initialize(sSettings)  
            Dim m As Map  
            m = jp.NextObject  
            'To avoid the bug of iOS - Maps derived from JSON cannot change  
            For Each k As String In m.Keys  
                mSets.Put(k, m.Get(k))  
            Next  
          
            'take only the first row  
            Exit  
        Loop  
        #IF B4A  
            ToastMessageShow(loadSet, True)  
        #Else If B4i  
            hd.ToastMessageShow(loadSet, True)  
        #End If  
      
    Catch  
        Log(LastException)  
        #IF B4A  
            ToastMessageShow(LastException, True)  
        #Else If B4i  
            hd.ToastMessageShow(LastException, True)  
        #End If  
    End Try  
  
  
End Sub  
  
  
  
  
Public Sub Set(SettingName As String, SettingValue As Object)  
    mSets.Put(SettingName, SettingValue)  
End Sub  
  
Public Sub Get(SettingName As String) As Object  
    Return mSets.Get(SettingName)  
End Sub  
  
  
Public Sub SaveSettings  
    Dim sSettings As String  
    Dim jg As JSONGenerator  
    jg.Initialize(mSets)  
    sSettings = jg.ToString  
    connSettings.ExecNonQuery2("UPDATE " & EscapeSQLEntity(sTable) & " SET " & EscapeSQLEntity(sField) & "=?", Array As String(sSettings))  
  
    #IF B4A  
        ToastMessageShow(saveSet, True)  
    #Else If B4i  
        hd.ToastMessageShow(saveSet, True)  
    #End If  
  
End Sub  
  
  
Private Sub EscapeSQLEntity(sEntityName) As String  
    Dim sb As StringBuilder  
    sb.Initialize  
  
    If sEntityName.StartsWith("[") = False Then  
        sb.Append("[")  
    End If  
    sb.Append(sEntityName.Trim)  
    If sEntityName.EndsWith("]") = False Then  
        sb.Append("]")  
    End If  
    Return sb.ToString  
End Sub  
  
Public Sub setSettingsSavedMessage(sMes As String)  
    saveSet = sMes  
End Sub  
  
Public Sub setSettingsLoadedMessage(sMes As String)  
    loadSet = sMes  
End Sub
```