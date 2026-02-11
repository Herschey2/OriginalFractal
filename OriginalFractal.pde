int deep = 2;
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
  dragoncurve((int)(300*sF+tX), (int)(300*sF+tY), deep, (float)(400*sF));
}
public void dragoncurve(float x, float y, int depth, float size){
  String folds = currentFolds;
  int direction = 0;
  int n = folds.length();
  int segments = n + 1;
  if (segments <= 0) return;
  float step = size / sqrt(segments);
  for (int i = 0; i < segments; i++){
    float t = (float)i / (float)max(1, segments - 1);
    stroke(0, 255 * t, 255 * (1 - t));
    float nx = x;
    float ny = y;
    if (direction == 0) nx = x + step;
    else if (direction == 1) ny = y + step;
    else if (direction == 2) nx = x - step;
    else ny = y - step;
    line(x, y, nx, ny);
    x = nx;
    y = ny;
    if (i < n){
      if (folds.charAt(i) == '1'){
        direction = (direction + 1) % 4;
      } else {
        direction = (direction + 3) % 4;
      }
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











