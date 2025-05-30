// lib/views/register_screen.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_kel7/routes/route_names.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    final name = _nameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    print('Name: $name');
    print('Email: $email');
    print('Phone: $phone');
    print('Password: $password');
    print('Confirm Password: $confirmPassword');
    if (password == confirmPassword && password.isNotEmpty) {
      context.goNamed(RouteNames.login);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign Up successful! Please log in.')),
      );
    } else if (password != confirmPassword) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match!')),
      );
    } else {
       context.goNamed(RouteNames.login);
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign Up successful! Please log in.')),
      );
    }
  }

  void _handleSignIn() {
    context.goNamed(RouteNames.login);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
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
              borderSide: BorderSide(color: const Color.fromARGB(255, 47, 12, 243), width: 1.5),
            ),
            suffixIcon: suffixIcon,
          ),
          style: TextStyle(fontSize: 10.sp, color: Colors.black87),
        ),
        SizedBox(height: 20.h),
      ],
    );
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
              SizedBox(height: 20.h),

              // Tombol kembali (opsional)
              // IconButton(
              //   icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20.sp),
              //   onPressed: () => context.pop(),
              // ),
              // SizedBox(height: 10.h),

              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Before you get started, let me help you to sign up first',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 40.h),

              _buildTextField(
                controller: _nameController,
                labelText: 'Name',
                hintText: 'Full Name',
              ),
              _buildTextField(
                controller: _emailController,
                labelText: 'Email',
                hintText: 'Email Account',
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(
                controller: _phoneController,
                labelText: 'Phone Number',
                hintText: 'Phone number',
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                controller: _passwordController,
                labelText: 'Password',
                hintText: 'Create a password',
              ),
              _buildTextField(
                controller: _confirmPasswordController,
                labelText: 'Confirm Password',
                hintText: 'Confirmation password',
              ),
              SizedBox(height: 40.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSignUp,
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
                          'Sign Up',
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
                    text: "Already have an account? ",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey[700],
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign in',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.orangeAccent[700],
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = _handleSignIn,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
