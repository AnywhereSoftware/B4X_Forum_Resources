#pragma once
#include "B4RDefines.h"
#include "ESPUI.h"

namespace B4R {
//Most elements in this test UI are assigned this generic callback which prints some
//basic information. Event types are defined in ESPUI.h
// Most elements in this test UI are assigned this generic callback which prints some
// basic information. Event types are defined in ESPUI.h
// The extended param can be used to hold a pointer to additional information
// or for C++ it can be used to return a this pointer for quick access
// using a lambda function

    typedef void (*SubVoid_extended)(UInt ControlId, Byte ControlType,B4RString* ControlLabel, B4RString* ControlValue, Int eventType, ULong userData) ;

    //~Event: OnExtendedCallback(ControlId as UInt, ControlType as Byte, ControlLabel as B4RString*, ControlValue as B4RString*, eventType as Int, userData as ULong)

    //~Version: 1                                                                         
    //~Author - 
    //~Libray from Arduino https://github.com/s00500/ESPUI
    //~shortname:ESPUI
//class ESPUI    
    class B4RESPUI
    {
        private:                                                                                                
            static B4RESPUI* instance;
            SubVoid_extended OnExtendedCallbackSub;
        public: 
            void Initialize( SubVoid_extended OnExtendedCallbackSub);
            //~hide
            static void ExtendedCallback(uint16_t ControlId, Byte ControlType,const char* ControlLabel, const char* ControlValue, int16_t eventType, uint32_t userData);
           //value by default sliderContinuous = false 
           #define /*bool SLIDERCONTINUOUS;*/ B4RESPUI_SLIDERCONTINUOUS ESPUI.sliderContinuous
          //value by default captivePortal= true 
           #define /*bool CAPTIVEPORTAL;*/ B4RESPUI_CAPTIVEPORTAL ESPUI.captivePortal

            void setVerbosity(Byte verbosity);
            // by default: username = "" <=> no user, no pass  + port = 80 
            void begin(B4RString* title, B4RString* username, B4RString* pass, uint16_t port);
            // username = "" => no user, no pass + port = 80            
            void beginSPIFFS(B4RString* title, B4RString* username, B4RString* pass, uint16_t port);
            // username = "" => no user, no pass + port = 80            
            void beginLITTLEFS(B4RString* title, B4RString* username, B4RString* pass, uint16_t port);
            //by default format = true
            // Initially preps the filesystem and loads a lot of stuff into LITTLEFS
            void prepareFileSystem(bool format);
            // Lists LITTLEFS directory
            void list();
            // write a LITTLEFS file
            void writeFile(B4RString* path, B4RString* data);
            // add a control with type + label
            uint16_t addControl(Int type, B4RString* label);
            // add a control with type + label + value 
            uint16_t addControl1(Int type, B4RString* label, B4RString* value);
            // add control with type + label + value + color
            uint16_t addControl2(Int type, B4RString* label, B4RString* value, Byte color);
            // add control with type + label + value + color + parent            
            uint16_t addControl3(Int type, B4RString* label, B4RString* value, Byte color, uint16_t parentControl);
            // by default force_rebuild_ui = false
            bool removeControl(uint16_t id, bool force_rebuild_ui);
            // Create Label without event
            uint16_t label(B4RString* label, Byte color, B4RString* value);
            // Create Graph display without event
            uint16_t graph(B4RString* label, Byte color);
            // Create Gauge display without event
            // by default min = 0, max = 100
            uint16_t gauge(B4RString* label, Byte color, int16_t value, int16_t min, int16_t max);
            //Create separator
            uint16_t separator(B4RString* label);
            // Create File Display
            uint16_t fileDisplay(B4RString* label, Byte color, B4RString* filename);
            
            // Get Type of a control
            uint8_t getControlType(uint16_t id);
            // Get a Label of a control
            B4RString* getControlLabel(uint16_t id);
            // Get a Value of a control
            B4RString* getControlValue(uint16_t id);  
                                                                  
            // Update Element value
            // by default clientId=-1
            void updateControlValue(uint16_t id, B4RString* value, int16_t clientId);
            // Update Element label
            // by default clientId=-1            
            void updateControlLabel(uint16_t control, B4RString* value, int16_t clientId);
            // Update a control
            // by default clientId=-1            
            void updateControl(uint16_t id, int16_t clientId);
            //  update Control Value
            void print(uint16_t id, B4RString* value);
            // update Label value
            void updateLabel(uint16_t id, B4RString* value);
            // update Button value
            void updateButton(uint16_t id, B4RString* value);
            // update Switcher Value
            // by default clientId = -1
            void updateSwitcher(uint16_t id, bool nValue, int16_t clientId);
            // update Slider Value
            // by default clientId = -1
            void updateSlider(uint16_t id, int16_t nValue, int16_t clientId);
            //update Number Value
            // by default clientId = -1
            void updateNumber(uint16_t id, int16_t nValue, int16_t clientId);
            // update Text value
            // by default clientId = -1
            void updateText(uint16_t id, B4RString* nValue, int16_t clientId);
            // update Select Value
            // by default clientId = -1
            void updateSelect(uint16_t id, B4RString* nValue, int16_t clientId);
            // update Gauge number
            // by default clientId = -1
            void updateGauge(uint16_t id, int16_t number, int16_t clientId);
            // update Time
            // by default clientId = -1
            void updateTime(uint16_t id, int16_t clientId);
            // clear Graph
            // by default clientId = -1
            void clearGraph(uint16_t id, int16_t clientId);
            // add GraphPoint value
            // by default clientId = -1
            void addGraphPoint(uint16_t id, int16_t nValue, int16_t clientId);
            // set PanelStyle style
            // by default clientId = -1
            void setPanelStyle(uint16_t id, B4RString* style, int16_t clientId);
            // set ElementStyle style
            // by default clientId = -1
            void setElementStyle(uint16_t id, B4RString* style, int16_t clientId);
            // set InputType type
            // by default clientId = -1
            void setInputType(uint16_t id, B4RString* type, int16_t clientId);
            // set PanelWide wide
            void setPanelWide(uint16_t id, bool wide);
            // set Vertical vert
            void setVertical(uint16_t id, bool vert);
            // set Enabled 
            // by default clientId = -1
            void setEnabled(uint16_t id, bool enabled, int16_t clientId);
            // update Visibility 
            // by default clientId = -1
            void updateVisibility(uint16_t id, bool visibility, int16_t clientId);
           // by default ui_title = "ESPUI" 
           #define /*B4RString* UI_TITLE;*/ B4RESPUI_UI_TITLE ESPUI.UI_TITLE

            void jsonReload();
            void jsonDom(uint16_t startidx, uint32_t client, bool Updating);
           // by default verbosity = Verbosity_Quiet 
           #define /*Byte Verbosity;*/ B4RESPUI_verbosity ESPUI.verbosity
           
            // add control with callback
            uint16_t addControl_CB(Byte type, B4RString* label, B4RString* value, Byte color, uint16_t parentControl, uint32_t userData); 
            // add button with callback          
            uint16_t button_CB(B4RString* label, Byte color, B4RString* value,  uint32_t userData);
            // add switcher with callback
            uint16_t switcher_CB(B4RString* label, Byte color, bool startState,  uint32_t userData);
            // add pad with callback
            uint16_t pad_CB(B4RString* label, Byte color,  uint32_t userData);
            // add padwithCenter with callback
            uint16_t padWithCenter_CB(B4RString* label, Byte color,  uint32_t userData);
            // add slider with callback
            uint16_t slider_CB(B4RString* label, Byte color, int16_t value, int16_t min, int16_t max,  uint32_t userData);
            // add number with callback
            uint16_t number_CB(B4RString* label, Byte color, int16_t value, int16_t min, int16_t max,  uint32_t userData);
            // add text with callback
            uint16_t text_CB(B4RString* label, Byte color, B4RString* value,  uint32_t userData);
            // add accelerometer with callback
            uint16_t accelerometer_CB(B4RString* label, Byte color, uint32_t userData);  

// Verbosity
     #define /*Byte Verb_Quiet;*/ B4RVerb_Quiet                                      0
     #define /*Byte Verb_Verbose;*/ B4RVerb_Verbose                                  1
     #define /*Byte Verb_VerboseJSON;*/ B4RVerb_VerboseJSON                          2   
// ControlType
     #define /*Byte  ControlTyp_Title;*/ B4RControlTyp_Title                         0     
     #define /*Byte  ControlTyp_Pad;*/ B4RControlTyp_Pad                             1  
     #define /*Byte  ControlTyp_PadWithCenter;*/ B4RControlTyp_PadWithCenter         2  
     #define /*Byte  ControlTyp_Button;*/ B4RControlTyp_Button                       3  
     #define /*Byte  ControlTyp_Label;*/ B4RControlTyp_Label                         4  
     #define /*Byte  ControlTyp_Switcher;*/ B4RControlTyp_Switcher                   5  
     #define /*Byte  ControlTyp_Slider;*/ B4RControlTyp_Slider                       6  
     #define /*Byte  ControlTyp_Number;*/ B4RControlTyp_Number                       7 
     #define /*Byte  ControlTyp_Text;*/ B4RControlTyp_Text                           8  
     #define /*Byte  ControlTyp_Graph;*/ B4RControlTyp_Graph                         9  
     #define /*Byte  ControlTyp_GraphPoint;*/ B4RControlTyp_GraphPoint               10  
     #define /*Byte  ControlTyp_Tab;*/ B4RControlTyp_Tab                             11  
     #define /*Byte  ControlTyp_Select;*/ B4RControlTyp_Select                       12  
     #define /*Byte  ControlTyp_Option;*/ B4RControlTyp_Option                       13  
     #define /*Byte  ControlTyp_Min;*/ B4RControlTyp_Min                             14  
     #define /*Byte  ControlTyp_Max;*/ B4RControlTyp_Max                             15  
     #define /*Byte  ControlTyp_Step;*/ B4RControlTyp_Step                           16  
     #define /*Byte  ControlTyp_Gauge;*/ B4RControlTyp_Gauge                         17  
     #define /*Byte  ControlTyp_Accel;*/ B4RControlTyp_Accel                         18  
     #define /*Byte  ControlTyp_Separator;*/ B4RControlTyp_Separator                 19  
     #define /*Byte  ControlTyp_Time;*/ B4RControlTyp_Time                           20  
     #define /*Byte  ControlTyp_FileDisplay;*/ B4RControlTyp_FileDisplay             21  
     #define /*Byte  ControlTyp_Fragment;*/ B4RControlTyp_Fragment                   98 
     #define /*Byte  ControlTyp_Password;*/ B4RControlTyp_Password                   99  
     #define /*Byte  ControlTyp_UpdateOffset;*/ B4RControlTyp_UpdateOffset           100  
     #define /*Uint  Control_noParent;*/ B4RControl_noParent                         0xffff
// ControlColor                                                                 
     #define /*Byte ControlCol_Turquoise;*/ B4RControlCol_Turquoise                  0  
     #define /*Byte ControlCol_Emerald;*/ B4RControlCol_Emerald                      1  
     #define /*Byte ControlCol_Peterriver;*/ B4RControlCol_Peterriver                2  
     #define /*Byte ControlCol_Wetasphalt;*/ B4RControlCol_Wetasphalt                3  
     #define /*Byte ControlCol_Sunflower;*/ B4RControlCol_Sunflower                  4  
     #define /*Byte ControlCol_Carrot;*/ B4RControlCol_Carrot                        5  
     #define /*Byte ControlCol_Alizarin;*/ B4RControlCol_Alizarin                    6
     #define /*Byte ControlCol_Dark;*/ B4RControlCol_Dark                            7  
     #define /*Byte ControlCol_None;*/ B4RControlCol_None                            0xFF  
// ClientUpdateType_t
// this is an orderd list. highest number is highest priority
     #define /*Byte ClientUpd_Synchronized;*/ B4RClientUpd_Synchronized              0  
     #define /*Byte ClientUpd_UpdateNeeded;*/ B4RClientUpd_UpdateNeeded              1  
     #define /*Byte ClientUpd_RebuildNeeded;*/ B4RClientUpd_RebuildNeeded            2  
     #define /*Byte ClientUpd_ReloadNeeded;*/ B4RClientUpd_ReloadNeeded              3  
// AwsClientStatus
     #define /*Byte AwsClientStat_WS_DISCONNECTED;*/ B4RAwsClientStat_WS_DISCONNECTED      0  
     #define /*Byte AwsClientStat_WS_CONNECTED;*/ B4RAwsClientStat_WS_CONNECTED            1  
     #define /*Byte AwsClientStat_WS_DISCONNECTING;*/ B4RAwsClientStat_WS_DISCONNECTING    2  
// AwsFrameType
     #define /*Byte AwsFrameTyp_WS_CONTINUATION;*/ B4RAwsFrameTyp_WS_CONTINUATION    0  
     #define /*Byte AwsFrameTyp_WS_TEXT;*/ B4RAwsFrameTyp_WS_TEXT                    1  
     #define /*Byte AwsFrameTyp_WS_BINARY ;*/ B4RAwsFrameTyp_WS_BINARY               2  
     #define /*Byte AwsFrameTyp_WS_DISCONNECT;*/ B4RAwsFrameTyp_WS_DISCONNECT        8  
     #define /*Byte AwsFrameTyp_WS_PING;*/ B4RAwsFrameTyp_WS_PING                    9          //??
     #define /*Byte AwsFrameTyp_WS_PONG;*/ B4RAwsFrameTyp_WS_PONG                    10         //??
// AwsMessageStatus
     #define /*Byte AwsMsgStat_WS_MSG_Sending;*/ B4RAwsMsgStat_WS_MSG_Sending        0  
     #define /*Byte AwsMsgStat_WS_MSG_SENT;*/ B4RAwsMsgStat_WS_MSG_SENT              1  
     #define /*Byte AwsMsgStat_WS_MSG_ERROR;*/ B4RAwsMsgStat_WS_MSG_ERROR            2  
// AwsEventType
     #define /*Byte AwsEvenTyp_WS_EVT_CONNECT;*/ B4RAwsEvenTyp_WS_EVT_CONNECT        0  
     #define /*Byte AwsEvenTyp_WS_EVT_DISCONNECT;*/ B4RAwsEvenTyp_WS_EVT_DISCONNECT  1  
     #define /*Byte AwsEvenTyp_WS_EVT_PONG;*/ B4RAwsEvenTyp_WS_EVT_PONG              2  
     #define /*Byte AwsEvenTyp_WS_EVT_ERROR;*/ B4RAwsEvenTyp_WS_EVT_ERROR            3 
     #define /*Byte AwsEvenTyp_WS_EVT_DATA;*/ B4RAwsEvenTyp_WS_EVT_DATA              4  
// CB Event Values
     #define /*Int CBEvent_B_DOWN;*/  BARCBEvent_B_DOWN                             -1
     #define /*Int CBEvent_B_UP;*/  BARCBEvent_B_UP                                  1
     #define /*Int CBEvent_P_LEFT_DOWN;*/  BARCBEvent_P_LEFT_DOWN                   -2
     #define /*Int CBEvent_P_LEFT_UP;*/  BARCBEvent_P_LEFT_UP                        2
     #define /*Int CBEvent_P_RIGHT_DOWN;*/  BARCBEvent_P_RIGHT_DOWN                 -3
     #define /*Int CBEvent_P_RIGHT_UP;*/  BARCBEvent_P_RIGHT_UP                      3
     #define /*Int CBEvent_P_FOR_DOWN;*/  BARCBEvent_P_FOR_DOWN                     -4
     #define /*Int CBEvent_P_FOR_UP;*/  BARCBEvent_P_FOR_UP                          4
     #define /*Int CBEvent_P_BACK_DOWN;*/  BARCBEvent_P_BACK_DOWN                   -5
     #define /*Int CBEvent_P_BACK_UP;*/  BARCBEvent_P_BACK_UP                        5
     #define /*Int CBEvent_P_CENTER_DOWN;*/  BARCBEvent_P_CENTER_DOWN               -6
     #define /*Int CBEvent_P_CENTER_UP;*/  BARCBEvent_P_CENTER_UP                    6
     #define /*Int CBEvent_S_ACTIVE;*/  BARCBEvent_S_ACTIVE                         -7
     #define /*Int CBEvent_S_INACTIVE;*/  BARCBEvent_S_INACTIVE                      7
     #define /*Int CBEvent_SL_VALUE;*/  BARCBEvent_SL_VALUE                          8
     #define /*Int CBEvent_N_VALUE;*/  BARCBEvent_N_VALUE                            9
     #define /*Int CBEvent_T_VALUE;*/  BARCBEvent_T_VALUE                            10
     #define /*Int CBEvent_S_VALUE;*/  BARCBEvent_S_VALUE                            11
     #define /*Int CBEvent_TM_VALUE;*/  BARCBEvent_TM_VALUE                          12
     
    };
}
