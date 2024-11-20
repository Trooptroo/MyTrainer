// Suggested code may be subject to a license. Learn more: ~LicenseLog:4181747874.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1884698722.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1243510662.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1269566691.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:692399185.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:962678455.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2524755212.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2889940486.
dart
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement login logic
                String email = _emailController.text;
                String password = _passwordController.text;
                print('Email: $email, Password: $password');

                // Navigate to the next screen after successful login
                Navigator.pushNamed(context, '/home'); // Replace '/home' with your actual route
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
