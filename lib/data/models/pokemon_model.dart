import 'package:hive/hive.dart';
import '../../domain/entities/pokemon_entity.dart'; // Verifica que esta ruta exista

// Esta línea debe ser la primera después de los imports
part 'pokemon_model.g.dart';

@HiveType(typeId: 0)
class PokemonModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String url;

  PokemonModel({required this.name, required this.url});

  // Métodos para la Pokedex Premium
  String get imageUrl {
    final id = url.split('/')[url.split('/').length - 2];
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  }

  String get formattedId {
    final id = url.split('/')[url.split('/').length - 2];
    return id.padLeft(3, '0');
  }

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }

  // Corregido: Ahora reconoce PokemonEntity
  PokemonEntity toEntity() => PokemonEntity(name: name, url: url);
}