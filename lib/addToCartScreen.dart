import 'package:flutter/material.dart';
import 'package:locat_databse_practice/CartScreen.dart';
import 'package:locat_databse_practice/base/app_colors.dart';
import 'package:locat_databse_practice/base/custom_button.dart';
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
  double price = 0.0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.blueAccent,
      title: Text('Add to Cart',style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${widget.product.name}', style: TextStyle(fontSize: 18)),
            Text('Price: ${widget.product.price * quantity}', style: TextStyle(fontSize: 18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quantity:', style: TextStyle(fontSize: 18)),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline_outlined),
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
                      icon: Icon(Icons.add_circle_outline_rounded),
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
                child: Text('Add to Cart',style: TextStyle(color: Colors.white)),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.primaryColor)),
              ),
            ),

          ],
        ),
      ),
    );
  }
  void _addToCart() async {
    final dbHelper = DatabaseHelper.instance;

    Map<String, dynamic> cartItem = {
      'name': widget.product.name,
      'price': widget.product.price * quantity,
      'quantity': quantity,
    };

    await dbHelper.insert(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${widget.product.name} added to Cart!'),
    ));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(),
      ),
    );
  }
}
