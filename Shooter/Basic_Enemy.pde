class Waddle extends Character{
  
  float even = 0; //Moves the feet depending is the coutner is odd or even
  float counter = 0;//for leg movement animation
  float count = 1;
  float arm1 = 0; //For arm movement animation
  float arm = 0.5;
  int fade = 255;// When dying it will slowly decay
  
  PVector dim;
  
  ArrayList<Projectile> proj = new ArrayList<Projectile>();
  
  Waddle(PVector pos, PVector vel, PVector dim){
    super(pos, vel,100, 150);
    this.dim=dim;
    health = 3; // health of basicEnemy
  }
  
  void update(){
    checkWalls();
    
    //Method to check if the player is touching the enemy and decrease health if so
    for (int i=0; i<basicEnemy.size(); i++){
      Character current = basicEnemy.get(i);
      hitCharacter(play);
      decreaseHealthPlayer(1);
    }
    
    //Depending on its health, it will...
    //Draw the enemy walking
    if(health>0){
      drawCharacter();
      pos.add(vel);
    }
    //Showing the dying enemy
    if (health==0 || health < 0){
      println(deathCounter);
      drawDead();
      deathCounter--;
    }
    //Incease killcount, and removes the dying enemy after 1 second and resets the animation time
    if(deathCounter<120){
      killCount++;
      speedCounter++;
      basicEnemy.remove(this);
      deathCounter=180;
    }
    //If the enemies reach below the threshold it will call the respawn method
    //Added the replay boolean so it does not spawn more after player dies
    if (basicEnemy.size() < basicMax && replay!=false){
      respawn();
    }
  }
   
  //Removes the object if it goes out of bounds
  void checkWalls(){
    if (pos.x<-100 || pos.y>height){
      killed();
    }
  }
  
  //Respawn method
  void respawn(){
    //Checks inside the list to see is a boss exists
    //If it does the boolean is true and another will not spawn
    if (basicEnemy.contains(second)){
    bossDead = true;
    }
    //If the ArrayList does not have a boss enemy in it, it will spawn that one first (top priority)
    //Resets the boolean so that another does not spawn
    if (bossDead == false){
      second = new Chilly(new PVector(random(1100,2000), random(280,800)), new PVector(speed,0), new PVector (80,180));
      basicEnemy.add(second);
      bossDead = true;
    }else{
      basicEnemy.add(new Waddle(new PVector(random(1500,2000), random(280,800)), new PVector(speed,0), new PVector (100,100)));
    }
  }
  
  //Basic enemy death drawing
  void drawDead(){
    fade-=5;
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(radians(45));
    ellipseMode(CENTER);
    
    //Foot 1
    fill(#FF9634,fade);
    stroke(#BF830A,fade);    
    strokeWeight(5);
    ellipse(-15,45,70,35);
    
    //Arm 1
    fill(#EAB447,fade);
    stroke(#BF830A,fade);
    strokeWeight(5);
    ellipse(-50,8,25,35);
    
    //Body
    ellipse(0,0,100,100);
    fill(#FCDB99,fade);
    noStroke();
    ellipse(-5,8,90,70);
    ellipse(-5,-12,80,60);
    
    //Foot 2
    fill(#FF9634,fade);
    stroke(#BF830A,fade);
    strokeWeight(5);
    ellipse(10,45,70,35);
    
    //Cheek
    fill(#FFAE62,fade);
    noStroke();
    ellipse(20,3,20,10);
    
    //Arm 2    
    strokeWeight(8);
    stroke(#552C06,fade);
    line(25,-50,25,30);
    fill(#F0F0F0,fade);
    stroke(#D3D3D3,fade);
    quad(25,-50,20,-60,25,-70,30,-60);
    fill(#EAB447,fade);
    stroke(#BF830A,fade);
    strokeWeight(5);
    ellipse(35,10,25,35);
    
    //Eyes
    fill(0,fade);
    stroke(0,fade);
    line(-20,-10,-30,0);
    line(-30,-20,-20,-10);
    line(0,-10,10,0);
    line(10,-20,0,-10);
    
    popMatrix();
  }
  
  //Regular enemy drawing that overrides Character
  void drawCharacter(){
    even+=1;
    super.drawCharacter();
    pushMatrix();
    translate(pos.x,pos.y);
    ellipseMode(CENTER);
    
    //Foot 1
    fill(#FF9634);
    stroke(#BF830A);
    strokeWeight(5);
    ellipse(-15+counter,45,70,35);
    
    //Arm 1
    fill(#EAB447);
    stroke(#BF830A);
    strokeWeight(5);
    ellipse(-50+arm1,8+arm1+0.2,25,35);
    
    //Body
    ellipse(0,0,100,100);
    fill(#FCDB99);
    noStroke();
    ellipse(-5,8,90,70);
    ellipse(-5,-12,80,60);
    
    //Foot 2
    fill(#FF9634);
    stroke(#BF830A);
    strokeWeight(5);
    ellipse(10+counter,45+counter,70,35);
    
    if (even%2 != 0){
      counter += count;
      if (abs(counter) > 5){
        count *= -1;
      }
    }
    
    //Cheek
    fill(#FFAE62);
    noStroke();
    ellipse(20,3,20,10);
    
    //Arm 2    
    strokeWeight(8);
    stroke(#552C06);
    line(25+arm1,-50+arm1,25+arm1,30+arm1);
    fill(#F0F0F0);
    stroke(#D3D3D3);
    quad(25+arm1,-50+arm1,20+arm1,-60+arm1,25+arm1,-70+arm1,30+arm1,-60+arm1);
    fill(#EAB447);
    stroke(#BF830A);
    strokeWeight(5);
    ellipse(35+arm1-0.4,10+arm1-0.4,25,35);
    
    
    arm1 += arm;
    if (abs(arm1) > 3){
      arm*= -1;
    }
    
    //Eyes
    fill(0);
    stroke(0);
    ellipse(-25,-10,8,18);
    ellipse(0,-10,8,18);
    
    //Pupils
    fill(255);
    stroke(255);
    ellipse(-25,-15,2,4);
    ellipse(0,-15,2,4);
    
    popMatrix();
  }
  
}
