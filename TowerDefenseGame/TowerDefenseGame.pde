PVector s = new PVector(100, 50);
String mode = "mainMenu"; //mainMenu, game, pauseMenu, settingsMenu
String tempMode;

int t = width/10;
Tile path = new Tile(t, true, false);
Tile grass = new Tile(t, false, false);
Tile build = new Tile(t, false, true);

Tile[][] basicTiles = {{grass, grass, grass, grass, grass, grass, grass, grass, grass, grass},
                      {grass, grass, grass, grass, grass, grass, grass, grass, grass, grass},
                      {grass, grass, grass, grass, grass, grass, grass, grass, grass, grass},
                      {grass, grass, grass, grass, grass, grass, grass, grass, grass, grass},
                      {grass, grass, grass, grass, grass, grass, grass, grass, grass, grass},
                      {grass, grass, grass, grass, grass, grass, grass, grass, grass, grass},
                      {grass, grass, grass, grass, grass, grass, grass, grass, grass, grass}};

Map basic = new Map(basicTiles);

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
}

void draw() {
  background(#C1C1C1);
  
  
  if (mode.equals("mainMenu")){
    mainMenu.displayMenu();
    if (start.hover()){
      start.changeColor(#D0AC1B);
    } else {
      start.changeColor(#FFCC00);
    }
    if (settings.hover()){
      settings.changeColor(#919191);
    } else {
      settings.changeColor(#B5B5B5);
    }
    if (quit.hover()){
      quit.changeColor(#AC0000);
    } else {
      quit.changeColor(#FF0000);
    }
  } 
  
  
  
  else if (mode.equals("game")) {
    basic.drawMap();
  } 
  
  
  
  
  else if (mode.equals("pauseMenu")) {
    pauseMenu.displayMenu();
    if (resume.hover()){
      resume.changeColor(#D0AC1B);
    } else {
      resume.changeColor(#FFCC00);
    }
    if (settings.hover()){
      settings.changeColor(#919191);
    } else {
      settings.changeColor(#B5B5B5);
    }
    if (quitToMenu.hover()){
      quitToMenu.changeColor(#AC0000);
    } else {
      quitToMenu.changeColor(#FF0000);
    }
  } 
  
  
  
  else if (mode.equals("settingsMenu")) {
    settingsMenu.displayMenu();
    if (PlayerHealthButton.hover()){
      PlayerHealthButton.changeColor(#32CD00);
    } else {
      PlayerHealthButton.changeColor(#3EFF00);
    }
    if (EnemyHealthButton.hover()){
      EnemyHealthButton.changeColor(#CF7700);
    } else {
      EnemyHealthButton.changeColor(#FF9300);
    }
    if (EnemySpeedButton.hover()){
      EnemySpeedButton.changeColor(#BAC000);
    } else {
      EnemySpeedButton.changeColor(#F7FF00);
    }
    if (LevelButton.hover()){
      LevelButton.changeColor(#643B00);
    } else {
      LevelButton.changeColor(#995A00);
    }
    if (Back.hover()){
      Back.changeColor(#AC0000);
    } else {
      Back.changeColor(#FF0000);
    }
  }
  
}


void mousePressed() {
  if (mode.equals("mainMenu")){
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
  }
  
  
  
  else if (mode.equals("pauseMenu")){
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
  }
  
  
  
  
  else if (mode.equals("settingsMenu")){
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
  if (mode.equals("game")){
    if (keyCode == ESC) {
      key = 0;
      mode = "pauseMenu";
    }
  }
}
