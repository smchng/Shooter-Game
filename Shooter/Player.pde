class Player extends Character{
  
  float damp = 0.6;//slows down player for better control
  float arm1 = 0; //Arm animation
  float arm = 0.5;
  float counter = 0; //for walking animation
  
  ArrayList<Projectile> proj = new ArrayList<Projectile>();
  
  Player(PVector pos, PVector dim){
    super(pos, new PVector(),100, 150);
    this.dim =dim;
  }
  
  void move(){
    super.moveCharacter();
    vel.mult(damp);
  }
  
  void update(){
    super.update(100,100);
    move();   
    checkProjectiles();
    healthBar();
    
    //If players helath become <0 the games ends
    if(playerHealth<0){
      playerHealth = 0;
      replay = false;
    }
  }
  
  //Moves players bullets
  void fire() {
    proj.add(new Projectile(new PVector(pos.x+110, pos.y+100), new PVector(5,0)));
  }
  
  //checks to see if the players projectiles hit the enemy and removes accordingly
  void checkProjectiles(){
    for (int i=0; i<proj.size(); i++) {
      Projectile p = proj.get(i);
      p.update();
      for(int j=0; j<basicEnemy.size();j++){
        Waddle enemy = basicEnemy.get(j);
        p.hit(enemy);
      }
      for(int j=0; j<thirdEnemy.size();j++){
        Wheelie enemy3 = thirdEnemy.get(j);
        p.hit(enemy3);
      }
      if (!p.isAlive) proj.remove(i);
    }
  }
  
  //Players health bar that changes depending on the damage taken
  void healthBar(){
    int barSize = 300;
    pushMatrix();
    scale(0.35);
    translate(0,0);
    rectMode(CORNER);
    fill(#F59CCD);
    stroke(#F27FBF);
    strokeWeight(5);
    image(bar, 100,100);
    fill(#4CE7FA);
    stroke(#00E3FF);
    float newHealth = (float) playerHealth/maxHealth;
    println(newHealth);
    rect(315,250, barSize*newHealth, 40);
    
    fill(255);
    textFont(font);
    textSize(60);
    text(killCount, 590, 220);
    
    popMatrix();
    
  }
  
  //3 Different methods to draw Kirby when standing, walking and shooting
  void shooting(){
    pushMatrix();
    translate(pos.x,pos.y);
    ellipseMode(CENTER);
    
    //Feet 
    fill(#ED435A);
    stroke(#FF2E4A);
    strokeWeight(5);
    ellipse(115,145,70,35);
    ellipse(85,150,40,55);
    ellipse(115,145,70,35);
    ellipse(85,150,40,55);
    
    //Arm 1
    fill(#F59CCD);
    stroke(#F27FBF);
    strokeWeight(5);
    ellipse(150,95,25,25);
    
    //Body
    ellipse(100,100,100,100);
    
    //Arm 2
    ellipse(50,95,25,25);
     
    //Face
    fill(0);
    stroke(0);
    ellipse(98,80,8,18);
    ellipse(120,80,8,18);
    
    //Mouth
    ellipse(110,118,35,40);
    
    //Pupil
    fill(255);
    stroke(255);
    ellipse(98,75,2,4);
    ellipse(120,75,2,4);
    
    //Cheek
    fill(#F27FBF);
    noStroke();
    ellipse(78,100,20,10);
    
    popMatrix();
    
  }
  
  //Kirby's stationary bullet to show if space is held
  void drawBullet(){
    pushMatrix();
    translate(pos.x+110, pos.y+100);
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
  
  void drawWalking(){
    pushMatrix();
    translate(pos.x,pos.y);
    ellipseMode(CENTER);
    
    //Feet
    fill(#ED435A);
    stroke(#FF2E4A);
    strokeWeight(5);
    if (counter%2 == 0){
      ellipse(115,145,70,35);
      ellipse(85,150,40,55);
    }else{
      ellipse(115,145,40,55);
      ellipse(85,150,70,35);
    }
    counter += 0.5;
    
    //Arm 1
    fill(#F59CCD);
    stroke(#F27FBF);
    strokeWeight(5);
    ellipse(150,95,25,25);
    
    //Body
    ellipse(100,100,100,100);
    
    //Arm 2
    ellipse(50,95,25,25);
    
    //Face
    fill(0);
    stroke(0);
    ellipse(108,90,8,18);
    ellipse(130,90,8,18);
    ellipse(120,110,3,3);
    
    //Pupil
    fill(255);
    stroke(255);
    ellipse(108,85,2,4);
    ellipse(130,85,2,4);
    
    //Cheek
    fill(#F27FBF);
    noStroke();
    ellipse(95,110,20,10);
    
    popMatrix();
  }

  
  //Kirby on standby
  void drawCharacter(){
    super.drawCharacter();
    pushMatrix();
    translate(pos.x,pos.y);
    ellipseMode(CENTER);
    
    //Feet
    fill(#ED435A);
    stroke(#FF2E4A);
    strokeWeight(5);
    ellipse(115,145,70,35);
    ellipse(85,150,40,55);
    
    //Arm 1
    fill(#F59CCD);
    stroke(#F27FBF);
    strokeWeight(5);
    ellipse(150+arm1-0.4,110+arm1-0.4,25,35);
    
    //Body
    ellipse(100,100,100,100);
    //triangle(150,125,100,40,50,125);
    
    //Arm 2
    ellipse(60+arm1,110+arm1+0.2,25,35);
    
    //Face
    fill(0);
    stroke(0);
    ellipse(108,90,8,18);
    ellipse(130,90,8,18);
    ellipse(120,110,3,3);
    
    //Pupil
    fill(255);
    stroke(255);
    ellipse(108,85,2,4);
    ellipse(130,85,2,4);
    
    //Cheek
    fill(#F27FBF);
    noStroke();
    ellipse(95,110,20,10);
    
    arm1 += arm;
    if (abs(arm1) > 3){
      arm*= -1;
    }
    
    popMatrix();
  }
  
}
