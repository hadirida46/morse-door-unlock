import 'package:flutter/material.dart';
import 'sign_up_page.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final Color primaryOrange = const Color(0xFFFFA726);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.grey[100],
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Home or office,\n we've got your back",
                  style: TextStyle(
                    fontFamily: 'Lobster',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryOrange,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 20),
                Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryOrange,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                // Email
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: primaryOrange),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryOrange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryOrange),
                    ),
                    labelStyle: TextStyle(color: primaryOrange),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),

                // Password
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: primaryOrange),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryOrange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryOrange),
                    ),
                    labelStyle: TextStyle(color: primaryOrange),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),

                // Sign In Button
                ElevatedButton(
                  onPressed: () {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text;

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill in all fields'),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                      );
                    } else {
                      print('Email: $email, Password: $password');
                      // Proceed with sign-in logic
                    }
                  },
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),

                // Sign Up Prompt + Button
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
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
