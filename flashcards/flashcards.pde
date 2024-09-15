CardsService cardsService;
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

void setup() {
  size(1200, 900);
  smooth(8);

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
}
