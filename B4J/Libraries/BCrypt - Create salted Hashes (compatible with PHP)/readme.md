### BCrypt - Create salted Hashes (compatible with PHP) by DonManfred
### 10/04/2019
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/110180/)

Based on this Maven repository:  
<https://mvnrepository.com/artifact/org.mindrot/jbcrypt/0.4>  
  
**bcrypt**  
*/\*\*  
 BCrypt implements OpenBSD-style Blowfish password hashing using  
 the scheme described in "A Future-Adaptable Password Scheme" by  
 Niels Provos and David Mazieres.  
 This password hashing system tries to thwart off-line password  
 cracking using a computationally-intensive hashing algorithm,  
 based on Bruce Schneier's Blowfish cipher. The work factor of  
 the algorithm is parameterised, so it can be increased as  
 computers get faster.  
 Usage is really simple. To hash a password for the first time,  
 call the hashpw method with a random salt*  
**Author:** DonManfred  
**Version:** 0.01  

- **BCrypt**

- **Functions:**

- **checkpw** (plaintext As String, hashed As String) As Boolean
*Check that a plaintext password matches a previously hashed  
 one  
plaintext: the plaintext password to verify  
hashed: the previously-hashed password  
Return type: @return:true if the passwords match, false otherwise*- **gensalt** As String
*Generate a salt for use with the BCrypt.hashpw() method,  
 selecting a reasonable default for the number of hashing  
 rounds to apply  
 returns an encoded salt value*- **gensalt2** (log\_rounds As Int) As String
*Generate a salt for use with the BCrypt.hashpw() method  
 log\_rounds the log2 of the number of rounds of  
 hashing to apply - the work factor therefore increases as  
 2\*\*log\_rounds.  
 returns an encoded salt value*- **gensalt3** (log\_rounds As Int, random As java.security.SecureRandom) As String
*Generate a salt for use with the BCrypt.hashpw() method  
 log\_rounds the log2 of the number of rounds of  
 hashing to apply - the work factor therefore increases as  
 2\*\*log\_rounds.  
 random an instance of SecureRandom to use  
 returns an encoded salt value*- **hashpw** (password As String, salt As String) As String
*Hash a password using the OpenBSD bcrypt scheme  
 password the password to hash  
 salt the salt to hash with (perhaps generated  
 using BCrypt.gensalt)  
 returns the hashed password*- **Initialize** (EventName As String)

  

```B4X
    Dim bc As BCrypt  
    Dim hash As String = bc.hashpw("Test",bc.gensalt)  
    Log(hash) ' $2a$10$2OA3heI7jImo7SFlFrfSK.9z6K7fF3Ny3vw3CZ3u24QvkRDSPYE6u
```

  
I tried the generated hash with PHP. password\_verify returns TRUE  
  
[PHP]$pw = "$2a$10$2OA3heI7jImo7SFlFrfSK.9z6K7fF3Ny3vw3CZ3u24QvkRDSPYE6u";  
if (password\_verify("Test",$pw) == true){  
 echo "password\_verify returns TRUE";  
} else {  
 echo "password\_verify returns FALSE";  
}[/PHP]