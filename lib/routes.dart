import 'package:get/get.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/details_screen.dart';
import 'ui/bindings/main_binding.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => HomeScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: '/details',
      page: () => const DetailsScreen(),
      // No necesita binding propio porque usa los datos pasados por argumentos
    ),
  ];
}