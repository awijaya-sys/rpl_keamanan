import '../models/post.dart';

/// Abstraksi repository untuk mengelola data post.
abstract class PostRepository {
  /// Mengambil daftar semua post.
  ///
  /// Melempar [Exception] jika terjadi error.
  Future<List<Post>> getPosts();
}
