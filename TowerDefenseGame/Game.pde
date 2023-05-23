
class Enemy {
  private int enemyHealth;
  private int enemySpeed;
  private int posX;
  private int posY;
  private int i = 0;
  private ArrayList<Tile> path = new ArrayList<Tile>();

  public Enemy(int enemyHealth, int enemySpeed, Map map) {
    this.enemyHealth = enemyHealth;
    this.enemySpeed = enemySpeed;
    for (int col = 0; col < map.getTileMap()[0].length; col++) {
      for (int row = 0; row < map.getTileMap().length; row++) {
        if (map.getTileMap()[row][col].isWalkable()) {
          path.add(map.getTileMap()[row][col]);
        }
      }
    }
    posX = path.get(0).getPosX();
    posY = path.get(0).getPosY() + path.get(0).getSize()/2;
  }

  public void march() {
    fill(255, 0, 0);
    while (posX < path.get(path.size()-1).getPosX() && posY < path.get(path.size()-1).getPosY()) {
     if (posX < path.get(i).getPosX() + path.get(0).getSize()/2) {
        posX+=enemySpeed/2;       
      }
      else if (posY < path.get(i).getPosY() + path.get(0).getSize()/2) {
        posY+=enemySpeed/2;
      }
     else if (i < path.size()-1) {
        i++;
      }  else {
        this.enemySpeed = 0;
        posX = path.get(0).getPosX();
        posY = path.get(0).getPosY() + path.get(0).getSize()/2; 
        playerHealth--;
        i = 0;
      }
      ellipse(posX, posY, path.get(0).getSize()/2, path.get(0).getSize()/2);
    }
  }
  
  public int getPosX() {
    return posY;
  }
  
  public int getPosY() {
    return posX;
  }
}

class Map {
  private Tile[][] map = new Tile[7][10];

  public Map(int[][] bitMap) {
    for (int row = 0; row < map.length; row++) {
      for (int col = 0; col < map[row].length; col++) {
        this.map[row][col] = new Tile(width/10, bitMap[row][col]);
        this.map[row][col].setPos(col*(width/10), row*(width/10));
      }
    }
  }

  public void drawMap() {
    rectMode(CORNER);
    for (int row = 0; row < map.length; row++) {
      for (int col = 0; col < map[row].length; col++) {
        map[row][col].drawTile();
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
  private int posX;
  private int posY;
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

  public void drawTile() {
    if (!(walkable || buildable || type > 2))
      fill(#22A91D);
    else if (!walkable && buildable)
      fill(#239122);
    else if (walkable && !buildable)
      fill(#C3932C);
    rect(posX, posY, size, size);
    //this.position = new PVector(x, y);
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

  public int getType() {
    return type;
  }
  
  public void setPos(int posX, int posY) {
    this.posX = posX;
    this.posY = posY;
  }

  public int getPosX() {
    return posX;
  }

  public int getPosY() {
    return posY;
  }

  public boolean hover() {
    if (mouseX >= this.posX && mouseX <= this.posX+(this.size) &&
      mouseY >= this.posY && mouseY <= this.posY+(this.size)) {
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

  public void drawTile() {
    rectMode(CORNER);
    int Tsize = this.getSize();
    int posX = this.getPosX();
    int posY = this.getPosY();
    //int Tsize = width/10;
    if (this.getType() == 3) {
      fill(#B5B5B5);
      rect(posX, posY, Tsize, Tsize);
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
    this.setPos(posX, posY);
  }

  public int getRange() {
    return this.towerRange;
  }
}
