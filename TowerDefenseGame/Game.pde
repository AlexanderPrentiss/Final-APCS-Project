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
  private Tile[][] map = new Tile[10][7];
  
  public Map(int[][] bitMap){
    for(int row = 0; row < map.length; row++) {
      for (int col = 0; col < map[row].length; col++) {
        this.map[row][col] = new Tile(width/10, bitMap[row][col]);
      }
    }
  }
  
  public void drawMap() {
    rectMode(CORNER);  
    for(int row = 0; row < map.length; row++) {
      for (int col = 0; col < map[row].length; col++) {
        map[row][col].drawTile(row*(width/10), col*(width/10));
      }
    }
  }
  
  public Tile[][] getTileMap() {
    return this.map;
  }
}

class Tile {
  private int size;
  private boolean walkable;
  private boolean buildable;
  private PVector position;
  private int type;
  
  public Tile(int size, int type){
    this.size = size;
    this.type = type;
    if (type == 1) {
      this.walkable = true;
      this.buildable = false;
    } else if (type == 2) {
      this.walkable = false;
      this.buildable = true;
    } else {
      this.walkable = false;
      this.buildable = false;
    }
  }
  
  public void drawTile(int x, int y) {
    if (!(walkable || buildable || type > 2)) 
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
  
  public int getType() {
    return type;
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

class Tower extends Tile{
  private int towerType;
  private int towerRange;
  private int towerROF;
  private int towerSize;
  
  public Tower(int towerType, int size){
    super(size, towerType);
  }
  
  public void buildTile(int posX, int posY){
    rectMode(CORNER);
    if (this.towerType == 1) {
      fill(#A0A0A0);
      rect(posX, posY, towerSize, towerSize);
    }
  }
}
