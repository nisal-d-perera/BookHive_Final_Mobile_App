import 'package:flutter/material.dart';
import 'package:bookhive/helper/appcolors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:bookhive/screens/home_page.dart';
import 'package:bookhive/screens/category_page.dart';
import 'package:bookhive/screens/message_page.dart';
import 'package:bookhive/screens/cart_page.dart';
import 'package:bookhive/screens/account_page.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  final int index;

  const MainScreen({super.key, this.index = 2});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int index;

  final List<Widget> screens = [
    CategoryPage(),
    const MessagePage(),
    const HomePage(),
    const CartPage(cartItems: []),
    const AccountPage(),
  ];

  Color bgColor = AppColors.mainColor;

  @override
  void initState() {
    super.initState();
    index = widget.index;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.mainColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> navigationItem = [
      const Icon(Icons.dashboard, size: 30, color: Colors.white),
      const Icon(Icons.message, size: 30, color: Colors.white),
      const Icon(Icons.home, size: 30, color: Colors.white),
      const Icon(Icons.shopping_cart, size: 30, color: Colors.white),
      const Icon(Icons.person, size: 30, color: Colors.white),
    ];

    return Container(
      color: AppColors.mainColor,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.white,
            body: screens[index],
            bottomNavigationBar: CurvedNavigationBar(
              color: bgColor,
              backgroundColor: Colors.white,
              height: 60.0,
              items: navigationItem,
              index: index,
              animationDuration: const Duration(milliseconds: 500),
              onTap: (int index) {
                setState(() {
                  this.index = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
