import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_kel7/views/article_detail_screen.dart';
import 'package:uas_kel7/views/explore_screen.dart';
import 'package:uas_kel7/views/favorite_screen.dart';
import 'package:uas_kel7/views/intro_screen.dart';
import 'package:uas_kel7/views/login_screen.dart';
import 'package:uas_kel7/views/profile_screen.dart';
import 'package:uas_kel7/views/register_screen.dart';
import 'package:uas_kel7/views/splash_screen.dart';
import 'package:uas_kel7/views/home_screen.dart';
import 'route_names.dart';

class AppRoute {
  AppRoute._();

  static final AppRoute _instance = AppRoute._();

  static AppRoute get instance => _instance;

  factory AppRoute() {
    _instance.goRouter ??= goRouterSetup();

    return _instance;
  }

  static MaterialPage _dummyPage(
    BuildContext context,
    GoRouterState state,
    String pageName,
  ) {
    return MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        appBar: AppBar(title: Text(pageName)),
        body: Center(child: Text('$pageName belum diimplementasikan.')),
      ),
    );
  }

  GoRouter? goRouter;
  static GoRouter goRouterSetup() {
    return GoRouter(
      initialLocation: RouteNames.splash,
      routes: [
        GoRoute(
          path: '/',
          name: RouteNames.splash,
          pageBuilder: (context, state) => MaterialPage(child: SplashScreen()),
        ),
        GoRoute(
          path: '/intro',
          name: RouteNames.intro,
          pageBuilder: (context, state) => const MaterialPage(child: IntroScreen()),
        ),
        GoRoute(
          path: '/login',
          name: RouteNames.login,
          pageBuilder: (context, state) => const MaterialPage(child: LoginScreen()),
        ),
        GoRoute(
          path: '/register',
          name: RouteNames.register,
          pageBuilder: (context, state) => const MaterialPage(child: RegisterScreen()),
        ),
        GoRoute(
          path: '/home',
          name: RouteNames.home,
          pageBuilder: (context, state) => MaterialPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/explore',
          name: RouteNames.explore,
          pageBuilder:
              (context, state) => MaterialPage(child: ExploreScreen()),
        ),
        GoRoute(
          path: '/favorites',
          name: RouteNames.favorites,
          pageBuilder:
              (context, state) => MaterialPage(child: FavoritesScreen()),
        ),
        GoRoute(
          path: '/profile',
          name: RouteNames.profile,
          pageBuilder:
              (context, state) => MaterialPage(child: ProfileScreen()),
        ),
        GoRoute(
          path: '/article/:articleId', // contoh: /article/:articleId
          name: RouteNames.articleDetail,
          pageBuilder: (context, state) {
            // Mengambil articleId dari path parameters
            final articleId = state.pathParameters['articleId'];
            // Memastikan articleId tidak null sebelum membuat halaman
            if (articleId == null) {
              // Jika ID null, bisa arahkan ke halaman error atau default
              print("Error: articleId is null for path ${state.uri}");
              return const MaterialPage(child: Scaffold(body: Center(child: Text("ID Artikel tidak valid atau hilang."))));
            }
            return MaterialPage(child: ArticleDetailScreen(articleId: articleId));
          },
        ),
      ],
    );
  }
}
