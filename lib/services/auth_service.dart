// lib/services/auth_service.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
    String? _token;
    final String _baseUrl = 'http://45.149.187.204:3000';
    final String _loginPath = '/api/auth/login';

    bool get isAuth => _token != null;
    String? get token => _token;

    Future<void> login(String email, String password) async {
        final url = Uri.parse('$_baseUrl$_loginPath');
        print('Mencoba melakukan POST request ke: $url');

        try {
            final response = await http.post(
                url,
                headers: {'Content-Type': 'application/json'},
                body: json.encode({'email': email, 'password': password}),
            );

            print('Status Code dari Login: ${response.statusCode}');
            print('Response Body dari Login: ${response.body}');

            if (response.statusCode == 200) {
                final responseData = json.decode(response.body);
                _token = responseData['body']['data']['token']; 

                if (_token != null) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('authToken', _token!);
                    notifyListeners();
                } else {
                    throw Exception('Token tidak ditemukan di dalam respons server.');
                }
            } else {
                throw Exception('Login gagal. Status Code: ${response.statusCode}');
            }
        } catch (error) {
            print('Error saat login: $error');
            throw Exception('Gagal terhubung ke server. Periksa koneksi internet atau kredensial Anda.');
        }
    }

    Future<void> tryAutoLogin() async {
        final prefs = await SharedPreferences.getInstance();
        if (!prefs.containsKey('authToken')) {
            return;
        }
        _token = prefs.getString('authToken');
        notifyListeners();
    }

    Future<void> logout() async {
        _token = null;
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('authToken');
        notifyListeners();
    }
}