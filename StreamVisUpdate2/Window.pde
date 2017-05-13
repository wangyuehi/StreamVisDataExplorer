public class WindowPlot extends RelationPlot {

  int windowSize = 4;
  float[][] points2D;
  LocationInfo loc2D ;
  float[][] data;
  int MODE = D2MODE;
  String[] xLabels;
  protected float transX, transY, scaleX, scaleY;
    protected int meshGridIntervalX = 45,meshGridIntervalY = 45;
  public WindowPlot(float viewX, float viewY, float viewWidth, float viewHeight, float[][] originData, float[][] points1D, float[][] points2D,String[] xLabels) {
    super(viewX, viewY, viewWidth, viewHeight, originData, points1D);
    this.points2D = points2D;
    loc2D = new LocationInfo(viewX, viewY, viewWidth, viewHeight, transform(points2D), D2MODE);
    data = points2D;
    updateLocationInfo();
    this.xLabels = xLabels;
  }

  void draw() {
    super.drawOutline();
   //  this.meshGrid( meshGridIntervalX,meshGridIntervalY );
    // super.drawPointsOnMouse();
    if (MODE == D1MODE)
    { 
      drawWindowLines();
      super.drawPointsOnMouse() ;
    } else
    { 
      drawWindowLines2D();
      drawPointsOnMouse() ;
    }
  }

  void setMODE(int mode) {
    MODE = mode;
    updateLocationInfo();
  }
  void updateLocationInfo() {
    if (MODE==D1MODE) {
      this.transX = super.transX;
      this.transY = super.transY;
      this.scaleX = super.scaleX;
      this.scaleY = super.scaleY;
      data = super.points;
    } else if (MODE == D2MODE) {
      this.transX = loc2D.transX;
      this.transY = loc2D.transY;
      this.scaleX = loc2D.scaleX;
      this.scaleY = loc2D.scaleY;
      data = points2D;
    }
  }
  void drawWindowLines() {


    pushMatrix();
    translate(transX, transY);     
    for (int i =0; i<data.length; i++) 
    {
      for (int k =super.indexOnMouse; k<super.indexOnMouse + windowSize; k++) {

        if (k<1)  k=1;
        if (k>359)  k=359;
        stroke(DEFAULT_COLORS[i]);
        strokeWeight(3*k/365);
        stroke(color(red(DEFAULT_COLORS[i]), green(DEFAULT_COLORS[i]), blue(DEFAULT_COLORS[i]), 300-60*(k-indexOnMouse)));
        line(k*super.scaleX, data[i][k]*(super.scaleY), (k+1)*super.scaleX, data[i][k+1]*(super.scaleY));
      }
    }
    popMatrix();
    strokeWeight(1);
  }

  void drawWindowLines2D() {

    int k = super.indexOnMouse- windowSize;
    pushMatrix();
    translate(transX, transY);
    for (int i =0; i<data.length; i++) 
    {
      if (k<1)
        k=1;
      if (k>359)
        k=359;

        beginShape();
  
        curveVertex(data[i][2*k]*(scaleX), data[i][2*k+1]*(scaleY));
      for (k = super.indexOnMouse - windowSize; k<=indexOnMouse; k++)
      {  
        if (k<1)
          k=1;
        if (k>359)
          k=359;


        
       // float gray = map(k, super.indexOnMouse - windowSize, indexOnMouse, 200, 255 );
        stroke(color(red(DEFAULT_COLORS[i]), green(DEFAULT_COLORS[i]), blue(DEFAULT_COLORS[i]), 255));  
        

        curveVertex(data[i][2*k]*(scaleX), data[i][2*k+1]*(scaleY));
        
        
      }
 curveVertex(data[i][2*(k-1)]*(scaleX), data[i][2*k-3]*(scaleY));  
        endShape();

      strokeWeight(1);
    }
    popMatrix();
  }

  void drawPointAt(int k) {
    indexOnMouse  = (int)k;
    this.highlight();
  }

  void drawPointsOnMouse() {
    if (isHighlighted) {
      int k = indexOnMouse;
      pushMatrix();
      translate(transX, transY);   
      for (int i =0; i<data.length; i++) {
        float w = super.baseWeight+abs(super.originData[i][k])*super.pointWeight;

        stroke(255);
        strokeWeight(w+3);

        point(data[i][2*k]*(scaleX), data[i][2*k+1]*(scaleY));

        stroke(DEFAULT_COLORS[i]);
        strokeWeight(w);

        point(data[i][2*k]*(scaleX), data[i][2*k+1]*(scaleY));
      }
      popMatrix();
      strokeWeight(1);
    
    stroke(0);
    textAlign(CENTER, CENTER);
    fill(0);
    text(getDate(indexOnMouse),this.getX()+ 3*this.getWidth()/4,this.getY() - 10);
  
   }
    
  }
  float[][] transform(float[][] data) {
    int index = 0;
    float[][] res = new float[2][5*data[0].length/2];
    for (int i = 0; i<data.length; i++) {

      for (int j = 0; j<data[0].length; j+=2) {

        res[0][index] = data[i][j];
        res[1][index++] = data[i][j+1];
      }
    }
    return res;
  }
   public String  getDate(int k) {
    int start=k-5, end=k;
    if (end>=xLabels.length) {

      end=xLabels.length-1;
    }
    if (end<0) {
      end=0;
    }
    if (start<0) {
      start=0;
    }


    return xLabels[start];
  }
}

