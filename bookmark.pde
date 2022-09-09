
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
