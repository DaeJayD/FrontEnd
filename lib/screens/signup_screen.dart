import 'package:appdev_thrift/screens/login_screen.dart';
import 'package:appdev_thrift/services/services_api.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD0BB94),
      body: Stack(
        children: [
          // Background Image
          Positioned(
            left: 38.82,
            top: -97,
            child: Transform.rotate(
              angle: -16 * (3.1415926535 / 180),
              child: Image.asset(
                'assets/icons/backgroundimage.png',
                width: 500,
                height: 500,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Form Container
          Positioned(
            left: 0,
            top: 187,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 187,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF816635),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input Fields
                  buildTextField("Email", emailController),
                  buildTextField("User name", usernameController),
                  buildTextField("Password", passwordController, obscureText: true),
                  buildTextField("Confirm Password", confirmPasswordController, obscureText: true),
                  buildTextField("Phone", phoneController),

                  const SizedBox(height: 20),

                  // Sign Up Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF816635),
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      String username = usernameController.text.trim();
                      String email = emailController.text.trim();
                      String password = passwordController.text.trim();

                      if (username.isEmpty || email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields are required!")));
                        return;
                      }
                      final response = await ApiService.registerUser(username, email, password);

                      if (response != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Successful!")));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Failed")));
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Back to Login Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "← Back to login",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF816635),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String hint, TextEditingController controller, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}