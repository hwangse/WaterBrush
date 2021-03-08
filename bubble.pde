class bubble{
  float x_pos, y_pos;
  float radius;
  int count;
  
  bubble(float _x, float _y, float _rad, int _count) {
    x_pos = _x;
    y_pos = _y;
    radius = _rad;
    count = _count;
  }
  
  void display() {
    noStroke();
    ellipse(x_pos, y_pos, radius, radius);
    
    int alpha = 30 - int(count * 0.2); // middle bubble
    fill(255, alpha);
    ellipse(x_pos, y_pos, radius * 0.8, radius * 0.8);
    
    int alpha2 = 150 - count;          // small white bubble
    if(alpha <= 0) return;
    fill(255, alpha2);
    ellipse(x_pos + radius*0.2, y_pos+radius*0.2, radius * 0.3, radius * 0.3);
  }
}
