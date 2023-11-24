import 'package:flutter/material.dart';
import 'package:group_names/cards.dart';

class NameInputPage extends StatefulWidget {
  const NameInputPage({super.key});

  @override
  State<NameInputPage> createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  TextEditingController _inputName = TextEditingController();

  List<String> namesList = [];
  List<List<String>> dividedLists = [];
  int batchSize = 5;

  void enterToList(String name) {
    if (!namesList.contains(name)) {
      namesList.add(name);
    } else {
      _showTextPopup(name);
    }
  }

  void groupNames() {
    if (namesList.length < 15) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Need to have morethan 15 names'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _inputName.clear();
                },
                child: const Text('Return'),
              ),
            ],
          );
        },
      );
    } else {
      makeFiveGroups();
    }
  }

  void makeFiveGroups() {
    namesList.shuffle();
    int aryLength = namesList.length;

    if (aryLength % 5 != 0 && aryLength % 5 != 4) {
      int remender = aryLength % 5;
      print('remender of if is $remender');

      for (int i = 0; i < namesList.length - remender; i += batchSize) {
        int end = (i + batchSize < namesList.length)
            ? i + batchSize
            : namesList.length;
        List<String> sublist = namesList.sublist(i, end);
        dividedLists.add(List<String>.from(sublist));
      }

      if (remender == 1) {
        dividedLists[0].add(namesList[aryLength - 1]);
      } else if (remender == 2) {
        dividedLists[0].add(namesList[aryLength - 1]);
        dividedLists[1].add(namesList[aryLength - 2]);
      } else if (remender == 3) {
        dividedLists[0].add(namesList[aryLength - 1]);
        dividedLists[1].add(namesList[aryLength - 2]);
        dividedLists[2].add(namesList[aryLength - 3]);
      }
    } else {
      for (int i = 0; i < namesList.length; i += batchSize) {
        int end = (i + batchSize < namesList.length)
            ? i + batchSize
            : namesList.length;
        List<String> sublist = namesList.sublist(i, end);
        dividedLists.add(List<String>.from(sublist));
      }
    }

    for (int i = 0; i < dividedLists.length; i++) {
      print("List ${i + 1}: ${dividedLists[i]}");
    }
  }

  void printSublist(int index) {
    if (dividedLists.length > index) {
      print("Second element from dividedLists: ${dividedLists[index]}");
    }
  }

  void _showTextPopup(String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Entered Name already exist'),
          content: Text(
            name,
            style: const TextStyle(fontSize: 30),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _inputName.clear();
              },
              child: const Text('Return'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Grouping'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _inputName,
                onTap: () {
                  dividedLists = [];
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.create),
                  border: OutlineInputBorder(),
                  hintText: "Enter Name",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.shade300,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    var name = _inputName.text;
                    // _showTextPopup(name);
                    enterToList(name);
                    print(namesList);
                    _inputName.clear();
                    dividedLists = [];
                  },
                  child: const Text('Enter'),
                ),
                const SizedBox(
                  width: 30,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.shade300,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    groupNames();
                  },
                  child: const Text('Group'),
                ),
                const SizedBox(
                  width: 30,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.shade300,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Cards(dividedLists: dividedLists)),
                    );
                  },
                  child: const Text('Go to cards'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
