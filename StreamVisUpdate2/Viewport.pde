public class Viewport{

  protected float viewX;
  protected float viewY;
  protected float viewWidth;
  protected float viewHeight;
  protected float viewCenterX;
  protected float viewCenterY;
  protected boolean isHighlighted;

  public Viewport(){
    this(-1.0f, -1.0f, -1.0f, -1.0f); //ad-hoc
  }
  public Viewport(float viewX, float viewY, float viewWidth, float viewHeight){
    this.set(viewX, viewY, viewWidth, viewHeight);
    this.dehighlight();
  }

  public void set(float viewX, float viewY, float viewWidth, float viewHeight){
    this.viewX = viewX;
    this.viewY = viewY;
    this.viewWidth = viewWidth;
    this.viewHeight = viewHeight;
    this.updateCenter();
  }
  public void setX(float viewX){
    this.viewX = viewX;
    this.updateCenter();
  }
  public void setY(float viewY){
    this.viewY = viewY;
    this.updateCenter();
  }
  public void setWidth(float viewWidth){
    this.viewWidth = viewWidth;
    this.updateCenter();
  }
  public void setHeight(float viewHeight){
    this.viewHeight = viewHeight;
    this.updateCenter();
  }
  private void updateCenter(){
    this.viewCenterX = this.viewX + this.viewWidth / 2.0f;
    this.viewCenterY = this.viewY + this.viewHeight / 2.0f;
  }
  public void highlight(){
    this.isHighlighted = true;
  }
  public void dehighlight(){
    this.isHighlighted = false;
  }

  public float getX(){
    return this.viewX;
  }
  public float getY(){
    return this.viewY;
  }
  public float getWidth(){
    return this.viewWidth;
  }
  public float getHeight(){
    return this.viewHeight;
  }
  public float getCenterX(){
    return this.viewCenterX;
  }
  public float getCenterY(){
    return this.viewCenterY;
  }
  public boolean isHighlighted(){
    return this.isHighlighted;
  }
  public void drawOutline(){
    pushMatrix();
    
    stroke(200);
    fill(255);
    rect(viewX+1,viewY+1,viewWidth-3,viewHeight-3);
 
    popMatrix();
    
  
 }
  public boolean isIntersectingWith(int x, int y){
    if(this.viewX <= x && x <= this.viewX + this.viewWidth){
      if(this.viewY <= y && y <= this.viewY + this.viewHeight)
        return true;
      else
        return false;
    }else{
      return false;
    }
  }
  
  public void meshGrid(int interval){
    int row = (int)(viewWidth/interval)+1;
    int col = (int)(viewHeight/interval)+1;
    int stepsX = (int)(viewWidth / 6);
    int stepsY = (int)(viewHeight / 6);
    for(int i = 1;i<row;i++){
      int x = (int)(this.getX()+interval * i);
      for(int j = 1;j<col;j++){
        int y =(int)( this.getY()+interval * j);
        
        dottedLine(this.getX()+2,y, this.getX()+this.getWidth()-2,y,stepsX);
      }
    dottedLine(x,this.getY()+2, x,this.getY()+this.getHeight()-2,stepsY);
    }
    
  }
    public void meshGrid(int intervalX,int intervalY){
    int row = (int)(viewWidth/intervalX)+1;
    int col = (int)(viewHeight/intervalY)+1;
    int stepsX = (int)(viewWidth / 6);
    int stepsY = (int)(viewHeight / 6);
    for(int i = 1;i<row;i++){
      int x = (int)(this.getX()+intervalX * i);
      for(int j = 1;j<col;j++){
        int y =(int)( this.getY()+intervalY * j);
        
        dottedLine(this.getX()+2,y, this.getX()+this.getWidth()-2,y,stepsX);
      }
    dottedLine(x,this.getY()+2, x,this.getY()+this.getHeight()-2,stepsY);
    }
    
  }
  void dottedLine(float x1, float y1, float x2, float y2, float steps){
 for(int i=0; i<=steps; i++) {
   float x = lerp(x1, x2, i/steps);
   float y = lerp(y1, y2, i/steps);
    strokeWeight(1);
 
    stroke(200);
   point(x, y);
   
 }
}

}
