import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:mappin/src/api/Dto/CommentDto.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';
import 'package:mappin/src/api/Dto/UserDto.dart';
import 'package:mappin/src/services/LocalStorageService.dart';
import 'package:mappin/src/values/routes.dart' as app_routes;

import 'Dto/LoginDto.dart';

class ApiService {
  ApiService() {
    // or new Dio with a BaseOptions instance.
    final BaseOptions options = BaseOptions(
      baseUrl: app_routes.baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    dio = Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      // Do something before request is sent
      final String storageToken =
          await LocalStorageService.get(StorageKeys.token);
      options.headers['Authorization'] = 'Bearer $storageToken';
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response<dynamic> response) async {
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) async {
      // Do something with response error
      return e; //continue
    }));
  }

  Dio dio; // = new Dio(); // with default Options

  // Auth
  Future<LoginResponseDto> login(LoginDto body) async {
    final Response<Map<String, dynamic>> response =
        await dio.post('/user/login', data: body.toJson());
    return LoginResponseDto.fromJson(response.data);
  }

  Future<LoginResponseDto> signup(LoginDto body) async {
    final Response<Map<String, dynamic>> response =
        await dio.post('/user/signup', data: body.toJson());
    return LoginResponseDto.fromJson(response.data);
  }

  // User
  Future<UserResponseDto> patchUser(UpdateUserDto body) async {
    final Response<Map<String, dynamic>> response =
        await dio.patch('/user', data: body.toJson());
    return UserResponseDto.fromJson(response.data);
  }

  Future<UserResponseDto> getUserMe() async {
    final Response<Map<String, dynamic>> response = await dio.get('/user');
    return UserResponseDto.fromJson(response.data);
  }

  Future<UserResponseDto> getUser(String userId) async {
    final Response<Map<String, dynamic>> response =
        await dio.get('/user/$userId');
    return UserResponseDto.fromJson(response.data);
  }

  // Post
  Future<PostResponseDto> createPost(CreatePostDto body) async {
    final Response<Map<String, dynamic>> response =
        await dio.post('/post', data: body.toJson());
    return PostResponseDto.fromJson(response.data);
  }

  Future<PostResponseDto> getPost(String postId) async {
    final Response<Map<String, dynamic>> response =
        await dio.get('/post/$postId');
    return PostResponseDto.fromJson(response.data);
  }

  // todo: patch post
  Future<CommentResponseDto> commentOnPost(
      String postId, CreateCommentDto body) async {
    final Response<Map<String, dynamic>> response =
        await dio.post('/post/$postId/comment', data: body);
    return CommentResponseDto.fromJson(response.data);
  }

  Future<void> deletePost(String postId) async {
    await dio.delete<void>('/post/$postId');
  }

  Future<List<PostDto>> getPostByPosition(
      double lat, double long, int radius) async {
    final Response<String> response =
        await dio.get('/post?lat=$lat&long=$long&radius=$radius');
    final dynamic list = json.decode(response.data);
    return (list as List<dynamic>)
        .map((dynamic e) => PostDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
