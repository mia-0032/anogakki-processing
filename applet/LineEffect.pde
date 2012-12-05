class LineEffect extends EffectAbstract{
  private int delta_c;
  
  LineEffect(int temp_x, int temp_y){
    super(temp_x, temp_y);
    this.c = 255;
    this.delta_c = 5;
  }
  
  void display(){
    stroke(0, this.c, this.c);
    line(0, this.y, width, this.y);
    this.c -= this.delta_c;
  }
}
