import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mappin/main.dart';
import 'package:mappin/src/viewModels/LoginViewModel.dart';
import 'package:mappin/src/widgets/platforms/PlatformButton.dart';
import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/enums.dart';
import 'package:mappin/src/values/font.dart' as fonts;

import '../values/font.dart';
import '../widgets/platforms/PlatformScaffold.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  static const String routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LoginViewModel _loginViewModel = getIt.get<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: HeaderProfil(),
            ),
            StreamBuilder<String>(
                stream: _loginViewModel.tokenUser.stream,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return Text('Token user ---> ${snapshot.data}');
                }),
            PlatformButton(
              child: const Text('Logout'),
              onPress: () {
                _loginViewModel.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderProfil extends StatelessWidget {
  const HeaderProfil({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  onPressed: () {})
            ],
          ),
          Row(
            children: <Widget>[
              ClipOval(
                child: CachedNetworkImage(
                  width: 55,
                  height: 55,
                  imageUrl: 'https://picsum.photos/100',
                  placeholder: (BuildContext context, String url) =>
                      SvgPicture.asset('assets/images/placeholder_user.svg'),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Username",
                      style: const TextStyle(
                        fontFamily: fonts.primaryFF,
                        fontSize: 16,
                        fontWeight: fonts.light,
                        color: colors.labelColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
