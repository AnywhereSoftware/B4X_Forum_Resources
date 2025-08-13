#include "B4RDefines.h"

// Most elements in this test UI are assigned this generic callback which prints some
// basic information. Event types are defined in ESESESPUI.h
// The extended param can be used to hold a pointer to additional information
// or for C++ it can be used to return a this pointer for quick access
// using a lambda function
void extendedCallback(Control* Control, int type, void* param)
{
    B4R::B4RESPUI::ExtendedCallback(Control->id,Control->type,Control->label,Control->value.c_str(), type, (uint32_t)param);    
};


namespace B4R
{
    B4RESPUI* B4RESPUI::instance = NULL;

//class ESPUI
    void B4RESPUI::Initialize( SubVoid_extended OnExtendedCallbackSub) 
    {
       instance = this;       
       this->OnExtendedCallbackSub = OnExtendedCallbackSub; 
    };

    void B4RESPUI::ExtendedCallback(uint16_t ControlId, Byte ControlType,const char* ControlLabel, const char* ControlValue, int16_t eventType, uint32_t userData)
    {
       const uint16_t cp = B4R::StackMemory::cp;
       B4RString* strtopic = CreateStackMemoryObject(B4RString);
       strtopic->data = ControlValue;
       B4RString* strtopic2 = CreateStackMemoryObject(B4RString);
       strtopic2->data = ControlLabel;
       instance->OnExtendedCallbackSub(ControlId, ControlType, strtopic2, strtopic, eventType, userData);
       B4R::StackMemory::cp = cp;    
    };
    
//enum           #define /*bool SLIDERCONTINUOUS;*/ B4RESPUI_SLIDERCONTINUOUS ESPUI::sliderContinuous

//enum           #define /*bool CAPTIVEPORTAL;*/ B4RESPUI_CAPTIVEPORTAL ESPUI::captivePortal

    void B4RESPUI::setVerbosity(Byte verbosity)
    {
       ESPUI.setVerbosity((Verbosity) verbosity);
    };

    void B4RESPUI::begin(B4RString* title, B4RString* username, B4RString* pass, uint16_t port)
    {  
       if (strcmp(username->data, "") == 0) {ESPUI.begin(title->data);}
       else { ESPUI.begin(title->data, username->data, pass->data, port);}      
    };

    void B4RESPUI::beginSPIFFS(B4RString* title, B4RString* username, B4RString* pass, uint16_t port)
    {
       if (strcmp( username->data, "") == 0) {ESPUI.beginSPIFFS(title->data);}
       else {ESPUI.beginSPIFFS(title->data, username->data, pass->data, port); }
    };

    void B4RESPUI::beginLITTLEFS(B4RString* title, B4RString* username, B4RString* pass, uint16_t port)
    {
       if (strcmp( username->data, "") == 0) {ESPUI.beginLITTLEFS(title->data);}
       else {ESPUI.beginLITTLEFS(title->data, username->data, pass->data, port);}
    };

    void B4RESPUI::prepareFileSystem(bool format)
    {
       ESPUI.prepareFileSystem(format);
    };

    void B4RESPUI::list()
    {
       ESPUI.list();
    };

    void B4RESPUI::writeFile(B4RString* path, B4RString* data)
    {
       ESPUI.writeFile(path->data, data->data);
    };

    uint16_t B4RESPUI::addControl(Int type, B4RString* label)
    {
       return ESPUI.addControl((ControlType) type, label->data);
    };

    uint16_t B4RESPUI::addControl1(Int type, B4RString* label, B4RString* value)
    {
       return ESPUI.addControl((ControlType) type, label->data, value->data);
    };

    uint16_t B4RESPUI::addControl2(Int type, B4RString* label, B4RString* value, Byte color)
    {
       return ESPUI.addControl((ControlType) type, label->data, value->data, (ControlColor) color);
    };

    uint16_t B4RESPUI::addControl3(Int type, B4RString* label, B4RString* value, Byte color, uint16_t parentControl)
    {
       return ESPUI.addControl((ControlType) type, label->data, value->data, (ControlColor) color, parentControl);
    };

    bool B4RESPUI::removeControl(uint16_t id, bool force_rebuild_ui)
    {
       return ESPUI.removeControl(id, force_rebuild_ui);
    };

    uint16_t B4RESPUI::label(B4RString* label, Byte color, B4RString* value)
    {
       return ESPUI.label(label->data, (ControlColor) color, value->data);
    };

    uint16_t B4RESPUI::graph(B4RString* label, Byte color)
    {
       return ESPUI.graph(label->data, (ControlColor) color);
    };

    uint16_t B4RESPUI::gauge(B4RString* label, Byte color, int16_t value, int16_t min, int16_t max)
    {
       return ESPUI.gauge(label->data, (ControlColor) color, value, min, max);
    };

    uint16_t B4RESPUI::separator(B4RString* label)
    {
       return ESPUI.separator(label->data);
    };

    uint16_t B4RESPUI::fileDisplay(B4RString* label, Byte color, B4RString* filename)
    {
       return ESPUI.fileDisplay(label->data, (ControlColor) color, filename->data);
    };

     
    uint8_t B4RESPUI::getControlType(uint16_t id)
    {
       return ESPUI.getControl(id)->type;
    };
       
    B4RString* B4RESPUI::getControlLabel(uint16_t id)
    {   
  		String rax = ESPUI.getControl(id)->label;
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };
    
    B4RString* B4RESPUI::getControlValue(uint16_t id)
    {
  		String rax = ESPUI.getControl(id)->value; 
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };
    
    void B4RESPUI::updateControlValue(uint16_t id, B4RString* value, int16_t clientId)
    {
       ESPUI.updateControlValue(id, value->data, clientId);
    };

    void B4RESPUI::updateControlLabel(uint16_t control, B4RString* value, int16_t clientId)
    {
       ESPUI.updateControlLabel(control, value->data, clientId);
    };

    void B4RESPUI::updateControl(uint16_t id, int16_t clientId)
    {
       ESPUI.updateControl(id, clientId);
    };

    void B4RESPUI::print(uint16_t id, B4RString* value)
    {
       ESPUI.print(id, value->data);
    };

    void B4RESPUI::updateLabel(uint16_t id, B4RString* value)
    {
       ESPUI.updateLabel(id, value->data);
    };

    void B4RESPUI::updateButton(uint16_t id, B4RString* value)
    {
       ESPUI.updateButton(id, value->data);
    };

    void B4RESPUI::updateSwitcher(uint16_t id, bool nValue, int16_t clientId)
    {
       ESPUI.updateSwitcher(id, nValue, clientId);
    };

    void B4RESPUI::updateSlider(uint16_t id, int16_t nValue, int16_t clientId)
    {
       ESPUI.updateSlider(id, nValue, clientId);
    };

    void B4RESPUI::updateNumber(uint16_t id, int16_t nValue, int16_t clientId)
    {
       ESPUI.updateNumber(id, nValue, clientId);
    };

    void B4RESPUI::updateText(uint16_t id, B4RString* nValue, int16_t clientId)
    {
       ESPUI.updateText(id, nValue->data, clientId);
    };

    void B4RESPUI::updateSelect(uint16_t id, B4RString* nValue, int16_t clientId)
    {
       ESPUI.updateSelect(id, nValue->data, clientId);
    };

    void B4RESPUI::updateGauge(uint16_t id, int16_t number, int16_t clientId)
    {
       ESPUI.updateGauge(id, number, clientId);
    };

    void B4RESPUI::updateTime(uint16_t id, int16_t clientId)
    {
       ESPUI.updateTime(id, clientId);
    };

    void B4RESPUI::clearGraph(uint16_t id, int16_t clientId)
    {
       ESPUI.clearGraph(id, clientId);
    };

    void B4RESPUI::addGraphPoint(uint16_t id, int16_t nValue, int16_t clientId)
    {
       ESPUI.addGraphPoint(id, nValue, clientId);
    };

    void B4RESPUI::setPanelStyle(uint16_t id, B4RString* style, int16_t clientId)
    {
       ESPUI.setPanelStyle(id, style->data, clientId);
    };

    void B4RESPUI::setElementStyle(uint16_t id, B4RString* style, int16_t clientId)
    {
       ESPUI.setElementStyle(id, style->data, clientId);
    };

    void B4RESPUI::setInputType(uint16_t id, B4RString* type, int16_t clientId)
    {
       ESPUI.setInputType(id, type->data, clientId);
    };

    void B4RESPUI::setPanelWide(uint16_t id, bool wide)
    {
       ESPUI.setPanelWide(id, wide);
    };

    void B4RESPUI::setVertical(uint16_t id, bool vert)
    {
       ESPUI.setVertical(id, vert);                  
    };

    void B4RESPUI::setEnabled(uint16_t id, bool enabled, int16_t clientId)
    {
       ESPUI.setEnabled(id, enabled, clientId);
    };

    void B4RESPUI::updateVisibility(uint16_t id, bool visibility, int16_t clientId)
    {
       ESPUI.updateVisibility(id, visibility, clientId);
    };

//enum           #define /*B4RString* UI_TITLE;*/ B4RESPUI_UI_TITLE ESPUI::UI_TITLE

//??     Control * controls = nullptr

    void B4RESPUI::jsonReload()
    {
       ESPUI.jsonReload();
    };

    void B4RESPUI::jsonDom(uint16_t startidx, uint32_t client, bool Updating)
    {
       ESPUI.jsonDom(startidx, (AsyncWebSocketClient*) client, Updating);
    };

//enum           #define /*Byte Verbosity;*/ B4RESPUI_verbosity ESPUI::verbosity

    uint16_t B4RESPUI::addControl_CB(Byte type, B4RString* label, B4RString* value, Byte color, uint16_t parentControl, uint32_t userData)
    {
       return ESPUI.addControl((ControlType) type, label->data, value->data, (ControlColor) color, parentControl, extendedCallback, (void*) userData);
    };

    uint16_t B4RESPUI::button_CB(B4RString* label, Byte color, B4RString* value,  uint32_t userData)
    {
       return ESPUI.button(label->data, &extendedCallback, (ControlColor) color, value->data, (void*) userData);
    };

    uint16_t B4RESPUI::switcher_CB(B4RString* label, Byte color, bool startState,  uint32_t userData)
    {
       return ESPUI.switcher(label->data, &extendedCallback, (ControlColor) color, startState, (void*) userData);
    };

    uint16_t B4RESPUI::pad_CB(B4RString* label, Byte color,  uint32_t userData)
    {
       return ESPUI.pad(label->data, &extendedCallback, (ControlColor) color, (void*) userData);
    };

    uint16_t B4RESPUI::padWithCenter_CB(B4RString* label, Byte color,  uint32_t userData)
    {
       return ESPUI.padWithCenter(label->data, &extendedCallback, (ControlColor) color, (void*) userData);
    };

    uint16_t B4RESPUI::slider_CB(B4RString* label, Byte color, int16_t value, int16_t min, int16_t max,  uint32_t userData)
    {
       return ESPUI.slider(label->data, &extendedCallback, (ControlColor) color, value, min, max, (void*) userData);
    };

    uint16_t B4RESPUI::number_CB(B4RString* label, Byte color, int16_t value, int16_t min, int16_t max,  uint32_t userData)
    {
       return ESPUI.number(label->data, &extendedCallback, (ControlColor) color, value, min, max, (void*) userData);
    };

    uint16_t B4RESPUI::text_CB(B4RString* label, Byte color, B4RString* value,  uint32_t userData)
    {
       return ESPUI.text(label->data, &extendedCallback, (ControlColor) color, value->data, (void*) userData);
    };

    uint16_t B4RESPUI::accelerometer_CB(B4RString* label, Byte color, uint32_t userData)
    {
       return ESPUI.accelerometer(label->data, &extendedCallback, (ControlColor) color, (void*) userData);
    };    


// Verbosity
//enum     #define /*Byte Verb_Quiet;*/ B4RVerb_Quiet                                0
//enum     #define /*Byte Verb_Verbose;*/ B4RVerb_Verbose                            1
//enum     #define /*Byte Verb_VerboseJSON;*/ B4RVerb_VerboseJSON                    2   


// ControlType
//enum     #define /*Byte  ControlTyp_Title;*/ B4RControlTyp_Title                         0     
//enum     #define /*Byte  ControlTyp_Pad;*/ B4RControlTyp_Pad                             1  
//enum     #define /*Byte  ControlTyp_PadWithCenter;*/ B4RControlTyp_PadWithCenter         2  
//enum     #define /*Byte  ControlTyp_Button;*/ B4RControlTyp_Button                       3  
//enum     #define /*Byte  ControlTyp_Label;*/ B4RControlTyp_Label                         4  
//enum     #define /*Byte  ControlTyp_Switcher;*/ B4RControlTyp_Switcher                   5  
//enum     #define /*Byte  ControlTyp_Slider;*/ B4RControlTyp_Slider                       6  
//enum     #define /*Byte  ControlTyp_Number;*/ B4RControlTyp_Number                       7 
//enum     #define /*Byte  ControlTyp_Text;*/ B4RControlTyp_Text                           8  
//enum     #define /*Byte  ControlTyp_Graph;*/ B4RControlTyp_Graph                         9  
//enum     #define /*Byte  ControlTyp_GraphPoint;*/ B4RControlTyp_GraphPoint               10  
//enum     #define /*Byte  ControlTyp_Tab;*/ B4RControlTyp_Tab                             11  
//enum     #define /*Byte  ControlTyp_Select;*/ B4RControlTyp_Select                       12  
//enum     #define /*Byte  ControlTyp_Option;*/ B4RControlTyp_Option                       13  
//enum     #define /*Byte  ControlTyp_Min;*/ B4RControlTyp_Min                             14  
//enum     #define /*Byte  ControlTyp_Max;*/ B4RControlTyp_Max                             15  
//enum     #define /*Byte  ControlTyp_Step;*/ B4RControlTyp_Step                           16  
//enum     #define /*Byte  ControlTyp_Gauge;*/ B4RControlTyp_Gauge                         17  
//enum     #define /*Byte  ControlTyp_Accel;*/ B4RControlTyp_Accel                         18  
//enum     #define /*Byte  ControlTyp_Separator;*/ B4RControlTyp_Separator                 19  
//enum     #define /*Byte  ControlTyp_Time;*/ B4RControlTyp_Time                           20  
//enum     #define /*Byte  ControlTyp_FileDisplay;*/ B4RControlTyp_FileDisplay             21  
//enum     #define /*Byte  ControlTyp_Fragment;*/ B4RControlTyp_Fragment                   98 
//enum     #define /*Byte  ControlTyp_Password;*/ B4RControlTyp_Password                   99  
//enum     #define /*Byte  ControlTyp_UpdateOffset;*/ B4RControlTyp_UpdateOffset           100  

//enum     #define /*Uint  Control_noParent;*/ B4RControl_noParent                   0xffff


// ControlColor                                                                 
//enum     #define /*Byte ControlCol_Turquoise;*/ B4RControlCol_Turquoise                  0  
//enum     #define /*Byte ControlCol_Emerald;*/ B4RControlCol_Emerald                      1  
//enum     #define /*Byte ControlCol_Peterriver;*/ B4RControlCol_Peterriver                2  
//enum     #define /*Byte ControlCol_Wetasphalt;*/ B4RControlCol_Wetasphalt                3  
//enum     #define /*Byte ControlCol_Sunflower;*/ B4RControlCol_Sunflower                  4  
//enum     #define /*Byte ControlCol_Carrot;*/ B4RControlCol_Carrot                        5  
//enum     #define /*Byte ControlCol_Alizarin;*/ B4RControlCol_Alizarin                    6
//enum     #define /*Byte ControlCol_Dark;*/ B4RControlCol_Dark                            7  
//enum     #define /*Byte ControlCol_None;*/ B4RControlCol_None                            0xFF  


// ClientUpdateType_t
// this is an orderd list. highest number is highest priority
//enum     #define /*Byte ClientUpd_Synchronized;*/ B4RClientUpd_Synchronized        0  
//enum     #define /*Byte ClientUpd_UpdateNeeded;*/ B4RClientUpd_UpdateNeeded        1  
//enum     #define /*Byte ClientUpd_RebuildNeeded;*/ B4RClientUpd_RebuildNeeded      2  
//enum     #define /*Byte ClientUpd_ReloadNeeded;*/ B4RClientUpd_ReloadNeeded        3  


//num AwsClientStatus
//enum     #define /*Byte AwsClientStat_WS_DISCONNECTED;*/ B4RAwsClientStat_WS_DISCONNECTED      0  
//enum     #define /*Byte AwsClientStat_WS_CONNECTED;*/ B4RAwsClientStat_WS_CONNECTED            1  
//enum     #define /*Byte AwsClientStat_WS_DISCONNECTING;*/ B4RAwsClientStat_WS_DISCONNECTING    2  


// AwsFrameType
//enum     #define /*Byte AwsFrameTyp_WS_CONTINUATION;*/ B4RAwsFrameTyp_WS_CONTINUATION    0  
//enum     #define /*Byte AwsFrameTyp_WS_TEXT;*/ B4RAwsFrameTyp_WS_TEXT                    1  
//enum     #define /*Byte AwsFrameTyp_WS_BINARY ;*/ B4RAwsFrameTyp_WS_BINARY               2  
//enum     #define /*Byte AwsFrameTyp_WS_DISCONNECT;*/ B4RAwsFrameTyp_WS_DISCONNECT        8  
//enum     #define /*Byte AwsFrameTyp_WS_PING;*/ B4RAwsFrameTyp_WS_PING                    9          //??
//enum     #define /*Byte AwsFrameTyp_WS_PONG;*/ B4RAwsFrameTyp_WS_PONG                    10         //??


// AwsMessageStatus
//enum     #define /*Byte AwsMsgStat_WS_MSG_Sending;*/ B4RAwsMsgStat_WS_MSG_Sending        0  
//enum     #define /*Byte AwsMsgStat_WS_MSG_SENT;*/ B4RAwsMsgStat_WS_MSG_SENT              1  
//enum     #define /*Byte AwsMsgStat_WS_MSG_ERROR;*/ B4RAwsMsgStat_WS_MSG_ERROR            2  


// AwsEventType
//enum     #define /*Byte AwsEvenTyp_WS_EVT_CONNECT;*/ B4RAwsEvenTyp_WS_EVT_CONNECT        0  
//enum     #define /*Byte AwsEvenTyp_WS_EVT_DISCONNECT;*/ B4RAwsEvenTyp_WS_EVT_DISCONNECT  1  
//enum     #define /*Byte AwsEvenTyp_WS_EVT_PONG;*/ B4RAwsEvenTyp_WS_EVT_PONG              2  
//enum     #define /*Byte AwsEvenTyp_WS_EVT_ERROR;*/ B4RAwsEvenTyp_WS_EVT_ERROR            3 
//enum     #define /*Byte AwsEvenTyp_WS_EVT_DATA;*/ B4RAwsEvenTyp_WS_EVT_DATA              4  


// CB Event Values
//enum     #define /*Int CBEvent_B_DOWN;*/  BARCBEvent_B_DOWN                       -1
//enum     #define /*Int CBEvent_B_UP;*/  BARCBEvent_B_UP                            1
                                                                             
//enum     #define /*Int CBEvent_P_LEFT_DOWN;*/  BARCBEvent_P_LEFT_DOWN             -2
//enum     #define /*Int CBEvent_P_LEFT_UP;*/  BARCBEvent_P_LEFT_UP                  2
//enum     #define /*Int CBEvent_P_RIGHT_DOWN;*/  BARCBEvent_P_RIGHT_DOWN           -3
//enum     #define /*Int CBEvent_P_RIGHT_UP;*/  BARCBEvent_P_RIGHT_UP                3
//enum     #define /*Int CBEvent_P_FOR_DOWN;*/  BARCBEvent_P_FOR_DOWN               -4
//enum     #define /*Int CBEvent_P_FOR_UP;*/  BARCBEvent_P_FOR_UP                    4
//enum     #define /*Int CBEvent_P_BACK_DOWN;*/  BARCBEvent_P_BACK_DOWN             -5
//enum     #define /*Int CBEvent_P_BACK_UP;*/  BARCBEvent_P_BACK_UP                  5
//enum     #define /*Int CBEvent_P_CENTER_DOWN;*/  BARCBEvent_P_CENTER_DOWN         -6
//enum     #define /*Int CBEvent_P_CENTER_UP;*/  BARCBEvent_P_CENTER_UP              6

//enum     #define /*Int CBEvent_S_ACTIVE;*/  BARCBEvent_S_ACTIVE                   -7
//enum     #define /*Int CBEvent_S_INACTIVE;*/  BARCBEvent_S_INACTIVE                7

//enum     #define /*Int CBEvent_SL_VALUE;*/  BARCBEvent_SL_VALUE                    8
//enum     #define /*Int CBEvent_N_VALUE;*/  BARCBEvent_N_VALUE                      9
//enum     #define /*Int CBEvent_T_VALUE;*/  BARCBEvent_T_VALUE                     10
//enum     #define /*Int CBEvent_S_VALUE;*/  BARCBEvent_S_VALUE                     11


//#define UI_TITLE            ControlType::Title
//#define UI_LABEL            ControlType::Label
//#define UI_BUTTON           ControlType::Button
//#define UI_SWITCHER         ControlType::Switcher
//#define UI_PAD              ControlType::Pad
//#define UI_CPAD             ControlType::Cpad
//#define UI_SLIDER           ControlType::Slider
//#define UI_NUMBER           ControlType::Number
//#define UI_TEXT_INPUT       ControlType::Text
//#define UI_GRAPH            ControlType::Graph
//#define UI_ADD_GRAPH_POINT  ControlType::GraphPoint

//#define UPDATE_LABEL        ControlType::UpdateLabel
//#define UPDATE_SWITCHER     ControlType::UpdateSwitcher
//#define UPDATE_SLIDER       ControlType::UpdateSlider
//#define UPDATE_NUMBER       ControlType::UpdateNumber
//#define UPDATE_TEXT_INPUT   ControlType::UpdateText
//#define CLEAR_GRAPH         ControlType::ClearGraph

// Colors
//#define COLOR_TURQUOISE     ControlColor::Turquoise
//#define COLOR_EMERALD       ControlColor::Emerald
//#define COLOR_PETERRIVER    ControlColor::Peterriver
//#define COLOR_WETASPHALT    ControlColor::Wetasphalt
//#define COLOR_SUNFLOWER     ControlColor::Sunflower
//#define COLOR_CARROT        ControlColor::Carrot
//#define COLOR_ALIZARIN      ControlColor::Alizarin
//#define COLOR_DARK          ControlColor::Dark
//#define COLOR_NONE          ControlColor::None
}
