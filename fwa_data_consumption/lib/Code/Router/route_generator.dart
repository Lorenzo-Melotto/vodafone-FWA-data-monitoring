import 'package:flutter/material.dart';
import 'package:fwa_data_consumption/Pages/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Home());
      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String? nomePagina) {
    String nomePaginaStrip = nomePagina!.replaceAll('/', '');
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Pagina non trovata"),
            centerTitle: true,
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.warning,
                  size: 30.0,
                  color: Colors.amber,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                  "Pagina \"$nomePaginaStrip\" non esistente",
                  style: const TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
