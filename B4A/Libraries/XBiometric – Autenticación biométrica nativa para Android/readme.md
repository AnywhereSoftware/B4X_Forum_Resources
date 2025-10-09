### XBiometric – Autenticación biométrica nativa para Android by Enxix
### 10/08/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/168949/)

**XBiometric** es una librería desarrollada completamente en **Java nativo** para integrarse fácilmente con **Basic4Android (B4A)**.  
Proporciona una interfaz unificada para el manejo de autenticación biométrica en Android, permitiendo verificar si el dispositivo puede autenticar, si existen huellas registradas, y ejecutar la autenticación del usuario mediante los mecanismos de seguridad disponibles.  
  
[HEADING=2]⚙️ Funciones principales[/HEADING]  
  
🔹 **SePuedeAutenticar**  
  
Verifica si el dispositivo está en condiciones de realizar autenticación biométrica.  
Evalúa el estado del hardware, la configuración de huellas o credenciales y devuelve una constante descriptiva del resultado.  
  

```B4X
If xbio.SePuedeAutenticar = xbio.ERROR_NONE_ENROLLED Then  
    Log("No hay huellas registradas en el dispositivo")  
End If
```

  
  
[HEADING=2]🧱 Constantes disponibles[/HEADING]  
  
[TABLE]  
[TR]  
[TH]Constante[/TH]  
[TH]Descripción[/TH]  
[/TR]  
[TR]  
[TD]ERROR\_HW\_UNAVAILABLE[/TD]  
[TD]El hardware biométrico no está disponible temporalmente (por ejemplo, está ocupado o presenta error).[/TD]  
[/TR]  
[TR]  
[TD]ERROR\_IDENTITY\_CHECK\_NOT\_ACTIVE[/TD]  
[TD]El sistema de identidad no está activo o disponible.[/TD]  
[/TR]  
[TR]  
[TD]ERROR\_NO\_HARDWARE[/TD]  
[TD]El dispositivo no cuenta con sensor biométrico.[/TD]  
[/TR]  
[TR]  
[TD]ERROR\_NONE\_ENROLLED[/TD]  
[TD]No hay huellas ni datos biométricos registrados.[/TD]  
[/TR]  
[TR]  
[TD]ERROR\_NOT\_ENABLED\_FOR\_APPS[/TD]  
[TD]La autenticación biométrica está deshabilitada para las aplicaciones.[/TD]  
[/TR]  
[TR]  
[TD]ERROR\_SECURITY\_UPDATE\_REQUIRED[/TD]  
[TD]Se requiere una actualización de seguridad para utilizar la biometría.[/TD]  
[/TR]  
[TR]  
[TD]NO\_AUTHENTICATION[/TD]  
[TD]No se realizó autenticación o fue cancelada por el usuario.[/TD]  
[/TR]  
[TR]  
[TD]LLAMAR\_A\_AUTENTICAR[/TD]  
[TD]Constante incluida por compatibilidad; no debe usarse directamente. Utilizar siempre el método Autenticar.[/TD]  
[/TR]  
[/TABLE]  
  
  
  
[HEADING=3]🔹 Autenticar[/HEADING]  
Inicia el proceso de autenticación biométrica.  
Muestra el diálogo del sistema para que el usuario se identifique con su **huella digital** o, si no está disponible, mediante el **PIN, patrón o contraseña** del dispositivo.  
  

```B4X
If (disponible= xio.SUCCESS)  Or (disponible = xio.LLAMAR_A_AUTENTICAR)Then     
    xio.Autenticar  
End If
```

  
  
[HEADING=2]🧠 Arquitectura y compatibilidad[/HEADING]  
  
La librería **XBiometric** utiliza directamente las clases nativas de Android:  

- android.hardware.fingerprint.FingerprintManager
- android.hardware.biometrics.BiometricPrompt

No depende de **AndroidX**, lo que la hace **más liviana, directa y totalmente nativa**.  
  
  
📱 **Compatibilidad:**  
  

- **Android 6.0 (API 23)** en adelante.
- Usa FingerprintManager en dispositivos con Android 6–8 (API 23–27).
- Usa BiometricPrompt a partir de Android 9 (API 28+).
- Compatible con autenticación por **huella**, **rostro** y **credenciales del dispositivo** (PIN/patrón/contraseña).

  

---

  
  
[HEADING=2]🚀 Ventajas de XBiometric[/HEADING]  
  

- 100 % **Java nativo**, sin dependencias externas ni AndroidX.
- Compatible con todas las versiones modernas de Android.
- Interfaz simple para **Basic4Android (B4A)**.
- Diseñada para máxima compatibilidad entre versiones de Android.

  
[HEADING=2]🧪 Pruebas y validación[/HEADING]  
  
La librería **XBiometric** fue **testeada y verificada** en los siguientes entornos:  

- ✅ **Android 15 (API 35)** – Funcionamiento completo con autenticación biométrica y credenciales del dispositivo.
- ✅ **Android 10 (API 29)** – Compatibilidad confirmada con huella digital y fallback a PIN/patrón/contraseña.

  
Aún **resta realizar pruebas en versiones anteriores** de Android (6, 7 y 8) que utilizan FingerprintManager.  
Si bien el código está diseñado para soportarlas de forma nativa, estas versiones se encuentran pendientes de validación en dispositivos reales.