#include "B4RDefines.h"

namespace B4R
{
	// Define static instance pointer
	B4RESP32WATCHDOG* B4RESP32WATCHDOG::instance = nullptr;
	
	void B4RESP32WATCHDOG::Initialize(int timeoutms, SubVoidResetReason ResetReasonSub)
	{

		instance = this;

		// Assign the reset reason event
		this->ResetReasonSub = ResetReasonSub;
		::Serial.println("[Initialize][ResetReasonSub] ADDED");
		
		// Deinitialize the watchdog first to avoid "already initialized" error
		B4RESP32WATCHDOG::DeInitialize();

		// Define the twdt config structure and set its properties
		esp_task_wdt_config_t config;
		
		// Timeout in ms, i.e. ESP waits timeoutms till reboot
		config.timeout_ms = timeoutms;
		
		// Watch all cores
		config.idle_core_mask = (1 << portNUM_PROCESSORS) - 1;
		
		// true: panic on timeout 
		config.trigger_panic = true;

		// Init the twdt task and check if succesful
		esp_err_t err = esp_task_wdt_init(&config);
		if (err != ESP_OK && err != ESP_ERR_INVALID_STATE) {
			::Serial.println("[Initialize][ERROR] TWDT failed to initialize!");
			return;
		}

		// Log to serial automatically
		B4RESP32WATCHDOG::ResetReason();

		// Add and watch the main twdt task
		esp_err_t add_result = esp_task_wdt_add(NULL);
		if (add_result == ESP_ERR_INVALID_STATE) {
			::Serial.println("[Initialize] TWDT task already being watched.");
		}

		// Add the looper to the poller
		FunctionUnion fu;
		fu.PollerFunction = Looper;
		pnode.functionUnion = fu;
		pnode.tag = this;
		if (pnode.next == NULL) {
			pollers.add(&pnode);
		}			
	}

	void B4RESP32WATCHDOG::DeInitialize()
	{
		esp_err_t err = esp_task_wdt_deinit();
		
		if (err == ESP_ERR_INVALID_STATE) {
			::Serial.println("[DeInitialize] TWDT was not active.");
		}		
	}

	void B4RESP32WATCHDOG::Feed()
	{
		// Resets the watchdog timer for current task
		esp_task_wdt_reset();
		
		// Go for sure and set short delay
		delay(1);		
	}

	int B4RESP32WATCHDOG::ResetReason()
	{
		esp_reset_reason_t reason = esp_reset_reason();
		::Serial.print("[ResetReason] code=");
		::Serial.println(reason);    

		switch (reason) {
			// Reset reason can not be determine
			ESP_RST_UNKNOWN:			::Serial.println("[ResetReason] UNKNOWN"); break;
			// Reset due to power-on event
			case ESP_RST_POWERON: 		::Serial.println("[ResetReason] POWER ON"); break;
			// Reset by external pin (not applicable for ESP32)
			case ESP_RST_EXT:     		::Serial.println("[ResetReason] EXTERNAL"); break;
			// Software reset via esp_restart
			case ESP_RST_SW:      		::Serial.println("[ResetReason] SOFTWARE"); break;
			// Software reset due to exception/panic
			case ESP_RST_PANIC:   		::Serial.println("[ResetReason] PANIC"); break;
			// Reset (software or hardware) due to interrupt watchdog
			case ESP_RST_INT_WDT:		::Serial.println("[ResetReason] WATCHDOG interrupt triggered reset"); break;
			// Reset due to task watchdog
			case ESP_RST_TASK_WDT:		::Serial.println("[ResetReason] WATCHDOG task triggered reset"); break;
			// Reset due to other watchdogs
			case ESP_RST_WDT:     		::Serial.println("[ResetReason] WATCHDOG others triggered reset"); break;
			// Reset after exiting deep sleep mode
			case ESP_RST_DEEPSLEEP:  	::Serial.println("[ResetReason] DEEPSLEEP"); break;
			// Brownout reset (software or hardware)
			case ESP_RST_BROWNOUT:		::Serial.println("[ResetReason] BROWNOUT"); break;
			// Reset over SDIO:		
			case ESP_RST_SDIO: 			::Serial.println("[ResetReason] SDIO"); break;
			// Reset by USB peripheral
			ESP_RST_USB: 				::Serial.println("[ResetReason] USB"); break;
			// Reset by JTAG
			ESP_RST_JTAG:       		::Serial.println("[ResetReason] JTAG"); break;
			// Reset due to efuse error
			ESP_RST_EFUSE:      		::Serial.println("[ResetReason] EFUSE"); break;
			// Reset due to power glitch detected
			ESP_RST_PWR_GLITCH: 		::Serial.println("[ResetReason] POWER_GLITCH"); break;
			// Reset due to CPU lock up (double exception)
			ESP_RST_CPU_LOCKUP: 		::Serial.println("[ResetReason] CPU_LOCKUP"); break;
			// 
			default:              		::Serial.println("[ResetReason] OTHER"); break;
		}
		resetReasonCode = reason;

		if (B4RESP32WATCHDOG::GetInstance()) {
			if (B4RESP32WATCHDOG::GetInstance()->ResetReasonSub != NULL) {
				::Serial.println("[ResetReason] B4R Sub calling");
				B4RESP32WATCHDOG::GetInstance()->ResetReasonSub(reason);
			} else {
				::Serial.println("[ResetReason] B4R Sub is NULL");
			}		
		}

		// Return the reason for further handling in B4R code
		return reason;		
	}

	B4RString* B4RESP32WATCHDOG::ReasonName(ULong code)
	{
		String msg = "INVALID";
		
		// Cast to uint32_t as needed for comparison
		switch ((uint32_t) code) {
			case ESP_RST_UNKNOWN:      msg = "UNKNOWN"; break;
			case ESP_RST_POWERON:      msg = "POWER ON"; break;
			case ESP_RST_EXT:          msg = "EXTERNAL"; break;
			case ESP_RST_SW:           msg = "SOFTWARE"; break;
			case ESP_RST_PANIC:        msg = "PANIC"; break;
			case ESP_RST_INT_WDT:      msg = "INT WDT"; break;
			case ESP_RST_TASK_WDT:     msg = "TASK WDT"; break;
			case ESP_RST_WDT:          msg = "OTHER WDT"; break;
			case ESP_RST_DEEPSLEEP:    msg = "DEEP SLEEP"; break;
			case ESP_RST_BROWNOUT:     msg = "BROWNOUT"; break;
			case ESP_RST_SDIO:         msg = "SDIO"; break;
			case ESP_RST_USB:          msg = "USB"; break;
			case ESP_RST_JTAG:         msg = "JTAG"; break;
			case ESP_RST_EFUSE:        msg = "EFUSE"; break;
			case ESP_RST_PWR_GLITCH:   msg = "POWER GLITCH"; break;
			case ESP_RST_CPU_LOCKUP:   msg = "CPU LOCKUP"; break;
		}
		// Convert the message to B4RString
		return B4RESP32WATCHDOG::StringToB4R(&msg);
	}

    void B4RESP32WATCHDOG::Looper(void* b) {
		// Optional: Log periodically
		static uint counter = 0;
		if (counter++ % 1000 == 0) {
			::Serial.println("[Looper] Feeding watchdog...");
		}

		// Feed watchdog (safe to call from Looper)
		// Basically it is resetting the watchdog
		// For clarity: 
		// Looper is called, b is a pointer to that object — it is cast back and can be used like any instance.
		B4RESP32WATCHDOG* self = (B4RESP32WATCHDOG*)b;
		self->Feed();

		// Small delay in ms (critical: not too long, else watchdog expires!)
		delay(150);
    }

	/**
	 * HELPER
	 */

	B4RString* B4RESP32WATCHDOG::StringToB4R(String* o)
	{
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(*o);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}


}
