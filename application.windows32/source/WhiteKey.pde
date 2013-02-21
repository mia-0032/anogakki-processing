class WhiteKey extends KeyAbstract {
  private boolean has_black;

  WhiteKey(int temp_key_num, int temp_sound_num) {
    super(temp_sound_num);
    super.setX(white_key_width * temp_key_num, white_key_width * (temp_key_num + 1));
    if (temp_key_num%7 != 2 && temp_key_num%7 != 6) {
      this.has_black = true;
    }
    else {
      this.has_black = false;
    }
  }

  void display() {
    super.keyFill();
    noStroke();
    rect(this.x1, 0, this.x2, height);
    stroke(0, 80, 0);
    if (this.has_black) {
      line(this.x2, half_height, this.x2, height);
    }
    else {
      line(this.x2, 0, this.x2, height);
    }
  }
}

