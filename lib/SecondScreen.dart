import 'package:flutter/material.dart';

class TodoItem {
  String text;
  bool isChecked;

  TodoItem({this.text, this.isChecked});
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<TodoItem> items = [];
  String newItem = "";
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SecondScreen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _controller,
                        onChanged: (value) {
                          newItem = value;
                        },
                      ),
                      FlatButton(
                          onPressed: () {
                            String tmpText = newItem;
                            _controller.text = "";
                            setState(() {
                              items.add(
                                  TodoItem(text: tmpText, isChecked: false));
                              newItem = "";
                            });
                            Navigator.pop(context);
                          },
                          child: Text("Add"))
                    ],
                  ),
                )),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Text("Nb items: ${items.length}"),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Checkbox(
                      value: items[index].isChecked,
                      onChanged: (newValue) {
                        setState(() {
                          items[index].isChecked = !items[index].isChecked;
                        });
                      },
                    ),
                    GestureDetector(
                      onLongPressEnd: (details) {
                        setState(() {
                          items.removeAt(index);
                        });
                      },
                      child: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "${items[index].text}",
                            style: TextStyle(
                                foreground: Paint()
                                  ..style = items[index].isChecked
                                      ? PaintingStyle.stroke
                                      : PaintingStyle.fill
                                  ..strokeWidth = 1
                                  ..color = Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }
}
