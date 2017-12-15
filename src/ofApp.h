#pragma once

#include "ofxiOS.h"

#define TRACE_COUNT 2000

class ofApp : public ofxiOSApp
{
    
private:
    
    ofTrueTypeFont myfont;
    ofVec2f trace[TRACE_COUNT];
    ofVec2f touchPoint;
    ofColor startColor;
    ofColor finishColor;
    ofColor curColor;
    ofImage screenImg;
    
    int curIndexText;
    int posX,posY;
    int count;
    int curIndex;
    int myScreenWidth;
    int myScreenHeight;
    int stringWidth;
    int myRadious;
    int sizeOfText;
    
    float centerX;
    float centerY;
    
    float angleX,angleY,angleZ;
    
    string myText;
    
    bool isTouchDown;
    bool drawEnabled;
    
    
    //------- private methods area ----------------------------------//
    
    void setColor(int posY);
    void clearScreen();
    void drawFont();
    void saveScreen();
        
public:
    
    void setup();
    void update();
    void draw();
    void exit();
    
    void touchDown(ofTouchEventArgs & touch);
    void touchMoved(ofTouchEventArgs & touch);
    void touchUp(ofTouchEventArgs & touch);
    void touchDoubleTap(ofTouchEventArgs & touch);
    void touchCancelled(ofTouchEventArgs & touch);
    
    void lostFocus();
    void gotFocus();
    void gotMemoryWarning();
    void deviceOrientationChanged(int newOrientation);
    
};


