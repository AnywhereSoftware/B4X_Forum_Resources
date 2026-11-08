#pragma once
#include "B4RDefines.h"
#include <TFT_eSPI.h> 
#include "TFT_eWidget.h"
//*********************
// callback
//*********************



    //~Event: void OnpressAction_Sub(void)
    //~Event: void OnReleaseAction_Sub(void)
    //~Version: 1 
    //~Author - 
    //~Libray from Arduino https://github.com/Bodmer/TFT_eWidget

namespace B4R {
//**********************
//  ButtonWidget
//********************** 
    typedef void (*Subvoid_void)(void);

    //~shortname:ButtonWidget
    class B4RButtonWidget
    {
        private:
            uint8_t backend[sizeof(ButtonWidget)];
            ButtonWidget* butto;
            static B4RButtonWidget*  instance;
            Subvoid_void OnpressAction_Sub;
            Subvoid_void OnReleaseAction_Sub;
        public:    
            void initialize(ulong TFTid);
            void initButton(int16_t x, int16_t y, uint16_t w, uint16_t h, uint16_t outline, uint16_t fill, uint16_t textcolor, B4RString* label, byte textsize);
            void initButtonUL(int16_t x1, int16_t y1, uint16_t w, uint16_t h, uint16_t outline, uint16_t fill, uint16_t textcolor, B4RString* label, byte textsize);
            //  Default : datum = MC_DATUM
            void setLabelDatum(int16_t x_delta, int16_t y_delta, byte datum);
            void setPressAction(Subvoid_void OnpressActionSub);                             
            void setReleaseAction(Subvoid_void OnreleaseActionSub);
            static void btn_pressAction();
            static void btn_releaseAction();      
            void PressAction();
            void ReleaseAction();                               
            void setPressTime(uint32_t pressTime);                                                                 
            void setReleaseTime(uint32_t releaseTime);                                                             
            uint32_t getPressTime();                                                                               
            uint32_t getReleaseTime();
            //  Default : long_name = ""                                                                             
            void drawButton(bool inverted, B4RString* long_name);
            //  Default : inverted = false, outlinewidth = -1, bgcolor = 0x00FFFFFF, long_name = ""
            void drawSmoothButton(bool inverted, int16_t outlinewidth, uint32_t bgcolor, B4RString* long_name);
            bool contains(int16_t x, int16_t y);
            void press(bool p);
            bool isPressed();
            bool justPressed();
            bool justReleased();
            bool getState();
    };        
//*************    
// GraphWidget
//*************
    //~shortname:GraphWidget
    class B4RGraphWidget
    {
        private:
            uint8_t backend[sizeof(GraphWidget)];
            GraphWidget* graph;
        public: 
            uint32_t initialize(ulong TFTid);
            bool createGraph(uint16_t graphWidth, uint16_t graphHeight, uint16_t bgColor);
            void setGraphGrid(double xsval, double xinc, double ysval, double yinc, uint16_t gridColor);                
            void setGraphPosition(uint16_t x, uint16_t y);                                                              
            void getGraphPosition(ArrayUInt* x, ArrayUInt* y);                                                         
            void drawGraph(uint16_t x, uint16_t y);                                                                     
            void setGraphScale(double xmin, double xmax, double ymin, double ymax);                                     
            void getBoundingBox(ArrayInt* xs, ArrayInt* ys, ArrayInt* xe, ArrayInt* ye);                               
            void getBoundingRect(ArrayInt* x, ArrayInt* y, ArrayUInt* w, ArrayUInt* h);                                 
            int16_t getPointX(double xval);                                                                             
            int16_t getPointY(double yval);                                                                             
            bool addLine(double xs, double ys, double xe, double ye, uint16_t col);                                                                                   
    }; 
    
 
 
 //**********************
//  TraceWidget   
//**********************
    //~shortname:TraceWidget 
    class B4RTraceWidget 
    {
        private:
            uint8_t backend[sizeof(TraceWidget)];
            TraceWidget* trace;
        public:
            void initialize(ulong GWid);   
            void startTrace(uint16_t ptColor);
            bool addPoint(float xval, float yval);
            uint16_t getLastPointX();
            uint16_t getLastPointY();
    };
           
//**********************
//  MeterWidget   
//**********************
    //~shortname:MeterWidget 
    class B4RMeterWidget 
    {
        private:
            uint8_t backend[sizeof(MeterWidget)];
            MeterWidget*  meter;
        public:
            void initialize(ulong TFTid);
            void setZones(uint16_t rs, uint16_t re, uint16_t os, uint16_t oe, uint16_t ys, uint16_t ye, uint16_t gs, uint16_t ge);     
            void analogMeter(uint16_t x, uint16_t y, double fullScale, B4RString* units, B4RString* s0, B4RString* s1, B4RString* s2, B4RString* s3, B4RString* s4);
            void analogMeter1(uint16_t x, uint16_t y, double startScale, double endScale, B4RString* units, B4RString* s0, B4RString* s1, B4RString* s2, B4RString* s3, B4RString* s4);
            void updateNeedle(double value, uint32_t ms_delay);
    };   
    
    
//************************
// SliderParam
//*************************
    //~shortname:SliderParam 
    class B4RSliderParam
    {   friend class B4RSliderWidget;
        protected:
            slider_t  param;
        public:     
            void initialize(); 
  // createSlider param
            void setslotWidth(uint16_t value);                                                                //#Proc
            void setslotLength(uint16_t value);                                                               //#Proc
            void setslotColor(uint16_t value);                                                                //#Proc
            void setslotBgColor(uint16_t value);                                                              //#Proc
            void setorientation(bool value);                                                                  //#Proc
  // createKnob  param
            void setknobWidth(uint16_t value);                                                                //#Proc
            void setknobHeight(uint16_t value);                                                               //#Proc
            void setknobRadius(uint16_t value);                                                               //#Proc
            void setknobColor(uint16_t value);                                                                //#Proc
            void setknobLineColor(uint16_t value);                                                            //#Proc
  // setSliderScale param                                                                                              
            void setsliderLT(int16_t value);                                                                  //#Proc
            void setsliderRB(int16_t value);                                                                  //#Proc
            void setstartPosition(int16_t value);                                                             //#Proc
            void setsliderDelay(uint16_t value);                                                              //#Proc
    };   
    
    
         
//************************
// SliderWidget
//*************************
//    class B4RSliderParam;
    //~shortname:SliderWidget 
    class B4RSliderWidget
    {
        private:
            uint8_t backend[sizeof(SliderWidget)];
            SliderWidget*  slide;
            B4RSliderParam t;
        public:
            void initialize(uint32_t TFTid, uint32_t SPRid);
            void drawSlider(uint16_t x, uint16_t y);
            void drawSliderParam(uint16_t x, uint16_t y);
            bool createSlider(uint16_t slotWidth, uint16_t slotLength, uint16_t slotColor, uint16_t bgColor, bool orientation);
            void createKnob(uint16_t kwidth, uint16_t kheight, uint16_t kradius, uint16_t kcolor1, uint16_t kcolor2);
            void setSliderScale(int16_t min, int16_t max, uint16_t usdelay);                                                            
            void setSliderScale1(int16_t min, int16_t max);                                                                             
            void setSliderPosition(int16_t val);                                                                                        
            int16_t getSliderPosition(); 
            //ArrayLong xysxye(4) => xs as int=xysxye(0) ys as int=xysxye(1) xe as uint=xysxye(2) ye as uint=xysxye(3)                                                                                                
            void getBoundingBox(ArrayLong* xysxye);  
            //ArrayInt xywh(4) => x as int=xywh(0)  y as int=xywh(1) w as int=xywh(2) h as int=xywh(3)                                             
            void getBoundingRect(ArrayInt* xywh);                                                 
            bool checkTouch(uint16_t tx, uint16_t ty); 
    };                                                                                                         
}
