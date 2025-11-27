import 'package:go_router/go_router.dart';
import 'package:antoine_online_app/src/presentation/app_shell.dart';
import 'package:antoine_online_app/src/presentation/screens/auth/login_screen.dart';
import 'package:antoine_online_app/src/presentation/screens/catalog/category_list_screen.dart';
import 'package:antoine_online_app/src/presentation/screens/cart/cart_screen.dart';
import 'package:antoine_online_app/src/presentation/screens/account/account_screen.dart';
import 'package:antoine_online_app/src/presentation/screens/checkout/checkout_screen.dart';
import 'package:antoine_online_app/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:antoine_online_app/features/store_locator/presentation/pages/store_locator_page.dart';
import 'package:antoine_online_app/src/presentation/screens/orders/order_history_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const CategoryListScreen(),
        ),
        GoRoute(
          path: '/wishlist',
          builder: (context, state) => const WishlistPage(),
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const CartScreen(),
        ),
        GoRoute(
          path: '/store-locator',
          builder: (context, state) => const StoreLocatorPage(),
        ),
        GoRoute(
          path: '/account',
          builder: (context, state) => const AccountScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrderHistoryScreen(),
    ),
  ],
);
