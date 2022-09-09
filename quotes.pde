


void getQuoteRow(int rowNum) {

  Person_Description = quotesTable.getString(rowNum, "Person_Description");
  
  Quote = "\"" + quotesTable.getString(rowNum, "Quote") + "\"";
  
  People = quotesTable.getInt(rowNum, "People");
  Work = quotesTable.getInt(rowNum, "Work");
  Humour = quotesTable.getInt(rowNum, "Humour");
  Place = quotesTable.getInt(rowNum, "Place");
  Time = quotesTable.getInt(rowNum, "Time");

  Book_Title = quotesTable.getString(rowNum, "Book_Title");
  Book_Author = quotesTable.getString(rowNum, "Book_Author");
  Book_Location = quotesTable.getString(rowNum, "Book_Location");
  
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
