
// -------------------------------
//       LIBRARY MEMORIES
// -------------------------------

boolean printMode = false;

// ------- table variables -------
Table quotesTable;
Table dewey;
int rowPointer = 0;

String   Person_Description;
String   Quote;
int      Positive_Sentiment;
int      Neutral_Sentiment;
int      Negative_Sentiment;
String   LOC_Label_Primary;
String   LOC_Class_Primary;
int      LOC_Class_Value_Primary;
String   LOC_Label_Secondary;
String   LOC_Class_Secondary;
int      LOC_Class_Value_Secondary;
String   Book_Suggestion_One;
String   Book_Suggestion_Two;

String   sentiment;
String   stack;

// ------- colour variables -------
color backgroundCol = color(255, 240, 240);
color textCol = color(255, 100, 100);

// ------- font variables -------
PFont fontQuote;

// ------- string variables -------
IntList order;
int pos = 0;
StringBuilder currentQuote;
String nextQuote;
boolean flipping = false;





void setup() {

  //fullScreen();
  size(1600, 900);

  frameRate(12);

  quotesTable = loadTable("quotes.csv", "header");

  fontQuote = loadFont("Menlo-Regular-48.vlw");
  textFont(fontQuote, 48);

  // get first row of the quotes csv
  getQuoteRow(rowPointer);

  // create current quote and load in initial quote (blank)
  currentQuote = new StringBuilder();
  currentQuote.append(Quote);


  if (printMode) {
    
    // ---- PRINT MODE ----

    for (TableRow row : quotesTable.rows()) {
      
      
    }
    exit();
  }
}



void draw() {

  // set background
  background(backgroundCol);




  // ---- SCREEN MODE ----

  // draw the main quote
  if (flipping) {
    fill(textCol, 150);
  } else {
    fill(textCol, 255);
  }

  println(flipping);

  // display main quote
  textSize(25);
  textAlign(CENTER);
  push();
  translate(width*0.5, height*0.6);
  rectMode(CENTER);
  text(currentQuote.toString(), 0, 0, 600, 800);
  pop();

  if (!flipping) {


    // display sentiment
    textSize(18);
    textAlign(CENTER);
    push();
    translate(width*0.2, height*0.9);
    rectMode(CENTER);
    text(sentiment, 0, 0, 400, 100);
    pop();

    // middle book
    textSize(18);
    textAlign(CENTER);
    push();
    translate(width*0.5, height*0.9);
    rectMode(CENTER);
    text(stack, 0, 0, 400, 100);
    pop();

    // right book
    textSize(18);
    textAlign(CENTER);
    push();
    translate(width*0.8, height*0.9);
    rectMode(CENTER);
    text("Books to look for:\n" + Book_Suggestion_One + "\n" + Book_Suggestion_Two, 0, 0, 400, 100);
    pop();
  }

  // update the quote animation
  if (flipping) updateQuoteAnimation();
}



void newQuote(String inputQuote) {

  nextQuote = inputQuote;

  // find the length of the largest string
  int maxStringLength = max(currentQuote.length(), nextQuote.length());

  // create an intlist and give it a shuffle
  // this determines the order that the characters flip
  order = new IntList();
  for (int n = 0; n < maxStringLength; n++) {
    order.append(n);
  }
  order.shuffle();


  // pad the strings so they are all the same length
  if (nextQuote.length() < currentQuote.length()) {
    int diff = currentQuote.length() - nextQuote.length();
    for (int n = 0; n < diff; n++) {
      nextQuote += " ";
    }
  }

  if (nextQuote.length() > currentQuote.length()) {
    int diff = nextQuote.length() - currentQuote.length();
    for (int n = 0; n < diff; n++) {
      currentQuote.append(" ");
    }
  }
}


void updateQuoteAnimation() {

  for (int n = 0; n < 12; n++) {

    if (pos < currentQuote.length()) {

      currentQuote.setCharAt(order.get(pos), nextQuote.charAt(order.get(pos)));

      pos++;
    } else {
      flipping = false;
    }
  }
}
