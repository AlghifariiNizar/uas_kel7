import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_kel7/views/explore_screen.dart';
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
          // Sementara
          pageBuilder:
              (context, state) =>
                  _dummyPage(context, state, 'Favorites Screen'),
        ),
        // GoRoute(
        //   path: '/profile',
        // name: RouteNames.profile, Jika akan digunakan tambahkan di route_names.dart
        // // Sementara
        //   pageBuilder: (context, state) => _dummyPage(context, state, 'Profile Screen'),
        // ),
      ],
    );
  }
}
