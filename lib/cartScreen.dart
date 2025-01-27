import 'package:flutter/material.dart';
import 'package:locat_databse_practice/db/db_helper.dart';

class CartScreen extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.getCartItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
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
              return ListTile(
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
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
