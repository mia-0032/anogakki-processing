class CircleEffect extends EffectAbstract {

  CircleEffect(int temp_x, int temp_y) {
    super(temp_x, temp_y);
  }

  void displayFigure() {
    beginShape(QUADS);
    
    vertex(this.getX(0), this.getY(0));
    vertex(this.getMinX(0), this.getMinY(0));

    for (int i = 10; i < 360; i+= 10) {
      vertex(this.getMinX(i), this.getMinY(i));
      vertex(this.getX(i), this.getY(i));
      vertex(this.getX(i), this.getY(i));
      vertex(this.getMinX(i), this.getMinY(i));
    }
    
    vertex(this.getMinX(0), this.getMinY(0));
    vertex(this.getX(0), this.getY(0));
    endShape();
  }
}

