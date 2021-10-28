class Wheelie extends Waddle{
  
  //Third extra enemy, same code as other enemies
  
  int fade = 255;
  int health;
  
  Wheelie(PVector pos, PVector vel, PVector dim){
    super(pos,vel,dim);
    health = 2;
  }
  
  void killed(){
    thirdEnemy.remove(this);
  }
  
  void update(){
    arrow();
    
    for (int i=0; i<thirdEnemy.size(); i++){
      Character current = thirdEnemy.get(i);
      hitCharacter(play);
      decreaseHealthPlayer(1);
    }
    
    if(health>0){
      drawCharacter();
      pos.add(vel);
    }
    if (health==0 || health < 0){
      drawDead();
      deathCounter--;
    }
    if(deathCounter<0){
      wheelieCounter++;
      killCount++;
      basicEnemy.remove(this);
      deathCounter=60;
    }
    checkWalls();
    if (thirdEnemy.size() == 0 && replay!=false){
      wheelieTimer = 1200;
      respawn();
    }
  }
  
  void respawn(){
    thirdEnemy.add(new Wheelie(new PVector(random(1100,2000), random(280,800)), new PVector(-20,0), new PVector (110,110)));   
  }
  
  //Draws an arrow to alert player before hand where it is coming from
  void arrow(){
    pushMatrix();
    translate(1050,pos.y);
    ellipseMode(CENTER);
    fill(#FF3636);
    stroke(#FF0F0F);
    strokeWeight(5);
    quad(-8,5,8,5,12,-35,-12,-35);
    ellipse(0,30,20,20);
    popMatrix();
  }
  
  void drawDead(){
    fade-=2;
    pushMatrix();
    translate(pos.x,pos.y);
    rectMode(CENTER);
    ellipseMode(CENTER);
    
    fill(50,fade);
    stroke(0,fade);
    strokeWeight(5);
    ellipse(0,0,110,110);
    
    fill(255,fade);
    strokeWeight(8);
    ellipse(0,0,60,60);
    
    fill(#10289B,fade);
    noStroke();
    ellipse(0,0,30,30);
    
    fill(255,fade);
    ellipse(-3,-5,15,15);
    ellipse(5,8,5,5);
    
    fill(#F72900,fade);
    arc(0,0,52,52,radians(-160),radians(25));
   
    popMatrix(); 
  }
  
  void drawCharacter(){
  pushMatrix();
  translate(pos.x,pos.y);
  rectMode(CENTER);
  ellipseMode(CENTER);
  
  fill(50);
  stroke(0);
  strokeWeight(5);
  ellipse(0,0,110,110);
  
  fill(255);
  strokeWeight(8);
  ellipse(0,0,60,60);
  
  fill(#10289B);
  noStroke();
  ellipse(0,0,30,30);
  
  fill(255);
  ellipse(-3,-5,15,15);
  ellipse(5,8,5,5);
  
  fill(#F72900);
  arc(0,0,52,52,radians(-160),radians(25));
 
  popMatrix();
  }
  
}
