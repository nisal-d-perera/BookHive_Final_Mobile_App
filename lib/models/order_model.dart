class Order {
  final int userId;
  final String status;
  final String date;
  final String bookName;
  final int quntity;
  final String orderNumber;
  final String shippingdate;
  final String extpectedDelivery;
  final String trackingNumber;

  Order({
    required this.userId,
    required this.status,
    required this.date,
    required this.bookName,
    required this.quntity,
    required this.orderNumber,
    required this.shippingdate,
    required this.extpectedDelivery,
    required this.trackingNumber,
  });
}
