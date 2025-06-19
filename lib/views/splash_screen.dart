import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uas_kel7/routes/route_names.dart';
import 'package:uas_kel7/services/auth_service.dart';
import 'package:uas_kel7/views/home_screen.dart';
import 'package:uas_kel7/views/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthAndNavigate();
    });
    // Future.delayed(const Duration(seconds: 3), () {
    //   if (mounted) {
    //     context.goNamed(RouteNames.intro);
    //   }
    // });
  }

  Future<void> _checkAuthAndNavigate() async {
    // Beri jeda agar splash screen terlihat
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.tryAutoLogin();

      if (mounted) {
        if (authService.isAuth) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IntroScreen()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/images/news1.jpeg', width: 123)),
    );
  }
}
