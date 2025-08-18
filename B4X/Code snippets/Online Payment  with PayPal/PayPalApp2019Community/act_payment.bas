B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.5
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: True
	#IncludeTitle: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private WebView1 As WebView
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("lay_payment")

	ProgressDialogShow2("Wait connect PayPal...", False)
	'parametri_pagamento("youremail@paypalaccount", Starter.descrizione_acquisto ,"1", Starter.prezzo_acquisto, "EUR", "First Name User","Last Name User","Address User", "Zip User", "City User", "email user","phone user ", "city/region/State user")
	'******* 
	'IMPORTANT: CHANGE youremail@paypalaccount with email valid paypal account
	parametri_pagamento("youremail@paypalaccount", Starter.descrizione_acquisto ,1, Starter.prezzo_acquisto, "EUR", "Franco","Rossi","Via Mazzini n.32", "00100", "Rome", "example@gmail.com","+39334445566", "Rome")

End Sub

Sub parametri_pagamento (emailpaypal As String, descrizione As String, numero_articoli As Int , prezzo As Double, valuta As String, nome As String, cognome As String, indirizzo As String , cap As String, citta As String, emailcliente As String, telefonocliente As String, provincia As String )
	'Sostituisco al numero la virgola o il punto con %2e
	Dim modifica_importo As String 
	modifica_importo = prezzo
	modifica_importo = modifica_importo.Replace(".","%2e")
	modifica_importo = modifica_importo.Replace(",","%2e")
	
	Log(modifica_importo)
	
	'Note: transazione_negata.php and transazione_ok.php they are two blank pages
	'Copy transazione_negata.php and transazione_ok.php into your server
	
	WebView1.LoadUrl($"https://www.paypal.com/cgi-bin/webscr?cmd=_xclick
	&business=${emailpaypal}
	&item_name=${descrizione}
	&item_number=${numero_articoli}
	&amount=${modifica_importo}
	&currency_code=${valuta}
	&Ic=IT
	&first_name=${nome}
	&last_name=${cognome}
	&address1=${indirizzo}
	&city=${citta}
	&zip=${cap}
	&email=${emailcliente}
	&state=${provincia}
	&night_phone_b=${telefonocliente}
	&cancel_return=https://www.youraddress.com/transazione_negata.php
	&return=https://www.youraddress.com/transazione_ok.php"$)

End Sub

'Enter otherwise the user goes back and we don't know if the transaction went well
Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	If KeyCode = KeyCodes.KEYCODE_BACK Then
		Return True
	End If
	Return False
End Sub

'The transaction was successful or not
Sub WebView1_PageFinished (Url As String)
	ProgressDialogHide
	Log(Url)
	If Url = "https://www.youraddress.com/transazione_ok.php" Then 
		Starter.ritorno_valore_pagamento = "YES"
		Activity.Finish
	else if Url = "https://www.youraddress.com/transazione_negata.php" Then
		Starter.ritorno_valore_pagamento = "FAILED"
		Activity.Finish
	End If
End Sub


Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


