B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=13.4
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
	
	-Functions Formatar
		* somenteNumeros("R$ 2.500,00") --> "250000"
		* telefone("99999999999") --> (99) 99999-9999
		* cpfCnpj("99999999999") --> "999.999.999-99" ou cpfCnpj("99999999999999") --> "99.999.999/9999-99"
		* cpf("99999999999") --> "999.999.999-99"
		* cnpj("99999999999999") --> "99.999.999/9999-99"
		* cpfSeguro("99999999999") --> "***.999.999-**"
		* valorBR(2500.75) --> "2.500,75"
		* valorDB("2.500,75") --> 2500.75
		* maiusculaInicioFrase("MARIA DA SILVA") --> "Maria da silva"
		* maiusculaInicioFrase("MARIA DA SILVA") --> "Maria Da Silva"
		* removerCaracteresEspeciais("MARIA #@ SILVA") --> "MARIA  SILVA"
		* removerAcentos("JOÃO GONÇALVES") --> "JOAO GONCALVES"
		
	-Functions Validar
		* cpfCnpj("99999999999") --> True ou False
		* cpf("99999999999") --> True ou False
		* cnpj("99999999999999") --> True ou False
		* email("teste@teste.com") --> True ou False
		
	-Functions Data (MM->mes | dd->dia | yyyy->ano 4 digitos | yy->ano 2 digitos | hh->hora | mm->minuto | ss->segundo)
		* data("2025-12-31 00:00:00", "yyyy-MM-dd hh:mm:ss", "dd/MM/yyyy hh:mm:ss") --> "31/12/2025 00:00:00"
		* longData(1767150000000, "dd/MM/yyyy hh:mm:ss") --> "31/12/2025 00:00:00"
		* dataLong("31/12/2025 00:00:00", "dd/MM/yyyy hh:mm:ss") --> 1767150000000
		* dataHoraBR("2025-12-31 00:00:00") --> "31/12/2025 00:00:00"
		* dataHoraDB("31/12/2025 00:00:00") --> "2025-12-31 00:00:00"
		* dataBR("2025-12-31") --> "31/12/2025"
		* dataDB("31/12/2025") --> "2025-12-31"
		* nomeMes("31/12/2025") --> "dezembro"
		* nomeDiaSenama("31/12/2025") --> "quarta-feira"
		
	-Function Extras 
		* UUIDv4
		* Truncate
#End If

Sub Process_Globals
	Public formatar As brFormatar
	Public validar As brValidar
	Public data As brData
	Public extras As brExtras
End Sub
