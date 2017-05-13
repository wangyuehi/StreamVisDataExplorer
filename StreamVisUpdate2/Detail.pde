public class Detail extends Viewport {
  /*row1: attributes
   *col1: dates
   */
  color rectColor = #898686;
  float[][] originData;
  String[] attrName;
  String[] xLabels;
  int flipX, flipY;
  int rectX = 100, rectY = 100;
  
  public Detail(float viewX, float viewY, float viewWidth, float viewHeight) {
    super(viewX, viewY, viewWidth, viewHeight); 
    flipX = (int)(this.getX() + this.getWidth() )/2;
    flipY = (int)((this.getY() + this.getHeight()) - rectY - 10);
  }

  public void setData(float[][] data) {
    originData = data;
  }

  public void setAttrName(String[] data) {
    attrName = data;
  }
  
  public void setXLabels(String[] data) {
    xLabels = data;
  }

  public void draw(int i) {
    /*
     *  mouse location (x ,y), show k-th data 
     */
 
    PVector location = getLocation();
    pushMatrix();
    fill(red(rectColor), green(rectColor), blue(rectColor), 200);
    rect( location.x, location.y,rectX, rectY);
   
    translate(location.x+5,location.y+20);
    drawText(i);
    popMatrix();
    
    
    
  }
  public void draw() {
    /*
     *  mouse location (x ,y), show k-th data 
     */
 
    PVector location = getLocation();
    pushMatrix();
    fill(red(rectColor), green(rectColor), blue(rectColor), 200);
    rect( location.x, location.y,rectX, rectY);
   
    translate(location.x+5,location.y+20);
    drawText();
    popMatrix();
    
    
    
  }
  public PVector getLocation() {
    PVector v1 = new PVector();

    v1.x = mouseX < flipX ? (mouseX + 10) : (mouseX - rectX -10 );
    v1.y = mouseY < flipY ? (mouseY) : (mouseY - rectY );
    return v1;
  }
  
  public int getK() {
    int k =(int) (originData.length*(mouseX - this.getX())/this.getWidth());
    if(k<0)k=0;
    return k < originData.length ? k : originData.length - 1;
  }

  public void drawText(int k) {

    int lineSpace = 15;

    
    stroke(0);
    fill(0);
    textSize(12);

    fill(255);
    textAlign(LEFT, BOTTOM);
    text(getXLabel(k), 0, 0); 
    for(int i = 0;i< attrName.length;i++){
      text(getAttrName(i)+":"+getDataEntry(k,i),0,lineSpace*(i+1) );
    }


  }
  
  public void drawText() {

    int lineSpace = 15;
    int k = getK();
    
    stroke(0);
    fill(0);
    textSize(12);

    fill(255);
    textAlign(LEFT, BOTTOM);
    text(getXLabel(k), 0, 0); 
    for(int i = 0;i< attrName.length;i++){
      text(getAttrName(i)+":"+getDataEntry(k,i),0,lineSpace*(i+1) );
    }


  }
  public String getXLabel(int k) {
    return xLabels[k];
  }
  public String getAttrName(int k) {
    return attrName[k];
  }
  public float getDataEntry(int k,int i) {
    return originData[k][i];
  }

}

