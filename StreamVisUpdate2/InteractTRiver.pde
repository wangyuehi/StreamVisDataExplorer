public class InteractThemeRiver extends ThemeRiver {

  int rect_x1, rect_x2, rect_y1, rect_y2;/* for slice plot draw rect */
  /*highlight themeriver*/
  public final float DAY_WIDE ;
  public final float WEEK_WIDE ;
  public final float MONTH_WIDE;
  public final float SEASON_WIDE ;
  color high  =#bd9e39;
  public int MODE;
  public boolean[] highlighted;
  Detail detail;
  float RiverWidth = this.getWidth();
  boolean LINESHOW = false;
  int selectX1, selectY1, selectX2, selectY2; 
  public boolean shadowShow = false;
  public InteractThemeRiver(float viewX, float viewY, float viewWidth, float viewHeight, ThemeRiverModel model, boolean[] highlighted,float[][] origin_data, String[] xLabels,String[] yTitles) {
    super(viewX, viewY, viewWidth, viewHeight, model); 
   
    detail = new Detail(viewX, viewY, viewWidth, viewHeight);
    detail.setData(origin_data);
    detail.setAttrName(yTitles);
    detail.setXLabels(xLabels);
    
    DAY_WIDE = RiverWidth/366;
    WEEK_WIDE = RiverWidth/53;
    MONTH_WIDE = RiverWidth/12;
    SEASON_WIDE = RiverWidth/4;
    this.highlighted = highlighted;
  }

  void draw() {

    super.draw();

    if (isHighlighted) {//highlited from similarity plot
      for (int i = 0; i<highlighted.length; i++) {

        if (highlighted[i])
        {    
          drawHighlight(i);
        }
      }
    }
     if(shadowShow ){//for mouse in themeriver. the rect draw.
  
      highlightBasic( selectX1, selectX2-selectX1,high);
    }
    if (LINESHOW) {//for mouse in themeriver, the gray line. common with relation display

      stroke(axisColor);
      fill(axisColor);
      strokeWeight(2);
      line(mouseX, this.getY()+2, mouseX, this.getY()+this.getHeight()-2);
      strokeWeight(1);
      detail.draw();
      
    }
   
  }


  public void onMouseDragged(int x, int y) {
    selectY2 = y;
    selectX2 = x;
  }

  public void onMouseReleased(int x, int y) {
    selectY2 = y;
    selectX2 = x;
      if (isIntersectingWith( x, y)) {
      shadowShow = true;
    } else
    {
      shadowShow = false;
    }
    
  }
  public void onMousePressed(int x, int y) {
    selectX1 = x;
    selectY1 = y;
    onMouseDragged(x, y);
    
  }
  
  
  public float[] getSelectedRange(){
  
    float[] res = new float[2];
    res[0] = (selectX1 - this.getX())/this.getWidth();
    res[1] = (selectX2 - this.getX())/this.getWidth();
    
    return res;
    
  }
  
  public void riverHighlight(int Mode, boolean[] highlighted ) {
    this.highlighted = highlighted;
    this.MODE = Mode;

    this.highlight();
  }

  public void drawHighlight(int i) {
    /*first, choose proper width to highlight*/
    float highlightWidth = 10.f;
    switch(MODE) {
    case DAY: 
      highlightWidth = DAY_WIDE;
      break;
    case WEEK: 
      highlightWidth = WEEK_WIDE;
      break;
    case MONTH: 
      highlightWidth = MONTH_WIDE;
      break;
    case SEASON: 
      highlightWidth =SEASON_WIDE;
      break;
    }

   
    float posX = this.getX()+5+ highlightWidth*(i);

  highlightBasic( posX, highlightWidth,high);
  }

void highlightBasic(float posX, float highlightWidth,color c){
    
  float highlightHeight=this.getHeight() ;
 float posY = this.getY();

    pushMatrix();
    noStroke();
    fill(color(red(c), green(c), blue(c), 90));
    rect(posX, posY, highlightWidth, highlightHeight);
    popMatrix();

}
  float sum(float[] a) {
    float sum = 0;
    for (int i = 0; i<a.length; i++)
      sum+=a[i];

    return sum;
  }

  public void onMouseMoved(int x, int y) {
    if (isIntersectingWith( x, y)) {
      LINESHOW = true;
    } else
    {
      LINESHOW = false;
    }
  }

  float getPosition(int mouseX) {

    return ((mouseX - this.getX()) / (this.getWidth())) ;
  }
}

