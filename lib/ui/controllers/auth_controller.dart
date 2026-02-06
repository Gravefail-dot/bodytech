import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  // Registro con validación robusta
  Future<void> register(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Todos los campos son obligatorios");
      return;
    }
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      String message = "Error al registrarse";
      if (e.code == 'email-already-in-use') message = "El correo ya está registrado";
      if (e.code == 'weak-password') message = "La contraseña es muy débil";

      Get.snackbar("Registro", message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Login
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", "Credenciales incorrectas o usuario no encontrado",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }
}