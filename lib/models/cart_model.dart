import 'package:bookhive/models/book_model.dart';
import 'package:uuid/uuid.dart';

class CartModel{
  final String id;
  final Book book;
  int quantity;

  CartModel({
    required this.book,
    required this.quantity,
  }) : id = Uuid().v4();
}