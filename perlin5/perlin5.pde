/*Fabio Vera
Music Visualizer for Processing

Takes audio from computer input and animates a set of lines based on level (volume) and beat detection. 
Animation always changing due to Perlin Noise.

*/





/*background shifts a little on beatdetection
  colors shift slowly, different color lines offset by i, stroke transparency different on each line 
  vertically mirrored figure added

  
  new in 3 
  colormode hsb allows for rainbow color transition
  duplicated parametric equations to be vertical and along background, (less transparent)
  duplicated animation to be mirrored for symmetry
*/

import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;
AudioInput player;
BeatDetect beat;


float t;  //for parametric equations
float t2;


int NUM_LINES = 15;  //number of lines for animation
float incr;
float SPEED = 4;


float linecolor;
float backg = 5;


void setup() {
  minim = new Minim(this);
  player = minim.getLineIn();
  beat = new BeatDetect();


  linecolor = 255;
  background(backg);
  size(1000,875);
  colorMode(HSB,100);
  
  noiseDetail(1);
  
}

void draw() {
  incr = player.left.level()*SPEED;

  beat.detect(player.mix);
    
  if( beat.isOnset() ) {
      linecolor = (linecolor + SPEED)%100;
  }

  background(backg);
  
  strokeWeight(3);
  
  linecolor = (linecolor + incr) % 100;
  
  translate(width/2,height/2);
  
  for (int i = 0; i< NUM_LINES; i++) {

    stroke((linecolor+2*i+linecolor-1)%100,100,100, i/2 ); //creates gradient between different lines
    
    //Set of Background Lines
    //line (x1(t+i),y1(t+i)+100,x2(t+i),y2(t+i)+100); 
    //line (x1(t2+i),-y1(t2+i)-200,x2(t2+i),-y2(t2+i)-200);
 
    //vertical pairs
 
    //line (y1(t2+i)-300,x1(t2+i),y2(t2+i)-300,x2(t2+i)); //middle bottom left incorrect
    line (-(y1(t2+i)+300),-x1(t2+i),-(y2(t2+i)+300),-x2(t2+i)); //left side top
    //line (y1(t2+i)+300,x1(t2+i),y2(t2+i)+300,x2(t2+i));  //right side bottom
    //line (-(y1(t2+i)-300),-x1(t2+i),-(y2(t2+i)-300),-x2(t2+i)); //middle top right incorrect
    
    line (y1(t+i),x1(t+i),y2(t+i),x2(t+i)); //middle bottom right correct
    line (-(y1(t+i)),-x1(t+i),-(y2(t+i)),-x2(t+i)); //middle top left correct
    //mirrored pairs  
  
    //line (-y1(t2+i)-300,x1(t2+i),-y2(t2+i)-300,x2(t2+i)); left side bottom
    line ((y1(t2+i)+300),-x1(t2+i),(y2(t2+i)+300),-x2(t2+i)); //right side top
    ///line (-y1(t2+i)+300,x1(t2+i),-y2(t2+i)+300,x2(t2+i)); middle bottom right incorrect
    //line ((y1(t2+i)-300),-x1(t2+i),(y2(t2+i)-300),-x2(t2+i)); //middle top left incorrect
    line (-y1(t+i),x1(t+i),-y2(t+i),x2(t+i)); //middle bottom left correct
    line ((y1(t+i)),-x1(t+i),(y2(t+i)),-x2(t+i)); //middle top right correct
    
    //Set of Foreground Lines
    stroke((linecolor+2*i)%100,100,100, 50 + i * 5 ); //creates gradient between different lines,transparency
    line (x1(t+i),y1(t+i),x2(t+i),y2(t+i));
    line (-(x1(t+i)),-y1(t+i),-(x2(t+i)),-y2(t+i));
    
    line (-x1(t+i),y1(t+i),-x2(t+i),y2(t+i));
    line ((x1(t+i)),-y1(t+i),(x2(t+i)),-y2(t+i));
  
}

  t = t+incr;

}





//param equations


float x1(float t) {

  return 600*noise(t/10);
}

float y1 (float t) {

  return 600*noise(t/10+10000);
}


float x2(float t) {

  return 600*noise(t/7+20000);
}

float y2 (float t) {
 
  return 500*noise(t/11+30000);
}