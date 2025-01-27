import 'package:flutter/material.dart';
import 'package:locat_databse_practice/db/product.dart';
import 'AddToCartScreen.dart';
import 'CartScreen.dart';


class ProductListScreen extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Cow', price: 20.0),
    Product(name: 'Cat', price: 50.0),
    Product(name: 'Dog', price: 50.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Product Screen',style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart,color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.greenAccent,
              child: ListTile(
                title: Text(product.name),
                subtitle: Text('Price: ${product.price}'),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddToCartScreen(product: product),
                      ),
                    );
                  },
                  child: Text('Add to Cart'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
