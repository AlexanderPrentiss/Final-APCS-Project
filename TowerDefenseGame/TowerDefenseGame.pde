PVector s = new PVector(100, 50);
String mode = "menu";

Button start = new Button(s, "Start", #FFCC00);
Button settings = new Button(s, "Settings", #B5B5B5);
Button quit = new Button(s, "Quit", #FF0000);
Menu mainMenu = new Menu("Tower Defenders 4", #E44523);

void setup() {
  size(720, 480);
  mainMenu.addButton(start);
  mainMenu.addButton(settings);
  mainMenu.addButton(quit);
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
  }
}


void mousePressed() {
  if (mode.equals("menu")){
    if (start.hover()) {
      mode = "game";
    }
    if (settings.hover()) {
      //settings.display()
    }
    if (quit.hover()) {
      exit();
    }
  }
}
