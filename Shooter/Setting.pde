//Code for the background

class Setting{
  float cloud;
  
  Setting (){
    cloud = 0;
  }
  
  void setting(){
  pushMatrix();
  background(#32c8dc);
  translate(width/2,height/2);
  rectMode(CENTER);
  ellipseMode(CENTER);
  
  //Cloud (Code is from Assignment 1 but updated)
  pushMatrix();
  noStroke();
  fill(192,212,224);
  translate(-width/2,-height/2-100);
  scale(2);
  ellipse(95 + cloud,120,100,60);
  ellipse(150 + cloud,90,100,60);
  ellipse(175 + cloud,120,100,60);
  ellipse(cloud,120,100,60);
  ellipse(55 + cloud,90,100,60);
  ellipse(80+ cloud,120,100,60);
  cloud = cloud + 1.5;
  if (cloud > 600){
    cloud = -350;
  }
  popMatrix();
  
  //Hills
  fill(#1AB725);
  stroke(#2D9B32);
  strokeWeight(7);
  ellipse(-450,-100, 100,200);
  ellipse(400,-100, 200,400);
  ellipse(270,-100, 100,200);
  ellipse(-350,-100, 200,400);
  ellipse(-200,-100, 100,200);
  ellipse(100,-100, 200,400);
  
  //Grass area
  fill(#32b716);
  stroke(#0F9815);
  strokeWeight(10);
  //Light patches
  rect(0,200,1200,600);
  //Dark Patches
  noStroke();
  fill(#13A71D);
  rect(-452,-10,195,170);
  rect(-70,-10,195,170);
  rect(320,-10,195,170);
  rect(-452,355,195,170);
  rect(-70,355,195,170);
  rect(320,355,195,170);
  rect(-265,175,195,190);
  rect(125,175,195,190);
  rect(515,175,195,190);
  //Vertical
  stroke(#0F9815);
  strokeWeight(10);
  line(-360,-100,-360,800);
  line(-165,-100,-165,800);
  line(30,-100,30,800);
  line(225,-100,225,800);
  line(420,-100,420,800);
  //Horizontal
  line(-600,80,600,80);
  line(-600,275,600,275);
  popMatrix();
}
}
