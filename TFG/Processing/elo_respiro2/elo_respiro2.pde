/**
 * This sketch demonstrates how to play a file with Minim using an AudioPlayer. <br />
 * It's also a good example of how to draw the waveform of the audio.
 * <p>
 * For more information about Minim and additional features, 
 * visit http://code.compartmental.net/minim/
 */

import ddf.minim.*;

import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

import processing.serial.*;


int currFile = 7;

Minim minim;
//\\AudioPlayer player;
AudioPlayer[] respFiles;

Serial myPort;  // Create object from Serial class



void setup()
{
  size(500, 200);
  //println(dataPath(""));

  //println(Serial.list());
  String portName = "/dev/cu.usbmodemfd121";//Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 115200);
  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);
  setupFiles();
  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  //player = minim.loadFile("EDITADO_normal.wav");
  //player = minim.loadFile("julia_bocejo.wav");
  //player = minim.loadFile("insp.wav");

  // play the file from start to finish.
  // if you want to play the file again, 
  // you need to call rewind() first.
  //player.play();
  //println(player.bufferSize());
}

float tot;
int avg;

float tot1;
int avg1 = 50;
int bg;

void draw()
{
  background(bg, bg, 0);



  if (!respFiles[currFile].isPlaying()) {
    respFiles[currFile].pause();
    respFiles[currFile].rewind();
    int nextFileNum = currFile + 1;
    currFile = nextFileNum % respFiles.length;
    respFiles[currFile].play();
    println("Playing file #"+currFile);
  }





  tot = 0;

  for (int i = 0; i < respFiles[currFile].bufferSize() - 1; i++)
  {

    respFiles[currFile].left.get(i);

    tot += abs(respFiles[currFile].left.get(i));
  }


  //println(avg1);
  //avg = int(tot*8);
  avg1 = int((avg1*3 + tot)/4);

  bg = constrain(avg1*15, 0, 255);
  //bg = int(map(bg, 0,255, 10,80));
  myPort.write(bg);
  //myPort.write(255);
  println(bg);
  if (bg>254) {
    //println(bg);
  }
}

