B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@


Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	Public QRBuffer(5000) As Byte
	Public QRCodeSize As Int
	Public QRCodeText(100) As Byte
	Private PixelSize As Int =3
	Public bc As ByteConverter
End Sub

Public Sub DisplayQR

	Dim APName As String=JoinStrings(Array As String("ESP32",bc.StringFromBytes(StartAccessPoint.APNameAdd)))
	
	Dim QRWifi As String=JoinStrings(Array As String("WIFI:T:WPA;S:",APName,";P:",bc.StringFromBytes(StartAccessPoint.APWiFiPassword),";;"))
	Log("Wifi-QR: ",QRWifi)
	bc.ArrayCopy2(QRWifi,0,QRCodeText,0,QRWifi.Length)
	
	RunNative("DisplayQRCode", Null)
	Log("QRCode size: ",QRCodeSize)
	
	Display.DrawRectangle(0,0,185,180,65535) 'RGB colours as integer
	
	Dim yLine As Int
	For y=0 To QRCodeSize*QRCodeSize-1 Step QRCodeSize
		For x=0 To QRCodeSize-1
			'Log(y,"/",x)
			Display.DrawRectangle(5+x*PixelSize,5+yLine*PixelSize,PixelSize,PixelSize,65535) 'white
			If QRBuffer(y+x)=255 Then 
				Display.DrawRectangle(5+x*PixelSize,5+yLine*PixelSize,PixelSize,PixelSize,0) 'black
			End If
		Next
		yLine=yLine+1
	Next

End Sub

#if c
#include "qrcode2.h"

void DisplayQRCode (B4R::Object* o) {

QRCode qrcode;
    uint8_t qrcodeData[qrcode_getBufferSize(10)];
    qrcode_initText(&qrcode, qrcodeData, 10, ECC_QUARTILE, (const char*)b4r_displayqrcode::_qrcodetext->data);
  	
  	b4r_displayqrcode::_qrcodesize = qrcode.size;
  
   
	Int i=0;

    for (uint8_t y = 0; y < qrcode.size; y++) {

         // Each horizontal module
        for (uint8_t x = 0; x < qrcode.size; x++) {

            // Print each module (UTF-8 \u2588 is a solid block)
            //Serial.print(qrcode_getModule(&qrcode, x, y) ? "\u2588\u2588": "  ");
			Serial.print(qrcode_getModule(&qrcode, x, y));
			if(qrcode_getModule(&qrcode, x, y)==true)
			{
				((byte*)b4r_displayqrcode::_qrbuffer->data)[i]=B11111111;
			}
			else
			{
				((byte*)b4r_displayqrcode::_qrbuffer->data)[i]=B0;
			}			
			i++;
        }

    }

}



#End If