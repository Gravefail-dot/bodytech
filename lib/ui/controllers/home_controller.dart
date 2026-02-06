import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/pokemon_model.dart';
import '../../domain/interfaces/i_pokemon_repository.dart';

class HomeController extends GetxController {
  final IPokemonRepository repository;

  // Inyectamos el repositorio por constructor
  HomeController({required this.repository});

  // Estado reactivo para la carga
  var isLoading = true.obs;

  // Lista maestra (Fuente de verdad)
  final pokemonList = <PokemonModel>[].obs;

  // Lista filtrada (La que se dibuja en la UI)
  final filteredList = <PokemonModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPokemons();
  }

  /// Método principal para obtener y sincronizar los Pokémon
  Future<void> fetchPokemons() async {
    try {
      isLoading(true);

      // Llamada al repositorio (Capa de Dominio)
      final result = await repository.getPokemons();

      // Mapeamos las entidades que vienen del Repo a Modelos con capacidades de UI
      final List<PokemonModel> models = result.map((e) =>
          PokemonModel(name: e.name, url: e.url)
      ).toList();

      // Sincronizamos las listas reactivas
      pokemonList.assignAll(models);
      filteredList.assignAll(models);

      // UX: Feedback visual inteligente para modo Offline
      // Verificamos si hay datos y si no hay un snackbar ya abierto para no saturar
      if (Get.isSnackbarOpen == false && models.isNotEmpty) {
        // Podrías añadir una lógica aquí con 'connectivity_plus' para ser más exacto,
        // pero avisar preventivamente ayuda a la transparencia del sistema.
        Get.snackbar(
          "Estado de Sincronización",
          "Datos cargados correctamente. Desliza hacia abajo para actualizar.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          icon: const Icon(Icons.sync, color: Colors.orange),
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(15),
          snackStyle: SnackStyle.FLOATING,
        );
      }
    } catch (e) {
      Get.snackbar(
          "Error de Carga",
          "No se pudo sincronizar la Pokédex. Revisa tu red.",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM
      );
    } finally {
      isLoading(false);
    }
  }

  /// Filtra la lista en tiempo real según el query del usuario
  void filterPokemons(String query) {
    if (query.isEmpty) {
      // Si el buscador está vacío, restauramos todos los 151
      filteredList.assignAll(pokemonList);
    } else {
      // Filtramos sobre la lista maestra para no perder datos
      filteredList.assignAll(
        pokemonList.where((p) =>
            p.name.toLowerCase().contains(query.toLowerCase())
        ).toList(),
      );
    }
  }
}