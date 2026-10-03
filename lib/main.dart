import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/routing/app_router.dart';
import 'data/datasources/local/news_local_datasource.dart';

void main() async {
  // Ensure bindings are initialized before calling async code
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage (articles and bookmarks)
  final localDataSource = NewsLocalDataSourceImpl();
  await localDataSource.init();

  // Open the auth box for session management
  await Hive.openBox('auth_box');
  await Hive.openBox('bookmarks_box');

  runApp(
    // ProviderScope is required for Riverpod to work
    const ProviderScope(
      child: NewsReaderApp(),
    ),
  );
}

class NewsReaderApp extends StatelessWidget {
  const NewsReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'News Reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system, // We will update this to persist user preference later
      routerConfig: appRouter,
    );
  }
}