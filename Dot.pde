class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;

  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;//true if this dot is the best dot from the previous generation

  float fitness = 0;

  Dot() {
    brain = new Brain(1500);//new brain with 1000 instructions

    //start the dots at the bottom of the window with a no velocity or acceleration
    pos = new PVector(width/2+200, height- 10);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }


  //-----------------------------------------------------------------------------------------------------------------
  //draws the dot on the screen
  void show() {
    //if this dot is the best dot from the previous generation then draw it as a big green dot
    if (isBest) {
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    } else {//all other dots are just smaller black dots
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }

  //-----------------------------------------------------------------------------------------------------------------------
  //moves the dot according to the brains directions
  void move() {

    if (brain.directions.length > brain.step) {//if there are still directions left then set the acceleration as the next PVector in the direcitons array
      acc = brain.directions[brain.step];
      brain.step++;
    } else {//if at the end of the directions array then the dot is dead
     dead = true;
    }

    //apply the acceleration and move the dot
    vel.add(acc);
    vel.limit(5);//not too fast
    pos.add(vel);
  }

  //-------------------------------------------------------------------------------------------------------------------
  //calls the move function and check for collisions and stuff
  void update() {
    if (!dead && !reachedGoal) {
      move();
      if (pos.x< 2|| pos.y<2 || pos.x>width-2 || pos.y>height -2) {//if near the edges of the window then kill it 
        dead = true;
      } else if (dist(pos.x, pos.y, goal.x, goal.y) < 5) {//if reached goal

        reachedGoal = true;
      } else if (   pos.x< 500 && pos.y < 305 && pos.x > 0   && pos.y > 300    ||            // blue
                    pos.x< 800 && pos.y < 455 && pos.x > 450 && pos.y > 450    ||            //light green
                    pos.x< 800 && pos.y < 705 && pos.x > 300 && pos.y > 700    ||            //red
                    pos.x< 250 && pos.y < 455 && pos.x > 0   && pos.y > 450    ||            //dark green
                    pos.x< 500 && pos.y < 105 && pos.x > 0 && pos.y > 100    ||            //yellow
                    pos.x< 900 && pos.y < 205 && pos.x > 500 && pos.y > 200    ||            //upper dark green
                    pos.x< 400 && pos.y < 565 && pos.x > 0   && pos.y > 560                  // light blue
                 ) {//if hit obstacle   
        dead = true;
      }
    }
  }


  //--------------------------------------------------------------------------------------------------------------------------------------
  //calculates the fitness
  void calculateFitness() {
    if (reachedGoal) {//if the dot reached the goal then the fitness is based on the amount of steps it took to get there
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step * brain.step);
    } else {//if the dot didn't reach the goal then the fitness is based on how close it is to the goal
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0/(distanceToGoal * distanceToGoal);
    }
    
  }

  //---------------------------------------------------------------------------------------------------------------------------------------
  //clone it 
  Dot gimmeBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();//babies have the same brain as their parents
    return baby;
  }
}
