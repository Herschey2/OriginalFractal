int deep = 10;
int lastDeep = 0;
String currentFolds = "";
double tX = 0.0;
double tY = 0.0;
double sF = 1.0;
public void setup() {
  size(600, 600);
  fill(0);
}
public void draw() {
  background(255);
  deep = 1 + (frameCount/60) % 12;
  if (deep != lastDeep) {
    currentFolds = regularPaperFold(deep);
    lastDeep = deep;
  }
  dragoncurve((int)(300*sF+tX), (int)(300*sF+tY), deep, (int)(50*sF));
}
public void dragoncurve(float x, float y, int depth, float size){
  String folds = currentFolds;
  int direction = 0;
  int n = folds.length();
  if (n <= 0) return;
  float step = size / (n + 1); 
  for(int i = 0; i < n; i++){
    float t = (float)i / (float)n;
    stroke(0, 255 * t, 255 * (1 - t));
    if(folds.charAt(i) == '1'){
      direction = (direction + 1) % 4;
    } else {
      direction = (direction + 3) % 4;
    }
    if(direction == 0){
      line(x, y, x + step, y);
      x += step;
    }
    else if(direction == 1){
      line(x, y, x, y + step);
      y += step;
    }
    else if(direction == 2){
      line(x, y, x - step, y);
      x -= step;
    }
    else{
      line(x, y, x, y - step);
      y -= step;
    }
  }
}
public String regularPaperFold(int numFolds) {
  if(numFolds<=1){
    return "1";
  }
  else{
    return regularPaperFold(numFolds-1)+"1"+reverse(onesComplement(regularPaperFold(numFolds-1)));
  }
}

public String onesComplement(String s){
  String jeff = "";
  char[] tom = s.toCharArray();
  for(char bob : tom){
    if(bob=='1'){
      jeff=jeff+'0';
    }
    else{
      jeff=jeff+'1';
    }
  }
  return jeff;
}

public String reverse(String sWord){
  String foo = "";
  for(int i =0; i<sWord.length(); i++){
    foo=sWord.substring(i,i+1)+foo;
  }
  return foo;
}
void mouseDragged(MouseEvent e) {
  tX += mouseX - pmouseX;
  tY += mouseY - pmouseY;
}
void mouseScrolled() {
  double f = 1.0;
  if (mouseScroll < 0 && sF < 2000000000000.0) {
    f = 1.1;
  } 
  else if (mouseScroll > 0 && sF > .5) {
    f = 0.9; 
  }
  tX = mouseX + (tX - mouseX) * f;
  tY = mouseY + (tY - mouseY) * f;
  sF *= f;
}









