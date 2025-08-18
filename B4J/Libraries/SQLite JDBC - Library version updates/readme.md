### SQLite JDBC - Library version updates by Claudio Oliveira
### 08/08/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/133792/)

Hi everybody!  
  
This thread is supposed to get all SQLite JDBC library version links together so as to find and download them easier.  
As a heavy B4J+SQLite user, I'm always looking forward to have new JDBC versions.  
All information contained herein has been taken from Mr. Taro L. Saito (xerial), library author, GitHub documentation.  
Thank you [USER=103273]@mcqueccu[/USER], for suggesting the creation of this thread.  
There are earlier versions available. They can be easily found [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/), should you ever need them.  
  
Future versions might be found in additional posts in this thread.  
  
Having this said, let's get to it!  
  
Sqlite-jdbc version 3.25.2 (2018.10.01) available for download **[HERE](https://oss.sonatype.org/content/repositories/releases/org/xerial/sqlite-jdbc/3.25.2/sqlite-jdbc-3.25.2.jar)**  

- Implements UPSERT, ALTER TABLE … RENAME COLUMN and added the Geopoply module.

[INDENT][/INDENT]  
Sqlite-jdbc version 3.27.2 (2019.03.15) available for download [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.27.2/sqlite-jdbc-3.27.2.jar)  

- Upgrade to SQLite 3.27.2

  
Sqlite-jdbc version 3.27.2.1 (2019.03.20) available for download **[HERE](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.27.2.1/sqlite-jdbc-3.27.2.1.jar)**  

- Make smaller the jar size by using -Os compiler option
- Performance improvement for concurrent access.

  
Sqlite-jdbc version 3.28.0 (2019.06.25) available for download [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.28.0/sqlite-jdbc-3.28.0.jar)  

- Upgrade to sqlite 3.28.0

  
Sqlite-jdbc version 3.30.1 (2019.12.23) available for download [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.30.1/sqlite-jdbc-3.30.1.jar)  

- Upgrade to sqlite 3.30.1
- Various fixes

  
  
Sqlite-jdbc version 3.31.1 (2020.05.05) available for download [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.31.1/sqlite-jdbc-3.31.1.jar)  

- Upgrade to sqlite 3.31.1
- Support update/commit/rollback event notifications #350
- Remove sparse index checks #476
- Support alpine linux (Linux-alpine)
- Enabled SQLITE\_ENABLE\_STAT4 flag

  
Sqlite-jdbc version 3.32.3 (2020.06.19) available for download [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.32.3/sqlite-jdbc-3.32.3.jar)  

- Fix multiple CVE reported issues <https://github.com/xerial/sqlite-jdbc/issues/501>

  
Sqlite-jdbc version 3.32.3.1 (2020.07.15) available for download [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.32.3.1/sqlite-jdbc-3.32.3.1.jar)  

- Remove SQLITE\_MAX\_MMAP\_SIZE compile option, which might be causing performance issuess.

  
Sqlite-jdbc version 3.32.3.2 (2020.07.28) available for download [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.32.3.2/sqlite-jdbc-3.32.3.2.jar)  

- Enable SQLITE\_MAX\_MMAP\_SIZE compile option again.
- Fixes issues when using Arm Cortex A8, A9 (32-bit architecture)

[INDENT][/INDENT]  
Sqlite-jdbc version 3.32.3.3 (2020.12.08) available for download [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.32.3.3/sqlite-jdbc-3.32.3.3.jar)  

- Apple Silicon (M1) support

  
Sqlite-jdbc version 3.34.0 (2020.12.10) available for download [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.34.0/sqlite-jdbc-3.34.0.jar)  

- Improved the performance of reading String columns
- Support URI file names (file://…) in backup/restore commands <https://sqlite.org/uri.html>
- Show SQL strings in PreparedStatements.toString()

  
Sqlite-jdbc version 3.35.0 (2021.06.27) available for download [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.35.0/sqlite-jdbc-3.35.0.jar)  

- Don't use 3.35.0 if you are Apple Silicon (M1) user. 3.35.0 failed to include M1 binary

  
Sqlite-jdbc version 3.35.0.1 (2021.06.27) available for download [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.35.0.1/sqlite-jdbc-3.35.0.1.jar)  

- Upgraded to SQLite 3.35.0
- Avoid using slower ByteBuffer decode() method (#575)
- Allow increasing SQLite limits (#568)
- Add Automatic-Module-Name for OSGi (#558
- Avoid using shared resource streams between class loaders when extracting the native library. (#578)
- (Note: Don't use 3.35.0 if you are Apple Silicon (M1) user. 3.35.0 failed to include M1 binary)

Sqlite-jdbc version 3.36.0 (2021.06.27) available for download [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.36.0/sqlite-jdbc-3.36.0.jar)  

- Upgrade to SQLite 3.36.0

  
  
Sqlite-jdbc version 3.36.0.1 (2021.06.30) available for download [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.36.0.1/sqlite-jdbc-3.36.0.1.jar)  

- Fixed a date parsing issue #88
- Added CI for testing JDK16 compatibility. sqlite-jdbc works for JDK8 to JDK16

  
Sqlite-jdbc version 3.36.0.2 (2021.08.25) available for download [**HERE**](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.36.0.2/sqlite-jdbc-3.36.0.2.jar)  

- **Newly Supported OS and Arch**

- Support custom collation creation (#627)
- Newly Supported OS and Arch
- Windows armv7 and arm64 (e.g., Surface Pro X) (#644)
- FreeBSD aarch64 (#642)
- Bring back Linux armv6 support (#628)
- FreeBSD x86 and x86\_64 (#639)
- Dropped DragonFlyBSD support (#641)

- **Other Intenal Fixes**

- Add reflect-config, jni-config and native-image.properties to graalvm native image compilation (#631)
- Fix multipleClassLoader test when directory is renamed (#647)
- CI tests for Windows and MacOS (#645)

Sqlite-jdbc version 3.39.2.0 (2021.08.25) available for download [**HERE**](https://github.com/xerial/sqlite-jdbc/releases/download/3.39.2.0/sqlite-jdbc-3.39.2.0.jar)