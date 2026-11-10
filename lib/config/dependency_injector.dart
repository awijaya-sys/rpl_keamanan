import 'package:flutter/material.dart';

import '../repositories/post_repository.dart';
import '../repositories/post_repository_impl.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../services/api_service.dart';

/// Penyedia dependency sederhana (singleton).
///
/// Menyimpan satu instance [ApiService] yang dipakai bersama oleh
/// [UserRepository] dan [PostRepository].
class DependencyInjector {
  DependencyInjector._internal();

  static final DependencyInjector _instance = DependencyInjector._internal();

  /// Instance tunggal [DependencyInjector].
  factory DependencyInjector() => _instance;

  /// Instance tunggal [ApiService] (singleton).
  final ApiService apiService = ApiService();

  /// Repository pengguna.
  late final UserRepository userRepository = UserRepositoryImpl(
    apiService: apiService,
  );

  /// Repository post.
  late final PostRepository postRepository = PostRepositoryImpl(
    apiService: apiService,
  );
}

/// InheritedWidget untuk menyediakan [DependencyInjector] ke widget tree.
class DependencyProvider extends InheritedWidget {
  final DependencyInjector injector;

  const DependencyProvider({
    super.key,
    required this.injector,
    required super.child,
  });

  /// Mengambil [DependencyInjector] terdekat dari [context].
  static DependencyInjector of(BuildContext context) {
    final provider = context
        .getInheritedWidgetOfExactType<DependencyProvider>();
    assert(
      provider != null,
      'DependencyProvider tidak ditemukan di widget tree',
    );
    return provider!.injector;
  }

  @override
  bool updateShouldNotify(DependencyProvider oldWidget) =>
      injector != oldWidget.injector;
}
