
void drawScreen() {

  // set background
  background(backgroundCol);

  // draw the bands

  fill(shadeCol);
  noStroke();
  rect(0, 0, width, height*0.2);
  rect(0, height*0.8, width, height*0.2);

  // ---- SCREEN MODE ----

  // draw the main quote
  if (flipping) {
    fill(textCol, 150);
  } else {
    fill(textCol, 255);
  }

  // display main quote
  textAlign(CENTER, CENTER);
  push();
  translate(width*0.5, height*0.5);
  rectMode(CENTER);
  textFont(fontScreenQuote);
  textSize(u*5);
  textLeading(u*7);
  text(currentQuote.toString(), 0, 0, 600, 800);
  pop();

  if (!flipping) {


    // display QUOTE ANALYSIS title
    textFont(fontSubtitle, 2.5*u);
    fill(textCol);
    textAlign(CENTER);
    text("QUOTE ANALYSIS", width*0.5, height*0.05);


    // ANALYSIS
    textFont(fontStack, u*3);
    fill(textCol);
    stroke(textCol);
    textAlign(CENTER);
    push();
    //rectMode(CENTER);
    text("People", width*0.1, height*0.1);
    text("Work", width*0.3, height*0.1);
    text("Humour", width*0.5, height*0.1);
    text("Place", width*0.7, height*0.1);
    text("Time", width*0.9, height*0.1);

    pop();

    strokeWeight(1);

    // People
    for (int x = 0; x < 5; x++) {
      if (x < People) {
        fill(textCol);
      } else {
        noFill();
      }
      rect(width*0.1-9*u + x*u*4, height*0.12, u*3, u*3);
    }

    // Work
    for (int x = 0; x < 5; x++) {
      if (x < Work) {
        fill(textCol);
      } else {
        noFill();
      }
      rect(width*0.3-9*u + x*u*4, height*0.12, u*3, u*3);
    }

    // Humour
    for (int x = 0; x < 5; x++) {
      if (x < Humour) {
        fill(textCol);
      } else {
        noFill();
      }
      rect(width*0.5-9*u + x*u*4, height*0.12, u*3, u*3);
    }

    // Place
    for (int x = 0; x < 5; x++) {
      if (x < Place) {
        fill(textCol);
      } else {
        noFill();
      }
      rect(width*0.7-9*u + x*u*4, height*0.12, u*3, u*3);
    }

    // Time
    for (int x = 0; x < 5; x++) {
      if (x < Time) {
        fill(textCol);
      } else {
        noFill();
      }
      rect(width*0.9-9*u + x*u*4, height*0.12, u*3, u*3);
    }


    // display FIND THIS BOOK title
    textFont(fontSubtitle, 2.5*u);
    fill(textCol);
    textAlign(CENTER);
    text("FIND THIS BOOK", width*0.5, height*0.85);

    // BOOK SUGGESTION
    textFont(fontStack, 3*u);
    fill(textCol);
    textAlign(CENTER);
    push();
    translate(width*0.5, height*0.9);
    rectMode(CENTER);
    text(Book_Title, 0, 0, width*0.8, u*5);
    textFont(fontStackScreen, 3*u);
    text(Book_Author, 0, 4*u, width*0.8, u*5);
    text(Book_Location, 0, 8*u, width*0.8, u*5);

    pop();
  }

  // update the quote animation
  if (flipping) updateQuoteAnimation();
}


void updateQuoteAnimation() {

  for (int n = 0; n < 1; n++) {

    if (pos < currentQuote.length()) {

      currentQuote.setCharAt(order.get(pos), nextQuote.charAt(order.get(pos)));

      pos++;
    } else {
      flipping = false;
    }
  }
}
