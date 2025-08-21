#pragma once
#include "B4RDefines.h"
#include "mcp_can.h"
#include "mcp_can.h"
//~version: 1.10
//~dependson: <SPI.h>
//~event: DataAvailable(Data() as Byte, ID As Int, Ext as Boolean)
namespace B4R {
	//~shortname: MCP_CAN
			typedef void (*SubByteArrayInt)(Array* barray, int* id, bool* ext) ;
	class B4RMCP_CAN {
		private:      
			uint8_t backend[sizeof(MCP_CAN)];
			PollerNode pnode;
			MCP_CAN* canbus;
			SubByteArrayInt DataSub;
			static void looper(void* b);
		public:
			//Initializes the module. Returns True if successful.
			//DataAvailableSub: The sub to call when data is received
			//SPI_CS_PIN: The CS pin that is connected to can module
			//CanSpeed: Speed of the bus. Lower speed longer reach.
			//Example: <code>
			//If can.Initialize(53, "can_DataAvailable", SPEED_1000KBPS) Then
			//  Log("Init OK")
			//Else
			//  Log("Init ERROR")
			//  Return
			//End If
			//</code>
			bool Initialize(SubByteArrayInt DataSub, int SPI_CS_PIN, byte CanSpeed);
			
			//Sending a "CAN message"
			//ID: Identifier, Max 11 bit = 2047
			//Msg: Array of data to be sent, Max 8 bytes
			//Frame: Set flag extended frame
			//Return true if the message length was valid and it was correctly queued for transmit
			//Example: <code>
			//  	If can.SendMessage(190, "Hi", can.FRAME_STD) Then Log("Sent")
			//</code>
			bool SendMessage(int ID, ArrayByte* Msg, byte Frame);
			
			#define /*Byte SPEED_10KBPS;*/	 		B4RMCP_CAN_SPEED_10KBPS		2
			#define /*Byte SPEED_50KBPS;*/ 			B4RMCP_CAN_SPEED_50KBPS		8
			#define /*Byte SPEED_100KBPS;*/ 		B4RMCP_CAN_SPEED_100KBPS	12
			#define /*Byte SPEED_250KBPS;*/ 		B4RMCP_CAN_SPEED_250KBPS	15
			#define /*Byte SPEED_500KBPS;*/ 		B4RMCP_CAN_SPEED_500KBPS	16
			#define /*Byte SPEED_1000KBPS;*/ 		B4RMCP_CAN_SPEED_1000KBPS	18

			#define /*Byte FRAME_STD;*/ 			B4RMCP_CAN_FRAME_STD		0
			#define /*Byte FRAME_EXT;*/ 			B4RMCP_CAN_FRAME_EXT		1


	};

}