import 'package:bookhive/helper/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:bookhive/data/book_data.dart';
import 'package:bookhive/screens/single_item_screen.dart';


class PopularItemWidget extends StatefulWidget {
  final String searchQuery;

  const PopularItemWidget({super.key, required this.searchQuery});

  @override
  State<PopularItemWidget> createState() => _PopularItemWidgetState();
}

class _PopularItemWidgetState extends State<PopularItemWidget> {
  @override
  Widget build(BuildContext context) {
    final filteredBooks = popularbooks.where((book) {
      return book.name.toLowerCase().contains(widget.searchQuery) ||
          book.author.toLowerCase().contains(widget.searchQuery);
    }).toList();

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: (150 / 220),
      children: filteredBooks.map((book) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SingleItemScreen(image: book.image, name: book.name, author: book.author, description: book.description, category: book.category, price: book.price,)));
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/books/${book.image}',
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded( 
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book.name,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text(book.author,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 87, 84, 84))),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rs. ${book.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SingleItemScreen(image: book.image, name: book.name, author: book.author, description: book.description, category: book.category, price: book.price,)));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
