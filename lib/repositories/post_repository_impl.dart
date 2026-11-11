import '../models/post.dart';
import '../services/api_service.dart';
import 'post_repository.dart';

/// Implementasi konkret dari PostRepository.
class PostRepositoryImpl implements PostRepository {
  final ApiService _apiService;

  PostRepositoryImpl({
    ApiService? apiService,
  }) : _apiService = apiService ?? ApiService();

  @override
  Future<List<Post>> getPosts() {
    return _apiService.getPosts();
  }
}