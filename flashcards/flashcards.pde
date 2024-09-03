Flashcard[] flashcards;
HashMap<String, ArrayList<Integer>> categories;

// Brugerdata - måske lav til en klasse?
String userName = "Christian";
int userLevel = 1;

State state;
long lastTime;

void setup() {
  size(600, 450);
  smooth(8);

  categories = new HashMap<>();

  loadCards();
  saveUserData();

  state = new MenuState();

  registerMethod("keyEvent", this);
  registerMethod("mouseEvent", this);

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

    flashcards[i] = new Flashcard(front, back);
  }

  for (Flashcard flashcard : flashcards) {
    println(flashcard.front);
  }
  println(categories);
}

void saveUserData() {
  JSONObject json = new JSONObject();
  json.setString("name", userName);
  json.setInt("level", userLevel);

  saveJSONObject(json, "data/user/save_data.json");
}
