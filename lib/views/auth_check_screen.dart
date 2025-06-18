import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_kel7/views/home_screen.dart';
import 'package:uas_kel7/views/login_screen.dart';
import 'package:uas_kel7/services/auth_service.dart';

class AuthCheckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Logika ini kita pindahkan dari main.dart
    return Consumer<AuthService>(
      builder: (ctx, auth, _) => auth.isAuth
          ? HomeScreen()
          : FutureBuilder(
              future: auth.tryAutoLogin(),
              builder: (ctx, authResultSnapshot) =>
                  authResultSnapshot.connectionState == ConnectionState.waiting
                      ? Scaffold(
                          body: Center(child: CircularProgressIndicator()),
                        )
                      : LoginScreen(),
            ),
    );
  }
}