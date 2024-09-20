CardsService cardsService;
ParticleSystem particleSystem;
PlayerData playerData;
State state;

long lastTime;

PFont fontRegular;
PFont fontMedium;
PFont fontSemiBold;
PFont fontBold;

final color COLOR_BACKGROUND = color(0);
final color COLOR_PRIMARY = #FFC41F;
final color COLOR_SECONDARY = color(128);
final color COLOR_TERTIARY = color(32);

PImage IMAGES_STAR;
PImage IMAGES_ICON_ONE;
PImage IMAGES_ICON_ZERO;
PImage IMAGES_ICON_RHOMBUS;
PImage IMAGES_ICON_CURLY_BRACES;
PImage IMAGES_ICON_AMPERSAND;

void setup() {
  size(1200, 900);
  smooth(8);

  particleSystem = new ParticleSystem();

  cardsService = new CardsService();
  cardsService.loadCards();
  
  playerData = new PlayerData();
  playerData.loadFromFile();

  state = new MenuState();

  registerMethod("keyEvent", this);
  registerMethod("mouseEvent", this);

  fontRegular = createFont("data/assets/fonts/SUSE-Regular.ttf", 24.0);
  fontMedium = createFont("data/assets/fonts/SUSE-Medium.ttf", 24.0);
  fontSemiBold = createFont("data/assets/fonts/SUSE-SemiBold.ttf", 24.0);
  fontBold = createFont("data/assets/fonts/SUSE-Bold.ttf", 24.0);
  textFont(fontRegular);
  
  IMAGES_STAR = loadImage("data/assets/textures/star.png");
  IMAGES_ICON_ONE = loadImage("data/assets/textures/icon_1.png");
  IMAGES_ICON_ZERO = loadImage("data/assets/textures/icon_0.png");
  IMAGES_ICON_RHOMBUS = loadImage("data/assets/textures/icon_rhombus.png");
  IMAGES_ICON_CURLY_BRACES = loadImage("data/assets/textures/icon_curly_braces.png");
  IMAGES_ICON_AMPERSAND = loadImage("data/assets/textures/icon_ampersand.png");

  windowResizable(true);

  lastTime = System.nanoTime();
}

void keyEvent(KeyEvent event) {
  state.handleKeyEvent(event);
}

void mouseEvent(MouseEvent event) {
  state.handleMouseEvent(event);
}

// deltaTime med hjælp fra:
// https://gamedev.stackexchange.com/questions/111741/calculating-delta-time

void draw() {
  long time = System.nanoTime();
  double deltaTime = (time - lastTime) / 1_000_000_000.0f; // StackOverflow spørgsmålet bruger int, men double er valgt da decimaler og præcision ønskes
  lastTime = time;

  state.update(deltaTime);
  state.render();
  
  push();
  // debug
  fill(COLOR_SECONDARY);
  textFont(fontRegular);
  textSize(14);
  textAlign(LEFT, BOTTOM);
  
  text("FPS: " + frameRate, 20, height - 40);
  float frameTime = (float) deltaTime * 1000.0;
  text("deltaTime: " + frameTime + " ms", 20, height - 20);
  pop();
}
