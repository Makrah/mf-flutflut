import 'package:flutter/cupertino.dart';
import 'package:mappin/src/widgets/platforms/PlatformTextField.dart';

class CreatePostTextFieldWidget extends StatelessWidget {
  const CreatePostTextFieldWidget({
    Key key,
    @required TextEditingController controllerText,
    @required String placeholder,
  })  : _controllerText = controllerText,
        _placeholder = placeholder,
        super(key: key);

  final TextEditingController _controllerText;
  final String _placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 20),
          Expanded(
            child: PlatformTextField(
                placeholder: _placeholder,
                controller: _controllerText,
                isPassword: false),
          ),
        ],
      ),
    );
  }
}
