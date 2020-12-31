import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';
import 'package:mappin/src/values/colors.dart' as colors;

class ProfileContainerPicture extends StatelessWidget {
  const ProfileContainerPicture({Key key, this.index, this.posts})
      : super(key: key);
  final int index;
  final List<PostDto> posts;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        decoration: const BoxDecoration(
            color: colors.commentBg,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Expanded(
                child: FadeInImage.memoryNetwork(
              height: index.isEven ? 150 : 180,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: kTransparentImage,
              image: posts[index].image,
            )),
          ),
          Row(
            children: <Widget>[
              Text(
                posts[index].title,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SvgPicture.asset('assets/images/icon_like.svg'),
              const SizedBox(width: 7),
              Text(
                posts[index].likes.length.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 7),
              SvgPicture.asset('assets/images/icon_comment.svg'),
              const SizedBox(width: 7),
              Text(
                posts[index].comments.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          )
        ]));
  }
}

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);
