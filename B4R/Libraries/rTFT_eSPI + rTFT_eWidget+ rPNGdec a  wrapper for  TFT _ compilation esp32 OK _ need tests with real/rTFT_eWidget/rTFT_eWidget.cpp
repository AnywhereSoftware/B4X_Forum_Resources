#include "B4RDefines.h"

void btn_pressAction(void)
{
    B4R::B4RButtonWidget::btn_pressAction();
};

void btn_releaseAction(void)
{
    B4R::B4RButtonWidget::btn_releaseAction();
};

B4R::B4RButtonWidget*  B4R::B4RButtonWidget::instance = NULL;

namespace B4R
{
//**********************
//  ButtonWidget
//********************** 
    void B4RButtonWidget::initialize(ulong TFTid)
    {
       butto = new (backend) ButtonWidget((TFT_eSPI*) TFTid);
    };

    void B4RButtonWidget::initButton(int16_t x, int16_t y, uint16_t w, uint16_t h, uint16_t outline, uint16_t fill, uint16_t textcolor, B4RString* label, byte textsize)
    {
       butto->initButton(x, y, w, h, outline, fill, textcolor, (char*)label->data, textsize);
    };
                                        
    void B4RButtonWidget::initButtonUL(int16_t x1, int16_t y1, uint16_t w, uint16_t h, uint16_t outline, uint16_t fill, uint16_t textcolor, B4RString* label, byte textsize)
    {
       butto->initButtonUL(x1, y1, w, h, outline, fill, textcolor, (char*)label->data, textsize);
    };

    void B4RButtonWidget::setLabelDatum(int16_t x_delta, int16_t y_delta, byte datum)
    {
       butto->setLabelDatum(x_delta, y_delta, datum);
    };
    
    void B4RButtonWidget::btn_pressAction()
    { 
       instance->OnpressAction_Sub();
    };

    void B4RButtonWidget::btn_releaseAction()
    {
       instance->OnReleaseAction_Sub(); 
    };

    void B4RButtonWidget::setPressAction(Subvoid_void OnpressActionSub)
    {
       this->OnpressAction_Sub = OnpressActionSub;
       instance = this;    
       butto->setPressAction(btn_pressAction);
    };

    void B4RButtonWidget::setReleaseAction(Subvoid_void OnreleaseActionSub)
    { 
       this->OnReleaseAction_Sub = OnreleaseActionSub;
       instance = this;        
       butto->setReleaseAction(btn_releaseAction);
    };
    
    void B4RButtonWidget::PressAction()
    {
       butto->pressAction= dummyButtonAction;
    };
    
    void B4RButtonWidget::ReleaseAction()
    {
       butto->releaseAction= dummyButtonAction;
    }; 

    void B4RButtonWidget::setPressTime(uint32_t pressTime)
    {
       butto->setPressTime(pressTime);
    };

    void B4RButtonWidget::setReleaseTime(uint32_t releaseTime)
    {
       butto->setReleaseTime(releaseTime);
    };

    uint32_t B4RButtonWidget::getPressTime()
    {
       return butto->getPressTime();
    };

    uint32_t B4RButtonWidget::getReleaseTime()
    {
       return butto->getReleaseTime();
    };

    void B4RButtonWidget::drawButton(bool inverted, B4RString* long_name)
    {
       butto->drawButton(inverted, long_name->data);
    };

    void B4RButtonWidget::drawSmoothButton(bool inverted, int16_t outlinewidth, uint32_t bgcolor, B4RString* long_name)
    {
       butto->drawSmoothButton(inverted, outlinewidth, bgcolor, long_name->data);
    };

    bool B4RButtonWidget::contains(int16_t x, int16_t y)
    {
       return butto->contains(x, y);
    };

    void B4RButtonWidget::press(bool p)
    {
       butto->press(p);
    };

    bool B4RButtonWidget::isPressed()
    {
       return butto->isPressed();
    };

    bool B4RButtonWidget::justPressed()
    {
       return butto->justPressed();
    };

    bool B4RButtonWidget::justReleased()
    {
       return butto->justReleased();
    };

    bool B4RButtonWidget::getState()
    {
       return butto->getState();
    };


    
//*************    
// GraphWidget
//*************
    uint32_t B4RGraphWidget::initialize(ulong TFTid)
    {
       graph = new (backend) GraphWidget((TFT_eSPI*) TFTid);
       return (uint32_t) &graph;
    };

    bool B4RGraphWidget::createGraph(uint16_t graphWidth, uint16_t graphHeight, uint16_t bgColor)
    {
       return graph->createGraph(graphWidth, graphHeight, bgColor);
    };

    void B4RGraphWidget::setGraphGrid(double xsval, double xinc, double ysval, double yinc, uint16_t gridColor)
    {
       graph->setGraphGrid(xsval, xinc, ysval, yinc, gridColor);
    };

    void B4RGraphWidget::setGraphPosition(uint16_t x, uint16_t y)
    {
       graph->setGraphPosition(x, y);
    };

    void B4RGraphWidget::getGraphPosition(ArrayUInt* x, ArrayUInt* y)
    {
       graph->getGraphPosition((uint16_t*)x->data, (uint16_t*)y->data);
    };

    void B4RGraphWidget::drawGraph(uint16_t x, uint16_t y)
    {
       graph->drawGraph(x, y);
    };

    void B4RGraphWidget::setGraphScale(double xmin, double xmax, double ymin, double ymax)
    {
       graph->setGraphScale(xmin, xmax, ymin, ymax);
    };

    void B4RGraphWidget::getBoundingBox(ArrayInt* xs, ArrayInt* ys, ArrayInt* xe, ArrayInt* ye)
    {
       graph->getBoundingBox((int16_t*)xs->data, (int16_t*)ys->data, (int16_t*)xe->data, (int16_t*)ye->data);
    };

    void B4RGraphWidget::getBoundingRect(ArrayInt* x, ArrayInt* y, ArrayUInt* w, ArrayUInt* h)
    {
       graph->getBoundingRect((int16_t*)x->data, (int16_t*)y->data, (uint16_t*)w->data, (uint16_t*)h->data);
    };

    int16_t B4RGraphWidget::getPointX(double xval)
    {
       return graph->getPointX(xval);
    };

    int16_t B4RGraphWidget::getPointY(double yval)
    {
       return graph->getPointY(yval);
    };

    bool B4RGraphWidget::addLine(double xs, double ys, double xe, double ye, uint16_t col)
    {
       return graph->addLine(xs, ys, xe, ye, col);
    };



//**********************
//  TraceWidget   
//**********************
    void B4RTraceWidget::initialize(ulong GWid)
    {
        trace = new (backend)TraceWidget((GraphWidget*) GWid);
    };
    void B4RTraceWidget::startTrace(uint16_t ptColor)
    {
       trace->startTrace( ptColor);
    };
    bool B4RTraceWidget::addPoint(float xval, float yval)
    {  
       return trace->addPoint( xval, yval);
    };
    uint16_t B4RTraceWidget::getLastPointX()
    {
       return trace->getLastPointX();
    };
    uint16_t B4RTraceWidget::getLastPointY()
    { 
       return trace->getLastPointY(); 
    }; 
    
     

//**********************
//  MeterWidget   
//**********************
    void B4RMeterWidget::initialize(ulong TFTid)
    {
       meter = new (backend) MeterWidget((TFT_eSPI*) TFTid);
    };   

    void B4RMeterWidget::setZones(uint16_t rs, uint16_t re, uint16_t os, uint16_t oe, uint16_t ys, uint16_t ye, uint16_t gs, uint16_t ge)
    {
       meter->setZones(rs, re, os, oe, ys, ye, gs, ge);
    };

    void B4RMeterWidget::analogMeter(uint16_t x, uint16_t y, double fullScale, B4RString* units, B4RString* s0, B4RString* s1, B4RString* s2, B4RString* s3, B4RString* s4)
    {
       meter->analogMeter(x, y, fullScale, (char*) units->data, (char*)s0->data, (char*)s1->data, (char*)s2->data, (char*)s3->data, (char*)s4->data);
    };

    void B4RMeterWidget::analogMeter1(uint16_t x, uint16_t y, double startScale, double endScale, B4RString* units, B4RString* s0, B4RString* s1, B4RString* s2, B4RString* s3, B4RString* s4)
    {
 //      meter->analogMeter(x, y, startScale, endScale, (char*)units->data, (char*)s0->data, (char*)s1->data, (char*)s2->data, (char*)s3->data, (char*)s4->data);
    };

    void B4RMeterWidget::updateNeedle(double value, uint32_t ms_delay)
    {
       meter->updateNeedle(value, ms_delay);
    };



//************************
// SliderWidget
//*************************
    void B4RSliderWidget::initialize(uint32_t TFTid, uint32_t SPRid)
    {
       slide = new (backend)SliderWidget((TFT_eSPI*) TFTid, (TFT_eSprite*) SPRid);
    };
    
    void B4RSliderWidget::drawSlider(uint16_t x, uint16_t y)
    {
       slide->drawSlider(x, y);
    };

    void B4RSliderWidget::drawSliderParam(uint16_t x, uint16_t y) 
    {
       slide->drawSlider(x, y, t.param);
    };

    bool B4RSliderWidget::createSlider(uint16_t slotWidth, uint16_t slotLength, uint16_t slotColor, uint16_t bgColor, bool orientation)
    {
       return slide->createSlider(slotWidth, slotLength, slotColor, bgColor, orientation);
    };

    void B4RSliderWidget::createKnob(uint16_t kwidth, uint16_t kheight, uint16_t kradius, uint16_t kcolor1, uint16_t kcolor2)
    {
       slide->createKnob(kwidth, kheight, kradius, kcolor1, kcolor2);
    };

    void B4RSliderWidget::setSliderScale(int16_t min, int16_t max, uint16_t usdelay)
    {
       slide->setSliderScale(min, max, usdelay);
    };

    void B4RSliderWidget::setSliderScale1(int16_t min, int16_t max)
    {
       slide->setSliderScale(min, max);
    };

    void B4RSliderWidget::setSliderPosition(int16_t val)
    {
       slide->setSliderPosition(val);
    };

    int16_t B4RSliderWidget::getSliderPosition()
    {
       return slide->getSliderPosition();
    };

    void B4RSliderWidget::getBoundingBox(ArrayInt* xysxye)
    {
       int16_t* tmp = (int16_t*)xysxye->data;
       slide->getBoundingBox(&tmp[0], &tmp[1], &tmp[2], &tmp[3]);
    };

    void B4RSliderWidget::getBoundingRect(ArrayLong* xywh)
    {
       int32_t* tmp = (int32_t*)xywh->data;
       slide->getBoundingRect( &tmp[0], &tmp[1], &tmp[2], &tmp[3]);
    };                                

    bool B4RSliderWidget::checkTouch(uint16_t tx, uint16_t ty)
    {
       return slide->checkTouch(tx, ty);
    };


    
//************************
// SliderParam
//*************************
   void B4RSliderParam::initialize()
   {
      slider_t param;
     // createSlider
      param.slotWidth = 5;
      param.slotLength = 100;
      param.slotColor = TFT_GREEN;
      param.slotBgColor = TFT_BLACK;
      param.orientation = true;

      // createKnob
      param.knobWidth = 21;
      param.knobHeight =21;
      param.knobRadius = 5;
      param.knobColor = TFT_WHITE;
      param.knobLineColor = TFT_RED;

      // setSliderScale
      param.sliderLT = 0.0;
      param.sliderRB = 100.0;
      param.startPosition = 50;
      param.sliderDelay = 2000; 
   };
       
  // createSlider
   void B4RSliderParam::setslotWidth(uint16_t value)
   {
      param.slotWidth = value;
   };
   void B4RSliderParam::setslotLength(uint16_t value)
   {
      param.slotLength = value;
   };
   void B4RSliderParam::setslotColor(uint16_t value)
   {
      param.slotColor = value;
   };
   void B4RSliderParam::setslotBgColor(uint16_t value)
   {
      param.slotBgColor = value;
   };
   void B4RSliderParam::setorientation(bool value)     //bool
   {
      param.orientation = value;
   };
  // createKnob
   void B4RSliderParam::setknobWidth(uint16_t value)
   {
      param.knobWidth = value;
   };
   void B4RSliderParam::setknobHeight(uint16_t value)
   {
      param.knobHeight = value;
   };
   void B4RSliderParam::setknobRadius(uint16_t value)
   {
      param.knobRadius = value;
   };
   void B4RSliderParam::setknobColor(uint16_t value)
   {
      param.knobColor = value;
   };
   void B4RSliderParam::setknobLineColor(uint16_t value)
   {
      param.knobLineColor = value;
   };
  // setSliderScale
   void B4RSliderParam::setsliderLT(int16_t value)
   {
      param.sliderLT = value;
   };
   void B4RSliderParam::setsliderRB(int16_t value)
   {
      param.sliderRB = value;
   };
   void B4RSliderParam::setstartPosition(int16_t value)
   {
      param.startPosition = value;
   };
   void B4RSliderParam::setsliderDelay(uint16_t value)
   {
      param.sliderDelay = value;
   };

}
