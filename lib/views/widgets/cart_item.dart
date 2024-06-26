import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:state/models/product_model.dart';
import 'package:state/viewmodel/cart_view_model.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required product, required int quantity});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return Card(
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/phone.png",
              width: 80,
              height: 80,
              fit: BoxFit.fill,
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    product.description,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black.withOpacity(.6),
                      fontSize: 13,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$${product.price}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 42, 243, 49),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(35),
                Consumer<CartController>(
                  builder: (context, cart, child) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            final snackBar = SnackBar(
                              duration: const Duration(seconds: 1),
                              backgroundColor: Colors.grey[700],
                              content: Text(
                                '${product.title} removed from cart',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              action: SnackBarAction(
                                backgroundColor: Colors.grey,
                                label: 'Undo',
                                onPressed: () {
                                  cart.addToCart(product);
                                },
                              ),
                            );
                            cart.getProductAmount(product.id) == 1
                                ? ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar)
                                : null;
                            cart.removeFromCart(product.id);
                          },
                          child: const Icon(
                            Icons.remove_circle,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            cart.getProductAmount(product.id).toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cart.addToCart(product);
                          },
                          child: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
