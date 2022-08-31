
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
String   Book_Title;
String   Book_Location;
String   Book_Author;
int      People;
int      Work;
int      Humour;
int      Place;
int      Time;

String   sentiment;
String   stack;

// ------- colour variables -------
//color backgroundCol = color(235, 199, 198); // pink
color backgroundCol = color(255, 255, 255);   // white
color textCol = color(255, 0, 0);   // pure red 
//color textCol = color(215, 20, 20); // dark red

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
  //size(640, 1425);  // print dimensions
  size(680, 1465);  // print dimensions WITH BLEED of 2mm on each side
  //size(1920, 1080);  // HD screen animation
  //size(960, 540);  // HD screen animation

  //frameRate(12);


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
  fontBack = createFont("ProximaNovaA-RegularIt", 28);
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


    int pageCount = 0;

    for (int a = 0; a < 7; a++) {

      for (int n = 0; n < quotesTable.getRowCount(); n++) {

        // place code for print layout here

        println("page: " + pageCount);

        getQuoteRow(n);
        // create current quote and load in initial quote (blank)
        currentQuote = new StringBuilder();
        currentQuote.append(Quote);

        frontPage();

        pdf.nextPage();

        backPage();

        pdf.nextPage();

        pageCount++;
      }
    }

    // fill up the rest with blanks
    for (int b = pageCount; b < 1000; b++) {

      frontPageBlank();
      pdf.nextPage();
      backPageBlank();
      pdf.nextPage();
      pageCount++;
    }

    endRecord();
    exit();
  }
}



void draw() {


  if (modePrintLayout) {

    // draw print layout

    noStroke();

    // draw a page to screen
    //frontPage();
    //backPage();
    frontPageBlank();
    //backPageBlank();

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
      //text("Books to look for:\n" + Book_Suggestion_One + "\n" + Book_Suggestion_Two, 0, 0, 400, 100);
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

  background(backgroundCol);

  fill(textCol);
  stroke(textCol);

  // punch hole
  // noFill();
  ellipse(width*0.5, height*0.08, 120, 120);
  //fill(0, 100);
  //ellipse(width*0.5, height*0.07, 50, 50);
  //ellipse(width*0.5, height*0.57, 40, 40);

  // display title
  shapeMode(CENTER);
  fill(textCol);
  logo.disableStyle();
  shape(logo, width*0.5, height*0.185, logo.width*0.315, logo.height*0.315);

  // horizontal line
  strokeWeight(2);
  line(0, height*0.27, width, height*0.27);
  line(0, height*0.27 + 5, width, height*0.27 + 5);

  // display QUOTE title
  textFont(fontSubtitle);
  textAlign(LEFT);
  push();
  translate(width*0.1, height*0.28);
  rectMode(LEFT);
  text("QUOTE", 0, 0, 200, 100);
  pop();

  // display quote
  textFont(fontQuote);
  textAlign(LEFT, TOP);
  textLeading(42);
  push();
  translate(width*0.5, height*0.551);
  rectMode(CENTER);
  noFill();
  //rect(0, 0, width*0.68, 700);
  text(currentQuote.toString(), 0, 0, width*0.66, 700);
  pop();

  // horizontal line
  strokeWeight(2);
  line(0, height*0.825, width, height*0.825);
  line(0, height*0.825 + 5, width, height*0.825 + 5);

  // display AUTHOR title
  textFont(fontSubtitle);
  textAlign(LEFT);
  push();
  translate(width*0.1, height*0.835);
  rectMode(LEFT);
  text("AUTHOR", 0, 0, 300, 100);
  pop();

  // display person description
  textFont(fontAuthor);
  textAlign(LEFT, TOP);
  push();
  translate(width*0.5, height*0.9);
  rectMode(CENTER);
  text(Person_Description, 0, 0, width*0.66, 100);
  pop();
}

void backPage() {

  background(backgroundCol);

  fill(textCol);
  stroke(textCol);

  // punch hole
  // noFill();
  ellipse(width*0.5, height*0.08, 120, 120);
  //fill(0, 100);
  //ellipse(width*0.5, height*0.07, 50, 50);
  //ellipse(width*0.5, height*0.57, 40, 40);

  // horizontal line
  strokeWeight(2);
  line(0, height*0.155, width, height*0.155);
  line(0, height*0.155 + 5, width, height*0.155 + 5);


  // display QUOTE ANALYSIS title
  textFont(fontSubtitle);
  fill(textCol);
  textAlign(LEFT);
  push();
  translate(width*0.32, height*0.20);
  rectMode(CENTER);
  text("QUOTE ANALYSIS", 0, 0, 300, 100);
  pop();

  // ANALYSIS
  textFont(fontStack, 45);
  fill(textCol);
  textAlign(LEFT);
  push();
  translate(width*0.47, height*0.34);
  rectMode(CENTER);
  textLeading(55);
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
    rect(width*0.5 + 47*x, height*0.205 + y*56, 33, 33);
  }

  // Work
  y++;
  for (int x = 0; x < 5; x++) {
    if (x < Work) {
      fill(textCol);
    } else {
      noFill();
    }
    rect(width*0.5 + 47*x, height*0.205 + y*56, 33, 33);
  }

  // Humour
  y++;
  for (int x = 0; x < 5; x++) {
    if (x < Humour) {
      fill(textCol);
    } else {
      noFill();
    }
    rect(width*0.5 + 47*x, height*0.205 + y*56, 33, 33);
  }

  // Place
  y++;
  for (int x = 0; x < 5; x++) {
    if (x < Place) {
      fill(textCol);
    } else {
      noFill();
    }
    rect(width*0.5 + 47*x, height*0.205 + y*56, 33, 33);
  }

  // Time
  y++;
  for (int x = 0; x < 5; x++) {
    if (x < Time) {
      fill(textCol);
    } else {
      noFill();
    }
    rect(width*0.5 + 47*x, height*0.205 + y*56, 33, 33);
  }

  // display info
  textFont(fontBack);
  textAlign(LEFT, TOP);
  textLeading(35);
  push();
  translate(width*0.5, height*0.645);
  rectMode(CENTER);
  noFill();
  //rect(0, 0, width*0.68, 700);
  text("This analysis of key characteristics helps us to match memories with books in the library.", 0, 0, width*0.66, 700);
  pop();

  // horizontal line
  strokeWeight(2);
  line(0, height*0.5, width, height*0.5);
  line(0, height*0.5 + 5, width, height*0.5 + 5);

  // display FIND A BOOK title
  textFont(fontSubtitle);
  fill(textCol);
  textAlign(LEFT);
  push();
  translate(width*0.1, height*0.51);
  rectMode(LEFT);
  text("FIND THIS BOOK", 0, 0, 300, 100);
  pop();

  // BOOK SUGGESTION
  textFont(fontStack, 28);
  fill(textCol);
  textAlign(LEFT);
  push();
  translate(width*0.47, height*0.68);
  rectMode(CENTER);
  text(Book_Title + "\n\n" + Book_Author + "\n\n" + Book_Location, 0, 0, 400, 400);
  pop();

  // draw line
  strokeWeight(1);
  line(width*0.175, height*0.755, width*0.825, height*0.755);

  // display info
  textFont(fontBack);
  textAlign(LEFT, TOP);
  textLeading(35);
  push();
  translate(width*0.5, height*0.9);
  rectMode(CENTER);
  noFill();
  //rect(0, 0, width*0.68, 700);
  text("We have selected this book in response to our analysis. Try to find it, or select another that you think connects to the quote.", 0, 0, width*0.66, 400);

  translate(0, 155);
  text("Slip this card into the book for someone else to find.", 0, 0, width*0.66, 400);

  pop();
}

void frontPageBlank() {

  background(backgroundCol);

  fill(textCol);
  stroke(textCol);

  // punch hole
  // noFill();
  ellipse(width*0.5, height*0.08, 120, 120);
  //fill(0, 100);
  //ellipse(width*0.5, height*0.07, 50, 50);
  //ellipse(width*0.5, height*0.57, 40, 40);

  // display title
  shapeMode(CENTER);
  fill(textCol);
  logo.disableStyle();
  shape(logo, width*0.5, height*0.185, logo.width*0.315, logo.height*0.315);

  // horizontal line
  strokeWeight(2);
  line(0, height*0.27, width, height*0.27);
  line(0, height*0.27 + 5, width, height*0.27 + 5);

  // display QUOTE title
  textFont(fontSubtitle);
  textAlign(LEFT);
  push();
  translate(width*0.1, height*0.28);
  rectMode(LEFT);
  text("QUOTE", 0, 0, 200, 100);
  pop();
}

void backPageBlank() {

  background(backgroundCol);

  fill(textCol);
  stroke(textCol);

  // punch hole
  // noFill();
  ellipse(width*0.5, height*0.08, 120, 120);
  //fill(0, 100);
  //ellipse(width*0.5, height*0.07, 50, 50);
  //ellipse(width*0.5, height*0.57, 40, 40);

  // horizontal line
  strokeWeight(2);
  line(0, height*0.155, width, height*0.155);
  line(0, height*0.155 + 5, width, height*0.155 + 5);

  // horizontal line
  strokeWeight(2);
  line(0, height*0.825, width, height*0.825);
  line(0, height*0.825 + 5, width, height*0.825 + 5);

  // display AUTHOR title
  textFont(fontSubtitle);
  textAlign(LEFT);
  push();
  translate(width*0.1, height*0.835);
  rectMode(LEFT);
  text("AUTHOR", 0, 0, 300, 100);
  pop();
}
