import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uas_kel7/routes/route_names.dart';
import 'package:uas_kel7/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final  _emailController = TextEditingController(text: 'news@itg.ac.id');
  final  _passwordController = TextEditingController(text: 'ITG#news');
  bool _isLoading = false;

    Future<void> _login() async {
    print('--- Tombol Login Ditekan! Proses _login() dimulai. ---');

    setState(() { _isLoading = true; });

    print('Mencoba memanggil Provider.of<AuthService>...');

    try {
        await Provider.of<AuthService>(context, listen: false).login(
            _emailController.text,
            _passwordController.text,
        );
        print('Pemanggilan AuthService.login() selesai tanpa error langsung.');

    } catch (error, stackTrace) {
        // BLOK INI AKAN JALAN JIKA ADA ERROR
        print('--- TERJADI ERROR SAAT MENCOBA LOGIN! ---');
        print('TIPE ERROR: ${error.runtimeType}');
        print('PESAN ERROR: $error');
        print('STACK TRACE:');
        print(stackTrace);
        print('-------------------------------------------');
        
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                title: Text('Login Gagal'),
                content: Text(error.toString()),
                actions: <Widget>[
                    TextButton(
                        child: Text('OK'),
                        onPressed: () => Navigator.of(ctx).pop(),
                    )
                ],
            ),
        );
    }
    
    if (mounted) {
        setState(() { _isLoading = false; });
    }
}

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailController.text;
      final password = _passwordController.text;
      // Panggil metode login dari AuthService tanpa listen
      await Provider.of<AuthService>(context, listen: false).login(email, password);
      // Navigasi tidak diperlukan di sini. `go_router` dengan `refreshListenable`
      // akan mendeteksi perubahan status login dan melakukan redirect secara otomatis.
    } catch (error) {
      // Tampilkan pesan error jika login gagal
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    } finally {
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _handleForgotPassword() {
    print('Forgot Password pressed');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Forgot Password pressed (Placeholder)')),
    );
  }

  void _handleSignUp() {
    context.goNamed(RouteNames.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Text(
                'Hello,',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 60.h),

              // Label Email
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              // TextField Email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Input Your Email Account',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 10.sp),
                  filled: true,
                  fillColor: Colors.grey[50], // Warna fill sedikit abu-abu
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.deepPurple, width: 1.5),
                  ),
                ),
                style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              ),
              SizedBox(height: 24.h),

              // Label Password
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              // TextField Password
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 10.sp),
                  filled: true,
                  fillColor: Colors.grey[50],
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.deepPurple, width: 1.5),
                  ),
                ),
                style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              ),
              SizedBox(height: 12.h),

              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: _handleForgotPassword,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(50.w, 30.h),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.orangeAccent[700], 
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 140.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 47, 12, 243),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 2,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 20.sp),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey[700],
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.orangeAccent[700],
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = _handleSignUp,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h), // Spasi di bawah
            ],
          ),
        ),
      ),
    );
  }
}
