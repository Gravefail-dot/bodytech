import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/pokemon_model.dart'; // Cambiamos Entity por Model

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // CORRECCIÓN: Recibimos como PokemonModel para tener acceso a la imagen HD
    final PokemonModel pokemon = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)
              ),
            ),
            child: Hero(
              tag: pokemon.name,
              child: Image.network(
                pokemon.imageUrl, // Ahora sí tenemos acceso a la imagen HD
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            pokemon.name.toUpperCase(),
            style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: const Icon(Icons.info_outline, color: Colors.orange),
                title: const Text("ID del Pokémon"),
                subtitle: Text("#${pokemon.formattedId}"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}