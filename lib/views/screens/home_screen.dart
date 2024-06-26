import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:state/models/product_model.dart';
import 'package:state/viewmodel/product_view_model.dart';
import 'package:state/views/screens/cart_screen.dart';
import 'package:state/views/widgets/product_container.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});

  final productsController = ProductsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          "Category",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const CartScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: productsController.list.length,
        itemBuilder: (ctx, index) {
          final product = productsController.list[index];
          return ChangeNotifierProvider<Product>.value(
            value: product,
            builder: (context, child) {
              return const ProductItem();
            },
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .52,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
      ),
    );
  }
}
