import 'package:bookhive/data/book_data.dart';
import 'package:bookhive/data/order_data.dart';
import 'package:bookhive/helper/appcolors.dart';
import 'package:flutter/material.dart';

class OrderTrackingPage extends StatelessWidget {
  final String orderNumber;

  const OrderTrackingPage({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    // Find the order from order data using the orderNumber
    final order = orders.firstWhere((order) => order.orderNumber == orderNumber);

    // Find the book from the book data using the bookName
    final book = books.firstWhere((book) => book.name == order.bookName);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, 
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Track Order',  
          style: TextStyle(
            color: Colors.white, 
            fontSize: 20, 
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 225,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/books/${book.image}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Qty: ${order.quntity} pcs',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rs. ${book.price}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            // Order Details
            const Text(
              'Order Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Expected Delivery Date', style: TextStyle(color: Colors.grey, fontSize: 18)),
                Text(order.extpectedDelivery, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tracking ID', style: TextStyle(color: Colors.grey, fontSize: 18)),
                const Text('TRK452126542', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            // Order Status
            const Text(
              'Order Status',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildStatusItem(
                    title: 'Order Placed',
                    subtitle: order.date,
                    isCompleted: true,
                  ),
                  _buildStatusItem(
                    title: 'In Progress',
                    subtitle: order.date,
                    isCompleted: true,
                  ),
                  _buildStatusItem(
                    title: 'Shipped',
                    subtitle: 'Expected ${order.extpectedDelivery}',
                    isCompleted: false,
                  ),
                  _buildStatusItem(
                    title: 'Delivered',
                    subtitle: '',
                    isCompleted: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem({
    required String title,
    required String subtitle,
    required bool isCompleted,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.mainColor : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 12, color: Colors.white),
            ),
            Container(
              height: 40,
              width: 2,
              color: Colors.grey.shade300,
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isCompleted ? Colors.black : Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: isCompleted ? Colors.black : Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        const Icon(Icons.local_shipping, color: AppColors.mainColor),
      ],
    );
  }
}