import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mappin/main.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';
import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/enums.dart';
import 'package:mappin/src/values/font.dart' as fonts;
import 'package:mappin/src/viewModels/LoginViewModel.dart';
import 'package:mappin/src/viewModels/ProfileViewModel.dart';
import 'package:mappin/src/widgets/DisposableWidget.dart';
import 'package:mappin/src/widgets/profile/ProfileContainerPicture.dart';
import 'package:mappin/src/widgets/profile/TablayoutProfile.dart';

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
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controllerLottie = AnimationController(vsync: this);
    _profileViewModel.isLoadingFunc(true);
    SchedulerBinding.instance.addPostFrameCallback((_) => onWidgetBuild());
  }

  Future<void> getImage() async {
    final PickedFile pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 40);
    setState(() {
      if (pickedFile != null) {
        final Uint8List bytes = io.File(pickedFile.path).readAsBytesSync();
        final String base64 = base64Encode(bytes);
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
                                    children: <Widget>[
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
                                  padding: const EdgeInsets.only(
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
          showError(context, 'Invalid credentials');
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

class HeaderProfilBis extends StatefulWidget {
  const HeaderProfilBis({Key key, this.loginViewModel}) : super(key: key);
  final LoginViewModel loginViewModel;

  @override
  _HeaderProfilBisState createState() => _HeaderProfilBisState();
}

class _HeaderProfilBisState extends State<HeaderProfilBis> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: fonts.primaryFF,
                    color: colors.labelColor,
                    fontWeight: fonts.black,
                    fontSize: 44,
                  ),
                ),
                GestureDetector(
                  child: SvgPicture.asset('assets/images/icon_logout.svg'),
                  onTap: () {
                    widget.loginViewModel.logout();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
