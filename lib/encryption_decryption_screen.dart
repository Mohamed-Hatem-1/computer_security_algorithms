import 'package:computer_security_algorithms/algorthims/ceasar.dart';
import 'package:computer_security_algorithms/algorthims/mono_alpha_petic.dart';
import 'package:computer_security_algorithms/algorthims/one_time_pad.dart';
import 'package:computer_security_algorithms/algorthims/play_fair.dart';
import 'package:computer_security_algorithms/algorthims/rail_fence.dart';
import 'package:flutter/material.dart';

class EncryptionDecryptionScreen extends StatefulWidget {
  @override
  _EncryptionDecryptionScreenState createState() =>
      _EncryptionDecryptionScreenState();
}

class _EncryptionDecryptionScreenState
    extends State<EncryptionDecryptionScreen> {
  String _selectedOperation = 'Encryption';
  String _selectedAlgorithm = 'Caesar Cipher';
  String _encryptionKey = '';
  String _inputText = '';
  String selectedAlgo = "";

  void _performEncryptionOrDecryption() {
    String result = '';
    if (_selectedOperation == 'Encryption') {
      if (_selectedAlgorithm == 'Caesar Cipher') {
        result = caesarCipherEncrypt(_inputText, int.parse(_encryptionKey));
      } else if (_selectedAlgorithm == 'Monoalphabetic') {
        result = monoalphabeticEncrypt(_inputText, _encryptionKey);
      } else if (_selectedAlgorithm == 'Playfair Cipher') {
        result = playfairEncrypt(_inputText, _encryptionKey);
      } else if (_selectedAlgorithm == "Hill Cipher") {
      } else if (_selectedAlgorithm == "Rail Fence") {
        result = railFenceEncrypt(_inputText,int.parse(_encryptionKey),);
      } else if (_selectedAlgorithm == "One-time Pad") {
        result = oneTimePadEncrypt(_inputText, _encryptionKey);
      }
    } else {
      if (_selectedAlgorithm == 'Caesar Cipher') {
        result = caesarCipherDecrypt(_inputText,int.parse(_encryptionKey));
      } else if (_selectedAlgorithm == 'Monoalphabetic') {
        result = monoalphabeticDecrypt(_inputText, _encryptionKey);
      } else if (_selectedAlgorithm == 'Playfair Cipher') {
        result = playfairDecrypt(_inputText, _encryptionKey);
      } else if (_selectedAlgorithm == "Hill Cipher") {
      } else if (_selectedAlgorithm == "Rail Fence") {
        result = railFenceDecrypt(_inputText,int.parse(_encryptionKey),);
      } else if (_selectedAlgorithm == "One-time Pad") {
        result = oneTimePadDecrypt(_inputText, _encryptionKey);
      }
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_selectedOperation == "Encryption"
              ? "Cipher Text"
              : "Plain Text"),
          content: Text(result),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1C0F13),
                minimumSize: const Size(100, 50),
                shadowColor: const Color(0xff1C0F13),
                elevation: 3,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Cansel",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Computer Security Algorithms",
                    style: TextStyle(
                      color: Color(0xff1C0F13),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xfff5f3f1),
                    ),
                    child: DropdownButton<String>(
                      alignment: Alignment.center,
                      borderRadius: BorderRadius.circular(12),
                      underline: const SizedBox(),
                      dropdownColor: const Color(0xfff5f3f1),
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
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xfff5f3f1),
                    ),
                    child: DropdownButton<String>(
                      underline: const SizedBox(),
                      alignment: Alignment.center,
                      value: _selectedAlgorithm,
                      borderRadius: BorderRadius.circular(12),
                      dropdownColor: const Color(0xfff5f3f1),
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
                          onTap: () {
                            selectedAlgo = value;
                            print(selectedAlgo);
                          },
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  autocorrect: true,
                  onChanged: (text) {
                    _inputText = text;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xfff5f3f1),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    labelText: _selectedOperation == 'Encryption'
                        ? 'Enter Plain Text'
                        : 'Enter Encrypted Text',
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  onChanged: (text) {
                    _encryptionKey = text;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xfff5f3f1),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    labelText: _selectedOperation == 'Encryption'
                        ? selectedAlgo == "Monoalphabetic"
                            ? "Enter Random Key (A-Z)"
                            : selectedAlgo == "Rail Fence"
                                ? "Enter Number Of Rails"
                                : 'Enter Encryption Key'
                        : selectedAlgo == "Monoalphabetic"
                            ? "Enter Random Key (A-Z)"
                            : selectedAlgo == "Rail Fence"
                                ? "Enter Number Of Rails"
                                : 'Enter Decryption Key',
                  ),
                  // Enable/disable based on the selected algorithm
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1C0F13),
                      minimumSize: const Size(150, 55),
                      shadowColor: const Color(0xff1C0F13),
                      elevation: 5,
                    ),
                    onPressed: _performEncryptionOrDecryption,
                    child: Text(
                      _selectedOperation,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
