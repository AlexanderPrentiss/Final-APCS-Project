PVector s = new PVector(125, 50);
String mode = "mainMenu"; //mainMenu, game, pauseMenu, settingsMenu, buildMenu
String tempMode;
int playerHealth = 20;
int enemySpeed = 4;
int enemyHealth = 10;

int tempRow;
int tempCol;
int tempSize;
int tempPosX;
int tempPosY;
int i = 0;

int width = 720;
int height = 500;

int t = width/10;

int[][] basicBitMap = {
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {2, 2, 2, 2, 2, 2, 0, 0, 0, 0},
  {1, 1, 1, 1, 1, 2, 0, 0, 0, 0},
  {2, 2, 2, 2, 1, 2, 2, 2, 2, 2},
  {0, 0, 0, 2, 1, 1, 1, 1, 1, 1},
  {0, 0, 0, 2, 2, 2, 2, 2, 2, 2}
};

Map basic = new Map(basicBitMap);
Enemy enemy1 = new Enemy(10, 1, basic);

Button start = new Button(s, "Start", #FFCC00);
Button settings = new Button(s, "Settings", #B5B5B5);
Button quit = new Button(s, "Quit", #FF0000);
Menu mainMenu = new Menu("Tower Defenders 4", #E44523);

Button resume = new Button(s, "Resume", #FFCC00);
Button nextWave = new Button(s, "Next Wave", #FFCC00);
Button quitToMenu = new Button(s, "Quit to Menu", #FF0000);
Menu pauseMenu = new Menu("Pause", #E44523);

Button PlayerHealthButton = new Button(s, "Player Health: " + playerHealth, #FF0000);
Button EnemyHealthButton = new Button(s, "Enemy Health: "+ enemyHealth, #FFBD00);
Button EnemySpeedButton = new Button(s, "Enemy Speed: " + enemySpeed, #FFCC00);
Button LevelButton = new Button(s, "Level" + ": basic", #995A00);
Button Back = new Button(s, "Back", #B5B5B5);
Menu settingsMenu = new Menu("Settings", #E44523);

Button ArcherTowerButton = new Button(s, "Archer", #A58200);
Button WizardTowerButton = new Button(s, "Wizard", #0099FF);
Menu buildMenu = new Menu("", #FFFFFF);

Enemy[] wave = new Enemy[11];

void setup() {
  size(720, 500);

  mainMenu.addButton(start);
  mainMenu.addButton(settings);
  mainMenu.addButton(quit);

  pauseMenu.addButton(resume);
  pauseMenu.addButton(nextWave);
  pauseMenu.addButton(settings);
  pauseMenu.addButton(quitToMenu);

  settingsMenu.addButton(PlayerHealthButton);
  settingsMenu.addButton(EnemyHealthButton);
  settingsMenu.addButton(EnemySpeedButton);
  settingsMenu.addButton(LevelButton);
  settingsMenu.addButton(Back);

  buildMenu.addButton(ArcherTowerButton);
  buildMenu.addButton(WizardTowerButton);
  buildMenu.addButton(Back);
  
  for (int i = 0; i < wave.length; i++) {
    wave[i] = new Enemy(enemyHealth, enemySpeed, basic);
  }
  
  wave[0].destroyEnemy();
  
}

void draw() {
  background(#C1C1C1);

  if (mode.equals("mainMenu")) {
    mainMenu.displayMenu();
    if (start.hover()) {
      start.changeColor(#D0AC1B);
    } else {
      start.changeColor(#FFCC00);
    }
    if (settings.hover()) {
      settings.changeColor(#919191);
    } else {
      settings.changeColor(#B5B5B5);
    }
    if (quit.hover()) {
      quit.changeColor(#AC0000);
    } else {
      quit.changeColor(#FF0000);
    }
  } else if (mode.equals("game")) {
    textAlign(CENTER);
    textSize(36);
    basic.drawMap();
    for (int j = 1; j < wave.length; j++) {
      if (i > j*75) {
        wave[j].march();
      }
    }
    for (int row = 0; row < basic.getTileMap().length; row++) {
      for (int col = 0; col < basic.getTileMap()[row].length; col++) {
        if (basic.getTileMap()[row][col] instanceof Tower && i % ((Tower)basic.getTileMap()[row][col]).getROF() == 0) {
          ((Tower)basic.getTileMap()[row][col]).findTarget(wave);
        }
      } 
    }
    fill(#ffffff);
    text(playerHealth, 19*width/20, height/10);
        i++;
  } else if (mode.equals("buildMenu")) {
    basic.drawMap();
    buildMenu.displayMenu();
    if (ArcherTowerButton.hover()) {
      ArcherTowerButton.changeColor(#7C6100);
    } else {
      ArcherTowerButton.changeColor(#A58200);
    }
    if (WizardTowerButton.hover()) {
      WizardTowerButton.changeColor(#0033CC);
    } else {
      WizardTowerButton.changeColor(#0099FF);
    }
    if (Back.hover()) {
      Back.changeColor(#AC0000);
    } else {
      Back.changeColor(#FF0000);
    }
  } else if (mode.equals("pauseMenu")) {
    pauseMenu.displayMenu();
    if (resume.hover()) {
      resume.changeColor(#D0AC1B);
    } else {
      resume.changeColor(#FFCC00);
    }
    if (nextWave.hover()) {
      nextWave.changeColor(#32CD00);
    } else {
      nextWave.changeColor(#3EFF00);
    }
    if (settings.hover()) {
      settings.changeColor(#919191);
    } else {
      settings.changeColor(#B5B5B5);
    }
    if (quitToMenu.hover()) {

      if (quitToMenu.hover()) {

        quitToMenu.changeColor(#AC0000);
      } else {
        quitToMenu.changeColor(#FF0000);
      }
    }
  } else if (mode.equals("settingsMenu")) {
    settingsMenu.displayMenu();
    if (PlayerHealthButton.hover()) {
      PlayerHealthButton.changeColor(#32CD00);
    } else {
      PlayerHealthButton.changeColor(#3EFF00);
    }
    if (EnemyHealthButton.hover()) {
      EnemyHealthButton.changeColor(#CF7700);
    } else {
      EnemyHealthButton.changeColor(#FF9300);
    }
    if (EnemySpeedButton.hover()) {
      EnemySpeedButton.changeColor(#BAC000);
    } else {
      EnemySpeedButton.changeColor(#F7FF00);
    }
    if (LevelButton.hover()) {
      LevelButton.changeColor(#643B00);
    } else {
      LevelButton.changeColor(#995A00);
    }
    if (Back.hover()) {
      Back.changeColor(#AC0000);
    } else {
      Back.changeColor(#FF0000);
    }
  } else if (mode.equals("GameOver")) {
    delay(4000);
    exit();
  }
  if (playerHealth == 0) {
    background(#C1C1C1);
    textAlign(CENTER);
    textSize(72);
    fill(#FF0000);
    text("You Lose", width/2, height/2);
    mode = "GameOver";
  }
}


void mousePressed() {
  if (mode.equals("game")) {
    for (int row = 0; row < basic.getTileMap().length; row++) {
      for (int col = 0; col < basic.getTileMap()[row].length; col++) {
        if (basic.getTileMap()[row][col].hover() && basic.getTileMap()[row][col].getType() == 2) {
          tempRow = row;
          tempCol = col;
          mode = "buildMenu";
        } 
      }
    }
  } else if (mode.equals("mainMenu")) {
    if (start.hover()) {
      mode = "game";
    }
    if (settings.hover()) {
      tempMode = mode;
      mode = "settingsMenu";
    }
    if (quit.hover()) {
      exit();
    }
  } else if (mode.equals("buildMenu")) {
    if (Back.hover()) {
      mode = "game";
    }
    if (ArcherTowerButton.hover()) {
      tempSize = basic.getTileMap()[tempRow][tempCol].getSize();
      tempPosX = basic.getTileMap()[tempRow][tempCol].getPosX();
      tempPosY = basic.getTileMap()[tempRow][tempCol].getPosY();
      basic.getTileMap()[tempRow][tempCol] = new Tower(3, tempSize);
      basic.getTileMap()[tempRow][tempCol].setPos(tempPosX, tempPosY);
      mode = "game";
    }
    if (WizardTowerButton.hover()) {
      tempSize = basic.getTileMap()[tempRow][tempCol].getSize();
      tempPosX = basic.getTileMap()[tempRow][tempCol].getPosX();
      tempPosY = basic.getTileMap()[tempRow][tempCol].getPosY();
      basic.getTileMap()[tempRow][tempCol] = new Tower(4, tempSize);
      basic.getTileMap()[tempRow][tempCol].setPos(tempPosX, tempPosY);
      mode = "game";
    }
    if (Back.hover()) {
      mode = "game";
    }
  } else if (mode.equals("pauseMenu")) {
    if (resume.hover()) {
      mode = "game";
    }
    if (nextWave.hover()) {
      i = 0;
      for (int i = 1; i < wave.length; i++) {
        wave[i].setPosX(wave[i].getStartingPosX());
        wave[i].setPosY(wave[i].getStartingPosY());
        wave[i].reset();
      }
      mode = "game";
    }
    if (settings.hover()) {
      tempMode = mode;
      mode = "settingsMenu";
    }
    if (quitToMenu.hover()) {
      mode = "mainMenu";
    }
  } else if (mode.equals("settingsMenu")) {
    if (PlayerHealthButton.hover()) {
      playerHealth++;
      if (playerHealth > 30) {
        playerHealth = 10;
      }
      PlayerHealthButton.changeText("Player Health: " + playerHealth);
    }
    if (EnemyHealthButton.hover()) {
      enemyHealth++;
      if (enemyHealth > 20) {
        enemyHealth = 1;
      }
      EnemyHealthButton.changeText("Enemy Health: "+ enemyHealth);
    }
    if (EnemySpeedButton.hover()) {
      enemySpeed++;
      if (enemySpeed > 20) {
        enemySpeed = 2;
      }
      EnemySpeedButton.changeText("Enemy Speed: " + enemySpeed);
    }
    if (LevelButton.hover()) {
      // increase level by one until it reaches the cap and then reset to 1
    }
    if (Back.hover()) {
      mode = tempMode;
    }
    for (int j = 1; j < wave.length; j++) {
      wave[j].settingsUpdate(enemySpeed, enemyHealth);
    }
  }
}


void keyPressed() {
  if (mode.equals("game")) {
    if (keyCode == ESC) {
      key = 0;
      mode = "pauseMenu";
    }
  }
}
