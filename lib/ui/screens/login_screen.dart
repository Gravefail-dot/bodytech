import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.fitness_center, size: 80, color: Colors.orange),
              const SizedBox(height: 20),
              const Text("Bodytech Challenge", textAlign: TextAlign.center, 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                validator: (value) => GetUtils.isEmail(value!) ? null : "Email no válido",
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña', border: OutlineInputBorder()),
                validator: (value) => value!.length >= 6 ? null : "Mínimo 6 caracteres",
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(vertical: 16)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authController.login(emailController.text, passwordController.text);
                  }
                },
                child: const Text("Iniciar Sesión", style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () => _showRegisterDialog(context),
                child: const Text("¿No tienes cuenta? Regístrate aquí"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showRegisterDialog(BuildContext context) {
    // Aquí puedes navegar a una pantalla de registro o usar un Dialog rápido
    Get.defaultDialog(
      title: "Registro",
      content: const Text("Usa el mismo formulario para registrarte en Firebase."),
      onConfirm: () => authController.register(emailController.text, passwordController.text),
    );
  }
}