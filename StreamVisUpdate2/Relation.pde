public class RelationPlot extends Viewport {

  float[][] originData;
  float[][] points;
  LocationInfo location;
  protected float transX, transY, scaleX, scaleY;
  public int baseWeight = 6, pointWeight = 30;
  int indexOnMouse = 0;
  boolean LINESHOW = false;
    protected int meshGridIntervalX = 65,meshGridIntervalY = 30;
  /* points format:
   *
   *
   */
  public RelationPlot (float viewX, float viewY, float viewWidth, float viewHeight, float[][] originData, float[][] points) {
    super(viewX, viewY, viewWidth, viewHeight); 
    this.originData = originData;
    this.points = points;
    adjustLocation();
  }
  void adjustLocation() {

    location = new LocationInfo(this.getX(), this.getY(), this.getWidth(), this.getHeight(), points, D1MODE);
    location.setPartialY(0.8);
    location.setPartialX(0.98);

    scaleX = location.getScaleX();
    scaleY = location.getScaleY();
    transX = location.getTransX();
    transY = location.getTransY();
  }
  void draw() {
    this.drawOutline();
   // this.meshGrid( meshGridIntervalX, meshGridIntervalY );
    commonLine();
    drawLines();
    drawPointsOnMouse();
  }

  void drawLines() {

    pushMatrix();
    strokeWeight(2);
    translate(transX, transY);
    float[][] data = points;

    for (int i =0; i<data.length; i++) {
      stroke(DEFAULT_COLORS[i]);

      for ( int j = 0; j<data[0].length-1; j++) {
      line(j*scaleX, data[i][j]*(scaleY), (j+1)*scaleX, data[i][j+1]*(scaleY));
      }
    }
    
    
    
    popMatrix();
    strokeWeight(1);
  }
  void drawPointAt(float m) {

    indexOnMouse  = (int)m;
    this.highlight();
  }
  void drawPointsOnMouse() {
    if (isHighlighted) {
      int k = indexOnMouse;
      pushMatrix();
      translate(transX, transY);   
      for (int i =0; i<points.length; i++) {
        float w = baseWeight+abs(originData[i][k])*pointWeight;

        stroke(255);
        strokeWeight(w+3);

        point( k*scaleX, points[i][k]*(scaleY));

        stroke(DEFAULT_COLORS[i]);
        strokeWeight(w);

        point( k*scaleX, points[i][k]*(scaleY));
      }
      popMatrix();
      strokeWeight(1);
    }
  }
  void  commonLine() {
  pushMatrix();
    
      int k = indexOnMouse;
      stroke(axisColor);
      fill(axisColor);
      strokeWeight(2);
      line(k*scaleX+transX, this.getY()+2, k*scaleX+transX, this.getY()+this.getHeight()-2);
      strokeWeight(1);
   popMatrix();
  }
}

