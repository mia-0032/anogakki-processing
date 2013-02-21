class LineEffect extends EffectAbstract {

  LineEffect(int temp_x, int temp_y) {
    super(temp_x, temp_y);
  }

  void displayFigure() {
    beginShape(QUADS);
    vertex(0, this.y - this.line_width);
    vertex(0, this.y + this.line_width);
    vertex(width, this.y + this.line_width);
    vertex(width, this.y - this.line_width);
    endShape();
  }
}

