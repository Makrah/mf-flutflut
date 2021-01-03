import 'package:dio/dio.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';
import 'package:mappin/src/api/Dto/UserDto.dart';
import 'package:mappin/src/api/Dto/GeoPointDto.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mappin/src/api/ApiService.dart';
import 'package:mappin/src/api/Dto/LoginDto.dart';
import 'package:mappin/src/services/LocalStorageService.dart';
import 'package:mappin/src/values/enums.dart';

class ProfileViewModel {
  final ApiService apiService = ApiService();

  int step = 0;
  List<PostDto> originalList = [];

  BehaviorSubject<String> tokenUser = BehaviorSubject<String>.seeded('');
  PublishSubject<ProfileState> profilState = PublishSubject<ProfileState>();
  BehaviorSubject<String> userName = BehaviorSubject<String>.seeded('');
  BehaviorSubject<String> userImage = BehaviorSubject<String>.seeded(null);
  BehaviorSubject<List<PostDto>> userPosts =
      BehaviorSubject<List<PostDto>>.seeded(<PostDto>[], sync: true);
  BehaviorSubject<bool> isLoading =
      BehaviorSubject<bool>.seeded(false, sync: true);

  void isLoadingFunc(bool value) {
    isLoading.add(value);
  }

  void setupRecent() {
    userPosts.add(originalList);
    step = 0;
  }

  void setupLikes() {
    var newList = <PostDto>[];
    originalList.forEach((element) {
      newList.add(element);
    });
    newList.sort((a, b) => a.likes.length.compareTo(b.likes.length));
    userPosts.add(newList.reversed.toList());
    step = 1;
  }

  void setupComments() {
    var newList = <PostDto>[];
    originalList.forEach((element) {
      newList.add(element);
    });
    newList.sort((a, b) => a.comments.length.compareTo(b.comments.length));
    userPosts.add(newList.reversed.toList());
    step = 2;
  }

  Future<void> updateProfile(String image) async {
    try {
      final resp = await apiService.patchUserImage(UpdateUserImageDto(image));
      final user = await apiService.getUserMe();
      userImage.add(user.user.image);
    } on DioError catch (error) {
      if (error.type != DioErrorType.DEFAULT) {
        profilState.add(ProfileState.noInternet);
      } else {
        print(error.response.statusMessage);
        profilState.add(ProfileState.error);
      }
    }
  }

  Future<void> createPost(String latitude, String longitude, String title, String description, String image) async {
    try {
      final resp = await apiService.createPost(new CreatePostDto(image, title, description, GeoPointDto(double.parse(latitude), double.parse(longitude))));
      profilState.add(ProfileState.success);
    } on DioError catch (error) {
      if (error.type != DioErrorType.DEFAULT) {
        profilState.add(ProfileState.noInternet);
      } else {
        print(error.response.statusMessage);
        profilState.add(ProfileState.error);
      }
    }
  }

  Future<void> getUserMe() async {
    isLoadingFunc(true);
    try {
      final resp = await apiService.getUserMe();
      print(resp.user);
      userName.add(resp.user.username);
      if (resp.user.image == null) {
        userImage.add(null);
      } else {
        userImage.add(resp.user.image);
      }
      originalList = resp.user.posts;
      userPosts.add(resp.user.posts);
      print("__________________");
      print("post =>${userPosts.value}");
      print("userName =>${userName.value}");
      print("image =>${userImage.value}");
      print("__________________");
      isLoadingFunc(false);
    } on DioError catch (error) {
      if (error.type != DioErrorType.DEFAULT) {
        profilState.add(ProfileState.noInternet);
      } else {
        print(error.response.statusMessage);
        profilState.add(ProfileState.error);
      }
    }
    isLoading.add(true);
  }
}
