
Table quotes;
Table dewey;

color backgroundCol = color(255, 240, 240);
color textCol = color(255, 100, 100);

PFont fontQuote;

IntList order;
int pos = 0;
StringBuilder currentQuote;
String nextQuote;

void setup() {

  //fullScreen();
  size(800, 800);

  quotes = loadTable("quotes.csv", "header");
  dewey = loadTable("dewey.csv", "header");

  fontQuote = loadFont("Menlo-Regular-48.vlw");
  textFont(fontQuote, 48);

  // create current quote and load in initial quote (blank)
  currentQuote = new StringBuilder();
  currentQuote.append("hello");
  
  newQuote(getRandomQuote());
}



void draw() {

  // set background
  background(backgroundCol);

  // draw the main quote
  fill(textCol);
  textSize(25);
  textAlign(LEFT);
  push();
  translate(width*0.5, height*0.6);
  rectMode(CENTER);
  text(currentQuote.toString(), 0, 0, 550, 800);
  pop();

  // update the quote animation
  updateQuoteAnimation();
}


void newQuote(String inputQuote) {
  
  nextQuote = inputQuote;
  
  stringA = getRandomQuote();
  stringB = getRandomQuote();
  stringC = stringA;
  //sb = new StringBuilder();

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

  currentQuote.append(stringC);
}


void updateQuoteAnimation() {
  /*
  for (int n = 0; n < 3; n++) {
   
   if (pos < stringC.length()) {
   
   currentQuote.setCharAt(order.get(pos), stringB.charAt(order.get(pos)));
   //println(stringB.charAt(order.get(pos)));
   //charsC[order.get(pos)] = stringB.charAt(order.get(pos));
   pos++;
   }
   }
   */
}
