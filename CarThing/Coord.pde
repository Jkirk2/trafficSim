
class Coord {
  float x;
  float y;
  Coord(float x, float y) {
    this.x=x;
    this.y=y;
  }
}

class Node {
  float x;
  float y;
  boolean endNode;
  float size;
  float startX;

  Node(float x, float y, boolean endNode) {
    this.x=x;
    this.y=y;
    this.endNode = endNode;
    size = 30;
    startX = x;
  }
  
  boolean mouseOver() {
    if (!endNode) {
      if (dist(x, y, mouseX, mouseY) < size/2) {
        return true;
      }
      return false;
    } else {
      if (mouseX < x + size && mouseX > x - size  && mouseY < y + size && mouseY > y - size) {
        return true;
      } else {
        return false;
      }
    }
  }
  void draw() {
    stroke(0);
    fill(0, 200, 200);


    if (mouseOver()) {
      strokeWeight(3);
      stroke(255, 100, 0, 200);
    }
    if (!endNode) {
      ellipse(x, y, size, size);
    } else {
      x = startX;
      rectMode(CENTER);
      rect(x, y, size, size);
    }
  }
}





int selectIndex;
boolean moveMode = false;

void makeCurve() {
  cursor(ARROW);
  if (moveMode && mousePressed) {
    cursor(MOVE);
  } else if (moveMode && !mousePressed) {
    moveMode = false;
  }

  background(255);
  if(!moveMode){
  sortByX();
  }
  try{
   r = new Road(nodes); 
   r.draw();
  }
  catch(Exception e){
    
  }
  
  for (int i = 0; i < nodes.size(); i++) {
    if (nodes.get(i).mouseOver() && !nodes.get(i).endNode && delete) {
      nodes.remove(i);
      moveMode = false;
    }
  }
  
  for (int i = 0; i < nodes.size(); i++) {
    nodes.get(i).draw();

    if (i == selectIndex && moveMode) {
      nodes.get(i).x = mouseX;
      nodes.get(i).y = mouseY;
    }
  }
  if(enter&& pressTimer < 0){
   mode = "display"; 
   pressTimer = 30;
  }
}

void sortByX(){
  while(!sortCheck()){
    for(int i = 0; i < nodes.size()-1; i++){
         if( nodes.get(i).x > nodes.get(i+1).x){
           Node temp1 = new Node(nodes.get(i).x,nodes.get(i).y,nodes.get(i).endNode);
           Node temp2 = new Node(nodes.get(i+1).x,nodes.get(i+1).y,nodes.get(i+1).endNode);
           temp1.startX = nodes.get(i).startX;
            temp2.startX = nodes.get(i+1).startX;
           nodes.set(i,temp2);
           nodes.set(i+1,temp1);
         }
    }
    
  }
  
}

boolean sortCheck(){ 
 for(int i = 0; i < nodes.size()-1; i++){
  if( nodes.get(i).x > nodes.get(i+1).x){
   return false; 
  }
 }
 return true;
}


void mouseClicked() {
  if (mode == "create") {
    if (!moveMode) {
      nodes.add(new Node(mouseX, mouseY, false));
    }
  }
  else{
   cars.add(new Car(mouseX,mouseY,random(2,5),random(.03,.1),random(.03,.1),r.getWaypoints(70)));
   //Car(float x, float y, float topSpeed, float brake, float accel, ArrayList<Coord> paths) {
  }

}

void mouseDragged() {
  if (!moveMode) {
    for (int i = 0; i < nodes.size(); i++) {
      if (nodes.get(i).mouseOver()) {
        selectIndex = i;
        moveMode = true;
      }
    }
  }
}
