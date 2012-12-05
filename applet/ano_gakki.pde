import processing.opengl.*;

ArrayList effects;

void setup(){
  size(2000, 700, OPENGL);
  noFill();
  smooth();
  strokeWeight(20);
  rectMode(CENTER);
  effects = new ArrayList();
}

void draw(){
  background(0);
  for(int i = 0;i < effects.size(); i++){
    EffectAbstract effect = (EffectAbstract) effects.get(i);
    effect.display();
    if(effect.finished()){
      effects.remove(i);
    }
  }
}

void mousePressed(){
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
void mouseDragged() {
  if(abs(mouseX - previous_x) > 100){
    effects.add(new TriangleEffect(mouseX, mouseY));
    previous_x = mouseX;
    previous_y = mouseY;
  }
}

void mouseReleased() {
  previous_x = 0;
  previous_y = 0;
}
