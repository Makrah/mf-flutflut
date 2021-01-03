import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mappin/src/api/Dto/CommentDto.dart';

import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/font.dart' as fonts;

class CommentCellWidget extends StatelessWidget {
  const CommentCellWidget({
    Key key,
    @required CommentDto comment,
  })  : _comment = comment,
        super(key: key);
  final CommentDto _comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: colors.commentBg,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipOval(
                    child: CachedNetworkImage(
                      width: 30,
                      height: 30,
                      imageUrl: _comment.user.image,
                      placeholder: (BuildContext context, String url) =>
                          SvgPicture.asset(
                              'assets/images/placeholder_user.svg'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      _comment.user.username,
                      style: const TextStyle(
                        fontFamily: fonts.primaryFF,
                        fontSize: 14,
                        fontWeight: fonts.light,
                        color: colors.labelColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Text(
              _comment.content,
              style: const TextStyle(
                fontFamily: fonts.primaryFF,
                fontSize: 12,
                fontWeight: fonts.light,
                color: colors.labelColor,
              ),
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
    );
  }
}
