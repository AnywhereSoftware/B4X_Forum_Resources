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
Public Sub EncryptPassword(mPassword As String, mAlgorithm As String, mTimeCost As Int, mMemoryCost As Int, mParallelism As Int) As ResumableSub
	Dim pythonCode As String = $"
from passlib.hash import bcrypt, pbkdf2_sha256, argon2, scrypt, sha512_crypt

def hash_password(mPassword: str, mAlgorithm: str, mTimeCost: int, mMemoryCost: int, mParallelism: int):
    if mAlgorithm == 'bcrypt':
        return bcrypt.hash(mPassword)
    elif mAlgorithm == 'pbkdf2':
        return pbkdf2_sha256.hash(mPassword)
    elif mAlgorithm == 'argon2':
        custom_argon2 = argon2.using(time_cost=mTimeCost, memory_cost=mMemoryCost, parallelism=mParallelism)
        return custom_argon2.hash(mPassword)
    elif mAlgorithm == 'scrypt':
        return scrypt.hash(mPassword)
    elif mAlgorithm == 'sha512_crypt':
        return sha512_crypt.hash(mPassword)
    else:
        return 'Unsupported algorithm'

"$
	Dim args As List
	args.Initialize
	args.Add(mPassword)
	args.Add(mAlgorithm)
	args.Add(mTimeCost)
	args.Add(mMemoryCost)
	args.Add(mParallelism)

	Dim wrapper As PyWrapper = B4XPages.MainPage.py.RunCode("hash_password", args, pythonCode)
	Wait For (wrapper.Fetch) Complete (output As PyWrapper)
	Return output.Value
End Sub



' Password verification
Public Sub VerifyPassword(mPassword As String, mHash As String, mAlgorithm As String) As ResumableSub
	Dim pythonCode As String = $"
from passlib.hash import bcrypt, pbkdf2_sha256, argon2
from b4x_bridge.bridge import bridge_instance  # type: ignore

password = '{mPassword}'
hashed = '{mHash}'
algo = '{mAlgorithm}'

def verify_password(password, hashed, algo="bcrypt"):
    try:
        if algo == "bcrypt":
            return bcrypt.verify(password, hashed)
        elif algo == "pbkdf2":
            return pbkdf2_sha256.verify(password, hashed)
        elif algo == "argon2":
            return argon2.verify(password, hashed)
        elif algo == 'scrypt':
            return scrypt.verify(password, hashed)
        elif algo == 'sha512_crypt':
            return sha512_crypt.verify(password, hashed)
        else:
            return False
    except Exception as e:
        bridge_instance.raise_event("passliberror", {"error": f"Error : {e}"})
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
