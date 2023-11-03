printLog(String text,{bool printAll=true}) {
  const String key = "LocTroiCayAnQua-----";
  int maxLength = text.length;
  if (maxLength >=1000 && printAll==true) {
    print(key);
    print("${text.substring(0,1000)}");
    printLog(text.substring(1000,maxLength),printAll: printAll);
  } else {
    print("$key$text");
  }
}
