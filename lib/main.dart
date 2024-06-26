import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:state/viewmodel/cart_view_model.dart';
import 'package:state/views/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) {
          return CartController();
        }),
      ],
      builder: (context, child) {
        return MaterialApp(
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: ProductsScreen(),
        );
      },
    );
  }
}
