import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Sign-In Demo',
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isPortrait = constraints.maxHeight > constraints.maxWidth;

          return Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/loginbg.png', // Replace with your image path
                  fit: BoxFit.fill, // Ensures the image covers the entire screen
                ),
              ),
              // Foreground content
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isPortrait ? constraints.maxWidth * 0.05 : constraints.maxWidth * 0.1, // Adjust for orientation
                  ),
                  child: Column(
                    mainAxisAlignment: isPortrait
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Spacer to push content down
                      SizedBox(height: constraints.maxHeight * 0.18), // Increased space from top (logo will move down)
                      // Logo - Increased size
                      SizedBox(
                        width: isPortrait
                            ? constraints.maxWidth * 0.5 // Larger size for logo
                            : constraints.maxWidth * 0.3, // Larger size for logo
                        height: isPortrait
                            ? constraints.maxHeight * 0.14 // Larger size for logo
                            : constraints.maxHeight * 0.18, // Larger size for logo
                        child: Image.asset(
                          'assets/images/logo.png', // Replace with your logo path
                          fit: BoxFit.contain,
                        ),
                      ),
                      if (isPortrait) SizedBox(height: constraints.maxHeight * 0.05), // Moved down "Sign in with email"
                      const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 22, // Slightly reduced font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.02),
                      // Email field
                      SizedBox(
                        width: constraints.maxWidth * 0.7, // Reduced width for the email field
                        child: _buildTextField('Email', false, constraints.maxHeight),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.02),
                      // Password field and Forgot Password button
                      SizedBox(
                        width: constraints.maxWidth * 0.7, // Reduced width for the password field
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildTextField('Password', true, constraints.maxHeight),
                            SizedBox(height: constraints.maxHeight * 0.01),
                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Forgot password clicked!'),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFFFFF9C4),
                              ),
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(fontSize: 12), // Reduced font size
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.03),
                      // Get Started button - Increased height
                      SizedBox(
                        width: constraints.maxWidth * 0.7, // Reduced width for the button
                        height: constraints.maxHeight * 0.08, // Increased height
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFF9C4),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Get Started clicked!')),
                            );
                          },
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 18, // Reduced font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField(String label, bool obscureText, double screenHeight) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        obscureText: obscureText,
        style: const TextStyle(fontSize: 14), // Reduced font size
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14), // Reduced font size
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: screenHeight * 0.012, // Reduced padding
          ),
        ),
      ),
    );
  }
}
