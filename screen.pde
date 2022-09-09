
void drawScreen() {

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
  textSize(u*4);
  textAlign(CENTER, CENTER);
  push();
  translate(width*0.5, height*0.5);
  rectMode(CENTER);
  text(currentQuote.toString(), 0, 0, 600, 800);
  pop();

  if (!flipping) {

    /*
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
    */
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
