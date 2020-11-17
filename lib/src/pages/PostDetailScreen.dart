import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mappin/src/viewModels/PostDetailViewModel.dart';
import 'package:mappin/src/widgets/platforms/PlatformAppBar.dart';
import 'package:mappin/src/widgets/platforms/PlatformProgress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;

import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/constants.dart' as constants;
import 'package:mappin/src/values/font.dart' as fonts;
import 'package:mappin/src/widgets/platforms/PlatformScaffold.dart';

class PostDetailArguments {
  PostDetailArguments(this.postId);

  final String postId;
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
    _postDetailViewModel.getPost(args.postId);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBarTitle: Text(
        'Title',
        style: TextStyle(
          fontFamily: fonts.primaryFF,
          color: colors.labelColor,
          fontWeight: fonts.bold,
          fontSize: 18,
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: PostDetailAuthorInfo(),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 10),
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
                  Container(
                    height: 180,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: DetailPostDescription(),
                        ),
                        Expanded(
                          child: DetailPostMap(
                              kGooglePlex: _kGooglePlex,
                              controllerMap: _controllerMap),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
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
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  CommentCellWidget(),
                  CommentCellWidget(),
                  CommentCellWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostDetailAuthorInfo extends StatelessWidget {
  const PostDetailAuthorInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    SvgPicture.asset('assets/images/placeholder_user.svg'),
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
                    color: colors.labelColor),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset('assets/images/icon_like.svg'),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 20),
              child: Text(
                '42',
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
                '42',
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

class DetailPostDescription extends StatelessWidget {
  const DetailPostDescription({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: double.infinity,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colors.accentColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Posted on',
              style: TextStyle(
                fontFamily: fonts.primaryFF,
                color: colors.labelColor,
                fontWeight: fonts.medium,
                fontSize: 14,
              ),
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.',
              style: TextStyle(
                fontFamily: fonts.primaryFF,
                color: colors.labelColor,
                fontWeight: fonts.light,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPostMap extends StatelessWidget {
  const DetailPostMap({
    Key key,
    @required map.CameraPosition kGooglePlex,
    @required Completer<map.GoogleMapController> controllerMap,
  })  : _kGooglePlex = kGooglePlex,
        _controllerMap = controllerMap,
        super(key: key);

  final map.CameraPosition _kGooglePlex;
  final Completer<map.GoogleMapController> _controllerMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.only(left: 5),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colors.accentColor,
      ),
      child: map.GoogleMap(
        mapType: map.MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        // markers: _markers,
        onMapCreated: (map.GoogleMapController controller) {
          _controllerMap.complete(controller);
        },
      ),
    );
  }
}

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
                          color: colors.labelColor),
                    ),
                  ),
                ],
              ),
              Text('12/12/2020'),
            ],
          ),
          Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.'),
        ],
      ),
    );
  }
}
