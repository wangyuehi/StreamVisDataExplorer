import controlP5.*;
public class ControlPane extends Viewport {
  ControlP5 cp5;
  DropdownList sliceList, matrix,weight, Local,global;
/**   slice Mode location   **/
final int SliceLabelX = 325;
final int SliceLabelY = 50;
final int SliceListX = SliceLabelX;
final int SliceListY = SliceLabelY + 25;

/**   matrix location   **/
final int matrixLabelX = 440;
final int matrixLabelY = 50;
final int matrixX = matrixLabelX;
final int matrixY = matrixLabelY +25;

/**    Weight fun location   **/
final int weightLabelX = 330;
final int weightLabelY = 205;
final int weightX = weightLabelX +110;
final int weightY =weightLabelY+5;
   
   
/**   Local confic location   **/
final int LocalLabelX = 440, LocalLabelY = 100;
final int LocalX =  LocalLabelX;
final int LocalY =  LocalLabelY + 25;
/**   Global confic location   **/
final int GlobalLabelX = 440, GlobalLabelY = 140;
final int GlobalX =  GlobalLabelX;
final int GlobalY =  GlobalLabelY + 25;
     PFont font;
  public ControlPane(float viewX, float viewY, float viewWidth, float viewHeight, ControlP5 cp5) {
    super(viewX, viewY, viewWidth, viewHeight);
    this.cp5 = cp5;
 font= createFont("Helvetica", 7);
  // cp5.setControlFont(new ControlFont(createFont("Helvetica", 12), 12));
   // cp5.setFont(font);

    SliceList();
    Slider();
    Matrix();
    Weight();
    Local();
    Global();

  }
  
  
  public void drawOutline() {
    pushMatrix();    
    stroke(200);
    fill(245);
    rect(viewX+1, viewY+1, viewWidth-3, viewHeight-3);
    popMatrix();
  }
  void Global(){
  
    global  = cp5.addDropdownList("global ")
      .setPosition(GlobalX, GlobalY);
    global.getCaptionLabel().set("   Line Chart  ");
    global.addItem("     1D", 1);
  global.addItem("     3D", 1);
  
    customize(global);
  
  
  }
  
void SliceList(){

 cp5.setControlFont(new ControlFont(createFont("IowanOldStyle", 13), 13));
    sliceList  = cp5.addDropdownList("Slice Mode ")
      .setPosition(SliceListX, SliceListY);
    sliceList.getCaptionLabel().set("By Day");
    sliceList.addItem("By Day", 0);
    sliceList.addItem("By Week", 1);
    sliceList.addItem("By Month", 2);
    sliceList.addItem("By Season", 3);
    customize(sliceList);
}
void Matrix(){

 
    matrix  = cp5.addDropdownList("Matrix ")
      .setPosition(matrixX, matrixY);
    matrix.getCaptionLabel().set("Correlation");
    matrix.addItem("Correlation", 0);
    matrix.addItem("Euclidean", 1);
    matrix.addItem("City", 2);
  
    customize(matrix);
}

void Weight(){

 
    weight  = cp5.addDropdownList("weight ")
      .setPosition(weightX, weightY);
    weight.getCaptionLabel().set("      5 ");
    weight.addItem("      5 ", 0);
    weight.addItem("      4 ", 1);
    weight.addItem("      3 ", 2);
  
    customize(weight);
}

void Local(){

 
    Local  = cp5.addDropdownList("Window Size ")
      .setPosition(LocalX, LocalY);
    Local.getCaptionLabel().set("  Optimal - 25  ");
    Local.addItem("Line Chart", 0);
    Local.addItem("  Parallel Coordinates", 1);
  
    customize(Local);
}
void Slider(){
 cp5.addSlider("slider")
     .setPosition(this.getX()+10,this.getY()+this.getHeight()-25)
     .setSize(220,8)
     .setRange(0,200)
     .setValue(128)
     .setSliderMode(Slider.FLEXIBLE)
     .setColorValue(color(0, 0, 0))
       .setColorBackground(color(234))
      . setLabelVisible(false)
     ;
      
}


  void draw() {
    labelFont = createFont("Georgia", 32);
  textFont(labelFont);
    this.drawOutline();
    textAlign(LEFT, BOTTOM);
    fill(0);
    textSize(12);
    text("Slice Mode", SliceLabelX, SliceLabelY);
    text("Distance Matrix", matrixLabelX, matrixLabelY);
    text("Exploration Size", weightLabelX,weightLabelY);
      text("Window Size", LocalLabelX,LocalLabelY);
       text("Relation Display", GlobalLabelX,GlobalLabelY);
  }
  
  
  void customize(DropdownList ddl) {
    ddl.toUpperCase(false); 
    ddl.setColorLabel(color(0));  

    PFont font = createFont("Helvetica", 12);
    // a convenience function to customize a DropdownList

    ddl.setColorBackground(color(255));
    ddl.setColorForeground(color(255));
    ddl.setColorActive(color(220));

    ddl.setItemHeight(20);
    ddl.setBarHeight(20);

    ddl.captionLabel().setFont(font);
  }
}

