


void getQuoteRow(int rowNum) {

  Person_Description = quotesTable.getString(rowNum, "Person_Description");
  Quote = "\"" + quotesTable.getString(rowNum, "Quote") + "\"";
  //Positive_Sentiment = quotesTable.getInt(rowNum, "Positive_Sentiment");
  //Neutral_Sentiment = quotesTable.getInt(rowNum, "Neutral_Sentiment");
  //Negative_Sentiment = quotesTable.getInt(rowNum, "Negative_Sentiment");
  LOC_Label_Primary = quotesTable.getString(rowNum, "LOC_Label_Primary");
  LOC_Class_Primary = quotesTable.getString(rowNum, "LOC_Class_Primary");
  LOC_Class_Value_Primary = quotesTable.getInt(rowNum, "LOC_Class_Value_Primary");
  LOC_Label_Secondary = quotesTable.getString(rowNum, "LOC_Label_Secondary");
  LOC_Class_Secondary = quotesTable.getString(rowNum, "LOC_Class_Secondary");
  LOC_Class_Value_Secondary = quotesTable.getInt(rowNum, "LOC_Class_Value_Secondary");
  Book_Suggestion_One = quotesTable.getString(rowNum, "Book_Suggestion_One");
  Book_Suggestion_Two = quotesTable.getString(rowNum, "Book_Suggestion_Two");

  sentiment = "Positive: " + Positive_Sentiment + "%\nNeutral: " + Neutral_Sentiment + "%\nNegative: " + Negative_Sentiment + "%";
  stack = LOC_Class_Primary + " " + LOC_Label_Primary;
}
