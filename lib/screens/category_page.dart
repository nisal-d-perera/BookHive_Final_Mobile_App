import 'package:bookhive/helper/appcolors.dart';
import 'package:bookhive/screens/category_item_page.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Row(
          children: [
            Text(
              "Explore",
              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: ListView(
            children: [
              Container(
                margin:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 20.0),
                width: MediaQuery.of(context).size.width,
                height: 60.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                      debugPrint(searchQuery);
                    });
                  },
                  style: TextStyle(color: const Color.fromARGB(255, 87, 84, 84).withOpacity(0.5)),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search for books",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 87, 84, 84).withOpacity(0.5),
                    ),
                    prefixIcon: Icon(Icons.search,
                        color: const Color.fromARGB(255, 87, 84, 84).withOpacity(0.5)),
                  ),
                ),
              ),
              CategoryItemPage(searchQuery: searchQuery),
            ],
          ),
        ),
      ),
    );
  }
}
