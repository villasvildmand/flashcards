class CardsService {
  // Alle flashcards i en usorteret liste
  Flashcard[] flashcards;

  // Alle flashcards sorteret efter kategorier
  HashMap<String, ArrayList<Integer>> categories;

  int[][] levels;
  int maxLevel;

  CardsService() {
    categories = new HashMap<>();
    levels = new int[5][0];
  }

  int[] getCardsAtLevel(int level) {
    return levels[level];
  }

  int[] getCardsBelowLevel(int level) {
    int[] cards = new int[]{};

    for (int i = level - 1; i >= 0; i--) {
      cards = concat(cards, levels[i]);
    }

    return cards;
  }

  Flashcard getCard(int id) {
    return flashcards[id];
  }

  int getMaxLevel() {
    return levels.length - 1;//this.maxLevel;
  }

  int getCardsCount() {
    return flashcards.length;
  }

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

      this.maxLevel = max(level, this.maxLevel);

      // Tilføjer kortets index til arrayen for dens level
      levels[level] = append(levels[level], i);

      flashcards[i] = new Flashcard(front, back, level);
    }

    for (Flashcard flashcard : flashcards) {
      println(flashcard.front);
    }

    println(categories);
    for (int i = 0; i < levels.length; i++) {
      println("level", levels[i].length);
    }
  }
}
