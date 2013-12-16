queries
=======

IQueryable collections for Dart language.

Version 0.0.4

Sample code:

```dart
import 'dart:math';
import 'package:queries/queries.dart';

void main() {
  const int NUMBER_OF_ORDERS = 50;
  const int NUMBER_OF_ORDER_DETAILS = NUMBER_OF_ORDERS * 5;
  const int NUMBER_OF_PRODUCTS = 15;
  var rnd = new Random(0);
  // Generate products
  var products = IQueryable.range(0, NUMBER_OF_PRODUCTS)
      .select(
          (id) => new Product(id, "Product $id", rnd.nextInt(10).toDouble())).toCollection();
  // Generate orders
  var orders = IQueryable.range(0, NUMBER_OF_ORDERS)
      .select(
          (id) => new Order(id, new DateTime(2013, 12, rnd.nextInt(30) + 1)))
      .toCollection();
  // Generate order details
  var orderDetails = IQueryable.range(0, NUMBER_OF_ORDER_DETAILS)
      .select((id) {
          var orderId = rnd.nextInt(NUMBER_OF_ORDERS - 1);
          var orderDetail = new OrderDetail(id, orders.single((Order o) => o.id == orderId));
          var productId = rnd.nextInt(NUMBER_OF_PRODUCTS - 1);
          orderDetail.product = products.single((Product p) => p.id == productId);
          orderDetail.price = orderDetail.product.price;
          orderDetail.quantity = rnd.nextInt(5);
          orderDetail.order.total += orderDetail.quantity * orderDetail.price;
          return orderDetail;
       }).toCollection();
  //
  var sales = orders
      .join(
          orderDetails,
          (Order o) => o,
          (OrderDetail od) => od.order,
          (Order o, OrderDetail od) => {
              "order"       : o,
              "orderDetail" : od})
      .groupBy(
          (row) => row["order"])
      .select((group) => {
          "order" : group.key,
          "sum"   : group.sum((row) => row["orderDetail"].quantity * row["orderDetail"].price),
          "lines" : group.count()})
      .orderBy(
          (row) => row["order"].date);
  //
  printResult("Products", products);
  printResult("Orders", orders);
  printResult("Sales", sales);
}

void printResult(String title, result) {
  print("========================");
  print(title);
  print("------------------------");
  for(var item in result) {
    print(item);
  }
}

class Order {
  int id;
  DateTime date;
  double total = 0.0;

  Order(this.id, this.date);

  operator ==(other) {
    if(identical(this, other)) {
      return true;
    }

    if(other is Order) {
      return id == other.id;
    }

    return false;
  }

  String toString() {
    return "Order #$id ${date} $total";
  }
}

class OrderDetail {
  int id;
  Order order;
  Product product;
  double price = 0.0;
  int quantity = 0;
  double total = 0.0;

  OrderDetail(this.id, this.order);

  String toString() {
    return "$product $quantity $price";
  }
}

class Product {
  int id;
  String name;
  double price;

  Product(this.id, this.name, this.price);

  String toString() {
    return name;
  }
}
```
