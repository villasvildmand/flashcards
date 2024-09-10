// Alle flashcards i en usorteret liste
Flashcard[] flashcards;

// Alle flashcards sorteret efter kategorier
HashMap<String, ArrayList<Integer>> categories;

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
  size(600, 450);
  smooth(8);

  categories = new HashMap<>();

  loadCards();

  state = new MenuState();

  registerMethod("keyEvent", this);
  registerMethod("mouseEvent", this);

  fontRegular = createFont("data/assets/fonts/SUSE-Regular.ttf", 24.0);
  fontMedium = createFont("data/assets/fonts/SUSE-Medium.ttf", 24.0);
  fontSemiBold = createFont("data/assets/fonts/SUSE-SemiBold.ttf", 24.0);
  fontBold = createFont("data/assets/fonts/SUSE-Bold.ttf", 24.0);
  textFont(fontRegular);

  windowResizable(true);

  playerData = new PlayerData();
  playerData.loadFromFile();

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

// TODO - ryk nedenstående funktioner til en klasse(?)

void loadCards() {
  JSONObject json = loadJSONObject("data/cards.json");

  StringList tags = json.getStringList("tags");
  for (int i = 0; i < tags.size(); i++) {
    String tag = tags.get(i);
    categories.put(tag, new ArrayList<Integer>());
  }
  categories.put("Ikke sorteret", new ArrayList<Integer>());

  JSONArray cards = json.getJSONArray("cards");

  flashcards = new Flashcard[cards.size()];

  for (int i = 0; i < cards.size(); i++) {
    JSONObject card = cards.getJSONObject(i);

    String front = card.getString("front");
    String back = card.getString("back");

    String tag = card.getString("tag");

    if (categories.containsKey(tag)) {
      categories.get(tag).add(i);
    } else {
      if (!tag.equals("")) println("Unsorted tag: " + tag);
      categories.get("Ikke sorteret").add(i);
    }

    int level = card.getInt("level");

    flashcards[i] = new Flashcard(front, back, level);
  }

  for (Flashcard flashcard : flashcards) {
    println(flashcard.front);
  }
  println(categories);
}
