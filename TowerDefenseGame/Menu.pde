public class Menu {
  private Button[] buttons = new Button[3];
  private int num = 0;
  
  void addButton(Button b) {
    if (num > 2) num = 0;
    buttons[num] = b;
    num++;
  }
  
  void displayMenu(){
    
  }
}

class Button {
  
  private PVector size;
  private String text;
  private color c;
  
  public Button(PVector size, String text, color c) {
    this.size = size;
    this.text = text;
    this.c = c;
  }
  
  void displayButton() {
  
  }
}
