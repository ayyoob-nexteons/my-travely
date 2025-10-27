import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class NavigationUtils {
  static void goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  static void goToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  static void goToSignup(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.signup,
    );
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  static void goToSearchResults(BuildContext context, String searchQuery) {
    Navigator.pushNamed(
      context,
      AppRoutes.searchResults,
      arguments: searchQuery,
    );
  }
}
