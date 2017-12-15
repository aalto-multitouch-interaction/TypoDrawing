#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup()
{
    posX = 100;
    posY = 100;
    
    angleX = 0;
    angleY = 0;
    angleZ = 0;
    
    curIndexText = 0;
    
    myRadious = 25;
    
    count = 0;
    curIndex = 0;
    
    startColor = ofColor::orangeRed;
    finishColor = ofColor::blueSteel;
    curColor = startColor;
    
    myText = "multitouch interaction";
    
    sizeOfText = myText.length();
    
    ofBackground(0);
    
    ofSetColor(255);
    
    ofSetBackgroundAuto(false);
    
    ofEnableSmoothing();
    ofSetCircleResolution(100);
    
    touchPoint.set(-100,0);
    
    myScreenWidth = ofGetScreenWidth();
    myScreenHeight = ofGetScreenHeight();
    
    centerX = (myScreenWidth/2);
    centerY = (myScreenWidth/2);
    
    ofxAccelerometer.setup();
    
    myfont.load("ITCAvantGardePro-Bk.otf", 200 , true , true , true);
    
    stringWidth = myfont.stringWidth(myText)/2;
}

//------------------ private method ----------------------------

void ofApp::setColor(int posY)
{
    float amount;
    string temp;
    
    amount = ofMap(posY , 0 , ofGetScreenHeight() , 0 , 1);
    
    curColor.lerp(finishColor, amount);
    
    ofSetColor(curColor,230);
    
    curColor = startColor;
}

void ofApp::clearScreen()
{
    ofSetColor(0);
    
    ofFill();
    
    ofDrawRectangle(0, 0, myScreenWidth, myScreenHeight);
}

void ofApp::saveScreen()
{
    screenImg.allocate(ofGetWidth(), ofGetHeight(), OF_IMAGE_COLOR_ALPHA);
    
    screenImg.grabScreen(0, 0 , ofGetWidth(), ofGetHeight()-51);
    
    screenImg.save("screenshot.png");
    
    printf("the screen saved\n");
}

void ofApp::drawFont()
{
    float angle;
    float yDiff;
    float xDiff;
    float dist;
    string temp;
    
    setColor(trace[curIndex].y);
    
    if (drawEnabled == true)
    {
        ofPushMatrix();
        
        ofTranslate(trace[curIndex].x , trace[curIndex].y);
        
        yDiff = (trace[curIndex+1].y - trace[curIndex].y);
        xDiff = (trace[curIndex+1].x - trace[curIndex].x);
        
        angle = atan2f(yDiff, xDiff);
        
        angle = ofRadToDeg(angle);
        
        dist = trace[curIndex+1].distance(trace[curIndex]) * 1.5;
        
        temp = myText.at(curIndexText++);
        
        if (curIndexText >= sizeOfText)
        {
            curIndexText = 0;
        }
        
        if (curIndex < (count-1))
        {
            ofRotateZ(angle);
            
            ofScale(dist/100, dist/100);
            
            //myfont.drawStringAsShapes(temp, 0, 0);
            
            myfont.drawString(temp ,0,0);
        }
        
        curIndex++;
        
        if (curIndex >= count)
        {
            drawEnabled = false;
        }
        
        ofPopMatrix();
    }
}




//-------------------------- public method -------------------------
void ofApp::update()
{
    angleX += ofxAccelerometer.getForce().y;
    angleY += ofxAccelerometer.getForce().x;
    angleZ += ofxAccelerometer.getForce().z;
}



//--------------------------------------------------------------
void ofApp::draw()
{
    drawFont();
    
    ofSetColor(0);
    
    ofDrawRectangle(0, ofGetScreenHeight()-50, ofGetScreenWidth(), ofGetScreenHeight()-50);
    
    ofSetColor(128);
    
    ofDrawLine(0,ofGetScreenHeight()-50 , ofGetScreenWidth() , ofGetScreenHeight()-50);
    
    ofPushMatrix();
    
    ofTranslate(20, ofGetScreenHeight()-25);
    
    ofScale(0.1,0.1);
    
    myfont.drawString("touch here to save your screen!",0,0);
    
    ofPopMatrix();
}

//--------------------------------------------------------------
void ofApp::exit()
{
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs &touch)
{
    isTouchDown = true;
    
    count = 0;
    curIndex = 0;
    curIndexText = 0;
    
    if (touch.y > ofGetScreenHeight() -50)
    {
        saveScreen();
    }
    
    touchPoint.set(touch.x , touch.y);
    
    
    if (touch)
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs &touch)
{
    touchPoint.set(touch.x , touch.y);
    
    if (isTouchDown == true)
    {
        trace[count++].set(touch.x, touch.y);
        
        ofFill();
        
        //setColor(touchPoint.y);
        
        //ofDrawCircle(touchPoint.x, touchPoint.y, myRadious);
        
        if (count >= TRACE_COUNT)
        {
            count = (TRACE_COUNT -1);
            
            printf("maximum %d \n",count);
        }
    }
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs &touch)
{
    isTouchDown = false;
    drawEnabled = true;
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs &touch)
{
    clearScreen();
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs &touch)
{
    
}

//--------------------------------------------------------------
void ofApp::lostFocus()
{
    
}

//--------------------------------------------------------------
void ofApp::gotFocus()
{
    
}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning()
{
    
}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation)
{
    
}

