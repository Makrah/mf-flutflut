import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';
import 'package:mappin/src/viewModels/PostDetailViewModel.dart';
import 'package:mappin/src/widgets/platforms/PlatformAppBar.dart';
import 'package:mappin/src/widgets/platforms/PlatformProgress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;

import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/constants.dart' as constants;
import 'package:mappin/src/values/font.dart' as fonts;
import 'package:mappin/src/widgets/platforms/PlatformScaffold.dart';
import 'package:mappin/src/widgets/postDetail/PostDetailMain.dart';

class PostDetailArguments {
  PostDetailArguments(this.currentPost);

  final PostDto currentPost;
}

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({Key key}) : super(key: key);

  static const String routeName = '/postDetail';

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final Completer<map.GoogleMapController> _controllerMap =
      Completer<map.GoogleMapController>();
  final PostDetailViewModel _postDetailViewModel = PostDetailViewModel();

  static const map.CameraPosition _kGooglePlex = map.CameraPosition(
    target: map.LatLng(43.240644, 5.406952),
    zoom: 8,
  );
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => onWidgetBuild());
  }

  void onWidgetBuild() {
    final PostDetailArguments args =
        ModalRoute.of(context).settings.arguments as PostDetailArguments;
    _postDetailViewModel.getPost(args.currentPost);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBarTitle: StreamBuilder<PostDto>(
        stream: _postDetailViewModel.currentPost.stream,
        builder: (BuildContext context, AsyncSnapshot<PostDto> snapshot) {
          return Text(
            snapshot.hasData ? snapshot.data.title : '-',
            style: TextStyle(
              fontFamily: fonts.primaryFF,
              color: colors.labelColor,
              fontWeight: fonts.bold,
              fontSize: 18,
            ),
          );
        }
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: PostDetailMain(
          kGooglePlex: _kGooglePlex,
          controllerMap: _controllerMap,
          postDetailViewModel: _postDetailViewModel,
        ),
      ),
    );
  }
}
