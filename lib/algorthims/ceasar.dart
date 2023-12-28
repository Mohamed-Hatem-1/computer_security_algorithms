String caesarCipherEncrypt(String text, int shift) {
  if (shift < 0) {
    shift += 26 * (shift.abs() ~/ 26);
    shift += 26;
  }
  const String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final String uppercaseText = text.toUpperCase();
  String encryptedText = "";
  for (int i = 0; i < uppercaseText.length; i++) {
    final currentChar = uppercaseText[i];
    if (alphabet.contains(currentChar)) {
      final currentIndex = alphabet.indexOf(currentChar);
      final newIndex = (currentIndex + shift) % 26;
      encryptedText += alphabet[newIndex];
    } else {
      encryptedText += currentChar;
    }
  }
  return encryptedText;
}

String caesarCipherDecrypt(String encryptedText, int shift) {
  return caesarCipherEncrypt(encryptedText, -shift);
}
