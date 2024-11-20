import 'package:clientguest/components/app_routes.dart';
import 'package:clientguest/controller/SignInController.dart';
import 'package:clientguest/controller/Store.dart';
import 'package:clientguest/models/SignInModel.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _agreed = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isApiCallProcess = false;
  late SignInModelRequest sir = SignInModelRequest();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void clearText() {
    _emailController.text = '';
    _passwordController.text = '';
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _agreed) {
      setState(() {
        isApiCallProcess = true;
      });

      sir.email = _emailController.text;
      sir.password = _passwordController.text;

      SignInController sic = SignInController();
      sic.SignIn(sir).then((val) async {
        setState(() {
          isApiCallProcess = false;
        });

        if (val.token.isNotEmpty) {
          try {
            // Decode JWT Token
            Map<String, dynamic> decodedToken = Jwt.parseJwt(val.token);

            // Lưu token vào SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', val.token);
            await prefs.setString('email', sir.email);

            print('Token saved successfully.');

            // Điều hướng tới màn hình chính
            Navigator.pushNamed(context, Routes.home);
          } catch (e) {
            print('Error decoding token: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Lỗi trong quá trình xử lý token.')),
            );
          }
        } else {
          print('Invalid token received.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đăng nhập thất bại. Vui lòng thử lại!!')),
          );
        }
      }).catchError((error) {
        setState(() {
          isApiCallProcess = false;
        });
        print('Error during sign-in: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã xảy ra lỗi. Vui lòng thử lại sau.')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng hoàn thành thông tin và chấp nhận điều khoản.'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // University logo
                Image.asset(
                  'assets/images/phenikaa.png',
                  height: 300,
                ),
                const Text(
                  'Đăng nhập',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sử dụng tài khoản được cấp để sử dụng dịch vụ',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Login form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: _agreed,
                            onChanged: (value) {
                              setState(() {
                                _agreed = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              'Tôi đồng ý và chấp nhận Chính sách quyền riêng tư khi sử dụng ứng dụng Phenikaa University',
                              style:
                              TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: isApiCallProcess ? null : _submitForm,
                        child: isApiCallProcess
                            ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        )
                            : const Text(
                          'Đăng nhập',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1A237E),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Hoặc đăng nhập bằng',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: Image.asset('assets/images/google.png', height: 24),
                  label: Text('Đăng nhập với Google'),
                  onPressed: () {
                    // Add Google sign-in logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Google login not implemented.')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.grey,
                    backgroundColor: Colors.white,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
