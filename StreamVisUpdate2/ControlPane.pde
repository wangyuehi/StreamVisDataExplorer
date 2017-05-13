import controlP5.*;
public class ControlPane extends Viewport {
  ControlP5 cp5;
  DropdownList matrix, weight, Local, global;
  /**   slice Mode location   **/


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
  void Global() {

    global  = cp5.addDropdownList("global ")
      .setPosition(GlobalX, GlobalY);
    global.getCaptionLabel().set("   Line Chart  ");
    global.addItem("     1D", 1);
    global.addItem("     3D", 1);

    customize(global);
  }

 
  void Matrix() {


    matrix  = cp5.addDropdownList("Matrix ")
      .setPosition(matrixX, matrixY);
    matrix.getCaptionLabel().set("Correlation");
    matrix.addItem("Correlation", 0);
    matrix.addItem("Euclidean", 1);
    matrix.addItem("City", 2);

    customize(matrix);
  }

  void Weight() {


    weight  = cp5.addDropdownList("weight ")
      .setPosition(weightX, weightY);
    weight.getCaptionLabel().set("      5 ");
    weight.addItem("      5 ", 0);
    weight.addItem("      4 ", 1);
    weight.addItem("      3 ", 2);

    customize(weight);
  }

  void Local() {


    Local  = cp5.addDropdownList("Window Size ")
      .setPosition(LocalX, LocalY);
    Local.getCaptionLabel().set("  Optimal - 25  ");
    Local.addItem("Line Chart", 0);
    Local.addItem("  Parallel Coordinates", 1);

    customize(Local);
  }
  void Slider() {
    cp5.addSlider("slider")
      .setPosition(this.getX()+10, this.getY()+this.getHeight()-25)
        .setSize(220, 8)
          .setRange(0, 6)
            .setValue(5)
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
    text("Exploration Size", weightLabelX, weightLabelY);
    text("Window Size", LocalLabelX, LocalLabelY);
    text("Relation Display", GlobalLabelX, GlobalLabelY);
  }



  
}

