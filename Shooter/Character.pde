class Character{
  //The 5 required fields
  PVector pos;
  PVector vel;
  int charWidth;
  int charHeight;
  int health;
  
  PVector dim;
  boolean touched;//Boolean to see if health should decrease
  int deathCounter = 180;//Value for death animation when enemy is dying
  
  Character(PVector pos, PVector vel, int charWidth, int charHeight){
    this.pos = pos;
    this.vel = vel;
    this.charWidth = charWidth;
    this.charHeight = charHeight;
    
    dim = new PVector(100,100);
    touched = true;
  }
  
  void update(float charWidth, float charHeight){
    moveCharacter();
    checkWalls(charWidth, charHeight);   
  }
  
  void moveCharacter(){
    pos.add(vel);
  }
  
  void accelerate(PVector acc){
    vel.add(acc);
  }
  
  //removes enemies if they go out of bounds
  void killed(){
    if (pos.x<0){
      basicEnemy.remove(this);
    }
  }
  
  //Checks to see if the enemy touches the player
  void hitCharacter(Character enemy){
    if(abs(pos.x-enemy.pos.x)<dim.x/2+enemy.dim.x/2 && abs(pos.y-enemy.pos.y)<dim.y/2+enemy.dim.y/2){
      touched = false;
    }
  }
  
  //If the players projectile hits the enemy, its health decreases
  void decreaseHealth(int amount){
    if (touched == false){
      health -= amount;
    }
  }
  
  //If the enemy hits the Player, the players health decreases
  void decreaseHealthPlayer(int amount){
    if (touched == false){
      playerHealth -= amount;
      touched = true;
    }
  }
    
  //Player window boundaries
  void checkWalls(float charWidth, float charHeight){
    if (pos.x<-charWidth-15) pos.x=width+charWidth/2;
    if (pos.x>width+charWidth/2) pos.x=-charWidth;
    if (pos.y<180) pos.y=180;
    if (pos.y>height-charHeight) pos.y=height-charHeight;
  }
  
  //Draw method that will be overritten
  void drawCharacter(){
    noFill();
    noStroke();
    ellipse(0,0,10,10);
  }
}
