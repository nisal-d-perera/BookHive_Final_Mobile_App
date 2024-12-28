import 'package:bookhive/helper/appcolors.dart';
import 'package:bookhive/screens/notification_page.dart';
import 'package:bookhive/widgets/favitems_widget.dart';
import 'package:bookhive/widgets/newitems_widget.dart';
import 'package:bookhive/widgets/popitems_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        },
                        child: const Text(
                          'BookHive',
                          style: TextStyle(
                              fontSize: 30,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        )),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotificationPage()),
                        );
                      },
                      icon: const Icon(Icons.notifications),
                      color: AppColors.mainColor,
                      iconSize: 35,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "Discover the best books!",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 20.0),
                width: MediaQuery.of(context).size.width,
                height: 60.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
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
              TabBar(
                  controller: _tabController,
                  labelColor: AppColors.mainColor,
                  unselectedLabelColor: Colors.black.withOpacity(0.5),
                  isScrollable: false,
                  indicator: const UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 3.0, color: AppColors.mainColor),
                    insets: EdgeInsets.symmetric(horizontal: 1.0),
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  tabs: const [
                    Tab(text: "Popular"),
                    Tab(text: "Favourites"),
                    Tab(text: "New"),
                  ]),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: [
                  PopularItemWidget(searchQuery: searchQuery,),
                  FavouriteItemWidget(searchQuery: searchQuery),
                  NewitemsWidget(searchQuery: searchQuery),
                ][_tabController.index],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
