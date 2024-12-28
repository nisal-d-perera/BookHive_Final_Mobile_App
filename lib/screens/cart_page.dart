import 'package:bookhive/provider/cart_provider.dart';
import 'package:bookhive/screens/checkout_page.dart';
import 'package:bookhive/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:bookhive/models/book_model.dart';
import 'package:bookhive/helper/appcolors.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  final List<Book> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Row(
          children: [
            Text(
              "My Cart",
              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 80), // Add bottom padding here
              child: context.watch<CartProvider>().shoppingCart.isNotEmpty
                  ? Consumer<CartProvider>(
                      builder: (context, value, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: value.shoppingCart
                              .map((cartItem) => CartItem(cartItem: cartItem))
                              .toList(),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 160),
                          Icon(Icons.shopping_cart,
                              size: size.width * 0.20, color: Colors.grey),
                          const SizedBox(height: 20),
                          const Text(
                            'Your cart is empty',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          if (context.watch<CartProvider>().shoppingCart.isNotEmpty)
            SafeArea(
              top: false, // Ensure it only affects the bottom of the screen
              child: Container(
                padding: const EdgeInsets.all(15),
                color: Colors.white, // Optional background for distinction
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Information",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20, // Fixed font size for consistency
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sub Total",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Rs. ${context.watch<CartProvider>().cartTotal}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Fee",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Rs. ${context.watch<CartProvider>().deliveryCharge}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "Rs. ${context.watch<CartProvider>().grandTotal}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: size.width,
                      height: size.height * 0.065,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Proceed to Checkout",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
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
}
