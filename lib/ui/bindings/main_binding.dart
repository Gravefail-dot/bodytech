import 'package:get/get.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    // 1. Inyectamos el Repositorio (Capa de Datos)
    // Usamos fenix: true para que se mantenga vivo o se recree si es necesario
    Get.lazyPut(() => PokemonRepositoryImpl(), fenix: true);

    // 2. Inyectamos el AuthController (Capa de Presentación - Global)
    // permanent: true porque la sesión debe escucharse en TODA la app
    Get.put(AuthController(), permanent: true);

    // 3. Inyectamos el HomeController (Capa de Presentación)
    // Le pasamos el repositorio que ya inyectamos arriba
    Get.lazyPut(() => HomeController(repository: Get.find<PokemonRepositoryImpl>()), fenix: true);
  }
}