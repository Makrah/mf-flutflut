import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mappin/src/widgets/platforms/PlatformTextField.dart';

class LoginTextFieldWidget extends StatelessWidget {
  const LoginTextFieldWidget({
    Key key,
    @required TextEditingController controllerUsername,
    @required String placeholder,
    @required String svgPath,
  })  : _controllerUsername = controllerUsername,
        _placeholder = placeholder,
        _svgPath = svgPath,
        super(key: key);

  final TextEditingController _controllerUsername;
  final String _placeholder;
  final String _svgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          SvgPicture.asset(_svgPath),
          SizedBox(width: 20),
          Expanded(
            child: PlatformTextField(
              placeholder: _placeholder,
              controller: _controllerUsername,
            ),
          ),
        ],
      ),
    );
  }
}
