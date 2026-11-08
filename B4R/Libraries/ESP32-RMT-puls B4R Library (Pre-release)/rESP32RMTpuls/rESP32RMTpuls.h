
#pragma once
#include "B4RDefines.h"
#include "driver/rmt_tx.h"
#include <stdio.h>

// This def block may need correction & add for other soc
#if (CONFIG_IDF_TARGET_ESP32)
  #define MAX_SYMBOLS 64
  #define MAX_TX_CHANNELS 8
  #define CURRENT_SOC "ESP32"
#elif (CONFIG_IDF_TARGET_ESP32S3)
  #define MAX_SYMBOLS 48
  #define MAX_TX_CHANNELS 4
  #define CURRENT_SOC "ESP32s3"
#elif (CONFIG_IDF_TARGET_ESP32C3 || CONFIG_IDF_TARGET_ESP32C6 || CONFIG_IDF_TARGET_ESP32H2)
  #define MAX_SYMBOLS 48
  #define MAX_TX_CHANNELS 2
  #define CURRENT_SOC "ESP32c3"
#else
  #define MAX_SYMBOLS 48
  #define MAX_TX_CHANNELS 4
  #define CURRENT_SOC "ESP32xx"
#endif


//
//   B4R Library to produce pulse signals with ESP32 RMT module. Using ESP32 IDF API driver rmt_tx.h 
//   Refer documentation and example files.
//   Use ChannelConfig() to setup the RMT TX channels.
//   Then send the pulse with with eg. TXpuls_us, TXpuls_ms, TXpuls_s, TXpuls_prd or TXpulsTrain.
//   SOC variants have different number of channels. eg. ESP32 has 8, ESP32-S3 has 4, ESP32-C3 has 2.
//   Dependencies: ESP-IDF V5.2+
namespace B4R {

//~Build: 20250801
//~shortname: ESP32RMTpuls
//~version: 0.90
   class B4RESP32RMTpuls {
      
      private:
         static rmt_channel_handle_t tx_channel[MAX_TX_CHANNELS];
         static rmt_encoder_handle_t copy_encoder;
        
      public:

         /**
         * Setup RMT Channel 
         * <code> 'Example: 
         * RMT.channelConfig (Ch0, P2, False)) '(RMT TX_channel,  GPIO pin, Invert)
         * </code>
         */         
          int ChannelConfig(byte Tx_ch, byte GPIO_n, bool Inv_out);


         /**
         * Send TX Pulse on Channel n in microseconds (µs)
         * Loop_cnt is a multiplier,  0 or 1 = 1*PW_us.  2 = 2*PW_us.  -1 = indefinitly*PW_us
         * <code> 'Example: 
         * RMT.TXpuls_us(Ch0, 10000, 0)  ' (channel n, PulseWidth us, loop) 10ms pulse
         * ' PW_us Max. = 48*65534, Loop_cnt Max. = 1000, resolution = 1us
         * </code>
         */      
         int TXpuls_us(byte Tx_ch, ULong PW_us, int Loop_cnt);


         /**
         * Send TX Pulse on Channel n  in milliseconds (ms)
         * Loop_cnt is a multiplier,  0 or 1 = 1*PW_ms.  2 = 2*PW_ms.  -1 = indefinitly*PW_ms
         * <code> 'Example: 
         * RMT.TXpuls_ms(Ch0, 10, 0)  ' (channel n, PulseWidth ms, loop) 10ms pulse
         * ' PW_ms Max. = 48*65, Loop_cnt Max. = 1000, resolution = 1000us
         * </code>
         */               
         int TXpuls_ms(byte Tx_ch, ULong PW_ms, int Loop_cnt);

        
         /**
         * Send TX Pulse on Channel n  in seconds (s)
         * Loop_cnt is a multiplier,  0 or 1 = 1*PW_s.  2 = 2*PW_s.  -1 = indefinitly*PW_s
         * <code> 'Example: 
         * RMT.TXpuls_ms(Ch0, 10, 0)  ' (channel n, PulseWidth ms, loop) 10ms pulse
         * ' PW_ms Max. = 48*65, Loop_cnt Max. = 1000, resolution = 1000us
         * </code>
         */
        int TXpuls_s(byte Tx_ch, ULong PW_s);

        
        /**
         * Send TX Pulse with period on Channel n  in microseconds (us)
         * Loop_cnt is a multiplier,  0 or 1 = 1*PW_us.  2 = 2*PW_us.  -1 = indefinitly*PW_us
         * <code> 'Example: 
         * RMT.TXpuls_PRD(Ch0, 1000, 2000, 10)  ' (channel n, PulseWidth us, PulsePeriod us, loop) 1ms pulse/2ms period, x10 
         * ' PW_us Max. = 48*65534, Loop_cnt Max. = 1000, resolution = 1000us
         * </code>
         */
        int TXpuls_prd(byte Tx_ch, ULong PW_us, ULong PRD_us, int Loop_cnt);


         /**
         * Send TX Pulse Train on Channel n  in microseconds (µs)
         * Loop_cnt is a multiplier,  0 or 1 = 1*PW_us.  2 = 2*PW_us.  -1 = indefinitly*PW_us
         * <code> 'Example: 
         * RMT.TXpulsTrain(Ch0, 10000, 20000, 48, 0)  ' (channel n, PulseWidth us,  Period us,  Num of pulse,  loop) 20ms period (50hz)
         * ' Period Max. = 65534,  PulseWidth Max = Period,  Loop_cnt Max. = 1000,  resolution = 1000µs
         * </code>
         */               
         int TXpulsTrain(byte Tx_ch, ULong PW_us, ULong Prd_us, byte Puls_n, int Loop_cnt);

         
         /**
         * Apply PWM to TX Pulse on Channel n. [Frequency, Duty%]  
         * This will modulate the pulse with carrier, eg. to adjust intensity.
         * <code> 'Example: 
         * RMT.PWMmod(Ch0, 30000, 480)  ' (channel n, Frequency hz,  Duty Percent) 30khz, 48% duty         
         * ' Frequency Max. = 20mhz,  Duty = 1 to 1000% (0 = disable Modulation)
         * </code>
         */               
         int PWMmod(byte Tx_ch, ULong Freq_hz, UInt Duty_val);
         
         
         /**
         * Configure and apply sync to RMT channel group.
         * - Channels listed in `tx_channels` will have synchronized start.
         * - Must call this *immediately before* triggering the first channel in the sync group.
         * - Do not transmit on unrelated channels between `SYNC_ch()` and the last group TX start,
         *   as they may be inadvertently included in the sync group (ESP-IDF behavior).
         * - Call again before each new sync group TX to rearm the sync manager.
         *
         * <code> 'Example: 
         * Private RMTsync_ch() As Byte
         * RMTsync_ch = Array As Byte(0,  1) ' channels to include in sync
         * RMT.SYNC_ch(RMTsync_ch,  2,  True)
         * </code>
         * - tx_channels  {byte array} of channel indices (e.g., [0,1])
         * - numof_ch     {byte} Number of channels in tx_channels[]
         * - SYNC_en      {bool} True to enable sync, False to delete current sync manager
         */
         int SYNC_ch(ArrayByte* tx_channels, byte numof_ch, bool SYNC_en);

         /**
         * Switch RMT out to another GPIO n 
         * <code> 'Example: 
         * SwitchGPIO(0, 2, 3, False)  '( ch 0, discon. GPIO 2, con. GPIO 3, no invert)
         * SwitchGPIO(0, -1, 3, False)  '( ch 0, --, con. GPIO 3, no invert)
         * </code>
         * - Tx_ch    {byte} RMT channel to apply
         * - GPIO_dis {int}  Disconnect GPIO pin  from RMT ch (-1 for no action)
         * - GPIO_con {int}  Connect GPIO pin to RMT ch (-1 for no action)
         * - Inv_out  {bool} True to invert output  
         */               
         int SwitchGPIO(byte Tx_ch, int GPIO_dis, int GPIO_con, bool Inv_out);

         
         /**
         * Invert RMT out for GPIO n  (at point when set)
         * Using gpio_matrix_out macro
         * <code> 'Example: 
         * InvOut(P2, True) ' (GPIO n, Inv_out)  invert RMT ch0 on GPIO2 pin.
         * </code>
         */               
         void InvOut(byte GPIO_n, bool Inv_out);


         /**
         * Stop RMT Loop - Use to stop a long or indefinite loop.
         * Need to call channelConfig before send a new puls on same ch.
         * <code> 'Example: 
         * StopLoop(ch0) ' (Tx_ch)  Stop RMT Loop.
         * </code>
         */            
         void StopPuls(byte Tx_ch);

     
         /**
         * Delete RMT Channel config 
         * <code> 'Example: 
         * ChannelDel(ch0) ' (Tx_ch)  Delete RMT Channel.
         * </code>
         */   
         void ChannelDelete(byte Tx_ch);
         
   };
}
