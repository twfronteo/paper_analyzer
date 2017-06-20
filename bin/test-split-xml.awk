/<PubmedArticle>/ {
  collect = 1 ; buffer = "" 
  ++count
}

/IdType="pubmed"/ {
  split($2, a, ">|<")
  file = a[2]".xml"
}

collect > 0 {
  if (buffer != "") buffer = buffer"\n"
  buffer = buffer $0
}

collect > 0 && /<Title>.+<\/Title>/ {
  file = file".xml"
}

/<\/PubmedArticle>/ {
  collect = 0;
  print file
  print "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" >file
  print buffer >file
  print "</PubmedArticleSet>" >file
}