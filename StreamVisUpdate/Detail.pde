public class Detail extends Viewport{
float[][] originData;
   public Detail(float viewX, float viewY, float viewWidth, float viewHeight, float[][] originData) {
    super(viewX, viewY, viewWidth, viewHeight); 
    this.originData = originData;
   }
}
