import 'package:bookhive/data/order_data.dart';
import 'package:bookhive/helper/appcolors.dart';
import 'package:bookhive/models/order_model.dart';
import 'package:bookhive/screens/order_tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int? userId;
  List<Order> userOrders = [];

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
      userOrders = orders.where((orders) => orders.userId == userId).toList();

      // Sorting orders from newest to oldest based on the 'date' field
      userOrders.sort((a, b) {
        DateTime dateA = DateTime.parse(a.date);  // Parse the date string to DateTime
        DateTime dateB = DateTime.parse(b.date);
        return dateB.compareTo(dateA); // Sort in descending order
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, 
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'My Orders',  
          style: TextStyle(
            color: Colors.white, 
            fontSize: 25, 
            fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white), 
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: ListView.builder(
        itemCount: userOrders.length,
        itemBuilder: (context, index) {
          final orders = userOrders[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Color(0xFF1F1F1F),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orders.status,
                      style: TextStyle(
                        color: orders.status == 'Delivered'
                            ? Colors.green
                            : Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          orders.date,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderTrackingPage(
                                  orderNumber: orders.orderNumber, 
                                ),
                              ),
                            );
                          },
                          child: Icon(Icons.chevron_right, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.location_pin, color: Colors.grey, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Order ID: ${orders.orderNumber}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Shipping Date: ${orders.shippingdate}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
