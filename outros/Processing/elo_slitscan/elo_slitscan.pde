/**
 * Simple Real-Time Slit-Scan Program. 
 * By Golan Levin.
 *
 * This demonstration depends on the canvas height being equal 
 * to the video capture height. If you would prefer otherwise, 
 * consider using the image copy() function rather than the 
 * direct pixel-accessing approach I have used here. 
 */
 
 
import processing.video.*;


import ddf.minim.*;

Minim minim;
AudioInput in;


Capture video;

int videoSliceX;
int drawPositionX;

void setup() {
  size(1440, 426, P2D);
  
  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this,640, 426,60);
  
  // Start capturing the images from the camera
  video.start();  
  
  videoSliceX = video.width / 2;
  drawPositionX = width - 1;
  background(0);
  
  
  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  
  // uncomment this line to *hear* what is being monitored, in addition to seeing it
 // in.enableMonitoring();
  
  
}


int s;

void draw() {
  if (video.available()) {
    video.read();
    video.loadPixels();
    
    // Copy a column of pixels from the middle of the video 
    // To a location moving slowly across the canvas.
    loadPixels();
    s =  1+ int(in.left.get(1)*500);
    //println(in.left.get(1));
    //println(s);
    for (int y = 0; y < video.height; y=y+s){
      
      int setPixelIndex = y*width + drawPositionX;
      int getPixelIndex = y*video.width  + videoSliceX;
      pixels[setPixelIndex] = video.pixels[getPixelIndex];
    }
    updatePixels();
    
    drawPositionX--;
    if (drawPositionX < 0) drawPositionX = width - 1;
  }
  
  
  
  //  background(0);
  stroke(255);
  
  // draw the waveforms so we can see what we are monitoring
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
   // line( i, 50 + in.left.get(i)*500, i+1, 50 + in.left.get(i+1)*500 );
    //line( i, 150 + in.right.get(i)*500, i+1, 150 + in.right.get(i+1)*500 );
  }
  
  
}



void stop()
{
  // always close audio I/O classes
  in.close();
  // always stop your Minim object
  minim.stop();
 
  super.stop();
}
