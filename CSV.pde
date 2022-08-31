


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
