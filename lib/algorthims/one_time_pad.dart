String oneTimePadEncrypt(String text, String key) {
  // Initializing cipherText
  String cipherText = "";

  // Initialize cipher list of key length
  // which stores the sum of corresponding no.'s
  // of plainText and key.
  List<int> cipher = List.generate(
      key.length,
      (index) =>
          text.codeUnitAt(index) -
          'A'.codeUnitAt(0) +
          key.codeUnitAt(index) -
          'A'.codeUnitAt(0));

  // If the sum is greater than 25
  // subtract 26 from it
  // and store that resulting value
  for (int i = 0; i < key.length; i++) {
    if (cipher[i] > 25) {
      cipher[i] = cipher[i] - 26;
    }
  }

  // Converting the no.'s into integers

  // Convert these integers to corresponding
  // characters and add them up to cipherText
  for (int i = 0; i < key.length; i++) {
    int x = cipher[i] + 'A'.codeUnitAt(0);
    cipherText += String.fromCharCode(x);
  }

  // Returning the cipherText
  return cipherText;
}

String oneTimePadDecrypt(String s, String key) {
  // Initializing plain text
  String plainText = "";

  // Initializing integer list of key length
  // which stores difference
  // of corresponding no.'s of
  // each character of cipherText and key
  List<int> plain = List.generate(
      key.length,
      (index) =>
          s.codeUnitAt(index) -
          'A'.codeUnitAt(0) -
          (key.codeUnitAt(index) - 'A'.codeUnitAt(0)));

  // If the difference is less than 0
  // add 26 and store it in the list.
  for (int i = 0; i < key.length; i++) {
    if (plain[i] < 0) {
      plain[i] = plain[i] + 26;
    }
  }

  // Converting int to corresponding char
  // add them up to plainText
  for (int i = 0; i < key.length; i++) {
    int x = plain[i] + 'A'.codeUnitAt(0);
    plainText += String.fromCharCode(x);
  }

  // Returning plainText
  return plainText;
}
