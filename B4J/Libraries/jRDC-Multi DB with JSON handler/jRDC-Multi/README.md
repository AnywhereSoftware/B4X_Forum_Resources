# **Servidor jRDC2-Multi Mod (B4J)**

## **1\. Introducción**

Este proyecto es una versión modificada del servidor [jRDC2 original](https://www.b4x.com/android/forum/threads/b4x-jrdc2-b4j-implementation-of-rdc-remote-database-connector.61801/#content), diseñada para actuar como un backend robusto y flexible. Su función principal es recibir peticiones HTTP, ejecutar comandos SQL predefinidos contra una base de datos y devolver los resultados en un formato estructurado.

Ha sido adaptado para servir tanto a clientes nativos (`B4A/B4i`) como a clientes web modernos (`JavaScript`, a través de frameworks como `NodeJS, React, Vue, Angular, etc`.).

## **2\. Características Principales**

- **Soporte para Múltiples Bases de Datos**: Puede cargar y gestionar hasta 4 archivos de configuración (`config.properties`) simultáneamente.
- **Comandos SQL Externalizados**: Las sentencias SQL se definen en los archivos de configuración, permitiendo modificarlas sin recompilar el servidor.
- **Doble Handler de Peticiones**: Incluye un handler clásico para clientes B4X y un handler JSON para clientes web.
- **Validaciones de Seguridad**: Verifica la existencia de comandos y la correspondencia en el número de parámetros.
- **Administración Remota**: Permite verificar el estado, recargar la configuración y reiniciar el servidor a través de URLs específicas.

## **3\. Configuración**

### **3.1. Archivos de Configuración**

El sistema está preparado para manejar hasta **cuatro configuraciones de bases de datos** (de `DB1` a `DB4`). No es necesario tener los cuatro archivos; el servidor cargará únicamente los que encuentre.

La nomenclatura de los archivos es fundamental:

- `config.properties` (para `DB1`)
- `config.DB2.properties`
- `config.DB3.properties`
- `config.DB4.properties`

**Notas importantes:**

- El **puerto** del servidor se toma **únicamente** del archivo principal `config.properties`, sin importar lo que digan los demás.
- Los datos de conexión (`JdbcUrl`, `usuario`, `contraseña`) sí se toman del archivo correspondiente a cada base de datos.

### **3.2. Añadir Drivers de Bases de Datos Adicionales**

Si necesitas conectarte a otros tipos de bases de datos (ej. Oracle), debes agregar el archivo del controlador .jar al proyecto antes de compilar. En el módulo `Main`, añade una línea como la siguiente:

```b4x
' Este es el nombre del archivo .jar, en este caso "C:\\Ruta\\LibsAdicionales\\ojdbc11.jar"
#AdditionalJar: ojdbc11
```

Al compilar, el driver se incluirá en el `.jar` final del servidor, por lo que no será necesario copiarlo por separado al directorio de producción.

## **4\. Uso del Handler Clásico (Para Clientes B4X)**

Este handler mantiene la compatibilidad con `DBRequestManager`. La selección de la base de datos se realiza dinámicamente a través de la URL.

- Para `config.properties` \=\> `http://tu-dominio.com:8090`
- Para `config.DB2.properties` \=\> `http://tu-dominio.com:8090/DB2`
- Para `config.DB3.properties` \=\> `http://tu-dominio.com:8090/DB3`
- Para `config.DB4.properties` \=\> `http://tu-dominio.com:8090/DB4`

## **5\. Uso del DBHandlerJSON (Para Clientes Web)**

Este handler está diseñado para clientes que se comunican vía `JSON`, como aplicaciones web JavaScript.

### **5.1. Endpoint y Métodos de Envío**

Las peticiones van dirigidas al endpoint `/DBJ`. El handler es flexible y acepta datos de dos maneras:

**Método Recomendado: POST con Body JSON**

Esta es la forma más limpia y estándar para las APIs modernas.

- **Método HTTP**: POST
- **URL**: http://tu-dominio.com:8090/DBJ
- **Header Requerido**: Content-Type: application/json
- **Body (Payload)**: El objeto JSON se envía directamente en el cuerpo de la petición.

**Ejemplo de Body:**

```
{
  "dbx": "DB2",
  "query": "get\_user",
  "exec": "executeQuery",
  "params": {
    "par1": "CDAZA"
  }
}
```

**Método Legacy: GET con Parámetro `j`**

Este método se mantiene por retrocompatibilidad.

- **Método HTTP**: GET (o POST con Content-Type: application/x-www-form-urlencoded)
- **URL**: El JSON completo se envía como el valor del parámetro `j` en la URL.

Ejemplo con GET:  
http://tu-dominio.com:8090/DBJ?j={"dbx":"DB2","query":"get\_user","exec":"executeQuery","params":{"par1":"CDAZA"}}

### **5.2. Formato del Payload JSON**

La estructura del objeto JSON es la misma para ambos métodos:

```
{
  "exec": "executeQuery",
  "query": "nombre\_del\_comando\_sql",
  "dbx": "DB1",
  "params": {
    "par1": "valor1",
    "par2": 123
  }
}
```

- `exec`: `"executeQuery"` (para SELECT) o `"executeCommand"` (para INSERT, UPDATE, DELETE).
- `query`: Nombre del comando SQL tal como está definido en el archivo de configuración (ej. `select\_user`).
- `dbx` (opcional): La llave de la base de datos (`DB1`, `DB2`, etc.). Si se omite, se usará **DB1** por defecto.
- `params` (opcional): Un objeto que contiene los parámetros para la consulta SQL.

### **5.3. ¡Importante\! Envío de Parámetros**

El servidor ordena las claves de los parámetros alfabéticamente antes de pasarlos a la consulta SQL. Para asegurar que los valores se asignen al `?` correcto, **debes nombrar las claves de los parámetros de forma secuencial**: `"par1"`, `"par2"`, `"par3"`, etc.

**Nota para más de 9 parámetros**: Si tienes 10 o más parámetros, usa un cero inicial para mantener el orden alfabético correcto (ej. `"par01"`, `"par02"`, ..., `"par10"`).

### **5.4. Respuestas JSON**

Las respuestas del servidor siempre son en formato JSON e incluyen un campo booleano `success`.

- **Si success es true**, los datos se encontrarán en la llave `result`.
- **Si success es false**, el mensaje de error se encontrará en la llave `error`.

## **6\. Administración del Servidor**

Se pueden ejecutar comandos de gestión directamente desde un navegador o una herramienta como cURL.

- **Verificar Estado**: `http://tu-dominio.com:8090/test`
- **Recargar Configuración**: `http://tu-dominio.com:8090/manager?command=reload` (Vuelve a leer todos los archivos `config.\*.properties` sin reiniciar el servidor).
- **Reiniciar Servidor (Estándar)**: `http://tu-dominio.com:8090/manager?command=rsx` (Ejecuta los scripts `start.bat`, `start2.bat` y `stop.bat`).
- **Reiniciar Servidor (con PM2)**: `http://tu-dominio.com:8090/manager?command=rpm2` (Ejecuta `reiniciaProcesoPM2.bat` y asume que el nombre del proceso es "RDC-Multi". Modificar el `.bat` si el nombre es diferente).
