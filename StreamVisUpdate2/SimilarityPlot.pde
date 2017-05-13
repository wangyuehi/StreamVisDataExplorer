
  
public class SimilarityBasic extends Viewport {
 

  protected  int SliceMode = DAY;
  protected  float[][] daypoints;
  protected ArrayList<float[][]> AllPoints;
  protected boolean[] selected;

  protected float[][] origin_data;
  protected String[] xLabels;

  protected ArrayList<LocationInfo> locationInfo;

  protected LocationInfo currentLoc;

  protected float transX, transY, scaleX, scaleY;
  protected int meshGridInterval = 60;

  public SimilarityBasic(float viewX, float viewY, float viewWidth, float viewHeight, 
  float[][] day, float[][] week, float[][] month, float[][] season, float[][] origin_data, String[] xLabels) {

    super(viewX, viewY, viewWidth, viewHeight);
    this.origin_data = origin_data;
    this.xLabels = xLabels;
    AllPoints = new ArrayList<float[][]>();
    selected = new boolean[day[0].length];
    locationInfo = new ArrayList<LocationInfo>();


    AllPoints.add(day);
    AllPoints.add(week);
    AllPoints.add(month);
    AllPoints.add(season);

    adjustLocation();
  }
  void initSelectPoint() {
    /* defualt config: false. all points are not selected */
    for (int i = 0; i<selected.length; i++) {
      selected[i] = false;
    }
  }
  void adjustLocation() {

    /*adjust the input points coordinates, make them in the center of plot*/
    LocationInfo dayLocation = new LocationInfo(this.getX(), this.getY(), this.getWidth(), this.getHeight(), AllPoints.get(DAY),D2MODE);
    LocationInfo weekLocation = new LocationInfo(this.getX(), this.getY(), this.getWidth(), this.getHeight(), AllPoints.get(WEEK),D2MODE);
    LocationInfo monthLocation = new LocationInfo(this.getX(), this.getY(), this.getWidth(), this.getHeight(), AllPoints.get(MONTH),D2MODE);
    LocationInfo seasonLocation = new LocationInfo(this.getX(), this.getY(), this.getWidth(), this.getHeight(), AllPoints.get(SEASON),D2MODE);

    locationInfo.add(dayLocation);
    locationInfo.add(weekLocation);
    locationInfo.add(monthLocation);
    locationInfo.add(seasonLocation);
  }


  void draw() {

    this.drawOutline();
    //this.meshGrid(meshGridInterval);
    daypoints = AllPoints.get(SliceMode);
    currentLoc = locationInfo.get(SliceMode);
    scaleX = currentLoc.getScaleX();
    scaleY = currentLoc.getScaleY();
    transX = currentLoc.getTransX();
    transY = currentLoc.getTransY();

    pushMatrix();
    translate(transX, transY);
  for (int i =0; i<daypoints[0].length; i++) {
        stroke(255);
        strokeWeight(11); 
        point(daypoints[0][i]*scaleX, daypoints[1][i]*scaleY);
        float gray = map(daypoints[0].length-i-1, 0, daypoints[0].length, 30, 255 );
        stroke(255, 0, 0, gray);
        strokeWeight(8);
        point(daypoints[0][i]*scaleX, daypoints[1][i]*scaleY);
        strokeWeight(1);
      
    } 
    popMatrix();
  }
  public void onMouseMoved(int toX, int toY) {
    highPressPoint(toX,toY);
  
  }
  
  public int highPressPoint(int toX,int toY){
  
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
       
           selected[i] = true;
           last = i;
      
        }
        else{
          selected[i] = false;
        }
      }
    }
    
    
      return last;
  }
 
  public int getSliceMode(){
    return SliceMode;
  }
 public void setSliceMode(int SliceMode){
    this.SliceMode = SliceMode;
  }
}

