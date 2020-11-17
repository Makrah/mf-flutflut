import 'package:dio/dio.dart';
import 'package:mappin/src/api/ApiService.dart';
import 'package:mappin/src/api/Dto/LoginDto.dart';
import 'package:mappin/src/services/LocalStorageService.dart';
import 'package:mappin/src/values/enums.dart';
import 'package:rxdart/rxdart.dart';

class SignupViewModel {
  final ApiService apiService = ApiService();

  PublishSubject<SignupState> signupState = PublishSubject<SignupState>();
  BehaviorSubject<bool> isLoading =
      BehaviorSubject<bool>.seeded(false, sync: true);

  bool validatePassword(String value) {
    const String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool isInfoValid(String username, String password, String confirmPassword) {
    if (username.trimLeft().length < 3) {
      signupState.add(SignupState.invalidUsername);
      return false;
    }
    if (!validatePassword(password)) {
      signupState.add(SignupState.invalidPassword);
      return false;
    }
    if (password != confirmPassword) {
      signupState.add(SignupState.passwordsDontMatch);
      return false;
    }
    return true;
  }

  Future<void> signup(
      String username, String password, String confirmPassword) async {
    if (!isInfoValid(username, password, confirmPassword)) {
      return;
    }
    isLoading.add(true);
    try {
      final LoginResponseDto resp =
          await apiService.signup(LoginDto(username, password));
      print(resp.token);
      await LocalStorageService.set(StorageKeys.token, resp.token);
      signupState.add(SignupState.success);
    } on DioError catch (error) {
      if (error.type != DioErrorType.DEFAULT) {
        signupState.add(SignupState.noInternet);
      } else {
        signupState.add(SignupState.error);
      }
    }
    isLoading.add(false);
  }
}
