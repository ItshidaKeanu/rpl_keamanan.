import 'package:flutter/material.dart';
import '../config/dependency_scope.dart';
import '../models/post.dart';
import '../repositories/post_repository.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late PostRepository _postRepository;
  late Future<List<Post>> _postsFuture;

  bool _repositoryInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_repositoryInitialized) {
      _postRepository =
          DependencyScope.of(context).postRepository;

      _postsFuture = _postRepository.getPosts();

      _repositoryInitialized = true;
    }
  }

  Future<void> _loadPosts() async {
    setState(() {
      _postsFuture = _postRepository.getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Postingan'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  const Text('Gagal memuat postingan'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadPosts,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          final posts = snapshot.data ?? [];

          if (posts.isEmpty) {
            return const Center(
              child: Text('Tidak ada postingan'),
            );
          }

          return RefreshIndicator(
            onRefresh: _loadPosts,
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        post.id.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      post.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(post.body),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}