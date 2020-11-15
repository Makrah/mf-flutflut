import 'package:flutter/material.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({Key key}) : super(key: key);

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        body: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Hero(
                tag: 'test',
                child: FlatButton(
                  child: const Text('Go back'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: false).pop();
                  },
                ),
              ),
            ]));
  }
}
