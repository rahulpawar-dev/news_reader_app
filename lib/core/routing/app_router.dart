import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../presentation/features/auth/screens/login_screen.dart';
import '../../presentation/features/bookmarks/screens/bookmarks_screen.dart';
import '../../presentation/features/home/home_screen.dart';
import '../../presentation/features/search/screens/search_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    // Check session directly from Hive for initial routing
    final isAuth = Hive.box('auth_box').get('is_logged_in', defaultValue: false);
    final isGoingToLogin = state.matchedLocation == '/login';

    if (!isAuth && !isGoingToLogin) return '/login';
    if (isAuth && isGoingToLogin) return '/';
    return null;
  },
  routes: [

    GoRoute(
      path: '/bookmarks',
      builder: (context, state) => const BookmarksScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(), // Navigates to your actual Home Screen
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => SearchScreen(), // Navigates to your new Search Screen
    ),
  ],
);