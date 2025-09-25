B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals

End Sub

Public Sub Initialize

End Sub

' Generate a new Fernet key
Public Sub GetKey() As ResumableSub
	Dim pythonCode As String = $"
from cryptography.fernet import Fernet
def generate_key():
    return Fernet.generate_key().decode()
"$
	Dim args As List
	args.Initialize
	Dim wrapper As PyWrapper = B4XPages.MainPage.py.RunCode("generate_key", args, pythonCode)
	Wait For (wrapper.Fetch) Complete (output As PyWrapper)
	Return output.Value
End Sub

 ' Encrypts data
Public Sub Encrypt(mData As String, mKey As String) As ResumableSub
	Dim pythonCode As String = $"
from cryptography.fernet import Fernet
def encrypt_data(mData: str, mKey: str):
    cipher = Fernet(mKey.encode())
    token = cipher.encrypt(mData.encode())
    return token.decode()
"$
	Dim args As List
	args.Initialize
	args.Add(mData)
	args.Add(mKey)
	Dim wrapper As PyWrapper = B4XPages.MainPage.py.RunCode("encrypt_data", args, pythonCode)
	Wait For (wrapper.Fetch) Complete (output As PyWrapper)
	Return output.Value
End Sub

 ' Decrypts the data
Public Sub Decrypt(mData As String, mKey As String) As ResumableSub
	Dim pythonCode As String = $"
from cryptography.fernet import Fernet
from b4x_bridge.bridge import bridge_instance  # type: ignore
def decrypt_data(mData: str, mKey: str):
    try:
        cipher = Fernet(mKey.encode())
        data = cipher.decrypt(mData.encode())
        return data.decode()
    except Exception as e:
        bridge_instance.raise_event('ferneterror', {'error': f'Error : {e}'})
        return ''
"$
	Dim args As List
	args.Initialize
	args.Add(mData)
	args.Add(mKey)
	Dim wrapper As PyWrapper = B4XPages.MainPage.py.RunCode("decrypt_data", args, pythonCode)
	Wait For (wrapper.Fetch) Complete (output As PyWrapper)
	Return output.Value
End Sub
