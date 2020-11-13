import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mappin/src/api/ApiService.dart';
import 'package:mappin/src/api/Dto/LoginDto.dart';
import 'package:mappin/src/services/LocalStorageService.dart';
import 'package:mappin/src/values/enums.dart';

class LoginViewModel {
  final ApiService apiService = ApiService();

  final loginState = PublishSubject<LoginState>();
  final username = BehaviorSubject<String>.seeded("");

  void login() async {
    try {
      final resp = await apiService.login(LoginDto("mistralaix", "Test1234*"));
      print(resp.token);
      username.add(resp.user.username);
      LocalStorageService.set(StorageKeys.token, resp.token);
      loginState.add(LoginState.success);
    } on DioError catch (error) {
      if (error.type != DioErrorType.DEFAULT) {
        // No internet
      } else {
        // print("Error ------> ${error.response.statusCode}");
      }
      loginState.add(LoginState.error);
    }
  }

  void getUserMe() async {
    try {
      final resp = await apiService.getUserMe();
      print(resp.user.username);
    } on DioError catch (error) {
      if (error.type != DioErrorType.DEFAULT) {
        // No internet
      } else {
        // print("Error ------> ${error.response.statusCode}");
      }
      loginState.add(LoginState.error);
    }
  }
}