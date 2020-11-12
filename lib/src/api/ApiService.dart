import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:testApp/src/api/Dto/CommentDto.dart';
import 'package:testApp/src/api/Dto/PostDto.dart';
import 'package:testApp/src/api/Dto/UserDto.dart';
import 'package:testApp/src/services/LocalStorageService.dart';

import 'Dto/LoginDto.dart';

class ApiService {
  Dio dio; // = new Dio(); // with default Options

  ApiService() {
    // or new Dio with a BaseOptions instance.
    BaseOptions options = new BaseOptions(
      baseUrl: "https://react-native-mobile.herokuapp.com",
      connectTimeout: 5000,
      receiveTimeout: 10000,
    );
    this.dio = new Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      // Do something before request is sent
      final storageToken = await LocalStorageService.get(StorageKeys.token);
      options.headers["Authorization"] = "Bearer ${storageToken}";
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) async {
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) async {
      // Do something with response error
      return e; //continue
    }));
  }

  // Auth
  Future<LoginResponseDto> login(LoginDto body) async {
    final response = await dio.post("/user/login", data: body.toJson());
    return LoginResponseDto.fromJson(response.data);
  }
  Future<LoginResponseDto> signup(LoginDto body) async {
    final response = await dio.post("/user/signup", data: body.toJson());
    return LoginResponseDto.fromJson(response.data);
  }

  // User
  Future<UserResponseDto> patchUser(UpdateUserDto body) async {
    final response = await dio.patch("/user", data: body.toJson());
    return UserResponseDto.fromJson(response.data);
  }
  Future<UserResponseDto> getUserMe() async {
    final response = await dio.get("/user");
    return UserResponseDto.fromJson(response.data);
  }
  Future<UserResponseDto> getUser(String userId) async {
    final response = await dio.get("/user/${userId}");
    return UserResponseDto.fromJson(response.data);
  }

  // Post
  Future<PostResponseDto> createPost(CreatePostDto body) async {
    final response = await dio.post("/post", data: body.toJson());
    return PostResponseDto.fromJson(response.data);
  }
  Future<PostResponseDto> getPost(String postId) async {
    final response = await dio.get("/post/${postId}");
    return PostResponseDto.fromJson(response.data);
  }
  // todo: patch post
  Future<CommentResponseDto> commentOnPost(String postId, CreateCommentDto body) async {
    final response = await dio.post("/post/${postId}/comment", data: body);
    return CommentResponseDto.fromJson(response.data);
  }
  Future<void> deletePost(String postId) async {
    await dio.delete("/post/${postId}");
  }
  Future<List<PostDto>> getPostByPosition(int lat, int long, int radius) async {
    final response = await dio.get("/post?lat=${lat}&long=${long}&radius=${radius}");
    List<dynamic> list = json.decode(response.data);
    return list.map((e) => PostDto.fromJson(e));
  }
}
