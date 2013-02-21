import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import promidi.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ano_gakki extends PApplet {





//midi\u51fa\u529b\u30af\u30e9\u30b9
MidiIO midi_io;
MidiOut midi_out;

//\u30ad\u30e3\u30c3\u30b7\u30e5
float[] sin_list = new float[360];
float[] cos_list = new float[360];
int half_height;

//\u30aa\u30af\u30bf\u30fc\u30d6\u6570
int octave_num = 2;

//\u9375\u76e4\u6570
int sum_key_num;
int white_key_num;
int black_key_num;

//\u9375\u76e4\u306e\u5e45
float white_key_width;
float black_key_width;

//\u30a8\u30d5\u30a7\u30af\u30c8\u683c\u7d0d
ArrayList effects;
//\u9375\u76e4\u683c\u7d0d
ArrayList white_keys;
ArrayList black_keys;

//\u524d\u306b\u62bc\u3055\u308c\u305f\u9375\u76e4
int previous_key = -1;

public void setup() {
  //\u753b\u9762\u521d\u671f\u5316(\u3042\u306e\u697d\u5668\u306e\u30c7\u30a3\u30b9\u30d7\u30ec\u30a4\u306e\u5927\u304d\u3055\u306b\u5408\u308f\u305b\u3066\u3042\u308b)
  size(1366*2, 700, P3D);
  rectMode(CORNERS);
  //\u5404\u6570\u5024\u306e\u8a08\u7b97
  half_height = ceil(height/2 * 0.9f);
  sum_key_num = octave_num * 12 + 1;
  white_key_num = octave_num * 7 + 1;
  black_key_num = octave_num * 5;
  white_key_width = width / white_key_num;
  black_key_width = 0.8f * white_key_width;
  //\u30aa\u30d6\u30b8\u30a7\u30af\u30c8\u683c\u7d0d\u5909\u6570\u521d\u671f\u5316
  effects = new ArrayList();
  white_keys = new ArrayList();
  black_keys = new ArrayList();
  int j = 0;
  for (int i = 0;i < white_key_num;i++) {
    white_keys.add(new WhiteKey(i, j));
    j++;
    if (i%7 != 2 && i%7 != 6) {
      black_keys.add(new BlackKey(i, j));
      j++;
    }
  }
  //sin\u3068cos\u306e\u5024\u3092\u30ad\u30e3\u30c3\u30b7\u30e5
  for (int i = 0;i < 360;i++) {
    sin_list[i] = sin(radians(i));
    cos_list[i] = cos(radians(i));
  }
  //midi\u51fa\u529b
  midi_io = MidiIO.getInstance(this);
  midi_io.printDevices();
  midi_out = midi_io.getMidiOut(0, 2);
}

public void draw() {
  noCursor();
  background(0);
  for (int i = 0;i < white_key_num;i++) {
    KeyAbstract white_key = (KeyAbstract) white_keys.get(i);
    white_key.display();
  }
  for (int i = 0;i < black_key_num;i++) {
    KeyAbstract black_key = (KeyAbstract) black_keys.get(i);
    black_key.display();
  }
  noStroke();
  for (int i = 0;i < effects.size(); i++) {
    EffectAbstract effect = (EffectAbstract) effects.get(i);
    effect.display();
    if (effect.finished()) {
      effects.remove(i);
    }
  }
}

public void mousePressed() {
  if (checkKeyPress()) {
    switch(frameCount%5) {
    case 0:
      effects.add(new CircleEffect(mouseX, mouseY));
      break;
    case 1:
      effects.add(new LineEffect(mouseX, mouseY));
      break;
    case 2:
      effects.add(new N_PolygonEffect(mouseX, mouseY, 3));
      break;
    case 3:
      effects.add(new N_PolygonEffect(mouseX, mouseY, 4));
      break;
    case 4:
      effects.add(new N_PolygonEffect(mouseX, mouseY, 5));
      break;
    default:
    }
  }
}

public void mouseDragged() {
    if (checkKeyPress()) {
      //\u307b\u3093\u3068\u306f\u661f\u3068\u304b\u304d\u308c\u3044\u305d\u3046
      effects.add(new N_PolygonEffect(mouseX, mouseY, 4));
    }
}

/**
 * \u3069\u306e\u9375\u76e4\u304c\u62bc\u3055\u308c\u305f\u304b\u30c1\u30a7\u30c3\u30af\u3059\u308b\u95a2\u6570
 **/
public boolean checkKeyPress() {
  boolean result = false;
  //\u4e0a\u534a\u5206\u3060\u3068\u9ed2\u9375\u76e4\u3001\u4e0b\u534a\u5206\u3060\u3068\u767d\u9375\u76e4
  if (mouseY <= half_height) {
    for (int i = 0;i < black_key_num;i++) {
      //\u30de\u30a6\u30b9\u30c9\u30e9\u30c3\u30b0\u6642\u306b\u540c\u3058\u97f3\u304c\u9023\u7d9a\u3067\u3067\u306a\u3044\u3088\u3046\u306b\u3059\u308b
      if (previous_key == i) {
        continue;
      }
      KeyAbstract black_key = (KeyAbstract) black_keys.get(i);
      result = black_key.pressed(mouseX);
      if (result == true) {
        previous_key = i;
        break;
      }
    }
  }
  else {
    for (int i = 0;i < white_key_num;i++) {
      //\u30de\u30a6\u30b9\u30c9\u30e9\u30c3\u30b0\u6642\u306b\u540c\u3058\u97f3\u304c\u9023\u7d9a\u3067\u3067\u306a\u3044\u3088\u3046\u306b\u3059\u308b
      if (previous_key == i) {
        continue;
      }
      KeyAbstract white_key = (KeyAbstract) white_keys.get(i);
      result = white_key.pressed(mouseX);
      if (result == true) {
        previous_key = i;
        break;
      }
    }
  }
  return result;
}

public void mouseReleased() {
  //\u9023\u7d9a\u3067\u540c\u3058\u97f3\u3092\u62bc\u3059\u3053\u3068\u306f\u3067\u304d\u308b
  previous_key = -1;
}

class BlackKey extends KeyAbstract {

  BlackKey(int temp_key_num, int temp_sound_num) {
    super(temp_sound_num);
    temp_key_num++;
    super.setX(white_key_width * temp_key_num - black_key_width/2, white_key_width * temp_key_num + black_key_width/2);
  }

  public void display() {
    super.keyFill();
    stroke(0, 80, 0);
    rect(this.x1, 0, this.x2, half_height);
  }
}
class CircleEffect extends EffectAbstract {

  CircleEffect(int temp_x, int temp_y) {
    super(temp_x, temp_y);
  }

  public void displayFigure() {
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

abstract class EffectAbstract {
  //\u751f\u6210\u3055\u308c\u305f\u5ea7\u6a19
  protected int x;
  protected int y;
  //\u8272\u306e\u5024
  protected int g_c = 255;
  protected int b_c = 0;
  //\u8584\u304f\u3057\u3066\u3044\u304f\u5024
  private int delta_g_c = 3;
  private int delta_b_c = 0;
  //\u5916\u5074\u306e\u5927\u304d\u3055
  protected int r = 60;
  //\u5185\u5074\u306e\u5927\u304d\u3055
  protected int in_r = 30;
  //\u5927\u304d\u304f\u3057\u3066\u3044\u304f\u5024
  private int delta_r = 4;
  private int delta_in_r = 4;
  //\u7dda\u306e\u592a\u3055
  protected int line_width = 15;

  EffectAbstract(int temp_x, int temp_y) {
    this.x = temp_x;
    this.y = temp_y;
  }

  public void display() {
    fill(0, this.g_c, this.b_c);
    this.displayFigure();
    this.r += this.delta_r;
    this.in_r += this.delta_in_r;
    this.g_c -= this.delta_g_c;
//    this.b_c -= this.delta_b_c;
  }

  public abstract void displayFigure();

  public boolean finished() {
    if (this.g_c <= 50) {
      return true;
    }
    else {
      return false;
    }
  }

  public float getX(int deg) {
    return this.x - this.r * cos_list[deg];
  }

  public float getY(int deg) {
    return this.y - this.r * sin_list[deg];
  }

  public float getMinX(int deg) {
    return this.x - this.in_r * cos_list[deg];
  }

  public float getMinY(int deg) {
    return this.y - this.in_r * sin_list[deg];
  }
}

abstract class KeyAbstract {
  //\u9375\u76e4\u306eX\u5ea7\u6a19
  protected float x1;
  protected float x2;

  private int sound_num;
  //\u9375\u76e4\u306e\u8272\uff08\u62bc\u3055\u308c\u305f\u3068\u304d\uff09
  private int pressed_color;
  private int delta_color = 5;

  KeyAbstract(int temp_sound_num) {
    this.sound_num = 60 + temp_sound_num;
  }

  public void setX(float temp_x1, float temp_x2) {
    if (temp_x1 <  temp_x2) {
      this.x1 = temp_x1;
      this.x2 = temp_x2;
    }
    else {
      this.x1 = temp_x2;
      this.x2 = temp_x1;
    }
  }

  public abstract void display();

  public void pressedSound() {
    print(this.sound_num);
    midi_out.sendNote(new Note(this.sound_num,100,1000));
    this.pressed_color = 80;
  }

  public void keyFill() {
    if (this.pressed_color > 0) {
      fill(0, this.pressed_color, 0);
      this.pressed_color -= this.delta_color;
    }
    else {
      fill(0, 0, 0);
    }
  }

  public boolean pressed(int mouse_X) {
    if (mouse_X > this.x1 && mouse_X < this.x2) {
      this.pressedSound();
      return true;
    }
    return false;
  }
}
class LineEffect extends EffectAbstract {

  LineEffect(int temp_x, int temp_y) {
    super(temp_x, temp_y);
  }

  public void displayFigure() {
    beginShape(QUADS);
    vertex(0, this.y - this.line_width);
    vertex(0, this.y + this.line_width);
    vertex(width, this.y + this.line_width);
    vertex(width, this.y - this.line_width);
    endShape();
  }
}

class N_PolygonEffect extends EffectAbstract {
  private int current_deg = 0;
  private int delta_deg = 3;
  private int side_num;
  private int side_angle;

  N_PolygonEffect(int temp_x, int temp_y, int temp_side_num) {
    super(temp_x, temp_y);
    //\u9802\u70b9\u6570\u3092\u683c\u7d0d
    this.side_num = temp_side_num;
    //\u9802\u70b9\u306e\u89d2\u5ea6
    this.side_angle = ceil(360/temp_side_num);
  }

  public void displayFigure() {
    beginShape(QUADS);    
    vertex(this.getX(current_deg), this.getY(current_deg));
    vertex(this.getMinX(current_deg), this.getMinY(current_deg));
      
    for (int i = this.side_angle; i < 360; i+= this.side_angle) {
      int deg = current_deg + i;

      if(deg >= 360){
        deg -= 360;
      }
      vertex(this.getMinX(deg), this.getMinY(deg));
      vertex(this.getX(deg), this.getY(deg));
      vertex(this.getX(deg), this.getY(deg));
      vertex(this.getMinX(deg), this.getMinY(deg));
    }

    vertex(this.getMinX(current_deg), this.getMinY(current_deg));
    vertex(this.getX(current_deg), this.getY(current_deg));

    endShape();

    this.current_deg += this.delta_deg;
    if(this.current_deg >= 360){
      this.current_deg -= 360;
    }
  }
}

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

  public void display() {
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

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ano_gakki" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
