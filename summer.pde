Population test;
PVector goal  = new PVector(650, 10);


void setup() {
  size(800,800); //size of the window
  frameRate(10000);//increase this to make the dots go faster
  test = new Population(1500);//create a new population with 1000 members
}


void draw() { 
  background(255);

  //draw goal
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);

  //draw obstacle(s)
  fill(0, 0, 255);       //blue top
  rect(0, 300, 500, 5);
  
  fill(0,255,0);        // green right
  rect(450,450,800,5);
  
  fill(255,0,0);        // bottom red
  rect(300,700,600,5);
  
  fill(10,100,90); //left 
  rect(0,450,250,5);
  
  fill(255,200,100);
  rect(0,100,500,5);
  
  fill(45,96,85);
  rect(500,200,400,5);
  
  fill(100,255,255);
  rect(0,560,400,5);

  if (test.allDotsDead()) {
    //genetic algorithm
    test.calculateFitness();
    test.naturalSelection();
    test.mutateDemBabies();
  } else {
    //if any of the dots are still alive then update and then show them

    test.update();
    test.show();
  }
}
