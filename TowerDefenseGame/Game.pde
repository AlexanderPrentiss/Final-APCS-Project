
class Enemy {
  private int enemyHealth;
  private int enemySpeed;
  private int posX;
  private int posY;
  private int startingPosX;
  private int startingHealth;
  private int startingPosY;
  private int startingSpeed;
  private int i;
  private int r;
  private int g;
  private int b;
  private ArrayList<Tile> path = new ArrayList<Tile>();

  public Enemy(int enemyHealth, int enemySpeed, Map map) {
    this.enemyHealth = enemyHealth;
    this.enemySpeed = enemySpeed;
    this.startingSpeed = enemySpeed;
    this.startingHealth = enemyHealth;
    this.r = 0;
    this.g = 255;
    this.b = 0;
    for (int col = 0; col < map.getTileMap()[0].length; col++) {
      for (int row = 0; row < map.getTileMap().length; row++) {
        if (map.getTileMap()[row][col].isWalkable()) {
          path.add(map.getTileMap()[row][col]);
        }
      }
    }
    posX = path.get(0).getPosX();
    posY = path.get(0).getPosY() + path.get(0).getSize()/2;
    startingPosX = posX;
    startingPosY = posY;
    i = 0;
  }

  public void march() {
    fill(r,g,b);
      println(posX);
     if (this.posX < this.path.get(i).getPosX() + this.path.get(0).getSize()/2) {
        this.posX+=enemySpeed/2;
        ellipse(this.posX, this.posY, this.path.get(0).getSize()/2, this.path.get(0).getSize()/2);
     } else if (this.posY < this.path.get(i).getPosY() + this.path.get(0).getSize()/2) {
        this.posY+=enemySpeed/2;
        ellipse(this.posX, this.posY, this.path.get(0).getSize()/2, this.path.get(0).getSize()/2);
     } else if (i < path.size()-1) {
        i++;
        ellipse(this.posX, this.posY, this.path.get(0).getSize()/2, this.path.get(0).getSize()/2);
     }  else {
       if (this.posX > this.path.get(path.size()-1).getPosX()-10){
          playerHealth--;
        }
        this.destroyEnemy();
        return;       
      }
    }
    
  public void destroyEnemy(){
    enemySpeed = 0;
    posX = -1000;
    posY = -1000;
  }
  
  public void damageEnemy(int damage){
    enemyHealth-=damage;
    this.r = (int)(255-255*((double)enemyHealth/startingHealth));
    this.g = (int)(255*((double)enemyHealth/startingHealth));
    if (enemyHealth <= 0) {
      this.destroyEnemy();
    }
  }
  
  public int getPosX() {
    return posX;
  }
  
  public int getPosY() {
    return posY;
  }
  
  public int getStartingPosX() {
    return startingPosX;
  }
  
  public int getStartingPosY() {
    return startingPosY;
  }
  
  public void setPosX(int x){
    this.posX = x;
  }
  
  public void setPosY(int y){
    this.posY = y;
  }
  
  public void reset() {
    this.i = 0;
    this.enemySpeed = this.startingSpeed;
    this.enemyHealth = this.startingHealth;
    this.r = 0;
    this.g = 255;
  }
  
  public void settingsUpdate(int speed, int health){
    this.startingHealth = health;
    this.startingSpeed = speed;
    this.enemyHealth = health;
    this.enemySpeed = speed;
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
  private int towerDamage;
  private int towerROF;

  public Tower(int towerType, int size) {
    super(size, towerType);
    if (towerType == 3) {
      this.towerRange = 3;
      this.towerROF = 12;
      this.towerDamage = 2;
    } else if (towerType == 4) {
      this.towerRange = 2;
      this.towerROF = 18;
      this.towerDamage = 5;
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
    } else if (this.getType() == 4) {
      fill(#B5B5B5);
      rect(posX, posY, Tsize, Tsize);
      noStroke();
      fill(#00FF00);
      rect(posX+Tsize*1/8, posY+Tsize*1/8, Tsize*3/4, Tsize*3/4);
      stroke(0);
    }
    this.setPos(posX, posY);
  }

  public int getRange() {
    return this.towerRange;
  }
  
  public int getROF() {
    return this.towerROF*10;
  }
  
  public void findTarget(Enemy[] enemy) {
    for (int i = 0; i < enemy.length; i++) {
      if ((enemy[i].getPosX() > this.getPosX()+(this.getSize()/2)-(this.towerRange*this.getSize()) && enemy[i].getPosX() < this.getPosX()+(this.getSize()/2)+(this.towerRange*this.getSize())) && 
      (enemy[i].getPosY() > this.getPosY()+(this.getSize()/2)-(this.towerRange*this.getSize()) && enemy[i].getPosY() < this.getPosY()+(this.getSize()/2)+(this.towerRange*this.getSize()))) {
        if (this.getType() == 3) {
          fill(#FFFFFF);
        } else if (this.getType() == 4) {
          fill(#0000FF);
        }     
        line(this.getPosX()+(this.getSize()/2), this.getPosY()+(this.getSize()/2), enemy[i].getPosX(), enemy[i].getPosY());
        enemy[i].damageEnemy(this.towerDamage);  
        break;
      }
    }
  }
}
