B4J=True
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	Private mIncomes As List
	Private mBanks As List
	Private mCreditCards As List
	Private mAssets As List
End Sub
	
Public Sub Initialize
End Sub
	
Public Sub New As clsFinancial
	Dim newItem As clsFinancial
	newItem.Initialize
	newItem.mIncomes.Initialize
	newItem.mBanks.Initialize
	newItem.mCreditCards.Initialize
	newItem.mAssets.Initialize
	Return newItem
End Sub
	
Public Sub getIncomes As List
	Return mIncomes
End Sub
	
Public Sub getBanks As List
	Return mBanks
End Sub
	
Public Sub getCreditCards As List
	Return mCreditCards
End Sub
	
Public Sub getAssets As List
	Return mAssets
End Sub
	
'Add Class-specific Subs and Calls to other Class Public Subs Here_________________________________________
	
'__________________________________________________________________________________________________________
	
#Region Delegate Subs
	
#End Region
	
