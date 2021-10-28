class Projectile{
  
  PVector pos,vel,dim;
  boolean isAlive;
  
  Projectile(PVector pos, PVector vel){
    this.pos = pos;
    this.vel = vel;
    dim = new PVector(25,25);
    isAlive = true;
  }
  
  //Draws and manipulates bullet of players
  void update(){
    move();
    checkWalls();
    drawBullet();
  }
  
  //Checks to see if the projectiles hit the player or enemy and decreases health accordingly
  void hit(Character enemy){
    if(abs(pos.x-enemy.pos.x)<dim.x/2+enemy.dim.x/2 && abs(pos.y-enemy.pos.y)<dim.y/2+enemy.dim.y/2){
      enemy.hitCharacter(enemy); 
      enemy.decreaseHealth(1);
      enemy.killed();
      isAlive=false;
    }
  }
  
  //Draws and manipulates boss's bullets
  void update2(){
    move();
    checkWalls();
    drawEnemyBullet();
  }
  
  void move(){
    pos.add(vel);
  }
  
  void checkWalls(){
    if (pos.x>width || pos.x<0 || pos.y>height || pos.y<180){
      isAlive=false;
    }
    
  }
  
  //Boss's bullet
  void drawEnemyBullet(){
    pushMatrix();
    translate(pos.x,pos.y);
    fill(255);
    stroke(0);
    strokeWeight(4);
    ellipseMode(CENTER);
    ellipse(0,0,30,30);
    popMatrix();
  }
  
  //Players bullets
  void drawBullet(){
    pushMatrix();
    translate(pos.x, pos.y);
    scale(0.5);
    fill(#FFF74D);
    stroke(#FFF300);
    strokeWeight(5);
    beginShape();
    vertex(10, 8); 
    vertex(20, -10); 
    vertex(30, 8);  
    vertex(50, 10); 
    vertex(35, 25); 
    vertex(43, 45); 
    vertex(20, 35); 
    vertex(-3, 45); 
    vertex(5,25);
    vertex(-10, 10); 
    vertex(10, 8);
    endShape(CLOSE);
    popMatrix();
  }
  
}
