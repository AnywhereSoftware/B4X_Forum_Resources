B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' pLib.bas
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

' Password hash
Public Sub EncryptPassword(mPassword As String, mAlgorithm As String) As ResumableSub
	Dim pythonCode As String = $"
from passlib.hash import bcrypt, pbkdf2_sha256

args = ["{mPassword}", "{mAlgorithm}"]

def hash_password(password, algo="bcrypt"):
    if algo == "bcrypt":
        return bcrypt.hash(password)
    elif algo == "pbkdf2":
        return pbkdf2_sha256.hash(password)
    else:
        return "Unsupported algorithm"

result = hash_password(args[0], args[1])
"$
	Dim args As List
	args.Initialize
	args.Add(mPassword)
	args.Add(mAlgorithm)

	Dim wrapper As PyWrapper = B4XPages.MainPage.py.RunCode("hash_password", args, pythonCode)
	Wait For (wrapper.Fetch) Complete (output As PyWrapper)
	Return output.Value
End Sub


' Password verification
Public Sub VerifyPassword(mPassword As String, mHash As String, mAlgorithm As String) As ResumableSub
	Dim pythonCode As String = $"
from passlib.hash import bcrypt, pbkdf2_sha256

password = '{mPassword}'
hashed = '{mHash}'
algo = '{mAlgorithm}'

def verify_password(password, hashed, algo="bcrypt"):
    if algo == "bcrypt":
        return bcrypt.verify(password, hashed)
    elif algo == "pbkdf2":
        return pbkdf2_sha256.verify(password, hashed)
    else:
        return False

result = verify_password(password, hashed, algo)
"$
	
	Dim args As List
	args.Initialize
	args.Add(mPassword)
	args.Add(mHash)
	args.Add(mAlgorithm)
	
	Dim wrapper As PyWrapper = B4XPages.MainPage.py.RunCode("verify_password", args, pythonCode)
	Wait For (wrapper.Fetch) Complete (output As PyWrapper)
	Return output.Value
End Sub
