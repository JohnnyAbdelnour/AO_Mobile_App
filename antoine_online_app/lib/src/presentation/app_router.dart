import 'package:go_router/go_router.dart';
import 'package:antoine_online_app/src/presentation/screens/auth/login_screen.dart';
import 'package:antoine_online_app/src/presentation/screens/catalog/category_list_screen.dart';
import 'package:antoine_online_app/src/presentation/screens/cart/cart_screen.dart';
import 'package:antoine_online_app/src/presentation/screens/account/account_screen.dart';
import 'package:antoine_online_app/src/presentation/screens/checkout/checkout_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CategoryListScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/account',
      builder: (context, state) => const AccountScreen(),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
  ],
);
