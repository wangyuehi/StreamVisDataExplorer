public class WeightGraph extends Viewport{

  float originX, originY;
  float lengthX, lengthY;
  float interval;
  int pointnum;
  float[] weight;
  float percent = 0.9;
  public  float[] Weight = {
    0.02, 0.03, 0.15, 0.3, 0.5
  }; 
  public WeightGraph(float viewX, float viewY, float viewWidth, float viewHeight, int num){
    super(viewX, viewY, viewWidth, viewHeight); 

    this.originX = this.getX() + 0.1 * this.getWidth() ;
    this.originY = this.getY() + 0.75 * this.getHeight();

    this.lengthX = 0.8 * this.getWidth();
    this.lengthY = 0.65 * this.getHeight();

    this.pointnum = num;
    interval = lengthX*0.8/pointnum;

    weight = new float[pointnum];
  }

  public void setWeight(float[] w) {

    Weight = w;
    pointnum = w.length;
  }
  public void draw() {
    this.drawOutline();
    
    pushMatrix();
    textSize(12);
    stroke(0);
    strokeWeight(1);
    /*X axis*/
    line(originX, originY, originX+lengthX, originY);
    textAlign(CENTER);
    fill(0);
    float posx =0 ;

    for (int i = 0; i<pointnum; i++) {
      posx = originX+(i+1)*interval;
      line(posx, originY, posx, originY+3);  
      if (i<pointnum-1)
        text("t-"+(pointnum-1-i), posx, originY+15) ;
      else
        text("t", posx-1, originY+15) ;
        
    }
    text("date",originX+lengthX-15,originY+15);

    /*Y axis*/
    line(originX, originY, originX, originY-lengthY);
    pushMatrix();
    translate(originX-4, originY-lengthY+20);
    rotate(-PI/2.0);
    
    text("weight",0,0);
popMatrix();
  //  line(originX, originY-lengthY*percent, originX+3, originY-lengthY*percent);

    /*weight*/
    pushMatrix();
    stroke(0);
      fill(255);
    strokeWeight(1);
    beginShape();
    curveVertex(originX+interval,originY-lengthY*percent*Weight[0]-10);
    for (int i = 0; i<pointnum; i++) {
      float x = originX+(i+1)*interval;
      float y = originY-lengthY*percent*Weight[i]-10;
     //fill(255);
      strokeWeight(1);
     curveVertex(x,y);
    }
     curveVertex(originX+(pointnum-1)*interval,originY-lengthY*percent*Weight[pointnum-1]-10);
     endShape();
    popMatrix();
    popMatrix();
  }
}
