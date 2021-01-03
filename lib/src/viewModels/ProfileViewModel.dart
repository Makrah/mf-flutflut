import 'package:dio/dio.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';
import 'package:mappin/src/api/Dto/UserDto.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mappin/src/api/ApiService.dart';
import 'package:mappin/src/values/enums.dart';

class ProfileViewModel {
  final ApiService apiService = ApiService();

  int step = 0;
  List<PostDto> originalList = <PostDto>[];

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
    final List<PostDto> newList = <PostDto>[];
    originalList.toList().forEach((PostDto element) {
      newList.add(element);
    });
    newList.sort(
        (PostDto a, PostDto b) => a.likes.length.compareTo(b.likes.length));
    userPosts.add(newList.reversed.toList());
    step = 1;
  }

  void setupComments() {
    final List<PostDto> newList = <PostDto>[];
    originalList.toList().forEach((PostDto element) {
      newList.add(element);
    });
    newList.sort((PostDto a, PostDto b) =>
        a.comments.length.compareTo(b.comments.length));
    userPosts.add(newList.reversed.toList());
    step = 2;
  }

  Future<void> updateProfile(String image) async {
    try {
      await apiService.patchUserImage(UpdateUserImageDto(image));
      final UserResponseDto user = await apiService.getUserMe();
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

  Future<void> createPost(String latitude, String longitude, String title,
      String description, String image) async {
    try {
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
      final UserResponseDto resp = await apiService.getUserMe();
      print(resp.user);
      userName.add(resp.user.username);
      if (resp.user.image == null) {
        userImage.add(null);
      } else {
        userImage.add(resp.user.image);
      }
      originalList = resp.user.posts;
      userPosts.add(resp.user.posts);
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
