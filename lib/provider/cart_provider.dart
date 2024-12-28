import 'package:flutter/material.dart';
import 'package:bookhive/models/cart_model.dart';
import 'package:bookhive/models/book_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> _shoppingCart = [];

  void addTocart(Book book) {
    var isExist =
        _shoppingCart.where((element) => element.book.name == book.name);
    if (isExist.isEmpty) {
      _shoppingCart.add(CartModel(book: book, quantity: 1));
    } else {
      isExist.first.quantity += 1;
    }
    notifyListeners();
  }

  void removeItem(String bookName) {
    _shoppingCart.removeWhere((element) => element.book.name == bookName);
    notifyListeners();
  }

  void incrementQty(String bookName) {
    CartModel item =
        _shoppingCart.where((element) => element.book.name == bookName).first;
    item.quantity++;
    notifyListeners();
  }

  void decrementQty(String bookName) {
    CartModel item =
        _shoppingCart.where((element) => element.book.name == bookName).first;
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _shoppingCart.remove(item);
    }
    notifyListeners();
  }

  double getCartTotal() {
    double total = 0;
    for (var cartItem in _shoppingCart) {
      total += (cartItem.book.price * cartItem.quantity);
    }
    return total;
  }

  void clearCart() {
    shoppingCart.clear();
    notifyListeners();
  }

  List<CartModel> get shoppingCart => _shoppingCart;
  double get cartTotal => getCartTotal();
  double get deliveryCharge => 250;
  double get grandTotal => cartTotal + deliveryCharge;
}
