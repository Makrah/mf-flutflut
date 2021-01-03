import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mappin/src/viewModels/ProfileViewModel.dart';
import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/font.dart' as fonts;

class TablayoutProfile extends StatefulWidget {
  const TablayoutProfile({
    Key key,
    this.profileViewModel,
  }) : super(key: key);
  final ProfileViewModel profileViewModel;

  @override
  _TablayoutProfileState createState() => _TablayoutProfileState();
}

class _TablayoutProfileState extends State<TablayoutProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Expanded(
            flex: 1,
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                      elevation: 0,
                      hoverElevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: widget.profileViewModel.step == 0
                          ? colors.yellowColor
                          : colors.backgroundColor,
                      onPressed: () {
                        setState(() {
                          widget.profileViewModel.setupRecent();
                        });
                      },
                      child: const Text(
                        'Recent',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontFamily: fonts.primaryFF,
                        ),
                      )),
                  RaisedButton(
                      elevation: 0,
                      hoverElevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: widget.profileViewModel.step == 1
                          ? colors.yellowColor
                          : colors.backgroundColor,
                      onPressed: () {
                        setState(() {
                          widget.profileViewModel.setupLikes();
                        });
                      },
                      child: const Text('Likes',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontFamily: fonts.primaryFF,
                          ))),
                  RaisedButton(
                      elevation: 0,
                      hoverElevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: widget.profileViewModel.step == 2
                          ? colors.yellowColor
                          : colors.backgroundColor,
                      onPressed: () {
                        setState(() {
                          widget.profileViewModel.setupComments();
                        });
                      },
                      child: const Text('Comments',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontFamily: fonts.primaryFF,
                          ))),
                ],
              ),
            ]),
          )),
    );
  }
}
