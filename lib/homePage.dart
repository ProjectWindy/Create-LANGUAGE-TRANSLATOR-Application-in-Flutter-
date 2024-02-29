import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var languages = ['Hindi', 'English', 'Marathi', 'Vietnamese', 'Japanese'];
  var originLanguage = 'From';
  var destinationLanguage = 'To';
  var output = '';
  var output1 = '';

  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });

    if (src == '--' || dest == '--') {
      setState(() {
        output = ' Fail to translate';
      });
    }
  }

  void reverseTranslate(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: dest, to: src);
    setState(() {
      output1 = translation.text.toString();
    });
  }

  String getLanguageCode(String language) {
    if (language == 'English') {
      return 'en';
    } else if (language == 'Hindi') {
      return 'hi';
    } else if (language == 'Marathi') {
      return 'mr';
    } else if (language == 'Vietnamese') {
      return 'vi';
    } else if (language == 'Japanese') {
      return 'ja';
    }
    return '--';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10223d),
      appBar: AppBar(
        title: Text('Language Translator'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originLanguage,
                      style: const TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLanguage = value!;
                        print(originLanguage);
                      });
                    }),
                SizedBox(
                  width: 40,
                ),
                Icon(
                  Icons.arrow_right_alt_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(
                  width: 40,
                ),
                DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage,
                      style: const TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                cursorColor: Colors.white,
                autofocus: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Please enter your text...",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  errorStyle: TextStyle(color: Colors.white, fontSize: 15),
                ),
                controller: languageController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Text to Translate';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: Colors.lightBlueAccent),
                onPressed: () {
                  translate(
                      getLanguageCode(originLanguage),
                      getLanguageCode(destinationLanguage),
                      languageController.text.toString());
                  print(output);
                },
                child: Text('Translate'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: Colors.lightBlueAccent),
                onPressed: () {
                  reverseTranslate(
                      getLanguageCode(originLanguage),
                      getLanguageCode(destinationLanguage),
                      languageController.text.toString());
                  print(output);
                },
                child: Text('reverseTranslate'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '\n$output',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Text(
              '\n$output1',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
