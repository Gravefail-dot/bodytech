import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class ApiProvider {
  // Cambiamos el limit de 20 a 151 (o el número que prefieras)
  final String _baseUrl = 'https://pokeapi.co/api/v2/pokemon?limit=151';

  Future<List<PokemonModel>> fetchPokemons() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['results'];
        return data.map((json) => PokemonModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al conectar con el servidor');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}