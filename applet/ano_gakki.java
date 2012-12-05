import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class ano_gakki extends PApplet {



ArrayList effects;

public void setup(){
  size(2000, 700, OPENGL);
  noFill();
  smooth();
  strokeWeight(20);
  rectMode(CENTER);
  effects = new ArrayList();
}

public void draw(){
  background(0);
  for(int i = 0;i < effects.size(); i++){
    EffectAbstract effect = (EffectAbstract) effects.get(i);
    effect.display();
    if(effect.finished()){
      effects.remove(i);
    }
  }
}

public void mousePressed(){
  switch(floor(random(4))){
//  switch(3){
    case 0:
      effects.add(new CircleEffect(mouseX, mouseY));
      break;
    case 1:
      effects.add(new LineEffect(mouseX, mouseY));
      break;
    case 2:
      effects.add(new RectEffect(mouseX, mouseY));
      break;
    case 3:
      effects.add(new TriangleEffect(mouseX, mouseY));
      break;
    default:
  }
}

int previous_x = 0;
int previous_y = 0;
public void mouseDragged() {
  if(abs(mouseX - previous_x) > 100){
    effects.add(new TriangleEffect(mouseX, mouseY));
    previous_x = mouseX;
    previous_y = mouseY;
  }
}

public void mouseReleased() {
  previous_x = 0;
  previous_y = 0;
}
class CircleEffect extends EffectAbstract{
  private int r;
  private int delta_c;
  private int delta_r;
  
  CircleEffect(int temp_x, int temp_y){
    super(temp_x, temp_y);
    this.r = 10;
    this.c = 255;
    this.delta_r = 20;
    this.delta_c = 5;
  }
  
  public void display(){
    stroke(0, this.c, this.c);
    ellipse(this.x, this.y, this.r, this.r);
    this.r += this.delta_r;
    this.c -= this.delta_c;
  }
}
abstract class EffectAbstract{
  protected int x;
  protected int y;
  protected int c;
  
  EffectAbstract(int temp_x, int temp_y){
    this.x = temp_x;
    this.y = temp_y;
  }
  
  public abstract void display();

  public boolean finished(){
    if(this.c <= 0){
      return true;
    }else{
      return false;
    }
  }
}
class LineEffect extends EffectAbstract{
  private int delta_c;
  
  LineEffect(int temp_x, int temp_y){
    super(temp_x, temp_y);
    this.c = 255;
    this.delta_c = 5;
  }
  
  public void display(){
    stroke(0, this.c, this.c);
    line(0, this.y, width, this.y);
    this.c -= this.delta_c;
  }
}
class RectEffect extends EffectAbstract{
  private int l;
  private int current_deg;

  private int delta_c;
  private int delta_l;
  private int delta_deg;

  private int rotated_x;
  private int rotated_y;
  
  RectEffect(int temp_x, int temp_y){
    super(temp_x, temp_y);
    this.l = 10;
    this.c = 255;
    this.current_deg = 0;
    this.delta_l = 10;
    this.delta_c = 5;
    this.delta_deg = 5;
  }
  
  public void display(){
    stroke(0, this.c, this.c);
    translate(this.x, this.y);
    rotate(radians(current_deg));
    rect(0, 0, this.l, this.l);
    resetMatrix();
    this.l += this.delta_l;
    this.c -= this.delta_c;
    this.current_deg += this.delta_deg;
  }
}
class TriangleEffect extends EffectAbstract{
  //\u534a\u5f84r\u306e\u5186\u306b\u5185\u63a5\u3059\u308b\u4e09\u89d2\u5f62
  private int r;
  private int current_deg;

  private int delta_c;
  private int delta_r;
  private int delta_deg;

  private int rotated_x;
  private int rotated_y;
  
  TriangleEffect(int temp_x, int temp_y){
    super(temp_x, temp_y);
    this.r = 10;
    this.c = 255;
    this.current_deg = 0;
    this.delta_r = 10;
    this.delta_c = 5;
    this.delta_deg = 5;
  }
  
  public void display(){
    stroke(0, this.c, this.c);
    triangle(this.getX(current_deg), this.getY(current_deg),
             this.getX(current_deg + 120), this.getY(current_deg + 120),
             this.getX(current_deg + 240), this.getY(current_deg + 240));
    this.r += this.delta_r;
    this.c -= this.delta_c;
    this.current_deg += this.delta_deg;
  }
  
  public float getX(int deg){
    return this.x - this.r * cos(radians(deg));
  }
  
  public float getY(int deg){
     return this.y - this.r * sin(radians(deg));
  }
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "ano_gakki" });
  }
}
