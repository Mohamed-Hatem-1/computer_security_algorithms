String prepareInput(String text) {
  text = text.replaceAll(RegExp(r'[^a-zA-Z]'), '');
  text = text.toUpperCase();
  text = text.replaceAll('J', 'I');
  return text;
}

List<List<String>> generateKey(String key) {
  key = prepareInput(key);

  List<List<String>> playfairMatrix =
      List.generate(5, (index) => List<String>.filled(5, ''));

  Set<String> keySet = Set();

  int i = 0, j = 0;
  for (String letter in key.split('')) {
    if (!keySet.contains(letter)) {
      playfairMatrix[i][j] = letter;
      keySet.add(letter);
      j += 1;
      if (j == 5) {
        i += 1;
        j = 0;
      }
    }
  }

  String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  for (String letter in alphabet.split('')) {
    if (letter != 'J' && !keySet.contains(letter)) {
      playfairMatrix[i][j] = letter;
      keySet.add(letter);
      j += 1;
      if (j == 5) {
        i += 1;
        j = 0;
      }
    }
  }

  return playfairMatrix;
}

Map<String, dynamic> findCharPosition(List<List<String>> matrix, String char) {
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      if (matrix[i][j] == char) {
        return {'row': i, 'col': j};
      }
    }
  }
  return {};
}

String playfairEncrypt(String plaintext, String key) {
  List<List<String>> matrix = generateKey(key);
  plaintext = prepareInput(plaintext);
  String cipherText = "";

  int i = 0;
  while (i < plaintext.length) {
    if (i == plaintext.length - 1) {
      plaintext += "X";
    } else if (plaintext[i] == plaintext[i + 1]) {
      plaintext =
          plaintext.substring(0, i + 1) + "X" + plaintext.substring(i + 1);
    }
    i += 2;
  }

  for (int i = 0; i < plaintext.length; i += 2) {
    String char1 = plaintext[i];
    String char2 = plaintext[i + 1];
    Map<String, dynamic> position1 = findCharPosition(matrix, char1);
    Map<String, dynamic> position2 = findCharPosition(matrix, char2);

    int row1 = position1['row'];
    int col1 = position1['col'];
    int row2 = position2['row'];
    int col2 = position2['col'];

    if (row1 == row2) {
      cipherText += matrix[row1][(col1 + 1) % 5] + matrix[row2][(col2 + 1) % 5];
    } else if (col1 == col2) {
      cipherText += matrix[(row1 + 1) % 5][col1] + matrix[(row2 + 1) % 5][col2];
    } else {
      cipherText += matrix[row1][col2] + matrix[row2][col1];
    }
  }
  // cpyBtn.style.display = "block";
  // error.innerText = "";
  return cipherText;
}

String playfairDecrypt(String ciphertext, String key) {
  List<List<String>> matrix = generateKey(key);
  ciphertext = prepareInput(ciphertext);
  String plaintext = "";

  for (int i = 0; i < ciphertext.length; i += 2) {
    String char1 = ciphertext[i];
    String char2 = ciphertext[i + 1];
    Map<String, dynamic> position1 = findCharPosition(matrix, char1);
    Map<String, dynamic> position2 = findCharPosition(matrix, char2);

    int row1 = position1['row'];
    int col1 = position1['col'];
    int row2 = position2['row'];
    int col2 = position2['col'];

    if (row1 == row2) {
      plaintext +=
          matrix[row1][(col1 - 1 + 5) % 5] + matrix[row2][(col2 - 1 + 5) % 5];
    } else if (col1 == col2) {
      plaintext +=
          matrix[(row1 - 1 + 5) % 5][col1] + matrix[(row2 - 1 + 5) % 5][col2];
    } else {
      plaintext += matrix[row1][col2] + matrix[row2][col1];
    }
  }
  // cpyBtn.style.display = "block";
  // error.innerText = "";
  return plaintext;
}
