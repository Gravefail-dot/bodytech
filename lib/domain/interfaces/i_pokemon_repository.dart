import '../entities/pokemon_entity.dart';

abstract class IPokemonRepository {
  // Cambiamos PokemonModel por PokemonEntity para que el contrato sea correcto
  Future<List<PokemonEntity>> getPokemons();
}