import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/auth_controller.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/pokemon_shimmer.dart'; // Importamos el nuevo widget estético

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
            "Pokédex Bodytech",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => authController.logout(),
            tooltip: "Cerrar Sesión",
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Barra de Búsqueda con diseño premium
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) => controller.filterPokemons(value),
                decoration: InputDecoration(
                  hintText: "Buscar Pokémon...",
                  prefixIcon: const Icon(Icons.search, color: Colors.orange),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),

          // 2. Sección principal con gestión de estados mediante Obx
          Expanded(
            child: Obx(() {
              // ESTADO: CARGANDO (Toque estético final con Shimmer)
              if (controller.isLoading.value && controller.pokemonList.isEmpty) {
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.82,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: 8, // Mostramos 8 esqueletos mientras carga
                  itemBuilder: (context, index) => const PokemonShimmer(),
                );
              }

              // ESTADO: VACÍO O SIN RESULTADOS
              if (controller.filteredList.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () => controller.fetchPokemons(),
                  color: Colors.orange,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                      EmptyState(
                        title: "No encontramos nada",
                        message: "Intenta con otro nombre o pulsa el botón para sincronizar.",
                        onRetry: () => controller.fetchPokemons(),
                      ),
                    ],
                  ),
                );
              }

              // ESTADO: DATOS LISTOS (GRILLA REAL)
              return RefreshIndicator(
                onRefresh: () => controller.fetchPokemons(),
                color: Colors.orange,
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.82,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: controller.filteredList.length,
                  itemBuilder: (context, index) {
                    final pokemon = controller.filteredList[index];
                    return PokemonCard(
                      pokemon: pokemon,
                      onTap: () => Get.toNamed('/details', arguments: pokemon),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}