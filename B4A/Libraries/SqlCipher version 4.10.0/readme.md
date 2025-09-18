### SqlCipher version 4.10.0 by Enxix
### 09/17/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/168668/)

Hola, debido a los problemas que encontré con Google y SQLCipher, decidí actualizar la librería a la versión 4.10.0.  
Usé un envoltorio de Erel y ajusté las referencias a la nueva versión.  
  
**Por favor, notifiquen cualquier error. Probé parte de la librería; el ámbito de prueba fue en Android 15 (dispositivo real). Si tienen problemas de artefactos o referencias, verifiquen primero en el foro la solución antes de reportar el error.**  
Traté de mantener los nombres de los métodos iguales. Solo cambié **SqlCipher** a **SqlCipherB4A** (nombre de la clase).  
  
En el envoltorio, Erel extiende la clase SQLCipher de SQL. Yo eliminé esa extensión.  
Adjunto los archivos (.aar) y las librerías.  
  

---

  
  
Hello, due to the issues I encountered with Google and SQLCipher, I decided to update the library to version 4.10.0.  
I used Erel’s wrapper and adjusted the references to the new version.  
  
**Please report any errors. I tested part of the library; the testing scope was Android 15 (real device). If you encounter issues with artifacts or references, please check the forum for a solution before reporting the error.**  
I tried to keep the method names the same. I only changed **SqlCipher** to **SqlCipherB4A** (class name).  
  
In the wrapper, Erel extends the SQLCipher class from SQL. I removed that extension.  
I am attaching the (.aar) files and the libraries.  
  

---

  
[AAR LIB Adicionales](https://www.mediafire.com/file/ltjkzma0a9j5hhf/aarlib.zip/file)  
  

```B4X
#AdditionalJar: sqlite-2.4.0.aar  
#AdditionalJar: sqlcipher-android-4.10.0.aar
```