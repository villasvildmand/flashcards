class ItemGrid {
  int itemCount;
  float maxWidth;
  float iX, iY;
  int maxItemsX;
  String name;
  
  ItemGrid(String name) {
    this.name = name;
  }
  
  void setItemSize(float x, float y) {
    this.iX = x;
    this.iY = y;
  }
  
  void setMaxWidth(float w) {
    this.maxWidth = w;
    this.maxItemsX = floor(w / iX);
  }
  
  void setItemCount(int count) {
    this.itemCount = count;
  }
  
  float getHeight() {
    return (this.itemCount / this.maxItemsX + 1) * this.iY;
  }
  
  PVector getItemPosition(int index) {
    float x = index % this.maxItemsX * this.iX;
    float y = index / this.maxItemsX * this.iY;
    return new PVector(x, y);
  }
}
