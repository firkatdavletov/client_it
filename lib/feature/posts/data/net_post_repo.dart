import 'package:client_it_product/feature/posts/domain/post_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../app/domain/app_api.dart';
import '../domain/entity/post/post_entity.dart';

@Injectable(as: PostRepo)
class NetPostRepo implements PostRepo {
  final AppApi api;

  NetPostRepo(this.api);

  @override
  Future<Iterable> fetchPosts() async {
    try {
      final response = await api.fetchPosts();
      return response.data;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<PostEntity> fetchPost(String id) async {
    try {
      final response = await api.fetchPost(id);
      return PostEntity.fromJson(response.data["data"]);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> createPost(Map args) async {
    try {
      final response = await api.createPost(args);
      return response.data["message"];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletePost(String id) async {
    try {
      await api.deletePost(id);
    } catch (_) {
      rethrow;
    }
  }

}