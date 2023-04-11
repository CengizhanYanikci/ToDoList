import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData.light(),
      home: MyHomePage(title: 'To Do List'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  Map<String, bool> _textMap = {};

  void _addText(String text) {
    setState(() {
      _textMap[text] = false;
    });
    _textController.clear();
  }

  void _removeText(String text) {
    setState(() {
      _textMap.remove(text);
    });
  }

  void _toggleCheck(String text) {
    setState(() {
      _textMap[text] = !_textMap[text]!;
    });
  }

  void _handleAddButton() {
    if (_textController.text.isNotEmpty) {
      _addText(_textController.text);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Boş bırakılamaz'),
            content: Text('Bir kaç kelime giriniz'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Color.fromARGB(255, 82, 223, 248),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Bir kaç kelime yazınız',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _textMap.length,
              itemBuilder: (context, index) {
                final String text = _textMap.keys.elementAt(index);
                final bool isChecked = _textMap.values.elementAt(index);
                return ListTile(
                  title: Text(
                    text,
                    style: TextStyle(
                      color: isChecked ? Colors.green : Colors.white,
                    ),
                  ),
                  tileColor: isChecked
                      ? Colors.transparent
                      : Color.fromARGB(255, 216, 122, 122),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeText(text);
                        },
                      ),
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          _toggleCheck(text);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _handleAddButton();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
