

void keyPressed() {

  if (keyCode == 32) {
    
    rowPointer++;
    
    if (rowPointer >= quotesTable.getRowCount()) {
      rowPointer = 0;
    }
    
    getQuoteRow(rowPointer);
    
    newQuote(Quote);    
        
    flipping = true;
    pos = 0;
    
  }
}
