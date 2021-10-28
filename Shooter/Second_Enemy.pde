class Chilly extends Waddle{
  
  //Boss enemy
  
  ArrayList<Projectile> proj = new ArrayList<Projectile>();//It projectiles in a list 
  
  int counter=0;//For hand animation
  int fade = 255;
  boolean isAlive = true;
  
  Chilly(PVector pos, PVector vel, PVector dim){
    super(pos,vel,dim);
    health = 6;
  }
  
  void update(){
    counter++;
    
    //Method to check if the player is touching the enemy and decrease health if so
    for (int i=0; i<basicEnemy.size(); i++){
      Character current = basicEnemy.get(i);
      hitCharacter(play);
      decreaseHealthPlayer(1);
    }
    
    //Regular enemy drawn
    if(health>0){
      drawCharacter();
      pos.add(vel);
    }
    //Shows death animation
    if (health==0 || health < 0){
      drawDead();
      deathCounter--;
    }
    //Removes the enemy after 3 seconds of dying
    if(deathCounter<0){
      killCount++;
      basicEnemy.remove(this);
      deathCounter=180;
    }
    //Boolean to check if the current enemy is dead to trigger a respawn
     if (this == second){
      bossDead = false;
     }
    checkWalls();
    checkProjectiles();
    //Shooting buffer so it is no constant
    //Only shoots once ball every second
    if(counter%60==0&&health>0){
      shoot();
    }
  }
  
  //Bosses projectiles
  //checks if it hits the enemy and removes it if it does
  void checkProjectiles(){
    for (int i=0; i<proj.size(); i++) {
      Projectile p = proj.get(i);
      p.update2();
      if(abs(p.pos.x-play.pos.x)<p.dim.x/2+play.dim.x/2 && abs(p.pos.y-play.pos.y)<p.dim.y/2+play.dim.y/2){
        println("shot");
        proj.remove(i);
        playerHealth--;
      }
    }
  }
  
  //Moves the projectiles
  void shoot() {
    proj.add(new Projectile(new PVector(pos.x+10, pos.y+50), new PVector(-5,0)));
  }
  
  //Dead drawing
  void drawDead(){
    fade-=2;
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(radians(45));
    rectMode(CENTER);
    ellipseMode(CENTER);
    
    //Hat
    fill(#3517FF,fade);
    strokeWeight(5);
    stroke(0,fade);
    quad(-10,0,65,0,55,-45,0,-45);
    
    //Hand1
    fill(#FFE817,fade);
    ellipse(-10,50,40,40);
    
    //Body
    fill(255,fade);
    ellipse(35,70,100,90);
    
    //Bell
    fill(#FFE817,fade);
    ellipse(20,70,30,30);
    
    //head
    fill(255,fade);
    ellipse(25,20,90,80);
    
    //Hand2
    fill(#FFE817,fade);
    ellipse(65,45,40,40);
    
    //Eyes
    fill(0,fade);
    stroke(0,fade);
    line(-5,25,5,15);
    line(5,25,-5,15);
    line(35,25,25,15);
    line(25,25,35,15);
    
    //Eyebrows
    stroke(0,fade);
    strokeWeight(12);
    line(0,1,-15,-8);
    line(20,1,35,-8);
   
    popMatrix();
  }
  
  //Regular drawing
  void drawCharacter(){
    
    pushMatrix();
    translate(pos.x,pos.y);
    rectMode(CENTER);
    ellipseMode(CENTER);
    
    //Hat
    fill(#3517FF);
    strokeWeight(5);
    stroke(0);
    quad(-10,0,65,0,55,-45,0,-45);
    
    //Hand1
    fill(#FFE817);
    ellipse(-10-arm1,50-arm1-0.4,40,40);
    
    //Body
    fill(255);
    ellipse(35,70,100,90);
    
    //Bell
    fill(#FFE817);
    ellipse(20,70,30,30);
    
    //head
    fill(255);
    ellipse(25,20,90,80);
    
    //Hand2
    fill(#FFE817);
    ellipse(65+arm1,45+arm1-0.4,40,40);
    
    //Eyes
    fill(0);
    stroke(0);
    ellipse(0,15,12,21);
    ellipse(20,15,12,21);
    
    //Pupil
    fill(255);
    stroke(255);
    ellipse(-2,13,5,8);
    ellipse(18,13,5,8);
    
    //Eyebrows
    stroke(0);
    strokeWeight(12);
    line(0,1,-15,-8);
    line(20,1,35,-8);
    
    arm1 += arm;
    if (abs(arm1) > 3){
      arm*= -1;
    }
    
    popMatrix();
    
  }
  
}
