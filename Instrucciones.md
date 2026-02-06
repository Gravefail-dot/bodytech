# Bodytech Challenge - Pokédex Pro 🚀

Este proyecto es una solución técnica robusta para el reto de desarrollo Flutter de **Bodytech**. Se ha construido una aplicación escalable que gestiona autenticación, consumo de APIs y persistencia local bajo estándares de arquitectura limpia.

## 🛠️ Stack Tecnológico
* [cite_start]**Framework**: Flutter 3.x[cite: 32].
* [cite_start]**Gestión de Estado**: GetX (Controladores reactivos y Bindings)[cite: 7, 34].
* [cite_start]**Autenticación**: Firebase Authentication[cite: 4, 36].
* [cite_start]**Base de Datos Local**: Hive (Persistencia de sesión y datos de API)[cite: 6, 35].
* [cite_start]**Networking**: HTTP para consumo de PokeAPI[cite: 5, 37].



## ✨ Funcionalidades Destacadas
* [cite_start]**Autenticación Completa**: Registro y Login con validaciones estrictas de formularios (Email, longitud de contraseña > 6)[cite: 10, 11, 13].
* [cite_start]**Sincronización Inteligente**: Los datos se consultan de la API y se guardan en Hive solo en el primer fetch para evitar duplicados[cite: 18, 30].
* [cite_start]**Modo Offline Resiliente**: Si no hay conexión, la app detecta el estado y carga automáticamente los datos desde la persistencia local[cite: 19, 30].
* **UI de Alto Nivel**: Implementación de **Shimmer Effect** para cargas, animaciones de héroe (`Hero`) y diseño responsivo en grilla.

## 🔐 Credenciales de Acceso
Para facilitar la revisión, puede utilizar la siguiente cuenta de prueba o registrar una nueva:
* **Usuario**: `prueba_body@prueba.com`
* **Contraseña**: `12345678`

## 🚀 Instalación
1. Clonar el repositorio.
2. Ejecutar `flutter pub get`.
3. Asegurarse de tener configurado el archivo `google-services.json` (Android) o `GoogleService-Info.plist` (iOS) en las carpetas correspondientes.
4. Ejecutar `flutter run`.

---
**Desarrollado por el Ing. Luis Colmenares** *Colaborador de la humanidad y proyectista de alto rango.*