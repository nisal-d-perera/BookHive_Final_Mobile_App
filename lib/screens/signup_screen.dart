import 'package:bookhive/helper/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:bookhive/screens/login_screen.dart'; 

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late Size mediaSize;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: const AssetImage("assets/images/register.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              const Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                    image: AssetImage("assets/images/BookHive2.png"),
                    width: 150.0,
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: mediaSize.width,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Create Your Account",
                              style: TextStyle(
                                fontSize: 32,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              "Please fill below information",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              "Your Name:",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            _buildInputField(nameController, icon: Icons.person),
                            const SizedBox(height: 20),
                            const Text(
                              "Email Address:",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            _buildInputField(emailController, icon: Icons.email),
                            const SizedBox(height: 20),
                            const Text(
                              "Phone Number:",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            _buildInputField(phoneController, icon: Icons.phone),
                            const SizedBox(height: 20),
                            const Text(
                              "Your Location:",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            _buildInputField(locationController, icon: Icons.location_on),
                            const SizedBox(height: 20),
                            const Text(
                              "Password:",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            _buildInputField(passwordController,
                                isPassword: true, icon: Icons.lock),
                            const SizedBox(height: 20),
                            
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()),);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mainColor,
                                shape: const StadiumBorder(),
                                elevation: 20,
                                shadowColor: AppColors.mainColor,
                                minimumSize: const Size.fromHeight(60),
                              ),
                              child: const Text(
                                "SIGN UP",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false, IconData? icon}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: Icon(icon, color: AppColors.mainColor),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainColor), // Focused line color
        ),
      ),
      obscureText: isPassword,
    );
  }
}
