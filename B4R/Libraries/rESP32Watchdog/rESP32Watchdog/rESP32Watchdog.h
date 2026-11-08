// Library: rESP32Watchdog
// ESP32 watchdog.
// Date: 20250422
// Author: Robert W.B. Linn
#pragma once
#include "B4RDefines.h"

#include "esp_task_wdt.h"
#include "esp_system.h"

//~Version: 1.0
namespace B4R
{
	
	//~Shortname: ESP32Watchdog
	//~Event: ResetReason (reason As Int)
	// Callback reset reason event
	typedef void (*SubVoidResetReason)(short reason);

	class B4RESP32WATCHDOG
	{
		private:
			// Global instance pointer
			static B4RESP32WATCHDOG* instance;

			int resetReasonCode;

			// Client callback defined in the B4R code
			SubVoidResetReason ResetReasonSub;

			// PollerNode added to the pollers.
			PollerNode pnode;

			// The ESP Task Watchdog Timer (TWDT) needs to be periodically fed from each watched task, or it will assume the task is stuck and trigger a reset.
			// The Looper() function, registered with pollers.add(&pnode), ensures that it:
			// * runs regularly in the main loop (thanks to B4R's internal poller system).
			// * calls Feed(), which in turn calls esp_task_wdt_reset().
			// * keeps the watchdog from firing unless a real hang happens.
			// The Looper is a heartbeat and not a monitor. Set a minimal delay in this function.
			// Keep Looper() minimal and predictable.
			static void Looper(void* b);
									
		public:
			/**
			* Initializes the watchdog with reset reason event.
			* timeout - Timeout in ms, i.e. ESP waits timeoutms till reboot.
			* ResetReasonSub (SubVoidResetReason) - Name of the reaset reason event.
			*/
			void Initialize(int timeoutms, SubVoidResetReason ResetReasonSub);
			
			/**
			* Deinitialize the watchdog.
			* It might be not initialized, check and log.
			*/
			void DeInitialize();

			/**
			 * Feed the watchdog to indicate the task is responsive.
			 * Resets the timer to prevent a system reset.
			 */
			void Feed();

			/**
			 * When the ESP crashes or reboots, the system fully restarts.
			 * Calling ResetReason() from B4R at AppStart is the only reliable place to check why the ESP32 restarted.
			 */
			int ResetReason();

			/**
			 * Get the reason code as short string.
			 */
			B4RString* ReasonName(ULong code);

			/**
			* Reset Reason Codes (ULong)
			*/

			#define /*ULong ESP_RST_UNKNOWN;*/      B4RESP32WATCHDOG_ESP_RST_UNKNOWN       ESP_RST_UNKNOWN
			#define /*ULong ESP_RST_POWERON;*/      B4RESP32WATCHDOG_ESP_RST_POWERON       ESP_RST_POWERON
			#define /*ULong ESP_RST_EXT;*/          B4RESP32WATCHDOG_ESP_RST_EXT           ESP_RST_EXT
			#define /*ULong ESP_RST_SW;*/           B4RESP32WATCHDOG_ESP_RST_SW            ESP_RST_SW
			#define /*ULong ESP_RST_PANIC;*/        B4RESP32WATCHDOG_ESP_RST_PANIC         ESP_RST_PANIC
			#define /*ULong ESP_RST_INT_WDT;*/      B4RESP32WATCHDOG_ESP_RST_INT_WDT       ESP_RST_INT_WDT
			#define /*ULong ESP_RST_TASK_WDT;*/     B4RESP32WATCHDOG_ESP_RST_TASK_WDT      ESP_RST_TASK_WDT
			#define /*ULong ESP_RST_WDT;*/          B4RESP32WATCHDOG_ESP_RST_WDT           ESP_RST_WDT
			#define /*ULong ESP_RST_DEEPSLEEP;*/    B4RESP32WATCHDOG_ESP_RST_DEEPSLEEP     ESP_RST_DEEPSLEEP
			#define /*ULong ESP_RST_BROWNOUT;*/     B4RESP32WATCHDOG_ESP_RST_BROWNOUT      ESP_RST_BROWNOUT
			#define /*ULong ESP_RST_SDIO;*/         B4RESP32WATCHDOG_ESP_RST_SDIO          ESP_RST_SDIO
			#define /*ULong ESP_RST_USB;*/          B4RESP32WATCHDOG_ESP_RST_USB           ESP_RST_USB
			#define /*ULong ESP_RST_JTAG;*/         B4RESP32WATCHDOG_ESP_RST_JTAG          ESP_RST_JTAG
			#define /*ULong ESP_RST_EFUSE;*/        B4RESP32WATCHDOG_ESP_RST_EFUSE         ESP_RST_EFUSE
			#define /*ULong ESP_RST_PWR_GLITCH;*/   B4RESP32WATCHDOG_ESP_RST_PWR_GLITCH    ESP_RST_PWR_GLITCH
			#define /*ULong ESP_RST_CPU_LOCKUP;*/   B4RESP32WATCHDOG_ESP_RST_CPU_LOCKUP    ESP_RST_CPU_LOCKUP

			/**
			 * HELPER
			 */
			
			// Convert C string to B4R String
			//~hide
			static B4RString* StringToB4R(String* o);

			// Add a public getter for the ESP32WATCHDOG instance.
			
			//~hide
			static B4RESP32WATCHDOG* GetInstance() { return instance; }

	};

}