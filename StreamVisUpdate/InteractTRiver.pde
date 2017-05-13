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
  float RiverWidth = this.getWidth();
boolean LINESHOW = false;
  public InteractThemeRiver(float viewX, float viewY, float viewWidth, float viewHeight, ThemeRiverModel model,boolean[] highlighted) {
    super(viewX, viewY, viewWidth, viewHeight, model); 
    
    DAY_WIDE = RiverWidth/366;
    WEEK_WIDE = RiverWidth/53;
    MONTH_WIDE = RiverWidth/12;
    SEASON_WIDE = RiverWidth/4;
    this.highlighted = highlighted;
    
  }

void draw(){
  
super.draw();

if(isHighlighted){//highlited from similarity plot
for (int i = 0; i<highlighted.length; i++) {

      if (highlighted[i])
      {    
        drawHighlight(i);
      }
    }
}
if(LINESHOW){//for mouse in themeriver, the gray line. common with relation display

 stroke(axisColor);
    fill(axisColor);
    strokeWeight(2);
    line(mouseX, this.getY()+2, mouseX, this.getY()+this.getHeight()-2);
    strokeWeight(1);
}
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



    float highlightHeight=this.getHeight() ;
    float posY = this.getY();
    float posX = this.getX()+5+ highlightWidth*(i);

    pushMatrix();
    noStroke();
    fill(color(red(high), green(high), blue(high), 90));
    rect(posX, posY, highlightWidth, highlightHeight);
    popMatrix();
  }
  
  float sum(float[] a) {
    float sum = 0;
    for (int i = 0; i<a.length; i++)
      sum+=a[i];

    return sum;
  }
  
    public void onMouseMoved(int x,int y){
  if(isIntersectingWith( x, y)){
      LINESHOW = true;
  
  }
  else
  {
      LINESHOW = false;
  }
  }
  
  float getPosition(int mouseX){
    
    return ((mouseX - this.getX()) / (this.getWidth())) ;
    
  }
}

