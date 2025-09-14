###  BR_FunctionsUtils, BR Functions Utils by Lucas Siqueira
### 09/11/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/168398/)

Functions created by Brazilians that can be useful for everyone.  
  
**BR\_FunctionsUtils  
Autor: Lucas Siqueira  
Versão: 1.0**  
  
V1.00  
 -Release  
   
  **-Funções Formatar**  
 \* somenteNumeros("R$ 2.500,00") –> "250000"  
 \* telefone("99999999999") –> (99) 99999-9999  
 \* cpfCnpj("99999999999") –> "999.999.999-99" ou cpfCnpj("99999999999999") –> "99.999.999/9999-99"  
 \* cpf("99999999999") –> "999.999.999-99"  
 \* cnpj("99999999999999") –> "99.999.999/9999-99"  
 \* cpfSeguro("99999999999") –> "\*\*\*.999.999-\*\*"  
 \* valorBR(2500,75) –> "2.500,75"  
 \* valorDB("2.500,75") –> 2500,75  
 \* maiusculaInicioFrase("MARIA DA SILVA") –> "Maria da silva"  
 \* maiusculaInicioFrase("MARIA DA SILVA") –> "Maria Da Silva"  
 \* removeCaracteresEspeciais("MARIA #@ SILVA") –> "MARIA SILVA"  
 \* removeAcentos("JOÃO GONÇALVES") –> "JOÃO GONÇALVES"  
   
 **-Funções Validar**  
 \* cpfCnpj("99999999999") –> Verdadeiro ou Falso  
 \* cpf("99999999999") –> Verdadeiro ou Falso  
 \* cnpj("99999999999999") –> Verdadeiro ou Falso  
 \* email(" [EMAIL]teste@teste.com[/EMAIL] ") –> Verdadeiro ou Falso  
   
  **-Funções** Dados (MM->mes | dd->dia | aaaa->ano 4 dígitos | yy->ano 2 dígitos | hh->hora | mm->minuto | ss->segundo)  
 \* dados("2025-12-31 00:00:00", "aaaa-MM-dd hh:mm:ss", "dd/MM/aaaa hh:mm:ss") –> "31/12/2025 00:00:00"  
 \* longData(1767150000000, "dd/MM/aaaa hh:mm:ss") –> "31/12/2025 00:00:00"  
 \* dataLong("31/12/2025 00:00:00", "dd/MM/aaaa hh:mm:ss") –> 1767150000000  
 \* dataHoraBR("2025-12-31 00:00:00") –> "31/12/2025 00:00:00"  
 \* dataHoraDB("31/12/2025 00:00:00") –> "2025-12-31 00:00:00"  
 \* dataBR("2025-12-31") –> "31/12/2025"  
 \* dataDB("31/12/2025") –> "2025-12-31"  
 \* nomeMes("31/12/2025") –> "dezembro"  
 \* nomeDiaSenama("31/12/2025") –> "quarta-feira"  
   
 **-Extras de função**   
 \* UUIDv4  
 \* Truncar