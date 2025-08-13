#pragma once
#include "B4RDefines.h"
#include "CAN.h"

//~version: 1.12
//~event: DataAvailable(Data() as Byte)
namespace B4R {
	//~shortname: CAN
			typedef void (*SubByteArray)(Array* barray) ;
	class B4RCAN {
		private:
			SubByteArray DataAvailableSub;
			static void looper(void* b);
		public:
			//Initializes the module. Returns True if successful.
			//DataAvailableSub: The sub to call when data is received
			//PinR: Using MCP2515 this is the CS pin.	Using ESP32 this is the RX pin. 
			//PinT: Using MCP2515 this must be Null.	Using ESP32 this is the TX pin. 
			//CanSpeed: Speed of the bus. Lower speed longer reach.
			//Example: <code>
			//If can.Initialize("can_DataAvailable", 53, Null, SPEED_1000KBPS) Then
			//  Log("Init OK")
			//Else
			//  Log("Init ERROR")
			//End If
			//</code>
			bool Initialize(SubByteArray DataAvailableSub, int PinR, int PinT, long CanSpeed);

			//Sending a standard CAN message
			//ID: MessageId, Max 11 bit = 2047
			//Msg: Array of data to be sent, Max 8 bytes
			//Example: <code>
			//	can.SendMessage(190, "Hi")
			//</code>
			void SendMessage(int ID, ArrayByte* Msg);

			//Sending an extended CAN message
			//ID: MessageId, Max 29 bit = 536870911
			//Msg: Array of data to be sent, Max 8 bytes
			//Example: <code>
			//	can.SendMessage(190, "Hi")
			//</code>
			void SendMessageExtended(long ID, ArrayByte* Msg);
			
			//Returns the MessageId of the last received message
			//Example: <code>
			//	Log("ID: ", can.MessageId")
			//</code>
			long MessageId();
			
			//Returns true if the MessageId of the last received message is extended
			//Example: <code>
			//	Log("isExtendedId: ", can.isExtendedId")
			//</code>
			bool isExtendedId();

			#define /*Long SPEED_10KBPS;*/	 		B4RCAN_SPEED_10KBPS		10000
			#define /*Long SPEED_50KBPS;*/ 			B4RCAN_SPEED_50KBPS		50000
			#define /*Long SPEED_100KBPS;*/ 		B4RCAN_SPEED_100KBPS	100000
			#define /*Long SPEED_125KBPS;*/ 		B4RCAN_SPEED_125KBPS	125000
			#define /*Long SPEED_250KBPS;*/ 		B4RCAN_SPEED_250KBPS	250000
			#define /*Long SPEED_500KBPS;*/ 		B4RCAN_SPEED_500KBPS	500000
			#define /*Long SPEED_1000KBPS;*/ 		B4RCAN_SPEED_1000KBPS	1000000
	};

}