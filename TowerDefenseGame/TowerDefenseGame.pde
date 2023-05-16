PVector s = new PVector(100, 50);
String mode = "menu"; //menu, game, game_pause, settings
String temp = "menu";

Button start = new Button(s, "Start", #FFCC00);
Button settings = new Button(s, "Settings", #B5B5B5);
Button quit = new Button(s, "Quit", #FF0000);
Menu mainMenu = new Menu("Tower Defenders 4", #E44523);

Button resume = new Button(s, "Resume", #00FF3A);
Button quitToMenu = new Button(s, "Quit to Menu", #FF0000);
Menu gameMenu = new Menu("Pause", #B5B5B5);

Button EnemySpeed = new Button(s, "Enemy Speed", #21EF00);
Button EnemyHealth = new Button(s, "Enemy Health", #FF75FB);
Button PlayerHealth = new Button(s, "Player Health", #FF6F6F);
Button Back = new Button(s, "Back", #CACACA);
Menu settingsMenu = new Menu("Settings", #3E3E3E);


void setup() {
  size(720, 480);
  mainMenu.addButton(start);
  mainMenu.addButton(settings);
  mainMenu.addButton(quit);
  
  gameMenu.addButton(resume);
  gameMenu.addButton(settings);
  gameMenu.addButton(quitToMenu);
  
  settingsMenu.addButton(PlayerHealth);
  settingsMenu.addButton(EnemyHealth);
  settingsMenu.addButton(EnemySpeed);
  settingsMenu.addButton(Back);
}

void draw() {
  background(#C1C1C1);
  
  
  if (mode.equals("menu")){
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
  


  } else if (mode.equals("game")) {
    rect(width/2, height/2, 100, 100);
  



  } else if (mode.equals("game_pause")) {
    gameMenu.displayMenu();
    if (resume.hover()) {
      resume.changeColor(#00A525);
    } else {
      resume.changeColor(#00FF3A);
    }
    if (settings.hover()) {
      settings.changeColor(#919191);
    } else {
      settings.changeColor(#B5B5B5);
    }
    if (quitToMenu.hover()) {
      quitToMenu.changeColor(#AC0000);
    } else {
      quitToMenu.changeColor(#FF0000);
    }
  


  } else if (mode.equals("settings")) {
    settingsMenu.displayMenu();
    if (PlayerHealth.hover()) {
      PlayerHealth.changeColor(#D45E5E);
    } else {
      PlayerHealth.changeColor(#FF6F6F);
    }
    if (EnemyHealth.hover()) {
      EnemyHealth.changeColor(#C55CC2);
    } else {
      EnemyHealth.changeColor(#FF75FB);
    }
    if (EnemySpeed.hover()) {
      EnemySpeed.changeColor(#19B400);
    } else {
      EnemySpeed.changeColor(#21EF00);
    }
    if (Back.hover()) {
      Back.changeColor(#A9A9A9);
    } else {
      Back.changeColor(#CACACA);
    }
  }
}


void mousePressed() {
  if (mode.equals("menu")){
    if (start.hover()) {
      mode = "game";
    }
    if (settings.hover()) {
      temp = mode;
      mode = "settings";
    }
    if (quit.hover()) {
      exit();
    }
  }  else if (mode.equals("game_pause")) {
    if (resume.hover()) {
      mode = "game";
    }
    if (settings.hover()) {
      temp = mode;
      mode = "settings";
    }
    if (quitToMenu.hover()) {
      mode = "menu";
    }
  } else if (mode.equals("settings")) {
    if (PlayerHealth.hover()) {
      /* PlayerHP++;
      if (PlayerHP > 20) PlayerHP = 1;*/
    }
    if (EnemyHealth.hover()) {
      /*EnemyHP++;
      if (EnemyHP > 10) EnemyHP = 1;*/
    }
    if (EnemySpeed.hover()) {
      /*EnemySwift++;
      if (EnemySwift > 5) EnemySwift = 1;*/
    }
    if (Back.hover()) {
      mode = temp;
    }
  }
}

void keyPressed() {
  if (mode.equals("game")) {
    if (keyCode == ESC) {
      key = 0;
      mode = "game_pause";
    }
  }
}
