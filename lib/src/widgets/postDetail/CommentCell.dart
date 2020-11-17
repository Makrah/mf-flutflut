import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/font.dart' as fonts;

class CommentCellWidget extends StatelessWidget {
  const CommentCellWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: colors.commentBg,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  ClipOval(
                    child: CachedNetworkImage(
                      width: 30,
                      height: 30,
                      imageUrl: 'https://picsum.photos/100',
                      placeholder: (BuildContext context, String url) =>
                          SvgPicture.asset(
                              'assets/images/placeholder_user.svg'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Username",
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
              Text(
                '12/12/2020',
                style: TextStyle(
                  fontFamily: fonts.primaryFF,
                  fontSize: 10,
                  fontWeight: fonts.light,
                  color: colors.labelColor,
                ),
              ),
            ],
          ),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.',
            style: TextStyle(
              fontFamily: fonts.primaryFF,
              fontSize: 12,
              fontWeight: fonts.light,
              color: colors.labelColor,
            ),
          ),
        ],
      ),
    );
  }
}
