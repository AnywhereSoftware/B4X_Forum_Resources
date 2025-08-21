B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.801
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Public SQL As SQL
 
	Public DBName As String
	Public TotColNumber As Int
	Public FrozenCols As Int
	Public ColNames(60) As String                        'Could be a list
	Public ColDataTypes(60) As String					 'Could be a list

End Sub

Sub Service_Create
	SQL.Initialize(File.DirInternal, "PROJECTS.db", True)       'Opens/created a Projects DB
	CreateDBTables
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

Sub Service_TaskRemoved
	
End Sub


Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub


'Creates two db Tables
Sub CreateDBTables
	SQLUtil.DropTable(SQL,"EQUIPMENT")							    'delete table if you want to start new
	If SQLUtil.TableExists(SQL,"EQUIPMENT")=False Then						'creates table if doesnt exist
		EquipInfo.EquipmentHeaders               							'headers for b4Xtable/dbColumns
		SQLUtil.CreateSQLTable(SQL,DBName,TotColNumber)       				'creates the database
		EquipInfo.PopulateEquipTable                  						'add records
	End If
		
	SQLUtil.DropTable(SQL,"CABLES")								'delete table if you want to start new
	If SQLUtil.TableExists(SQL,"CABLES")=False Then							'creates table if doesnt exist
		CableInfo.CableHeaders												'headers for b4Xtable/dbColumns
		SQLUtil.CreateSQLTable(SQL,DBName,TotColNumber)						'creates the database
		CableInfo.PopulateCableTable                      					'add records
	End If
End Sub