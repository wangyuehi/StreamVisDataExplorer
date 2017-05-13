class TimeSliceSimilarity extends SimilarityBasic {


  color rectcolor =#ff7f0e;

  boolean RECTSHOW = false;

  boolean[] riverSelect;

  int rect_x1, rect_x2, rect_y1, rect_y2;/* for slice plot draw rect */
  
  protected boolean[] Highlighted;/*for label which point is in rect*/
  
  Detail detail;

  public TimeSliceSimilarity(float viewX, float viewY, float viewWidth, float viewHeight, 
  float[][] day, float[][] week, float[][] month, float[][] season, float[][] origin_data, String[] xLabels,String[] yTitles) {

    super(viewX, viewY, viewWidth, viewHeight, day, week, month, season, origin_data, xLabels);
    Highlighted = new boolean[xLabels.length];
    riverSelect = new boolean[xLabels.length];
    detail = new Detail(viewX, viewY, viewWidth, viewHeight);
    detail.setData(origin_data);
    detail.setAttrName(yTitles);
    detail.setXLabels(xLabels);
    initHighlighted();
   
    
  }

  void initHighlighted() {
    for (int i = 0; i<Highlighted.length; i++) {
      Highlighted[i] = false;
      riverSelect[i] = false;
    }
  }

  boolean[] getHighlighted() {
    return Highlighted;
  }
  void draw() {

    super.draw();

    pushMatrix();

    for (int i =0; i<super.daypoints[0].length; i++) {
      if (super.selected[i]||riverSelect[i]) {
        int diameter = 25;
        pieChart(diameter, super.origin_data[i], super.daypoints[0][i]*super.scaleX+super.transX, super.daypoints[1][i]*super.scaleY+super.transY);
        
      }
    } 

    popMatrix();
      
   for (int i =0; i<super.daypoints[0].length; i++) {
      if (super.selected[i]) {
       
         detail.draw(i);
         break;
      }
    } 

    drawRect() ;
  }

  void checkRiver(float x1, float x2) {
    int start = (int)(x1 * xLabels.length);
    int end = (int)(x2 * xLabels.length);

    for (int i = 0; i<xLabels.length; i++) {
      if (i>start&&i<end)
        riverSelect[i] = true;
      else 
        riverSelect[i] = false;
    }
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
  void UpdateHighlight() {
    for (int i = 0; i<daypoints[0].length; i++) {
      float x = daypoints[0][i]*scaleX+transX;
      float y = daypoints[1][i]*scaleY+transY;

      if (x>rect_x1&&x<rect_x2&&y>rect_y1&&y<rect_y2)
      {
        Highlighted[i] = true;
      } else {
        Highlighted[i] = false;
      }
    }
  }
  public void onMousePressed(int x, int y) {
    rect_x1 = x;
    rect_y1 = y;
    onMouseDragged(x, y);
    highSelectedPoint(x, y);
  }

  public int highSelectedPoint(int toX, int toY) {

    int last = -1;

    if (isIntersectingWith(toX, toY)) {

      float distmin = 3.0f;
      float dist;

      for (int i = 0; i<daypoints[0].length; i++) {
        float x = daypoints[0][i]*scaleX+transX;
        float y = daypoints[1][i]*scaleY+transY;
        dist = dist(x, y, toX, toY);
        if (dist<distmin)
        {
          if (selected[i]) {
            selected[i] = false;
          } else {
            selected[i] = true;
            last = i;
          }
        }
      }
    }


    return last;
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




}

