import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mappin/src/widgets/platforms/PlatformProgress.dart';

import 'package:mappin/src/values/colors.dart' as colors;

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({Key key}) : super(key: key);

  static const String routeName = '/postDetail';

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        body: Column(
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
              Container(
                height: 200,
                width: double.infinity,
                child: Hero(
                  tag: 'img_selected',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                      imageUrl: "https://picsum.photos/2000",
                      placeholder: (BuildContext context, String url) =>
                          Container(
                        color: colors.backgroundColorDark,
                        child: PlatformProgress(
                          isAnimating: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]));
  }
}
