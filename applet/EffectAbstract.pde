abstract class EffectAbstract{
  protected int x;
  protected int y;
  protected int c;
  
  EffectAbstract(int temp_x, int temp_y){
    this.x = temp_x;
    this.y = temp_y;
  }
  
  abstract void display();

  boolean finished(){
    if(this.c <= 0){
      return true;
    }else{
      return false;
    }
  }
}
