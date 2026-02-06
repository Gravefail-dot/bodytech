import 'package:hive_flutter/hive_flutter.dart';
import '../models/pokemon_model.dart';

class LocalProvider {
  static const String _boxName = 'pokemonBox';

  Future<void> savePokemons(List<PokemonModel> pokemons) async {
    final box = await Hive.openBox<PokemonModel>(_boxName);

    // Requisito: Solo guardar al primer fetch o evitar duplicados
    if (box.isEmpty) {
      final Map<int, PokemonModel> pokemonMap = {
        for (var i = 0; i < pokemons.length; i++) i: pokemons[i]
      };
      await box.putAll(pokemonMap);
    }
  }

  Future<List<PokemonModel>> getCachedPokemons() async {
    final box = await Hive.openBox<PokemonModel>(_boxName);
    return box.values.toList();
  }
}