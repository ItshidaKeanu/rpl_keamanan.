import '../services/api_service.dart';

import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';

import '../repositories/post_repository.dart';
import '../repositories/post_repository_impl.dart';

/// Class untuk mengelola dependency aplikasi.
class DependencyInjector {
  static final DependencyInjector _instance =
      DependencyInjector._internal();

  factory DependencyInjector() {
    return _instance;
  }

  DependencyInjector._internal();

  late final ApiService apiService = ApiService();

  late final UserRepository userRepository =
      UserRepositoryImpl(apiService: apiService);

  late final PostRepository postRepository =
      PostRepositoryImpl(apiService: apiService);
}