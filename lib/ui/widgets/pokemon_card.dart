import 'package:flutter/material.dart';
import '../../data/models/pokemon_model.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel pokemon;
  final VoidCallback onTap;

  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // 1. Contenedor de la Imagen con Gradiente y Carga Suave
            Expanded(
              flex: 7,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.orange.shade100, Colors.orange.shade200],
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                padding: const EdgeInsets.all(12),
                child: Hero(
                  tag: pokemon.name,
                  child: Image.network(
                    pokemon.imageUrl,
                    fit: BoxFit.contain,
                    // Mientras carga la imagen real
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                          color: Colors.orange,
                          strokeWidth: 2,
                        ),
                      );
                    },
                    // Si falla la carga (ej. sin internet y no cacheado)
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.catching_pokemon,
                        size: 50,
                        color: Colors.orange,
                      );
                    },
                  ),
                ),
              ),
            ),

            // 2. Panel de Información Inferior
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    // Círculo con el ID (Estilo Badge)
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        pokemon.formattedId,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Nombre del Pokémon
                    Expanded(
                      child: Text(
                        pokemon.name.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 0.5,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.black26),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}