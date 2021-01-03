import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' as map;
import 'package:mappin/src/api/Dto/CommentDto.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';
import 'package:mappin/src/viewModels/PostDetailViewModel.dart';
import 'package:mappin/src/widgets/platforms/PlatformProgress.dart';
import 'package:mappin/src/widgets/postDetail/CommentCell.dart';
import 'package:mappin/src/widgets/postDetail/DetailPostDescription.dart';
import 'package:mappin/src/widgets/postDetail/DetailPostMap.dart';
import 'package:mappin/src/widgets/postDetail/PostDetailAuthorInfo.dart';

import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/font.dart' as fonts;

class PostDetailMain extends StatelessWidget {
  const PostDetailMain({
    Key key,
    @required Completer<map.GoogleMapController> controllerMap,
    @required PostDetailViewModel postDetailViewModel,
  }) : _controllerMap = controllerMap,
        _postDetailViewModel = postDetailViewModel,
        super(key: key);

  final Completer<map.GoogleMapController> _controllerMap;
  final PostDetailViewModel _postDetailViewModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PostDto>(
        stream: _postDetailViewModel.currentPost.stream,
        builder:
            (BuildContext context, AsyncSnapshot<PostDto> currentPostSnap) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: PostDetailAuthorInfo(
                        currentPost: currentPostSnap.data,
                      ),
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Hero(
                        tag: 'img_selected',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                            imageUrl: currentPostSnap.data.image,
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
                    Container(
                      height: 180,
                      width: double.infinity,
                      child: StreamBuilder<PostDetailDto>(
                        stream: _postDetailViewModel.post.stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<PostDetailDto> snapshot) {
                          return Row(
                            children: <Widget>[
                              Expanded(
                                child: DetailPostDescription(
                                  currentPost: snapshot.data,
                                ),
                              ),
                              Expanded(
                                child: DetailPostMap(
                                  controllerMap: _controllerMap,
                                  currentPost: currentPostSnap.data,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text(
                        'Comments',
                        style: TextStyle(
                          fontFamily: fonts.primaryFF,
                          color: colors.labelColor,
                          fontWeight: fonts.medium,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<List<CommentDto>>(
                  stream: _postDetailViewModel.comments,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<CommentDto>> snap) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return CommentCellWidget(comment: snap.data[index]);
                      }, childCount: snap.data.length),
                    );
                  }),
            ],
          );
        });
  }
}
