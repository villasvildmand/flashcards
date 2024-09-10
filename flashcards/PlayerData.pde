class PlayerData {
  String name;
  int gameLevel;
  
  void loadFromFile() {
    JSONObject player = loadJSONObject("data/user/save_data.json");
    
    this.gameLevel = player.getInt("gameLevel");
    this.name = player.getString("name");
  }
  
  void saveToFile() {
    JSONObject json = new JSONObject();
    
    json.setInt("level", gameLevel);
    json.setString("name", name);
    
    saveJSONObject(json, "data/user/save_data.json");
  }
}
