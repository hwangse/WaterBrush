class drop {
  float x_pos, y_pos;            // position
  float move_default, move_real; // random move
  int target_count, count;       // total number
  int r, g, b, alpha;            // color
  int percentage;

  drop(float _x, float _y, float _move) {
    x_pos = _x;
    y_pos = _y;
    move_default = _move;
    target_count = 300;
    count = 0;
    percentage = int(random(100));
  }
  
  void clock(){
     count++; 
  }
  
  void move() {
    move_real = count < 200 ? move_default * 0.3 : move_default;
    x_pos += random(-move_real, move_real);
    y_pos += random(-move_real, move_real);
  }

  void display() {              // display water drawing before they became snow or rain
    if(count >= target_count) {
      if(temperature >= 20){
         fly();
      }else if (temperature <= 0){
         snow(); 
      } else {
         rain(); 
      }
      return;
    }
    
    noStroke();
    r = 10 + int(count / 2);
    g = 60 + int(count / 2);
    b = 190;
    fill(r, g, b, 100);
    float radius = random(20 + int(count / 20));
    new bubble(x_pos, y_pos, radius, count).display();
  }
  
  void fly() {
    float radius = random(20 + int(count / 20));
    float acceleration = (temperature - defaultTemp) * 0.35; // the hotter, the faster
    y_pos += random(-(move_default * 2 + acceleration), 0);
    alpha = 400 - (count + int(acceleration * 3));
    if(alpha < 0) return;
    
    // gradient color change to red
    color from = color(r, g, b);
    color to = color(204, 100, 110);
    color targetColor = lerpColor(from, to, (temperature - defaultTemp) * 0.06);
    color gradColor = lerpColor(from, targetColor, (count - 300) * 0.02);
    
    noStroke();
    fill(gradColor, alpha);
    new bubble(x_pos, y_pos, radius, count).display();
  }
  
  void rain() {
    float radius = random(20 + int(count / 20));
    float acceleration = (defaultTemp - temperature) * 0.2;
    y_pos -= random(-(move_default * 2 + acceleration), 0);
    alpha = 400 - count;
    if(alpha < 0) return;
    
    // gradient color change to blue
    color from = color(r, g, b);
    color to = color(108, 185, 196);
    color targetColor = lerpColor(from, to, (defaultTemp - temperature) * 0.06);
    color gradColor = lerpColor(from, targetColor, (count - 300) * 0.02);
    
    noStroke();
    fill(gradColor, alpha);
    new bubble(x_pos, y_pos, radius, count).display();   
  }
  
  void snow(){
    if(percentage < 15){                         // only few flakes will be fallen
      alpha = int(400 - (count * 0.4));          // falling speed
      
      if(y_pos <= height * 0.985)
        y_pos -= random(-(move_default * 5), 0);  
    }else{
      alpha = int(400 - (count * 0.9)); 
    }
    if(alpha < 0) return;
    
    float radius = random(20 + int(count / 20)); // snowflake radius
    
    // gradient color change to white
    color from = color(r, g, b);
    color to = color(255);
    color gradColor = lerpColor(from, to, (count - 300) * 0.02);
    
    noStroke();
    fill(gradColor, alpha * 0.9);
    new bubble(x_pos, y_pos, radius, count).display(); 
  }
}
