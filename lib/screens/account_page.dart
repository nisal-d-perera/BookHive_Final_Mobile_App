import 'package:bookhive/helper/appcolors.dart';
import 'package:bookhive/models/user_model.dart';
import 'package:bookhive/screens/main_screen.dart';
import 'package:bookhive/screens/order_page.dart';
import 'package:bookhive/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookhive/data/user_data.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int? userId;
  String? userName;
  String? userImage;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('user_id');
    });
    if (userId != null) {
      User? user = userdetails.firstWhere(
        (user) => user.id == userId,
      );
      setState(() {
        userName = user.name; 
        userImage = user.image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/$userImage'),
            ),
            const SizedBox(width: 10),
            Text(
              userName ?? 'Loading...',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
              },
              child: const Icon(Icons.settings, color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'My Orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOrderStatus(Icons.account_balance_wallet, 'To Pay', () {}),
                _buildOrderStatus(Icons.local_shipping, 'To Ship', () {}),
                _buildOrderStatus(Icons.receipt_long, 'To Receive', () {}),
                _buildOrderStatus(Icons.rate_review, 'To Review', () {}, count: 10),
                _buildOrderStatus(Icons.cancel, 'Returns', () {}),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIconWithLabel(Icons.history, 'History', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderPage()));
                  }),
                  _buildIconWithLabel(Icons.card_membership, 'Cards', () {}),
                  _buildIconWithLabel(Icons.favorite_border, 'Wishlist', () {}),
                  _buildIconWithLabel(Icons.card_giftcard, 'Coupons', () {}),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPromoCard('Bundle deals', 'Hot sale', Icons.shopping_basket, () {}),
                  _buildPromoCard('Coins +20', 'Get more coins', Icons.monetization_on, () {}),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Points',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildCard('Points', '0', () {}),
                ),
                Expanded(
                  child: _buildCard('Payment Options', '0', () {}),
                ),
              ],
            ),
            const Divider(),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              children: [
                _buildGridItem(Icons.mail_outline, 'Messages', () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen(index: 1,)));
                }),
                _buildGridItem(Icons.local_offer, 'Promos', () {}),
                _buildGridItem(Icons.style, 'DarazLook', () {}),
                _buildGridItem(Icons.payment, 'PayLater', () {}),
                _buildGridItem(Icons.help_outline, 'Help Center', () {}),
                _buildGridItem(Icons.phone, 'Customer Care', () {}),
                _buildGridItem(Icons.rate_review, 'My Reviews', () {}),
                _buildGridItem(Icons.people, 'My Affiliates', () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatus(IconData icon, String label, VoidCallback onPressed, {int count = 0}) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Stack(
            children: [
              Icon(icon, size: 40, color: AppColors.mainColor),
              if (count > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text('$count', style: const TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildIconWithLabel(IconData icon, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(icon, size: 35, color: AppColors.mainColor),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildPromoCard(String title, String subtitle, IconData icon, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(icon, size: 30, color: AppColors.mainColor),
                const SizedBox(height: 4),
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String value, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: AppColors.mainColor),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
