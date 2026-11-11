import '../models/post.dart';

/// Abstraksi repository untuk mengelola data Post.
abstract class PostRepository {
  /// Mengambil daftar semua postingan.
  Future<List<Post>> getPosts();
}