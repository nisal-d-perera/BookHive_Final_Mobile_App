import 'package:bookhive/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _scaleAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    _animationController.forward();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
      );
    });
  }



  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                'assets/images/BookHive2.png',
                width: 300.0,
                height: 300.0,
              ),
            ),
            const SizedBox(height: 50.0),
            // Loading bar
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 168, 139, 52),),
            ),
          ],
        ),
      ),
    );
  }
}
