import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _selectedRole = 'User';

  final Color primaryOrange = const Color(0xFFFFA726);

  OutlineInputBorder _customBorder() => OutlineInputBorder(
    borderSide: BorderSide(color: primaryOrange),
    borderRadius: BorderRadius.circular(10),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Scrollable AppBar
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            backgroundColor: Colors.indigo[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: 16),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Lottie.asset('lib/assets/Logo.json'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Home & Office',
                        style: TextStyle(
                          fontFamily: 'Lobster',
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Repair App!',
                          style: TextStyle(
                            fontFamily: 'Lobster',
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Form Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: Colors.grey[100],
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryOrange,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      // Name Field
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person, color: primaryOrange),
                          enabledBorder: _customBorder(),
                          focusedBorder: _customBorder(),
                          labelStyle: TextStyle(color: primaryOrange),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Email Field
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email, color: primaryOrange),
                          enabledBorder: _customBorder(),
                          focusedBorder: _customBorder(),
                          labelStyle: TextStyle(color: primaryOrange),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),

                      // Password Field
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock, color: primaryOrange),
                          enabledBorder: _customBorder(),
                          focusedBorder: _customBorder(),
                          labelStyle: TextStyle(color: primaryOrange),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),

                      // Confirm Password Field
                      TextField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: primaryOrange,
                          ),
                          enabledBorder: _customBorder(),
                          focusedBorder: _customBorder(),
                          labelStyle: TextStyle(color: primaryOrange),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),

                      // Role Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        decoration: InputDecoration(
                          labelText: 'Register as',
                          enabledBorder: _customBorder(),
                          focusedBorder: _customBorder(),
                          labelStyle: TextStyle(color: primaryOrange),
                        ),
                        items:
                            ['User', 'Service Provider'].map((role) {
                              return DropdownMenuItem(
                                value: role,
                                child: Text(role),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedRole = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 30),

                      // Sign Up Button
                      ElevatedButton(
                        onPressed: () {
                          String name = _nameController.text.trim();
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();
                          String confirmPassword =
                              _confirmPasswordController.text.trim();

                          // Error Style
                          final errorSnackBar =
                              (String message) => SnackBar(
                                content: Text(message),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.all(16),
                              );

                          // Validations
                          if (name.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty ||
                              confirmPassword.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              errorSnackBar('Please fill in all the fields'),
                            );
                            return;
                          }

                          if (password != confirmPassword) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              errorSnackBar('Passwords do not match'),
                            );
                            return;
                          }

                          // Success
                          print(
                            'Account created: $name, $email, Role: $_selectedRole',
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Account ready!'),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(16),
                            ),
                          );
                        },
                        child: const Text('Next'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryOrange,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
