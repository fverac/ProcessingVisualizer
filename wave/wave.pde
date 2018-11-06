import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;

AudioInput player;
BeatDetect beat;


void setup() {
  colorMode(HSB,100);
  
  minim = new Minim(this);
  player = minim.getLineIn();
  beat = new BeatDetect();
  
  size(1000,800);
  noFill();
  
  stroke(100); //255
  strokeWeight(3);
  noiseDetail(1);
  beaty = new boolean[int(howmany)];
}
 float t = 0;
 float incr = 0;
 float level;
 float g = 0;
 
 int howmany = 50;
 float x;
 float y;
  
 boolean[] beaty;
 
 
 
void draw() {
  background(0);
  
  beat.detect(player.mix);

  
  level = player.left.level();
  incr = level*200 ;
  translate(width/2,height/2);
  

  float r;
  float thet = 0;
  
  for (int i = 0; i < howmany; i++){
    strokeWeight( map(i,0,howmany, 1, 12) );
    //stroke( (map(i,0,howmany, 0, 100) + t/30 )%100 ,100,100);
    x = map(i,0,howmany,-width/2,width/2);
    y = map(i,0,howmany,10,150)*sin( (x+t)/(50) );
    
    r = sqrt(x*x +y*y);
    
    if (x > 0 && y > 0) {
       thet = atan(y/x); 
    }
    else if (x == 0) {
      if (y > 0) { thet = PI/2; }
      else if (y < 0) { thet = 3*PI/2; }
      else thet = 0;
    }
    else if (y == 0) {
      if (x  > 0) { thet = 0; }
      else if (x < 0) { thet = PI;}
      
    }
    else if (x < 0) {
      thet = atan(y/x) + PI;
    }
    else thet = atan(y/x) + 2*PI;
    
    float x2 = r * cos(thet + 2*PI*noise(g/231) );    //+ g/329);
    float y2 = r * sin(thet + 2*PI*noise(g/124) );    // + g/491);
    
    

       point(x2,y2 );
       point(-x2,y2);
    

  }
  g += incr;
  t+=incr;
}
 