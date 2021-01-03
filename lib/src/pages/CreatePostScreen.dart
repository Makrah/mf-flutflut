import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';
import 'dart:ui';

import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mappin/main.dart';
import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/enums.dart';
import 'package:mappin/src/values/font.dart' as fonts;
import 'package:mappin/src/viewModels/LoginViewModel.dart';
import 'package:mappin/src/viewModels/ProfileViewModel.dart';
import 'package:mappin/src/widgets/DisposableWidget.dart';
import 'package:mappin/src/widgets/CreatePostTextFieldWidget.dart';
import 'package:geolocator/geolocator.dart';

import 'package:mappin/src/widgets/platforms/PlatformButton.dart';
import '../widgets/platforms/PlatformScaffold.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key key}) : super(key: key);

  static const String routeName = '/createPost';

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen>
    with DisposableWidget {
  final LoginViewModel _loginViewModel = getIt.get<LoginViewModel>();
  final TextEditingController _controllerLatitude = TextEditingController();
  final TextEditingController _controllerLongitude = TextEditingController();
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final ProfileViewModel _profileViewModel = getIt.get<ProfileViewModel>();
  final ImagePicker picker = ImagePicker();

  String base64 = '';

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => onWidgetBuild());
  }

  void onWidgetBuild() {
    _profileViewModel.profilState.stream.listen((ProfileState event) {
      switch (event) {
        case ProfileState.success:
          EdgeAlert.show(
            context,
            title: 'Success',
            description: 'Post uploaded',
            gravity: EdgeAlert.TOP,
            backgroundColor: colors.alerterSuccessColor,
          );
          break;
        case ProfileState.error:
          EdgeAlert.show(
            context,
            title: 'Erreur',
            description: 'Invalid credentials',
            gravity: EdgeAlert.TOP,
            backgroundColor: colors.alerterErrorColor,
          );
          break;
        case ProfileState.noInternet:
          EdgeAlert.show(
            context,
            title: 'Erreur',
            description: 'No internet connection',
            gravity: EdgeAlert.TOP,
            backgroundColor: colors.alerterErrorColor,
          );
          break;
        default:
      }
    }).canceledBy(this);
  }

  Future<void> getImage() async {
    try {
      final PickedFile pickedFile =
          await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
      setState(() {
        if (pickedFile != null) {
          final Uint8List bytes = io.File(pickedFile.path).readAsBytesSync();
          base64 = base64Encode(bytes);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: always_declare_return_types
    imageSelectorGallery() async {
      // ignore: deprecated_member_use
      final io.File galleryFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );
      base64 = base64Encode(galleryFile.readAsBytesSync());
      setState(() {});
    }

    return PlatformScaffold(
        body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(children: <Widget>[
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 40),
                        child: HeaderProfilBis(
                          loginViewModel: _loginViewModel,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        width: double.infinity,
                        child: PlatformButton(
                          color: colors.primaryTransparentColor,
                          height: 60,
                          borderRadius: 12,
                          child: const Text(
                            'Take picture',
                            style: TextStyle(
                              fontFamily: fonts.primaryFF,
                              color: colors.labelColor,
                              fontWeight: fonts.bold,
                              fontSize: 16,
                            ),
                          ),
                          onPress: () {
                            imageSelectorGallery();
                          },
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          child: PlatformButton(
                              color: colors.primaryTransparentColor,
                              height: 60,
                              borderRadius: 12,
                              child: const Text(
                                'Get my location',
                                style: TextStyle(
                                  fontFamily: fonts.primaryFF,
                                  color: colors.labelColor,
                                  fontWeight: fonts.bold,
                                  fontSize: 16,
                                ),
                              ),
                              onPress: () async {
                                await getCurrentLocation();
                              })),
                      Hero(
                          tag: 'tfLatitude',
                          child: Material(
                            type: MaterialType.transparency,
                            child: CreatePostTextFieldWidget(
                              controllerText: _controllerLatitude,
                              placeholder: 'Latitude',
                            ),
                          )),
                      Hero(
                          tag: 'tfLongitude',
                          child: Material(
                            type: MaterialType.transparency,
                            child: CreatePostTextFieldWidget(
                              controllerText: _controllerLongitude,
                              placeholder: 'Longitude',
                            ),
                          )),
                      Hero(
                        tag: 'tfTitle',
                        child: Material(
                          type: MaterialType.transparency,
                          child: CreatePostTextFieldWidget(
                            controllerText: _controllerTitle,
                            placeholder: 'Title',
                          ),
                        ),
                      ),
                      Hero(
                        tag: 'tfDescription',
                        child: Material(
                          type: MaterialType.transparency,
                          child: CreatePostTextFieldWidget(
                            controllerText: _controllerDescription,
                            placeholder: 'Description',
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        width: double.infinity,
                        child: PlatformButton(
                          color: colors.primaryTransparentColor,
                          height: 60,
                          borderRadius: 12,
                          child: const Text(
                            'Post it !',
                            style: TextStyle(
                              fontFamily: fonts.primaryFF,
                              color: colors.labelColor,
                              fontWeight: fonts.bold,
                              fontSize: 16,
                            ),
                          ),
                          onPress: () {
                            setState(() {});
                            if (base64 == '' || base64 == null) {
                              EdgeAlert.show(
                                context,
                                title: 'Error',
                                description: 'No image selected',
                                gravity: EdgeAlert.TOP,
                                backgroundColor: colors.alerterErrorColor,
                              );
                            } else
                              _profileViewModel.createPost(
                                  _controllerLatitude.text,
                                  _controllerLongitude.text,
                                  _controllerTitle.text,
                                  _controllerDescription.text,
                                  base64);
                          },
                        ),
                      ),
                    ])))));
  }

  Future<void> getCurrentLocation() async {
    print('cposition');
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _controllerLatitude.text = position.latitude.toString();
    _controllerLongitude.text = position.longitude.toString();
    print(position);
    setState(() {});
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
              children: const <Widget>[
                Text(
                  'Post',
                  style: TextStyle(
                    fontFamily: fonts.primaryFF,
                    color: colors.labelColor,
                    fontWeight: fonts.black,
                    fontSize: 44,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
