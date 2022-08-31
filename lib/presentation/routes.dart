import 'package:flutter/material.dart';
import 'package:tameer/data/models/product.dart';
import 'package:tameer/presentation/screens/screens.dart';

class ProductDetailArguments {
  final Product product;
  final String categoryId;

  ProductDetailArguments({required this.product, required this.categoryId});
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/gettingStarted':
        return MaterialPageRoute(builder: (context) => const GettingStartedScreen());
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case '/profile':
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case '/productsList':
        return MaterialPageRoute(builder: (context) => const ProductsListScreen());
      case '/productDetail':
        final args = settings.arguments as ProductDetailArguments;
        return MaterialPageRoute(builder: (context) => ProductDetailScreen(product: args.product, categoryId: args.categoryId));
      case '/cart':
        return MaterialPageRoute(builder: (context) => const CartScreen(), settings: const RouteSettings(name: '/cart'));
      case '/location':
        return MaterialPageRoute(builder: (context) => LocationScreen(), settings: const RouteSettings(name: '/location'));
      case '/checkout':
        return MaterialPageRoute(builder: (context) => const CheckoutScreen(), settings: const RouteSettings(name: '/checkout'));
      default:
        return MaterialPageRoute(builder: (context) => const GettingStartedScreen());
    }
  }
}
