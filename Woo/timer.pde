class timer{
 float last;
 float interval;
 
 void setup(){
   size (50,50);
   strokeWeight(15);
   last = millis();
   interval = 0;
   
 }
 
 void strokeChange(){
   if (millis() > last + interval)
   {
   last = millis();
   stroke(random(0,255),random(0,255),random(0,255));
   }
 }
   
 
 void draw(){
   strokeChange();
   ellipse (900,400,50, 50);
 }
}