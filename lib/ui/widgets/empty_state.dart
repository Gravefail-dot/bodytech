import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final VoidCallback? onRetry; // Agregamos la capacidad de reintentar

  const EmptyState({
    super.key,
    required this.title,
    this.message = "Intenta buscar con otro nombre o revisa tu conexión.",
    this.icon = Icons.search_off,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView( // Evita errores de overflow en pantallas pequeñas
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono con diseño neumórfico sutil
            Icon(
                icon,
                size: 100,
                color: Colors.orange.withOpacity(0.3)
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D)
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  height: 1.4 // Mejora la legibilidad
              ),
            ),

            // Si pasamos un método onRetry, mostramos el botón
            if (onRetry != null) ...[
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text("REINTENTAR"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}