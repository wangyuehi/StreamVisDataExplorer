
public class ThemeRiver extends Viewport{



  protected ThemeRiverModel model;

    protected int meshGridIntervalX = 65,meshGridIntervalY = 30;
  protected Viewport floodArea;
  protected ArrayList<River> rivers;
  protected PGraphics pickBuffer;

  public ThemeRiver(float viewX, float viewY, float viewWidth, float viewHeight, ThemeRiverModel model){
    super(viewX, viewY, viewWidth, viewHeight);
    this.update(model);
  }


   void update(ThemeRiverModel model){
    this.model = model;

//get the colors needed
    color[] colors = new color[this.model.getYTitles().length];
    for(int i = 0; i < colors.length; i++){
      if(i < DEFAULT_COLORS.length)
        colors[i] = DEFAULT_COLORS[i];
      else
        colors[i] = color((int)random(0, 256), (int)random(0, 256), (int)random(0, 256));
    }

//axis config
    
    float floodAreaHeight = this.getHeight() * 0.8;
    float floodAreaX = this.getX()-5;
   
 
    float floodAreaY = this.getY() + 0.1 * this.getHeight();
    float floodAreaWidth = this.getWidth()+10;
    this.floodArea = new Viewport(floodAreaX, floodAreaY, floodAreaWidth, floodAreaHeight);

    float tickIntervalForRiver = floodAreaWidth / (float)(this.model.getNumberOfValueColumn() +1);
 
 
    int row = this.model.getNumberOfValueRow();
    int column = this.model.getNumberOfValueColumn();
    float max = MIN_FLOAT;
    for(int i = 0; i < column; i++){
      float sum = 0.0f;
      for(int j = 0; j < row; j++)
        sum += this.model.getValueAt(j, i);
      if(sum > max)
        max = sum;
    }

    float yUnit = floodAreaHeight / max;
    float[][] ys = new float[row + 1][column]; //"row + 1" for adding line_0
    for(int i = 0; i < column; i++)
      ys[0][i] = floodAreaY + floodAreaHeight;
    for(int i = 0; i < column; i++){
      for(int j = 1; j < row + 1; j++)
        ys[j][i] = ys[j - 1][i] - this.model.getValueAt(j - 1, i) * yUnit;
    }

    for(int i = 0; i < column; i++){ //centering
      float high = ys[0][i];
      float low = ys[row][i];
      float l = high - low;
      float offset = floodAreaHeight / 2.0f - l / 2.0f;
      for(int j = 0; j < row + 1; j++)
        ys[j][i] -= offset;
    }

    Vertex[][] vs = new Vertex[row + 1][column]; //"row + 1" for adding line_0
    for(int i = 0; i < row + 1; i++){
      float x = floodAreaX + tickIntervalForRiver;
      for(int j = 0; j < column; j++){
        vs[i][j] = new Vertex(x, ys[i][j]);
        x += tickIntervalForRiver;
      }
    }

    this.rivers = new ArrayList<River>();
    for(int i = 0; i < row; i++){
      ArrayList<Vertex> lower = new ArrayList<Vertex>();
      ArrayList<Vertex> upper = new ArrayList<Vertex>();
      for(int j = 0; j < column; j++){
        lower.add(vs[i][j]);
        upper.add(vs[i + 1][j]);
      }
      River river = new River(lower, upper, colors[i]);
      this.rivers.add(river);
    }

    this.pickBuffer = createGraphics((int)this.getWidth(), (int)this.getHeight());
    this.drawPickBuffer();
  }

 protected void drawPickBuffer(){
    this.pickBuffer.beginDraw();
    this.pickBuffer.background(255);
    for(int i = 0; i < this.rivers.size(); i++)
      this.rivers.get(i).drawIn(this.pickBuffer);
    this.pickBuffer.endDraw();
  }

  public void draw(){
    //background(255);
    this.drawOutline();
    // this.meshGrid( meshGridIntervalX,meshGridIntervalY );
    for(int i = 0; i < this.rivers.size(); i++)
      this.rivers.get(i).draw();

  }


}
