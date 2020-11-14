import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mappin/src/api/ApiService.dart';
import 'package:mappin/src/api/Dto/LoginDto.dart';
import 'package:mappin/src/services/LocalStorageService.dart';
import 'package:mappin/src/values/enums.dart';

class LoginViewModel {
  final ApiService apiService = ApiService();

  final loginState = PublishSubject<LoginState>();
  final authState = BehaviorSubject<AuthState>.seeded(AuthState.splash);
  final tokenUser = BehaviorSubject<String>.seeded("");

  void logout() {
    LocalStorageService.set(StorageKeys.token, null);
    tokenUser.add("");
    authState.add(AuthState.unauthent);
  }

  Future<AuthState> getAuthState() async {
    final token = await LocalStorageService.get(StorageKeys.token);
    print("token --> ${token}");
    if (token == null) {
      this.authState.add(AuthState.unauthent);
      return AuthState.unauthent;
    } else {
      tokenUser.add(token);
      this.authState.add(AuthState.authent);
      return AuthState.authent;
    }
  }

  void login(String username, String password) async {
    try {
      final resp = await apiService.login(LoginDto(username, password));
      print(resp.token);
      this.tokenUser.add(resp.user.username);
      LocalStorageService.set(StorageKeys.token, resp.token);
      tokenUser.add(resp.token);
      loginState.add(LoginState.success);
      authState.add(AuthState.authent);
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
