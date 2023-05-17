public class Game {
  private int playerHealth;
  private int level;
  
  public Game(int playerHealth, int level) {
    this.playerHealth = playerHealth;
    this.level = level;
  }
  
  public void startGame() {
    
  }
}

class Enemy {
  private int enemyHealth;
  private int enemySpeed;
  
  public Enemy(int enemyHealth, int enemySpeed){
    this.enemyHealth = enemyHealth;
    this.enemySpeed = enemySpeed;
  }
  
  public void march(PVector spawnPoint) {
  
  }
}

class Map {
  Tile[][] map = new Tile[10][7];
  
  public Map(Tile[][] map){
    /*for (int row = 0; row < map.length; row++){
      for (int col = 0; col < map[row].length; col++){
        this.map[row][col] = map[row][col];
      } 
    }*/
    this.map = map;
  }
  
  public void drawMap() {
    rectMode(CORNER); 
    
    for (int row = 0; row < map.length; row++){
    for (int col = 0; col < map[row].length; col++){
      map[row][col].drawTile(1+col*map[row][col].getSize(), 1+row*map[row][col].getSize());
    }
  }
  }
}

class Tile {
  private int size;
  private boolean walkable;
  private boolean buildable;
  private PVector position;
  
  public Tile(int size, boolean walkable, boolean buildable){
    this.size = size;
    this.walkable = walkable;
    this.buildable = buildable;
  }
  
  public void drawTile(int x, int y) {
    if (!(walkable || buildable)) 
    fill(#22A91D);
    else if (!walkable && buildable) 
    fill(#239122);
    else if (walkable && !buildable) 
    fill(#C3932C);
    
    rect(x, y, size, size);
    this.position = new PVector(x, y);
  }
  
  public boolean isWalkable(){
    return walkable;
  }
  
  public boolean isBuildable(){
    return buildable;
  }
  
  public int getSize() {
    return size;
  }
  
  public boolean hover()  {
    if (mouseX >= this.position.x && mouseX <= this.position.x+(this.size) && 
      mouseY >= this.position.y && mouseY <= this.position.y+(this.size)) {
      return true;
    } else {
      return false;
    }
  }
}
