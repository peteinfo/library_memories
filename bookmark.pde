

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
