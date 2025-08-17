B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

#if AppNotes

2024/07/27:
	Moved notes from Main to here (code module AppNotes)
	Fixed another bug in cmbStudentID_ValueChanged

'******
'2018/05/29:
'******
'Fixed a race condition in cmbStudentID_ValueChanged. Tried three options (see code) and picked third one.
'Noticed previously while updating the layout file, but filed away as fluke.
'Thanks once more to @Diceman for pointing it out and making me look at it more closely.
'https://www.b4x.com/android/forum/threads/jrdc2-client-example-using-modded-jrdc2.85581/#post-588834

'******
'2018/05/16:
'******
'Created a new layout file that works with current (as of date) B4J version(s).
'Thanks to @Diceman for pointing out the issue.
'https://www.b4x.com/android/forum/threads/jrdc2-client-example-using-modded-jrdc2.85581/#post-591798

'******
'2017/10/30:
'******
'DBUtils example adaptation to jRDC2
'Requirements:
'1)Running jRDC2 Server with following sql command entries listed below. Please note that they are set up
'  to work with SQLite. For one statement, an alternative is provided for MySQL. Other DBs may need other
'  adjustements.
'2)The jRDC2Utils.Intitialize in AppStart below needs to be adjusted to access your jRDC2 server.

'******** config.properties SQL COMMANDS ***********
'#SQL COMMANDS
'sql.drop_students=DROP TABLE If EXISTS Students
'sql.drop_grades=DROP TABLE If EXISTS Grades
'sql.drop_dbversion=DROP TABLE If EXISTS DBVersion
'sql.create_table_students=CREATE TABLE If Not EXISTS Students (\
'	Id VARCHAR(255) PRIMARY KEY,\
'	`First Name` TEXT,\
'	`Last Name` TEXT,\
'	Birthday BIGINT)
'sql.create_table_grades=CREATE TABLE If Not EXISTS Grades (\
'	Id VARCHAR(255),\
'	Test TEXT,\
'	Grade INTEGER)
'sql.insert_students=INSERT INTO Students (Id, `First Name`, `Last Name`, Birthday) VALUES (?, ?, ?, ?)
'sql.insert_grades=INSERT INTO Grades (Id, Test, Grade) VALUES (?, ?, ?)
'sql.select_studentids=Select Id FROM Students
'sql.select_students=Select Id, `First Name`, `Last Name`, Birthday FROM students
'sql.select_student=Select Id, `First Name`, `Last Name`, Birthday FROM students WHERE id = ?
'sql.select_tests=Select Test FROM Grades WHERE id = ?
'#SQLite version
'sql.select_testgrades=Select test || ', Grade: ' || grade FROM Grades WHERE id = ? AND grade <= 55
'#MySQL version
'#sql.select_testgrades=SELECT CONCAT(test, ', Grade: ', grade) FROM Grades WHERE id = ? AND grade <= 55
'sql.select_grade=Select Grade FROM Grades WHERE id = ? And test = ?
'sql.update_grade=UPDATE Grades SET Grade = ? WHERE id = ? And test = ?


#End If
