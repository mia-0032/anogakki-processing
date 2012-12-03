abstract class KeyAbstract {
  //鍵盤のX座標
  protected float x1;
  protected float x2;

  private int sound_num;
  //鍵盤の色（押されたとき）
  private int pressed_color;
  private int delta_color = 5;

  KeyAbstract(int temp_sound_num) {
    this.sound_num = 60 + temp_sound_num;
  }

  void setX(float temp_x1, float temp_x2) {
    if (temp_x1 <  temp_x2) {
      this.x1 = temp_x1;
      this.x2 = temp_x2;
    }
    else {
      this.x1 = temp_x2;
      this.x2 = temp_x1;
    }
  }

  abstract void display();

  void pressedSound() {
    print(this.sound_num);
    midi_out.sendNote(new Note(this.sound_num,100,1000));
    this.pressed_color = 80;
  }

  void keyFill() {
    if (this.pressed_color > 0) {
      fill(0, this.pressed_color, 0);
      this.pressed_color -= this.delta_color;
    }
    else {
      fill(0, 0, 0);
    }
  }

  boolean pressed(int mouse_X) {
    if (mouse_X > this.x1 && mouse_X < this.x2) {
      this.pressedSound();
      return true;
    }
    return false;
  }
}
