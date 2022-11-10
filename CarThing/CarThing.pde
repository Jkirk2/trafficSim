ArrayList<Car> cars;
ArrayList<Node> nodes;
int pressTimer = 30;
boolean left;
boolean right;
boolean accel;
boolean brake;
boolean delete;
boolean enter;
Road r;
String mode;

void setup() {
  size(1920, 1080);
  cars = new ArrayList<Car>();
  mode = "create";
  nodes = new ArrayList<Node>();
  nodes.add(new Node(0, height/2, true));
  nodes.add(new Node(width, height/2, true));
}

void draw() {
  pressTimer --;
  if (mode == "create") {
    makeCurve();
  } else if (mode == "display") {
    background(30, 200, 30);
    r.draw();
    for (int i = 0; i < cars.size(); i++) {
      cars.get(i).draw();
      
    }
    if (enter && pressTimer < 0) {
      for (int i = 0; i < cars.size(); i++) {
        cars.remove(i);
        
      }
      pressTimer = 30;
      mode = "create";
    }
  }
}







public void keyPressed() {
  if (key == 'a'||key == 'A') left = true;
  if (key == 'd'||key == 'D') right = true;
  if (key == 'w'||key == 'W') accel = true;
  if (key == 's'||key == 'S') brake = true;
  if (key == DELETE) delete = true;
  if (key == ENTER) enter = true;
}

public void keyReleased() {
  if (key == 'a'||key == 'A') left = false;
  if (key == 'd'||key == 'D') right = false;
  if (key == 'w'||key == 'W') accel = false;
  if (key == 's'||key == 'S') brake = false;
  if (key == DELETE) delete = false;
  if (key == ENTER) enter = false;
}
