import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  final String authToken;
  final String userId;
  Orders(this.authToken,this.userId, this._orders);


  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> removeOrders(String id) async {
    final url = 'https://shop-app-66c2a.firebaseio.com/orders/$id.json?auth=$authToken';
    final existingProductIndex =
    orders.indexWhere((element) => element.id == id);
    var existingProduct = orders[existingProductIndex];
    orders.removeAt(existingProductIndex);
    notifyListeners();
    final responce = await http.delete(url);
    if (responce.statusCode >= 400) {
      orders.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('could not delete product');
    }
    existingProduct = null;
  }

  Future<void> fetchAndSetOrders() async {
    final url = 'https://shop-app-66c2a.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    print(json.decode(response.body));
    final List<OrderItem> loadedOrders = [];
    final extractData = json.decode(response.body) as Map<String, dynamic>;
    if (extractData == null) {
      return;
    }
    extractData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        dateTime: DateTime.parse(orderData['dateTime']),
        products: (orderData['products'] as List<dynamic>)
            .map(
              (items) => CartItem(
                id: items['id'],
                price: items['price'],
                title: items['title'],
                quantity: items['quantity'],
              ),
            )
            .toList(),
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://shop-app-66c2a.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timestamp = DateTime.now();
    final responce = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price
                  })
              .toList()
        }));

    _orders.insert(
      0,
      OrderItem(
        id: json.decode(responce.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
