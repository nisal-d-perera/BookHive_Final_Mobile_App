import 'package:bookhive/models/order_model.dart';

final List<Order> orders = [
  Order(
    userId: 1,
    status: "Shipped",
    date: "2024-12-01",
    bookName: "Happy Place",
    quntity: 2,
    orderNumber: "ORD001",
    shippingdate: "2024-12-02",
    extpectedDelivery: "2024-12-05",
    trackingNumber: "TRK001",
  ),
  Order(
    userId: 2,
    status: "In Progress",
    date: "2024-12-03",
    bookName: "The Fault in Our Stars",
    quntity: 1,
    orderNumber: "ORD002",
    shippingdate: "2024-12-04",
    extpectedDelivery: "2024-12-07",
    trackingNumber: "TRK002",
  ),
  Order(
    userId: 1,
    status: "Delivered",
    date: "2024-11-29",
    bookName: "Harry Potter and Sorcerers Stone",
    quntity: 3,
    orderNumber: "ORD003",
    shippingdate: "2024-11-30",
    extpectedDelivery: "2024-12-02",
    trackingNumber: "TRK003",
  ),
  Order(
    userId: 3,
    status: "To Receive",
    date: "2024-12-05",
    bookName: "The 5th Victim",
    quntity: 1,
    orderNumber: "ORD004",
    shippingdate: "2024-12-06",
    extpectedDelivery: "2024-12-10",
    trackingNumber: "TRK004",
  ),
  Order(
    userId: 1,
    status: "In Progress",
    date: "2024-12-06",
    bookName: "The Lord of the Rings",
    quntity: 1,
    orderNumber: "ORD005",
    shippingdate: "2024-12-07",
    extpectedDelivery: "2024-12-12",
    trackingNumber: "TRK005",
  ),
];

