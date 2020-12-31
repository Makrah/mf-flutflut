import 'dart:typed_data';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mappin/main.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';
import 'package:mappin/src/widgets/DisposableWidget.dart';
import 'package:mappin/src/viewModels/LoginViewModel.dart';
import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/enums.dart';
import 'package:mappin/src/viewModels/ProfileViewModel.dart';
import 'package:mappin/src/values/font.dart' as fonts;
import 'dart:convert';
import 'dart:io' as Io;
import '../widgets/platforms/PlatformScaffold.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  static const String routeName = '/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin, DisposableWidget {
  final LoginViewModel _loginViewModel = getIt.get<LoginViewModel>();
  final ProfileViewModel _profileViewModel = getIt.get<ProfileViewModel>();
  AnimationController _controllerLottie;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controllerLottie = AnimationController(vsync: this);
    _profileViewModel.isLoadingFunc(true);
    SchedulerBinding.instance.addPostFrameCallback((_) => onWidgetBuild());
  }

  Future getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 40);
    setState(() {
      if (pickedFile != null) {
        final bytes = Io.File(pickedFile.path).readAsBytesSync();
        var base64 = base64Encode(bytes);
        _profileViewModel.updateProfile(base64);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        body: Container(
            child: StreamBuilder<String>(
                stream: _profileViewModel.userImage.stream,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  // ignore: unrelated_type_equality_checks
                  return snapshot.data == true
                      ? Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Lottie.asset(
                              'assets/animations/focus_animation.json',
                              controller: _controllerLottie,
                              onLoaded: (LottieComposition composition) {
                                _controllerLottie.duration =
                                    composition.duration;
                                _controllerLottie.addStatusListener(
                                    (AnimationStatus status) {
                                  if (status == AnimationStatus.completed) {
                                    _controllerLottie.reset();
                                  }
                                });
                              },
                            ),
                          ),
                        )
                      : Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 40),
                              child: HeaderProfilBis(
                                loginViewModel: _loginViewModel,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: Row(
                                children: <Widget>[
                                  StreamBuilder<String>(
                                      stream:
                                          _profileViewModel.userImage.stream,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        return snapshot.data == null
                                            ? CircularProfileAvatar(
                                                null,
                                                child: SvgPicture.asset(
                                                    'assets/images/placeholder_user.svg'),
                                                radius: 28,
                                                backgroundColor:
                                                    Colors.transparent,
                                                cacheImage: true,
                                                onTap: () {
                                                  getImage();
                                                },
                                                showInitialTextAbovePicture:
                                                    true,
                                              )
                                            : CircularProfileAvatar(
                                                snapshot.data,
                                                radius: 28,
                                                backgroundColor:
                                                    Colors.transparent,
                                                cacheImage: true,
                                                onTap: () {
                                                  getImage();
                                                },
                                                showInitialTextAbovePicture:
                                                    true,
                                              );
                                      }),
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 25),
                                        child: StreamBuilder<String>(
                                            stream: _profileViewModel
                                                .userName.stream,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String>
                                                    snapshot) {
                                              return Text(snapshot.data,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          fonts.primaryFF,
                                                      fontSize: 19,
                                                      fontWeight: fonts.light,
                                                      color:
                                                          colors.labelColor));
                                            }),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            TablayoutProfile(
                              profileViewModel: _profileViewModel,
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: StreamBuilder<List<PostDto>>(
                                      stream:
                                          _profileViewModel.userPosts.stream,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<PostDto>>
                                              snapshot) {
                                        return StaggeredGridView.countBuilder(
                                            crossAxisCount: 4,
                                            itemCount: snapshot.data.length,
                                            staggeredTileBuilder: (int index) =>
                                                StaggeredTile.extent(2,
                                                    index.isEven ? 210 : 240),
                                            mainAxisSpacing: 10.0,
                                            crossAxisSpacing: 10.0,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                ProfileContainerPicture(
                                                  index: index,
                                                  posts: snapshot.data,
                                                ));
                                      }),
                                ))
                          ],
                        );
                })));
  }

  void onWidgetBuild() {
    _profileViewModel.getUserMe();
    _profileViewModel.profilState.stream.listen((ProfileState event) {
      switch (event) {
        case ProfileState.success:
          break;
        case ProfileState.error:
          showError(this.context, 'Invalid credentials');
          break;
        default:
      }
    }).canceledBy(this);
  }

  void showError(BuildContext context, String description) {
    EdgeAlert.show(
      context,
      title: 'Error',
      description: description,
      gravity: EdgeAlert.TOP,
      backgroundColor: colors.alerterErrorColor,
    );
  }
}

class ProfileContainerPicture extends StatelessWidget {
  final int index;
  final List<PostDto> posts;
  const ProfileContainerPicture({Key key, this.index, this.posts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        decoration: const BoxDecoration(
            color: colors.commentBg,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
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
            children: [
              Text(
                posts[index].title,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
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

class HeaderProfilBis extends StatefulWidget {
  final LoginViewModel loginViewModel;
  const HeaderProfilBis({Key key, this.loginViewModel}) : super(key: key);

  @override
  _HeaderProfilBisState createState() => _HeaderProfilBisState();
}

class _HeaderProfilBisState extends State<HeaderProfilBis> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: fonts.primaryFF,
                    color: colors.labelColor,
                    fontWeight: fonts.black,
                    fontSize: 44,
                  ),
                ),
                IconButton(
                    icon: SvgPicture.asset('assets/images/icon_logout.svg'),
                    iconSize: 50,
                    onPressed: () {
                      widget.loginViewModel.logout();
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TablayoutProfile extends StatefulWidget {
  final ProfileViewModel profileViewModel;
  TablayoutProfile({
    Key key,
    this.profileViewModel,
  }) : super(key: key);

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
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
