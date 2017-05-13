public class LegendAxis extends Viewport {

  private ArrayList<LegendView> legendViews;

  public LegendAxis(float viewX, float viewY, float viewWidth, float viewHeight, String[] legends, color[] legendColors) {
    super(viewX, viewY, viewWidth, viewHeight);

    this.legendViews = new ArrayList<LegendView>();
    float h = 1*this.getHeight()/(legends.length+0.5);//(textAscent() + textDescent()) * 2.0f;
    float gapY = (this.getHeight() - h * legends.length) / 2f;
    float x = this.getX() + this.getWidth() * 0.1f;
    float y = this.getY() + this.getHeight() * 0.05f;
    float w = this.getWidth() * 0.8f;
    for (int i = legends.length - 1; i >= 0; i--) {
      LegendView legendView = new LegendView(x, y, w, h, legends[i], legendColors[i]);
      legendViews.add(legendView);
      y += h;
    }
  }

  public void draw() {

    stroke(0);
   // this.drawOutline();
    float x = this.getX() + this.getWidth();
    //println(x);
   // line(x, this.getY(), x, this.getY() + this.getHeight());
    for (int i = 0; i < this.legendViews.size (); i++)
      this.legendViews.get(i).draw();
  }

  private class LegendView extends Viewport {

    private String legend;
    private color legendColor;
    private int legendSize = 15;

    public LegendView(float viewX, float viewY, float viewWidth, float viewHeight, String legend, color legendColor) {
      super(viewX, viewY, viewWidth, viewHeight);
      this.legend = legend;
      this.legendColor = legendColor;
    }

    public void draw() {
      noStroke();
      fill(this.legendColor);
      rect(this.getX(), this.getY(), legendSize*1.5, legendSize);

      fill(0);
      textSize(12);
      textAlign(LEFT, BOTTOM);
      text(this.legend, this.getX()+legendSize*2.5, this.getY()+legendSize);
    }
  }
}

