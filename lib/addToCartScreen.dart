import 'package:flutter/material.dart';
import 'package:locat_databse_practice/cartScreen.dart';
import 'package:locat_databse_practice/db/db_helper.dart';
import 'package:locat_databse_practice/db/product.dart';

class AddToCartScreen extends StatefulWidget {
  final Product product;

  AddToCartScreen({required this.product});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  int quantity = 1;

  void _addToCart() async {
    final dbHelper = DatabaseHelper.instance;

    Map<String, dynamic> cartItem = {
      'name': widget.product.name,
      'price': widget.product.price,
      'quantity': quantity,
    };

    await dbHelper.insert(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${widget.product.name} added to Cart!'),
    ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add to Cart')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${widget.product.name}', style: TextStyle(fontSize: 18)),
            Text('Price: ${widget.product.price}', style: TextStyle(fontSize: 18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quantity:', style: TextStyle(fontSize: 18)),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                    ),
                    Text('$quantity', style: TextStyle(fontSize: 18)),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _addToCart,
                child: Text('Add to Cart'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
