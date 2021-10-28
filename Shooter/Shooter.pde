//Samantha Chung D101
//301426865

//Some code and methdod order was referenced off previous lab challenges but it was modified

/*Kirby has 2 images: open mouth and closed mouth
It also has a walking animation and a standby animation
When space is pressed kirby's mouth opens and it shoots out stars
Kirby has a health bar to show its life
Waddle dee are the basicEnemy and needs to be shot 3 times to die
Chilly are the bossEnemy and shoots snowballs at kirby. It need to be shot 6 times to die
Every 20 seconds of game play, one or more wheelies are shown. They move 2x speed
Wheelie can be shot but its better to dodge them

Kirby initial spawn at left side of screen
Apples will appear to give health
Invincible Candy will also appear if kirby is about to die or they beat 30 enemies

If you kill 30 enemies you get bronze star
if you survive for 5 mins without dying
If you kill 10 Wheelies you get gold star
*/

//Code that assigns speeds to the variables
PVector upAcc = new PVector(0,-2);
PVector downAcc = new PVector(0,2);
PVector leftAcc = new PVector(-2,0);
PVector rightAcc = new PVector(2,0);

boolean up, down, left, right, space; //Booleans than checks which arrow keys are pressed
boolean start = true; // Boolean to see if the button to start the game is pressed
boolean replay = true; // Boolean to end game if player health reaches 0
boolean bossDead; //Boolean to spawn a new boss when a boss is killed

int basicMax = 8; //The max amount of basic enemies able to spawn at a time with the boss enemy hidden in it too
int thirdMax = 2; //the max amount of wheelies able to spawn at once
int wheelieTimer = 2000;// Timer to make wheelies spawn in intervals
int appleMax = 1;
int killCount; // Counter for how many enemies you killed
int speedCounter = killCount; // Depending on how many enemies you kill the enemies become faster and faster
int speed = -3; //initial speed of the boss and basic enemies
int maxHealth = 200; //the maximum health of the player
int playerHealth = maxHealth; // the health of player that will decrease
int gameCount; //Times how long you have played for, for achievement
int wheelieCounter=0;//How many wheelies you have killed

//Font and image uploaded for details in the game
PFont font; //for healthbar "Kirby"
PImage bar;//for back of helath bar
PImage narration;//The start screen image
PImage apple; //Power up
PImage end;//The end screen when you die'
PImage gold;//Achievement medals
PImage silver;
PImage bronze;

//Reference variables to the classes
Setting set = new Setting();
Player play = new Player(new PVector(50,370), new PVector(100,100));
Waddle basic = new Waddle(new PVector(random(1100,2000), random(280,800)), new PVector(speed,0), new PVector (100,100));
Chilly second = new Chilly(new PVector(random(1100,2000), random(280,800)), new PVector(speed,0), new PVector (100,180));
Wheelie third = new Wheelie(new PVector (random(1500,2000), random(280,800)), new PVector(-20,0), new PVector (110,110));
Items apples = new Items (new PVector(7500, random(2000,5000)), new PVector(-2,0), new PVector (50,50));

//ArrayLists to store each instance of the characters
ArrayList<Waddle> basicEnemy = new ArrayList<Waddle>();
ArrayList<Wheelie> thirdEnemy = new ArrayList<Wheelie>();
ArrayList<Player> you = new ArrayList<Player>();
ArrayList<Items> appleList = new ArrayList<Items>();
       
void setup(){
  size (1100,800);
  
  //Images and fonts that I imported
  bar = loadImage("Healthbar.png");
  narration = loadImage("Narration.png");
  apple = loadImage("Apple.png");
  end = loadImage("end.png");
  gold = loadImage("gold.png");
  silver = loadImage("silver.png");
  bronze = loadImage("bronze.png");
  
  font = loadFont("ArialRoundedMTBold-48.vlw");
  
  //Line to "hide" instance of boss enemy in to the basicEnemy ArrayList
  basicEnemy.add(second);
  
  //Adding each instance of the characters in to a list
  for(int i = 0; i<basicMax; i++){
     basicEnemy.add(new Waddle(new PVector(random(1100,2000), random(280,775)), new PVector(speed,0), new PVector (100,100)));
  }
  for(int i = 0; i<thirdMax; i++){
     thirdEnemy.add(new Wheelie(new PVector(random(1500,2000), random(280,750)), new PVector(-20,0), new PVector (110,110)));
  }
  for(int i = 0; i<appleMax; i++){
     appleList.add(new Items(new PVector(7500,random(2000,5000)), new PVector(-0.05,0), new PVector (50,50)));
  }
}

void draw(){
  //Adjusts speed of the enemies depending on the amount killed
  //Each time 20 enemies are killed speed increases by 1.5 and the timer is reset
  if(speedCounter%20 == 0){
    speed-=1.5;
    speedCounter = 1;
  }
  
  //draws the background
  set.setting();
  //Shows the start screen with any characters
  if(start == true){
    pushMatrix();
    scale(0.5);
    image(narration, 320, 55);
    popMatrix();
    
  }
  //If the game ends, health is 0, the end image shows
  if (replay == false){
    pushMatrix();
    scale(0.5);
    image(end, 320, 55);
    popMatrix(); 
  }
  //In the beggining if you click on this area the game starts
  if(mousePressed&&mouseX<650 && mouseY<715 &&mouseX>450&&mouseY>650){
    start = false;
  }
  //This triggers the rest of the code that starts to the
  if(start==false){
    entireGame();
    gameCount++;
  
    //Achievements
    if(killCount>30){
      pushMatrix();
      scale(0.18);
      image(bronze, 5400,450);
      popMatrix();
    }
    
    if(gameCount>18000){
      pushMatrix();
      scale(0.18);
      image(silver, 4400,450);
      popMatrix();
    }
    if(wheelieCounter > 9 ){
      pushMatrix();
      scale(0.18);
      image(gold, 4900,150);
      popMatrix();
    }
  }
}

//the entire game in a method
void entireGame(){
  //This stuff only works if replay is true, health is not 0
  if(replay!= false){
    //Depending on what kirby is doing, there is a different draw
    //moving = the walking draw
    //standing = standby draw
    //shooting = shoot draw
    
    //Walk methods to move Kirby
    if (up) {
        play.accelerate(upAcc);
        play.drawWalking();
    }
    if (left){
      play.accelerate(leftAcc);
      play.drawWalking();
    }
    if (down){
      play.accelerate(downAcc);
      play.drawWalking();
    }
    if (right){
      play.accelerate(rightAcc);
      play.drawWalking();
    }
    //Standing call
    if (up == false && left == false&&right == false&&down == false && space == false){
        play.drawCharacter();
    }
    //shooting call
    if (space){
      play.shooting();
      play.drawBullet();
    }
    
    play.update();
  }
    
    //loops to get and manipulate the enemies if replay == true
    for(int i = 0; i<basicEnemy.size(); i++){
      Waddle dee = basicEnemy.get(i);
      if (replay!=false){
        dee.update();
      }
    }
    
    wheelieTimer--;
    if(wheelieTimer<0){
      for(int i = 0; i<thirdEnemy.size(); i++){
        Wheelie wheel = thirdEnemy.get(i);
        if (replay!=false){
          wheel.update();
        }
      }
    }
    
    //Loop to move an appl across the screen as a power up
    for(int i = 0; i<appleList.size(); i++){
      Items app = appleList.get(i);
      if(replay != false){
        app.update();
      }
    }
    
}

//checks if keys are pressed or not and resets if it is not pressed
void keyPressed() {
  if (keyCode == ' '){
    space = true;
  }
  if (key == CODED) {
    if (keyCode == UP) up = true;
    if (keyCode == DOWN) down = true;
    if (keyCode == LEFT) left = true;
    if (keyCode == RIGHT) right = true;
  }
}
//To avoid machine gun, if you release the space bar the player will shoot
void keyReleased() {
  if (keyCode == ' '){
    space = false;
    play.fire();
  }
  if (key == CODED) {
    if (keyCode == UP) up = false;
    if (keyCode == DOWN) down = false;
    if (keyCode == LEFT) left = false;
    if (keyCode == RIGHT) right = false;
  }
}
