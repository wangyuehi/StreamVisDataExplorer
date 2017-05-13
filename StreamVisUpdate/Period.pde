import controlP5.*;
public class Period extends Viewport{
  ControlP5 cp5;
  PImage img;
  LocationInfo loc;
  float[][] data;
  int scaleX,scaleY,transX,transY;
  float originX,originY,lengthX, lengthY;
  float offset = 16;
  public Period(float viewX, float viewY, float viewWidth, float viewHeight, float[][] data,ControlP5 cp5){
    super(viewX, viewY, viewWidth, viewHeight); 
    this.cp5 = cp5;
    this.data = data;
    loc = new LocationInfo(this.getX(),this.getY(),this.getWidth(),this.getHeight(),data,D2MODE);
    loc.setPartialX(0.9);
    
    scaleX = (int)loc.getScaleX();
    scaleY = (int)loc.getScaleY();
    transX = (int)loc.getTransX();
    transY = (int)loc.getTransY();
    originX = this.getX() + offset;
    originY = this.getY() + this.getHeight()-offset;
    lengthX = this.getWidth()-(offset+2);
    lengthY = this.getHeight() - (offset+2);
    
  }
  
  void draw(){
    this.drawOutline();
    //this.meshGrid(30);
    showExcel();
    showAxis();
  }


void showExcel(){
  pushMatrix();

  translate(transX+10,transY-20);

  //stroke(periodLineColor);
  color test=#1f77b4;
  stroke(test);
  for(int i = 0;i<data[0].length-1;i++){
 
    line(data[0][i]*scaleX,this.getHeight() - data[1][i]*scaleY,data[0][i+1]*scaleX,this.getHeight() - data[1][i+1]*scaleY);

  }
  popMatrix();
  
}

void showAxis(){
  stroke(100);
  fill(100);
  line(originX, originY, originX, originY-lengthY);
   line(originX, originY, originX+lengthX, originY);
    pushMatrix();
    translate(originX-4, originY-lengthY+30);
    rotate(-PI/2.0);
    
    text("Spectrum",0,0);
popMatrix();
pushMatrix();
    translate(originX+lengthX-20, originY+12);
   
    
    text("f(Hz)",0,0);
popMatrix();
int interval = 40;
int pointnum = 4;
  for (int i = 0; i<pointnum; i++) {
      float posx = originX+(i+1)*interval;
      line(posx, originY, posx, originY+3);  
    ;
         text(""+(i+1)*(0.1), posx-1, originY+12) ;
    }

}


}
