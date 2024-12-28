import 'package:bookhive/data/address_data.dart';
import 'package:bookhive/data/card_data.dart';
import 'package:bookhive/data/user_data.dart';
import 'package:bookhive/models/address_model.dart';
import 'package:bookhive/models/card_model.dart';
import 'package:bookhive/models/user_model.dart';
import 'package:bookhive/screens/main_screen.dart';
import 'package:bookhive/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:bookhive/helper/appcolors.dart';
import 'package:bookhive/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int? userId;

  User? userDetail;

  Address? userAddress;

  Cards? userCard;

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
      setState(() {
        userDetail = userdetails.firstWhere(
          (user) => user.id == userId,
        );

        userAddress = addressdetails.firstWhere(
          (address) => address.userId == userId,
        );

        userCard = carddetails.firstWhere(
          (card) => card.userId == userId,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    String formattedCardNumber = '${userCard!.cardNumber.substring(0, 4)} ${'** ** **'} ${userCard!.cardNumber.substring(userCard!.cardNumber.length - 4)}';


    final cartProvider = context.watch<CartProvider>();
    final cartItems = cartProvider.shoppingCart;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Order Confirmation',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shipping Address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${userDetail!.name}, ${userDetail!.mobile}\n'
                    '${userAddress!.address}, ${userAddress!.city},\n'
                    '${userAddress!.district}, ${userAddress!.province},\n'
                    '${userAddress!.postalCode}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  Divider(height: 30, thickness: 1, color: Colors.grey[300]),

                  // Cart Items
                  ...cartItems.map((cartItem) {
                    return CartItem(cartItem: cartItem);
                  }).toList(),

                  Divider(height: 30, thickness: 1, color: Colors.grey[300]),

                  // Payment Method
                  Text(
                    'Payment Method',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.credit_card, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('${userCard!.cardType} $formattedCardNumber',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),

                  Divider(height: 30, thickness: 1, color: Colors.grey[300]),

                  // Summary
                  Text(
                    'Summary',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal', style: TextStyle(fontSize: 16)),
                      Text('Rs. ${cartProvider.cartTotal}',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivary Fee', style: TextStyle(fontSize: 16)),
                      Text('Rs. ${cartProvider.deliveryCharge}',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),

                  Divider(height: 30, thickness: 1, color: Colors.grey[300]),

                  // Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rs. ${cartProvider.grandTotal}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Order Confirmed!'),
                content: Text('Your order has been placed successfully.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.read<CartProvider>().clearCart();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: Text(
            'Pay Now',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
