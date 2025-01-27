import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:locat_databse_practice/db/db_helper.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  late Future<List<Map<String, dynamic>>> _cartItemsFuture;

  @override
  void initState() {
    super.initState();
    _refreshCart();
  }
void _refreshCart() {
  setState(() {
    _cartItemsFuture = dbHelper.getCartItems();
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Your Cart',style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.getCartItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CupertinoActivityIndicator(radius: 50, color: Colors.blue));
          }
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final cartItems = snapshot.data!;

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.greenAccent,
                  child: ListTile(
                    title: Text(item['name']),
                    subtitle: Text(
                      'Price: ${item['price']} | Quantity: ${item['quantity']}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await dbHelper.delete(item['id']);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${item['name']} removed from cart!')),
                        );
                        (context as Element).reassemble();
                        _refreshCart();
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
