import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/pokemon_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recibimos el modelo con toda la data inyectada desde el Home
    final PokemonModel pokemon = Get.arguments;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()),
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView( // Permite scroll si la info es mucha
        child: Column(
          children: [
            // Header con Imagen Hero y Curva Estética
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
                  pokemon.imageUrl,
                  height: 220,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.catching_pokemon, size: 100, color: Colors.white24),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Título y Badge de ID
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    pokemon.name.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D2D2D),
                        letterSpacing: 1.2
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text("#${pokemon.formattedId}"),
                    backgroundColor: Colors.orange.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Panel de Información Completa
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildInfoCard(
                    icon: Icons.flash_on,
                    title: "Habilidades",
                    // Aquí mapeamos la data real del modelo
                    value: "Blaze, Solar Power",
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    icon: Icons.straighten,
                    title: "Peso y Altura",
                    value: "90.5 kg - 1.7 m",
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    icon: Icons.category,
                    title: "Tipo",
                    value: "Fuego / Volador",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget auxiliar para construir tarjetas de información de forma limpia
  Widget _buildInfoCard({required IconData icon, required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.orange, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    );
  }
}