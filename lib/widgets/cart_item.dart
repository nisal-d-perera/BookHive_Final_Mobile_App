import 'package:bookhive/models/cart_model.dart';
import 'package:bookhive/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final CartModel cartItem;
  const CartItem({super.key, required this.cartItem});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * 0.30,
            height: size.height * 0.13,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center( 
              child: Image.asset(
                'assets/images/books/${widget.cartItem.book.image}',
                width: 70,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.cartItem.book.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.005),
                Text("Rs. ${widget.cartItem.book.price}",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.030),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<CartProvider>().incrementQty(widget.cartItem.book.name);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Icon(Icons.add, color: Colors.black, size:14),
                        ),
                      ),
                    ),
                    SizedBox(width: 13),
                    Text(widget.cartItem.quantity.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 13),
                    GestureDetector(
                      onTap: () {
                        context.read<CartProvider>().decrementQty(widget.cartItem.book.name);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Icon(Icons.remove, color: Colors.black, size:14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<CartProvider>().removeItem(widget.cartItem.book.name);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Item removed from cart", style: TextStyle(color: Colors.white)),
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.red.withOpacity(0.7),
              radius: 18,
              child: Icon(Icons.delete, color: Colors.white, size: 18),
            )
          ),
        ],
      ),
    );
  }
}