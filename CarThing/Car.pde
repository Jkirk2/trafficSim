class Car {
  float x;
  float y;
  float rd;
  float g;
  float b;
  float topSpeed = 10;
  float speed;
  float brake = .1;
  float accel = .1;
  float wheelAngle;
  float maxAngle = PI/10 ;
  
  float rotation;
  float r;
  float size = 30;
  float turnRate = .01;
  int  pathIndex;
  float rotTarget;
  ArrayList<Coord> waypoints;
  Car(float x, float y, float topSpeed, float brake, float accel,ArrayList<Coord> paths) {
    this.topSpeed = topSpeed;
    pathIndex = 0;
    this.brake = brake;
    this.accel=accel;
   
    this.x=x;
    this.y=y;
    rd=random(255);
    g=random(255);
    b=random(255);
    wheelAngle = 0;
    waypoints = new ArrayList<Coord>();
    setWaypoints(paths);
    waypoints.add( new Coord(waypoints.get(waypoints.size()-1).x + 200,waypoints.get(waypoints.size()-1).y));
     for(int i = 0; i < waypoints.size(); i++){
      println(i,waypoints.get(i).x,waypoints.get(i).y); 
     }
  }
  
  void setWaypoints(ArrayList<Coord> path){
   waypoints = path; 
   float minDist = 99999999;
   for(int i = 0; i < waypoints.size(); i++){
     if(minDist > dist(x,y,waypoints.get(i).x,waypoints.get(i).y)){
      minDist =  dist(x,y,waypoints.get(i).x,waypoints.get(i).y);
      pathIndex = i;

     }
   }
  }



  void draw() {
    //wrap();
    checkAngles();
    displayCar();
  }

  void displayCar() {
    pushMatrix();
    translate(x, y);
    rotate(r);
    fill(0);
    rect(-.4*size, size*.26, .3*size, .2*size, 100);
    rect(-.4*size, -size*.26, .3*size, .2*size, 100);
    pushMatrix();
    translate(size*.4, size*.26);
    rotate(wheelAngle);
    rect(0, 0, .3*size, .2*size, 100);
    popMatrix();
    pushMatrix();
    translate(size*.4, -size*.26);
    rotate(wheelAngle);
    rect(0, 0, .3*size, .2*size, 100);
    popMatrix();
    rectMode(CENTER);
    fill(100);
    pushMatrix();
    rotate(wheelAngle);
    popMatrix();
    fill(rd,g,b);
    rect(0, 0, size, size/2);

    popMatrix();
    
    x+= speed * cos(r+wheelAngle);
    y+= speed * sin(r+wheelAngle);
    rotation = wheelAngle/7;
    if(speed == 0){
     rotation = 0; 
    }
    else if(speed <1){
     rotation = rotation * speed; 
    }
    r += rotation;
    
    drive();
  }

  void checkAngles() {
    float velocity = abs(speed)*.2;
    if(velocity < 1){
     velocity = 1; 
    }
    float adjustAngle = maxAngle/velocity;
    
    
    if (wheelAngle > adjustAngle) {
      wheelAngle = adjustAngle;
    } else if (wheelAngle < -adjustAngle) {
      wheelAngle = -adjustAngle;
    }
    if (speed > topSpeed) {
      speed = topSpeed;
    }
    speed -=.01;
    if (speed <0){
     speed = 0; 
    }
    
    r = loopRad(r);
  }
  
  void drive(){

    float targetX = waypoints.get(pathIndex).x;
    float targetY = waypoints.get(pathIndex).y;
    float xRelative = targetX - x;
    float yRelative = -1* (targetY - y);
    rotTarget = -atan2(xRelative,yRelative)+PI/2;
    rotTarget = -loopRad(-rotTarget);
    float steerAngle = -loopRad(r+wheelAngle);
    float aDelta = angleDist(steerAngle,rotTarget);
    
    
    if(aDelta >= 0 || abs(aDelta) >=178){
     wheelAngle -= turnRate;
    }
    else{
     wheelAngle += turnRate; 
    }
    
    if(dist(x,y,targetX,targetY) <=60){
     pathIndex ++; 
     if(pathIndex == waypoints.size()){
      pathIndex = 0; 
      x=-200;
      y = height/2;
     }
     
    }
    
    
  }
  
  void wrap(){
   if(x > width + size){
    x = -size; 
   }
   else if(x < -size){
    x = width + size; 
   }
   
    if(y > height + size){
    y = -size; 
   }
   else if(y < -size){
    y = height + size; 
   }
   
  }
  
  float loopRad(float angle){
    float temp = angle;
    if(-temp < 0){
      temp = -(2*PI + -temp);
    }
    if(-temp > PI*2){
     temp = -(0 + -temp - PI*2); 
    }
    return temp;
  }
  float angleDist(float current, float goal){
      float leftDist;
      float rightDist;
      if(goal >= current){
        leftDist = goal-current;
      }
      else{
       leftDist = (2*PI - current)+ goal;
      }
      if(goal <= current){
       rightDist = current - goal; 
      }
      else{
        rightDist = current + PI*2 - goal;
      }
      if(leftDist <= rightDist){
       return leftDist; 
      }
      else{
       return -rightDist; 
      }
      
  }

  
}
