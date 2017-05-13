class TimeSliceSimilarity extends SimilarityBasic {


  color rectcolor =#ff7f0e;

  boolean RECTSHOW = false;
  

  int rect_x1, rect_x2, rect_y1, rect_y2;/* for slice plot draw rect */
  protected boolean[] Highlighted;/*for label which point is in rect*/

  public TimeSliceSimilarity(float viewX, float viewY, float viewWidth, float viewHeight, 
  float[][] day, float[][] week, float[][] month, float[][] season, float[][] origin_data, String[] xLabels) {

    super(viewX, viewY, viewWidth, viewHeight, day, week, month, season, origin_data, xLabels);
    Highlighted = new boolean[xLabels.length];
 
    initHighlighted();
  }
  
  void initHighlighted() {
    for (int i = 0; i<Highlighted.length; i++) {
      Highlighted[i] = false;
    }
  }
  
  boolean[] getHighlighted(){
  return Highlighted;
  }
  void draw() {

    super.draw();

    pushMatrix();
    translate(super.transX, super.transY);
    for (int i =0; i<super.daypoints[0].length; i++) {
      if (super.selected[i]) {
        int diameter = 25;
        pieChart(diameter, super.origin_data[i], super.daypoints[0][i]*super.scaleX, super.daypoints[1][i]*super.scaleY);
        drawText(i);
      }
    } 
    popMatrix();
    drawRect() ;

  }

  void pieChart(float diameter, float[] data, float x, float y) {
    float lastAngle = 0;
    for (int i = 0; i < data.length; i++) {

      noStroke();
      fill(255);
      arc(x, y, diameter+5, diameter+5, lastAngle, lastAngle+radians(data[i]*360/sum(data)));

      fill(DEFAULT_COLORS[i]);

      arc(x, y, diameter, diameter, lastAngle, lastAngle+radians(data[i]*360/sum(data)));
      lastAngle +=radians(data[i]*360/sum(data));
    }
  }

  float sum(float[] a) {
    float sum = 0;
    for (int i = 0; i<a.length; i++)
      sum+=a[i];

    return sum;
  }

  void drawRect() {
    if (RECTSHOW) {
      float sizex = rect_x2-rect_x1;
      float sizey = rect_y2-rect_y1;
      pushMatrix();
      stroke(120);
      noFill();

      strokeWeight(1.5);
      stroke(color(red(rectcolor), green(rectcolor), blue(rectcolor)));
      rect(rect_x1, rect_y1, sizex, sizey);
      popMatrix();
      UpdateHighlight();
    }
  }
void UpdateHighlight(){
for (int i = 0; i<daypoints[0].length; i++) {
      float x = daypoints[0][i]*scaleX+transX;
      float y = daypoints[1][i]*scaleY+transY;

      if (x>rect_x1&&x<rect_x2&&y>rect_y1&&y<rect_y2)
      {
          Highlighted[i] = true;
      }
      else{
          Highlighted[i] = false;
      }
      
    }

}
  public void onMousePressed(int x, int y) {
    rect_x1 = x;
    rect_y1 = y;
    onMouseDragged(x, y);
  }


  void onMouseReleased(int x, int y) {

    rect_x2 = x;
    rect_y2 = y;

    if (isIntersectingWith(rect_x1, rect_y1)&&isIntersectingWith(rect_x2, rect_y2)) {
      RECTSHOW = true;
    }
  }

  void onMouseDragged(int x, int y) {

    rect_x2 = x;
    rect_y2 = y;
  }




  public void drawText(int i) {
    pushMatrix();

    float x = this.getX()-transX+10;
    float y = this.getY()+this.getHeight()-transY-5;

    stroke(0);
    fill(0);

    textSize(12);
    switch(super.SliceMode) {

    case SEASON:
      stroke(255);
      fill(255);
      rect(x, y-15, 100, 15);

      fill(0);
      textAlign(LEFT, BOTTOM);
      text(getDateSeason(i), x, y); 
      break;

    case MONTH:
      stroke(255);
      fill(255);
      rect(x, y-15, 100, 15);

      fill(0);
      textAlign(LEFT, BOTTOM);
      text(getDateMonth(i), x, y); 
      break;

    case WEEK:
      stroke(255);
      fill(255);
      rect(x, y-15, 100, 15);

      fill(0);
      textAlign(LEFT, BOTTOM);
      text(getDateWeek(i), x, y); 
      break;

    case DAY:
      stroke(255);
      fill(255);
      rect(x, y-15, 100, 15);

      fill(0);
      textAlign(LEFT, BOTTOM);
      text(getDateday(i), x, y); 

      break;
    }
    popMatrix();
  }
  public String getDateday(int k) {

    if (k>=super.xLabels.length) {
      k = super.xLabels.length;
    }

    if (k<0) {
      k=0;
    }


    return xLabels[k];
  }

  public String getDateMonth(int k ) {

    if (k>12)
      k=12;
    if (k<0)
      k=0;

    String[] month = {
      "2010/1", "2010/2", "2010/3", "2010/4", "2010/5", "2010/6", "2010/6", "2010/7", "2010/8", "2010/9", "2010/10", "2010/11", "2010/12"
    };
    return month[k];
  }
  public String getDateSeason(int k ) {

    if (k>4)
      k=4;
    if (k<0)
      k=0;

    String[] season = {
      "2010/1-2010/3", "2010/4-2010/6", "2010/7-2010/9", "2010/10-2010/12"
    };
    return season[k];
  }

  public String getDateWeek(int k ) {
    if (k>52)
      k=52;
    if (k<0)
      k=0;
    return super.xLabels[(k)*7]+"-"+super.xLabels[(k+1)*7-1];
  }
}

