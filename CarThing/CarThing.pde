ArrayList<Car> cars;

boolean left;
boolean right;
boolean accel;
boolean brake;
Road r;

void setup() {
  size(1920, 1080);
  cars = new ArrayList<Car>();
    r = new Road(0, height/2, width, height/2, 4);
  cars.add(new Car(0, height/2, 2, .05, .05, r.getWaypoints(10)));

 

}
int pressTimer = 0;
void draw() {
  pressTimer ++;
  background(255);
  r.draw(r.vertex);
  if (left && pressTimer > 40){
    cars.add(new Car(0, height/2, 2, .05, .05, r.getWaypoints(10)));
    pressTimer = 0;
  }
  for (int i = 0; i < cars.size(); i++) {
    cars.get(i).draw();
    
      moveCar(cars.get(i));
    
  }
  
  r.getWaypoints(50);
 
}



void moveCar(Car player) {

  //if ( left && !right) {
  //  player.wheelAngle -= turnRate;
  //} else if (right && !left) {
  //  player.wheelAngle += turnRate;
  //}
  accel = true;
  if (accel && !brake) {
    player.speed += player.accel;
  } else if (brake && !accel) {
    player.speed -= player.brake;
  }
}



public void keyPressed() {
  if (key == 'a'||key == 'A') left = true;
  if (key == 'd'||key == 'D') right = true;
  if (key == 'w'||key == 'W') accel = true;
  if (key == 's'||key == 'S') brake = true;
}

public void keyReleased() {
  if (key == 'a'||key == 'A') left = false;
  if (key == 'd'||key == 'D') right = false;
  if (key == 'w'||key == 'W') accel = false;
  if (key == 's'||key == 'S') brake = false;
}
