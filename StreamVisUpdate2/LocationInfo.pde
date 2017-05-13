public class LocationInfo extends Viewport {
  /*
  adjust all the points' position automatically.
   data format: 2 x (number of points)
   first row:  x coordinates...
   second row: y coordinates...
   */
  int MODE;
  private float scaleX, scaleY, transX, transY;
  float[][] data;
  float partialX = 0.8;
  float partialY = 0.8;
  float minX, maxX, minY, maxY;
  public LocationInfo(float viewX, float viewY, float viewWidth, float viewHeight, float[][] data, int MODE) {
    super(viewX, viewY, viewWidth, viewHeight);
    this.data = data;
    this.MODE = MODE;
    if (MODE == D1MODE) {
      getScale1D();
    } else if (MODE == D2MODE) {
      getScale2D();
    }
    getTrans();
  }
  

  void setPartialX(float p) {
    partialX = p;

    if (MODE == D1MODE) {
      getScale1D();
    } else 
    if (MODE == D2MODE) {
      getScale2D();
    }
    getTrans();
  }
  
  void setPartialY(float p) {
    partialY = p;

    if (MODE == D1MODE) {
      getScale1D();
    } else 
    if (MODE == D2MODE) {
      getScale2D();
    }
    getTrans();
  }
  
  void getScale2D() {

    float[] minmaxX = findMinMax(data[0]);
    minX = minmaxX[0];
    maxX = minmaxX[1];

    float[] minmaxY = findMinMax(data[1]);
    minY = minmaxY[0];
    maxY = minmaxY[1];

    float w = partialX * this.getWidth();
    float h = partialY * this.getHeight();

    scaleX = w / (maxX - minX);
    scaleY = h / (maxY - minY);
  }


  void getTrans() {


    float centerOfPointX = scaleX * (minX + maxX)/2;
    float centerOfPointY = scaleY * (minY + maxY)/2;

    transX = this.getCenterX() - centerOfPointX;
    transY = this.getCenterY() - centerOfPointY;
  }



  void getScale1D() {


    minX = 1;
    maxX = data[0].length-1;

    float[] minmaxY = findMinMax(data);
    minY = minmaxY[0];
    maxY = minmaxY[1];

    float w = partialX * this.getWidth();
    float h = partialY * this.getHeight();

    scaleX = w / (maxX - minX);
    scaleY = h / (maxY - minY);
  }
  float[] findMinMax(float[][] data) {
    /*global min max*/
    float[] res = new float[2];
    float min = 100.f, max = 0.f;
    for (int i = 0; i < data.length; i++ ) {
      for (int j = 0; j < data[0].length; j++) {
        if (min>data[i][j])
          min = data[i][j];
        if (max<data[i][j])
          max = data[i][j];
      }
    }
    res[0] = min;
    res[1] = max; 
    return res;
  }

  float[] findMinMax(float[] data) {
    /*X or Y min max*/
    float[] res = new float[2];
    float min = 100.f, max = 0.f;
    for (int i = 0; i < data.length; i++ ) {

      if (min>data[i])
        min = data[i];
      if (max<data[i])
        max = data[i];
    }
    res[0] = min;
    res[1] = max; 
    return res;
  }

  float getScaleX() {
    return scaleX;
  }

  float getScaleY() {
    return scaleY;
  }

  float getTransX() {
    return transX;
  }

  float getTransY() {
    return transY;
  }
}

