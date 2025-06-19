import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_kel7/services/auth_service.dart';
import 'package:uas_kel7/views/splash_screen.dart';
import 'package:uas_kel7/views/intro_screen.dart';
import 'package:uas_kel7/views/login_screen.dart';
import 'package:uas_kel7/views/register_screen.dart';
import 'package:uas_kel7/views/home_screen.dart';
import 'package:uas_kel7/views/explore_screen.dart';
import 'package:uas_kel7/views/favorite_screen.dart';
import 'package:uas_kel7/views/profile_screen.dart';
import 'package:uas_kel7/views/article_detail_screen.dart';
import 'route_names.dart';

class AppRoute {
  final AuthService authService;
  GoRouter? _goRouter;

  AppRoute(this.authService) {
    _goRouter ??= goRouterSetup();
  }

  GoRouter get goRouter => _goRouter!;

  GoRouter goRouterSetup() {
    return GoRouter(
      initialLocation: RouteNames.splash,
      refreshListenable: authService,
      redirect: (BuildContext context, GoRouterState state) {
        final bool isLoggedIn = authService.isAuth;
        final String location = state.uri.toString();

        final bool isPublicRoute = location == RouteNames.splash ||
                                   location == RouteNames.intro ||
                                   location == RouteNames.login ||
                                   location == RouteNames.register;

        if (!isLoggedIn && !isPublicRoute) {
          return RouteNames.login;
        }

        if (isLoggedIn && (location == RouteNames.login || location == RouteNames.register || location == RouteNames.intro)) {
          return RouteNames.home;
        }

        return null;
      },
      routes: [
        GoRoute(
          path: RouteNames.splash,
          name: RouteNames.splash,
          pageBuilder: (context, state) => const MaterialPage(child: SplashScreen()),
        ),
        GoRoute(
          path: RouteNames.intro,
          name: RouteNames.intro,
          pageBuilder: (context, state) => const MaterialPage(child: IntroScreen()),
        ),
        GoRoute(
          path: RouteNames.login,
          name: RouteNames.login,
          pageBuilder: (context, state) => const MaterialPage(child: LoginScreen()),
        ),
        GoRoute(
          path: RouteNames.register,
          name: RouteNames.register,
          pageBuilder: (context, state) => const MaterialPage(child: RegisterScreen()),
        ),
        GoRoute(
          path: RouteNames.home,
          name: RouteNames.home,
          pageBuilder: (context, state) => const MaterialPage(child: HomeScreen()),
        ),
        GoRoute(
          path: RouteNames.explore,
          name: RouteNames.explore,
          pageBuilder: (context, state) => const MaterialPage(child: ExploreScreen()),
        ),
        GoRoute(
          path: RouteNames.profile,
          name: RouteNames.profile,
          pageBuilder: (context, state) => const MaterialPage(child: ProfileScreen()),
        ),
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            appBar: AppBar(title: const Text('Error Halaman')),
            body: Center(child: Text('Halaman tidak ditemukan: ${state.error?.message}')),
          ),
        );
      },
    );
  }
}