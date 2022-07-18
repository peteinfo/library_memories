
Table quotes;
Table dewey;

color backgroundCol = color(255, 240, 240);
color textCol = color(255, 100, 100);

PFont fontQuote;

String stringA;
String stringB;
String stringC;
IntList order;
int pos = 0;
String[] charsC;
StringBuilder sb;

void setup() {

  //fullScreen();
  size(800, 800);

  quotes = loadTable("quotes.csv", "header");
  dewey = loadTable("dewey.csv", "header");

  fontQuote = loadFont("Menlo-Regular-48.vlw");
  textFont(fontQuote, 48);

  //newBookmark();

  stringA = getRandomQuote();
  stringA = getRandomQuote();
  sb = new StringBuilder();

  firstQuote();
}



void draw() {

  background(backgroundCol);

  fill(textCol);
  textSize(25);
  textAlign(LEFT);
  push();
  translate(width*0.5, height*0.6);
  rectMode(CENTER);
  text(sb.toString(), 0, 0, 550, 800);
  pop();

  updateQuoteAnimation();
}


String getRandomClass() {

  int randomEntry = int(random(dewey.getRowCount()));
  String code = dewey.getString(randomEntry, "CLASS");
  String caption = dewey.getString(randomEntry, "CAPTION");

  return code + " " + caption;
}



String getRandomQuote() {
  int randomEntry = int(random(quotes.getRowCount()));
  String quote = quotes.getString(randomEntry, "QUOTE");
  String name = quotes.getString(randomEntry, "NAME");

  return quote + "\n(" + name + ")";
}

void keyPressed() {

  if (keyCode == 32) {
    //newBookmark();
    newQuote();
  }
}

void newBookmark() {

  background(backgroundCol);

  rectMode(CENTER);

  /*
  noFill();
   stroke(textCol);
   strokeWeight(1);
   rect(width/2, height/2, width*0.35, height*0.75, 20);
   */

  fill(textCol);
  textSize(25);
  textAlign(LEFT);
  push();
  translate(width*0.5, height*0.6);
  text(getRandomQuote(), 0, 0, 550, 800);
  pop();

  /*
  fill(textCol);
   textSize(25);
   text(getRandomClass(), width/2-width*0.15, height*0.7);
   text(getRandomClass(), width/2-width*0.15, height*0.75);
   text(getRandomClass(), width/2-width*0.15, height*0.8);
   */
}

void firstQuote() {
  stringA = getRandomQuote();
  stringB = getRandomQuote();
  stringC = stringA;
  sb = new StringBuilder();

  int stringLength = max(stringA.length(), stringB.length());

  order = new IntList();

  for (int n = 0; n < stringLength; n++) {
    order.append(n);
  }
  order.shuffle();

  // pad the strings so they are all the same length

  if (stringC.length() < stringB.length()) {

    int diff = stringB.length() - stringC.length();

    for (int n = 0; n < diff; n++) {
      stringA += " ";
      stringC += " ";
    }
  }

  if (stringC.length() > stringB.length()) {

    int diff = stringC.length() - stringB.length();

    for (int n = 0; n < diff; n++) {
      stringB += " ";
    }
  }

  charsC = stringC.split("");
  sb.append(stringC);
}

void newQuote() {
 
  // --------------------
  // FILL THIS SECTION IN
  // --------------------
  
}


void updateQuoteAnimation() {

  for (int n = 0; n < 3; n++) {

    if (pos < stringC.length()) {

      sb.setCharAt(order.get(pos), stringB.charAt(order.get(pos)));
      //println(stringB.charAt(order.get(pos)));
      //charsC[order.get(pos)] = stringB.charAt(order.get(pos));
      pos++;
    }
  }
}
