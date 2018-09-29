/*
Music Visualizer for Processing

Takes audio from computer input and alters parameters to the "superfornula" based
on the level or volume of the audio. 

The "superformula" is a function that can be used to draw a variety of funky shapes.

https://en.wikipedia.org/wiki/Superformula

Perlin noise is also used to ensure "randomness" in the animation. 

Credit to Alexander Miller for tutorial on drawing superformula
https://www.youtube.com/watch?v=u6arTXBDYhQ
*/
import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;

AudioInput player;
BeatDetect beat;





void setup() {
  
  minim = new Minim(this);
  player = minim.getLineIn();
  beat = new BeatDetect();
  
  size(1000,800);
  noFill();
  
  stroke(255);
  strokeWeight(3);
  noiseDetail(2);
}
 float t = 0;
 float incr = 0;
 float level;


void draw() {
  level = player.left.level();
  incr = level*10 ;
 
 
 background(0);
 
 translate(width/2, height/2);
 
 beginShape();
 //add some vertices
 for(float theta = 0; theta <= 2* PI; theta += 0.01) {
   float rad = r(theta,
   2,  //a
   2,  //b
   20,  //m
   1,  //n1
   noise(t) * 4 - .5, //n2
   (1-noise(t+10000)) * 4 - .5 //n3
   );
   
   //convert from polar to cartesian coordinates
   float x = rad * cos(theta) * 50;
   float y = rad * sin(theta) * 50;
   
   vertex(x,y);
 }
 
 endShape();
 
 
 t += incr;
}




float r(float theta, float a,float b, float m, float n1, float n2, float n3) {
  return pow(pow(abs( cos(m * theta / 4.0) / a),n2) + pow(abs( sin(m * theta / 4.0) / b),n3), -1.0/n1);
}