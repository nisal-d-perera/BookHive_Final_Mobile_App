import 'package:bookhive/helper/appcolors.dart';
import 'package:bookhive/models/book_model.dart';
import 'package:bookhive/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleItemScreen extends StatefulWidget {
  final String image;
  final String name;
  final String author;
  final String description;
  final String category;
  final double price;

  const SingleItemScreen({
    super.key,
    required this.image,
    required this.name,
    required this.author,
    required this.description,
    required this.category,
    required this.price,
  });

  @override
  State<SingleItemScreen> createState() => _SingleItemScreenState();
}

class _SingleItemScreenState extends State<SingleItemScreen> {
  bool isFavorite = false;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 30,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/images/books/${widget.image}',
                    width: 300,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Author: ${widget.author}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Category: ${widget.category}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            width: 160,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (quantity > 1) {
                                        quantity--;
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  "$quantity",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Rs. ${widget.price}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Book Overview",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              context
                                  .read<CartProvider>()
                                  .addTocart(Book(
                                    image: widget.image,
                                    name: widget.name,
                                    author: widget.author,
                                    description: widget.description,
                                    category: widget.category,
                                    price: widget.price,
                                  ));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Added to Cart", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  )),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Row(
                                children: [
                                  Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: isFavorite
                                    ? Colors.grey.withOpacity(0.2)
                                    : AppColors.mainColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: isFavorite ? Colors.red : Colors.white,
                                size: 30,
                              ),
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
        ),
      ),
    );
  }
}
