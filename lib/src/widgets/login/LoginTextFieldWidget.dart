import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mappin/src/widgets/platforms/PlatformTextField.dart';

class LoginTextFieldWidget extends StatelessWidget {
  const LoginTextFieldWidget({
    Key key,
    @required TextEditingController controllerUsername,
    @required String placeholder,
    @required String svgPath,
    @required bool isPassword,
  })  : _controllerUsername = controllerUsername,
        _placeholder = placeholder,
        _svgPath = svgPath,
        _isPassword = isPassword,
        super(key: key);

  final TextEditingController _controllerUsername;
  final String _placeholder;
  final String _svgPath;
  final bool _isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(_svgPath),
          const SizedBox(width: 20),
          Expanded(
            child: PlatformTextField(
              placeholder: _placeholder,
              controller: _controllerUsername,
              isPassword: _isPassword,
            ),
          ),
        ],
      ),
    );
  }
}
