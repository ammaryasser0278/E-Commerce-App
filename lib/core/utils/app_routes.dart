import 'package:go_router/go_router.dart';
import 'package:supplements_app/features/auth_feature/views/login_view.dart';
import 'package:supplements_app/features/auth_feature/views/register_view.dart';
import 'package:supplements_app/features/home_feature/presentation/views/home_view.dart';
import 'package:supplements_app/features/home_feature/presentation/views/product_details_view.dart';
import 'package:supplements_app/features/home_feature/data/product_model.dart';
import 'package:supplements_app/features/onboarding_feature/presentation/views/onboarding_view.dart';
import 'package:supplements_app/features/splash_feature/presentation/views/splash_view.dart';
import 'package:supplements_app/features/payment_feature/views/payment_view.dart';
import 'package:supplements_app/features/order_feature/views/order_history_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplements_app/features/order_feature/views/cart_view.dart';
import 'package:supplements_app/features/order_feature/logic/cart_cubit.dart';
import 'package:supplements_app/features/seller_dashboard_feature/views/seller_dashboard_view.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashView(
        onFinish: () {
          context.go('/onboarding');
        },
      ),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingView(
        onFinish: () {
          context.go('/login');
        },
      ),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginView()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeView()),
    GoRoute(
      path: '/product-details',
      builder: (context, state) {
        final product = state.extra as Product?;
        return ProductDetailsView(product: product);
      },
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) {
        double totalAmount = 0.0;
        List<Map<String, dynamic>> cartItems = const [];
        final extra = state.extra;
        if (extra is double) {
          totalAmount = extra;
        } else if (extra is Map) {
          final map = extra;
          final t = map['total'];
          totalAmount = t is num ? t.toDouble() : 0.0;
          final items = map['items'];
          if (items is List) {
            cartItems = items.cast<Map<String, dynamic>>();
          }
        }
        return PaymentView(totalAmount: totalAmount, cartItems: cartItems);
      },
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrderHistoryView(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) => CartView(items: cartState.items),
        );
      },
    ),
    GoRoute(
      path: '/seller-dashboard',
      builder: (context, state) => const SellerDashboardView(),
    ),
  ],
);
