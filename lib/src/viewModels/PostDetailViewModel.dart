import 'package:dio/dio.dart';
import 'package:mappin/src/api/ApiService.dart';
import 'package:mappin/src/api/Dto/CommentDto.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';
import 'package:rxdart/rxdart.dart';

class PostDetailViewModel {
  final ApiService apiService = ApiService();

  BehaviorSubject<bool> isLoading =
      BehaviorSubject<bool>.seeded(false, sync: true);
  BehaviorSubject<PostDetailDto> post =
      BehaviorSubject<PostDetailDto>.seeded(null, sync: true);
  BehaviorSubject<PostDto> currentPost =
      BehaviorSubject<PostDto>.seeded(null, sync: true);
  BehaviorSubject<List<CommentDto>> comments =
      BehaviorSubject<List<CommentDto>>.seeded(<CommentDto>[], sync: true);

  Future<void> getPost(PostDto currentPost) async {
    this.currentPost.add(currentPost);
    isLoading.add(true);
    try {
      final PostResponseDto resp =
          await apiService.getPost(currentPost.id);
      post.add(resp.post);
      comments.add(resp.post.comments);
    } on DioError catch (error) {
      print(error);
    }
    isLoading.add(false);
  }
}
