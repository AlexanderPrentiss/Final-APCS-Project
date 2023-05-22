PVector s = new PVector(100, 50);
String mode = "mainMenu"; //mainMenu, game, pauseMenu, settingsMenu, buildMenu
String tempMode;

int tempRow;
int tempCol;
int tempSize;
int tempPosX;
int tempPosY;

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
Enemy enemy1 = new Enemy(100, 2, basic);

Button start = new Button(s, "Start", #FFCC00);
Button settings = new Button(s, "Settings", #B5B5B5);
Button quit = new Button(s, "Quit", #FF0000);
Menu mainMenu = new Menu("Tower Defenders 4", #E44523);

Button resume = new Button(s, "Resume", #FFCC00);
Button quitToMenu = new Button(s, "Quit to Menu", #FF0000);
Menu pauseMenu = new Menu("Pause", #E44523);

Button PlayerHealthButton = new Button(s, "Player Health", #FF0000);
Button EnemyHealthButton = new Button(s, "Enemy Health", #FFBD00);
Button EnemySpeedButton = new Button(s, "Enemy Speed", #FFCC00);
Button LevelButton = new Button(s, "Level", #995A00);
Button Back = new Button(s, "Back", #B5B5B5);
Menu settingsMenu = new Menu("Settings", #E44523);

Button ArcherTowerButton = new Button(s, "Archer", #A58200);
Menu buildMenu = new Menu("", #FFFFFF);



void setup() {
  size(720, 500);

  mainMenu.addButton(start);
  mainMenu.addButton(settings);
  mainMenu.addButton(quit);

  pauseMenu.addButton(resume);
  pauseMenu.addButton(settings);
  pauseMenu.addButton(quitToMenu);

  settingsMenu.addButton(PlayerHealthButton);
  settingsMenu.addButton(EnemyHealthButton);
  settingsMenu.addButton(EnemySpeedButton);
  settingsMenu.addButton(LevelButton);
  settingsMenu.addButton(Back);

  buildMenu.addButton(ArcherTowerButton);
  buildMenu.addButton(Back);
  
  
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
    basic.drawMap();
    enemy1.march();
    
  } else if (mode.equals("buildMenu")) {
    basic.drawMap();
    buildMenu.displayMenu();
    if (ArcherTowerButton.hover()) {
      ArcherTowerButton.changeColor(#7C6100);
    } else {
      ArcherTowerButton.changeColor(#A58200);
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
    if (quit.hover()) {
      exit();
    }
  } else if (mode.equals("pauseMenu")) {
    if (resume.hover()) {
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
      // increase level by one until it reaches the cap and then reset to 1
    }
    if (EnemyHealthButton.hover()) {
      // increase level by one until it reaches the cap and then reset to 1
    }
    if (EnemySpeedButton.hover()) {
      // increase level by one until it reaches the cap and then reset to 1
    }
    if (LevelButton.hover()) {
      // increase level by one until it reaches the cap and then reset to 1
    }
    if (Back.hover()) {
      mode = tempMode;
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
