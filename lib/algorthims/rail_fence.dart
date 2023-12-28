String railFenceEncrypt(String message, int rails) {
  if (rails < 2) {
    print("Number of rails should be 2 or more.");
    return "";
  }

  List<List<String>> fence = List.generate(rails, (index) => []);
  int rail = 0;
  int direction = 1;

  for (int i = 0; i < message.length; i++) {
    fence[rail].add(message[i]);
    rail += direction;

    if (rail == 0 || rail == rails - 1) {
      direction = -direction;
    }
  }

  String encryptedMessage = "";
  for (int i = 0; i < rails; i++) {
    encryptedMessage += fence[i].join("");
  }

  // error.innerText = "";
  // cpyBtn.style.display = "block";
  return encryptedMessage;
}

String railFenceDecrypt(String cipher, int key) {
  List<List<String>> rail =
      List.generate(key, (index) => List<String>.filled(cipher.length, '\n'));

  bool dirDown = false;
  int row = 0, col = 0;

  for (int i = 0; i < cipher.length; i++) {
    if (row == 0 || row == key - 1) {
      dirDown = !dirDown;
    }

    rail[row][col] = '*';
    col += 1;

    if (dirDown) {
      row += 1;
    } else {
      row -= 1;
    }
  }

  int index = 0;
  for (int i = 0; i < key; i++) {
    for (int j = 0; j < cipher.length; j++) {
      if (rail[i][j] == '*') {
        rail[i][j] = cipher[index];
        index += 1;
      }
    }
  }

  String result = "";
  dirDown = false;
  row = 0;
  col = 0;

  for (int i = 0; i < cipher.length; i++) {
    if (row == 0 || row == key - 1) {
      dirDown = !dirDown;
    }

    if (rail[row][col] != '*') {
      result += rail[row][col];
      col += 1;
    }

    if (dirDown) {
      row += 1;
    } else {
      row -= 1;
    }
  }

  return result;
}
