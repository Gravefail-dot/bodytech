import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

// 1. IMPORTANTE: Debes tener este archivo generado por 'flutterfire configure'
import 'firebase_options.dart';

import 'data/models/pokemon_model.dart';
import 'routes.dart';
import 'ui/bindings/main_binding.dart';

void main() async {
  // 1. Garantizar que Flutter esté listo antes de cualquier plugin
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inicializar Firebase con opciones (Crucial para Web)
  // Esto soluciona el error "FirebaseOptions cannot be null"
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 3. Inicializar Hive
  await Hive.initFlutter();

  // Seguridad: Registrar el adaptador solo si no existe
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(PokemonModelAdapter());
  }

  // 4. Abrir la caja de datos para la Pokedex
  await Hive.openBox<PokemonModel>('pokemonBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Verificamos el estado de autenticación actual
    final User? user = FirebaseAuth.instance.currentUser;

    return GetMaterialApp(
      title: 'Bodytech Challenge',
      debugShowCheckedModeBanner: false,

      // Inyección global de dependencias
      initialBinding: MainBinding(),

      // Lógica de sesión: si hay usuario va a Home, sino a Login
      initialRoute: user == null ? '/login' : '/home',

      getPages: AppRoutes.routes,

      theme: ThemeData(
        useMaterial3: true,
        // Colores corporativos Bodytech
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          primary: Colors.orange,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
    );
  }
}