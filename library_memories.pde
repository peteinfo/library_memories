
// -------------------------------
//       LIBRARY MEMORIES
// -------------------------------

import processing.pdf.*;

PGraphicsPDF pdf;

boolean modeGeneratePDF = true;
boolean modePrintLayout = true;
boolean printedPDF = false;

// ------- table variables -------
Table quotesTable;
Table dewey;
int   rowPointer = 0;

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
int      People;
int      Work;
int      Humour;
int      Place;
int      Time;

String   sentiment;
String   stack;

// ------- colour variables -------
color backgroundCol = color(235, 199, 198);
color textCol = color(215, 20, 20);

// ------- font variables -------
PFont fontQuote;
PFont fontTitle;
PFont fontSubtitle;
PFont fontAuthor;
PFont fontBack;
PFont fontStack;

PShape logo;

// ------- string variables -------
IntList order;
int pos = 0;
StringBuilder currentQuote;
String nextQuote;
boolean flipping = false;





void setup() {

  //fullScreen();
  //size(640, 1425, PDF, "bookmark.pdf");  // print dimensions
  size(640, 1425);  // print dimensions
  //size(1920, 1080);  // HD screen animation
  //size(960, 540);  // HD screen animation

  frameRate(12);


  quotesTable = loadTable("quotes.csv", "header");
  String[] fontList = PFont.list();

  for (int n = 0; n < 100; n++) {
    fontList = shorten(fontList);
  }
  printArray(fontList);

  fontQuote = createFont("ProximaNovaA-RegularIt", 35);
  fontTitle = createFont("ArcherPro-Bold", 60);
  fontSubtitle = createFont("ProximaNovaA-Regular", 25);
  fontAuthor = createFont("ProximaNova-Regular", 35);
  fontBack = createFont("ProximaNovaA-ThinIt", 25);
  fontStack = createFont("ArcherPro-Bold", 35);

  logo = loadShape("exLibris.svg");


  // get first row of the quotes csv
  getQuoteRow(rowPointer);

  // create current quote and load in initial quote (blank)
  currentQuote = new StringBuilder();
  currentQuote.append(Quote);


  if (modeGeneratePDF) {

    // ---- PRINT MODE ----

    pdf = (PGraphicsPDF)beginRecord(PDF, "bookmarks.pdf");


    for (int n = 0; n < quotesTable.getRowCount(); n++) {

      // place code for print layout here

      println("page: " + n);

      getQuoteRow(n);
      // create current quote and load in initial quote (blank)
      currentQuote = new StringBuilder();
      currentQuote.append(Quote);

      background(backgroundCol);
      frontPage();

      pdf.nextPage();

      background(backgroundCol);
      backPage();

      pdf.nextPage();
    }
    endRecord();
    exit();
  }
}



void draw() {


  if (modePrintLayout) {

    // draw print layout

    if (!printedPDF) {
      beginRecord(PDF, "bookmark.pdf");
    }


    background(backgroundCol);
    //background(255);
    fill(backgroundCol);
    noStroke();
    //rect(0, 0, width, height);

    //frontPage();

    backPage();


    if (!printedPDF) {
      endRecord();
      printedPDF = true;
    }
  } else {



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

void frontPage() {
  fill(textCol);
  stroke(textCol);

  // punch hole
  // noFill();
  ellipse(width*0.5, height*0.07, 80, 80);
  fill(0, 100);
  ellipse(width*0.5, height*0.07, 50, 50);
  //ellipse(width*0.5, height*0.57, 40, 40);

  // display title
  shapeMode(CENTER);
  fill(textCol);
  logo.disableStyle();
  shape(logo, width*0.5, height*0.175, logo.width*0.31, logo.height*0.31);

  // horizontal line
  strokeWeight(2);
  line(0, height*0.265, width, height*0.265);
  line(0, height*0.265 + 5, width, height*0.265 + 5);

  // display QUOTE title
  textFont(fontSubtitle);
  textAlign(LEFT);
  push();
  translate(width*0.23, height*0.31);
  rectMode(CENTER);
  text("QUOTE", 0, 0, 200, 100);
  pop();

  // display quote
  textFont(fontQuote);
  textAlign(LEFT, TOP);
  textLeading(42);
  push();
  translate(width*0.5, height*0.56);
  rectMode(CENTER);
  noFill();
  //rect(0, 0, width*0.68, 700);
  text(currentQuote.toString(), 0, 0, width*0.68, 700);
  pop();

  // horizontal line
  strokeWeight(2);
  line(0, height*0.83, width, height*0.83);
  line(0, height*0.83 + 5, width, height*0.83 + 5);

  // display AUTHOR title
  textFont(fontSubtitle);
  textAlign(LEFT);
  push();
  translate(width*0.23, height*0.875);
  rectMode(CENTER);
  text("AUTHOR", 0, 0, 200, 100);
  pop();

  // display person description
  textFont(fontAuthor);
  textAlign(LEFT, TOP);
  push();
  translate(width*0.5, height*0.91);
  rectMode(CENTER);
  text(Person_Description, 0, 0, width*0.68, 100);
  pop();
}

void backPage() {


  fill(textCol);
  stroke(textCol);

  // punch hole
  // noFill();
  ellipse(width*0.5, height*0.07, 80, 80);
  fill(0, 100);
  ellipse(width*0.5, height*0.07, 50, 50);
  //ellipse(width*0.5, height*0.57, 40, 40);

  // horizontal line
  strokeWeight(2);
  line(0, height*0.15, width, height*0.15);
  line(0, height*0.15 + 5, width, height*0.15 + 5);


  // display WHAT IS IN THIS QUOTE title
  textFont(fontSubtitle);
  fill(textCol);
  textAlign(LEFT);
  push();
  translate(width*0.38, height*0.20);
  rectMode(CENTER);
  text("QUOTE ANALYSIS", 0, 0, 400, 100);
  pop();

  // ANALYSIS
  textFont(fontStack);
  fill(textCol);
  textAlign(LEFT);
  push();
  translate(width*0.47, height*0.36);
  rectMode(CENTER);
  textLeading(50);
  text("People\nWork\nHumour\nPlace\nTime", 0, 0, 400, 400);
  pop();

  strokeWeight(1);

  // People
  int y=0;
  for (int x = 0; x < 5; x++) {
    if (x < People) {
      fill(textCol);
    } else {
      noFill();
    }
    rect(width*0.44 + 52*x, height*0.215 + y*52, 35, 35);
  }

  // Work
  y++;
  for (int x = 0; x < 5; x++) {
    if (x < Work) {
      fill(textCol);
    } else {
      noFill();
    }
    rect(width*0.44 + 52*x, height*0.215 + y*52, 35, 35);
  }

  // Humour
  y++;
  for (int x = 0; x < 5; x++) {
    if (x < Humour) {
      fill(textCol);
    } else {
      noFill();
    }
    rect(width*0.44 + 52*x, height*0.215 + y*52, 35, 35);
  }

  // Place
  y++;
  for (int x = 0; x < 5; x++) {
    if (x < Place) {
      fill(textCol);
    } else {
      noFill();
    }
    rect(width*0.44 + 52*x, height*0.215 + y*52, 35, 35);
  }

  // Time
  y++;
  for (int x = 0; x < 5; x++) {
    if (x < Time) {
      fill(textCol);
    } else {
      noFill();
    }
    rect(width*0.44 + 52*x, height*0.215 + y*52, 35, 35);
  }






  // display info
  textFont(fontBack);
  textAlign(LEFT, TOP);
  textLeading(35);
  push();
  translate(width*0.5, height*0.66);
  rectMode(CENTER);
  noFill();
  //rect(0, 0, width*0.68, 700);
  text("This analysis of key characteristics helps us to match memories with books in the library.", 0, 0, width*0.68, 700);
  pop();

  // horizontal line
  strokeWeight(2);
  line(0, height*0.51, width, height*0.51);
  line(0, height*0.51 + 5, width, height*0.51 + 5);

  // display FIND A BOOK title
  textFont(fontSubtitle);
  fill(textCol);
  textAlign(LEFT);
  push();
  translate(width*0.38, height*0.56);
  rectMode(CENTER);
  text("FIND THIS BOOK", 0, 0, 400, 100);
  pop();

  // BOOK SUGGESTION
  textFont(fontStack, 27);
  fill(textCol);
  textAlign(LEFT);
  push();
  translate(width*0.47, height*0.7);
  rectMode(CENTER);
  text(Book_Suggestion_One + "\n\nLocation: " + stack, 0, 0, 400, 400);
  pop();

  // draw line
  strokeWeight(1);
  line(width*0.16, height*0.8, width*0.84, height*0.8);

  // display info
  textFont(fontBack);
  textAlign(LEFT, TOP);
  textLeading(35);
  push();
  translate(width*0.5, height*0.96);
  rectMode(CENTER);
  noFill();
  //rect(0, 0, width*0.68, 700);
  text("We have selected this book in response to our analysis. Try to find it, or select another that you think connects to the quote.\nSlip this card into the book for someone else to find.", 0, 0, width*0.68, 400);
  pop();
}
