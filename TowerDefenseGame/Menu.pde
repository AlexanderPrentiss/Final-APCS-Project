public class Menu {
  private ArrayList<Button> buttons = new ArrayList<Button>();
  private String title;
  private color mc;
  
  public Menu(String title, color mc){
    this.title = title;
    this.mc = mc;
  }
  
  public void addButton(Button b) {
    buttons.add(b);
  }
  
  public void displayMenu(){
    //textMode(CENTER);
    textAlign(CENTER);
    textSize(72);
    fill(mc);
    text(title, width/2, 75);
    int spacing = (height-200)/buttons.size();
    for (int i = 0; i < buttons.size(); i++) {
      buttons.get(i).displayButton(125+(buttons.get(i).getHeight()/2)+(spacing*i));
    }
  }
}

class Button {
  
  private PVector size;
  private String text;
  private color bc;
  private int position;
  
  public Button(PVector size, String text, color bc) {
    this.size = size;
    this.text = text;
    this.bc = bc;
  }
  
  public void displayButton(int position) {
    rectMode(CENTER);
    textAlign(CENTER);
    fill(bc);
    rect(width/2, position, this.size.x, this.size.y);
    fill(0, 0, 0);
    textSize(this.size.y/3);
    text(this.text, width/2, position+(this.size.y/6));
    noFill();
    this.position = position;
  }
  
  public int getHeight() {
    return (int)this.size.y;
  }
  
  public int getWidth() {
    return (int)this.size.x;
  }
  
  public boolean hover()  {
    if (mouseX >= (width/2)-(this.size.x/2) && mouseX <= (width/2)+(this.size.x/2) && 
      mouseY >= this.position-(this.size.y/2) && mouseY <= this.position+(this.size.y/2)) {
      return true;
    } else {
      return false;
    }
  }
  
  public void changeColor(color n) {
    this.bc = n;
  }
  
  public void changeText(String s) {
    this.text = s;
  }
}
