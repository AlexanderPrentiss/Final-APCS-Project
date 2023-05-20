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
  private int posX;
  private int posY;
  private ArrayList<Tile> path = new ArrayList<Tile>();

  public Enemy(int enemyHealth, int enemySpeed) {
    this.enemyHealth = enemyHealth;
    this.enemySpeed = enemySpeed;
  }

  public void march(Map map) {
    fill(255, 0, 0);
    for (int col = 0; col < map.getTileMap()[0].length; col++) {
      for (int row = 0; row < map.getTileMap().length; row++) {
        if (map.getTileMap()[row][col].isWalkable()) {
          path.add(map.getTileMap()[row][col]);
        }
      }
    }
    posX = path.get(0).getPosX();
    posY = path.get(0).getPosY() + path.get(0).getSize()/2;   
    for (int i = 0; i < path.size(); i++) {
      while (posX < path.get(i).getPosX() + path.get(0).getSize()/2) {
        ellipse(posX, posY, path.get(0).getSize()/2, path.get(0).getSize()/2);
        posX+=(10*enemySpeed);
        basic.drawMap();
      }
    }
  }
}

class Map {
  private Tile[][] map = new Tile[7][10];

  public Map(int[][] bitMap) {
    for (int row = 0; row < map.length; row++) {
      for (int col = 0; col < map[row].length; col++) {
        this.map[row][col] = new Tile(width/10, bitMap[row][col]);
      }
    }
  }

  public void drawMap() {
    rectMode(CORNER);
    for (int row = 0; row < map.length; row++) {
      for (int col = 0; col < map[row].length; col++) {
        map[row][col].drawTile(col*(width/10), row*(width/10));
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

  public Tile(int size, int type) {
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

  public boolean isWalkable() {
    return walkable;
  }

  public boolean isBuildable() {
    return buildable;
  }

  public int getSize() {
    return size;
  }
  
  public void setPosition(PVector position) {
    this.position = (position);
  }

  public int getType() {
    return type;
  }

  public int getPosX() {
    return (int)position.x;
  }

  public int getPosY() {
    return (int)position.y;
  }

  public boolean hover() {
    if (mouseX >= this.position.x && mouseX <= this.position.x+(this.size) &&
      mouseY >= this.position.y && mouseY <= this.position.y+(this.size)) {
      return true;
    } else {
      return false;
    }
  }
}

class Tower extends Tile {
  private int towerRange;
  private int towerROF;

  public Tower(int towerType, int size) {
    super(size, towerType);
    if (towerType == 3) {
      this.towerRange = 3; 
      this.towerROF = 2;
    }
  }

  public void drawTile(int posX, int posY) {
    rectMode(CORNER);
    int Tsize = this.getSize();
    //int Tsize = width/10;
    if (this.getType() == 3) {
      fill(#B5B5B5);
      rect(posX, posY,Tsize, Tsize);
      noStroke();
      fill(#686868);
      rect(posX, posY, Tsize/10, Tsize/5);
      rect(posX, posY, Tsize/5, Tsize/10);
      rect(posX+(Tsize/2)-Tsize/10, posY, Tsize/5, Tsize/10);
      rect(posX+(Tsize/2)-Tsize/10, posY+Tsize-Tsize/10, Tsize/5, Tsize/10);
      rect(posX, posY+(Tsize/2)-Tsize/10, Tsize/10, Tsize/5);
      rect(posX+Tsize-Tsize/10, posY+(Tsize/2)-Tsize/10, Tsize/10, Tsize/5);
      rect(posX+Tsize-Tsize/5, posY, Tsize/5, Tsize/10);
      rect(posX+Tsize-Tsize/10, posY, Tsize/10, Tsize/5);
      
      rect(posX, posY+Tsize-Tsize/5, Tsize/10, Tsize/5);
      rect(posX, posY+Tsize-Tsize/10, Tsize/5, Tsize/10);
      rect(posX+Tsize-Tsize/5, posY+Tsize-Tsize/10, Tsize/5, Tsize/10);
      rect(posX+Tsize-Tsize/10, posY+Tsize-Tsize/5, Tsize/10, Tsize/5);
      stroke(0);
    }
    PVector position = new PVector(posX, posY);
    this.setPosition(position);
  }
  
  public int getRange() {
    return this.towerRange;
  }
}
