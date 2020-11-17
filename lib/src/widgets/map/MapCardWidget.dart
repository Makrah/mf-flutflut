import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';
import 'package:mappin/src/pages/PostDetailScreen.dart';
import 'package:mappin/src/viewModels/MapViewModel.dart';

import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/font.dart' as fonts;
import 'package:mappin/src/widgets/platforms/PlatformProgress.dart';
import 'package:mappin/src/values/constants.dart' as constants;

class MapCardWidget extends StatefulWidget {
  const MapCardWidget({
    Key key,
    @required MapViewModel mapViewModel,
    @required PostDto currentPost,
  })  : _mapViewModel = mapViewModel,
        _currentPost = currentPost,
        super(key: key);

  final MapViewModel _mapViewModel;
  final PostDto _currentPost;

  @override
  _MapCardWidgetState createState() => _MapCardWidgetState();
}

class _MapCardWidgetState extends State<MapCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: false).pushNamed(
          PostDetailScreen.routeName,
          arguments: PostDetailArguments(widget._currentPost),
        );
      },
      child: Stack(
        children: <Widget>[
          AnimatedOpacity(
            opacity: 0.8,
            duration: const Duration(milliseconds: 500),
            child: Hero(
              tag: 'img_selected',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                  imageUrl: "https://picsum.photos/2000",
                  placeholder: (BuildContext context, String url) => Container(
                    color: colors.backgroundColorDark,
                    child: PlatformProgress(
                      isAnimating: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 30,
            ),
            height: 200,
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipOval(
                      child: CachedNetworkImage(
                        width: 30,
                        height: 30,
                        fit: BoxFit.fill,
                        imageUrl:
                            '${constants.baseUrl}${widget._currentPost.user.image}',
                        placeholder: (BuildContext context, String url) =>
                            SvgPicture.asset(
                                'assets/images/placeholder_user.svg'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget._currentPost.user.username,
                        style: const TextStyle(
                            fontFamily: fonts.primaryFF,
                            fontSize: 14,
                            fontWeight: fonts.light,
                            color: colors.labelColor),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      widget._mapViewModel.currentPost.add(null);
                    },
                    child: SvgPicture.asset('assets/images/icon_close.svg'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget._currentPost.title,
                        style: const TextStyle(
                          fontFamily: fonts.primaryFF,
                          fontWeight: fonts.bold,
                          fontSize: 22,
                          color: colors.labelColor,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/icon_like.svg'),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 20),
                            child: Text(
                              '${widget._currentPost.likes.length}',
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
                              '${widget._currentPost.comments.length}',
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
