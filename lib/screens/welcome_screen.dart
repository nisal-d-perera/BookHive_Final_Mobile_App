import 'package:bookhive/helper/appcolors.dart';
import 'package:bookhive/screens/login_screen.dart';
import 'package:bookhive/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Positioned.fill(
                  child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  'assets/images/Background.jpg',
                  fit: BoxFit.cover,
                ),
              )),
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: ClipOval(
                        child: Container(
                      width: 180,
                      height: 180,
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/Logo.png',
                        width: 130.0,
                        height: 130.0,
                      ),
                    )),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Welcome!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Explore a world of books & \npurchase your favorites with ease',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        minimumSize: const Size(double.infinity, 60.0),
                      ),
                      child: const Text(
                        'Register Here',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                    height: 60.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: AppColors.mainColor.withOpacity(0.2),
                          highlightColor: AppColors.mainColor.withOpacity(0.2),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.transparent,
                              border: Border.all(
                                color: AppColors.mainColor,
                                width: 4.0,
                              ),
                            ),
                            child: const Text(
                              'Already have an account?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ))
            ],
          )),
    );
  }
}
