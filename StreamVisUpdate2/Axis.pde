public class Axis extends Viewport {

  private TitleView titleView;
  private ArrayList<TickView> tickViews;

  public Axis(float viewX, float viewY, float viewWidth, float viewHeight, String title, String[] tickLabels, float tickInterval, float startX) {
    super(viewX, viewY, viewWidth, viewHeight);

    float tickX = viewX+startX;
    float tickY = viewY;

    float tickWidth = tickInterval;
    float tickHeight = viewHeight * 0.7f;
    this.tickViews = new ArrayList<TickView>();
    for (int i = 0; i < tickLabels.length; i++) {
      TickView tickView = new TickView(tickX, tickY, tickWidth, tickHeight, tickLabels[i]);
      this.tickViews.add(tickView);
      tickX += tickInterval;
    }

    float titleX = viewX;
    float titleY = viewY + tickHeight;
    float titleWidth = viewWidth;
    float titleHeight = viewHeight - tickHeight;
    this.titleView = new TitleView(titleX, titleY, titleWidth, titleHeight, title);
  }

  public void draw() {

    stroke(axisColor);
    fill(axisColor);
    strokeWeight(2);
    line(this.getX(), this.getY(), this.getX() + this.getWidth()-2, this.getY());
    this.titleView.draw();
    for (int i = 0; i < this.tickViews.size (); i++)
      this.tickViews.get(i).draw();

    strokeWeight(1);
  }

  private class TitleView extends Viewport {

    private String title;

    public TitleView(float viewX, float viewY, float viewWidth, float viewHeight, String title) {
      super(viewX, viewY, viewWidth, viewHeight);
      this.title = title;
    }

    public void draw() {
      textAlign(CENTER, CENTER);
      fill(0);
      // text(this.title, this.getCenterX(), this.getCenterY());
    }
  }

  private class TickView extends Viewport {

    private String tickLabel;
    private float tickLength;

    public TickView(float viewX, float viewY, float viewWidth, float viewHeight, String tickLabel) {
      super(viewX, viewY, viewWidth, viewHeight);
      this.tickLabel = tickLabel;
      this.tickLength = this.getHeight() * 0.15f;
    }

    public void draw() {
      stroke(axisColor);
      fill(axisColor);
      strokeWeight(2);
      line(this.getX(), this.getY(), this.getX(), this.getY() + this.tickLength);
      strokeWeight(1);
      fill(0);
      pushMatrix();
      translate(this.getX(), this.getY() + this.tickLength);
      //rotate(HALF_PI * 3.0f);

      textAlign(CENTER, CENTER);
      text(this.tickLabel, 5.0f - this.tickLength, 7.0f);
      popMatrix();
    }
  }
}

