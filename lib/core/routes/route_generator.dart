import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/splash/view/splash_screen.dart';
import '../../features/login/view/login_screen.dart';
import '../../features/signup/view/signup_screen.dart';
import '../../features/login/view_model/login_view_model.dart';
import '../../features/signup/view_model/signup_view_model.dart';
import '../../features/hotel_list/view/hotel_list_screen.dart';
import '../../features/hotel_list/view_model/hotel_list_view_model.dart';
import '../../features/search_results/view/search_results_screen.dart';
import '../../features/search_results/view_model/search_results_view_model.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => LoginViewModel(),
            child: const LoginScreen(),
          ),
        );
      
      case AppRoutes.signup:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SignupViewModel(),
            child: const SignupScreen(),
          ),
        );
      
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => HotelListViewModel(),
            child: const HotelListScreen(),
          ),
        );
      
      case AppRoutes.searchResults:
        final searchQuery = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SearchResultsViewModel(),
            child: SearchResultsScreen(searchQuery: searchQuery),
          ),
        );
      
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}
