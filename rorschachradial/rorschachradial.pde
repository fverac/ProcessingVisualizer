/* Fabio Vera
Music Visualizer for Processing

An alternative visualization of system sound.

Made using 2D Perin Noise.

*/

import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;

AudioInput player;
BeatDetect beat;


float t;
float t2;


int NUM_LINES = 15;
float incr;
float SPEED = 2;

float backg = 5;


float level;



void setup() {
  minim = new Minim(this);
  player = minim.getLineIn();
  beat = new BeatDetect();


  background(backg);
  size(1000,875);
  colorMode(HSB,100);
  strokeWeight(10);
  
  stroke(50,20,100);
  
  noiseDetail(4);
    

}

void draw() {
  level = player.left.level();
  incr = level*SPEED;

  
  fill(0,0,0, 3);
  stroke(0,0,0,100);
  rect(0,0,width,height);
  
  stroke(50,20,100);
  
  for (int i = 0; i< 501; i= i +8) {
    for (int j = 0; j< 875; j = j+8) {
      if ( 
      noise(i*0.015, j*0.015, t)*log(level+1)/log(5)/ (  sqrt( (500-i)*(500-i)+(437-j)*(437-j) )  )  > 0.00003) {
        if (i == 500) {
          point(i,j);
        }
        else{
          point(i,j);
          point(1000-i,j);
        }
      }
    }
    
  }
  

  t = t+incr;

}