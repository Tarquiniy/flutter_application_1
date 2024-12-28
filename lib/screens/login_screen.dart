import 'package:flutter/material.dart';
import '/screens/main_screen.dart';
import '/services/database_service.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/gothic_app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GothicAppBar(title: "Login"),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    labelText: 'Username',
                    controller: _usernameController,
                    icon: Icons.person,
                  ),
                  CustomTextField(
                    labelText: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                    icon: Icons.lock,
                  ),
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text("Enter the Night"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final dbService = DatabaseService();
      final username = _usernameController.text;
      final password = _passwordController.text;

      final user = await dbService.getUserByUsername(username);

      if (user != null && user.password == password) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                MainScreen(user: user),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      } else {
        setState(() {
          _errorMessage = "Invalid username or password";
        });
      }
    }
  }
}
