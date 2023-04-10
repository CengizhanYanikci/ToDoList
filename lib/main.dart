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
  List<String> _textList = [];
  List<bool> _checkList = [];

  void _addText(String text) {
    setState(() {
      _textList.add(text);
      _checkList.add(false);
    });
    _textController.clear();
  }

  void _removeText(int index) {
    setState(() {
      _textList.removeAt(index);
      _checkList.removeAt(index);
    });
  }

  void _toggleCheck(int index) {
    setState(() {
      _checkList[index] = !_checkList[index];
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
              itemCount: _textList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _textList[index],
                    style: TextStyle(
                      color: _checkList[index] ? Colors.green : Colors.white,
                    ),
                  ),
                  tileColor: _checkList[index] ? Colors.transparent : Color.fromARGB(255, 216, 122, 122), // Check yapılmadıysa kırmızı arkaplan
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeText(index);
                        },
                      ),
                      Checkbox(
                        value: _checkList[index],
                        onChanged: (value) {
                          _toggleCheck(index);
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