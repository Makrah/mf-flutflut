import 'package:flutter/material.dart';
import 'package:mappin/main.dart';
import 'package:mappin/src/viewModels/LoginViewModel.dart';
import 'package:mappin/src/widgets/platforms/PlatformButton.dart';

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
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<String>(
                stream: _loginViewModel.tokenUser.stream,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
