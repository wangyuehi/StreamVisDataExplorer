import controlP5.*;

final int CANVAS_WIDTH_DEFAULT  = 790;
final int CANVAS_HEIGHT_DEFAULT =590;

final String DATA_FILE_PATH = "rawdata.csv";
  final int SliceLabelX = 325;
  final int SliceLabelY = 50;
  final int SliceListX = SliceLabelX;
  final int SliceListY = SliceLabelY + 25;
float[][] RawData;
float[][] day, week, month, season;
String xTitle ;  
String[] xLabels ;
String[] yTitles ;

float[][] riverData;
float[][] local1D;
float[][] global1D;
float[][] local2D;
float[][] perioddata;


ControlP5 cp5;

/*
 *  data.csv format
 *  By assuming the line index is base 0.
 *  a. Line#(0): X_TITLE,X_LABEL1,X_LABEL2,...,X_LABEL_N
 *  b. Line#(1)~#(end): Y_TITLE,VALUE1,VALUE2,...,VALUE_N
 *  
 *  Day.txt format
 *  Column#(0): x1, x2, x3, ... x coordinates...
 *  Column#(1): y1, y2, y3, ... y coordinates...
 */

InteractThemeRiver themeRiver;
LegendAxis legend;
TimeSliceSimilarity similarity;
ControlPane control;
WeightGraph weightfunction;
Period period;
RelationPlot globalPlot;
WindowPlot localPlot;
Axis commonAxis;
  DropdownList sliceList;


final int LegendX = 315;
final int LegendY = 85 ;
final int LegendWidth = 110;
final int LegendHeight = 100;

final float SimiX = 5;
final float SimiY = 20;
final float SimiWidth = 300;
final float SimiHeight = 300;

final float ControlX = 310;
final float ControlY = 20;
final float ControlWidth = 240;
final float ControlHeight = 300;

final float WeightX = 315;
final float WeightY = 210;
final float WeightWidth = 230;
final float WeightHeight = 80;

final float PeriodX = 555;
final float PeriodY = 20;
final float PeriodWidth = 230;
final float PeriodHeight = 100;

final float LocalX = 555;
final float LocalY = 140;
final float LocalWidth = 230;
final float LocalHeight = 180;

final float GlobalX = 5;
final float GlobalY = 440;
final float GlobalWidth = 780;
final float GlobalHeight = 110;

final int ThemeRiverX = 5;
final int ThemeRiverY = 325;
final int ThemeRiverWidth = 780;
final int ThemeRiverHeight = 110;

final float AxisX = GlobalX;
final float AxisY = GlobalY + GlobalHeight-3;
final float AxisWidth = GlobalWidth;
final float AxisHeight = 60;
PFont font1;
void setup() {

  int canvasWidth = CANVAS_WIDTH_DEFAULT;
  int canvasHeight = CANVAS_HEIGHT_DEFAULT;
  size(canvasWidth, canvasHeight);
  cp5 = new ControlP5(this);
  font1= createFont("Helvetica", 7);
  cp5.setFont(font1);

  /* themeRiver */
  loadRawData(DATA_FILE_PATH);
  day = transpose(loaddata("./points/Ldis.txt", 365, 2));
  week = transpose(loaddata("./points/LdisPerWeek.txt", 52, 2));
  month = transpose(loaddata("./points/LdisPerMonth.txt", 12, 2));
  season = transpose(loaddata("./points/LdisPerSeason.txt", 4, 2));
  local1D = loaddata("./points/LdisMatrixLocal.txt", 5, 361);
  local2D = loaddata("./points/LdisMatrixLocal2D.txt", 5, 722);
  global1D = loaddata("./points/pollutionLocal.txt", 5, 361);
  riverData = loaddata("./normalizedRiverData.txt", 5, 73);
  perioddata = loaddata("./period.txt", 174, 2);
  String[] labels = {
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"
  };

  ThemeRiverModel model = createThemeRiverModelFrom(riverData);
  model.setXLabels(labels);
  int tickInterval = (int)(AxisWidth/labels.length);


  legend = new LegendAxis(LegendX, LegendY, LegendWidth, LegendHeight, yTitles, DEFAULT_COLORS);
  commonAxis = new Axis(AxisX, AxisY, AxisWidth, AxisHeight, "", labels, tickInterval, 3);
  similarity = new TimeSliceSimilarity(SimiX, SimiY, SimiWidth, SimiHeight, day, week, month, season, transpose(RawData), xLabels,yTitles);

  themeRiver = new InteractThemeRiver((float)ThemeRiverX, (float)ThemeRiverY, (float)ThemeRiverWidth, (float)ThemeRiverHeight, model, similarity.getHighlighted(),transpose(RawData), xLabels,yTitles);
  control = new ControlPane(ControlX, ControlY, ControlWidth, ControlHeight, cp5);
  weightfunction = new WeightGraph(WeightX, WeightY, WeightWidth, WeightHeight, 5);
  period = new Period(PeriodX, PeriodY, PeriodWidth, PeriodHeight, transpose(perioddata), cp5);
  localPlot = new WindowPlot(LocalX, LocalY, LocalWidth, LocalHeight, RawData, local1D, local2D, xLabels);
  globalPlot = new RelationPlot(GlobalX, GlobalY, GlobalWidth, GlobalHeight, RawData, global1D);
  
    SliceList();
  
}

void draw() {
  background(241);
  themeRiver.draw();

  similarity.draw();
  control.draw();
  weightfunction.draw();
  period.draw();
  localPlot.draw();
  globalPlot.draw();
  commonAxis.draw();
  legend.draw();
  drawTitle();

}


void mouseMoved() {
  themeRiver.onMouseMoved(mouseX, mouseY);

  similarity.onMouseMoved(mouseX, mouseY);
  if (themeRiver.isIntersectingWith(mouseX, mouseY)) {
    themeRiver.onMouseMoved(mouseX, mouseY);
    int m = (int)(themeRiver.getPosition(mouseX) * global1D[0].length);
    notifyAll(m);
  }
}
void notifyAll(int x) {
  localPlot.drawPointAt(x);
  globalPlot.drawPointAt(x);
  globalPlot.commonLine();
}
void mousePressed() {
  similarity.onMousePressed(mouseX, mouseY);
  themeRiver.onMousePressed(mouseX, mouseY);

}


void mouseReleased() {
  themeRiver.onMouseReleased(mouseX, mouseY);

  similarity.onMouseReleased(mouseX, mouseY);

  if (similarity.RECTSHOW)
  {//notify themeriver to highlight

    themeRiver.riverHighlight(similarity.getSliceMode(), similarity.getHighlighted());
  }
  if (themeRiver.shadowShow)
  {
    float[] range =  themeRiver.getSelectedRange();
    similarity.checkRiver(range[0], range[1]);
  }
}

void mouseDragged() {
  themeRiver.onMouseDragged(mouseX, mouseY);
  similarity.onMouseDragged(mouseX, mouseY);
}

void drawTitle() {
  textAlign(CENTER, CENTER);
  stroke(0);
  fill(0);
  text("Time Slice Similarity Plot", similarity.getCenterX(), 10);
  text("Control Panel ", control.getCenterX(), 10);
  text("Period Detection ", period.getCenterX(), 10);
  text("Exploration Display :", localPlot.getX() + localPlot.getWidth()/3, localPlot.getY()-10);
}

void loadRawData(String dataFilePath) {


  String[] lines = loadStrings(dataFilePath);

  String[] header = splitTokens(trim(lines[0]), ",");

  xTitle = header[0];

  xLabels = new String[lines.length - 1];//first colomn is date and time

  yTitles = new String[header.length - 1];// first line is polution's name


  for (int i = 1; i < header.length; i++)
    yTitles[i - 1] = header[i];

  float[][] values = new float[lines.length - 1][yTitles.length];
  for (int i = 1; i < lines.length; i++) {
    String[] data = splitTokens(trim(lines[i]), ",");
    xLabels[i - 1] = trim(data[0]);
    for (int j = 1; j < data.length; j++)
      values[i - 1][j - 1] = float(data[j]);
  }

  float[][] valuesinrow = new float[yTitles.length][lines.length-1];

  for (int i = 0; i<yTitles.length; i++) {
    for (int j =0; j<lines.length-1; j++) {


      valuesinrow[i][j]=values[j][i];
    }
  }
  RawData = valuesinrow;
}
public float[][] loaddata(String path, int row, int col) {
  BufferedReader reader = createReader(path);  
  String line;
  float[][] data  = new float[row][col];
  for (int i = 0; i<data.length; i++) {
    try {
      line = reader.readLine();
    } 
    catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
    if (line == null) {
      // Stop reading because of an error or file is empty
      break;
    } else {
      for (int j = 0; j<data[0].length; j++) {
        String[] pieces = split(line, ",");
        data[i][j] = float(pieces[j]);
      }
    }
  }
  return data;
}
public float[][] transpose(float[][] data) {
  float[][] res = new float[data[0].length][data.length];

  for (int i = 0; i<res.length; i++) {
    for (int j =0; j<res[0].length; j++) {

      {
        res[i][j]=data[j][i];
      }
    }
  }
  return res;
}
ThemeRiverModel createThemeRiverModelFrom(float[][] data) {

  return new ThemeRiverModel(xTitle, xLabels, yTitles, data);
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



 void SliceList() {

    cp5.setControlFont(new ControlFont(createFont("IowanOldStyle", 13), 13));
    sliceList  = cp5.addDropdownList("Slice Mode")
      .setPosition(SliceListX, SliceListY);
    sliceList.getCaptionLabel().set("By Day");
    sliceList.addItem("By Day", DAY);
    sliceList.addItem("By Week", WEEK);
    sliceList.addItem("By Month", MONTH);
    sliceList.addItem("By Season", SEASON);
    customize(sliceList);
  }

void controlEvent(ControlEvent theEvent) {
if(theEvent.isGroup()){
 if(theEvent.getGroup().getName() == "Slice Mode"){
similarity.setSliceMode((int)(theEvent.getGroup().getValue()));
}

  }
}
