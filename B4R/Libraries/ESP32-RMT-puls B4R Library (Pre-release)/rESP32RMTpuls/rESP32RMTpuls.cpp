/*   ----------========= PRELIMINARY ===========------------
 B4R Library to generate Pulse signals with ESP32 RMT peripheral module. Using ESP32 IDF driver.
     Version 0.90   2025.07.07 - 2025.08.04  ToniG
     Requires: ESP-IDF V5.2+

     RMT resolution is set = 1us (min pulse width. 
     Clock source is APB_CLK(80mhz) Set for PWM carrier period calc.
     
     TooDoo:
            1. TXpulsTrain test full buffer + looping - done.
            2. Document return values (& review)
            3. apply 'esp_err_t err =' to IDF func calls  where applicable.
            4. Fix/Test ChannelDelete


Note: This program is NOT fully tested for SOC variants & IDF versions, expect some issues (& please feedback)

*/
#pragma once
#include "B4RDefines.h"
#include "esp_check.h"
#include <rom/gpio.h>
#include "soc/gpio_struct.h"
#include "soc/rmt_reg.h"
#include "esp_err.h"

//#define DEBUG_LOG // Enable/Disable debug logging (!this will add big delays)

namespace B4R 
{

#define RMT_DUR_MAX 32767
#define LOOP_MAX 1023
#define BUFFER_MAX_VAL (RMT_DUR_MAX * 2) * (MAX_SYMBOLS-1) // (last symbol reserved for looping)
#define CLR_SYMBOLS true           // clear remaining symbols after data

rmt_channel_handle_t B4RESP32RMTpuls::tx_channel[MAX_TX_CHANNELS] = {NULL};
rmt_encoder_handle_t B4RESP32RMTpuls::copy_encoder = NULL;


   int B4RESP32RMTpuls::ChannelConfig(byte Tx_ch, byte GPIO_n, bool Inv_out) 
   {   int err = 0;   
       if (Tx_ch > MAX_TX_CHANNELS) 
          {::Serial.println("Error - Channel num > MAX_TX_CHANNELS"); err = 1;
          return err;
          }

       rmt_tx_channel_config_t tx_chan_config = {
           .gpio_num = (gpio_num_t)GPIO_n,
           .clk_src = RMT_CLK_SRC_APB, //RMT_CLK_SRC_DEFAULT,
           .resolution_hz = 1e6,  
           .mem_block_symbols = MAX_SYMBOLS,
           .trans_queue_depth = 4,
           .flags = {.invert_out = Inv_out}
       };
       
       ESP_ERROR_CHECK(rmt_new_tx_channel(&tx_chan_config, &tx_channel[Tx_ch]));
//     No encoding, we just use raw memory block symbols
       rmt_copy_encoder_config_t copy_encoder_config = {};
       ESP_ERROR_CHECK(rmt_new_copy_encoder(&copy_encoder_config, &copy_encoder));
       
       ESP_ERROR_CHECK(rmt_enable(tx_channel[Tx_ch]));  
       return err;
   }
//===================================================

//      --== TX Pulse_Period ==--
   int B4RESP32RMTpuls::TXpuls_prd(byte Tx_ch, ULong PW_us, ULong PRD_us, int Loop_cnt)
   {
       int err = 0;   
       if (Tx_ch > MAX_TX_CHANNELS) 
          {::Serial.println("Error - TXpuls_prd: Channel num > MAX_TX_CHANNELS"); err = 1;
          return err;
          }
 
       if (PW_us > BUFFER_MAX_VAL) {PW_us = BUFFER_MAX_VAL; err = 2;}
       if (PRD_us > BUFFER_MAX_VAL) {PRD_us = BUFFER_MAX_VAL; err = 3;}
       if (Loop_cnt > LOOP_MAX) {Loop_cnt = LOOP_MAX; err = 4;}

       static rmt_symbol_word_t symbols[MAX_SYMBOLS];
       uint32_t Debug_1 = 0;
       bool flag_clrALL = CLR_SYMBOLS;

       bool use_PRD = (PRD_us > PW_us);                  //flag enable period set
       bool loop_en = (Loop_cnt > 1 || Loop_cnt == -1); // 0 or 1 = no loop

       uint32_t rem_pw = PW_us;
       uint32_t rem_prd = PRD_us > PW_us ? PRD_us - PW_us : PRD_us = 0; //using ternary if to set var. 
   //                        logic       ?    if true     : if false;   
#ifdef DEBUG_LOG
    ::Serial.printf("TXpuls_prd: Write to RMT RAM buffer Tx_ch=%d PW_us=%d PRD_us=%d Loop_cnt=%d +",
                     Tx_ch, PW_us, PRD_us, Loop_cnt);
#endif
       for (uint8_t i = 0; i < MAX_SYMBOLS; ++i)
       {
           uint16_t dur0 = 0, dur1 = 0, dur_end;
           bool lvl0 = 0, lvl1 = 0;

           if (rem_pw > 0) //         Puls data
           {   lvl0 = 1; lvl1 = 1;
               // Extract val from rem_pw
               dur0 = (rem_pw > RMT_DUR_MAX) ? RMT_DUR_MAX : rem_pw; 
               rem_pw -= dur0; //< whittle down
               dur1 = (rem_pw > RMT_DUR_MAX) ? RMT_DUR_MAX : rem_pw;
               rem_pw -= dur1;

               // End of puls data
               if (rem_pw == 0 && dur1 == 0)
               {  dur1 = 1; lvl1 = 0;              //< for use_PRD
                  if (rem_prd > 2) {rem_prd-=1;}   // subtract the 1 added to dur1 for prd
                  if(!use_PRD && !loop_en) {dur1 = 0; lvl1 = 0;}
                  if(!use_PRD && loop_en)  {dur1 = 1; lvl1 = 1; dur0 = dur0 > 1 ? dur0-=1 : dur0 = dur0;}
                  dur_end = 0;
               }
           }     
                 // Extract val from rem_prd
           else if (use_PRD && rem_prd > 0) //  Period data
           {   lvl0 = 0; lvl1 = 0;
               dur0 = (rem_prd > RMT_DUR_MAX) ? RMT_DUR_MAX : rem_prd;
               rem_prd -= dur0;
               dur1 = (rem_prd > RMT_DUR_MAX) ? RMT_DUR_MAX : rem_prd;
               rem_prd -= dur1;

               if (rem_prd == 0 && dur1 == 0)
               {  // end marker fall thru
                  if(loop_en) {dur1 = 1; lvl1 = 0;} // TX end marker starts at next dur0
               }
           }
           else  // zero remaining mem buffer
           {   dur0 = dur1 = 0;
               lvl0 = lvl1 = 0;
               if (!flag_clrALL) break;
           }

           symbols[i].duration0 = dur0;
           symbols[i].duration1 = dur1;
           symbols[i].level0 = lvl0;
           symbols[i].level1 = lvl1;

#ifdef DEBUG_LOG
           Debug_1 += dur0 + dur1;
           ::Serial.printf("symbol[%d]:, dur0=,%d, [%d], dur1=,%d,[%d], rem_pw=,%d, rem_prd=,%d \n\r",
                                       i, dur0, lvl0, dur1, lvl1, rem_pw, rem_prd);
#endif
           if (rem_pw == 0 && rem_prd == 0 && !flag_clrALL) break;  // don't zero remaining mem buffer
       }
          // TX the pulse   
          rmt_transmit_config_t transmit_config = {.loop_count = Loop_cnt}; // Mem block TX multiplier:       
          esp_err_t errt = rmt_transmit(tx_channel[Tx_ch], copy_encoder, symbols, sizeof(symbols), &transmit_config);
         if (errt == ESP_ERR_INVALID_STATE)
         {printf("Error: RMT channel %d not enabled.\n\r", Tx_ch); return err;}
          
#ifdef DEBUG_LOG
          ::Serial.printf("Tally: Debug_1=%d \n\r", Debug_1);
#endif
         if(errt != ESP_OK) {err = errt;}
         return err;
   }
//===================================================


//      --== TX Pulse microseconds ==--
   int B4RESP32RMTpuls::TXpuls_us(byte Tx_ch, ULong PW_us, int Loop_cnt) 
   {   int err = 0;
       uint32_t PRD_us = 0;
        
       err = TXpuls_prd( Tx_ch, PW_us, PRD_us, Loop_cnt);
       return err;
   }   



//      --== TX Pulse milliseconds ==-- 
   int B4RESP32RMTpuls::TXpuls_ms(byte Tx_ch, ULong PW_ms, int Loop_cnt) 
   {  int err = 0;
      err = TXpuls_us(Tx_ch, PW_ms * 1000UL, Loop_cnt);
      return err;
   }


//      --== TX Pulse seconds ==-- 
   int B4RESP32RMTpuls::TXpuls_s(byte Tx_ch, ULong PW_s) 
   {   int err = 0;
       const uint32_t MAX_PULSE_US = (MAX_SYMBOLS - 1) * 65534UL;
       uint64_t total_us = (uint64_t)PW_s * 1000000ULL;
       uint32_t pulse_us = 0;
       int loop_cnt = 0; //1;

          if (total_us <= MAX_PULSE_US) {pulse_us = (uint32_t)total_us;}
          else 
          {  loop_cnt = (int)((total_us + MAX_PULSE_US - 1) / MAX_PULSE_US); // ceil
             if (loop_cnt > 1024) {loop_cnt = 1024; total_us = MAX_PULSE_US * loop_cnt;}
             pulse_us = (uint32_t)(total_us / loop_cnt); // even split
          }

#ifdef DEBUG_LOG 
       ::Serial.printf("TXpulse_s: pulse_us=%u loop_cnt=%d (from %llu us) \n\r", pulse_us, loop_cnt, total_us);
#endif
       err = TXpuls_us(Tx_ch, pulse_us, loop_cnt);
       return err;
   }
//===================================================

//      --== TX Pulse Train ==--
   int B4RESP32RMTpuls::TXpulsTrain(byte Tx_ch, ULong PW_us, ULong Prd_us, byte Puls_n, int Loop_cnt) 
   {   int err = 0;
        if (Tx_ch > MAX_TX_CHANNELS) 
        {::Serial.println("Error - TXpulsTrain: Channel num > MAX_CHANNELS"); err = 1; return err;}
        if (Puls_n > MAX_SYMBOLS-1) {Puls_n = MAX_SYMBOLS-1; err = -2;}  // clamp Puls_n 
        if (PW_us > Prd_us)  {PW_us = Prd_us; err = -1;}                 // clamp 100% duty
      static rmt_symbol_word_t symbols[MAX_SYMBOLS];
         uint8_t i = 0;
         uint16_t dur0, dur1;
         bool lvl1 = 0;
         bool lvl0 = 1;
         
// ::Serial.printf("TXpulsTrain: Tx_ch=%d, PW_us=%d, Prd_us=%d,  Puls_n=%d \n\r", Tx_ch, PW_us, Prd_us, Puls_n);
      //while (i < MAX_SYMBOLS) {
      for (i = 0; i < MAX_SYMBOLS; ++i)
      {  
         if (PW_us < Prd_us)  {dur0 = PW_us; dur1 = Prd_us-PW_us;}    // dur0+dur1 = period
         if (PW_us == Prd_us) {dur0 = Prd_us-1; dur1 = 1; lvl1 = 1;}  // 100% duty
         if (i >= Puls_n) {dur0 = dur1 = 0; lvl0 = lvl1 = 0;}        // TX end-marker
       
        symbols[i].duration0 = dur0;
        symbols[i].level0 = lvl0;
        symbols[i].duration1 = dur1;
        symbols[i].level1 = lvl1;
 
//DEBUG
//  ::Serial.printf("TXpulsTrain: Tx_ch=%d, PW_us=%d, Prd_us=%d,  Puls_n=%d, symbol_cnt=%d, dur0=%d, dur1=%d \n\r", Tx_ch, PW_us, Prd_us, Puls_n, i, dur0, dur1);
     
         if (i > MAX_SYMBOLS-1) {::Serial.printf("TXpulsTrain: ERROR SYMBOL SET OVERFLOW i=%d \n\r", i);break;} // just in case...
      }

#ifdef DEBUG_LOG // Symbol Mem Dump       ---=== THIS TAKES A WHILE===---
      for (i = 0; i <= MAX_SYMBOLS-1; ++i){
         {::Serial.printf("PT_rmt_mem: symbol:%d, %d, %d,Loop=%d   \n\r", i, symbols[i].duration0, symbols[i].duration1, Loop_cnt);}  // print mem
         }
         ::Serial.println("----------");
#endif

       if(Loop_cnt > 1023) Loop_cnt = 1023;
       
       rmt_transmit_config_t transmit_config = {.loop_count = Loop_cnt}; // Mem block multiplier:
       ESP_ERROR_CHECK(rmt_transmit(tx_channel[Tx_ch], copy_encoder, symbols, sizeof(symbols), &transmit_config));
       
 //      rmt_transmit_config_t transmit_config = {.loop_count = Loop_cnt}; // Mem block TX multiplier:       
 //      ESP_ERROR_CHECK(rmt_transmit(tx_channel[Tx_ch], copy_encoder, symbols, sizeof(symbols), &transmit_config));
       
       return err;
   }   
//====================================================


#define RMT_CARRIER_DUTY_REG(Tx_ch)     (RMT_CH0CARRIER_DUTY_REG +(Tx_ch) *0x04)
#define RMT_CH_CONF0_REG(Tx_ch)         (RMT_CH0CONF0_REG +(Tx_ch) *0x04)
#define RMT_CARRIER_LO                  (RMT_CARRIER_LOW_CH0_S) // 0
#define RMT_CARRIER_HI                  (RMT_CARRIER_HIGH_CH0_S)// 16
 
// --== Set PWM Carrier modulation ==--
   int B4RESP32RMTpuls::PWMmod(byte Tx_ch, ULong Freq_hz, UInt Duty_val) 
   {
       const uint16_t DUTY_SCALE = 1000; // (eg. Duty_val = 1000 means 100.0%)
       // Clock and range settings
       const uint32_t RMT_CLK_HZ = 80'000'000;  // APB clock
       const uint32_t MIN_FREQ = 620;
       const uint32_t MAX_FREQ = 20'000'000;
       int err = 0;
//::Serial.printf("PWMmod data: TX_ch%lu, Freq=%lu Hz, Duty_val=%u, \n\r", Tx_ch, Freq_hz, Duty_val);
       if (Freq_hz < MIN_FREQ)   { Freq_hz = MIN_FREQ; err = 1; }
       if (Freq_hz > MAX_FREQ)   { Freq_hz = MAX_FREQ; err = 1; }
     //  if (Duty_val >= DUTY_SCALE) {Duty_val = DUTY_SCALE; err = 2;} // Avoid 100%, would cause ticks=0
         
       if (Freq_hz == 0 || Duty_val == 0) // Disable PWM
       {
          REG_CLR_BIT(RMT_CH_CONF0_REG(Tx_ch), RMT_CARRIER_EN_CH0);
          return err;
       }
         
       uint32_t total_ticks = RMT_CLK_HZ / Freq_hz;
       uint32_t max_duty_val = (65535ULL * DUTY_SCALE) / total_ticks; // Prevent overflow of high_ticks

      if (Duty_val > max_duty_val) // Clamp duty at low frequencies
      {  ::Serial.printf("Warning: Duty too high at %lu Hz: Clamping Duty_val from %u to %lu (max %.1f%%)\n\r",
                          Freq_hz, Duty_val, max_duty_val,  100.0 * (float)max_duty_val / DUTY_SCALE);
         Duty_val = max_duty_val;
      }
       uint32_t high_ticks  = (total_ticks * Duty_val + (DUTY_SCALE / 2)) / DUTY_SCALE;  // rounded
       uint32_t low_ticks   =  total_ticks - high_ticks;

       // Hardware limits: ticks must be 1..65536
       if (high_ticks < 1 || high_ticks > 65536 || // something gone wrong...
           low_ticks  < 1 || low_ticks  > 65536)  {err = 3;}

       if (err != 0) 
       {   ::Serial.printf("PWMmod error: ERR=%d, Freq=%lu Hz, Duty_val=%u, high_ticks=%lu, low_ticks=%lu\n",
                                          err, Freq_hz, Duty_val, high_ticks, low_ticks);
           if (err >2) return err;
       }
//    ::Serial.printf("PWMmod data: Freq=%lu Hz, Duty_val=%u, high_ticks=%lu, low_ticks=%lu\n\r", // DEBUG
//                                  Freq_hz, Duty_val, high_ticks, low_ticks);
    // Set carrier duty  
    REG_WRITE(RMT_CARRIER_DUTY_REG(Tx_ch), (uint32_t)high_ticks << 16 | low_ticks);

    // Apply to TX puls, Enable carrier
#if SOC_RMT_SUPPORT_CARRIER_EFF_EN // not for old RMT module(ESP32, ESP32c2)
    REG_SET_BIT(RMT_CH_CONF0_REG(Tx_ch), RMT_CARRIER_EFF_EN_CH0); // BIT(20)
#endif    
    REG_SET_BIT(RMT_CH_CONF0_REG(Tx_ch), RMT_CARRIER_EN_CH0);     // BIT(21)

    return 0;
   }
//====================================================


//      --== Apply sync to channels ==--
int B4RESP32RMTpuls::SYNC_ch(ArrayByte* tx_channels, byte numof_ch, bool SYNC_en)
{
    static rmt_sync_manager_handle_t chSync = NULL;

    if (!SYNC_en)  // delete sync
       { if (chSync != NULL) 
            { rmt_del_sync_manager(chSync);
             chSync = NULL;
            }
         return 0;
       }

    if (chSync != NULL) // Reset sync to rearm
       { rmt_sync_reset(chSync);
//         ::Serial.printf("chSync: = %d \n\r", chSync);
         return 0;
       }

    rmt_channel_handle_t ch_handles[numof_ch];

    for (int i = 0; i < numof_ch; i++) 
    {   byte ch_index = ((Byte*)tx_channels->data)[i];
        if (ch_index >= MAX_TX_CHANNELS || tx_channel[ch_index] == NULL) 
           {return -1;} // invalid index or channel not created
        
        ch_handles[i] = tx_channel[ch_index];
//::Serial.printf("Sync channels: %d, ch handles=%d, Index=%u  \n\r", i, ch_handles[i], ch_index);
    }

    rmt_sync_manager_config_t chSync_config = 
    {   .tx_channel_array = ch_handles,
        .array_size = numof_ch,
    };

    esp_err_t result = rmt_new_sync_manager(&chSync_config, &chSync);
    return (result == ESP_OK) ? 0 : -2;
}
//====================================================


//#define SW_GPIO_IDF
//      --== Switch GPIO out ==--  W.I.P
   int B4RESP32RMTpuls::SwitchGPIO(byte Tx_ch, int GPIO_dis, int GPIO_con, bool Inv_out)
#ifndef SW_GPIO_IDF
   {  if (Tx_ch >= MAX_TX_CHANNELS) return -1;  // Out of range
   
      if (GPIO_dis > 0) // disconnect GPIO from RMT ch
      {   gpio_set_direction((gpio_num_t)GPIO_dis, GPIO_MODE_INPUT);
          gpio_matrix_out((gpio_num_t)GPIO_dis, SIG_GPIO_OUT_IDX, false, false);
//::Serial.printf("SwitchGPIO: DIS. Ch=%d, Dis=%d  \n\r", Tx_ch, GPIO_dis); //DEBUG    
      }   
      
      if (GPIO_con > 0) // connect GPIO to RMT ch
      {   gpio_reset_pin((gpio_num_t)GPIO_con);
          gpio_set_direction((gpio_num_t)GPIO_con, GPIO_MODE_OUTPUT);
          gpio_matrix_out((gpio_num_t)GPIO_con, RMT_SIG_OUT0_IDX + Tx_ch, Inv_out, false);
//::Serial.printf("SwitchGPIO: CON. Ch=%d, Con=%d  \n\r", Tx_ch, GPIO_con); //DEBUG  
      }
#else  // NOT TESTED...
      rmt_tx_switch_gpio(Tx_ch, GPIO_con, Inv_out); // only for IDF > 5.4.2
#endif

    return 0;
   }
//====================================================

//      --== Invert GPIO out ==--
   void B4RESP32RMTpuls::InvOut(byte GPIO_n, bool Pin_Inv) 
   {
      GPIO.func_out_sel_cfg[GPIO_n].inv_sel = int(Pin_Inv); //req. gpio_struct.h
   }
   
      //      --== Stop RMT channel ==--
   void B4RESP32RMTpuls::StopPuls(byte Tx_ch) 
   {
      if (tx_channel[Tx_ch] != NULL) {ESP_ERROR_CHECK(rmt_disable(tx_channel[Tx_ch]));} //This requires new ch config !
   
   }
   
   
   //      --== Delete RMT channel ==--
   void B4RESP32RMTpuls::ChannelDelete(byte Tx_ch) 
   {
 //       ESP_ERROR_CHECK(rmt_disable(tx_channel[Tx_ch])); //Delete channel config
   }

 }


/* General Notes & info.
   ** for early? IDF or soc specific, loop value 0 or 1 may not be no loop ??.
  * Last symbol is reserved as TX end marker for looping with a full symbol buffer
  * A channel will stop transmitting when it encounters a zero period(.duration = 0)
  * A lower channel can use any of the higher channel blocks, but this disables the higher channel. (not implemented in this lib)
  * For clean looping (pulse width multiplier) .duration1 should be non zero, else 1us gap between repeats.
  * If Invert is set =true, & then not set(comment line) the GPIO matrix will retain inv state (partially?) after compile - set to false will restore.
  * When writing to mem symbol bitfields, old data can remain.(end-marker will mitigate)
  * Set carrier freq/duty using IDF will crash ESP with out of range data. Hence struct/regset.
  
  * From rmt_ll.h(ESP32)
    RMT_LL_EVENT_TX_LOOP_END(channel) (0) // esp32 doesn't support tx loop count
    RMT_LL_EVENT_RX_THRES(channel)    (0) // esp32 doesn't support rx wrap
  
  * 1 tick(res=1µs) is added to any pulse value with .duration1=0, but its level will be 0,  
    so a 5µs pulse will be 5µs with a period of 6µs 111110 (6 ticks) Typically insignificant.<br>  
    If looping with 1µs pulse, it will be 2µs x loop count (<-- does not apply to > 1µs pulse)
  
  * Sync: (ESP-IDF behaviour) 
    With a group of sync channels, another channel sent before sync channels TX will be sync'd 
    Mitigate: Dont send non-sync channels after sync setup(or re-armed),
    sync will disarm after each sync group TX.

*/