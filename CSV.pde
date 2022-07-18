


String getRandomClass() {

  int randomEntry = int(random(dewey.getRowCount()));
  String code = dewey.getString(randomEntry, "CLASS");
  String caption = dewey.getString(randomEntry, "CAPTION");

  return code + " " + caption;
}


String getRandomQuote() {
  int randomEntry = int(random(quotes.getRowCount()));
  String quote = quotes.getString(randomEntry, "QUOTE");
  String name = quotes.getString(randomEntry, "NAME");

  return quote + "\n(" + name + ")";
}
