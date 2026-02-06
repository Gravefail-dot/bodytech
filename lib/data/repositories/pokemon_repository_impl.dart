import 'package:connectivity_plus/connectivity_plus.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/interfaces/i_pokemon_repository.dart';
import '../models/pokemon_model.dart';
import '../providers/api_provider.dart';
import '../providers/local_provider.dart';

class PokemonRepositoryImpl implements IPokemonRepository {
  final apiProvider = ApiProvider();
  final localProvider = LocalProvider();

  @override
  Future<List<PokemonEntity>> getPokemons() async {
    // Verificamos el estado de la conexión
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

    // Si tenemos conexión (móvil, wifi o ethernet)
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {
      try {
        // 1. Obtenemos los 151 Pokémon desde la API
        final List<PokemonModel> remoteModels = await apiProvider.fetchPokemons();

        // 2. Persistencia: Guardamos en Hive para el uso Offline
        await localProvider.savePokemons(remoteModels);

        // 3. Mapeamos a Entidades para cumplir con el contrato de Dominio
        return remoteModels.map((m) => m.toEntity()).toList();
      } catch (e) {
        // En caso de error en la API (ej. servidor caído), intentamos carga local
        return _fetchLocal();
      }
    } else {
      // Sin conexión: vamos directo a la base de datos local
      return _fetchLocal();
    }
  }

  /// Método privado para centralizar la recuperación de datos locales
  Future<List<PokemonEntity>> _fetchLocal() async {
    try {
      final List<PokemonModel> localModels = await localProvider.getCachedPokemons();
      return localModels.map((m) => m.toEntity()).toList();
    } catch (e) {
      // Si falla hasta la carga local, devolvemos una lista vacía para no romper la UI
      return [];
    }
  }
}