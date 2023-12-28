import 'package:flutter/material.dart';

class EncryptionDecryptionScreen extends StatefulWidget {
  @override
  _EncryptionDecryptionScreenState createState() => _EncryptionDecryptionScreenState();
}

class _EncryptionDecryptionScreenState extends State<EncryptionDecryptionScreen> {
  String _selectedOperation = 'Encryption';
  String _selectedAlgorithm = 'Caesar Cipher';
  String _encryptionKey = '';
  String _inputText = '';

  bool _isEncryptionKeyEnabled() {
    return _selectedAlgorithm != 'Rail Fence';
  }

  String caesarCipherEncrypt(String plainText, int shift) {
    String result = '';
    for (int i = 0; i < plainText.length; i++) {
      if (plainText[i].toUpperCase() != plainText[i].toLowerCase()) {
        // Encrypt alphabetic characters only
        String char = plainText[i];
        String shiftedChar = String.fromCharCode(char.codeUnitAt(0) + shift);
        if (char == char.toUpperCase()) {
          if (shiftedChar.codeUnitAt(0) > 'Z'.codeUnitAt(0)) {
            shiftedChar = String.fromCharCode(shiftedChar.codeUnitAt(0) - 26);
          }
        } else {
          if (shiftedChar.codeUnitAt(0) > 'z'.codeUnitAt(0)) {
            shiftedChar = String.fromCharCode(shiftedChar.codeUnitAt(0) - 26);
          }
        }
        result += shiftedChar;
      } else {
        // Non-alphabetic characters remain unchanged
        result += plainText[i];
      }
    }
    return result;
  }

  String caesarCipherDecrypt(String encryptedText, int shift) {
    return caesarCipherEncrypt(encryptedText, -shift);
  }

  void _performEncryptionOrDecryption() {
    String result = '';
    if (_selectedOperation == 'Encryption') {
      if (_selectedAlgorithm == 'Caesar Cipher') {
        result = caesarCipherEncrypt(_inputText, 3); // Using a shift of 3 as an example
      } else if (_selectedAlgorithm == 'Monoalphabetic') {
        // Implement Monoalphabetic encryption logic
      } else if (_selectedAlgorithm == 'Playfair Cipher') {
        // Implement Playfair Cipher encryption logic
      }
      // Implement encryption logic for other algorithms
    } else {
      if (_selectedAlgorithm == 'Caesar Cipher') {
        result = caesarCipherDecrypt(_inputText, 3); // Using a shift of 3 as an example
      } else if (_selectedAlgorithm == 'Monoalphabetic') {
        // Implement Monoalphabetic decryption logic
      } else if (_selectedAlgorithm == 'Playfair Cipher') {
        // Implement Playfair Cipher decryption logic
      }
      // Implement decryption logic for other algorithms
    }
    // Update the UI to display the result
    setState(() {
      _inputText = result;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Result: $result'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Computer Security Algorithms'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _selectedOperation,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOperation = newValue!;
                });
              },
              items: <String>['Encryption', 'Decryption']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _selectedAlgorithm,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAlgorithm = newValue!;
                });
              },
              items: <String>[
                'Caesar Cipher',
                'Monoalphabetic',
                'Playfair Cipher',
                'Hill Cipher',
                'Rail Fence',
                'One-time Pad'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              onChanged: (text) {
                _inputText = text;
              },
              decoration: InputDecoration(
                labelText: _selectedOperation == 'Encryption'
                    ? 'Enter Plain Text'
                    : 'Enter Encrypted Text',
              ),
            ),
            TextField(
              onChanged: (text) {
                _encryptionKey = text;
              },
              decoration: InputDecoration(
                labelText: _selectedOperation == 'Encryption'
                    ? 'Enter Encryption Key'
                    : 'Enter Decryption Key',
              ),
              enabled: _isEncryptionKeyEnabled(), // Enable/disable based on the selected algorithm
            ),
            ElevatedButton(
              onPressed: _performEncryptionOrDecryption,
              child: Text(_selectedOperation),
            ),
          ],
        ),
      ),
    );
  }
}