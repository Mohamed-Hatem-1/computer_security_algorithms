String monoalphabeticEncrypt(String text, String key) {
  if (key.length != 26) {
    throw ArgumentError("Key length should be 26 characters");
  }

  Map<String, String> charMap = {};
  String alphabet = "abcdefghijklmnopqrstuvwxyz";

  for (int i = 0; i < alphabet.length; i++) {
    charMap[alphabet[i]] = key[i];
  }

  String encryptedText = text.toLowerCase().replaceAllMapped(
        RegExp('[a-z]'),
        (match) => charMap[match.group(0)] ?? match.group(0)!,
      );

  return encryptedText;
}

String monoalphabeticDecrypt(String encryptedText, String key) {
  if (key.length != 26) {
    throw ArgumentError("Key length should be 26 characters");
  }

  Map<String, String> charMap = {};
  String alphabet = "abcdefghijklmnopqrstuvwxyz";

  for (int i = 0; i < alphabet.length; i++) {
    charMap[key[i]!] = alphabet[i];
  }

  String decryptedText = encryptedText.toLowerCase().replaceAllMapped(
        RegExp('[a-z]'),
        (match) => charMap[match.group(0)] ?? match.group(0)!,
      );

  return decryptedText;
}
