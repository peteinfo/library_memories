
// -------------------------------
//       LIBRARY MEMORIES
// -------------------------------

import processing.pdf.*;

PGraphicsPDF pdf;

boolean modeGeneratePDF = false;
boolean modePrintLayout = false;

// ------- unit variables -------
float u;

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
color backgroundCol = color(218, 187, 181); // pink
color shadeCol = color(212, 154, 141); // dusky pink
//color backgroundCol = color(255, 255, 255);   // white
//color textCol = color(255, 0, 0);   // pure red
color textCol = color(201, 66, 59); // dark red
float opacityTop = 0;
float opacityTopTarget = 0;
float opacityBottom = 0;
float opacityBottomTarget = 0;

// ------- font variables -------
PFont fontQuote;
PFont fontTitle;
PFont fontSubtitle;
PFont fontAuthor;
PFont fontBack;
PFont fontStack;
PFont fontStackScreen;
PFont fontScreenQuote;

PShape logo;

// ------- string variables -------
IntList order;
int pos = 0;
StringBuilder currentQuote;
String nextQuote;
boolean flipping = false;



void setup() {

  fullScreen(2);
  //size(640, 1425);  // print dimensions
  //size(680, 1465);  // print dimensions WITH BLEED of 2mm on each side
  //size(1920, 1080);  // HD screen animation
  //size(960, 540);  // HD screen animation, half size tester

  u = height / 100;

  frameRate(24);

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
  fontStackScreen = createFont("ArcherPro", 35);
  fontScreenQuote = createFont("ProximaNovaA-RegularIt", 60);

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
  } else {

    drawScreen();
  }
}
