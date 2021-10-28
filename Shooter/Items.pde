class Items {
  
  //Class for apple item that will heal Kirby if touched
  
  PVector pos, vel,dim;
  float itemCounter;
  
  Items(PVector pos, PVector vel, PVector dim){
    this.pos = pos;
    this.vel = vel;
    this.dim = dim;
    itemCounter = random(0,50);
  }
  
  //Rare item so it only appears if the counter is equal to 12, nothing else
  void update(){
    
    //Method to check if the player is touching the item
    //If it is, player increases health by 100
    for (int i=0; i<appleList.size(); i++){
      Items current = appleList.get(i);
      if(abs(pos.x-play.pos.x)<dim.x/2+play.dim.x/2 && abs(pos.y-play.pos.y)<dim.y/2+play.dim.y/2){
        playerHealth+=100;
        appleList.remove(i);
      }
    }
    
    if (itemCounter == 12.0){
      move();
      checkWalls();
      acc(new PVector(-0.05,0));
      appleDraw();
    }
  }
    
  void move(){
    pos.add(vel);
  }
  
  void checkWalls(){
    if (pos.x<-100){
      appleList.remove(this);
    }
  }
  
  void acc(PVector acc){
    vel.add(acc);
  }
  
  
  void appleDraw(){
    scale(0.15);
    image(apple, pos.x, pos.y);
  }
}
