import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';

import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/font.dart' as fonts;

class PostDetailAuthorInfo extends StatelessWidget {
  const PostDetailAuthorInfo({
    Key key,
    @required PostDto currentPost,
  }) : _currentPost = currentPost, super(key: key);

  final PostDto _currentPost;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipOval(
              child: CachedNetworkImage(
                width: 30,
                height: 30,
                imageUrl: _currentPost.user.image,
                placeholder: (BuildContext context, String url) =>
                    SvgPicture.asset('assets/images/placeholder_user.svg'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                _currentPost == null ? '-' : _currentPost.user.username,
                style: const TextStyle(
                    fontFamily: fonts.primaryFF,
                    fontSize: 14,
                    fontWeight: fonts.light,
                    color: colors.labelColor),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            SvgPicture.asset('assets/images/icon_like.svg'),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 20),
              child: Text(
                _currentPost == null ? '-' : '${_currentPost.likes.length}',
                style: const TextStyle(
                  fontFamily: fonts.primaryFF,
                  fontSize: 14,
                  fontWeight: fonts.light,
                  color: colors.labelColor,
                ),
              ),
            ),
            SvgPicture.asset('assets/images/icon_comment.svg'),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                _currentPost == null ? '-' : '${_currentPost.comments.length}',
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
    );
  }
}