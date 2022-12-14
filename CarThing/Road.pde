class Road {
  float xStart;
  float yStart;
  float xFinish;
  float yFinish;
  int vertex;
  float w = 20;
  float xVertex[];
  float yVertex[];
  ArrayList<Coord> waypoints;
  ArrayList<Node> segments;
  Road(ArrayList<Node> segments) {

    this.segments=segments;
    vertex = segments.size();


    createRoad();
    waypoints = getWaypoints();
  }


  void createRoad() {
    vertex = vertex +2;
    xVertex = new float [vertex];
    yVertex = new float [vertex];
    
    xVertex[0] = segments.get(0).x-50;
    yVertex[0] = segments.get(0).y;
    xVertex[xVertex.length-1] = segments.get(segments.size()-1).x+50;
    yVertex[yVertex.length-1] = segments.get(segments.size()-1).y;
    for (int i = 0; i < segments.size(); i++) {
      xVertex[i+1] = segments.get(i).x;
      yVertex[i+1] = segments.get(i).y;
    }

  }

  void draw() {
    strokeWeight(60);
    stroke(100);
    beginShape();
    noFill();
    curveVertex(xStart, yStart);
    for (int i = 0; i < vertex; i++) {
      curveVertex(xVertex[i], yVertex[i]);
    }
    curveVertex(xFinish, yFinish);
    endShape();
    strokeWeight(1);
    stroke(0);
  }

  ArrayList<Coord> getWaypoints() {
    ArrayList<Coord> temp = new ArrayList<Coord>();
    int index = 0;
    float x;
    float y;
    for (int i = 0; i < width; i++) {
      int x0 = index-2;
      int x1 = index-1;
      int x2 = index;
      int x3 = index+1;
      if (x0 < 0) {
        x0 = 0;
      }
      if (x1 < 0) {
        x1 = 0;
      }
      if (x3 > xVertex.length) {
        x3 = xVertex.length;
      }
      float t;
      if ((xVertex[x2]-xVertex[x1]) > 0) {
        t = (i - xVertex[x1])/(xVertex[x2]-xVertex[x1]);
      } else {
        t = 0;
      }
      x = curvePoint(xVertex[x0], xVertex[x1], xVertex[x2], xVertex[x3], t);
      y = curvePoint(yVertex[x0], yVertex[x1], yVertex[x2], yVertex[x3], t);
      temp.add(new Coord(x, y));
      if (i > xVertex[index]) {
        index++;
      }
    }
    return temp;
  }

  ArrayList<Coord> getWaypoints(int dist) {
    float lastX = waypoints.get(0).x;
    float lastY = waypoints.get(0).y;
    ArrayList<Coord> temp = new ArrayList<Coord>();
    temp.add(new Coord(lastX, lastY));
    for (int i = 0; i < waypoints.size(); i++) {

      if (dist(lastX, lastY, waypoints.get(i).x, waypoints.get(i).y)>=dist) {
        fill(255, 0, 0);
        temp.add(new Coord(waypoints.get(i).x, waypoints.get(i).y));


        lastX = waypoints.get(i).x;
        lastY = waypoints.get(i).y;
      }
    }
    return temp;
  }
}
